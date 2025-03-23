
#1.  the sheband/hashbang

#!/bin/bash

#2. Fetches the METAR data

curl -s "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hours=12&bbox=40%2C-90%2C45%2C-85" > aviation.json

#3. Parses the data and pulls out the receiptTime value
#4. OUTPUTS only the first six values to the screen

jq '.[].receiptTime' aviation.json | head -n 6

#5. Parses the data and pulls out each of the tempurature
#6. OUTPUTS the average tempurature across the 12 hours
avgTemp=$(jq '[.[].temp] | add / length' aviation.json)
echo "Average Tempurature: $avgTemp"

#7. Parses the data and pulls out each of the tempurature
#8. OUTPUTS a boolean response for if more than half of the last 12 hours were cloudy (i.e. not CLR)

cloudy_count=$(jq '[.[] | select(.clouds[].cover != "CLR")] | length' aviation.json)
total_reports=$(jq 'length' aviation.json)


cloudy=false

if [ "$cloudy_count" -gt "$((total_reports/2))" ]; then
	cloudy=true
fi

echo "Mostly Cloudy: $cloudy"
