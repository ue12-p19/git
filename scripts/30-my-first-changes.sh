
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh; standard-start

# si nécessaire, vous pouvez remettre le repository 
# dans l'état où il est après le notebook 20-my-first-repo
# 
# pour cela enlever le premier caractère '#' 
# et évaluer la cellule

# bash scripts/20-my-first-repo.sh >& /dev/null

# si nécessaire, on se place dans le repo git
[ -d my-first-repo ] && cd my-first-repo

pwd

# vous devez avoir 4 commits
show-repo

# souvenez-vous que HEAD^^ signifie désigne le commit
# qui est le grand-père de HEAD

git checkout -b devel HEAD^^

show-repo

show-repo --all

ls

# de très nombreuses options disponibles
# sans --all
git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'

# avec --all
git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all

git ls-tree --abbrev HEAD

git ls-tree --abbrev master

# git status donne une synthèse

git status

# je mets un changement dans l'index
echo "une ligne dans l'index" >> README.md
git add README.md

# je fais un autre changement 
# mais pas dans l'index
echo "pas dans l'index" >> README.md

git status

# par défaut git diff montre les diffs
# entre l'espace de travail et l'index
git diff

# pour voir ce qui est dans l'index

git diff --cached

type show-diffs

show-diffs

# pour revenir à l'état du dernier commit

git reset --hard

git status

show-diffs

ls

git reset --hard
../scripts/populate.sh do-both-kinds-of-changes

show-diffs

git reset --hard
../scripts/populate.sh do-both-kinds-of-changes


# on vide l'index mais on conserve 
# les deux différences  

git reset

show-diffs

git reset --hard
../scripts/populate.sh do-both-kinds-of-changes


# on abandonne la différence 
# qui n'etait pas dans l'index

git checkout -- .

show-diffs

git reset --hard HEAD
../scripts/populate.sh do-both-kinds-of-changes

# si on fait les deux 
# c'est comme reset --hard

git reset -- README.md
git checkout -- README.md

show-diffs
