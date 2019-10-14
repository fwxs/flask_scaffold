# flask_scaffold
Create a functional flask project structure

## Usage

```
$ ./flask_scaffold
[*] Setting up a virtual environment.
[*] Changing source.
[*] Updating pip.
[*] Install flask (y/n): y
[*] Installing flask, flask testing and flask-restplus.
[*] Install optional libraries (Migrate, pyjwt, bcrypt, Script, SQLAlchemy) (y/n): y
[*] Installing optional libraries.
[*] Creating a flask functional environment.
[*] Creating __init__.py files
[*] Dumping requirements.txt
[*] Directory structure.

.:
app requirements.txt

./app:
__init__.py  main  test

./app/main:
__init__.py  controller  model  service

./app/main/controller:
__init__.py

./app/main/model:
__init__.py

./app/main/service:
__init__.py

./app/test:
__init__.py
```
