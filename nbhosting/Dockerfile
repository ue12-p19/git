# --------
FROM nbhosting/minimal-notebook

RUN jupyter nbextension enable splitcell/splitcell

RUN pip install bash_kernel && python -m bash_kernel.install
