#!/bin/bash

input_file="output.txt"
output_file="websites.csv"

echo "Site, Title, Summary" > "$output_file"

# loop through the input file
while read -r line; do
  # extract the URL from the input line
  site=$(echo "$line" | awk '{print $4}')

  # determine whether the URL uses http or https
  if [[ "$site" == http://* ]]; then
    scheme="http"
    site=${site#http://}
  elif [[ "$site" == https://* ]]; then
    scheme="https"
    site=${site#https://}
  else
    scheme=""
  fi

  # extract the IP address from the input line
  ip=$(echo "$line" | awk '{print $6}')

  # extract the title from the input line
  title=$(echo "$line" | grep -i 'Title' | cut -d':' -f2- | sed 's/^ *//')

  # extract the summary from the input line
  summary=$(echo "$line" | grep -i 'Summary' | cut -d':' -f2- | sed 's/^ *//')

  # write the output line to the output file
  echo "${scheme}://${site}, ${ip}, \"$title\", \"$summary\"" >> "$output_file"

done < "$input_file"
