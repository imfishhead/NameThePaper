#!/bin/zsh
set -euo pipefail

project_dir="${0:A:h:h}"
cd "$project_dir"

export CLANG_MODULE_CACHE_PATH="$project_dir/.build/clang-module-cache"
swiftpm_options=(
    --disable-sandbox
    --jobs 1
    --cache-path "$project_dir/.build/swiftpm-cache"
    --config-path "$project_dir/.build/swiftpm-config"
    --security-path "$project_dir/.build/swiftpm-security"
)

swift build -c debug "${swiftpm_options[@]}"
binary_dir="$(swift build -c debug --show-bin-path "${swiftpm_options[@]}")"
app_dir="$project_dir/dist/NameThePaper 0.3.app"

mkdir -p "$app_dir/Contents/MacOS" "$app_dir/Contents/Resources"
cp -X "$binary_dir/namethepaper" "$app_dir/Contents/MacOS/namethepaper"
cp -X "$project_dir/Supporting/Info.plist" "$app_dir/Contents/Info.plist"
cp -X "$project_dir/Assets/namethepaper-icon-1024.png" "$app_dir/Contents/Resources/namethepaper-icon-1024.png"
xattr -cr "$app_dir"
codesign --force --deep --sign - "$app_dir"

echo "$app_dir"
