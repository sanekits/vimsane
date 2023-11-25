# Makefile for spaces-dotfiles.mk
SHELL=/bin/bash
.ONESHELL:
.SUFFIXES:

setup:
	@set -ue
	make -f Makefile setup
