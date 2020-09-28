#!/bin/bash

# AUTHOR fwxs
# VERSION 1.1

function set_venv {
	echo "[*] Setting up the virtual environment."
	python -c 'import venv'

	if [[ $? != 0 ]]; then
		echo "[!] Venv is not installed... Installing."
		pip install venv;
	else
		python -m venv .venv
		touch .env

		echo "
if [[ ! -v VIRTUAL_ENV ]]; then
	FLASK_ENV='development'
	FLASK_APP=''
	source .venv/bin/activate
fi" > .env;
		cp .env .env.example
	fi
}

function update_pip {
	echo "[*] Updating pip."
	pip install --upgrade pip
}

function activate_source {
	echo "[*] Changing source."
	source .venv/bin/activate
}

function set_flask_application_factory_scaffold {
	dirs=("app" "app/main" "app/main/model" "app/main/controller" "app/main/service" "test")

	echo "[*] Creating a flask functional environment."
	mkdir -p "${dirs[@]}"

	for directory in "${dirs[@]}"; do
		pushd $directory > /dev/null
		touch __init__.py
		popd > /dev/null
	done

	sed -i -e s'/FLASK_APP=""/FLASK_APP="app:create_app"/' .env
}

function install_flask {
	echo -n "[*] Install flask (y/n): "
	read install

	case $install in
		y|Y)
			packages=("flask" "flask_testing" "python-dotenv")
			echo "[*] Installing $packages"
			pip install "${packages[@]}"

			echo "[*] Set application factory structure? (y/n)"
			read setAppFactory

			case $setAppFactory in
				y|Y)
					set_flask_application_factory_scaffold
					;;
				*)
					;;
			esac
			;;
		*)
			;;
	esac
}

function dump_requirements {
	echo "[*] Dumping requirements.txt"
	pip freeze > requirements.txt
}

function usage {
	echo "${0##*/} <dir name>"
}

function init_repo {
	git init .
	touch README.md

	echo "__pycache__/" > .gitignore
	echo ".venv/" >> .gitignore
	echo ".env" >> .gitignore
}

function set_flask_environment {
	echo "[*] Creating env in $1"
	mkdir $1
	cd $1

	set_venv
	activate_source
	update_pip
	install_flask
	dump_requirements

	echo "[*] Initialize repository? (y/n)"
	read initRepo

	case $initRepo in
		y|Y)
			init_repo
			;;
		*)
			;;
	esac

	cd ..
}

if [[ $# == 0 ]]; then
	usage 
	return 1 2> /dev/null || exit 1
fi

set_flask_environment $1
