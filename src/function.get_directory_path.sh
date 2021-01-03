#!/usr/bin/env bash

get_directory_path() {
  ( unset CDPATH && cd "${1}" && pwd -P )
}
