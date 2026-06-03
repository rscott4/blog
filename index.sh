#!/usr/bin/env bash

: ${INDEX_JSON_FILE_PATH:="./index.json"}

[ "$#" = "0" ] && echo "{}" > "${INDEX_JSON_FILE_PATH}" && exit 0

json_arr=
json_arr+="{"
for typ in $@; do
    mod_times="$(git log --follow --format=%ad --date=unix "${typ}")"

    git_hash_object="$(git ls-files -s "${typ}" | awk '{ printf $2 }')"
    [ -z "${git_hash_object}" ] && git_hash_object="UNTRACKED_${typ}";
    name="$(grep "^= .*$" "${typ}" | head -1)"
    [ -n "${name}" ] \
        && name="${name:2}" \
        || name="$(basename "${typ}" | sed 's/.typ$//g')"
    created="$(echo "${mod_times}" | tail -1)"
    [ -z "${created}" ] && created=0;
    modified="$(echo "${mod_times}" | head -1)"
    [ -z "${modified}" ] && modified=0;
    path_typ="./${typ}"
    path_html="$(echo "${path_typ}" | sed 's/.typ$/.html/g')"
    path_pdf="$(echo "${path_typ}" | sed 's/.typ$/.pdf/g')"

    printf -v json \
        '"%s": {
            "name": "%s",
            "created": %s,
            "modified": %s,
            "path": {
                "typ": "%s",
                "html": "%s",
                "pdf": "%s"
            }
        }' \
        "${git_hash_object}" "${name}" "${created}" "${modified}" \
        "${path_typ}" "${path_html}" "${path_pdf}"

    json_arr+="${json},"
done
json_arr="${json_arr::-1}"
json_arr+="}"

echo "${json_arr}" | jq \
    "to_entries | sort_by(.value.created) | reverse | from_entries" \
    > "${INDEX_JSON_FILE_PATH}"
