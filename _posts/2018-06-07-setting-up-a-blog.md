---
published: false
title: Setting up a Blog with Git
category: Blogging
excerpt: |
  My first post will just cover some of the steps I took to set this site up as a bit of a walk through. If you're not wanting to build a site today feel free to look through it anyway.
feature_text: |
  ## Blog: a ~~regularly~~ updated website
feature_image: "/assets/imgs/koz2.JPG"
image: "/assets/imgs/koz2.JPG"
---

Hi, I'm Josh. I write software for a living and actually really enjoy it. Well, most of the time.

I keep finding myself wanting to write up some of the things I've learnt about and the mistakes I've made. So here we are. Hopefully someone can learn from it and possibly avoid the same issues that I had.

My first post will just cover some of the steps I took to set this site up as a bit of a walk through. If you're not wanting to build a site today feel free to look through it anyway. I'm hoping to follow up with some tips on using Git, ZSH/Shell but for now I'll try to keep it brief.

It'll be easier if you already use a terminal regularly and are familiar with Git but I'll try to walk through everything without too many assumptions.

# What are we using?

First I want to than David Darnes who make the [Alembic theme](https://alembic.darn.es) that is responsible for the majority of the styling for the site. He did an awesome job and even included some nice features like a service worker, search and a contact page.

I plan to tweak it further to suite my needs but the theme is a lovely collection of useful templates and [CSS](TODO) and is easy to install and use.

I'm using [Github Pages](TODO), a very neat static site tool built by and integrated with Github. It takes a bunch of configuration files and pages written in [Markdown](TODO) and turns them into a site that runs on `$USERNAME.github.io` for free.

P.S. I'm going to use `this notation` to show that I mean to run the command in your terminal.

## Steps


#### 1. Get a Github account or use one that you already have.

  - Sign up here (or you can use other hosts for git and your site if you know about them)
    - [ https://github.com/ ](https://github.com/)
      
#### 2. Create a new repository called `$USERNAME.github.io`.
  - Use [https://github.com/new](https://github.com/new)
  - Call it `$USERNAME.github.io` (a special repository name that tells github that you want to use it as a github pages site.
#### 3. Read a bit about Git and install 'git' if you're not familiar with it.
  - For most Linux users: `sudo apt install git`
  - For Mac users: find a git tutorial or `brew install git` if you use [Homebrew](https://github.com/Homebrew/brew).
  - For windows users: find a git tutorial.
  - Heres a few to get you started:
    - Installing Git – the easy way
      - [ https://gist.github.com/derhuerst/1b15ff4652a867391f03 ](https://gist.github.com/derhuerst/1b15ff4652a867391f03)
    - Setting up Git and Github on your Mac
      - [ http://burnedpixel.com/blog/setting-up-git-and-github-on-your-mac/ ](http://burnedpixel.com/blog/setting-up-git-and-github-on-your-mac/)
  - (I recommand using apt for linux
#### 4. Install ruby, bundler, jekyll, an editor etc.
  - Again for linux users either you can probably use `apt install ruby bundler jekyll` (or you proabably know how to install packages yourself).
  - Mac users `brew install ruby jekyll` TODO
#### 5. Create a new Jekyll site
  - `jekyll new $USERNAME.github.io`
  - `cd $USERNAME.github.io`
#### 6. Set up your repo.
  - Turn the jekyll site into a git repo.
    - `git init`
  - Add a 'remote'
    - `git remote add git@github.com:$USERNAME/$USERNAME.github.io.git`
  - Push your code up to github for the first time!
    - `git push -u origin master`
#### 7. What is \_config.yml
#### 8. Writing a first post
#### 9. Push

Done!

----
