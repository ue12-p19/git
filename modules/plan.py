from IPython.display import HTML

# a None section is meant as a separator

PLAN = {
    'header': "plan du cours",
    'outline': [
        "introduction",             # 01
        "notebooks bash",           # 10
        "mon premier repo",         # 20
        "gérer les changements",    # 30
        "ma première branche",      # 40
    ]
}


def span(text, bold=False, strike=False):
    class_ = ''
    if bold or strike:
        class_ += ' class="'
    if bold:
        class_ += ' plan-bold'
    if strike:
        class_ += ' plan-strike'
    if bold or strike:
        class_ += '"'
    return (f"<span{class_}>{text}</span>")


def section_plan(data, title, subtitle, level):
    """
    one specific section, and possibly one specific subsection
    """
    result = f"<h{level} class='plan'>{data['header']}</h{level}>"
    result += "<ul class='plan'>"
    done = True
    for item in data['outline']:
        # ignore sectioning
        if item is None:
            continue
        # are there subsections ?
        if isinstance(item, str):
            pl_title, pl_subtitles = item, []
        else:
            pl_title, pl_subtitles = item
        # is this the current topic ?
        cur_title = title.lower() in pl_title
        if cur_title:
            done = False
        # write section
        result += f"<li>{span(pl_title, bold=cur_title, strike=done)}"
        # if we've asked for subsections, only detail
        # the current section
        subdone = True
        if subtitle and cur_title and pl_subtitles:
            result += "<ul class='subplan'>"
            for pl_subtitle in pl_subtitles:
                cur_subtitle = subtitle.lower() in pl_subtitle
                if cur_subtitle:
                    subdone = False
                item = span(pl_subtitle, bold=cur_subtitle, strike=subdone)
                result += f"<li>{item}</li>"
            result += "</ul>"
        # close section
        result +="</li>"
    result += "</ul>"
    return HTML(result)


def detailed_plan(data, level):
    """
    all sections and subsections
    """
    result = f"<h{level} class='plan'>{data['header']}</h{level}>"
    result += "<div class='plan-container'>"
    result += "<div class='plan-part'>"
    result += "<ul class='plan'>"
    for item in data['outline']:
        if item is None:
            result += "</ul>"
            result += "</div>" # class='plan-part'
            result += "<div class='plan-part'>"
            result += "<ul class='plan'>"
            continue
        # are there subsections ?
        if isinstance(item, str):
            pl_title, pl_subtitles = item, []
        else:
            pl_title, pl_subtitles = item
        result += f"<li>{span(pl_title)}"
        if pl_subtitles:
            result += "<ul class='subplan'>"
            for pl_subtitle in pl_subtitles:
                result += f"<li>{span(pl_subtitle)}</li>"
            result += "</ul>"
        # close section
        result +="</li>"
    result += "</ul>"
    result += "</div>" # class='plan-part'
    result += "</div>" # class='plan-container'
    return HTML(result)



def plan(title=None, subtitle=None, *, level=1):
    if title is None:
        return detailed_plan(PLAN, level)
    else:
        return section_plan(PLAN, title, subtitle, level)
