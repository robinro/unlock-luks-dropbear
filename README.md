# Unlock a full disk encrypted ubuntu system via SSH

You can encrypt your system and it is even possible to do this for a server and then enter the encryption key during boot via ssh.
Tutorials how to this this can be found e.g. here:
https://www.thomas-krenn.com/de/wiki/Voll-verschl%C3%BCsseltes-System_via_SSH_freischalten

I don't like to edit files in /usr/share and actually you don't have to. Leave out the corresponding step, but instead copy the `crypt_unlock.sh` provided here to `/etc/initramfs-tools/hooks/` and run `update-initramfs -u` afterwards.
This way is also safer for updates to the initramfs-related packages.

When logging in during boot to dropbear. Instead of running the passfifo command, run `unlock`, enter the password and the server
will continue to boot.

This is based on the scripts published at
http://www.emmolution.org/?p=307
https://stinkyparkia.wordpress.com/2014/10/14/remote-unlocking-luks-encrypted-lvm-using-dropbear-ssh-in-ubuntu-server-14-04-1-with-static-ipst/
https://bildung.xarif.de/xwiki/bin/Informatik/verschl%C3%BCsselte+Systemfestplatte+per+SSH+freischalten

If you ever get stuck using this or a similar script: Log in, look at ps and run the kill commands by hand. From ubuntu 12.04 to 14.04 there were some subtle changes.
