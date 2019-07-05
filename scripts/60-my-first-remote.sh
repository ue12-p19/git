
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

cd $TOPLEVEL

# on recommence un autre repo plus simple; à nouveau
# je nettoie complètement ce qu'on a pu faire précédemment
if [ -d initial-repo ]; then
    echo "on repart d'un directory vide"
    rm -rf initial-repo
fi

# on le crée
mkdir initial-repo

# on va dedans
cd initial-repo

# si nécessaire, on se place dans le repo git
[ -d initial-repo ] && cd initial-repo

pwd

$SCRIPTS/do populate-initial-repo

git l

# vous devez avoir 2 commits
git l


# avec deux branches `master` et `devel`
# on est sur la branch devel
git branch

# on utilisera ce répertoire $TOPLEVEL/cloned-repo
# pour héberger un repo avatar de ce qu'on 
# pourrait mettre sur github

if [ -d $TOPLEVEL/cloned-repo ]; then
    rm -rf $TOPLEVEL/cloned-repo
fi

cd $TOPLEVEL

git clone initial-repo/.git cloned-repo

cd $TOPLEVEL/cloned-repo

ls

git status

git l

cd $TOPLEVEL/initial-repo
git l -1

cd $TOPLEVEL/cloned-repo
git l -1

# nous sommes dans le clone
pwd

# pour lister les remotes connus
git remote

# en version bavarde on voit à quoi correspond le remote 
git remote -v

# depuis le clone, on voit un nouveau type 
# de référence, comme par exemple origin/master

git l --all

cd $TOPLEVEL/initial-repo

git l


$SCRIPTS/do first-commit-in-initial

git l

cd $TOPLEVEL/initial-repo
git l

cd $TOPLEVEL/cloned-repo
git l

# je retourne sur le clone
cd $TOPLEVEL/cloned-repo

# on va chercher les commits nouveaux
# en faisant --all on va sur tous les remote connus
# ici on n'en a qu'un, c'est origin = initial
git fetch --all

# le repo initial

cd $TOPLEVEL/initial-repo
git l

# le repo après fetch
cd $TOPLEVEL/cloned-repo

# si je ne précise pas --all
# on part comme toujours de HEAD
git l 

# mais si j'ajoute --all:

git l --all

git merge origin/devel

git l

# git config permet de lire
# un attribut dans la config

# ceci est le défaut pour le
# premier argument à git pull
git config branch.devel.remote

# pareil pour le deuxième argument

git config branch.devel.merge

cd $TOPLEVEL/initial-repo

$SCRIPTS/do commit-in-initial-for-simple-push

git l

# ce qui fait que du coté de `initial-repo`
# on ne connait aucun remote
git remote

# il va donc nous falloir définir un remote à la main
# et cette fois plutôt que de l'appeler `origin` on va l'appeler `cloned` 
# ce sera beaucoup plus parlant pour nous

git remote add cloned $TOPLEVEL/cloned-repo/.git

git remote

# la situation dans initial
# on a 4 commits

cd $TOPLEVEL/initial-repo

git l --all

# et dans le clone
# seulement 3 commits

cd $TOPLEVEL/cloned-repo
git l --all

# on se met dans le repo initial

cd $TOPLEVEL/initial-repo

# xxx ça ne fonctionne pas comme scénario car
# le remote ici n'est pas un bare repo
# et pour pousser ça devient scabreux

git push cloned devel


