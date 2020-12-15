#!/bin/bash
lazy_download(){
    local _URL=$1
    local _DEST=$2
    local _URLMD5=`/bin/echo ${_URL} | /usr/bin/md5sum | /bin/cut -f1 -d" "`
    local _FILENAME="${_URLMD5}_$(basename "${_URL}")"
    local _DOWNLOAD_FILEPATH=${_CACHEDIR}/${_FILENAME}

    # Download to files directory
    echo_debug "Lazy Downloading ${_URL} ..."
    if [ -f "${_DOWNLOAD_FILEPATH}" ]; then
        echo_debug "    File ${_FILENAME} already exists on cache!"
    else
        echo_debug "    Downloading file from ${_URL} ..."
        wget ${_URL} -O "${_DOWNLOAD_FILEPATH}"
    fi

    echo_debug "    ... saving it to ${_DEST}."
    cp "${_DOWNLOAD_FILEPATH}" "${_DEST}"
}
