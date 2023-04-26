#!/bin/bash
source "set-variables.sh"

read -sp "Please provide password" RCLONE_CONFIG_PASS
export RCLONE_CONFIG_PASS
echo

if [ -d $SOURCE_DIR ]
	then
		for DESTINATION in ${DESTINATIONS[@]}
		do
			echo Syncing to $DESTINATION
			rclone -v --ask-password=false sync "$SOURCE_DIR" "$DESTINATION"
		done
		# LONGTERM
		for LONGTERM_DESTINATION in ${LONGTERM_DESTINATIONS[@]}
		do
			echo Syncing to $LONGTERM_DESTINATION
			rclone -v --ask-password=false sync "$LONGTERM_SOURCE_DIR" "$LONGTERM_DESTINATION"
		done
	else
		echo >&2 "Source directory $SOURCE_DIR doesn't exist"
fi
