
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
    bash $SCRIPTS/2-03-my-first-merge.sh
    bash $SCRIPTS/2-04-kinds-of-merge.sh
fi >& /dev/null

# si nécessaire, on se place dans le dépôt git
[ -d my-first-repo ] && cd my-first-repo

pwd

# ceci compte les commits
# vous devez en avoir 9 
git log --oneline | wc -l


# le dernier s'appelle 'conflit résolu'
git log -1 --format="%s"

# et la branche courante est master
git branch

# le point de départ 
# par défaut est HEAD

git l

# si je donne un point de départ

git l devel

# en partant d'un commit précis

git l HEAD~2

git l

# je fais comme si je notais le sha-1
# du sommet sur un bout de papier

ghost=$(git log -1 --format='%h')
echo $ghost

# la branche courante est master
# on la fait reculer d'un cran
git reset --hard HEAD^

# si je regarde master, je ne vois plus devel
git l

# si je regarde les branches connues
# je ne vois plus le merge 'conflit résolu'
git l --all

# en précisant le hash
# je peux toujours accéder au
# commit 'conflit résolu'
git l $ghost

# on est toujours dans master
git branch

git merge $ghost

git l

# git branch, sans option
# montre la liste des branches
# la branche courante est mise en relief

git branch

# git log -1 : pour ne voir que un commit
git log --oneline -1 HEAD

git l --all

# pour juste créer une branche (sans y aller)
# donner simplement un nom et un commit

git branch foobar HEAD~2

git l --all

# pour renommer une branche 
# (même la branche courante d'ailleurs)

git branch -m foobar trucmuche

git l --all

# pour détruire une branche

git branch -d trucmuche

git l --all


# je mets un signet
git branch bookmark HEAD

# maintenant si je reset master
git reset --hard HEAD^

git l --all

git branch -d bookmark

# avec -D on force la destruction
git branch -D bookmark

# le commit est bien sûr toujours là
git merge $ghost

git l

git l --all
