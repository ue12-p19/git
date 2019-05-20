
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

# si nécessaire, vous pouvez remettre le repository en l'état
# 
# pour cela enlever les commentaires qui suivent et évaluer la cellule

# bash $TOPLEVEL/scripts/10-my-first-repo.sh >& /dev/null
# bash $TOPLEVEL/scripts/20-my-first-changes.sh >& /dev/null
# bash $TOPLEVEL/scripts/30-my-first-branch.sh >& /dev/null

# si nécessaire, on se place dans le repo git
[ -d my-first-repo ] && cd my-first-repo

pwd

# vous devez avoir deux branches, 6 commits dont un merge
# et être sur la branche master 
show-repo --all

show-repo

git checkout devel
git merge master

show-repo

# rappel
cat file1

# un changement qui
# ne sera pas conflictuel

echo 'pas de souci' >> file1

cat file2

# modifions une ligne dans file2

sed -i.patch -e 's|line2 of file2|DANS DEVEL|' file2

cat file1

cat file2

git add file1 file2
git commit -m 'pour conflit dans devel'

show-repo --all

# remettons-nous au commit précédent
git checkout master

# nous sommes sur devel
# modifions une ligne

sed -i.patch -e 's|line2 of file2|DANS MASTER|' file2

cat file2

git add file2
git commit -m'pour conflit dans master'

show-repo --all


# on est sur master
git merge devel

git status

cat file2

# je simule une modification sous éditeur
cat > file2 << EOF
line1 of file2
DANS MASTER et dans DEVEL
line3 of file2
EOF


# pas de changement naturellement
git status

# maintenant on peut mettre 
# la résolution du conflit dans l'index
git add file2

# plus de souci
git status

# et à présent on peut committer
git commit -m  'conflit résolu'

show-repo --all

git diff devel master

