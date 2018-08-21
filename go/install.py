import subprocess

def get_shell_output(args_string):
    args = args_string.split()
    result = subprocess.run(args, stdout=subprocess.PIPE)

    stdout = result.stdout.decode('utf-8')
    return stdout


f = open("dependencies.txt", "r")
lines = f.readlines()
for l in lines:
    print(f"Installing {l}")
    o = get_shell_output(f"go get -u {l}")
    print(o)
