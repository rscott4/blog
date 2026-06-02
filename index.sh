#!/usr/bin/env bash

: ${INDEX_JSON_FILE_PATH:="./index.json"}

[ "$#" = "0" ] && echo "{}" > "${INDEX_JSON_FILE_PATH}" && exit 0

json_arr=
json_arr+="["
for typ in $@; do
    mod_times="$(git log --follow --format=%ad --date=unix "${typ}")"

    name="$(grep "^= .*$" "${typ}" | head -1)"
    [ -n "${name}" ] \
        && name="${name:2}" \
        || name="$(basename "${typ}" | sed 's/.typ$//g')"
    created="$(echo "${mod_times}" | tail -1)"
    modified="$(echo "${mod_times}" | head -1)"
    path_typ="./${typ}"
    path_html="$(echo "${path_typ}" | sed 's/.typ$/.html/g')"
    path_pdf="$(echo "${path_typ}" | sed 's/.typ$/.pdf/g')"

    printf -v json \
        '{
            "name": "%s",
            "created": "%s",
            "modified": "%s",
            "path": {
                "typ": "%s",
                "html": "%s",
                "pdf": "%s"
            }
        }' \
        "${name}" "${created}" "${modified}" \
        "${path_typ}" "${path_html}" "${path_pdf}"

    json_arr+="${json},"
done
json_arr="${json_arr::-1}"
json_arr+="]"

echo "${json_arr}" | jq > "${INDEX_JSON_FILE_PATH}"
