# import the necessary libraries
import os
import random
from scripts.locust_test import HttpUser, task, between
from requests.auth import HTTPBasicAuth

# define the class NextcloudUser for the user, wait-time between tasks and the actual tasks that will be performed to test the Nextcloud server
class NextcloudUser(HttpUser):
    auth = None # authentication
    user_name = None # nextcloud username
    wait_time = between(2, 5) # wait time between tasks

    # define the on_start method to initialize the user
    def on_start(self):
        user_idx = random.randrange(0, 29)
        self.user_name = f'user{user_idx}'
        self.auth = HTTPBasicAuth(self.user_name, 'testanelcloud')

    # define the tasks that will be performed by the user:
    # upload a 1GB file
    @task(1)
    def upload_file_1gb(self):
        remote_path = f"/remote.php/dav/files/{self.user_name}/1gb_file_{random.randrange(0, 10)}"
        with open("big-file", "rb") as file:
            self.client.put(remote_path, data=file, auth=self.auth)

    # upload a 1KB file
    @task(10)
    def upload_file_1kb(self):
        remote_path = f"/remote.php/dav/files/{self.user_name}/1kb_file_{random.randrange(0, 10)}"
        with open("small-file", "rb") as file:
            self.client.put(remote_path, data=file, auth=self.auth)

    # upload a 1MB file
    @task(5)
    def upload_file_1mb(self):
        remote_path = f"/remote.php/dav/files/{self.user_name}/1mb_file_{random.randrange(0, 10)}"
        with open("medium-file", "rb") as file:
            self.client.put(remote_path, data=file, auth=self.auth)

    # upload an image file (png)
    @task(2)
    def upload_file_png(self):
        remote_path = f"/remote.php/dav/files/{self.user_name}/example_{random.randrange(0, 10)}.png"
        with open("img.jpeg", "rb") as file:
            self.client.put(remote_path, data=file, auth=self.auth)

    # send a PROPFIND request (get the properties of a file)
    @task(1)
    def propfind(self):
        self.client.request("PROPFIND", f"/remote.php/dav/files/{self.user_name}/", auth=self.auth)

    # send a GET request to read a file (Readme.md)
    @task(1)
    def read_file(self):
        self.client.get(f"/remote.php/dav/files/{self.user_name}/Readme.md", auth=self.auth)
