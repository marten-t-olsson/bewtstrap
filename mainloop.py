import requests
import json
import git
import os
import shutil
import ansible_runner
import socket

def read_hostname():
    hostname = socket.gethostname()
    return str(hostname)

def prepare_config(config_dir):
    if not os.path.exists(config_dir):
        os.makedirs(config_dir)

def download_config(url, config_path):
    try:
        response = requests.get(url)
        response.raise_for_status()
        json_data = response.json()

        with open(config_path, 'w') as file:
            json.dump(json_data, file, indent=4)

        print(f"JSON content has been successfully written to {config_path}")

    except requests.exceptions.RequestException as e:
        print(f"An error occurred: {e}")


def load_config(file_path):
    try:
        with open(file_path, 'r') as file:
            config = json.load(file)
            return config

    except Exception as e:
        print(f"An error occurred: {e}")

def prepare_repo(work_root_dir):
    if os.path.exists(work_root_dir):
        print("Working directory: " + work_root_dir + " exists. Removing it before cloning repos")
        shutil.rmtree(work_root_dir)

def clone_repo(repo_url, tag, dest_dir):
    try:
        if not os.path.exists(dest_dir):
            os.makedirs(dest_dir)

        # Clone the repository with the specified tag and depth of 1
        repo = git.Repo.clone_from(
            repo_url,
            dest_dir,
            branch=tag,
            depth=1
        )

        print(f"Repository cloned successfully into '{dest_dir}' with tag '{tag}'.")

    except Exception as e:
        print(f"An unexpected error occurred: {e}")

def loop_repos(config):
    try:
        for playbook in config['read'][0]['playbooks']:
            name = playbook['name']
            tag = playbook['tag']
            repo_dir = work_root_dir + "/" + name
            repo_url = repo_base_url + "/" + name
            clone_repo(repo_url, tag, repo_dir)

            r = ansible_runner.run(private_data_dir=repo_dir, playbook='main.yml')

    except Exception as e:
        print(f"An error occurred: {e}")


# Root directory where all repositories are cloned to
work_root_dir="/usr/local/sbin/mainloop/workdir"

# URL where we download the config for the device
base_url = 'http://192.168.64.1:5001/read/serial/'
url = 'http://192.168.64.1:5001/read/serial/' + read_hostname()

# URL to where git repositories are found
repo_base_url = "https://github.com/marten-t-olsson"

# Config path/filename
config_dir = "/etc/mainloop/"
config_filename = "config.json"
config_path = config_dir + config_filename


prepare_config(config_dir)
download_config(url, config_path)

file_path = config_path
config = load_config(file_path)
if config:
    prepare_repo(work_root_dir)
    loop_repos(config)
