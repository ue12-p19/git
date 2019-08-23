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

    # 2 tracks
    # 'intro' : 2 sections 1* et 2*
    # 'approfondissement' : 3*

    track_specs = [
        ('Session 1' , 'utilisation en local', 
         [ ('intro', '1-*.ipynb'),
           ('primer', '2-*.ipynb'),
         ]),
        ('Session 2', 'synchros et fonctions avancées',
         [ ('synchros', '3-*.ipynb'),
           ('avancé', '4-*.ipynb'),
         ]),
        ]

    return [Track(coursedir, 
                  [Section(coursedir=coursedir,
                           name=section_name, 
                           notebooks=notebooks_by_pattern(
                               coursedir,
                               f"notebooks/{pattern}"))
                   for section_name, pattern in section_specs],
                  name=track_name,
                  description=track_description)
            for track_name, track_description, section_specs in track_specs]
