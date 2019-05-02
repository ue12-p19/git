# --------
FROM nbhosting/minimal-notebook

RUN jupyter nbextension enable splitcell/splitcell

RUN git config --global user.email "notebook.user@example.org" && config --global user.name "Notebook User"

# not quite sure yet which is best, let's ship both for now

RUN pip install bash_kernel && python -m bash_kernel.install

RUN pip install metakernel_bash && python -m metakernel_bash install
