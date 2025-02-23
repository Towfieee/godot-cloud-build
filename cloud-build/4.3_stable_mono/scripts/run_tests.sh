#!/bin/bash
set -e

echo "Running Godot tests..."
~/godot_server/godot.linuxbsd.${GODOT_VERSION}_${RELEASE_NAME}_mono_release.x86_64 -v -e --quit --headless ${GODOT_TEST_ARGS}