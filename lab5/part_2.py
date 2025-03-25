import json

import pandas as pd

# reading the data
with open('../data/schacon.repos.json', 'r') as file:
	data = json.load(file)

# pulls name, html_url, updated_at, visibility
df = pd.json_normalize(data, meta=['name', 'html_url', 'updated_at', 'visibility'])

# only first 5
df = df[['name', 'html_url', 'updated_at', 'visibility']].head(5)

df.to_csv('chacon.csv', index=False, header=False)

print("stuff is in csv now")
