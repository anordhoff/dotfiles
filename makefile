validate-submodule:
ifndef submodule
	$(error submodule is undefined (eg submodule=https://github.com/tpope/vim-repeat.git))
endif

validate-path:
ifndef path
	$(error path is undefined (eg path=vim/pack/package/start/vim-repeat))
endif

add: validate-submodule validate-path
	git submodule add $(submodule) $(path)

update:
	git submodule update --remote --merge

init:
	git submodule update --init --remote --merge

rm: validate-path
	git rm $(path)
	rm -rf .git/modules/$(path)
