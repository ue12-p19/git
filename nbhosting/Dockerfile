# --------
FROM nbhosting/minimal-notebook

### nbextensions 

# install rise
RUN pip install --pre rise

### bash kernel

# let's go with this one which is based on metakernel 
RUN pip install calysto_bash

# these 2 are also available, but less responsive 
#RUN pip install bash_kernel && python -m bash_kernel.install
#RUN pip install metakernel_bash && python -m metakernel_bash install


### speed up jupyter lab startup
RUN jupyter lab build
