#!/bin/bash
# Extract Tweets for a user using TWINT then extract Youtube links from it
#
# CSV separator is COMMA
#
# Requirements : 
#  - TWINT
#  - CSV tool (sudo apt install csvtool)

# You can modify this link to the location you prefer
BASEDIR=~/TwitterLinksExtractor

# Do not modify these values
USERNAME=$1
DATETIME=$(date +'%Y%m%d-%H%M%S')
WORKDIR="$BASEDIR/$USERNAME/$DATETIME"
TWEETLISTCSV="$WORKDIR/tweetlist.csv"
TWEETLIST="$WORKDIR/tweetlist.txt"
URLSLIST="$WORKDIR/urlslist.txt"
URLSYOUTUBE="$WORKDIR/urlsyoutube.txt"
URLSSPOTIFY="$WORKDIR/urlsspotify.txt"
URLSDEEZER="$WORKDIR/urlsdeezer.txt"

# Initial Display
echo "Username: $USERNAME"
echo "Working Directory : $WORKDIR"

# Directory creation
echo
echo "Directory Creation"

mkdir -p $WORKDIR
cd $WORKDIR


# Extract tweets to CSV using Twint
echo
echo "Extraction of the tweets"

twint -u $USERNAME -o $TWEETLISTCSV --csv


# Extract Tweets column only from CSV
echo
echo "Extraction of the column containing only tweets"

# AWK command does not work if the column has carriage returns in cells
#awk -F "\"*,\"*" '{print $11}' $TWEETLISTCSV > $TWEETLIST

# Using CSV Tool instead
csvtool col 11 $TWEETLISTCSV > $TWEETLIST

# Extract URLS
echo
echo "Extraction of the URLS"

cat $TWEETLIST | grep http | grep -shoP 'http.*?[" >]' > $URLSLIST


# Normalizing URLs (Remove trailing dots, spaces, Remove mobile, use long Youtube addresses)
echo
echo "Normalisation of the URLS"

sed -e "s/ …//g" -i $URLSLIST
sed -e "s/ //g" -i $URLSLIST
sed 's,",,g' -i $URLSLIST
sed 's,//m.,//,g' -i $URLSLIST
sed 's,youtu.be/,youtube.com/watch?v=,g' -i $URLSLIST

# Select only Youtube.com links
echo
echo "Extraction of the Youtube URLS"
cat $URLSLIST | grep youtu > $URLSYOUTUBE

echo
echo "Extraction of the Spotify URLS"
cat $URLSLIST | grep spotify > $URLSSPOTIFY

echo
echo "Extraction of the Deezer URLS"
cat $URLSLIST | grep deezer > $URLSDEEZER

