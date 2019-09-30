import json

def parseJson(file):
  try:
    with open(file, encoding='utf-8') as f:
      json_file = json.load(f)
    return json_file

  except IOError as e:
    return "an error occured while reading file"