#!/bin/bash

# Location of EyeTV
EYETV_FILENAME="/Applications/EyeTV.app"

# This locaation has to be readable/writable/executable by the user the cronjob is run as (script will return an error if it's not)
LOCATION_OF_SCRIPT="/dvbt/"

XML_GZ_URL="http://nzepg.org/freeview.xml.gz"
GZ_FILE_NAME=$(basename "$XML_GZ_URL")
EXTRACTED_FILE_NAME="freeview.xml"

# 
# Leave the rest of the script as is unless you know what your doing
#

if [[ ! -f "${LOCATION_OF_SCRIPT}${GZ_FILE_NAME}" ]]; then

	# Download zip
	echo "Downloading XML gz"
	# curl -O -s "$XML_GZ_URL" > "${LOCATION_OF_SCRIPT}${EXTRACTED_FILE_NAME}.gz"
	curl --output "${LOCATION_OF_SCRIPT}${GZ_FILE_NAME}" "$XML_GZ_URL"

	# Check to see the gz file was downloaded
	if [[ ! -f ${LOCATION_OF_SCRIPT}${GZ_FILE_NAME} ]]; then
		echo "Error 1: Could not find downloaded xml file at '${LOCATION_OF_SCRIPT}${GZ_FILE_NAME}' exiting script"
		exit 1
	fi
		
	# Unzip file 
	echo "Extracting xml.gz file ${LOCATION_OF_SCRIPT}${EXTRACTED_FILE_NAME}"
	gzip -d "${LOCATION_OF_SCRIPT}${GZ_FILE_NAME}" -c > "${LOCATION_OF_SCRIPT}${EXTRACTED_FILE_NAME}"
	
	# Check to see the xml file was extracted
	if [[ ! -f "${LOCATION_OF_SCRIPT}${EXTRACTED_FILE_NAME}" ]]; then
		echo "Error 2: Could not find extracted xml file at '${LOCATION_OF_SCRIPT}${EXTRACTED_FILE_NAME}' exiting script"
		exit 1
	fi

	# Open the xml file with EyeTV in the background
	echo "Opens xml file with $EYETV_FILENAME"
	open -g "${LOCATION_OF_SCRIPT}${EXTRACTED_FILE_NAME}" -a "$EYETV_FILENAME"
	
	# Clean up
	echo "Deleting gz and extracted xml files"
	# Delete the old gz file
	rm "${LOCATION_OF_SCRIPT}${GZ_FILE_NAME}"
	# Delete extracted xml file
	rm "${LOCATION_OF_SCRIPT}${EXTRACTED_FILE_NAME}"
	
else
	echo "'${LOCATION_OF_SCRIPT}${GZ_FILE_NAME}' already exists"
fi