# make-kit.mk for vimsane
#  This makefile is included by the root shellkit Makefile
#  It defines values that are kit-specific.
#  You should edit it and keep it source-controlled.

# TODO: update kit_depends to include anything which
#   might require the kit version to change as seen
#   by the user -- i.e. the files that get installed,
#   or anything which generates those files.
kit_depends := \
    bin/vimsane.bashrc \
    bin/vimsane.sh

.PHONY: publish publish-draft

VimsaneCfgDeps := $(shell cd vimsane-cfg && git ls-files | sed 's,^,vimsane-cfg/,')

bin/vimsane-cfg.tgz: $(VimsaneCfgDeps)
	tar -czvf $@ $(VimsaneCfgDeps)

tree-setup: .pull-vimsane-cfg bin/vimsane-cfg.tgz

.pull-vimsane-cfg:
	cd vimsane-cfg && git pull

publish: pre-publish publish-common release-upload release-list
	cat tmp/draft-url
	@echo ">>>> publish complete OK. (FINAL)  <<<"

publish-draft: pre-publish publish-common release-draft-upload release-list
	cat tmp/draft-url
	@echo ">>>> publish complete OK. (DRAFT - you must manually publish it from github release page)  <<<"
