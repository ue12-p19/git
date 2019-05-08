
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh; standard-start

# si nécessaire, vous pouvez remettre le repository 
# dans l'état où il est après le notebook 01
# 
# pour cela enlever le premier caractère '#' 
# et évaluer la cellule

# bash 20-my-first-repo.sh >& /dev/null

# si nécessaire, on se place dans le repo git
[ -d my-first-repo ] && cd my-first-repo

pwd

# vous devez avoir 4 commits
show-repo

git checkout -b devel HEAD^^

show-repo

ls

show-repo --all





git ls-tree HEAD

ls ../../figures

%%html
<img src="figures/notebook1.svg">


