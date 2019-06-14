
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
    bash $SCRIPTS/30-my-first-branch.sh
    bash $SCRIPTS/40-kinds-of-merge.sh
fi >& /dev/null

# si nécessaire, on se place dans le repo git
[ -d my-first-repo ] && cd my-first-repo

pwd

# vous devez avoir 9 commits
git log --oneline | wc -l


# le dernier s'appelle 'conflit résolu'
git log -1 --format="%s"

# et la branche courante est master
git branch

if [ -d $TOPLEVEL/fake-github ]; then
    rm -rf $TOPLEVEL/fake-github
fi

cd $TOPLEVEL
git clone my-first-repo/.git fake-github


cd $TOPLEVEL/fake-github

ls

git l

cd $TOPLEVEL
git clone https://github.com/parmentelat/nbautoeval
