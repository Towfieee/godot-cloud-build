#!/bin/bash
set -e

echo "Downloading Godot engine and export templates..."

mkdir -p $GSUTIL_DEST
mkdir -p $EXPORT_TEMPLATES_DIR

gsutil cp ${GAME_ENGINE_DIR}/godot.linuxbsd.${GODOT_VERSION}_${RELEASE_NAME}_mono_release.x86_64.zip ${GSUTIL_DEST}/godot.linuxbsd.${GODOT_VERSION}_${RELEASE_NAME}_mono_release.x86_64.zip
gsutil cp ${GAME_ENGINE_DIR}/export-templates/Godot_v${GODOT_VERSION}_${RELEASE_NAME}_export_templates.zip ${GSUTIL_DEST}/Godot_v${GODOT_VERSION}_${RELEASE_NAME}_export_templates.zip

echo "Extracting files..."
unzip -o ${GSUTIL_DEST}/godot.linuxbsd.${GODOT_VERSION}_${RELEASE_NAME}_mono_release.x86_64.zip -d $GSUTIL_DEST
unzip -o ${GSUTIL_DEST}/Godot_v${GODOT_VERSION}_${RELEASE_NAME}_export_templates.zip -d $EXPORT_TEMPLATES_DIR

# Remove zip files after extraction
rm -f ${GSUTIL_DEST}/*.zip
