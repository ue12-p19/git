# --------
FROM nbhosting/minimal-notebook

### configure git 
RUN git config --global user.email "notebook.user@example.org" && git config --global user.name "Notebook User"

### nbextensions 

# splitcell
RUN jupyter nbextension enable splitcell/splitcell

# install rise
RUN pip install rise && jupyter-nbextension install rise --py && jupyter-nbextension enable rise --py

RUN pip install ipywidgets && jupyter nbextension enable --py widgetsnbextension


### kernels
# let's go with this one which is based on metakernel 

RUN pip install calysto_bash

## not quite sure yet which is best, let's ship both for now
#
#RUN pip install bash_kernel && python -m bash_kernel.install
#
#RUN pip install metakernel_bash && python -m metakernel_bash install

