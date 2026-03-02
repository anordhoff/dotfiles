.PHONY: validate-submodule
validate-submodule:
ifndef submodule
	$(error submodule is undefined (eg submodule=https://github.com/tmux-plugins/tmux-resurrect.git))
endif

.PHONY: validate-path
validate-path:
ifndef path
	$(error path is undefined (eg path=tmux/plugins/resurrect))
endif


# make init
.PHONY: init
init:
	git submodule update --init

# make update
.PHONY: update
update:
	git submodule update --remote --merge

# make pull
.PHONY: pull
pull:
	git pull

# make add submodule=https://github.com/tmux-plugins/tmux-resurrect.git path=tmux/plugins/resurrect
.PHONY: add
add: validate-submodule validate-path
	git submodule add $(submodule) $(path)

# make rm path=tmux/plugins/resurrect
.PHONY: rm
rm: validate-path
	git rm $(path) -f
	rm -rf .git/modules/$(path)

# make diff dir1=dotfiles dir2=dotfiles.backup
.PHONY: diff
diff:
	diff -r --exclude .git --exclude tmux/plugins $(dir1) $(dir2)
