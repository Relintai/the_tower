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

rm -Rf ./export

mkdir export
mkdir export/the_tower${version_snake_cased}_android_release
mkdir export/the_tower${version_snake_cased}_android_debug
mkdir export/the_tower${version_snake_cased}_linux
mkdir export/the_tower${version_snake_cased}_windows
mkdir export/the_tower${version_snake_cased}_javascript
mkdir export/the_tower${version_snake_cased}_pi4
mkdir export/the_tower${version_snake_cased}_osx
mkdir export/export_templates_tt${version_snake_cased}

./engine/bin/godot.x11.opt.tools.64 --path ./game/ --export-debug Android-Release ${project_root}/export/the_tower${version_snake_cased}_android_release/the_tower${version_snake_cased}.apk
./engine/bin/godot.x11.opt.tools.64 --path ./game/ --export-debug Android ${project_root}/export/the_tower${version_snake_cased}_android_debug/the_tower_debug${version_snake_cased}.apk
./engine/bin/godot.x11.opt.tools.64 --path ./game/ --export Linux/X11 ${project_root}/export/the_tower${version_snake_cased}_linux/the_tower${version_snake_cased}_x11
./engine/bin/godot.x11.opt.tools.64 --path ./game/ --export "Windows Desktop" ${project_root}/export/the_tower${version_snake_cased}_windows/the_tower${version_snake_cased}.exe
./engine/bin/godot.x11.opt.tools.64 --path ./game/ --export HTML5 ${project_root}/export/the_tower${version_snake_cased}_javascript/the_tower.html
./engine/bin/godot.x11.opt.tools.64 --path ./game/ --export PI4/X11 ${project_root}/export/the_tower${version_snake_cased}_pi4/the_tower${version_snake_cased}_pi4
./engine/bin/godot.x11.opt.tools.64 --path ./game/ --export "Mac OSX" ${project_root}/export/the_tower${version_snake_cased}_osx/the_tower${version_snake_cased}.app

cp ./engine/bin/godot.windows.opt.tools.64.exe ${project_root}/export/godot.tt${version}.windows.opt.tools.64.exe
cp ./engine/bin/godot.x11.opt.tools.64 ${project_root}/export/godot.tt${version}.x11.opt.tools.64
cp ./engine/bin/godot.x11.pi4.opt.tools.32 ${project_root}/export/godot.tt${version}.x11.pi4.opt.tools.32
cp ./engine/bin/godot.javascript.opt.tools.threads.zip ${project_root}/export/godot.tt${version}.javascript.opt.tools.zip
cp ./engine/bin/Godot.app.zip ${project_root}/export/godot.tt${version}.osx.opt.tools.zip

cp ./engine/bin/android_debug.apk ${project_root}/export/export_templates_tt${version_snake_cased}/android_debug.apk
cp ./engine/bin/android_release.apk ${project_root}/export/export_templates_tt${version_snake_cased}/android_release.apk
cp ./engine/bin/godot.javascript.opt.debug.zip ${project_root}/export/export_templates_tt${version_snake_cased}/godot.javascript.opt.debug.zip
cp ./engine/bin/godot.javascript.opt.zip ${project_root}/export/export_templates_tt${version_snake_cased}/godot.javascript.opt.zip
cp ./engine/bin/godot.windows.opt.64.exe ${project_root}/export/export_templates_tt${version_snake_cased}/godot.windows.opt.64.exe
cp ./engine/bin/godot.windows.opt.debug.64.exe ${project_root}/export/export_templates_tt${version_snake_cased}/godot.windows.opt.debug.64.exe
cp ./engine/bin/godot.x11.opt.64 ${project_root}/export/export_templates_tt${version_snake_cased}/godot.x11.opt.64
cp ./engine/bin/godot.x11.opt.debug.64 ${project_root}/export/export_templates_tt${version_snake_cased}/godot.x11.opt.debug.64
cp ./engine/bin/godot.x11.pi4.opt.32 ${project_root}/export/export_templates_tt${version_snake_cased}/godot.x11.pi4.opt.32
cp ./engine/bin/godot.x11.pi4.opt.debug.32 ${project_root}/export/export_templates_tt${version_snake_cased}/godot.x11.pi4.opt.debug.32
cp ./engine/bin/osx.zip ${project_root}/export/export_templates_tt${version_snake_cased}/osx.zip
