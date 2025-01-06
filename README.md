# Docker Chiseled Corretto

This project is a Proof of Concept (PoC) to verify the benefits of using "chisel" tools on Ubuntu in comparison to Alpine images.

## Overview

The goal of this project is to compare the performance, size, and security of Docker images built using chisel tools on Ubuntu versus those built using Alpine images. Chisel tools are designed to create minimal, hardened Docker images, and this project aims to evaluate their effectiveness.

## Benefits of Chisel Tools

- **Reduced Image Size**: Chisel tools help in creating smaller Docker images by removing unnecessary components.
- **Improved Security**: By minimizing the attack surface, chisel tools enhance the security of Docker images.
- **Performance**: Evaluate if there are any performance improvements when using chisel tools on Ubuntu.

## Comparison with Alpine

Alpine Linux is known for its small size and security features. This project will compare the following aspects between chiseled Ubuntu images and Alpine images:

- Image size
- Build time
- Runtime performance
- Security vulnerabilities

## Image sizes

|        | Alpine                                                                                                                                     | Ubuntu                                                                                                                                     | Ubuntu (chiseled)                                                                                                                              |
|--------|--------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| base   | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-base/alpine?label=tgagor%2Fcorretto-base%3Aalpine)     | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-base/ubuntu?label=tgagor%2Fcorretto-base%3Aubuntu)     |                                                                                                                                                |
| jdk-11 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jdk/11-alpine?label=tgagor%2Fcorretto-jdk%3A11-alpine) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jdk/11-ubuntu?label=tgagor%2Fcorretto-jdk%3A11-ubuntu) |                                                                                                                                                |
| jdk-17 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jdk/17-alpine?label=tgagor%2Fcorretto-jdk%3A17-alpine) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jdk/17-ubuntu?label=tgagor%2Fcorretto-jdk%3A17-ubuntu) |                                                                                                                                                |
| jdk-21 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jdk/21-alpine?label=tgagor%2Fcorretto-jdk%3A21-alpine) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jdk/21-ubuntu?label=tgagor%2Fcorretto-jdk%3A21-ubuntu) |                                                                                                                                                |
| jre-11 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jre/11-alpine?label=tgagor%2Fcorretto-jre%3A11-alpine) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jre/11-ubuntu?label=tgagor%2Fcorretto-jre%3A11-ubuntu) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jre/chiseled-11?label=tgagor%2Fcorretto-jre%3Achiseled-11) |
| jre-17 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jre/17-alpine?label=tgagor%2Fcorretto-jre%3A17-alpine) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jre/17-ubuntu?label=tgagor%2Fcorretto-jre%3A17-ubuntu) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jre/chiseled-17?label=tgagor%2Fcorretto-jre%3Achiseled-17) |
| jre-21 | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jre/21-alpine?label=tgagor%2Fcorretto-jre%3A21-alpine) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jre/21-ubuntu?label=tgagor%2Fcorretto-jre%3A21-ubuntu) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/tgagor/corretto-jre/chiseled-21?label=tgagor%2Fcorretto-jre%3Achiseled-21) |

## Usage

To build and run the Docker images, follow these steps:

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/docker-chiseled-corretto.git
    cd docker-chiseled-corretto
    ```

2. Install Template Dockerfile tool:
    ```sh
    sudo curl -sLfo /usr/local/bin/td https://github.com/tgagor/template-dockerfiles/releases/latest/download/td-linux-amd64
    sudo chmod +x /usr/local/bin/td
    ```

2. Build the Docker image using chisel tools on Ubuntu:
    ```sh
    make
    ```

## Conclusion

This PoC will help determine if using chisel tools on Ubuntu provides significant benefits over using Alpine images. The results will guide future decisions on the best practices for building minimal, secure, and performant Docker images.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
