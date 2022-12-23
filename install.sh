url='https://scripts.dutrasystem.net/gltunnelvpn/api/CheckUser'

cd ~

if ! [ -x "$(command -v git)" ]; then
    echo 'Erro: git nao esta instalado.' >&2
    echo 'Instalando Git...'

    sudo apt-get install git -y 1>/dev/null 2>/dev/null

    if ! [ -x "$(command -v git)" ]; then
        echo 'Erro: git nao esta instalado.' >&2
        exit 1
    fi

    echo 'Git instalado com sucesso.'
fi

function install_checkuser() {
    echo 'Instalando CheckUser...'

    git clone $url
    cd CheckUser

    python3 setup.py install

    if ! [ -x "$(command -v checkuser)" ]; then
        echo 'Erro: CheckUser nao esta instalado.' >&2
        exit 1
    fi

    clear
    read -p 'Porta: ' -e -i 5000 port
    checkuser --port $port --start --daemon

    echo 'CheckUser instalado com sucesso.'
    echo 'Execute: checkuser --help'
    echo 'URL: http://'$(curl -s icanhazip.com)':'$port
    read
}

function uninstall_checkuser() {
    echo 'Desinstalando CheckUser...'

    checkuser --stop

    [[ -d CheckUser ]] && rm -rf CheckUser

    [[ -f /usr/bin/checker ]] && {
        service check_user stop
        /usr/bin/checker --uninstall
        rm /usr/bin/checker
    }

    [[ -f /usr/local/bin/checkuser ]] && {
        service check_user stop
        /usr/local/bin/checkuser --remove-service
        rm /usr/local/bin/checkuser
    }
}

function reinstall_checkuser() {
    uninstall_checkuser
    install_checkuser
}

function console_menu() {
    clear
    echo 'CHECKUSER MENU'
    echo '[01] - Instalar CheckUser'
    echo '[02] - Desinstalar CheckUser'
    echo '[03] - Reinstalar CheckUser'
    echo '[00] - Sair'

    read -p 'Escolha uma opção: ' option

    case $option in
    01 | 1)
        install_checkuser
        console_menu
        ;;
    02 | 2)
        uninstall_checkuser
        console_menu
        ;;
    03 | 3)
        reinstall_checkuser
        console_menu
        ;;
    00 | 0)
        echo 'Saindo...'
        exit 0
        ;;
    *)
        echo 'Opção inválida.'
        read -p 'Pressione enter para continuar...'
        console_menu
        ;;
    esac

}

function main() {
    case $1 in
    install)
        install_checkuser
        ;;
    update)
        check_update
        ;;
    uninstall)
        uninstall_checkuser
        ;;
    *)
        echo 'Usage: ./install.sh [install|update|uninstall]'
        exit 1
        ;;
    esac
}

if [[ $# -eq 0 ]]; then
    console_menu
else
    main $1
fi
