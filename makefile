.PHONY: validate-submodule
validate-submodule:
ifndef submodule
	$(error submodule is undefined (eg submodule=https://github.com/tpope/vim-repeat.git))
endif

.PHONY: validate-path
validate-path:
ifndef path
	$(error path is undefined (eg path=nvim/pack/plugins/start/repeat))
endif


# make init
.PHONY: init
init:
	git submodule update --init
	make -C nvim/pack/plugins/start/telescope-fzf-native
	npm install --no-package-lock --prefix nvim/pack/plugins/opt/markdown-preview nvim/pack/plugins/opt/markdown-preview

# make update
.PHONY: update
update:
	git submodule update --remote --merge
	make -C nvim/pack/plugins/start/telescope-fzf-native
	npm install --no-package-lock --prefix nvim/pack/plugins/opt/markdown-preview nvim/pack/plugins/opt/markdown-preview

# make pull
.PHONY: pull
pull:
	git pull
	make -C nvim/pack/plugins/start/telescope-fzf-native
	npm install --no-package-lock --prefix nvim/pack/plugins/opt/markdown-preview nvim/pack/plugins/opt/markdown-preview

# make add submodule=https://github.com/tpope/vim-repeat.git path=nvim/pack/plugins/start/repeat
.PHONY: add
add: validate-submodule validate-path
	git submodule add $(submodule) $(path)

# make rm path=nvim/pack/plugins/start/repeat
.PHONY: rm
rm: validate-path
	git rm $(path) -f
	rm -rf .git/modules/$(path)

# make diff dir1=dotfiles dir2=dotfiles.backup
.PHONY: diff
diff:
	diff -r --exclude .git --exclude nvim/pack/plugins --exclude tmux/plugins $(dir1) $(dir2)
