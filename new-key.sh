#!/usr/bin/env bash

set -ex

aws iam create-access-key --user-name ${USERNAME}
