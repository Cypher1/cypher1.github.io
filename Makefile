.PHONY: deploy prepare serve

BOOK=".book"

all: prepare

serve: prepare
	mdbook serve

src/SUMMARY.md: src/posts/*.md
	@echo "====> updating SUMMARY.md"
	bash ./gen.sh

book: src book.toml src/SUMMARY.md
	@echo "====> building"
	mdbook build

prepare: book
	@echo "====> preparing book"
	rm -rf $(BOOK)
	mkdir $(BOOK)
	git worktree add $(BOOK) gh-pages -f
	rm -rf $(BOOK)/*
	cp -rp book/html/* $(BOOK)/
	rm -rf book
	cp -rp CNAME $(BOOK)/
	touch $(BOOK)/.nojekyll

deploy: prepare
	@echo "====> deploying to github"
	cd $(BOOK) && \
		git add -A && \
		git commit -m "deployed on $(shell date) by ${USER}" || true && \
		git push origin gh-pages
