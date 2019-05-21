
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

# si nécessaire, vous pouvez remettre le repository en l'état
# 
# pour cela mettez "true" au lieu de ""
# et bien sûr évaluer la cellule

reset=""

if [ -n "$reset" ]; then 
    bash $TOPLEVEL/scripts/10-my-first-repo.sh
    bash $TOPLEVEL/scripts/20-my-first-changes.sh
    bash $TOPLEVEL/scripts/30-my-first-branch.sh
    bash $TOPLEVEL/scripts/40-kinds-of-merge.sh
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
