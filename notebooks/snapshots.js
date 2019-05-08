const defaultTemplate = 
    GitgraphJS.templateExtend("metro", {
        colors: ["navy", "gray", "orange"],
        arrow: {
            size: 0,
        },
        branch: {
            label: {
            font: "normal 16pt Quicksand",
            display: true,
            strokeColor: "black",
        },
        lineWidth: 7,
        },
        commit: {
            dot: {
                size: 12,
            },
            spacing: 40,
            message: {
                displayAuthor: false,
                displayHash: false,
                font: "normal 20pt Quicksand",
            },
        },
    });

function init_repo(container, optional_template) {
    let template = optional_template ? optional_template : defaultTemplate;
    let options = {template: template};
    let gitgraph = GitgraphJS.createGitgraph(container, options);
    let master = gitgraph.branch("master");
    return [gitgraph, master];
}

function phase1(gitgraph, master) {
    master.commit("my first commit: added README.md");
    master.commit("added LICENSE, changed README.md");
    return [gitgraph, master];
}

function phase2(gitgraph, master) {
    master.commit("new files file1 and file2");
    master.commit("added file3, we now have 5 files");
    return [gitgraph, master];
}

function phase3(gitgraph, devel) {
    devel.commit("foobar");
}

function draw_repo20(id) {
    let [gitgraph, master] = init_repo(document.getElementById(id));
    phase1(gitgraph, master);
    phase2(gitgraph, master);
    return [gitgraph, master];
}

function draw_repo30(id) {
    let [gitgraph, master] = init_repo(document.getElementById(id));
    phase1(gitgraph, master);
    let devel = gitgraph.branch("devel");
    phase2(gitgraph, master);
    phase3(gitgraph, devel);
    return [gitgraph, master, devel];
}

function draw_repo40(id) {
    let [gitgraph, master, devel] = draw_repo30(id);
    master.merge(devel);
    return [gitgraph, master, devel];
}

function draw_repo50(id) {
    let [gitgraph, master, devel] = draw_repo40(id);
    devel.merge(master);
    return [gitgraph, master, devel];
}

function draw_repo60(id) {
    let [gitgraph, master, devel] = draw_repo50(id);
    master.tag('tag-1.0');
    return [gitgraph, master, devel];
}


function display_from_hashes() {
    let hash = window.location.hash;
    let sections = [];
    if (hash.indexOf("#") == 0)
        hash = hash.slice(1);
    if (! hash) {
        sections.push('phase1');
    } else {
        sections = hash.split("+");
    }
    sections.forEach(function(section, index) {
        let draw_function = eval(`draw_${section}`);
        if (draw_function) {
            let row = $("<div>").addClass("row");
            row.append(
                    $("<div>").addClass("col-7  ").addClass("right-border").attr("id", section),
                    $("<div>").addClass("col-5")
                        .append($(`<pre><code>${draw_function.toString()}</code></pre>`)));
            ;
            $("#phases").append(row);
            draw_function(section);
        } else {
            $("#phases").append($("<div>").attr("id", section));
            $(`#${section}`).html(`no such phase ${section}`);      
        }
        if (index < (sections.length-1))
            $("#phases").append($("<hr>").addClass("sep"));
    });
}

// autoexec upon load
$(display_from_hashes);

/*
      // Simulate git commands with Gitgraph API.
      const master = gitgraph.branch("master");
      master.commit("Initial commit");

      const develop = gitgraph.branch("develop");
      develop.commit("Add TypeScript");

      const aFeature = gitgraph.branch("a-feature");
      aFeature
        .commit("Make it work")
        .commit("Make it right")
        .commit("Make it fast");

      develop.merge(aFeature);
      develop.commit("Prepare v1");

      master.merge(develop).tag("v1.0.0");
    }
  */
