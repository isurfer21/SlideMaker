#!/usr/bin/bash
ROOT_DIR="$PWD"
USER_DIR="$HOME"

dirs=(
	"S01_Introduction_&_setup_of_node.js" 
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

version() {
	echo " Builder   version 1.0 \n Copyright (c) 2019 Abhishek Kumar. All rights reserved. \n"
}

help() {
	echo "\n Builder's options are:\n"
    echo "  -v  --version       to see the current version of the app"
    echo "  -g  --gends         to generate folder structure for all sessions"
    echo "  -r  --remds         to remove folder structure for all sessions"
    echo "  -b  --build         to build slides for all sessions"
    echo "  -h  --help          to see the menu of command line options"
    echo "\n Please choose accordingly. \n"
}

gends() {
    echo " Generating folders for"
    for i in "${dirs[@]}"
	do
		echo " - $i"
		mkdir "docs/$i"
        touch "docs/$i/slide.css"
        touch "docs/$i/slide.md"
	done
    echo " Done! \n"
}

remds() {
    echo " Removing folders for"
    for i in "${dirs[@]}"
	do
		echo " - $i"
		rm -rf "docs/$i"
	done
    echo " Done! \n"
}

build() {
	echo " Building slides for"
	for i in "${dirs[@]}"
	do
		echo "- $i"
		python3 slidemaker.py -d="docs/$i"
	done
	echo " Done! \n"
}

if [[ "$1" == "" ]]; then 
    echo " Command missing! \n"
  else 
    cd $ROOT_DIR
	case "$1" in
    '-g')
		gends
	;;
    '--gends')
		gends
    ;;
    '-r')
		remds
	;;
    '--remds')
		remds
    ;;
    '-b')
		build
	;;
    '--build')
        build
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