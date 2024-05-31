filename ?= dotfiles-$(shell date +"%m%d%y").tar.gz

.PHONY: validate-submodule
validate-submodule:
ifndef submodule
	$(error submodule is undefined (eg submodule=https://github.com/tpope/vim-repeat.git))
endif

.PHONY: validate-path
validate-path:
ifndef path
	$(error path is undefined (eg path=nvim/package/start/repeat))
endif


# make init
.PHONY: init
init:
	git submodule update --init

# make update
.PHONY: update
update:
	git submodule update --remote --merge

# make add submodule=https://github.com/tpope/vim-repeat.git path=nvim/package/start/repeat
.PHONY: add
add: validate-submodule validate-path
	git submodule add $(submodule) $(path)

# make rm path=nvim/package/start/repeat
.PHONY: rm
rm: validate-path
	git rm $(path) -f
	rm -rf .git/modules/$(path)

# make tar files="nvim zsh tmux/tmux.conf"
# TODO: ignore macos ._* files
.PHONY: tar
tar:
	tar --exclude '**/._*' --exclude-vcs --exclude nvim/package --exclude tmux/plugins -czvf $(filename) $(files)

# make diff dir1=dotfiles dir2=dotfiles.backup
# TODO: exclude nvim/package and tmux/plugins
.PHONY: diff
diff:
	diff -r --exclude .git --exclude package --exclude plugins $(dir1) $(dir2)
