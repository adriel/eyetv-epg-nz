#!/bin/bash

# Location of EyeTV
EYETV_FILENAME="/Applications/EyeTV.app"

XML_GZ_URL="http://nzepg.org/freeview.xml.gz"
GZ_FILE_NAME=$(basename "$XML_GZ_URL")
EXTRACTED_FILE_NAME="freeview.xml"

# 
# Leave the rest of the script as is unless you know what your doing
#

# Determine absolute path to this script                                                                                                                                 
LOCATION_OF_SCRIPT="`dirname $0`"
LOCATION_OF_SCRIPT=`cd $LOCATION_OF_SCRIPT;pwd`/
# Check this location is to be readable/writable/executable by the user this script is running as                                                                        
if [ ! -w $LOCATION_OF_SCRIPT -o ! -x $LOCATION_OF_SCRIPT -o ! -r $LOCATION_OF_SCRIPT ]; then
  echo "Error 0: This script must be placed in a directory that is readable, "
  echo "writable and executable by the user running this script. The directory"
  echo " '$LOCATION_OF_SCRIPT' is not. Exiting script"
  exit 1
fi

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