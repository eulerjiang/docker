#!/bin/bash
#
# Create SuSE 11 SP3 image from running system
#
ROOTFS="/tmp/rootfs-suse11sp3-$$"
mkdir $ROOTFS

#trap "rm -rf $ROOTFS" INT QUIT TERM
cd $ROOTFS

copyFiles()
{
    mkdir -m 777 tmp
    mkdir -m 777 proc
    for dir in bin  boot etc  home  lib  lib64 opt root  sbin  sys usr var
    do
        cp -a /$dir .
    done
}

copyDev()
{
    mkdir -m 755 dev
    for X in stdin stdout stderr pts shm console initctl full null ptmx random tty tty0 urandom zero
    do
        cp -a /dev/$X dev
    done

	# setting up /dev, so we'll just wipe it out and create our own
	# mkdir -m 755 dev
	# (
        # cd dev
        # ln -sf /proc/self/fd ./
        # mkdir -m 755 pts
        # mkdir -m 1777 shm
        # mknod -m 600 console c 5 1
        # mknod -m 600 initctl p
        # mknod -m 666 full c 1 7
        # mknod -m 666 null c 1 3
        # mknod -m 666 ptmx c 5 2
        # mknod -m 666 random c 1 8
        # mknod -m 666 tty c 5 0
        # mknod -m 666 tty0 c 4 0
        # mknod -m 666 urandom c 1 9
        # mknod -m 666 zero c 1 5
	# )
}

tarRepo()
{
    tar --numeric-owner -caf "/tmp/SuSE11SP3.tar" .
}

copyFiles
copyDev
tarRepo