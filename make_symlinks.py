import subprocess
from pathlib import Path

OLD_FILE_PATH = "~/.old_dotfiles/"


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
        if folder == "~":
            continue

        path_prefix = "/".join(folders[0:i])
        get_shell_output(f"mkdir -p {path_prefix}/{folder}")


def make_symlink(source, target):
    return get_shell_output(f"ln -sv {source} {target}")


def move_existing_file(target):
    get_shell_output(f"mv {target} {OLD_FILE_PATH}")


# MAIN

_ = get_shell_output(f"mkdir -p {OLD_FILE_PATH}")

p = str(Path.home()) + "/.dotfiles/symlinks.txt"
f = open(p)

lines = f.readlines()
for l in lines:
    source = l.split()[0]
    target = l.split()[1]

    print("Moving existing file if existing")
    move_existing_file(target)

    if target != "~/":
        print(f"Making folders for {target}")
        folder_output = make_folders(target)
        if folder_output is not None:
            print(folder_output)

    print(f"Symlinking {source} to {target}\n")
    symlink_output = make_symlink(source, target)
    print(symlink_output)
