# Install Buddy

## What is it?
Simple tool to automate installing  of a list of packages(manifest), on a freshely installed Linux system.

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
Clone this repo. Create and/or modify a package manifest YAML file. See [example](https://github.com/geekaholic/install-buddy/blob/master/conf/manifest-example.conf).

```yaml
manifest:
  - vim
  - git
  - powertop
  - inxi
```

```bash
Usage: sudo ./bin/install-buddy -f <manifest_file>
```

Checkout sample packages in manifest-example.conf and try installing them.

```bash
sudo ./bin/install-buddy -f ./conf/manifest-example.conf
```

## TODO (Coming soon!)

Package name aliases to support name changes across distros.
