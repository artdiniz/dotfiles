extensions="
    artdiniz.quitcontrol-vscode
    artdiniz.strike-vscode
    dbaeumer.vscode-eslint
    editorconfig.editorconfig
    esbenp.prettier-vscode
    visualstudioexptteam.vscodeintellicode
    christian-kohler.npm-intellisense
    tomoki1207.pdf
    mushan.vscode-paste-image
    eamodio.gitlens
"

for extension in $extensions; do
    code --install-extension "$extension"
done

