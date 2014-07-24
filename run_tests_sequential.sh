#!/bin/bash
##
# Reproduce SBT issue #1117 "No scala version specified or detected" by
#   building a Play 2.0.x project, followed by a Play 2.3.x project.
##

##
# Setup
##

# Download and unzip old Play version per old instructions
# See http://www.playframework.com/documentation/2.0.x/Installing
OLD_PLAY_VERSION=2.0.8
wget -N http://downloads.typesafe.com/play/${OLD_PLAY_VERSION}/play-${OLD_PLAY_VERSION}.zip
[[ -d ./play-${OLD_PLAY_VERSION}/ ]] || unzip -q play-${OLD_PLAY_VERSION}.zip
OLD_PLAY="$(pwd)/play-${OLD_PLAY_VERSION}/play"

# Download sbt-extras script
GH_COMMIT=cd6e88fc5bc4243277e603d78084b4bb266a4ffc
wget -N https://raw.githubusercontent.com/paulp/sbt-extras/${GH_COMMIT}/sbt
chmod u+x ./sbt
SBT_EXTRAS="$(pwd)/sbt"

# Build old Play project using old 'play' command
pushd sample-play-2.0.x
${OLD_PLAY} test
popd

# Build new Play project using sbt-extras script
pushd sample-play-2.3.x
${SBT_EXTRAS} test
popd

