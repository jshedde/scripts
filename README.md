scripts
=======

Usefull daily scripts...

# Installation

```
git clone --recursive https://github.com/jshedde/scripts
cd scripts
cp config.sh.dist config.sh
```
Editer config.sh (cf Features)

Puis lancer la commande : (attention cette commande modifie vos repo git)

```
bonjour-projects.sh
```

# Features

## Pre commit hook

Currently available
* PSR-2

To enable, uncomment :

```bash
#ENABLE_PRECOMMIT_HOOK=1
```

## Disable push to origin

Safety belt :)

To enable, uncomment :

```bash
#DISABLE_PUSH_ON_ORIGIN=1
```

## Add "upstream" remote repositories

Add a git remote named upstream branched to lafourchette repositories

To enable, uncomment :

```bash
#ENABLE_UPSTREAM=1
```

## Add personal remote repositories

Add a git remote repository named with your account login

Ex : jshedde => git@github.com/jshedde/myrepo.git


To enable, uncomment :

```bash
#ADD_REMOTE_FOR_CURRENT_USER=1
```

## Set remote origin to lafourchette repositories

To enable, uncomment :

```bash
#ENABLE_ORIGIN_LAFOURCHETTE=1
```
