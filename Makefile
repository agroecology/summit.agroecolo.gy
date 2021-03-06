PROECT = summit
DOMAIN = $(PROJECT).agroecolo.gy
BASE_DIR = $(shell pwd)
BUILD_DIR = $(BASE_DIR)/resources/public
REPO = git@github.com:agroecology/$(PROJECT).agroecology.github.io.git
THEME_REPO = git@github.com:agroecology/thompson-fields.git
THEME_DIR = resources/templates/themes/thompson_fields

build:
	lein run

dev:
	lein ring server

clean:
	rm -rf $(BUILD_DIR)

commit-latest:
	-@git commit -a; git push origin master

publish: commit-latest clean build
	@rm -rf $(BUILD_DIR)/.git
	@cd $(BUILD_DIR) && \
	git init && \
	git add * &> /dev/null && \
	git commit -a -m "Generated content." &> /dev/null && \
	git push -f $(REPO) master:master

update:
	cd $(THEME_DIR) && \
	git checkout master && \
	git pull && \
	cd - && \
	git add $(THEME_DIR) && \
	git submodule update

# The next target is only here for documentation sake; this only needed to be
# done once, during the initial setup of the repository. It assumes that the
# top-level site-generating repp, agroecolo.gy, has been created already.
setup:
	ln -s ../../../../agroecolo.gy/$(THEME_DIR) $(THEME_DIR)

rm-submodule:
	-git rm .gitmodules
	-git rm --cached $(THEME_DIR)
