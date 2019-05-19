# SlideMaker
It is a slide making tool based on *Takahashi* method


### Usage
1. To generate folder structure for all sessions

	```
	$ sh build.sh -r
	```

2. To remove folder structure for all sessions
	
	```
	$ sh build.sh -g
	```

3. To build slides for all sessions
	
	```
	$ sh build.sh -b
	```

4. To watch the folder and rebuild when file changes
	
	```
	$ sh build.sh -w
	```

5. To perform action without logging
	
	```
	$ sh build.sh [-?] -s
	```
	where `[-?]` could be anything switch out of `-g`, `-r`, `-b` or `-w`


### Dependencies
```
$ brew update
$ brew install fswatch
```