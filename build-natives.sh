#!/usr/bin/env bash

rm -r ./java/src/main/resources/zipfastnatives
mkdir -p ./java/src/main/resources/zipfastnatives

declare -a Targets=("aarch64-linux-gnu" "i386-linux-gnu" "x86_64-linux-gnu" "powerpc64le-linux-gnu" "i386-windows-gnu" "x86_64-windows-gnu" "x86_64-macos-none" "aarch64-macos-none")

cd zig || exit

for target in "${Targets[@]}"; do
    rm -r zig-out
    printf "\-\-\-\nBuilding %s\n\-\-\-\n\n\n" "$target"
    if [ "$target" == "aarch64-macos-none" ];
    then
        zig build -Drelease-fast=true -Dtarget="$target" -Dcpu=apple_m1 || exit
    else
        zig build -Drelease-fast=true -Dtarget="$target" || exit
    fi
    mkdir ../java/src/main/resources/zipfastnatives/"$target"
    find zig-out/ -type f -name "*.so" -exec cp {} ../java/src/main/resources/zipfastnatives/"$target"/ \;
    find zig-out/ -type f -name "*.dll" -exec cp {} ../java/src/main/resources/zipfastnatives/"$target"/ \;
    find zig-out/ -type f -name "*.dylib" -exec cp {} ../java/src/main/resources/zipfastnatives/"$target"/ \;
done

cd ..