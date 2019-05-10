
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
