#!/usr/bin/env python3

####################
import sys

import IPython

# we drop older versions, requires IPython v4
assert IPython.version_info[0] >= 4

import nbformat

default_license = 'license CC BY-NC-ND'


def xpath(top, path):
    result = top
    for i in path:
        result = result[i]
    return result


def compare_without_trailing_newline(a ,b):
    """
    returns True if both strings are almost equal
    if any of the input strings ends with a "\n", 
    it is ignored is the comparison
    """
    a_ref = a if (not a or a[-1] != "\n") else a[:-1]
    b_ref = b if (not b or b[-1] != "\n") else b[:-1]
    return a_ref == b_ref


def replace_file_with_string(target, new_contents):
    try:
        with open(target) as reader:
            current = reader.read()
    except Exception as e:
        current = ""
    if compare_without_trailing_newline(current, new_contents):
        return False
    # overwrite target file
    with open(target, 'w') as writer:
        writer.write(new_contents)
    return True


####################
class Notebook:

    def __init__(self, name, verbose):
        if name.endswith(".ipynb"):
            name = name.replace(".ipynb", "")
        self.name = name
        self.filename = f"{self.name}.ipynb"
        self.verbose = verbose
        self.sections = []        

    def parse(self):
        try:
            with open(self.filename) as f:
                self.notebook = nbformat.reader.read(f)

        except:
            print("Could not parse {}".format(self.filename))
            import traceback
            traceback.print_exc()


    def cells(self):
        return self.xpath(['cells'])

    def cell_contents(self, cell):
        return cell['source']

    def xpath(self, path):
        return xpath(self.notebook, path)


    def remove_license_cells(self, license):
        """
        remove license cells that ruin reveal output
        """
        nb_found = 0
        
        def is_license(cell, license):
            return self.cell_contents(cell).find(license) >= 0
        
        cells_to_remove = [
            cell for cell in self.cells() if is_license(cell, license)]
        nb_found += len(cells_to_remove)
        for cell_to_remove in cells_to_remove:
            self.cells().remove(cell_to_remove)
        if nb_found:
            print(f"found and removed {nb_found} license cells")


    def compute_plan(self):
        """
        fills in self.sections from text cells that 
        start with 1 or 2 #
        """
        for cell in self.cells():
            if cell['cell_type'] != 'markdown':
                continue
            contents = self.cell_contents(cell).split('\n')[0]
            if (contents.startswith('# ')
                or contents.startswith('## ')):
                self.sections.append(contents)
        plan_filename = f"{self.name}-plan.md"
        with open(plan_filename, 'w') as output:
            for line in self.sections:
                print(line, file=output)
        print(f"PLAN written in {plan_filename}")
            

    def save(self):
        outfilename = self.filename
        # don't specify output version for now
        new_contents = nbformat.writes(self.notebook) + "\n"
        if replace_file_with_string(outfilename, new_contents):
            print(f"{self.name} saved into {outfilename}")


    def full_monty(self, license):
        self.parse()
        self.remove_license_cells(license)
        self.compute_plan()
        self.save()


def full_monty(name, **kwds):
    verbose = kwds['verbose']
    del kwds['verbose']
    nb = Notebook(name, verbose)
    nb.full_monty(**kwds)


from argparse import ArgumentParser

usage = """remove license cells from input notebook(s)
"""

def main():
    parser = ArgumentParser(usage=usage)
    parser.add_argument(
        "-t", "--license-text", dest='license', default=default_license,
        help="if a cell contains that text, it gets deleted")
    parser.add_argument(
        "-v", "--verbose", dest="verbose", action="store_true", default=False,
        help="show current notebookname")
    parser.add_argument(
        "notebooks", metavar="IPYNBS", nargs="*",
        help="the notebooks to normalize")

    args = parser.parse_args()

    if not args.notebooks:
        notebooks = Path().glob("*.ipynb")
        notebooks = str(notebook for notebook in notebooks)

    for notebook in args.notebooks:
        if args.verbose:
            print(f"{sys.argv[0]} is opening notebook {notebook}")
        full_monty( notebook, license=args.license, verbose=args.verbose)

if __name__ == '__main__':
    main()
