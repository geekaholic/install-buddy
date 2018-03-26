# Install Buddy

Simple tool to automate installing required software on a freshely installed Linux system.

I run several flavors of Linux distros (Debian/Ubuntu/Fedora/Arch/Solus etc.). I wanted a tool that can kickstart a fresh installation with useful packages to be productive right away!

```
Usage: sudo ./bin/install-buddy -f <manifest_file>
```

Checkout sample packages in manifest-example.conf and try installing them.

```
sudo ./bin/install-buddy -f ./conf/manifest-example.conf
```

## TODO (Coming soon!)

Package name aliases to support name changes across distros.
