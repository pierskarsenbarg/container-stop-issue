#!/bin/bash

pulumi up -f -s dev

echo $?

if [ $? -ne 0 ]; then
  echo "error occurred when running pulumi command for ${project_name}"
  exit 1
fi

shell_event_handler() {
    echo "${1} received."

    case "${1}" in
        "SIGTERM")
            exit 143
            ;;
        "SIGHUP")
            exit 129
            ;;
        "SIGINT")
            exit 130
            ;;
        "SIGKILL")
            exit 137
            ;;
        "SIGQUIT")
            exit 131
            ;;
        "EXIT")
            exit 255
            ;;
        *)
            exit 1
            ;;
    esac
}

trap 'shell_event_handler SIGTERM' SIGTERM
trap 'shell_event_handler SIGHUP' SIGHUP
trap 'shell_event_handler SIGINT' SIGINT
trap 'shell_event_handler SIGKILL' SIGKILL
trap 'shell_event_handler SIGQUIT' SIGQUIT
trap 'shell_event_handler EXIT' EXIT