#!/bin/bash
set -e

version=""
version_snake_cased=""

if [ ! -z $1 ]; then
    version="."
    version+=$1

    version_snake_cased=${version//./_}
fi

project_root=$(pwd)

rm -Rf ./release

mkdir release

cd export

rm -Rf the_tower${version_snake_cased}_full_source
rm -Rf the_tower${version_snake_cased}_game_source

mkdir the_tower${version_snake_cased}_full_source
mkdir the_tower${version_snake_cased}_game_source

# Warn if a file is over a megabyte. Used to catch big temporary files that would slip through outherwise
python ../tools/copy_repos.py ../ ./the_tower${version_snake_cased}_full_source 1048576
python ../tools/copy_repos.py ../game/ ./the_tower${version_snake_cased}_game_source

zip -q ../release/the_tower${version_snake_cased}_android_debug.zip  ./the_tower${version_snake_cased}_android_debug/*
zip -q ../release/the_tower${version_snake_cased}_android_release.zip  ./the_tower${version_snake_cased}_android_release/*
zip -q ../release/the_tower${version_snake_cased}_javascript.zip  ./the_tower${version_snake_cased}_javascript/*
zip -q ../release/the_tower${version_snake_cased}_linux.zip  ./the_tower${version_snake_cased}_linux/*
zip -q ../release/the_tower${version_snake_cased}_windows.zip  ./the_tower${version_snake_cased}_windows/*
zip -q ../release/the_tower${version_snake_cased}_pi4.zip  ./the_tower${version_snake_cased}_pi4/*
zip -r -q ../release/the_tower${version_snake_cased}_osx.zip  ./the_tower${version_snake_cased}_osx/*

# Editor
zip -q ../release/editor_windows_tt${version_snake_cased}.zip  ./godot.tt${version}.windows.opt.tools.64.exe
zip -q ../release/editor_linux_tt${version_snake_cased}.zip  ./godot.tt${version}.x11.opt.tools.64
zip -q ../release/editor_pi4_tt${version_snake_cased}.zip  ./godot.tt${version}.x11.pi4.opt.tools.32
cp  ./godot.tt${version}.javascript.opt.tools.zip ../release/editor_javascript_tt${version_snake_cased}.zip
zip -q ../release/editor_osx_tt${version_snake_cased}.zip  ./godot.tt${version}.osx.opt.tools.zip

zip -q ../release/export_templates_tt${version_snake_cased}.zip  ./export_templates_tt${version_snake_cased}/*

zip -q -r ../release/the_tower${version_snake_cased}_full_source.zip  ./the_tower${version_snake_cased}_full_source/*
zip -q -r ../release/the_tower${version_snake_cased}_game_source.zip  ./the_tower${version_snake_cased}_game_source/*

cd ..

