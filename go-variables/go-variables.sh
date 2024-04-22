#! /usr/bin/env bash

set -e
set -x

# echo "repos=("; curl -sSL "https://api.github.com/orgs/golang/repos?per_page=100" | jq '.[] | .name' | sort && echo ")"
repos=(
# ".allstar"
# "appengine"
# "arch"
"benchmarks"
# "blog"
# "build"
"crypto"
# "cwg"
"debug"
# "dep"
# "dl"
# "example"
"exp"
"freetype"
# "gddo"
"geo"
# ".github"
"glog"
"go"
"gofrontend"
# "go-get-issue-15410"
# "govulncheck-action"
"groupcache"
"image"
# "leveldb"
# "lint"
"mobile"
# "mock"
"mod"
"net"
"oauth2"
"perf"
# "pkgsite"
# "pkgsite-metrics"
"playground"
# "proposal"
"protobuf"
# "review"
"scratch"
"snappy"
# "sublime-build"
# "sublime-config"
"sync"
"sys"
# "talks"
"telemetry"
"term"
"text"
"time"
"tools"
"tour"
# "vgo"
"vscode-go"
"vuln"
# "vulndb"
# "website"
# "wiki"
# "winstrap"
"xerrors"
)

for repo in "${repos[@]}"; do
    echo "https://github.com/golang/$repo"
    mkdir -p tmp
    [ -d "tmp/$repo" ] || git clone --depth 1 "https://github.com/golang/$repo" "tmp/$repo"
    pushd "tmp/$repo"
    branch="$(git rev-parse --abbrev-ref HEAD)"
    find . -name '*.go' ! -name '*_test.go' -exec grep -nH -oP '([gG]etenv\(["`][A-Z0-9_]+["`])|([sS]etenv\(["`][A-Z0-9_]+["`],)|(envOr\(["`][A-Z0-9_]+["`],)|(EnvVar\{Name: ["`][A-Z0-9_]+["`])|(LookupEnv\(["`][A-Z0-9_]+["`])' {} + | \
        grep -vP '"TZ"|"CC"|"GCC"|"TMPDIR"|"USER"|"PWD"|"HOME"|"ZONEINFO"|"CXX"|"AR"|"APPDATA"|"DISPLAY"|"BROWSER"' | \
        grep -vP '"PATH"|"FC"|"FOO"|"LANG"|"LANGUAGE"|"LOCALAPPDATA"|"ROOT"|"PORT"|"HOMEDRIVE"|"HOMEPATH"' | \
        grep -vP '"XDG_|"CGO_"|"ANDROID_|"ASR_CONFIG"|"AWS_|"BENCH_|"LC_ALL"|"HTTP_PROXY"|"NO_PROXY"|"TERM"' | \
        grep -vP '"USERPROFILE"|"CLOUDSQL_|"GAE_|"DOES_NOT_EXIST"' | \
        sed -E "s@^\.@https://github.com/golang/$repo/blob/$branch@" | \
        sed -E 's@.go:([0-9]+):@.go#L\1: @' | \
        tee -a ../../results.txt || true
    popd
done

cat results.txt | grep -oP '(?<=")[A-Za-z\d_]+(?=")' | sort -u | sed -E 's@^@- @g'
