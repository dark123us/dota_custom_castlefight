LUA ?= lua
LUACOV ?= luacov
CUR = $(pwd)

help:
	@echo "use make [COMMAND]"
	@echo "	where COMMAND is"
	@echo "	submodules_dev - load submodules in dev mode"
	@echo "	submodules_update - load submodules"

coverage:
	@$(LUACOV)
	@cat luacov.report.out

test: 
	$(LUA) test/init.lua

submodules_update:
	@git submodule init
	@git submodule update

submodules_dev:
	@cd src/game/scripts/vscripts/lib
	@git clone ssh://git@github.com/dark123us/dota-ecs
	@git clone ssh://git@github.com/dark123us/dota-lua-debug
	@git submodule update
	@cd $CUR

.PHONY: help submodules_update submodules_dev
