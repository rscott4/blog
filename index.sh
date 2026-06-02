#!/usr/bin/env bash

: ${INDEX_JSON_FILE_PATH:="./index.json"}

json=
json+="["
for typ in $@; do
    name="$(grep "^= .*$" "${typ}" | head -1)"
    [ -n "${name}" ] \
        && name="${name:2}" \
        || name="$(basename "${typ}" | sed 's/.typ$//g')"

    mod_times="$(git log --follow --format=%ad --date=unix "${typ}")"
    created="$(echo "${mod_times}" | tail -1)"
    modified="$(echo "${mod_times}" | head -1)"
    typ="./${typ}"
    html="$(echo "${typ}" | sed 's/.typ$/.html/g')"
    pdf="$(echo "${typ}" | sed 's/.typ$/.pdf/g')"
    json+=$(jq --null-input \
        --arg name "${name}" \
        --arg created "${created}" \
        --arg modified "${modified}" \
        --arg typ "${typ}" \
        --arg html "${html}" \
        --arg pdf "${pdf}" \
        "{ \
        name: \$name, \
        created: \$created, \
        modified: \$modified, \
        typ: \$typ, \
        html: \$html, \
        pdf: \$pdf \
        }")
    json+=","
done
[ "$#" != "0" ] && json="${json::-1}"
json+="]"

echo "${json}" | jq > "${INDEX_JSON_FILE_PATH}"
