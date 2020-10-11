.PHONY: deploy
deploy: book
	rm -rf /tmp/book
	@echo "====> deploying to github"
	git worktree add /tmp/book gh-pages -f
	rm -rf /tmp/book/*
	cp -rp book/* /tmp/book/
	cd /tmp/book && \
		git add -A && \
		git commit -m "deployed on $(shell date) by ${USER}" && \
		git push origin gh-pages
