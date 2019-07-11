
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

cd $TOP

# on recommence un autre repo plus simple; à nouveau
# je nettoie complètement ce qu'on a pu faire précédemment
if [ -d repo-alice ]; then
    echo "on repart d'un directory vide"
    rm -rf repo-alice repo-cloned fake-github.git repo-bob
fi

# on le crée
mkdir repo-alice

# on va dedans
cd repo-alice

# si nécessaire, on se place dans le repo git
[ -d repo-alice ] && cd repo-alice

pwd

$SCRIPTS/do populate-repo-alice

git l

# vous devez avoir 2 commits
git l


# avec deux branches `master` et `devel`
# on est sur la branch devel
git branch

# on utilisera ce répertoire $TOP/repo-cloned
# pour simuler un deuxième repo
# 
# on verra plus tard qu'en pratique deux personnes
# qui travaillent ensemble passent par un troisième 
# repo sur github, mais pour l'instant on veut 
# seulement bien illustrer les fonctions `fetch` et `pull` 

if [ -d $TOP/repo-cloned ]; then
    rm -rf $TOP/repo-cloned
fi

cd $TOP

git clone repo-alice/.git repo-cloned

cd $TOP/repo-cloned

ls

git status

git l

cd $TOP/repo-alice
git l -1

cd $TOP/repo-cloned
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

cd $TOP/repo-alice

git l


$SCRIPTS/do first-commit-in-alice

git l

cd $TOP/repo-alice
git l

cd $TOP/repo-cloned
git l

# je retourne sur le clone
cd $TOP/repo-cloned

# on va chercher les commits nouveaux
# en faisant --all on va sur tous les remote connus
# ici on n'en a qu'un, c'est origin = initial
git fetch --all

# le repo initial

cd $TOP/repo-alice
git l

# le repo après fetch
cd $TOP/repo-cloned

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

cd $TOP
rm -rf repo-cloned fake-github.git
git clone --bare repo-alice fake-github.git

cd $TOP

# le contenu d'un repo bare
ls fake-github.git

# est proche du contenu d'un .git
# dans un repo 'normal'

ls repo-alice/.git

cd $TOP/repo-alice

$SCRIPTS/do commit-in-initial-for-simple-push

git l

cd $TOP/fake-github.git
git l

# on avait bien créé un remote plus haut mais
# c'était dans `repo-bob`

cd $TOP/repo-alice

# mais ici dans repo-alice on ne connait aucun remote
git remote

# il va donc nous falloir définir un remote à la main
# et cette fois plutôt que de l'appeler `origin` on va l'appeler `github` 
# ce sera beaucoup plus parlant pour nous

git remote add github $TOP/fake-github.git

git remote -v

# la situation dans initial
# on a 4 commits

cd $TOP/repo-alice

git l --all

# et dans le clone
# seulement 3 commits

cd $TOP/fake-github.git

git l --all

# on se met dans le repo initial

cd $TOP/repo-alice

# la syntaxe de push est voisine de celle de pull
# on pourrait faire simplement
#
# git push github devel


# cela dit je recommande par sécurité 
# d'éviter toute ambiüité 
# et de faire explicitement
#
git push github devel:devel

# ainsi après le push 
# les deux repos sont 
# en phase



cd $TOP/repo-alice
git l 

# remarque un peu digressive
# voyez que github
# ne connait aucun remote
# c'est bien le cas dans la vraie vie
# car ce n'est jamais github 
# qui pousse ou qui tire

cd $TOP/fake-github.git
git l 

# on repart d'un repo tout simple avec seulement deux commits 
# pour ne pas encombrer inutilement l'affichage

# on nettoie
cd $TOP
rm -rf repo-alice fake-github.git repo-bob

# recrée repo-alice avec deux commits
cd $TOP
mkdir repo-alice
cd repo-alice
$SCRIPTS/do populate-repo-alice > /dev/null

# on crée un repo bare qui remplace github
# pour faire le proxy entre les deux acteurs
cd $TOP
git clone --bare repo-alice fake-github.git

# on clone le faux github dans repo-bob
cd $TOP
git clone fake-github.git repo-bob

cd $TOP/repo-alice
git l

cd $TOP/fake-github.git
git l

cd $TOP/repo-bob
git l

# alice avance de son coté

cd $TOP/repo-alice
$SCRIPTS/do commit-alice

git l

# bob aussi

cd $TOP/repo-bob
$SCRIPTS/do commit-bob

git l

cd $TOP/repo-alice
git remote add github $TOP/fake-github.git
git remote

cd $TOP/repo-bob
git remote add github $TOP/fake-github.git
git remote

cd $TOP/repo-alice

git push github devel:devel 

git l

cd $TOP/fake-github.git
git l

# si bob essaie de pousser à ce stade, c'est refusé
# car le merge, qui n'est pas fast-forward, impliquerait
# la création d'un nouveau commit, ce qui
# est risqué à distance 
#
# notez bien qu'ici les deux modifications de alice et bob
# sont indépendantes et peuvent être mergées sans conflit !

cd $TOP/repo-bob
git push github devel

# pour s'en sortir il suffit que Bob commence par tirer
# et c'est en tirant qu'on va créer le commit qui merge les deux travaux
# 
# pour des raisons sordides liées au fait qu'on est dans un notebook
# je lui passe l'option --no-edit

cd $TOP/repo-bob
git pull --no-edit github devel 

git l

cd $TOP/repo-bob
git push github devel


git l

# et alice peut tirer
cd $TOP/repo-alice
git pull github devel

git l
