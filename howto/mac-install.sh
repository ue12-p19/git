#!/usr/bin/env bash

set -e
set -u

UNAME=$(uname)
BREW=(python3)
REPO="git@github.com:flotpython/gittutorial.git"
LOCAL="$HOME/gittutorial"

# Wraps everything to delay execution, useful when run from curl...
main() {
  if [ "$UNAME" != "Darwin" ]; then
      echo "Oups, not a Mac ? 😭😡☠️"
      echo "Aborting..."
      exit 1
  fi

  # BANNER
  echo -e "\033[34m"
  echo "  ____ ___ _____ "
  echo " / ___|_ _|_   _|"
  echo "| |  _ | |  | |  "
  echo "| |_| || |  | |  "
  echo " \____|___| |_|  "
  echo -e "\033[0m"
  echo
  echo -e "Ce script va installer les dépendences nécessaires pour le cours \033[31mgit\033[0m:"
  echo " • Homebrew (gestionnaire de packet pour Mac)"
  echo " • Python (3.x)"
  echo " • NumPy & Jupyter"
  echo " • cloner le cours localement"
  echo
  read -p "Continuer? (o/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Oo]$ ]]; then
    echo "Annulé" 
    exit 0 # quitte tout
  else
    echo
  fi


  trap "echo;echo '☠️ ☠️  Installation annulée. ☠️ ☠️ '" EXIT
  install_mac
  trap - EXIT

  echo -e "\033[32m"
  echo "BRAVO: vous pouvez désormais ouvrir les notebooks:"
  echo
  echo "    $ cd $LOCAL/notebooks"
  echo "    $ jupyter notebook"
  echo
  echo -e "🎉 🎉  Installation terminée 🎉 🎉 \033[0m"

}

install_mac() {
  say "Recherche des outils de build"
  if [ "$(xcode-select -p)ok" == "ok" ]; then
      ko
      echo -e "Installation des outils de compilation (\033[31mmdp requis\033[0m):"
      xcode-select --install
  fi
  ok

  say "Recherche de Homebrew"
  if ! command -v brew >>/dev/null 2>&1; then
    ko 
    echo -e "Installation de Homebrew (\033[31mmdp requis\033[0m):"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  ok

  say "Recherche de Python 3.x"
  if ! command -v python3 >>/dev/null 2>&1; then
    ko
    say "Installation de Python 3.x via Homebrew"
    brew install python3 >>/dev/null 2>&1
  fi
  ok

  say "Recherche de pip"
  if ! command -v pip3 >>/dev/null 2>&1; then
    ko
    say "Installation de pip via easy_install"
    easy_install --user pip >>/dev/null 2>&1
  fi
  ok
  say "Mise à jour de pip"
  pip3 install --upgrade pip >>/dev/null 2>&1
  printf " " && ok

  say "Installation de Numpy et Jupyter"
  pip3 install numpy jupyter >>/dev/null 2>&1
  ok

  say "Installation du kernel \"Calysto Bash\""
  pip3 install calysto_bash >>/dev/null 2>&1
  python -m calysto_bash install >>/dev/null 2>&1
  if ! jupyter kernelspec list | grep "calysto_bash" >>/dev/null; then
    ko
    echo
    echo -e "\033[31mImpossible d'installer le kernel calysto_bash pour Jupyter !\033[0m"
    exit 1
  fi
  ok

  say "Vérification de la copie locale"
  if [ ! -d "$LOCAL" ];then 
    printf " " && ko
    say "Clonage du dépôt vers ~/gittutorial"
    git clone --recursive "$REPO" "$LOCAL" >>/dev/null 2>&1
  fi
  printf " " && ok
}


say() {
  printf "%-74s" "$1"
}
ok() {
  echo -e "[\033[32mOK\033[0m]"
}
ko() {
  echo -e "[\033[31mKO\033[0m]"
}

main