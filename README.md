# TwitterLinksExtractor
Retreive Tweets from a User Timeline and export all links to separated text files

## Requirements
- Bash
- Python3
- TWINT (https://github.com/twintproject/twint)
- CSV Tools

## Tested on
- Ubuntu 18.04

## Installation (Ubuntu 18.04 LTS)
Install python3 and pip3 : 
sudo apt install python3 python3-pip

Install CSVTool : 
sudo apt install csvtool

Clone this repository in your favorite location

## Usage

### Run the tool
Run the bash script from this repository with the Twitter username as a parameter, without the @ sign.
eg: ./tle.sh jack

### What the script is actually doing
The script will be creating repository for all the extract your will run in a folder structure like this one:
/home/(YourUsername)/TwitterLinkExtractor/(TwitterUsername)/(DateTime)/

Every stage of the extraction creates a different file :
- A CSV file with all the tweets from the user's TL
- A text file with only the tweets without all other info (extract of column 11 from the CSV using CSVTool)
- A text file of all the links the script found
- Separate files for each type of links

## Supported links
At the moment the script separates links from the following sources:
- Youtube
- Spotify
- Deezer

It could simply adapted to catch other webistes.

## Alternative Scrapers
At the moment the script is using TWINT as a scrapper but you could use some others
- https://github.com/taspinar/twitterscraper
- https://github.com/bisguzar/twitter-scraper

