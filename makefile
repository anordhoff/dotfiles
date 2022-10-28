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

# TODO: https://stackoverflow.com/questions/18770545/why-is-my-git-submodule-head-detached-from-master
update:
	# git submodule update --remote --merge
	# --- OR ---
	# git submodule update
	# git submodule foreach git checkout master
	# git submodule foreach git pull origin master

init:
	git submodule update --init

rm: validate-path
	git rm $(path)
	rm -rf .git/modules/$(path)
