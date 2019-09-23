
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh  

# si nécessaire, vous pouvez remettre le repository 
# dans l'état où il est après le notebook 10-my-first-repo
# 
# pour cela mettez "true" au lieu de ""
# et bien sûr évaluer la cellule

reset=""

if [ -n "$reset" ]; then 
    cd $TOP
    bash $SCRIPTS/2-01-my-first-repo.sh 
fi >& /dev/null

# si nécessaire, on se place dans le dépôt git
[ -d my-first-repo ] && cd my-first-repo

pwd

# vous devez avoir 4 commits
git l

# souvenez-vous que HEAD^^ 
# désigne le commit
# qui est le grand-père de HEAD

git checkout -b devel HEAD^^

git l

# avec --all on demande à voir toutes les branches
git l --all

# quand on change de branche
# les fichiers sur le disque changent aussi !
ls

git l --all
