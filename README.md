# l3build-coursedocs
Template repository for storing course documents built with l3build

This repository contains assessment documents (problem sets, quizzes, exams) for
a class. The repository is a bundle of LaTeX modules managed by the `l3build`
utility.

## HOWTO

### Starting a new semester

1. Create a new repository from this template (or copy `course.yml`/`build.lua`
   into an existing bundle).
2. Fill in `course.yml`'s `default_context` for the new course:
   `course_number`, `section_number`, `term_season`, `term_year`, `course_name`,
   `term_name`, `bundle_name`, `site_id`, and `number_copies` at minimum.
3. `build.lua`'s `bundle` is read directly out of `course.yml`'s `bundle_name`, so
   there's nothing to keep in sync by hand — just make sure `bundle_name` is set.
4. If any documents need multiple versions this semester (see below), set
   `has_versions: true` and fill in `versions_csv` with a sensible default (e.g.
   the most common case, like quiz meeting times). Individual documents can
   override this at creation time.
5. If the course has its own shared LaTeX package or TikZ library, set
   `extra_latex_packages` / `extra_tikz_libraries`.

### Creating new documents

Individual documents (problem sets, quizzes, exams) are scaffolded with the
[`cookiecutter`](https://cookiecutter.readthedocs.io/) utility, from templates
maintained in [`cookiecutter-coursedocs`](https://github.com/leingang/cookiecutter-coursedocs).

To create a new problem set:

    cookiecutter --config-file course.yml \
        gh:leingang/cookiecutter-coursedocs --directory=pset

To create a new quiz (exam-class based):

    cookiecutter --config-file course.yml \
        gh:leingang/cookiecutter-coursedocs --directory=nyuquiz

To create a new quiz (Auto Multiple Choice based):

    cookiecutter --config-file course.yml \
        gh:leingang/cookiecutter-coursedocs --directory=amcquiz

To create a new exam:

    cookiecutter --config-file course.yml \
        gh:leingang/cookiecutter-coursedocs --directory=exam

Any `course.yml` default can be overridden for a single document by passing it
as extra context on the command line, e.g. if exams need a different set of
versions than quizzes:

    cookiecutter --config-file course.yml \
        gh:leingang/cookiecutter-coursedocs --directory=exam \
        versions_csv=1100,1530

### Multiple versions

The `nyuquiz`, `exam`, and `amcquiz` templates can generate several versions of
the same document (e.g. one per lecture section's meeting time, or lettered
forms A/B/C for basic anti-cheating) from a single `.dtx` source, using
docstrip guards. This is controlled by four `course.yml`/cookiecutter keys:

* `has_versions`: turn the feature on for a document.
* `versions_csv`: comma-separated version identifiers, e.g. `1100,1230,1400`
  or `A,B,C`. Each becomes a docstrip guard and gets its own random seed.
* `versions_with_solutions`: which of those versions get a separate solution
  file generated (defaults to all of them).
* `version_randomization_groups`: group versions that should share a random
  seed, using `;` within a group and `,` between groups, e.g.
  `A;ms2025,B,C,D` gives a custom student `ms2025` version `A`'s content but
  their own randomization.

### Building documents

Run these from inside a document's own module folder (e.g. `q01/`, `ps1/`),
not from the bundle root:

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
