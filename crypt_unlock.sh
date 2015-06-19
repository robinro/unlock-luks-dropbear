#!/bin/sh
 
PREREQ="dropbear"
 
prereqs() {
echo "$PREREQ"
}
 
case "$1" in
prereqs)
prereqs
exit 0
;;
esac
 
. "${CONFDIR}/initramfs.conf"
. /usr/share/initramfs-tools/hook-functions
 
if [ "${DROPBEAR}" != "n" ] && [ -r "/etc/crypttab" ] ; then
cat > "${DESTDIR}/bin/unlock" << EOF
#!/bin/sh
if PATH=/lib/unlock:/bin:/sbin /scripts/local-top/cryptroot; then
# following line kill the remote shell right after the passphrase has
# been entered.
# kill local password-dialogs
kill \`pidof cryptroot\` 
kill \`pidof dropbear\` 
exit 0
fi
exit 1
EOF
 
# ps | grep cryptroot | grep -v "grep" | awk '{print \$1}'\`
#kill \`ps | grep ask-for-password | grep -v "grep" | awk '{print \$1}'\`

chmod 755 "${DESTDIR}/bin/unlock"
 
mkdir -p "${DESTDIR}/lib/unlock"
cat > "${DESTDIR}/lib/unlock/plymouth" << EOF
#!/bin/sh
[ "\$1" == "--ping" ] && exit 1
/bin/plymouth "\$@"
EOF
 
chmod 755 "${DESTDIR}/lib/unlock/plymouth"
 
echo To unlock root-partition run "unlock" >> ${DESTDIR}/etc/motd
 
fi
