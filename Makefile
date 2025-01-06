SHELL=/bin/bash
BUILD_CONFIG ?= build.yaml
DOCKER_REGISTRY ?= $(shell cat $(BUILD_CONFIG)| yq -r .prefix)
GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)
GIT_TAG ?= $(shell echo $(GIT_BRANCH) | sed -E 's/[/:]/-/g' | sed 's/master/latest/' )
DOCKER_CMD ?= docker
MAINTAINER ?= $(shell cat build.yaml| yq -r '.maintainer')
IMAGES := $(shell cat build.yaml| yq -r '.images|keys[]')

.PHONY: all all-images push summary clean

all: build summary

build:
	$(call stage_status,$@)
	td --config $(BUILD_CONFIG) \
		--build \
		--tag $(GIT_TAG)

$(IMAGES):
	$(call stage_status,$@)
	td --config $(BUILD_CONFIG) \
		--image $@ \
		--build \
		--verbose \
		--tag $(GIT_TAG)

push:
	td --config $(BUILD_CONFIG) \
		--push \
		--tag $(GIT_TAG)

build-and-push:
	$(call stage_status,$@)
	td --config $(BUILD_CONFIG) \
		--build \
		--push \
		--tag $(GIT_TAG)

define stage_status
	@echo
	@echo
	@echo ================================================================================
	@echo Building: $(1)
	@echo ================================================================================
endef

define summary
	@echo
	@echo
	@echo ================================================================================
	@echo Generated images:
	@echo ================================================================================
	@$(DOCKER_CMD) image ls \
		--format "{{.Repository}}:{{.Tag}}\t{{.Size}}" \
		--filter=dangling=false \
		--filter=reference="$(DOCKER_REGISTRY)/*:*" | sort | column -t
endef


clean:
	@$(DOCKER_CMD) image rm -f $(shell $(DOCKER_CMD) image ls --format "{{.Repository}}:{{.Tag}}" --filter=dangling=false --filter=reference="$(DOCKER_REGISTRY)/*:*") 2>/dev/null || true
	@find . -iname '*.Dockerfile' -delete

prune:
	@$(DOCKER_CMD) system prune --all --force --volumes

summary:
	$(call summary)
