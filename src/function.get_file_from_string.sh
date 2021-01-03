#!/usr/bin/env bash

get_file_from_string() {
    local sLine sSourceFile

    sLine="${*}"
    sSourceFile="${sLine#* }"

    # Remove any quotes
    if [[ ${sSourceFile} = *\"* || ${sSourceFile} = *\'* ]]; then
        sSourceFile="${sSourceFile:1:${#sSourceFile}-2}"
    fi

    echo "${sSourceFile}"
}
