install:
	test -h $(HOME)/.screenrc || ln -sf $(PWD)/screenrc $(HOME)/.screenrc
	test -h $(HOME)/.bashrc   || ln -sf $(PWD)/bashrc $(HOME)/.bashrc
	test -h $(HOME)/.gitconfig || ln -sf $(PWD)/gitconfig $(HOME)/.gitconfig
	test -h $(HOME)/.config/awesome || ln -sf $(PWD)/awesome $(HOME)/.config/awesome
	test -h $(HOME)/.toprc || ln -sf $(PWD)/toprc $(HOME)/.toprc
	test -h $(HOME)/.Xdefaults || ln -sf $(PWD)/Xdefaults $(HOME)/.Xdefaults
	test -h $(HOME)/.vim || ln -sf $(PWD)/vim $(HOME)/.vim
	test -h $(HOME)/.vimrc || ln -sf $(PWD)/vim/.vimrc $(HOME)/.vimrc
	test -h $(HOME)/.xinitrc || ln -sf $(PWD)/xinitrc $(HOME)/.xinitrc
	test -h $(HOME)/bin || ln -sf $(PWD)/bin $(HOME)/bin
