
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

# en particulier pour savoir la version de `git` qui est installée
git version

cd $TOP

# pour pouvoir recommencer le scénario depuis le début
# je nettoie complètement ce qu'on a pu faire précédemment
if [ -d my-first-repo ]; then
    echo "on repart d'un directory vide"
    rm -rf my-first-repo
fi

# on le crée
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

# git log se plaint, c'est normal 
# car on n'a encore créé aucun commit
git log

# là je triche, je crée README.md par script 
# imaginez que j'ai utilisé un éditeur de texte
$SCRIPTS/do create-readme

# voyons ce fichier
cat README.md

# on a pour l'instant une différence 
# entre l'espace de travail et l'index: en rouge
git status

git add README.md

# notre différence est maintenant montrée en vert
git status

git commit -m 'my first commit: added README.md'

# pour l'instant on n'en a qu'un
git log

# il n'y a plus de changement dans l'index
git status

git log   

# on reparlera de git log tout à l'heure
git log --oneline

# lorsque le fichier ne fait qu'une seule ligne, pas besoin de EOF
$SCRIPTS/do create-license

# voici le contenu du fichier LICENSE
cat LICENSE

# comme on veut que ce nouveau fichier 
# fasse partie du deuxième commit, on l'ajoute
git add LICENSE

# voilà ce que nous montre alors "git status"
git status

# maintenant je corrige la faute d'orthographe

# de nouveau, normalement on fait ça avec un éditeur
# ici j'utilise un outil en ligne de commande, peu importe...
$SCRIPTS/do fix-readme 

# voici maintenant git status
# remarquez ce qui est en vert et ce qui est en rouge
# qui correspond aux deux étages
git status

git diff

# c'est bien ce que je voulais faire
# donc je peux ajouter tout le fichier 
git add README.md

# regardons à nouveau git status
# tout ce qui est en vert sera dans le prochain commit
git status

# tous les changements montrés EN VERT vont faire partie du prochain commit
git commit -m "added LICENSE, changed README.md"

git log

# le format par défaut de git log est vite encombrant, si on veut condenser
git log --oneline

git log --oneline --graph

# on peut facilement se définir des raccourcis
git config --global alias.l "log --oneline --graph"

# du coup c'est plus rapide
git l

# pour voir la documentation complète
# de git log (attention très très long !)
# enlever le commentaire en début de ligne:

# git log --help

git l

git status

# on crée deux fichiers; les détails importent peu
$SCRIPTS/do create-code

$SCRIPTS/do create-doc

# leur contenu
cat factorial.py    

cat factorial.md

# les fichiers dans le commit courant 
# (en fait dans l'index mais ici c'est pareil)
git ls-files

# sur le disque
ls -1

# un changement dans README.md
echo 'commit #3' >> README.md

git status

# je prépare le commit 
git add README.md factorial.py 

# je fais le commit
git commit -m "new code file, tweak README"

git l

# un changement dans README.md
echo 'commit #4' >> README.md

# ici git status me montre que j'ai 
# (*) le fichier README.md modifié 
# (*) le fichier file2 qui n'est pas dans le repo
git status

# si j'ajoute les deux fichiers file1 et file3
# je prépare un commit qui contient 
# tout ce qu'il y a dans mon répertoire de travail
git add README.md factorial.md

# du coup tout est en vert
git status

git commit -m "adding markdown, we now have 4 files"

git l

ls -l

git ls-tree HEAD

# par exemple si je parcours les commits en partant de HEAD
# j'en vois donc 4
git l HEAD

# si je pars de HEAD^, je n'en plus que 3
git l HEAD^

# et ainsi de suite
git log --oneline HEAD^^
