
# Linker commands used
linker = scripts/dotmanager linker --source $(1) --target $(2)
forced_linker = scripts/dotmanager linker --source $(1) --target $(2) -r

# get colors if terminal supports it
ifneq (,$(findstring xterm,${TERM}))
	BLACK       := $(shell tput -Txterm setaf 0)
	RED         := $(shell tput -Txterm setaf 1)
	GREEN       := $(shell tput -Txterm setaf 2)
	YELLOW      := $(shell tput -Txterm setaf 3)
	LIGHTPURPLE := $(shell tput -Txterm setaf 4)
	PURPLE      := $(shell tput -Txterm setaf 5)
	BLUE        := $(shell tput -Txterm setaf 6)
	WHITE       := $(shell tput -Txterm setaf 7)
	RESET       := $(shell tput -Txterm sgr0)
else
	BLACK       := ""
	RED         := ""
	GREEN       := ""
	YELLOW      := ""
	LIGHTPURPLE := ""
	PURPLE      := ""
	BLUE        := ""
	WHITE       := ""
	RESET       := ""
endif

# test if colors appear
test_colors: 
	@echo "${BLACK}BLACK${RESET}"
	@echo "${RED}RED${RESET}"
	@echo "${GREEN}GREEN${RESET}"
	@echo "${YELLOW}YELLOW${RESET}"
	@echo "${LIGHTPURPLE}LIGHTPURPLE${RESET}"
	@echo "${PURPLE}PURPLE${RESET}"
	@echo "${BLUE}BLUE${RESET}"
	@echo "${WHITE}WHITE${RESET}"

# install all dotfiles available
.PHONY: install_all
install_all :
	install_tmux \
	install_vim

###########################################
# Setup for VIM
###########################################

.PHONY: install_vim_plug
install_vim_plug :
	@curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@echo "$(GREEN)Installed$(RESET) vim plug"

.PHONY: install_vim_ftplugin
install_vim_ftplugin :
	@mkdir -p ${HOME}/.vim/ftplugin
	$(call linker, ${CURDIR}/dotfiles/vim/ftplugin/python.vim, ${HOME}/.vim/ftplugin/python.vim)
	$(call linker, ${CURDIR}/dotfiles/vim/ftplugin/verilog_systemverilog.vim, ${HOME}/.vim/ftplugin/verilog_systemverilog.vim)
	@echo "$(GREEN)Installed$(RESET) vim ftplugin folder"

.PHONY: clean_vim_ftplugin
clean_vim_ftplugin :
	@rm -f ${HOME}/.vim/ftplugin
	@echo "$(GREEN)Cleaned$(RESET) vim ftplugin folder"

.PHONY: install_vim
install_vim : install_vim_plug install_vim_ftplugin
	$(call linker, ${CURDIR}/dotfiles/vim/vimrc, ${HOME}/.vimrc)
	@echo "$(GREEN)Installed$(RESET) .vimrc file"

.PHONY: force_install_vim
force_install_vim : install_vim_plug install_vim_ftplugin
	$(call forced_linker, ${CURDIR}/dotfiles/vim/vimrc, ${HOME}/.vimrc)

.PHONY: clean_vim
clean_vim :
	@rm -f ${HOME}/.vimrc
	@echo "$(GREEN)Removed$(RESET) .vimrc"
	@rm -rf ${HOME}/.vim/
	@echo "$(GREEN)Removed$(RESET) .vim/"

###########################################
# Setup for TMUX
###########################################

.PHONY: install_tmux_plugin
install_tmux_plugin :
	@mkdir -p ${HOME}/.tmux/plugins
	@git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
	@echo "$(GREEN)Installed$(RESET) tmux plugin"

.PHONY: install_tmux
install_tmux : install_tmux_plugin
	$(call linker, ${CURDIR}/dotfiles/tmux/tmux.conf, ${HOME}/.tmux.conf)
	@echo "$(GREEN)Installed$(RESET) .tmux.conf"

.PHONY: force_install_tmux
force_install_tmux : install_tmux_plugin
	$(call forced_linker, ${CURDIR}/dotfiles/tmux/tmux.conf, ${HOME}/.tmux.conf)
	@echo "$(YELLOW)Forced$(RESET) $(GREEN)Install$(RESET) .tmux.conf"

.PHONY: clean_tmux
clean_tmux :
	@rm -f ${HOME}/.tmux.conf
	@echo "$(GREEN)Removed$(RESET) .tmux.conf"
	@rm -rf ${HOME}/.tmux/
	@echo "$(GREEN)Removed$(RESET) .tmux folder"

###########################################
# Setup for SCREEN
###########################################

.PHONY: install_screen
install_screen :
	$(call linker, ${CURDIR}/dotfiles/screen/screenrc, ${HOME}/.screenrc)

.PHONY: force_install_screen
force_install_screen :
	$(call forced_linker, ${CURDIR}/dotfiles/screen/screenrc, ${HOME}/.screenrc)

.PHONY: clean_screen
clean_screen :
	@rm -f ${HOME}/.screen

###########################################
# Setup for GIT
###########################################

.PHONY: install_gitconfig
install_gitconfig :
	$(call linker, ${CURDIR}/dotfiles/git/gitconfig, ${HOME}/.gitconfig)
	@echo "$(GREEN)Installed$(RESET) .gitconfig"

.PHONY: force_install_gitconfig
force_install_gitconfig :
	$(call forced_linker, ${CURDIR}/dotfiles/git/gitconfig, ${HOME}/.gitconfig)
	@echo "$(YELLOW)Forced$(RESET) $(GREEN)Install$(RESET) .gitconfig"

.PHONY: clean_gitconfig
clean_gitconfig :
	@rm -f ${HOME}/.gitconfig
	@echo "$(GREEN)Removed$(RESET) .gitconfig"
