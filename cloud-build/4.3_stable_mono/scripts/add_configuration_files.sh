#!/bin/bash
set -e

echo "Adding necessary configuration files..."

echo '[gd_resource type="EditorSettings" format=3]' > ${EDITOR_DEST}/editor_settings-${GODOT_VERSION:0:3}.tres
echo '[resource]' >> ${EDITOR_DEST}/editor_settings-${GODOT_VERSION:0:3}.tres

echo 'export/windows/rcedit = "/opt/rcedit.exe"' >> ${EDITOR_DEST}/editor_settings-${GODOT_VERSION:0:3}.tres
echo 'export/windows/wine = "/usr/bin/wine64-stable"' >> ${EDITOR_DEST}/editor_settings-${GODOT_VERSION:0:3}.tres

chmod +x ~/godot_server/godot.linuxbsd.${GODOT_VERSION}_${RELEASE_NAME}_mono_release.x86_64