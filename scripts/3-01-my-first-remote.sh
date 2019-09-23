
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

cd $TOP

# on recommence un autre dépôt plus simple; à nouveau
# je nettoie complètement ce qu'on a pu faire précédemment
if [ -d repo-alice ]; then
    echo "on repart d'un directory vide"
    rm -rf repo-alice repo-cloned fake-github.git repo-bob
fi

# on le crée
mkdir repo-alice

# on se place dans ce répertoire dépôt git
cd $TOP/repo-alice

pwd 

# on remplit un peu avec deux commits
$SCRIPTS/do populate-repo-alice

# vous devez avoir 2 commits
git l


# avec deux branches `master` et `devel`
# on est sur la branch devel
git branch

# on utilisera ce répertoire $TOP/repo-cloned
# pour simuler un deuxième dépôt
# pour l'instant on le supprime
# 
if [ -d $TOP/repo-cloned ]; then
    rm -rf $TOP/repo-cloned
fi

cd $TOP

# idem, en pratique on peut remplacer 'repo-alice'
# par une URL sur github

git clone repo-alice repo-cloned

cd $TOP/repo-alice
git l
echo ============
ls

cd $TOP/repo-cloned
git l
echo ============
ls

# le clone est 'propre', 
# aucun changement pendant
git status

# on se trouve sur le même commit
# que repo-alice
git l

cd $TOP/repo-alice
git l -1

cd $TOP/repo-cloned
git l -1

# nous sommes dans le clone
pwd

# pour lister les remotes connus
git remote

# pour savoir à quoi - à quelle URL - correspond le remote

git config remote.origin.url

# depuis le clone, 
pwd

# on voit un nouveau type de référence
# comme par exemple origin/master
git l --all

cd $TOP/repo-alice
$SCRIPTS/do first-commit-in-alice

# on a maintenant un commit de plus du coté d'alice
git l

# résumons l'état des deux cotés 
# à ce stade
# avant de faire le fetch

# 3 commits chez alice
cd $TOP/repo-alice
git l

# repo-cloned n'a aucune
# idée à ce stade qu'il y a 
# du nouveau chez alice

# 2 commits dans le clone
cd $TOP/repo-cloned
git l

# toujours sur le clone
cd $TOP/repo-cloned

# on va chercher avec fetch les commits nouveaux
# si on voulait on pourrait faire 
# git fetch origin

# mais en faisant --all on va sur tous les remote connus
# c'est l'utilisation habituelle 
# de toutes façons ici on n'en a qu'un
# c'est origin = repo-alice
# donc les deux formes reviennent au même

git fetch --all

# le dépôt initial

# on a toujours 3 commits bien sûr
cd $TOP/repo-alice
git l

# le clone après fetch
cd $TOP/repo-cloned

# je précise bien --all
# car sinon je ne verrais que les commits
# atteignables depuis la branche courante 'devel'

# on voit maintenant 3 commits
git l --all

# la branche courante est devel

git merge origin/devel

# maintenant repo-cloned est parfaitement à jour 
# avec repo-alice
git l

cd $TOP
rm -rf repo-cloned fake-github.git

# avec l'option --bare on crée un dépôt bare
# comme il le serait sur github
git clone --bare repo-alice fake-github.git

cd $TOP

# le contenu d'un dépôt bare
ls fake-github.git

# est proche du contenu d'un .git
# dans un dépôt 'normal'

ls repo-alice/.git

# créons un commit chez alice

cd $TOP/repo-alice

$SCRIPTS/do commit-in-initial-for-simple-push

git l

# sur le clone bien sûr 
# le nouveau commit est absent

cd $TOP/fake-github.git

git l

cd $TOP/repo-alice

# on avait bien un remote dans le scénario précédent
# mais c'était dans repo-cloned 
# le remote avait alors été créé par 'git clone' 
# 
# ici dans repo-alice on ne connait aucun remote
 
git remote

# il va donc nous falloir définir un remote à la main
# et cette fois plutôt que de l'appeler `origin` on va l'appeler `github` 
# ce sera beaucoup plus parlant pour nous

git remote add github $TOP/fake-github.git

# maintenant on connait un remote
git remote

# qui est un raccourci pour désigner le dépôt qui se situe ici
git config remote.github.url

# la situation dans initial
# on a 4 commits

cd $TOP/repo-alice

git l --all

# et dans le clone
# seulement 3 commits

cd $TOP/fake-github.git

git l --all

# on se met dans le dépôt initial

cd $TOP/repo-alice

# la syntaxe de push est voisine de celle de pull
# on pourrait faire simplement
#
# git push github devel


# cela dit je recommande par sécurité 
# et pour éviter toute ambigüité 
# de faire explicitement
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
