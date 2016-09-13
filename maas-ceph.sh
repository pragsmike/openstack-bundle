#!/bin/bash

function partition_osd() {
    ID=$1
    DISK=$2

    maas maas partitions create $ID $DISK size=500M
    maas maas partition format $ID $DISK $DISK-part1 fstype=fat32

    maas maas partitions create $ID $DISK size=8G
    maas maas partition format $ID $DISK $DISK-part2 fstype=ext4
    maas maas partition mount  $ID $DISK $DISK-part2 mount_point=/

    maas maas partitions create $ID $DISK size=5G
    maas maas partition format $ID $DISK $DISK-part3 fstype=ext4
    maas maas partition mount  $ID $DISK $DISK-part3 mount_point=/ceph-journal-1

    maas maas partitions create $ID $DISK size=5G
    maas maas partition format $ID $DISK $DISK-part4 fstype=ext4
    maas maas partition mount  $ID $DISK $DISK-part4 mount_point=/ceph-journal-2
}

partition_osd rspahc sdb

partition_osd emyype sdb
