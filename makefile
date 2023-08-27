init:
	git submodule update --init

update:
	git submodule update --remote --merge

# make add submodule=https://github.com/tpope/vim-repeat.git path=nvim/package/start/repeat
add: validate-submodule validate-path
	git submodule add $(submodule) $(path)

# make add path=nvim/package/start/repeat
rm: validate-path
	git rm $(path) -f
	rm -rf .git/modules/$(path)


validate-submodule:
ifndef submodule
	$(error submodule is undefined (eg submodule=https://github.com/tpope/vim-repeat.git))
endif

validate-path:
ifndef path
	$(error path is undefined (eg path=nvim/package/start/repeat))
endif
