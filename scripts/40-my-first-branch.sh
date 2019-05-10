
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

git branch

# -1 : équivalent à git log -n 1 
# ou encore git log --max-count 1
git log --oneline -1 HEAD

# pour créer une branche: donner juste un nom et un commit

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
# du coup si on crée un commit maintenant

echo "dans la branche devel" >> README.md
git add README.md
git commit -m "le début de la branche devel"

show-repo --all

ls

git checkout master

ls

git checkout devel

ls

git diff master devel

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
