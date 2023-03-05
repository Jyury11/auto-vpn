import subprocess
import inquirer

# --------------------------------------------------
#                   definitions
# --------------------------------------------------
ERR_CODE = 1

# --------------------------------------------------
#                   functions
# --------------------------------------------------
def command(cmd: list[str]):
  code = subprocess.run(cmd).returncode
  if ERR_CODE <= code:
    raise Exception("command failed.")

def command_with_ret(cmd: list[str]) -> str:
  ret = subprocess.Popen(
      cmd, stdout=subprocess.PIPE,
      shell=True
  ).communicate()[0].decode('utf-8').split("\n")
  return list(filter(None, ret))

# --------------------------------------------------
#                      main
# --------------------------------------------------

# gcloud configurations
print("\n-----setup gcloud auth------")
command(["gcloud", "auth", "login", "--no-launch-browser"])

print("\n-----setup gcloud project------")
projects = command_with_ret("gcloud projects list | awk '{ print $1 }' | grep -v PROJECT_ID")
if len(projects) == 0:
  raise Exception("failed get projects")

questions = [
  inquirer.List('projects',
      message="Please choice your project ",
      choices=projects,
  ),
]
answers = inquirer.prompt(questions)
command(["gcloud", "config", "set", "project", answers["projects"]])

print("\n-----setup gcloud auth default------")
command(["gcloud", "auth", "application-default", "login", "--no-launch-browser"])
