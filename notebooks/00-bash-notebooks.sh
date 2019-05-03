
# ceci ne va pas marcher
print("je ne parle pas le Python") 

# à la place il faut faire
echo "je ne parle pas le Python, je parle le bash"

pwd

# ce sera toujours notre façon de commencer
[ -f scripts/helpers.sh ] && source scripts/helpers.sh; standard-start

# ces deux réglages pour git sont nécessaires
# 
# ça se lit comme ceci: si user.name est indéfini, alors on lui donne la chaine "Jeanne Durand"
git config user.name  || git config --global user.name "Jeanne Durand"
git config user.email || git config --global user.email "jeanne.durand@example.org"
