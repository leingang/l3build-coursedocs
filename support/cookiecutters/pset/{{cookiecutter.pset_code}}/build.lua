#!/usr/bin/env texlua

bundle = "{{cookiecutter.bundle_name}}"
module = "{{cookiecutter.pset_code}}"
maindir = ".."

version = "0.0"
versiondate = "{% now 'local', '%Y-%m-%d' %}"


unpackfiles  = {"*.dtx"}
unpackexe    = "latex" -- required because of the \ProvidesFile

typesetfiles = {"*.*.tex"}
supportdir = "support"
typesetsuppfiles = {"*.png", "*.pdf","*.sty", "latexmkrc","vc*"}
typesetexe = "lualatex"-- typesetexe   = "xelatex"
typesetopts  = "-interaction=nonstopmode -halt-on-error -file-line-error"

dofile(maindir .. "/config.lua")

tagfiles = {"*.dtx","*.lua"}
next_version = next_version_latex

-- l3build install --full will install the pdfs in the directory below
options['texmfhome'] = maindir .. '/../Public/'
-- TODO set sourcefiles to nil only during installation
tdslocations = {'*.*.pdf',"*.dtx"}