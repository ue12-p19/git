
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

# si nécessaire, vous pouvez remettre le repository en l'état
# 
# pour cela mettez "true" au lieu de ""
# et bien sûr évaluer la cellule

reset=""

if [ -n "$reset" ]; then 
    cd $TOP
    bash $SCRIPTS/3-01-my-first-remote.sh
fi >& /dev/null

# si nécessaire, on se place dans le dépôt git
[ -d repo-alice ] && cd repo-alice

pwd

# nous sommes dans 'repo-alice' qui a 4 commits

git l

# et pour être sûr on vérifie aussi 
# qu'il n'y a pas de différence entre
# le commit et les fichiers
# on doit voir 'working tree clean'

git status

# je crée le clone

cd $TOP
rm -rf repo-upstream
git clone repo-alice repo-upstream
cd repo-upstream
git l

# je change le début du fichier python


$SCRIPTS/do change-factorial-py-beginning

git diff

# je crée le commit correspondant

git add factorial.py
git commit -m "modif début de factorial.py depuis upstream"

cd $TOP/repo-alice
$SCRIPTS/do change-factorial-py-end
git diff

cd $TOP/repo-alice
git pull ../repo-upstream

cd $TOP/repo-alice
git diff

# dans un premier temps on range nos modifications courantes
# dans un objet de type stash

# on lui donne un message pour le retrouver
# car on peut créer autant de stashes que l'on veut
git stash push -m"change circa the end of factorial.py"

# le point c'est que maintenant notre dépôt est propre
git status

# si on veut on peut lister les stashes 

git stash list

# comme le repo est propre maintenant
# on peut tirer sans souci

git pull ../repo-upstream

# et pour remettre les changements locaux
# dans nos fichiers, on applique le stash 
# avec la commande `git stash pop`
git stash pop 'stash@{0}'

# on est bien dans l'état où on voulait être
# le commit de upstream a été tiré
# et on a préservé la modification locale 
git l

git diff
