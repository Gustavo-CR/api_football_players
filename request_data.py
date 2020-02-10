import requests

url = "https://api-football-v1.p.rapidapi.com/v2/players/team/443/2018-2019"

headers = {
    'x-rapidapi-host': "api-football-v1.p.rapidapi.com",
    'x-rapidapi-key': "43972733a1msh24e042b055639acp17bac5jsn8a8251e33def"
    }

response = requests.request("GET", url, headers=headers)

print(response.text)
