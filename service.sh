#!/bin/bash

# Função para construir as imagens
build_images() {
    case $1 in
        dns)
            docker build -t dns_image ./dns
            ;;
        web)
            docker build -t web_image ./web
            ;;
        *)
            echo "Serviço desconhecido: $1. Use 'dns' ou 'web'."
            ;;
    esac
}

# Função para iniciar os containers
start_service() {
    case $1 in
        dns)
            docker run -d -p 53:53/udp --name dns_container dns_image
            ;;
        web)
            docker run -p 80:80 --name web_container web_image
            ;;
        *)
            echo "Serviço desconhecido: $1. Use 'dns' ou 'web'."
            ;;
    esac
}

# Função para parar e remover os containers
stop_service() {
    case $1 in
        dns)
            docker stop dns_container && docker rm dns_container
            ;;
        web)
            docker stop web_container && docker rm web_container
            ;;
        *)
            echo "Serviço desconhecido: $1. Use 'dns' ou 'web'."
            ;;
    esac
}

# Função principal para gerenciar as operações
main() {
    if [[ $# -ne 2 ]]; then
        echo "Uso: $0 <serviço> <ação>"
        echo "Exemplo: $0 dns start"
        exit 1
    fi

    service=$1
    action=$2

    case $action in
        build)
            build_images $service
            ;;
        start)
            build_images $service
            start_service $service
            ;;
        stop)
            stop_service $service
            ;;
        *)
            echo "Ação desconhecida: $action. Use 'build', 'start' ou 'stop'."
            ;;
    esac
}

# Executa a função principal com os argumentos fornecidos
main "$@"
