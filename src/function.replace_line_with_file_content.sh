#!/usr/bin/env bash

replace_line_with_file_content() {

  local sLine sSourceFile

  sLine="${*}"
  sSourceFile="$(get_file_from_string "${sLine}")"

  if [[ -f ${sSourceFile} && -f "../${sSourceFile}" ]]; then
    sSourceFile="../${sSourceFile}"
  fi

  while read -r; do
    # @NOTE: $REPLY is set by `read`
    if [[ ${REPLY:0:2} != '#!' ]]; then
      # Ignore shebang line
      echo "${REPLY}"
    #@TODO: For now we do not recurse into sourced files
    #elif [[ ${REPLY} =~ ^\s*source ]]; then
    #  sLine=$(replace_line_with_file_content "${REPLY}")
    fi
  done < "${sSourceFile}"
}
