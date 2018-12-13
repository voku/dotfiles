#!/usr/bin/env bash

umount /mnt/c
mount -t drvfs C: /mnt/c -o metadata

umount /mnt/h
mount -t drvfs H: /mnt/h -o metadata
