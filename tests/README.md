# Running tests

Make sure you have [minitest](https://github.com/seattlerb/minitest) installed by running `bundle install` from the project directory.

To run unit tests, from project directory:

```
$ rake test
```

To run full integration tests, you need to have [docker](https://www.docker.com/get-docker) installed and connectivity to the internet.

```
$ rake integration
```
