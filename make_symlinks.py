import subprocess
import os
import re
from pathlib import Path

home = str(Path.home())
OLD_FILE_PATH = home + "/.old_dotfiles"


def get_shell_output(args_string):
    args = args_string.split()
    result = subprocess.run(args, stdout=subprocess.PIPE)

    stdout = result.stdout.decode("utf-8")
    return stdout


def make_folders(path):
    if path[-1] == "/":
        path = path[:-1]  # Remove last char

    folders = path.split("/")
    for i, folder in enumerate(folders):
        if folder == f"{home}/" or folder == home:
                continue

        path_prefix = "/".join(folders[0:i])
        print(f"mkdir -p {path_prefix}/{folder}")
        _ = get_shell_output(f"mkdir -p {path_prefix}/{folder}")


def make_symlink(source, target):
    return get_shell_output(f"ln -sfv {source} {target}")


def move_existing_file(target):
    _ = get_shell_output(f"mv {target} {OLD_FILE_PATH}/")


# MAIN

_ = get_shell_output(f"mkdir -p {OLD_FILE_PATH}")

p = home + "/.dotfiles/symlinks.txt"
f = open(p)

lines = f.readlines()
for l in lines:
    source = l.split()[0].replace("~", home)
    target = l.split()[1].replace("~", home)

    file_pattern = r'([\w|\.]+)\s'
    match = re.findall(file_pattern, l)
    if match:
        print("Moving existing file")
        existing_file_path = target + match[0]
        print(existing_file_path)
        move_existing_file(existing_file_path)

    if target != f"{home}/" and target != home:
        print(f"Making folders for {target}")
        folder_output = make_folders(target)
        if folder_output is not None:
            print(folder_output)

    print(f"Symlinking {source} to {target}\n")
    symlink_output = make_symlink(source, target)
    print(symlink_output)
