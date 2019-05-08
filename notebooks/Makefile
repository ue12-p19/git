NORMALIZE = ../../flotpython-tools/tools/nbnorm.py
NORMALIZE_OPTIONS = --author "Thierry Parmentelat" --logo-path media/inria-25-alpha.png



NOTEBOOKS := $(shell git ls-files *.ipynb)
SHELLS = $(subst .ipynb,.sh,$(NOTEBOOKS))

all: norm conv

%.sh: %.ipynb
	jupyter nbconvert --to script $*

conv: $(SHELLS)

norm:
	$(NORMALIZE) $(NORMALIZE_OPTIONS) $(NOTEBOOKS)

