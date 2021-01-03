#!/usr/bin/env bash

set -o errexit -o errtrace -o nounset -o pipefail

inline_source() {
source 'deps/includes/src/declare/declare.exit-codes.inc'
source 'src/function.get_directory_path.sh'
source 'src/function.get_file_from_string.sh'
source 'src/function.get_file_path.sh'
source 'src/function.replace_line_with_file_content.sh'

  # @TODO: Create separate "handle_params" function
  # @TODO: Add usage/help message and params

  if [[ $# -lt 1 || $1 == "" ]]; then
    echo 'One parameter expected: <source-file>' >&2
    exit "${EXIT_NOT_ENOUGH_PARAMETERS}"
  else
    local sSourceDirectory sSourceFilePath sTrimmedLine

    readonly sSourceFilePath="$(get_file_path "${1}")"
    readonly sSourceDirectory=$(dirname "${sSourceFilePath}")

    pushd "${sSourceDirectory}" > /dev/null || exit "${EXIT_COULD_NOT_FIND_DIRECTORY}"

    while read -r; do
      # @NOTE: $REPLY is set by `read`
      sTrimmedLine="$(echo "${REPLY}" | xargs)"

      if [[ "${sTrimmedLine:0:7}" = 'source ' && ${REPLY} != *\$* ]]; then
        replace_line_with_file_content "${REPLY}"
      else
        echo "${REPLY}"
      fi
    done < "${sSourceFilePath}"

    popd > /dev/null 2>&1 || true
  fi
}

if [[ ${BASH_SOURCE[0]} != "$0" ]]; then
  export -f inline_source
else
  inline_source "${@-}"
  exit ${?}
fi

# EOF
