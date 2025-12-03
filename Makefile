.POSIX:

export DM_REPO := $(HOME)/git/GenshinData
export TRANSLATE_DM := $(HOME)/git/translate-dm

undefine CHECKOUT
include checkout.mk

all: author $(CHECKOUT)
$(CHECKOUT):
	./scripts/checkout $@ $(lastword $(subst -, ,$@))
	git commit -m "Add $@" -- checkout.mk $@ || true

translate: author
	./scripts/translate $(CHECKOUT)
	git add v*
	git commit -m "Translate fields" -- v* || true

rebuild: author
	git branch -D live || true
	./scripts/rebuild

author:
	git config user.name 'akuzihs'
	git config user.email '<>'

.PHONY: all translate rebuild author
