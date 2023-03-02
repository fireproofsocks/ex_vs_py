# import os
from os.path import exists
import json
from time import time

index_file = "tmp/files/index.txt"


def vet_files():
    with open(index_file, 'r') as myfile:
        for line in myfile:
            open_json_file(line.rstrip())
            # dict_obj = json.loads(person_data)


def open_json_file(json_file):
    with open(json_file, 'r') as myfile:
        for line in myfile:
            data = json.loads(line)
            files_exist(data['paths'])


def files_exist(paths):
    for p in paths:
        exists(p)


if __name__ == "__main__":
    start_time = int(time() * 1000)
    vet_files()
    end_time = int(time() * 1000)
    print(f'Duration: {end_time - start_time} ms')
