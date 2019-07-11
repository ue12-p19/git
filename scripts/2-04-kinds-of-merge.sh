
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

# si nécessaire, vous pouvez remettre le repository en l'état
# 
# pour cela mettez "true" au lieu de ""
# et bien sûr évaluer la cellule

reset=""

if [ -n "$reset" ]; then 
    cd $TOP
    bash $SCRIPTS/10-my-first-repo.sh
    bash $SCRIPTS/20-my-first-changes.sh
    bash $SCRIPTS/30-my-first-branch.sh
fi >& /dev/null

# si nécessaire, on se place dans le repo git
[ -d my-first-repo ] && cd my-first-repo

pwd

# vous devez avoir deux branches, 6 commits dont un merge
# et être sur la branche master 
git l --all

git l

git checkout devel
git merge master

git l

# un changement qui
# ne sera pas conflictuel

$SCRIPTS/do no-worries-1

# celui-ci par contre le sera

$SCRIPTS/do conflict-1

git diff

git add factorial.md
git commit -m 'pour conflit dans devel'

git l --all

# remettons-nous au commit précédent
git checkout master

# même logique, on fait deux changements

$SCRIPTS/do no-worries-2
$SCRIPTS/do conflict-2

git diff

git add factorial.py factorial.md

git commit -m'pour conflit, dans master'

git l --all


# on est sur master
git merge devel

git status

cat factorial.md

# je simule une modification sous éditeur
$SCRIPTS/do resolve-conflict

cat factorial.md

# pas de changement naturellement
git status

# maintenant on peut mettre 
# la résolution du conflit dans l'index
git add factorial.md

# plus de souci
git status

# et à présent on peut committer
git commit -m  'conflit résolu'

git l --all

git diff devel master

