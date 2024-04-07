<!--
published: false 
title: Setting up a Blog with Git
category: Blogging
excerpt: |
  My first post will just cover some of the steps I took to set this site up as a bit of a walk through. If you're not wanting to build a site today feel free to look through it anyway.
feature_text: |
  ## Blog: a ~~regularly~~ updated website
feature_image: "/assets/imgs/koz2.JPG"
image: "/assets/imgs/koz2.JPG"
-->

Hi, I'm <span class="name">Jay</span>. I write software for a living and actually really enjoy it. Well, most of the time.

I keep finding myself wanting to write up some of the things I've learnt about and the mistakes I've made. So here we are. Hopefully someone can learn from it and possibly avoid the same issues that I had.

My first post will just cover some of the steps I took to set this site up as a bit of a walk through. If you're not wanting to build a site today feel free to look through it anyway. I'm hoping to follow up with some tips on using Git, Shell (in particular zsh) but for now I'll try to keep it brief.

It'll be far easier if you already use a terminal regularly and are familiar with Git but I'll try to introduce things as they come up.

# What are we using?

First up, I want to thank David Darnes who make the [Alembic theme](https://alembic.darn.es). That theme is responsible for the majority of the styling (and a significant portion of the functionality) of the site. He did an awesome job and even included some really nice features like a service worker, RSS feed, and search and contact pages.

I plan to tweak it further to suit my needs but the theme is a lovely collection of useful templates and [CSS](https://www.w3schools.com/css/) and is easy to install and use.

For hosting, I'm using [Github Pages](https://pages.github.com/), a very neat static site tool built by and integrated with Github. It takes a bunch of configuration files and pages written in [Markdown](https://www.markdowntutorial.com/) and turns them into a site that runs on `$USERNAME.github.io` for free.

P.S. I'm going to use `this notation` to show that I mean a command that can be run in your terminal and `$this_notation` to show that the value might not be the same for everyone and should be something you set up or something already available in your [shell](https://www.shellscript.sh/).

## Steps


#### 1. Get a Github account or use one that you already have.

Sign up at [https://github.com/](https://github.com/) (or you can use other hosts for git and your site if you are already familiar with them).
      
#### 2. Create a new repository called `$USERNAME.github.io`.
  - Use [https://github.com/new](https://github.com/new) if you're using Github.
  - Call it `$USERNAME.github.io` (a special repository name that tells github that you want to use it as a github pages site.

#### 3. Install 'git'
Git is a really useful tool for managing (mostly text) files that change over time while also being edited by multiple people. It's a pretty complex piece of software so I'll point you to some other tutorials about it.

Here's some to get git installed on a few common platforms:
- For most Linux users: `sudo apt install git`
- For Mac users: I recommend `brew install git` ([Homebrew](https://github.com/Homebrew/brew) is really awesome).
- Setting up Git and Github on your Mac
  - [ http://burnedpixel.com/blog/setting-up-git-and-github-on-your-mac/ ](http://burnedpixel.com/blog/setting-up-git-and-github-on-your-mac/)
- For windows users:
  - Installing Git – the easy way
    - [ https://gist.github.com/derhuerst/1b15ff4652a867391f03 ](https://gist.github.com/derhuerst/1b15ff4652a867391f03)

#### 4. Install ruby, bundler, jekyll, an editor etc.
There's an official quite start guide to jekyll [here](https://jekyllrb.com/docs/quickstart/) but I'll add a tldr.

- Linux: Again for linux users either you can probably use `apt install ruby` (or you proabably know how to install packages yourself).

- Mac: Similar to linux `brew install ruby`
- Windows users can use [rubyinstaller](https://rubyinstaller.org/) but I can't promise that it works particularly well.

Now that we all have ruby, we can use it's package manager (gem) to install jekyll (and bundler) tools for running the site:
`gem install jekyll bundler`.

#### 5. Create a new Jekyll site
Now it's time to build a skeleton for your site. You can use a template online (I used the [Alembic theme](https://alembic.darn.es)) or use `jekyll new $USERNAME.github.io` to make a completely clean new site.
  - `cd $USERNAME.github.io`
#### 6. Set up your repo.
  - Turn the jekyll site into a git repo.
    - `git init`
  - Add a 'remote'
    - `git remote add git@github.com:$USERNAME/$USERNAME.github.io.git`
  - Push your code up to github for the first time!
    - `git push -u origin master`

#### 7. Try it locally

The command that we are going to use to run the site locally is:
`jekyll server --livereload`

This tells `jekyll` the program that builds the site to run a server locally (it should be on localhost:4000. The `--livereload` flag tells jekyll to reload the site when the source files change. This makes it easy to modify the site quickly and see what the outcome is.

If you're looking around for things to change try looking in `./_posts`, 

Any theme styling is in `./_sass` and some config in `./_config` and there's loads to play around with before it's 'production ready' but hopefully this gets you started.


#### 8. Try it online

When you're ready you can commit your changes to your git remote and then `git push` them up to your server.

Now your `$USERNAME.github.io` should be live with your site.

I'm working on a follow up on this post that talks more about the specifics about jekyll that surprised me. See you soon.

----
