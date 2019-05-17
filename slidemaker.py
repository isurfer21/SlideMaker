import fileinput
import argparse
import shutil
import os


class AppProp:

    def __init__(self, arg):
        self.arg = arg

    @staticmethod
    def version():
        print('''
Slide Maker
Version 1.0
Copyright (c) 2019 Abhishek Kumar
Licensed by MIT license
		''')

    @staticmethod
    def readFileAsStr(filePath):
        with open(filePath, 'r') as file:
            data = file.read()  # .replace('\n', '')
        return data

    @staticmethod
    def replaceStrInFile(filePath, searchStr, replaceStr):
        with fileinput.FileInput(filePath, inplace=True, backup='') as file:
            for line in file:
                print(line.replace(searchStr, replaceStr), end='')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-v', '--version', help='Show the version and exit',
                        action='store_true', default=False)
    parser.add_argument(
        '-d', '--directory', help='Set slide directory', action='store', default=None)
    appargs = parser.parse_args()

    if appargs.version:
        AppProp.version()
    else:
        print('Slide Maker')
        if appargs.directory:
            if os.path.isdir(appargs.directory):
                proot = os.path.dirname(os.path.realpath(__file__))
                phtm = os.path.join(proot, 'slide.htm')
                pmd = os.path.join(appargs.directory, 'slide.md')
                if os.path.exists(phtm) and os.path.exists(pmd):
                    phtml = os.path.join(appargs.directory, 'index.html')
                    if os.path.exists(phtml):
                        print('- Removing already existing .html file')
                        os.remove(phtml)
                    print('- Creating new .html file')
                    shutil.copy(phtm, phtml)
                    print('- Extracting content from .md file')
                    tmd = AppProp.readFileAsStr(pmd)
                    print('- Inserting content of .md file into .html file')
                    AppProp.replaceStrInFile(phtml, '<!--[SLIDE]-->', tmd)
                    pcss = os.path.join(appargs.directory, 'slide.css')
                    if os.path.exists(pcss):
                        print('- Extracting content from .css file')
                        tcss = AppProp.readFileAsStr(pcss)
                        print('- Inserting content of .css file into .html file')
                        AppProp.replaceStrInFile(phtml, '/*[STYLE]*/', tcss)
                else:
                    print('Error: Either .htm or .md file is missing')
            else:
                print('Error: Provided directory path does not exist')
        else:
            print('Error: Directory path is missing')

    print('Done!')

if __name__ == "__main__":
    main()
