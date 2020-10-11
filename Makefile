.PHONY: deploy

all: deploy

src/SUMMARY.md: src/posts/*.md
	@echo "====> updating SUMMARY.md"
	./gen.sh

book: src book.toml src/SUMMARY.md
	@echo "====> building"
	mdbook build

deploy: book
	@echo "====> deploying to github"
	rm -rf /tmp/book
	git worktree add /tmp/book gh-pages -f
	cp -rp CNAME /tmp/book/
	cd /tmp/book && \
		git add -A && \
		git commit -m "deployed on $(shell date) by ${USER}" && \
		git push origin gh-pages
