# NZ EyeTV EPG auto importer

## Why
I wanted an automated download/extract insert of EPG data for EyeTV as the EPG standard used in New Zealand
is MHEG5 which EyeTV doesn't natively support.

There is a [plugin for EyeTV](https://github.com/tokyovigilante/EyeTVEPGParser "EyeTV MHEG5 EPG plugin") 
which can be used to fetch MHEG5 data from your DVB-T stream. 
Thanks to tokyovigilante and SJB and others on Geekzone.

## Instructions
- Download the .sh script.
- Edit the script and change any options at the top.
- Create a cronjob for the script E.G. `30 2 * * * /dvbt/dvbt.sh` to run the script at 2:30 AM every night.

## EPG Feed
Currently the script is using [nzepg.org](http://nzepg.org) for the XML feed. If you know of any other NZ EPG sources please contact me.

---

Tested on Mac OS X 10.6.7 and EyeTV 3.5.1 (6588)