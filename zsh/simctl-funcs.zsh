# Useful iOS dev funcs
# Copied from https://github.com/obayer/iosctl

iosbase () {
  simulator_path=$(pgrep -aix launchd_sim | xargs ps -p | tail -n1 | awk '{print $5}' | rev | cut -d / -f5- | rev)

  if [ -n "${simulator_path}" ]; then
    echo ${simulator_path}
  else
    echo "No iOS Simulator is running" >&2
  fi
}

iosapp () {
  find $(iosbase) -iname "$1*.app"
}

iosdata () {
  grep -R "_refreshUUIDForContainer:withError" $(iosbase) --include="mobile_installation.log.0" | grep -i $1 | tail -n1 | awk -F "is now at " '{print $2}'
}

ioslog () {
  local device_id=$(iosbase $1 | rev | cut -d / -f1 | rev)
  echo "${HOME}/Library/Logs/CoreSimulator/${device_id}/system.log"
}
