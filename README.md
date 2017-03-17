# CryptoTrade

[![Build Status](https://travis-ci.org/matthewsedam/cryptotrade.svg?branch=master)](https://travis-ci.org/matthewsedam/cryptotrade)

CryptoTrade is a cryptocurrency trading program written in Chapel.
See [this](https://github.com/chapel-lang/chapel) for more information about Chapel.

Copyright 2017 Matthew Sedam. All rights reserved.

CryptoTrade is released under the Apache License 2.0.
See [LICENSE](LICENSE.txt) for details.

## Contributing

See [Issue #22](//github.com/matthewsedam/cryptotrade/issues/22) for the design approach.

## Checking out the Source

You can clone from GitHub with

    git clone git@github.com:matthewsedam/cryptotrade

or, if you are not a GitHub user,

    git clone git://github.com/matthewsedam/cryptotrade

## Build Prerequisites

CryptoTrade depends upon the Chapel compiler.
See [here](https://github.com/chapel-lang/chapel) for more
information and installation instructions.

If you plan to use dockerBuild.sh to build CryptoTrade using Docker,
please see [here](https://www.docker.com/) to install Docker. Then,
run

    docker pull chapel/chapel:latest

to install the latest Chapel Docker image.

## Building CryptoTrade

Prerequisite: make

Build instructions:

    make

To clean:

    make clean

To build and run CryptoTrade using Docker, use

    cd cryptotrade
    sudo ./dockerBuild.sh run

The CryptoTrade executable is in `build`.

## Versioning

Releases will follow a semantic versioning format.

`<major>.<minor>.<patch>`

For more information on SemVer, visit [http://semver.org/](http://semver.org/).
