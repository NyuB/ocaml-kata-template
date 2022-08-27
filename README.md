![CI/CD](https://github.com/NyuB/ocaml-kata-template/actions/workflows/main.yml/badge.svg)
# OCaml Kata-Template

Ready-to-code OCaml Dune project with some sample tests and exercises already implemented

# Setup

## With VS Code Remote Development Container (recommended)

*Vs Code and Docker (or Docker Desktop on windows) required*

+ Install Remote-Containers extension
+ Use "Remote-Containers:Open Folder in Container" from the command palette and choose this folder. Select the "Use Dockerfile in folder" option with **./Dockerfile.dev**. 
+ Install the 'OCaml Platform' Extension in the dev Container (the same way you would usually install a VSCode extension)
+ Now cd into **project**
+ Run ```dune build```. 
+ Run ```dune exec project```. The programm should run, ouputing some lines prompting to run some tests. 
+ Run ```dune test```. All tests should succeed.
+ Try to hover over symbols in **lib/setup.ml**. Syntax highlights and type inference should be displayed.
+ Try to rename "lib" in line 2 of **lib/dune** project file (e.g in "notlib"). Run ```dune build```. The build should fail. Now open (or close then re-open) **test/setup.ml**. Error highlighting should be displayed complaining about unbounded module name. Don't forget to rollback your changes in **lib/dune**.
+ You're good to go.

## With Docker but without VS Code Remote Development Container

*Docker required*

+ `docker build --tag ocaml:workspace --file Dockerfile.dev .` ( Do not forget the '.' ;) )
+ `./dockin ocaml:workspace ocaml`
+ `cd /workspace/project`

## On Linux without Docker

*Patience required*

+ Refer to the OCaml Documentation

# Use as template

## Rename

To rename the project folder and dune project files (will replace "project" as the project name)

```
python rename_template.py <newname> <oldname? = "project">
```
