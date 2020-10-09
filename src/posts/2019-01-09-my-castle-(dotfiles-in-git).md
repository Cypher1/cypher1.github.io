<!--
published: true
title: Git backed Configuration
category: [Dotfiles, Config, Git]
excerpt: |
  What amazing tool could solve my configuration backup problem?

  Well, of course, its Git.
feature_text: |
  **a man’s home <s>directory</s> is his castle**
feature_image: "/assets/imgs/koz3.JPG"
image: "/assets/imgs/koz3.JPG"
-->

I've been using Linux for a little while and along the way have accumulated a fair bit of configuration (even though I try to remove the bits I don't need anymore).

I often find that these configs help me out (e.g. [my Vim config](/posts/2018-10-01-init.vim-(the-best-bits)/)) so, after the first few times I lost bits of it, I spent some time ensuring that I could keep it, even if I changed computers, had a hard drive fail or went mad and wrote a bunch of terrible configuration.

What amazing tool could solve my configuration backup problem?

Well, of course, its [Git](https://en.wikipedia.org/wiki/Git).

I keep any config and useful bash scripts that I need in a git repo. This includes:
- [Vim config](http://vim.wikia.com/wiki/Example_vimrc)
- [Zsh config](https://wiki.archlinux.org/index.php/zsh#Sample_.zshrc_files)
- [Git config](https://git-scm.com/docs/git-config)
- [i3 config](https://i3wm.org/docs/userguide.html)
- [a font I like](https://github.com/powerline/fonts/tree/master/Hack)
- a script for setting up my favourite keyboard config
- a list of [Python](https://pypi.org/) and [NPM](https://www.npmjs.com) packages I commonly use
- a list of programs that I commonly use
- a script that installs all the above

So, lets step through what I needed to do this.

First, (assuming you are a Linux, or possibly Mac/BSD user) I'll assume you are familiar with a terminal (e.g. [bash](TODO)).

```bash
cd ~/.config
```

We're now in one of the most common places to store user specific configuration.
Lets setup a git repo. I recommend using [Github](https://github.com) or [Bitbucket](https://bitbucket.org).

This should give you an identifier for your git repo, mine is `git@github.com:Cypher1/Castle.git`.

```bash
git init
git remote add origin git@github.com:user/repo.git
```

Now you can add any files that you already have in `.config`.

```bash
git add important_file_to_backup
git commit -m "Adding important file"
```

Nice enough, but we are missing our actual dotfiles (the ones stored in our home directory).

So, lets grab those, I'll use my `zshrc` file as an example but you should be able to substitute to make this work for any dotfile.

First we move the actual dot file into our repo and add it.
```bash
mv ~/.zshrc ~/.config/zshrc
cd ~/.config/
git add zshrc
git commit -m "Adding my zshrc"
```

Now we need a bit of a trick to make it look (to our programs) like the dotfiles are still where we left them.

Fortunately there's a great tool for this called ['soft links'](TODO). They make use of the structure of modern file systems to make a 'linked' version of a file or directory.

The utility to make soft links is called `ln` or `link` (find out more with `man ln`).
```bash
ln -s ~/.config/zshrc ~/.zshrc
```

This creates a new soft link at `~/.zshrc` and connects it to `~/.config/zshrc`.

Now programs that open `~/.zshrc` will actually be opening `~/.config/zshrc`, so all your edits will be tracked in the git repo.

Always remember to upload your changes to your remote repo so that you have them backed up.
```bash
git push origin master
```
I recommend learning more about `git` so that you can manage your backups and your changes to them.

For me, it was worth creating an installer script that does all my soft linking, and software installation.

You can find it [here](https://github.com/Cypher1/Castle/blob/master/bin/arrive).
