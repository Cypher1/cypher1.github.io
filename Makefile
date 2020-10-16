.PHONY: deploy prepare

BOOK=".book"

all: deploy

src/SUMMARY.md: src/posts/*.md
	@echo "====> updating SUMMARY.md"
	bash ./gen.sh

book: src book.toml src/SUMMARY.md
	@echo "====> building"
	mdbook build

prepare: book
	@echo "====> deploying to github"
	rm -rf $(BOOK)
	mkdir $(BOOK)
	git worktree add $(BOOK) gh-pages -f
	rm -rf $(BOOK)/*
	cp -rp book/html/* $(BOOK)/
	cp -rp CNAME $(BOOK)/
	touch $(BOOK)/.nojekyll

deploy: prepare
	@echo "====> deploying to github"
	cd $(BOOK) && \
		git add -A && \
		git commit -m "deployed on $(shell date) by ${USER}" && \
		git push origin gh-pages
