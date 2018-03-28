# Install Buddy

## What is it?
Simple tool to automate installing  of a list of packages, on a freshely installed Linux system.

## Why?
From time to time, I end up reinstalling or switching Linux distos and the initial setup to get things just right by installing my favorite packages and configuring it can take some time. I wanted a tool that can kickstart a fresh installation by automating the setup process so that I can be productive right away!

## Installation Prerequisite
* Supported distro
  - Debian & flavors(Ubuntu, Mint, ElementaryOS etc.)
  - Fedora / CentOS
  - Solus
  - Arch
* Modern version of [Ruby](https://www.ruby-lang.org/en/documentation/installation/) is required to be installed.
* Default Package Manager fully updated (e.g `apt-get update` on Debian like)

## Installation
Clone this repo. Create and/or modify a package-list YAML file. See [example](https://github.com/geekaholic/install-buddy/blob/master/conf/package-list-example.yml).

```yaml
packages:
  - vim
  - git
  - powertop
  - inxi
```

```bash
Usage: sudo ./bin/install-buddy -f <package_list_file>
```

```bash
sudo ./bin/install-buddy -f ./conf/package-list-example.yml
```

## TODO (Coming soon!)

Package name aliases to support name changes across distros.
