#!/bin/sh -x


mkdir -p /tmp/pip_install

exec /bin/bash -c "trap : TERM INT; while [ 1 ]; do sleep 15; done & wait"
