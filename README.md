# Install Buddy

## What is it?
Simple wrapper tool which relies on native package manager to automate installing a list of packages, on a freshely installed Linux/OSX system.

## Why?
From time to time, I end up reinstalling or switching Linux distos and the initial setup to get things just right the way it was can be time consuming. I wanted a simple tool that can bootstrap a fresh installation by automating the installation of additional packages, so that I can be productive right away!

Checkout my [favorite list of packages](https://github.com/geekaholic/mydotfiles/blob/master/my-packages.yml).

## Installation Prerequisite
* Supported distro
  - Alpine
  - Arch
  - Debian & flavors(Ubuntu, Mint, ElementaryOS etc.)
  - Fedora / CentOS
  - Gentoo
  - Solus
  - Mac OSX (via [Homebrew](https://brew.sh))
* Modern version of [Ruby](https://www.ruby-lang.org/en/documentation/installation/) is required to be installed.
* Default Package Manager fully updated (e.g `apt-get update` on Debian like)

## Installation
Clone this repo. Create and/or modify a package-list YAML file. See [example](https://github.com/geekaholic/install-buddy/blob/master/conf/package-list-example.yml).

```yaml
packages:
  - vim
  - git
  - the_silver_searcher:
    - alias: { Debian: "silversearcher-ag", Solus: "silver-searcher"}
    - skip: [ "CentOS" ]
  - snapd:
    - only: [ "Ubuntu" ]
  - powertop
```

```bash
Usage: sudo ./bin/install-buddy -f <package_list_file>
```

Add `--dry-run` to pretend to install packages without actually installing them.

```bash
sudo ./bin/install-buddy -f ./conf/package-list-example.yml --dry-run
sudo ./bin/install-buddy -f ./conf/package-list-example.yml
```

## Package Alias Support
Some packages might be named differently depending on distro.
Eg: [the-silver-searcher](https://github.com/ggreer/the_silver_searcher), a faster alternative to `ack-grep` is named differently depending on distro. Look at following example above on how to write it.

## Skip package installation for some distros
Some times you may want to skip installing a package for a specific distro or distro family. For example you might want to skip `MacOSX` when installing `docker` package because on OSX it's not installed via homebrew.

Note: This feature can not be combined with the `-only` feature.

## Installing packages "Only" on some distros
Some times you might want to restrict installation of a package to `only` one distro name or family. This works similar to the `-skip` feature except you specify the distros to only install on.

Note: This feature can not be combined with the `-skip` feature.
