# l3build-coursedocs
Template repository for storing course documents built with l3build

This repository contains assessment documents (problem sets, quizzes, exams) for
a class. The repository is a bundle of LaTeX modules managed by the `l3build`
utility. 

## HOWTO

### Creating new documents

These individual directories are defined as templates or “cookiecutters” and are managed by the `cookiecutter` utility. 

To create a new problem set:

    cookiecutter --config-file course.yml \
        support/cookiecutters/pset

To create a new quiz:

    cookiecutter --config-file course.yml \
        support/cookiecutters/quiz

To create a new exam:

    cookiecutter --config-file course.yml \
        https://github.com/leingang/cookiecutter-exam.git

### Building documents

To build all documents in a directory:

    l3build doc

To build only one, use it as a second argument, without `.tex`.

### Publishing

Do `l3build bump (major|minor|patch)` to bump the version number. Minor
versions are incremental content changes. Patch versions are for fixing
errors. Version 1.0 should be the first version intended for printing.
A version tag will be created for the repository at the same time.

The bump commands will fail if the repository is not clean, so commit
changes before bumping.

After bumping and tagging, a `l3build install --full` is recommended, along
with syncing the repo to github.

Do `l3build install --full` to generate the documents and install them in
a local directory.

### Printing

See my [gist](https://gist.github.com/leingang/b782762d50e362baf2c8902e1692112f) for that.

## TODO

Create `l3build` targets to shorten the commands for document creation.

Script the creation of stubs from a calendar file.

### `l3build` modularity

Use separate lua files for the different l3build extensions:

* tagging files (`only_if_clean`, `bumpversion`, etc.)
* typesetting (`latexmkrc` and `typeset`)
* marking documents with version control info (`vc`, `markversion.sty`, etc.)
* installing?

### Cookiecutter excision

The `pset` and `quiz` cookiecutters should be excised and placed in their own repositories. 

* Options for simple or bundle
* exam package