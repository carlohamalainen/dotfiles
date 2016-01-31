# Mount an encrypted LVM volume

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

# Rename volume if name clash

The above doesn't work if two volumes (e.g. internal hard drive and USB drive) have the same name.

First use `vgdisplay` to see the UUIDs:

    # vgdisplay
      --- Volume group ---
      VG Name               ubuntu-vg
      System ID
      Format                lvm2
      Metadata Areas        1
      Metadata Sequence No  3
      VG Access             read/write
      VG Status             resizable
      MAX LV                0
      Cur LV                2
      Open LV               0
      Max PV                0
      Cur PV                1
      Act PV                1
      VG Size               465.52 GiB
      PE Size               4.00 MiB
      Total PE              119172
      Alloc PE / Size       119161 / 465.47 GiB
      Free  PE / Size       11 / 44.00 MiB
      VG UUID               1DIDQ9-ZNHC-voA1-rSoH-jxkP-Lj6z-GYPgOn

      --- Volume group ---
      VG Name               ubuntu-vg
      System ID
      Format                lvm2
      Metadata Areas        1
      Metadata Sequence No  3
      VG Access             read/write
      VG Status             resizable
      MAX LV                0
      Cur LV                2
      Open LV               2
      Max PV                0
      Cur PV                1
      Act PV                1
      VG Size               931.27 GiB
      PE Size               4.00 MiB
      Total PE              238405
      Alloc PE / Size       238394 / 931.23 GiB
      Free  PE / Size       11 / 44.00 MiB
      VG UUID               GVpJ55-vl66-3SVR-XIBA-0Brv-dfhK-QD6PWP

Use `vgrename` to change the second one to a different name:

    vgrename GVpJ55-vl66-3SVR-XIBA-0Brv-dfhK-QD6PWP blah

Check the volumes:

    root@bobcat:~# vgscan
      Reading all physical volumes.  This may take a while...
      Found volume group "ubuntu-vg" using metadata type lvm2
      Found volume group "blah" using metadata type lvm2

Activate the volume:

    vgchange -ay

Scan to get device name:

    # lvscan
      ACTIVE            '/dev/ubuntu-vg/root' [464.48 GiB] inherit
      ACTIVE            '/dev/ubuntu-vg/swap_1' [1012.00 MiB] inherit
      ACTIVE            '/dev/blah/root' [930.24 GiB] inherit
      ACTIVE            '/dev/blah/swap_1' [1012.00 MiB] inherit

Mount the main partition:

    # mkdir /mnt/blah_root
    # mount /dev/blah/root /mnt/blah_root
