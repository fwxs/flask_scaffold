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

		echo '
		if [[ ! -v VIRTUAL_ENV ]]; then
			source .venv/bin/activate
		fi
		' > .env;
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
}

function install_flask {
	echo -n "[*] Install flask (y/n): "
	read install

	case $install in
		y|Y)
			echo "[*] Installing flask, flask testing."
			pip install flask flask_testing

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
}

if [[ $# == 0 ]]; then
	usage 
	return 1 2> /dev/null || exit 1
fi

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