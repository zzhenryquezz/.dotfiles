# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Stow

```
apt install stow
```

## Installation

First, check out the dotfiles repository in your $HOME directory using git

```
git clone git@github.com:zzhenryquezz/.dotfiles.git

cd dotfiles
```

Then use GNU stow to create symbolic links

```
stow .
```
