
# de très nombreuses options disponibles
# sans --all
git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'

# avec --all
git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all

# le contenu d'un commit
git ls-tree --abbrev HEAD

# un autre commit
git ls-tree --abbrev master

# git status donne une synthèse

# dans le cas général il va nous montrer 
# (*) le nom de la branche courante
# (*) les deux sortes de différences
# (*) et aussi le cas échéant les fichiers
#     qui sont présents mais pas dans le commit

# mais pour l'instant il n'y a pas grand chose à voir
git status

# je mets un changement dans l'index
echo "δ2: une ligne dans l'index" >> README.md
git add README.md

# je fais un autre changement 
# mais pas dans l'index
echo "δ1: pas dans l'index" >> README.md

# voici ce que ça donne quand on a des changements 

git status

# par défaut git diff montre les diffs
# entre l'espace de travail et l'index

git diff

# pour voir ce qui est dans l'index

git diff --cached

# juste pour ce tuto:
# 
# un raccourci pour bien montrer 
# LES DEUX différences:
# fichiers / index 
# et
# index / commit

type show-diffs

show-diffs

# j'avais deux différences (une dans l'index et l'autre non)

# avec cette commande je vais revenir à l'état du dernier commit

git reset --hard

git status

show-diffs

ls

git reset --hard
$SCRIPTS/do both-kinds-of-changes

show-diffs

git reset --hard
$SCRIPTS/do both-kinds-of-changes


# on vide l'index mais on conserve 
# les deux différences  

git reset

show-diffs

git reset --hard
$SCRIPTS/do both-kinds-of-changes


# on abandonne la différence 
# qui n'etait pas dans l'index

git checkout -- .

show-diffs

git reset --hard HEAD
$SCRIPTS/do both-kinds-of-changes

# si on fait les deux 
# c'est comme reset --hard

git reset -- README.md
git checkout -- README.md

show-diffs
