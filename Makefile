# Makefile for vimsane
SHELL=/bin/bash
.ONESHELL:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules --no-print-directory
.SHELLFLAGS= -uec
Remake = make $(MAKEFLAGS) -f $(realpath $(lastword $(MAKEFILE_LIST)))

absdir := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
Flag = $(HOME)/.flag-vimsane

Vim=$(shell which vim)

Config:
	@
	cat <<-EOF
	absdir=$(absdir)
	Flag=$(Flag)
	Flags="$$(ls $(Flag) 2>/dev/null | tr  '\n' ' ')"
	EOF

setup:



$(Flag)/.init:
	@
	mkdir -p $(Flag)
	touch $@

$(Flag)/vim-installed:
	@
	which vim &>/dev/null || {
		apt-get install -y vim
	}
	bash -lic '$$(which vim) --version &>/dev/null '  || exit 19
	touch $@

$(HOME)/.vim/vimrc: $(HOME)/.vim/.init $(Flag)/vundlevim | $(Flag)/vim-installed
	@
	cd $(@D)
	mkdir -p $(HOME)/.vimtmp
	ln -sf load-lmath-plugins.vim load-plugins.vim
	ln -sf lmath-vimrc.vim vimrc


$(Flag)/vundlevim:
	@
	cd $(HOME)/.vim
	git clone https://github.com/sanekits/Vundle.vim -o sane
	touch $@


$(HOME)/.vim/.init:
	@
	cd $(HOME)
	git clone https://github.com/sanekits/vimsane-cfg .vim
	touch $@

$(Flag)/plugins-installed: | $(Flag)/vim-installed
	@
	bash -ic 'VIMHOME=$(HOME)/.vim command $(Vim) +PluginInstall +qall; exit'
	VIMHOME=$(HOME)/.vim $(Vim) +PluginInstall +qall
	touch $@

$(Flag)/EDITOR-defined: | $(Flag)/vim-installed
	@ # We expect EDITOR=vim instead of vi
	bash -ic 'echo $$EDITOR' | grep -q vim && {
		touch $@
		exit 0
	} || :
	echo 'EDITOR=$(Vim) # Added by vimsane/Makefile target $@' >> $(HOME)/.bashrc
	touch $@


setup: \
	$(Flag)/.init \
	$(HOME)/.vim/vimrc \
	$(Flag)/plugins-installed \
	$(Flag)/EDITOR-defined \
	| $(Flag)/vim-installed


clean:
	@
	rm $(Flag)/* &>/dev/null ||  :
	rm -rf $(HOME)/.vim
	[[ -h $(HOME)/.local/vim ]] && rm $(HOME)/.local/vim || :
