validate-submodule:
ifndef submodule
	$(error submodule is undefined (eg submodule=https://github.com/tpope/vim-repeat.git))
endif

validate-path:
ifndef path
	$(error path is undefined (eg path=vim/pack/package/start/vim-repeat))
endif

validate-branch:
ifndef branch
	$(error branch is undefined (eg branch=master))
endif

add: validate-submodule validate-path validate-branch
	git submodule add -b $(branch) $(submodule) $(path)

update:
	# TODO

init:
	# TODO

rm: validate-path
	git rm $(path)
	rm -rf .git/modules/$(path)
