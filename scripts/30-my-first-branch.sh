
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

# si nécessaire, vous pouvez remettre le repository en l'état
# 
# pour cela mettez "true" au lieu de ""
# et bien sûr évaluer la cellule

reset=""

if [ -n "$reset" ]; then 
    cd $TOPLEVEL
    bash $SCRIPTS/10-my-first-repo.sh 
    bash $SCRIPTS/20-my-first-changes.sh 
fi >& /dev/null

# si nécessaire, on se place dans le repo git
[ -d my-first-repo ] && cd my-first-repo

pwd

# vous devez avoir 4 commits, deux branches
# et être sur la branche devel
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

# ce merge va créer un commit, donc:

# - il sera créé sur la branche courante
# ici master
# -  il me faut donner un message
git merge devel -m "mon premier merge"


# remarquez le nouveau commit 
# qui est bien sûr
# créé dans la branche courante
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
