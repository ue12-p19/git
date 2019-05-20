NORMALIZE = ../../flotpython-tools/tools/nbnorm.py
NORMALIZE_OPTIONS = --author "Thierry Parmentelat" --logo-path media/inria-25-alpha.png --rise



NOTEBOOKS := $(shell git ls-files *.ipynb)
SHELLS = $(foreach nb,$(subst .ipynb,.sh,$(NOTEBOOKS)),../scripts/$(nb))

all: norm shell

norm:
	$(NORMALIZE) $(NORMALIZE_OPTIONS) $(NOTEBOOKS)

shell: $(SHELLS)

../scripts/%.sh: %.ipynb
	jupyter nbconvert --to script $* && mv -f $*.sh ../scripts && chmod +x ../scripts/$*.sh

plan:
	grep '"## ' $(NOTEBOOKS) > PLAN.grep
