#!/usr/bin/bash
ROOT_DIR="$PWD"
USER_DIR="$HOME"

dirs=(
	"S01_Introduction_and_setup_of_node.js" 
	"S02_Core_concepts_of_JS" 
	"S03_Useful_ES6_features" 
	"S04_Node_JS_Modules" 
	"S05_Node_Package_Manager" 
	"S06_Creating_Web_Server" 
	"S07_File_System" 
	"S08_Debugging_Node_JS_Application" 
	"S09_Events" 
	"S10_Process_Event" 
	"S11_Express_JS" 
	"S12_Serving_Static_Resources" 
	"S13_Database_Connectivity" 
	"S14_Project_Development" 
)

silent=1

version() {
	echo " Builder   version 1.0 \n Copyright (c) 2019 Abhishek Kumar. All rights reserved. \n"
}

help() {
	echo "\n Builder's options are:\n"
	echo "  -v  --version       to see the current version of the app"
	echo "  -g  --gends         to generate folder structure for all sessions"
	echo "  -r  --remds         to remove folder structure for all sessions"
	echo "  -b  --build         to build slides for all sessions"
	echo "  -w  --watch         to watch for auto-rebuild when file changes"
	echo "  -s  --silent        to perform action without logging"
	echo "  -h  --help          to see the menu of command line options"
	echo "\n Please choose accordingly. \n"
}

islog() {
	case "$1" in
    '-s')
		silent=0
	;;
    '--silent')
        silent=0
    ;;
    esac
}

print() {
	if [[ $silent == 1 ]]; then
		echo "$1"
	fi
}

gends() {
    print " Generating folders for"
    for i in "${dirs[@]}"
	do
		print " • $i"
		mkdir "docs/$i"
        touch "docs/$i/slide.css"
        touch "docs/$i/slide.md"
	done
    print " Done! \n"
}

remds() {
    print " Removing folders for"
    for i in "${dirs[@]}"
	do
		print " • $i"
		rm -rf "docs/$i"
	done
    print " Done! \n"
}

build() {
	print " Building slides for"
	for i in "${dirs[@]}"
	do
		print "\n • $i \n"
		if [[ $silent == 1 ]]; then
			python3 slidemaker.py -d="docs/$i"
		else 
			python3 slidemaker.py -s -d="docs/$i"
		fi	
	done
	print "\n Done! \n"
}

watch() {
	print " Watching docs/ folder"
	trap "exit 0" SIGINT SIGTERM; 
	while true
	do
		fswatch -1 docs/
		build
		sleep 1
	done
}

if [[ "$1" == "" ]]; then 
    echo " Command missing! \n"
  else 
    cd $ROOT_DIR
	case "$1" in
    '-g')
		islog "$2"
		gends
	;;
    '--gends')
		islog "$2"
		gends
    ;;
    '-r')
		islog "$2"
		remds
	;;
    '--remds')
		islog "$2"
		remds
    ;;
    '-b')
		islog "$2"
		build
	;;
    '--build')
		islog "$2"
        build
    ;;
    '-w')
		islog "$2"
		watch
	;;
    '--watch')
		islog "$2"
        watch
    ;;
    '-v')
		version
	;;
    '--version')
        version
    ;;
    '-h')
		help
	;;
    '--help')
        help
    ;;
    esac
fi
exit 0