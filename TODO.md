# TODO features

* Explicitly be able to specify installer

```yaml
packages:
  - k9s:
    - installer: "brew"
```

* Running as non root should auto sudo for installers that require it
