from typing import Text
import requests
import json

def main():
    print("List of users recently watched quickemu:")
    print("-------------------")
    r = requests.get('https://api.github.com/users/quickemu-project/events')
    json_data = json.loads(r.text)
    for i in json_data:
        if i['type'] == "WatchEvent":
            print(i['actor']['display_login'])
    print("-------------------")
if __name__ == '__main__':
    main()