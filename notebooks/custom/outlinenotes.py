from IPython.nbconvert.preprocessors import *

count = 4

# quick and dirty - that must exist some place else
def indent(text, space=4):
    sep = space * ' '
    return ''.join( f"{sep}{line}\n" for line in text.split("\n"))
    

def debug(message, text):
    global count
    count -= 1
    if count < 0:
        return
    print(f"{40*'='} {message}")
    print(text)

class OutlineNotes(Preprocessor):
    """
    decorate cells marked as 'notes' with a 'slide-notes' 
    CSS class
    """

    def preprocess_cell(self, cell, resources, index):
        """
        embed notes cells with a css class
        """
        # leave code unchanged
        if cell.cell_type != "markdown":
             return cell, resources
        if ('slideshow' in cell.metadata and 
            cell.metadata['slideshow']['slide_type'] == 'notes'):
            debug('avant', cell.source)
            cell.source = f".. note::\n\n{indent(cell.source)}\n"
            # cell.cell_type = "raw"
            debug('après', cell.source)
        return cell, resources
