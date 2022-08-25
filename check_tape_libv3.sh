#!/bin/bash
# this is a simple script that executes a few commands.  
# this script assumes that mt-st is isntalled
#sudo apt-cache policy mt-st
#mt-st:
#  Installed: 1.4-2
#  Candidate: 1.4-2
#  Version table:
# *** 1.4-2 500
#        500 https://urldefense.com/v3/__http://archive.ubuntu.com/ubuntu__;!!LpKI!nqRIcTlW2Ka4d2DnPGZD0gMHZR4l_-R3SYfPYxZFdv28hz0_z6qz3h__KiP1_zniNJhwhlxoPS048MrLM2HkhAeyVbM$ [archive[.]ubuntu[.]com] jammy/universe amd64 Packages
#        100 /var/lib/dpkg/status

set -x

# list scsi device and verify it is there 
lsscsi -g


echo "check status"
mt -f /dev/st0   status

echo "Write eof at the current position of the tape"
mt -f /dev/st0 eof

echo "erase tape"
#mt -f /dev/st0 erase

echo "rewind tape"
mt -f /dev/st0 rewind

echo "back up /home" 
tar -clpzvf /dev/st0 /home
#tar -czf /dev/st0 /home

echo "compare and restore tape backup"
pushd /
mt -f /dev/st0 rewind
tar -dlzvf /dev/st0 home
#tar -xzf /dev/st0 www
popd


echo "eject tape"
#mt -f /dev/st0 eject

echo "done"


