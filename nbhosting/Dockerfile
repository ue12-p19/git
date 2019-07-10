# --------
FROM nbhosting/minimal-notebook

### configure git 
RUN git config --global user.email "notebook.user@example.org" && git config --global user.name "Notebook User"

### nbextensions 

# splitcell
RUN jupyter nbextension enable splitcell/splitcell

# install rise
RUN pip install --pre rise

RUN pip install ipywidgets && jupyter nbextension enable --py widgetsnbextension


### bash kernel

# let's go with this one which is based on metakernel 
RUN pip install calysto_bash

# these 2 are also available, but less responsive 
#RUN pip install bash_kernel && python -m bash_kernel.install
#RUN pip install metakernel_bash && python -m metakernel_bash install


### git tools 

RUN pip install git+https://github.com/parmentelat/nbgitpuller@nbhosting && jupyter serverextension enable --py nbgitpuller 

RUN jupyter labextension install @jupyterlab/git && pip install --upgrade jupyterlab-git && jupyter serverextension enable --py jupyterlab_git

