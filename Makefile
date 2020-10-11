.PHONY: deploy

all: deploy

book: src book.toml
	@echo "====> building"
	mdbook build

deploy: book
	@echo "====> deploying to github"
	rm -rf /tmp/book/* || true
	git worktree add /tmp/book gh-pages -f
	cp -rp CNAME /tmp/book/
	cd /tmp/book && \
		git add -A && \
		git commit -m "deployed on $(shell date) by ${USER}" && \
		git push origin gh-pages
