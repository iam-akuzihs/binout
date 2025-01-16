.POSIX:

export DM_REPO := $(HOME)/git/GenshinData
export TRANSLATE_DM := $(HOME)/git/translate-dm

undefine CHECKOUT
include checkout.mk

all: $(CHECKOUT)
$(CHECKOUT):
	./scripts/checkout $@ $(lastword $(subst -, ,$@))
	git commit -m "Add $@" -- checkout.mk $@ || true

translate:
	./scripts/translate $(CHECKOUT)
	git add v*
	git commit -m "Translate fields" -- v* || true

rebuild:
	git branch -D live || true
	./scripts/rebuild

.PHONY: all translate rebuild
