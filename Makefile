# Makefile for vimsane
SHELL=/bin/bash
.ONESHELL:
.SUFFIXES:
MAKEFLAGS += --no-builtin-rules --no-print-directory
.SHELLFLAGS= -uec
Remake = make $(MAKEFLAGS) -f $(realpath $(lastword $(MAKEFILE_LIST)))

absdir := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
Flag = $(HOME)/.flag-vimsane

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
	bash -lic 'command vim --version &>/dev/null'  || exit 19
	touch $@

$(HOME)/.vim/vimrc: $(HOME)/.vim/.init $(Flag)/vundlevim
	@
	cd $(@D)
	mkdir -p $(HOME)/.vimtmp
	ln -sf load-lmath-plugins.vim load-plugins.vim
	ln -sf lmath-vimrc.vim vimrc


$(Flag)/vundlevim:
	@
	cd $(HOME)/.vim
	git clone bbgithub:sanekits/Vundle.vim -o bbsane
	touch $@


$(HOME)/.vim/.init:
	@
	cd $(HOME)
	git clone bbgithub:sanekits/vimsane-cfg .vim
	touch $@

$(Flag)/plugins-installed:
	@
	bash -lic 'VIMHOME=$(HOME)/.vim command vim +PluginInstall +qall'
	VIMHOME=$(HOME)/.vim vim +PluginInstall +qall
	touch $@

$(Flag)/EDITOR-defined:
	@ # We expect EDITOR=vim instead of vi
	bash -ic 'echo $$EDITOR' | grep -q vim && {
		touch $@
		exit 0
	} || :
	echo 'EDITOR=vim # Added by vimsane/Makefile target $@' >> $(HOME)/.bashrc
	touch $@


setup: \
	$(Flag)/.init \
	$(Flag)/vim-installed \
	$(HOME)/.vim/vimrc \
	$(Flag)/plugins-installed \
	$(Flag)/EDITOR-defined

clean:
	@
	rm $(Flag)/* &>/dev/null ||  :
	rm -rf $(HOME)/.vim
	[[ -h $(HOME)/.local/vim ]] && rm $(HOME)/.local/vim || :
