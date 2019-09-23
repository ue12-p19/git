
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

# on repart d'un dépôt tout simple 
# avec seulement deux commits 
# pour ne pas encombrer inutilement l'affichage

# on nettoie
cd $TOP
rm -rf repo-alice fake-github.git repo-bob

# on recrée repo-alice avec deux commits
cd $TOP
mkdir repo-alice
cd repo-alice
$SCRIPTS/do populate-repo-alice > /dev/null

# on crée un dépôt bare qui remplace github
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

# dans repo-alice on ne connait aucun remote
# on en crée un qui s'appelle github

cd $TOP/repo-alice
git remote add github $TOP/fake-github.git
git remote

# on a déjà un remote 'origin' lié au clone initial
# mais on l'ignore et on crée un second remote
# pour homogénéité entre les deux repos d'alice et de bob 

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

git l --all
