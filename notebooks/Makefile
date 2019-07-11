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
LICENCE_STRIP = ../tools/nbstriplicense.py

# nbpublish insists on getting an absolute path for output path
ABSEXPORT = $(shell pwd)/exporting

# by default
HTMLSTYLE = html_ipypublish_all 
# static reveal slides
SLIDESSTYLE = slides_ipypublish_all
# sphinx output comes with a toc but figures are broken
SPHINXSTYLE = sphinx_ipypublish_main.run




NOTEBOOKS := $(shell git ls-files *.ipynb)
SHELLS = $(foreach nb,$(subst .ipynb,.sh,$(NOTEBOOKS)),../scripts/$(nb))

all: norm shell

norm:
	$(NORMALIZE) $(NORMALIZE_OPTIONS) $(NOTEBOOKS)

shell: $(SHELLS)

../scripts/%.sh: %.ipynb
	jupyter nbconvert --to script $* && mv -f $*.sh ../scripts && chmod +x ../scripts/$*.sh

####
plan:
	egrep '"#{1,2} ' $(NOTEBOOKS) > PLAN.grep

#########################################################################
# execution / conversion / publication
# 
# we execute once
# foo.ipynb -> exporting/foo.exec.ipynb
# 
# at this point, the most suitable output format 
# for other teachers and students who don't feel comfy with 
# live slideshows, seems to be html


export: exec html media

.PHONY: export exec html media

####
exporting:
	mkdir exporting

media: 
	mkdir -p exporting/media
	(cd ../media; rsync -ai $$(git ls-files) ../notebooks/exporting/media/)


####
EXECS=$(foreach nb,$(NOTEBOOKS),exporting/$(subst .ipynb,.exec.ipynb,$(nb)))

exporting/%.exec.ipynb: %.ipynb
	jupyter nbconvert --to notebook --execute $*.ipynb --output exporting/$*.exec.ipynb

exec: exporting $(EXECS)



####
HTMLS=$(foreach nb,$(NOTEBOOKS),exporting/$(subst .ipynb,.exec.html,$(nb)))

exporting/%.exec.html:%.ipynb 
	nbpublish -f $(HTMLSTYLE) -o $(ABSEXPORT) exporting/$*.exec.ipynb
	rm exporting/*.log

html: exporting $(HTMLS)



#### bundle

.PHONY: bundle slides sphinx

bundle: exporting/ALL.html
slides: exporting/SLIDES.html

exporting/ALL.ipynb: $(EXECS)
	nbmerge exporting/[0-9]*.exec.ipynb > $@

exporting/ALL.html: exporting/ALL.ipynb
	nbpublish -f $(HTMLSTYLE) -o $(ABSEXPORT) exporting/ALL.ipynb
	rm exporting/*.log

# static reveal slides
exporting/SLIDES.ipynb: exporting/ALL.ipynb
	cp exporting/ALL.ipynb $@
	$(LICENCE_STRIP) $@

exporting/SLIDES.html: exporting/SLIDES.ipynb
	nbpublish -f $(SLIDESSTYLE) -o $(ABSEXPORT) exporting/SLIDES.ipynb
	mv -f exporting/SLIDES.slides.html $@
	rm exporting/*.log



# this one has the same figure all over the document
sphinx: exporting/ALL-sphinx.html

exporting/ALL-sphinx.html: exporting/ALL.ipynb
	nbpublish -f $(SPHINXSTYLE) -o $(ABSEXPORT) exporting/ALL.ipynb
	mv -f exporting/ALL.html $@
	rm exporting/*.log

foo:
	nbpublish -f $(SPHINXSTYLE) -o $(ABSEXPORT) exporting/[0-9]*.ipynb

### 
# markdown would be nice too, at least for creating a single bundled document
# unfortulately, terminal color sequences (like Esc-[-33m and similar) 
# end up unchanged and clobber the output, esp. for this course 
# so let's forget about that for now

clean:
	rm -rf exporting/*.html exporting/ALL*

superclean:
	rm -rf exporting