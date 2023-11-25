# Makefile for vimsane
SHELL=/bin/bash
.ONESHELL:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules --no-print-directory
Remake = make $(MAKEFLAGS) -f $(realpath $(lastword $(MAKEFILE_LIST)))

absdir := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
Flag = $(HOME)/.flag-vimsane

Config:
	@set -ue
	cat <<-EOF
	absdir=$(absdir)
	EOF

setup:



$(Flag)/.init:
	@set -ue
	mkdir -p $(Flag)
	touch $@

$(Flag)/vim-installed:
	@set -ue
	which vim &>/dev/null || {
		apt-get install -y vim 
	}
	bash -lic 'command vim --version &>/dev/null'  || exit 19
	touch $@

$(HOME)/.vim/vimrc: $(HOME)/.vim/.init $(Flag)/vundlevim
	@set -ue
	cd $(@D)
	mkdir -p $(HOME)/.vimtmp
	ln -sf load-lmath-plugins.vim load-plugins.vim
	ln -sf lmath-vimrc.vim vimrc


$(Flag)/vundlevim:
	@set -ue
	cd $(HOME)/.vim
	git clone bbgithub:sanekits/Vundle.vim -o bbsane
	touch $@


$(HOME)/.vim/.init:
	@set -ue
	cd $(HOME)
	git clone bbgithub:sanekits/vimsane-cfg .vim
	touch $@

$(Flag)/plugins-installed:
	@set -ue
	bash -lic 'VIMHOME=$(HOME)/.vim command vim +PluginInstall +qall'
	VIMHOME=$(HOME)/.vim vim +PluginInstall +qall
	touch $@


setup: \
	$(Flag)/.init \
	$(Flag)/vim-installed \
	$(HOME)/.vim/vimrc \
	$(Flag)/plugins-installed

clean:
	@set -ue
	rm $(Flag)/* &>/dev/null ||  :
	rm -rf $(HOME)/.vim
	[[ -h $(HOME)/.local/vim ]] && rm $(HOME)/.local/vim || :
