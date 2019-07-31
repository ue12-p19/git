"""
a default sphinx configuration file

This file is execfile()d by Sphinx,
with the current directory set to its containing dir

.. seealso::  

    http://www.sphinx-doc.org/en/master/usage/configuration.html

"""

needs_sphinx = "1.6"

master_doc = "index"

source_suffix = ['.rst']

exclude_patterns = ['_build', 'build', '**.ipynb_checkpoints']

extensions = ['ipypublish.sphinx.notebook', 'ipypublish.sphinx.gls', 'sphinx.ext.mathjax', 'sphinxcontrib.bibtex', 'sphinx.ext.todo']

ipysphinx_export_config = 'sphinx_ipypublish_all.ext.noexec'
ipysphinx_show_prompts = True
ipysphinx_input_prompt = 'In:'
ipysphinx_output_prompt = 'Out:'
ipysphinx_input_toggle = True
ipysphinx_output_toggle = True

todo_include_todos = False

numfig = True

numfig_secnum_depth = 2

numfig_format = {'section': 'Section %s', 'figure': 'Fig. %s', 'table': 'Table %s', 'code-block': 'Code Block %s'}

math_numfig = True

math_eqref_format = "eq.{number}"

linkcheck_ignore = ["r'http://localhost:\\d+/'"]

ipysphinx_show_prompts = True

ipysphinx_input_prompt = "[{count}]:"

ipysphinx_output_prompt = "[{count}]:"
