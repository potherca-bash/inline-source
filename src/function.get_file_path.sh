#!/usr/bin/env bash

get_file_path() {
    local sFile sFileName sPath

    readonly sFile="${1}"

    readonly sFileName=$(basename "${sFile}")
    readonly sPath="$(get_directory_path "$(dirname "${sFile}")")"

    echo "${sPath}/${sFileName}"
}
