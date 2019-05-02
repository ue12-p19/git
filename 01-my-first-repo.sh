
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh; standard-start

git version

# je détruis
rm -rf my-first-repo

# on le crée, vide
mkdir my-first-repo

# on va dedans
cd my-first-repo

ls -a

git init

ls -aF

# malgré la présence de ce directory .git
# si on demande la liste des fichiers 'normaux' 
# on voit un répertoire vide
ls

git log

cat > README.md << EOF
# lisez-moi

Ce répository sert à ilustrer 
notre cours sur **git**
EOF

# voyons ce fichier
cat README.md

git add README.md

git commit -m 'mon premier commit'

git log

git log --oneline

# lorsque le fichier ne fait qu'une seule ligne, pas besoin de EOF
echo 'Licence Creative Commons BY-NC-ND 4.0' > LICENSE

# voici le contenu du fichier LICENSE
cat LICENSE

# comme on veut que ce nouveau fichier 
# fasse partie du deuxième commit, on l'ajoute
git add LICENSE

# voilà ce que nous montre alors "git status"
git status

# maintenant je corrige la faute d'orthographe
sed -i -e s,ilustrer,illustrer, README.md
rm -f README.md-e

# voici maintenant git status
# remarquez la différence entre 
# ce qui est en vert et ce qui est en rouge
# nous y reviendrons
git status

# dans l'immédiat je veux ajouter le changement lié à l'orthographe
# dans le prochain commit

git diff README.md

# c'est bien ce que je voulais faire
git add README.md

# regardons à nouveau git status
# tout ce qui est en vert sera dans le prochain commit
git status

# tous les changements montrés EN VERT vont faire partie du prochain commit
git commit -m "nouveau fichier LICENSE, une correction dans README.md"

git log

# le format par défaut de git log est vite encombrant, si on veut condenser
git log --oneline

# pour éviter de retaper cette phrase un peu longue
# j'en profite pour ajouter l'option --graph qui est utile 
# lorsque les dépendances deviennent moins simples
function show-repo() { git log --oneline --graph; }

show-repo

# pour voir la documentation complète
# de git log (attention très très long !)
# enlever le commentaire en début de ligne:

# git log --help

git status

# on crée trois fichiers; les détails importent peu
../scripts/populate create-three-files

# leur contenu
cat file1    

cat file2  

cat file3

git ls-files

ls -1F

git add file1 file2
git commit -m "deux fichiers de plus"

show-repo

sed -i -e s',line2 of file1,line2 modified in file1,' file1
rm file1-e

# ici git status me montre que j'ai 
# (*) le fichier file1 modifié 
# (*) le fichier file3 qui n'est pas dans le repo
git status

# si j'ajoute les deux fichiers file1 et file3
# je prépare un commit qui contient 
# tout ce qu'il y a dans mon répertoire de travail
git add file1 file3

# du coup tout est en vert
git status

git commit -m "quatrième commit, avec 5 fichiers"

show-repo

git log --oneline HEAD^

git log --oneline HEAD^^

# du coup je peux améliorer un peu mon raccourci
# avec cette incantation un peu magique, je passe à git log
# les mêmes paramètres que je reçois de show-repo
function show-repo() { git log --oneline --graph "$@"; }

show-repo HEAD^^^

# d'une part, les fichiers présents dans le répertoire de travail
ls -l

# et d'autre part, le contenu des commits
git ls-tree HEAD

# ainsi je peux regarder le contenu d'un commit précédent
git ls-tree HEAD~3
