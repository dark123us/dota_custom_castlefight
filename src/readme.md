Документация
============

https://castlefight-doc.readthedocs.io/en/latest/index.html

https://dark123us.github.io/castlefight-doc/index.html

Клонирование
============

```
git clone --recurse-submodules ssh://git@github.com/dark123us/castlefight CastleFight
cd CastleFight
```

Подгрузить сабмодули
```
git submodule update --init --recursive
```


Использование git-repositories
==============================

склонировать проект, перейти в свою ветку к примеру создав ее:
```
git checkout -b dark123us
git push --set-upstream origin dark123us
```
или перейдя в нее
```
git checkout dark123us
```
далее работаем, добавляем изменения, проверяем, что попало в изменения, фиксируем изменения, заливаем
```
git add .
git status
git commit -m "что-то на изменял ссылка на #таск_в_redmine"
git push
```

если необходимо забрать изменения из master или develop веток - фиксируем изменения и сливаем данные
```
git add .
git status
git commit -m "fix before merge"
git pull --all
git merge master
```

Git дополнительные возможности
------------------------------

ведение двух источников

проверяем куда нацелен сонфиг
```
$ git remote -v
origin  ssh://git@github.com/dark123us/castlefight (fetch)
origin  ssh://git@github.com/dark123us/castlefight (push)
```
Добавляем направление и проверяем
```
$ git remote set-url --add origin ssh://git@r.bysel.by:5005/castle-fight-evolution/castlefight.git
$ git remote -v
origin  ssh://git@github.com/dark123us/castlefight (fetch)
origin  ssh://git@github.com/dark123us/castlefight (push)
origin  ssh://git@r.bysel.by:5005/castle-fight-evolution/castlefight.git (push)
```

Слияение изменений

Создаем ветку, сливаем с интересующей нас веткой

```
$ git checkout -b tmp
Switched to a new branch 'tmp'

$ git merge origin/map_and_design --squash
Auto-merging deploy/run-tools.bat
CONFLICT (content): Merge conflict in deploy/run-tools.bat
Removing deploy/pathgit.env.sample
Removing deploy/pathgame.env.sample
Removing deploy/namecustom.env.sample
Auto-merging deploy/links_restore.bat
CONFLICT (content): Merge conflict in deploy/links_restore.bat
Squash commit -- not updating HEAD
Automatic merge failed; fix conflicts and then commit the result.
```
Проверяем конфликты, проверяем файлы, коммитим, переходим в свою ветку и сливаемся с временной веткой, затем удаляем временную ветку

```
$ git add .
$ git status
$ git checkout dark123us
Switched to branch 'dark123us'
Your branch is up to date with 'origin/dark123us'.

$ git merge tmp
Updating f8a2113..4188e51
Fast-forward
 deploy/links_restore.bat                           |   6 ++++--
 deploy/pathgit.env.sample                          |   2 +-
 deploy/run-tools.bat                               |   5 ++---
 src/content/maps/catle_story_0.1.vmap              | Bin 8974203 -> 9039161 bytes
 .../materials/overviews/catle_story_0.1.tga        | Bin 0 -> 786450 bytes
 .../materials/overviews/catle_story_0.1.txt        |   8 ++++++++
 .../materials/overviews/catle_story_0.1.vmat       |   6 ++++++
 7 files changed, 21 insertions(+), 6 deletions(-)
 create mode 100644 src/content/materials/overviews/catle_story_0.1.tga
 create mode 100644 src/content/materials/overviews/catle_story_0.1.txt
 create mode 100644 src/content/materials/overviews/catle_story_0.1.vmat

```

