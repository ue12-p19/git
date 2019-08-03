
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

cd $TOP

# pour pouvoir recommencer le scénario depuis le début
# je nettoie complètement ce qu'on a pu faire précédemment
if [ -d repo-rebase ]; then
    echo "on repart d'un directory vide"
    rm -rf repo-rebase
fi

# on le crée
mkdir repo-rebase

# on va dedans
cd repo-rebase

$SCRIPTS/do rebase-init
$SCRIPTS/do rebase-master-branch
$SCRIPTS/do rebase-devel-branch

# rappel:
# git l = git log --oneline --graph
git l --all

git l

# récrire le dernier commit
git commit --amend --message C

git l

# le commit 'OOPS' est 
# toujours là quelque part
# mais on ne le parcourt pas
git l --all

# juste pour garder une référence
git branch old-devel devel

git l --all

# ça se lit comme ceci
# reconstruire la branche devel 
# au dessus de la branche master
git rebase master devel

git l --all

git checkout -b merging master
git merge old-devel --message F

git l --all

# pas de différence entre les deux contenus
git diff merging devel
