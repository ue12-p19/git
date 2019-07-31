# dependencies
# (*) nbnorm is the historical custom tool from flotpython
# (*) for nbpublish
#     pip install ipypublish 
# (*) with the sphinx engine (broken for us - unused)
#     pip install ipypublish[sphinx]
# (*) notebook concatenation
#     pip install nbmerge


NORMALIZE = ../../flotpython-tools/tools/nbnorm.py
NORMALIZE_OPTIONS = --author "Thierry Parmentelat" --logo-path media/inria-25-alpha.png --rise
LICENCE_STRIP = ../../flotpython-gittutorial/tools/nbstriplicense.py

# using ipypublish instead of sphinx-build
# nbpublish insists on getting an absolute path for output path
#ABSEXPORT = $(shell pwd)/exporting
# by default
#HTMLSTYLE = html_ipypublish_all 
# static reveal slides
#SLIDESSTYLE = slides_ipypublish_all
# sphinx output comes with a toc but figures are broken
#SPHINXSTYLE = sphinx_ipypublish_all.run




NOTEBOOKS := $(shell git ls-files *.ipynb)

all:: norm 

norm:
	$(NORMALIZE) $(NORMALIZE_OPTIONS) $(NOTEBOOKS)

all:: shell

SHELLS = $(foreach nb,$(subst .ipynb,.sh,$(NOTEBOOKS)),../scripts/$(nb))
shell: $(SHELLS)

../scripts/%.sh: %.ipynb
	jupyter nbconvert --to script $* && mv -f $*.sh ../scripts && chmod +x ../scripts/$*.sh

#########################################################################
# execution / conversion / publication
# 
# we execute once
# foo.ipynb -> exporting/foo.exec.ipynb
# 
# at this point, the most suitable output format 
# for other teachers and students who don't feel comfy with 
# live slideshows, seems to be html


all:: exec

.PHONY: exec

#### exec notebooks
EXECS=$(foreach nb,$(NOTEBOOKS),exporting/$(subst .ipynb,.exec.ipynb,$(nb)))

exporting/%.exec.ipynb: %.ipynb
	jupyter nbconvert --to notebook --execute $*.ipynb --output exporting/$*.exec.ipynb
	$(LICENCE_STRIP) $@

exec: $(EXECS)



#### sphinx

.PHONY: sphinx view-sphinx

sphinx: exporting/_build/html/index.html

exporting/_build/html/index.html: exporting/index.rst exporting/conf.py $(EXECS) 
	sphinx-build -b html exporting exporting/_build/html

view-sphinx:
	open exporting/_build/html/index.html

### 
# markdown would be nice too, at least for creating a single bundled document
# unfortulately, terminal color sequences (like Esc-[-33m and similar) 
# end up unchanged and clobber the output, esp. for this course 
# so let's forget about that for now

clean:
	rm -rf exporting/_build

superclean: clean
	rm -rf exporting/*.ipynb

