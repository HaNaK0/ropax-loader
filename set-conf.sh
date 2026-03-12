#! /bin/bash
platform="${1}-conf.lua"
echo "setting ${platform} as conf.lua"
cat $platform >> conf.lua
