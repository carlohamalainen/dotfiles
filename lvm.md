I can never remember this stuff...

Boot an Ubuntu live DVD and start a root shell.

Use ```vgscan``` to find the LVM volumes:

    # vgscan
      Reading all physical volumes.  This may take a while...
      Found volume group "r500" using metadata type lvm2

Use ```vgchange``` to activate the volume:

# vgchange -ay
  2 logical volume(s) in volume group "r500" now active

Use ```lvscan``` to find the device names:

    # lvscan
      ACTIVE            '/dev/r500/root' [144.91 GiB] inherit
      ACTIVE            '/dev/r500/swap_1' [3.90 GiB] inherit

Mount these devices:

    # mkdir /mnt/r500_root
    # mount /dev/r500/root /mnt/r500_root

Hey look, some files:

    # ls /mnt/r500_root
    bin   cdrom  etc home (and so on, output snipped)

