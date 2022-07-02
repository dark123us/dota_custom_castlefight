LUA ?= lua
LUACOV ?= luacov
CUR = $(pwd)

DEVPATH = deploy/linux

help: 
	@echo ''
	@echo 'Usage:'
	@echo ' make <target>'
	@echo ''
	@echo 'Targets:'
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

coverage: ## Проверка покрытия тестами
	@$(LUACOV)
	@cat luacov.report.out

test: ## Запуск тестов
	$(LUA) test/init.lua

submodules_update: ## подкгрузить сабмодули
	@git submodule init
	@git submodule update

submodules_dev: ## сабмодули подгрузить клоникрование
	cd deploy/linux; bash submodules-dev.sh

ide: ## IDE для разраотки
	@cd $(DEVPATH); bash 20-run-dev.sh

install: ## Синхронизировать кастомку, пересобрать карту, запустить доты и тулсы
	@cd $(DEVPATH); bash 10-install.sh

build-map: ## Собрать карту
	@cd $(DEVPATH); bash 11-build-map.sh

run-tools: ## Запустить доту и инструменты
	@cd $(DEVPATH) && bash 12-run-tools.sh

sync: ## Синхронизировать код
	@cd $(DEVPATH); bash 22-synchronize.sh

clean: ## Очистка проекта
	@cd $(DEVPATH); bash 40-uninstall.sh




.PHONY: help submodules_update submodules_dev
