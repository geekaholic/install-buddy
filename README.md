# Install Buddy

## What is it?
Simple wrapper tool which relies on the native package manager to automate installing a list of packages, on a freshly installed Linux/OSX system.

## Why?
From time to time, I end up reinstalling or switching Linux distos, and the initial setup to get things just right the way it was can be time-consuming. I wanted a simple tool that can bootstrap a fresh installation by automating the installation of additional packages so that I can be productive right away!

Check out my [favorite list of packages](https://github.com/geekaholic/mydotfiles/blob/master/my-packages.yml).

## Installation Prerequisite
* Supported distro
  - Alpine
  - Arch
  - Debian & flavors(Ubuntu, Mint, ElementaryOS etc.)
  - Fedora / CentOS
  - Gentoo
  - Solus
  - Mac OSX (via [Homebrew](https://brew.sh))
  - Installing via a shell script (experimental) 
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
  - brew:
    - shell: [ "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"" ]
```

```bash
Usage: sudo ./bin/install-buddy -f <package_list_file>
```

Add `--dry-run` to pretend to install packages without actually installing them.

```bash
sudo ./bin/install-buddy -f ./conf/package-list-example.yml --dry-run
sudo ./bin/install-buddy -f ./conf/package-list-example.yml
```

Add `--no-root` to try force installation as non root and stop it from complaining (e.g: with homebrew)

```bash
./bin/install-buddy -f ./conf/package-list-example.yml --no-root
```

## Package Alias Support
Some packages might be named differently depending on distro.
Eg: [the-silver-searcher](https://github.com/ggreer/the_silver_searcher), a faster alternative to `ack-grep` is named differently depending on distro. Look at the following example above on how to write it.

## Skip package installation for some distros
Some times you may want to skip installing a package for a specific distro or distro family. For example, you might want to skip `MacOSX` when installing the `docker` package because on OSX it's not installed via homebrew.

Note: This feature can not be combined with the `-only` feature.

## Installing packages "Only" on some distros
Some times you might want to restrict the installation of a package to `only` one distro name or family. This works similar to the `-skip` feature except you specify the distros to only install on.

Note: This feature can not be combined with the `-skip` feature.

## Remote Install
Remote install allows you to run InstallBuddy on a remote system via SSH without having to install ruby or download this repo on it. In order for this to work the remote system should have SSH server running without any restrictions for `root user` to login. The recommended secure way to do this is to enable passwordless login for root using your public key for authentication.

```
vim /etc/ssh/sshd_config

PermitRootLogin without-password
```

Alternately you could set a temporary password for `root` user and enter that in (be prepared to enter the password multiple times!).

```
# If you don't have a public key
ssh-key -t rsa
# Copy content to clipboard
cat ~/.ssh/id_rsa.pub | xclip -sel clip

# SSH to remote and become root
mkdir /root/.ssh
chmod 700 /root/.ssh

cat > /root/.ssh/authorized_keys
... copy content of clipboard with pub key
Ctrl + D

chmod 400 /root/.ssh/authorized_keys
```

You also need to install some additional gems via bundle. From project directory

```
bundle install --without development

```

Finally to remote install run `install-buddy` without sudo: 

```
# To do a dry run and see which commands will be executed on remote
./bin/install-buddy --dry-run -f ../my-packages.yml --remote 172.17.0.2

# Then remove --dry-run to perform an actual install
./bin/install-buddy -f ../my-packages.yml --remote 172.17.0.2
```
