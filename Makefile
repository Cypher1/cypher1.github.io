.PHONY: deploy

all: deploy

book: src book.toml
	@echo "====> building"
	mdbook build

deploy: book
	rm -rf /tmp/book || true
	@echo "====> deploying to github"
	git worktree add /tmp/book gh-pages
	cp -rp book/* /tmp/book/
	cp -rp CNAME /tmp/book/
	cd /tmp/book && \
		git add -A && \
		git commit -m "deployed on $(shell date) by ${USER}" && \
		git push origin gh-pages
