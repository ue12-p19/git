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

    section_names = [
        'Introduction',
        'Primer',
        'Approfondissement',
    ]


    default_track =  Track(
        coursedir,
        [Section(coursedir=coursedir,
                 name=section_name,
                 notebooks=notebooks_by_pattern(
                     coursedir,
                     f"notebooks/{number}-*.ipynb"))
         for number, section_name in enumerate(section_names, 1)],
        name="single",
        description="git tuto")

    return [default_track]
