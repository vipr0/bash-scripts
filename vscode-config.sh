archivename=

##### Functions

import_settings()
{
    tar -xf $archivename

    echo
    echo "Importing extensions"
    echo "================================="
    xargs -n1 code --install-extension < ~/vscode-extensions.txt

    echo
    echo "Exporting settings"
    echo "===================================="
    cp ./vscode-settings.json ~/.config/Code/User/settings.json

    echo
    echo "Complete"
}

export_settings()
{
    echo "Exporting extensions"
    echo "===================================="
    code --list-extensions | tee ./vscode-extensions.txt

    echo
    echo "Exporting settings"
    echo "===================================="
    cp ~/.config/Code/User/settings.json ./vscode-settings.json

    echo
    echo "Create archive"
    echo "===================================="
    tar -cf vscode-config.tar vscode-extensions.txt vscode-settings.json
    rm vscode-extensions.txt vscode-settings.json

    echo
    echo "Complete"
}

usage()
{
    echo "Usage: ./vscode-config.sh [options][path]"
    echo "  -i --import <archive>:  Import configuration from .tar file"
    echo "  -e --export:            Export configuration to vscode-config.tar file"
    echo "  -h --help               Print usage."
}


while [ "$1" != "" ]; do
    case $1 in
        -i | --import )         shift
                                archivename=$1
                                import_settings
                                ;;
        -e | --export )         export_settings
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done
