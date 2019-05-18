# SlideMaker
It is a slide making tool based on Takahashi method

### Usage
To generate folder structure for all sessions
```
$ sh build.sh -r
```

To remove folder structure for all sessions
```
$ sh build.sh -g
```

To build slides for all sessions
```
$ sh build.sh -b
```

To perform action without logging
```
$ sh build.sh [-?] -s
```
where `[-?]` could be anything switch out of `-g`, `-r`, or `-b`

### Dependencies
```
$ brew update
$ brew install watchman
```