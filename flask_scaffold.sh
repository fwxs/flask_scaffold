#!/bin/bash

# AUTHOR fwxs
# VERSION 1.0 

echo "[*] Setting up a virtual environment."
python -c 'import venv'

if [[ $? != 0 ]]; then
	echo "[!] Venv is not installed... Installing."
	pip install venv;
else
	python -m venv .venv
	touch .env

	echo '
	if [[ ! -v VIRTUAL_ENV ]]; then
		source .venv/bin/activate
	fi
	' > .env;
fi

echo "[*] Changing source."
source .venv/bin/activate

echo "[*] Updating pip."
pip install --upgrade pip

echo -n "[*] Install flask (y/n): "
read installFlask

case $installFlask in
	y|Y)
		echo "[*] Installing flask, flask testing and flask-restplus."
		pip install flask flask_testing flask-restplus

		echo -n "[*] Install optional libraries (Migrate, pyjwt, bcrypt, Script, SQLAlchemy) (y/n): "
		read optionalLibraries

		case $optionalLibraries in
			y|Y)
				echo "[*] Installing optional libraries."
				pip install flask-bcrypt Flask-Migrate Flask-Script pyjwt Flask-SQLAlchemy
				;;
			*)
				;;
		esac
		;;
	*)
		;;
esac


echo "[*] Creating a flask functional environment."
mkdir -p app/main app/main/model app/main/controller app/main/service app/test

echo "[*] Creating __init__.py files"
touch app/__init__.py
touch app/main/__init__.py
touch app/main/model/__init__.py
touch app/main/controller/__init__.py
touch app/main/service/__init__.py
touch app/test/__init__.py

echo "[*] Dumping requirements.txt"
pip freeze > requirements.txt


echo "[*] Directory structure."
ls -R


