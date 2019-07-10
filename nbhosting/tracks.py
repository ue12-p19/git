# pylint: disable=c0111

from nbhosting.courses import (
    Track, Section, Notebook,
    notebooks_by_pattern, track_by_directory)

def tracks(coursedir):
    """
    coursedir is a CourseDir object that points
    at the root directory of the filesystem tree
    that holds notebooks

    result is a list of Track instances
    """

    # define a single track that has sections:
    # 1: for notebooks named 00*
    # 2: for notebooks named 0[1-9]0*
    # 3: for notebooks named 1[0-9][0-9]*

    section_specs = [
        ('Introducion', '00[0-9]*.ipynb'),
        ('Primer', '0[1-9][0-9]*.ipynb'),
        ('Approfondissement', '1[0-9][0-9]*.ipynb'),
        ]


    default_track =  Track(
        coursedir,
        [Section(coursedir=coursedir,
                 name=section_name,
                 notebooks=notebooks_by_pattern(
                     coursedir,
                     f"notebooks/{pattern}"))
         for number, (section_name, pattern) in enumerate(section_specs, 1)],
        name="unique",
        description="git tuto")

    return [default_track]
