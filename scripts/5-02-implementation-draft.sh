
# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh

cd $TOP/repo-alice
pwd

git show-ref --hash --head HEAD

git log -1 --pretty='%h'

git log -1 --pretty='%H'

# on calcule le SHA-1 du commit courant
commit_hash=$(git log -1 --pretty='%h')

# il est dans la variable bash 'commit_hash' 
# qu'on peut référencer avec '$commit_hash'

echo $commit_hash

# le contenu typique d'un objet de type 'commit'

git cat-file -p $commit_hash

git cat-file -p $commit_hash | git hash-object -t commit --stdin

# le SHA-1 de l'objet git représentant le contenu du directory est

directory_hash=$(git cat-file -p $commit_hash | grep '^tree ' | cut -d' ' -f2)

echo $directory_hash

# le contenu typiquement d'un objet de type 'tree'
# correspondant à un répertoire

git cat-file -p $directory_hash

file_hash=$(git cat-file -p $directory_hash | head -1 | awk '{print $3;}')
echo $file_hash

#dir_part=$(cut -c 1-2 <<< $file_hash)
#file_part=$(cut -c 3- <<< $file_hash)
dir_part=${file_hash:0:2}
file_part=${file_hash:2:38}

echo dir=$dir_part
echo file=$file_part

echo .git/objects/$dir_part/$file_part

ls -l .git/objects/$dir_part/$file_part

# OOPS can't use cat directly
cat .git/objects/$dir_part/$file_part
