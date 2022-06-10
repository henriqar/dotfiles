

# Linker commands used
linker = scripts/dotmanager linker --source $(1) --target $(2)
forced_linker = scripts/dotmanager linker --source $(1) --target $(2) -r

# install command used

.PHONY: install_all

# install all dotfiles available
install_all :
	install_tmux \
	install_vim

.PHONY: install_vim
install_vim :
	$(call linker, ${CURDIR}/dotfiles/vim, ${HOME}/.vim)

.PHONY: force_install_vim
force_install_vim :
	$(call forced_linker, ${CURDIR}/dotfiles/vim, ${HOME}/.vim)

.PHONY: install_tmux
install_tmux :
	$(call linker, ${CURDIR}/dotfiles/tmux/.tmux.conf, ${HOME}/.tmux.conf)

.PHONY: force_install_tmux
force_install_tmux :
	$(call forced_linker, ${CURDIR}/dotfiles/tmux/.tmux.conf, ${HOME}/.tmux.conf)

