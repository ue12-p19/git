
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

# si nécessaire, vous pouvez remettre le repository en l'état
# 
# pour cela mettez "true" au lieu de ""
# et bien sûr évaluer la cellule

reset=""

if [ -n "$reset" ]; then 
    cd $TOP
    bash $SCRIPTS/2-01-my-first-repo.sh 
    bash $SCRIPTS/2-02-consistency-repo-fs.sh 
fi >& /dev/null

# si nécessaire, on se place dans le dépôt git
[ -d my-first-repo ] && cd my-first-repo

pwd

# vous devez avoir 4 commits, deux branches
# et être sur la branche devel
git l --all

# la branche courante est devel
# du coup si on crée un commit
# maintenant:

echo "dans la branche devel" >> LICENSE
git add LICENSE
git commit -m "le début de la branche devel"

# on est  sur devel
ls

# on va sur master
git checkout master

# on retrouve tous nos fichiers
ls

# on retourne sur devel
git checkout devel

# les fichiers suivent le contenu du commit
ls

git diff master devel

# on se met dans la branche master
git checkout master

# on vérifie
git branch

# ce merge va 
# créer un commit, donc:

# - il sera créé 
# sur la branche courante
# ici master
# -  il me faut donner
# un message

git merge devel -m "mon premier merge"

# remarquez le nouveau commit 
# qui est bien sûr
# créé dans la branche courante
git l

git l

git l -1 master^

git l -1 master~2

git l --all

# l'endroit de la 'fourche' c'est
git merge-base master^ master^2

fork=$(git merge-base master^ master^2)
echo $fork

# on va se définir des raccourcis
# pour désigner les 4 points importants

left="master^"

right="master^2"

git l -1 master

git l -1 $left

git l -1 $right

git l -1 $fork


git diff $right master

git diff $fork $left

git diff $left master

git diff $fork $right

git l --all
