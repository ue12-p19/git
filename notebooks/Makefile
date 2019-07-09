# dependencies
# (*) nbnorm is the historical custom tool from flotpython
# (*) for nbpublish
#     pip install ipypublish 
# (*) notebook concatenation i.e. nbtb cat
#     pip install nbtoolbelt


NORMALIZE = ../../flotpython-tools/tools/nbnorm.py
NORMALIZE_OPTIONS = --author "Thierry Parmentelat" --logo-path media/inria-25-alpha.png --rise

# nbpublish insists on getting an absolute path for output path
ABSEXPORT = $(shell pwd)/exporting

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
	grep '"## ' $(NOTEBOOKS) > PLAN.grep

#########################################################################
# execution / conversion / publication
# 
# we execute once
# foo.ipynb -> exporting/foo.exec.ipynb
# 
# at this point, the most suitable output format 
# for other teachers and students who don't feel comfy with 
# live slideshows, seems to be html


export: exec html

####
exporting:
	mkdir exporting



####
EXECS=$(foreach nb,$(NOTEBOOKS),exporting/$(subst .ipynb,.exec.ipynb,$(nb)))

exporting/%.exec.ipynb: %.ipynb
	jupyter nbconvert --to notebook --execute $*.ipynb --output exporting/$*.exec.ipynb

exec: exporting $(EXECS)



####
HTMLS=$(foreach nb,$(NOTEBOOKS),exporting/$(subst .ipynb,.exec.html,$(nb)))

exporting/%.exec.html:%.ipynb 
	nbpublish -f html_ipypublish_all -o $(ABSEXPORT) exporting/$*.exec.ipynb
	rm exporting/*.log

html: exporting $(HTMLS)



#### bundle
bundle: exporting/ALL.html

exporting/ALL.ipynb: $(EXECS)
	nbtb cat exporting/[0-9]*.exec.ipynb
	mv exporting/0*-cat.ipynb $@

exporting/ALL.html: exporting/ALL.ipynb
	nbpublish -f html_ipypublish_all -o $(ABSEXPORT) exporting/ALL.ipynb
	rm exporting/*.log


### 
# markdown would be nice too, at least for creating a single bundled document
# unfortulately, terminal color sequences (like Esc-[-33m and similar) 
# end up unchanged and clobber the output, esp. for this course 
# so let's forget about that for now

####
MDS=$(foreach nb,$(NOTEBOOKS),exporting/$(subst .ipynb,.exec.md,$(nb)))

exporting/%.exec.md:%.ipynb 
	jupyter nbconvert --to markdown --execute $*.ipynb --output exporting/$*.md

md: exporting $(MDS)



all-md: exporting/ALL.md
exporting/ALL.md: $(MDS)
	cat $(MDS) > $@

