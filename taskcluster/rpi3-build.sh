#!/bin/bash

set -xe

source $(dirname "$0")/tc-tests-utils.sh

source ${DS_ROOT_TASK}/DeepSpeech/tf/tc-vars.sh

BAZEL_TARGETS="
//native_client:libdeepspeech.so
"

BAZEL_BUILD_FLAGS="${BAZEL_ARM_FLAGS} ${BAZEL_EXTRA_FLAGS}"
BAZEL_ENV_FLAGS="TF_NEED_CUDA=0"
SYSTEM_TARGET=rpi3
SYSTEM_RASPBIAN=/tmp/multistrap-raspbian-buster

maybe_install_xldd

do_bazel_build

do_deepspeech_binary_build

export SUPPORTED_PYTHON_VERSIONS="3.7.6:ucs2"
do_deepspeech_python_build

do_deepspeech_nodejs_build
