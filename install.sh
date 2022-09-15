install_zsh() {
	sudo apt install -y zsh
	chsh -s $(which zsh)
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_zsh_config() {
	cp -r zsh/* ~/.oh-my-zsh/custom
	cp ~/.zshrc ~/.zshrc.bak
	cp zsh/.zshrc ~/.zshrc
}

install_exa() {
	sudo apt install exa
}

install_nvim() {
	sudo apt install neovim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_nvim_config() {
	mkdir -p ~/.config/nvim
	cp nvim/* ~/.config/nvim
	nvim +PlugInstall +UpdateRemotePlugins +qall
}

install_pyenv() {
	curl https://pyenv.run | bash
}
