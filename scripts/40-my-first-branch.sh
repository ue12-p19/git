
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh; standard-start

# si nécessaire, vous pouvez remettre le repository 
# dans l'état où il est après le notebook 20-my-first-repo
# 
# pour cela enlever le premier caractère '#' 
# et évaluer la cellule

# bash scripts/20-my-first-repo.sh >& /dev/null
# bash scripts/30-my-first-changes.sh >& /dev/null

# si nécessaire, on se place dans le repo git
[ -d my-first-repo ] && cd my-first-repo

pwd

# vous devez avoir 4 commits, deux branches
# et être sur la branche devel
show-repo --all

# pour voir la liste des branches
# met la branche courante en relief

git branch

# git log -1 : pour ne voir que un commit
git log --oneline -1 HEAD

show-repo --all

# pour créer une branche
# donner juste un nom et un commit

git branch foobar HEAD^

show-repo --all

# pour renommer une branche 
# (même la branche courante d'ailleurs)

git branch -m foobar trucmuche

show-repo --all

# pour détruire une branche

git branch -d trucmuche

show-repo --all


# la branche courante est devel
# du coup si on crée un commit
# maintenant:

echo "dans la branche devel" >> LICENSE
git add LICENSE
git commit -m "le début de la branche devel"

show-repo --all

ls

git checkout master

ls

git checkout devel

ls

git diff master devel

# on se met dans la branche master
git checkout master

# on vérifie
git branch

# ce merge va créer un commit
# il me faut donc donner un message
git merge devel -m "mon premier merge"

# remarquez le nouveau commit
show-repo

show-repo

show-repo -1 master^

show-repo -1 master~2

show-repo

show-repo -1 master^

show-repo -1 master^2

show-repo 

# première à droite, puis on descend
show-repo -1 master^2^

# c'est donc comme si j'était descendu 3 fois
show-repo -1 master~3

show-repo --all

# l'endroit de la 'fourche' c'est
git merge-base master^ master^2

fork=$(git merge-base master^ master^2)
echo $fork

# on va se définir des raccourcis
# pour désigner les 4 points importants

left="master^"

right="master^2"

show-repo -1 master

show-repo -1 $left

show-repo -1 $right

show-repo -1 $fork

git diff $right master

git diff $fork $left

git diff $left master

git diff $fork $right

xxx

# les fichiers dans l'index,
# i.e. dans le prochain commit 
# si on le faisait maintenant
git ls-files

# pareil 
# mais pour voir seulement
# seulement ceux qui sont modifiés

# alias: git ls-files -m
git ls-files --modified

# imaginons que je détruis un fichier
rm LICENSE

git ls-files

touch NEW

git ls-files

# je suis actuellement 
# sur la branche `devel`,
# un commit qui a 2 fichiers

git ls-tree --abbrev devel

# imaginons que je veuille 
# revenir à la branche `master`

git ls-tree --abbrev master

# mais que j'aie un fichier `file1` qui traine:
touch file1

# alors `git` va refuser de revenir à la branche `master`
git checkout master

# pour revenir à un état propre
rm file1

# devrait afficher:
# 
# On branch devel
# nothing to commit, working tree clean

git status

# je modifie README.md

echo 'on modifie le readme' >> README.md

git diff README.md

git checkout master

git diff

git status

show-repo

git log
