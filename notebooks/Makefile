NOTEBOOKS := $(shell git ls-files *.ipynb)
SHELLS = $(subst .ipynb,.sh,$(NOTEBOOKS))

all: norm conv

%.sh: %.ipynb
	jupyter nbconvert --to script $*

conv: $(SHELLS)

norm:
	nbstripout $(NOTEBOOKS)

