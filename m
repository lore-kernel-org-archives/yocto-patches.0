Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FF6EFCD7A
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 23:13:10 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28159.1773097981114508683
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 16:13:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (165-23-88-160-dynamic.midco.net [165.23.88.160])
	by host.hernesphere.com (Postfix) with ESMTPSA id F22D3FDD88;
	Mon,  9 Mar 2026 18:12:55 -0500 (CDT)
Authentication-Results: host.hernesphere.com;
        spf=pass (sender IP is 165.23.88.160) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Subject: [PATCH 1/2] Add IMG and PKG SDK installers
Date: Mon,  9 Mar 2026 18:12:50 -0500
Message-ID: <20260309231251.99347-2-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309231251.99347-1-dev@qinc.tv>
References: <20260309231251.99347-1-dev@qinc.tv>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 23:13:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3389

This adds support for generating both .img and .pkg installers for
macOS SDK distribution.

The .img (HFS+ filesystem image, bzip2 compressed) requires running
`finalize-img` after mounting to relocate and sign the executables.

The .pkg automates the process and integrates the relocation and
signing into the installer.

Signed-off-by: Eric L. Hernes <dev@qinc.tv>
---
 README                                      |  19 ++
 conf/files/darwin-toolchain-shar-extract.sh | 316 ++++++++++++++++++++
 conf/files/finalize-sdk.sh                  |  48 +++
 conf/files/mk-macos-img.sh                  |  49 +++
 conf/files/mk-macos-pkg.sh                  | 161 ++++++++++
 conf/files/post-install.in                  |   9 +
 conf/files/pre-install.in                   |  84 ++++++
 conf/layer.conf                             |   3 +
 conf/machine-sdk/darwin-common.inc          |  55 +++-
 9 files changed, 742 insertions(+), 2 deletions(-)
 create mode 100644 conf/files/darwin-toolchain-shar-extract.sh
 create mode 100644 conf/files/finalize-sdk.sh
 create mode 100755 conf/files/mk-macos-img.sh
 create mode 100755 conf/files/mk-macos-pkg.sh
 create mode 100644 conf/files/post-install.in
 create mode 100644 conf/files/pre-install.in

diff --git a/README b/README
index 89845b5..e04aa6e 100644
--- a/README
+++ b/README
@@ -30,3 +30,22 @@ https://lists.yoctoproject.org/g/yocto-patches before =
being able to post.
 When sending single patches, please use something like:
 'git send-email -M -1 --to yocto-patches@lists.yoctoproject.org --subjec=
t-prefix=3D"meta-darwin][PATCH"'
=20
+The following variables can be set in the local.conf or elsewhere:
+
+To enable building the .pkg installer, set:
+DARWIN_INSTALLER_PKG =3D "1"
+
+To enable building a .img installer, set:
+DARWIN_INSTALLER_IMG =3D "1"
+
+To save some time during builds, you can disable the shell script instal=
ler with:
+DARWIN_INSTALLER_SH =3D "0"
+
+To specify the path in the .img and path that the .pkg will install to, =
set
+DARWIN_INSTALLER_PATH =3D "/Library/Developer/org.openembedded.sdk"
+
+The .img will require running the `finalize-img` to relocate and sign
+the executables.
+
+The .pkg automates the process and integrates the relocation and
+signage into the installer.
diff --git a/conf/files/darwin-toolchain-shar-extract.sh b/conf/files/dar=
win-toolchain-shar-extract.sh
new file mode 100644
index 0000000..e486f3d
--- /dev/null
+++ b/conf/files/darwin-toolchain-shar-extract.sh
@@ -0,0 +1,316 @@
+#!/bin/sh
+
+export LC_ALL=3Den_US.UTF-8
+
+# The pipefail option is now part of POSIX (POSIX.1-2024) and available =
in more
+# and more shells. Enable it if available to make the SDK installer more=
 robust.
+(set -o pipefail 2> /dev/null) && set -o pipefail
+
+#Make sure at least one python is installed
+INIT_PYTHON=3D$(which python3 2>/dev/null )
+[ -z "$INIT_PYTHON" ] && INIT_PYTHON=3D$(which python2 2>/dev/null)
+[ -z "$INIT_PYTHON" ] && echo "Error: The SDK needs a python installed" =
&& exit 1
+
+# Remove invalid PATH elements first (maybe from a previously setup tool=
chain now deleted
+PATH=3D`$INIT_PYTHON -c 'import os; print(":".join(e for e in os.environ=
["PATH"].split(":") if os.path.exists(e)))'`
+
+tweakpath () {
+    case ":${PATH}:" in
+        *:"$1":*)
+            ;;
+        *)
+            PATH=3D$PATH:$1
+    esac
+}
+
+# Some systems don't have /usr/sbin or /sbin in the cleaned environment =
PATH but we make need it=20
+# for the system's host tooling checks
+tweakpath /usr/sbin
+tweakpath /sbin
+
+# linux calls it aarch64; Apple calls it arm64
+if [ @SDK_ARCH@ =3D=3D aarch64 ]; then
+    OSX_SDK_ARCH=3Darm64
+else
+    OSX_SDK_ARCH=3D@SDK_ARCH@
+fi
+
+INST_ARCH=3D$(uname -m | gsed -e "s/i[3-6]86/ix86/" -e "s/x86[-_]64/x86_=
64/")
+SDK_ARCH=3D$(echo ${OSX_SDK_ARCH} | gsed -e "s/i[3-6]86/ix86/" -e "s/x86=
[-_]64/x86_64/")
+
+INST_GCC_VER=3D$(gcc --version 2>/dev/null | gsed -ne 's/.* \([0-9]\+\.[=
0-9]\+\)\.[0-9]\+.*/\1/p')
+SDK_GCC_VER=3D'@SDK_GCC_VER@'
+
+verlte () {
+	[  "$1" =3D "`printf "$1\n$2" | sort -V | head -n1`" ]
+}
+
+verlt() {
+	[ "$1" =3D "$2" ] && return 1 || verlte $1 $2
+}
+
+verlt `uname -r` @OLDEST_KERNEL@
+if [ $? =3D 0 ]; then
+	echo "Error: The SDK needs a kernel > @OLDEST_KERNEL@"
+	exit 1
+fi
+
+if [ "$INST_ARCH" !=3D "$SDK_ARCH" ]; then
+	# Allow for installation of ix86 SDK on x86_64 host
+	if [ "$INST_ARCH" !=3D x86_64 -o "$SDK_ARCH" !=3D ix86 ]; then
+		echo "Error: Incompatible SDK installer! Your host is $INST_ARCH and t=
his SDK was built for $SDK_ARCH hosts."
+		exit 1
+	fi
+fi
+
+if ! xz -V > /dev/null 2>&1; then
+	echo "Error: xz is required for installation of this SDK, please instal=
l it first"
+	exit 1
+fi
+
+SDK_BUILD_PATH=3D"@SDKPATH@"
+DEFAULT_INSTALL_DIR=3D"@SDKPATHINSTALL@"
+SUDO_EXEC=3D""
+EXTRA_TAR_OPTIONS=3D""
+target_sdk_dir=3D""
+answer=3D""
+relocate=3D1
+savescripts=3D0
+verbose=3D0
+publish=3D0
+listcontents=3D0
+while getopts ":yd:npDRSl" OPT; do
+	case $OPT in
+	y)
+		answer=3D"Y"
+		;;
+	d)
+		target_sdk_dir=3D$OPTARG
+		;;
+	n)
+		prepare_buildsystem=3D"no"
+		;;
+	p)
+		prepare_buildsystem=3D"no"
+		publish=3D1
+		;;
+	D)
+		verbose=3D1
+		;;
+	R)
+		relocate=3D0
+		savescripts=3D1
+		;;
+	S)
+		savescripts=3D1
+		;;
+	l)
+		listcontents=3D1
+		;;
+	*)
+		echo "Usage: $(basename "$0") [-y] [-d <dir>]"
+		echo "  -y         Automatic yes to all prompts"
+		echo "  -d <dir>   Install the SDK to <dir>"
+		echo "=3D=3D=3D=3D=3D=3D=3D=3D Extensible SDK only options =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D"
+		echo "  -n         Do not prepare the build system"
+		echo "  -p         Publish mode (implies -n)"
+		echo "=3D=3D=3D=3D=3D=3D=3D=3D Advanced DEBUGGING ONLY OPTIONS =3D=3D=3D=
=3D=3D=3D=3D=3D"
+		echo "  -S         Save relocation scripts"
+		echo "  -R         Do not relocate executables"
+		echo "  -D         use set -x to see what is going on"
+		echo "  -l         list files that will be extracted"
+		exit 1
+		;;
+	esac
+done
+
+payload_offset=3D$(($(grep -na -m1 "^MARKER:$" "$0"|cut -d':' -f1) + 1))
+if [ "$listcontents" =3D "1" ] ; then
+    if [ @SDK_ARCHIVE_TYPE@ =3D "zip" ]; then
+        tail -n +$payload_offset "$0" > sdk.zip
+        if unzip -l sdk.zip;then
+            rm sdk.zip
+        else
+            rm sdk.zip && exit 1
+        fi
+    else
+        tail -n +$payload_offset "$0"| gtar tvJ || exit 1
+    fi
+    exit
+fi
+
+titlestr=3D"@SDK_TITLE@ installer version @SDK_VERSION@"
+printf "%s\n" "$titlestr"
+printf "%${#titlestr}s\n" | tr " " "=3D"
+
+if [ $verbose =3D 1 ] ; then
+	set -x
+fi
+
+@SDK_PRE_INSTALL_COMMAND@
+
+# SDK_EXTENSIBLE is exposed from the SDK_PRE_INSTALL_COMMAND above
+if [ "$SDK_EXTENSIBLE" =3D "1" ]; then
+	DEFAULT_INSTALL_DIR=3D"@SDKEXTPATH@"
+	if [ "$INST_GCC_VER" =3D '4.8' -a "$SDK_GCC_VER" =3D '4.9' ] || [ "$INS=
T_GCC_VER" =3D '4.8' -a "$SDK_GCC_VER" =3D '' ] || \
+		[ "$INST_GCC_VER" =3D '4.9' -a "$SDK_GCC_VER" =3D '' ]; then
+		echo "Error: Incompatible SDK installer! Your host gcc version is $INS=
T_GCC_VER and this SDK was built by gcc higher version."
+		exit 1
+	fi
+fi
+
+if [ "$target_sdk_dir" =3D "" ]; then
+	if [ "$answer" =3D "Y" ]; then
+		target_sdk_dir=3D"$DEFAULT_INSTALL_DIR"
+	else
+		read -p "Enter target directory for SDK (default: $DEFAULT_INSTALL_DIR=
): " target_sdk_dir
+		[ "$target_sdk_dir" =3D "" ] && target_sdk_dir=3D$DEFAULT_INSTALL_DIR
+	fi
+fi
+
+eval target_sdk_dir=3D$(echo "$target_sdk_dir"|gsed 's/ /\\ /g')
+if [ -d "$target_sdk_dir" ]; then
+	target_sdk_dir=3D$(cd "$target_sdk_dir"; pwd)
+else
+	target_sdk_dir=3D$(greadlink -m "$target_sdk_dir")
+fi
+
+# limit the length for target_sdk_dir, ensure the relocation behaviour i=
n relocate_sdk.py has right result.
+# This is due to ELF interpreter being set to 'a'*1024 in
+# meta/recipes-core/meta/uninative-tarball.bb
+if [ ${#target_sdk_dir} -gt 1024 ]; then
+	echo "Error: The target directory path is too long!!!"
+	exit 1
+fi
+
+if [ "$SDK_EXTENSIBLE" =3D "1" ]; then
+	# We're going to be running the build system, additional restrictions a=
pply
+	if echo "$target_sdk_dir" | grep -q '[+\ @$]'; then
+		echo "The target directory path ($target_sdk_dir) contains illegal" \
+		     "characters such as spaces, @, \$ or +. Abort!"
+		exit 1
+	fi
+	# The build system doesn't work well with /tmp on NFS
+	fs_dev_path=3D"$target_sdk_dir"
+	while [ ! -d "$fs_dev_path" ] ; do
+		fs_dev_path=3D`dirname $fs_dev_path`
+        done
+	fs_dev_type=3D`stat -f -c '%t' "$fs_dev_path"`
+	if [ "$fs_dev_type" =3D "6969" ] ; then
+		echo "The target directory path $target_sdk_dir is on NFS, this is not=
 possible. Abort!"
+		exit 1
+	fi
+else
+	if [ -n "$(echo $target_sdk_dir|grep ' ')" ]; then
+		echo "The target directory path ($target_sdk_dir) contains spaces. Abo=
rt!"
+		exit 1
+	fi
+fi
+
+if [ -e "$target_sdk_dir/environment-setup-@REAL_MULTIMACH_TARGET_SYS@" =
]; then
+	echo "The directory \"$target_sdk_dir\" already contains a SDK for this=
 architecture."
+	printf "If you continue, existing files will be overwritten! Proceed [y=
/N]? "
+
+	default_answer=3D"n"
+else
+	printf "You are about to install the SDK to \"$target_sdk_dir\". Procee=
d [Y/n]? "
+
+	default_answer=3D"y"
+fi
+
+if [ "$answer" =3D "" ]; then
+	read answer
+	[ "$answer" =3D "" ] && answer=3D"$default_answer"
+else
+	echo $answer
+fi
+
+if [ "$answer" !=3D "Y" -a "$answer" !=3D "y" ]; then
+	echo "Installation aborted!"
+	exit 1
+fi
+
+# Try to create the directory (this will not succeed if user doesn't hav=
e rights)
+mkdir -p $target_sdk_dir >/dev/null 2>&1
+
+# if don't have the right to access dir, gain by sudo=20
+if [ ! -x $target_sdk_dir -o ! -w $target_sdk_dir -o ! -r $target_sdk_di=
r ]; then=20
+	if [ "$SDK_EXTENSIBLE" =3D "1" ]; then
+		echo "Unable to access \"$target_sdk_dir\", will not attempt to use" \
+		     "sudo as as extensible SDK cannot be used as root."
+		exit 1
+	fi
+
+	SUDO_EXEC=3D$(which "sudo")
+	if [ -z $SUDO_EXEC ]; then
+		echo "No command 'sudo' found, please install sudo first. Abort!"
+		exit 1
+	fi
+
+	# test sudo could gain root right
+	$SUDO_EXEC pwd >/dev/null 2>&1
+	[ $? -ne 0 ] && echo "Sorry, you are not allowed to execute as root." &=
& exit 1
+
+	# now that we have sudo rights, create the directory
+	$SUDO_EXEC mkdir -p $target_sdk_dir >/dev/null 2>&1
+fi
+
+printf "Extracting SDK..."
+if [ @SDK_ARCHIVE_TYPE@ =3D "zip" ]; then
+    tail -n +$payload_offset "$0" > sdk.zip
+    if $SUDO_EXEC unzip $EXTRA_TAR_OPTIONS sdk.zip -d $target_sdk_dir;th=
en
+        rm sdk.zip
+    else
+        rm sdk.zip && exit 1
+    fi
+else
+    tail -n +$payload_offset "$0"| $SUDO_EXEC gtar mxJ -C $target_sdk_di=
r --checkpoint=3D.2500 $EXTRA_TAR_OPTIONS || exit 1
+fi
+echo "done"
+
+printf "Setting it up..."
+# fix environment paths
+real_env_setup_script=3D""
+for env_setup_script in `ls $target_sdk_dir/environment-setup-*`; do
+	if grep -q 'OECORE_NATIVE_SYSROOT=3D' $env_setup_script; then
+		# Handle custom env setup scripts that are only named
+		# environment-setup-* so that they have relocation
+		# applied - what we want beyond here is the main one
+		# rather than the one that simply sorts last
+		real_env_setup_script=3D"$env_setup_script"
+	fi
+	$SUDO_EXEC gsed -e "s:@SDKPATH@:$target_sdk_dir:g" -i $env_setup_script
+done
+if [ -n "$real_env_setup_script" ] ; then
+	env_setup_script=3D"$real_env_setup_script"
+fi
+
+@SDK_POST_INSTALL_COMMAND@
+
+# delete the relocating script, so that user is forced to re-run the ins=
taller
+# if he/she wants another location for the sdk
+if [ $savescripts =3D 0 ] ; then
+	$SUDO_EXEC rm -f ${env_setup_script%/*}/relocate_sdk.py ${env_setup_scr=
ipt%/*}/relocate_sdk.sh
+fi
+
+# Execute post-relocation script
+post_relocate=3D"$target_sdk_dir/post-relocate-setup.sh"
+if [ -e "$post_relocate" ]; then
+	$SUDO_EXEC gsed -e "s:@SDKPATH@:$target_sdk_dir:g" -i $post_relocate
+	$SUDO_EXEC /bin/sh $post_relocate "$target_sdk_dir" "@SDKPATH@"
+	if [ $? -ne 0 ]; then
+		echo "Executing $post_relocate failed"
+		exit 1
+	fi
+	$SUDO_EXEC rm -f $post_relocate
+fi
+
+echo "SDK has been successfully set up and is ready to be used."
+echo "Each time you wish to use the SDK in a new shell session, you need=
 to source the environment setup script e.g."
+for env_setup_script in `ls $target_sdk_dir/environment-setup-*`; do
+	echo " \$ . $env_setup_script"
+done
+
+exit 0
+
+MARKER:
diff --git a/conf/files/finalize-sdk.sh b/conf/files/finalize-sdk.sh
new file mode 100644
index 0000000..494fc94
--- /dev/null
+++ b/conf/files/finalize-sdk.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+##################################################
+## file: finalize-sdk.sh
+##
+##
+## /bin/sh script to finalize oesdk files
+##
+## 1. change pathing from hardcoded path to install path
+## 2. codesign binaries and dylibs
+##
+## This can be run on the final installed files; or during install in a =
staging area if we know
+## what the final destination path will be.
+##
+
+x_path=3D$(realpath $(dirname "${0}"))
+first_csid=3D$(security -qq find-identity -v -p codesigning |cut -c47- |=
head -1 | tr -d '"')
+
+staging=3D${1:-"${x_path}"}
+new_path=3D${2:-"${x_path}"}
+codesign_id=3D${3:-"${first_csid}"}
+
+native_sysroot=3D"@native_sysroot@"
+
+do_relocate=3Dyes
+do_codesign=3Dyes
+
+if [ "${do_relocate}" =3D yes ]; then
+    old_path=3D"/usr/local/oe-sdk-hardcoded-buildpath"
+
+    find "${staging}" -type f -exec file {} +| grep -i ":.*\(ASCII\|scri=
pt\|source\).*text" |cut -d: -f1  |
+        while read fn; do
+            sed -i "" "s,${old_path},${new_path},g" "${fn}" || echo "${f=
n}"
+        done
+fi
+
+if [ "${do_codesign}" =3D yes ]; then
+    if [ -z "${codesign_id}" ]; then
+        echo "requested codesigning, but did not find a codesigning iden=
tity"
+    else
+        find "${staging}/sysroots/${native_sysroot}" -type f -exec file =
{} + |
+            grep Mach-O |=20
+            cut -d: -f1 |
+            sed -e "s,^,'," -e "s,$,'," |
+            xargs codesign --continue --force --timestamp --sign "${code=
sign_id}" >/dev/null 2>&1
+    fi
+fi
+
+exit 0
diff --git a/conf/files/mk-macos-img.sh b/conf/files/mk-macos-img.sh
new file mode 100755
index 0000000..eb577c1
--- /dev/null
+++ b/conf/files/mk-macos-img.sh
@@ -0,0 +1,49 @@
+#!/bin/bash
+##################################################
+## file: meta-darwin/conf/files/mk-macos-img.sh
+##
+## Original Author: Eric L. Hernes <eric@qinc.tv>
+##
+## /bin/sh script to do create macos .img image for openembedded sdk
+##
+
+# $1 =3D SDK Title
+# $2 =3D SDK Name
+# $3 =3D SDK Architecture
+# $4 =3D SDK Version
+# $5 =3D path to SDK path files
+# $6 =3D SDK img output filename
+# $7 =3D path to finalize script
+# $8 =3D destination path within the IMG
+
+pkg_title=3D${1:-"OpenEmbedded SDK"}
+pkg_name=3D${2:-"oesdk-darwin21"}
+pkg_arch=3D${3:-"aarch64"}
+pkg_vers=3D${4:-"x.x.x.y"}
+sdk_path=3D${5:-".../tmp/work/armv8a-oe-linux/meta-toolchain/1.0/sdk/ima=
ge"}
+img_path=3D${6:-".../tmp/deploy/sdk/macos-test-sdk.img"}
+finalize_img=3D${7:-"finalize-img"}
+dst_path=3D${8-"/Library/Developer/org.openembedded.sdk/${pkg_name}"}
+
+img_finalize=3D"${dst_path}/"$(basename "${finalize_img}")
+
+set $(du -sm ${sdk_path})
+
+# add 10% for overhead
+size_mb=3D$((${1} * 11 / 10))
+
+dd if=3D/dev/zero of=3D"${img_path}" bs=3D1M count=3D${size_mb}
+mkfs.hfsplus -s -v "${pkg_name}" "${img_path}"
+
+hfsplus "${img_path}" mkdir-p "${dst_path}"
+
+hfsplus "${img_path}" addall "${sdk_path}" "${dst_path}"
+
+hfsplus "${img_path}" add "${finalize_img}" "${img_finalize}"
+hfsplus "${img_path}" chmod 755 "${img_finalize}"
+
+hfsplus "${img_path}" rm "${dst_path}/relocate_sdk.py"
+
+hfsplus "${img_path}" rm "${dst_path}/post-relocate-setup.sh"
+
+
diff --git a/conf/files/mk-macos-pkg.sh b/conf/files/mk-macos-pkg.sh
new file mode 100755
index 0000000..2534cfa
--- /dev/null
+++ b/conf/files/mk-macos-pkg.sh
@@ -0,0 +1,161 @@
+#!/bin/bash
+##################################################
+## file: meta-darwin/conf/files/mk-macos-pkg.sh
+##
+## Original Author: Eric L. Hernes <eric@qinc.tv>
+##
+## /bin/sh script to do create macos .pkg installer for openembedded sdk
+##
+
+# $1 =3D SDK Title
+# $2 =3D SDK Name
+# $3 =3D SDK Architecture
+# $4 =3D SDK Version
+# $5 =3D path to SDK path files
+# $6 =3D SDK pkg output filename
+# $7 =3D path to finalize script
+# $8 =3D destination path relative to the user's selected volume
+
+pkg_title=3D${1:-"OpenEmbedded SDK"}
+pkg_name=3D${2:-"oesdk-darwin21"}
+pkg_arch=3D${3:-"aarch64"}
+pkg_vers=3D${4:-"x.x.x.y"}
+sdk_path=3D${5:-".../tmp/work/armv8a-oe-linux/meta-toolchain/1.0/sdk/ima=
ge"}
+pkg_path=3D${6:-".../tmp/deploy/sdk/macos-test-sdk.pkg"}
+finalize_pkg=3D${7:-"finalize-pkg"}
+dst_path=3D${8-"/Library/Developer/org.openembedded.sdk/${pkg_name}/x"}
+
+echo "pkg_title: ${pkg_title}"
+echo "pkg_name: ${pkg_name}"
+echo "pkg_arch: ${pkg_arch}"
+echo "pkg_vers: ${pkg_vers}"
+echo "sdk_path: ${sdk_path}"
+echo "pkg_path: ${pkg_path}"
+echo "dst_path: ${dst_path}"
+
+count=3D$(find ${sdk_path} -type f | wc -l)
+set $(du -sk ${sdk_path})
+kbytes=3D$1
+
+echo "SDK will contain ${count} files and consume ${kbytes}K bytes"
+
+org_id=3Dorg.openembedded.sdk
+
+pkg_id=3D"${org_id}.${pkg_name}.pkg"
+
+flat=3Ddist/Package.pkg
+
+build=3Dbuild
+mkbom=3Dmkbom
+xar=3Dxar
+
+files=3D$(realpath $(dirname $0))
+
+rm -rf ${build}
+rm -f "${pkg_path}"
+
+mkdir ${build}
+cd ${build}
+
+mkdir -p ${flat}
+mkdir scripts
+
+( cd ${sdk_path} && find . | cpio -o --format odc --owner 0:80 | xz -c -=
T0 ) > ${flat}/Payload
+
+#
+# Swift installs stuff to /Library/org.swift.swiftpm;
+#
+# So let's do something similar
+# Install files to /Library/Developer/org.openembedded.sdk
+#
+cat > ${flat}/PackageInfo <<EOF
+<pkg-info format-version=3D"2" identifier=3D"${pkg_id}" version=3D"${pkg=
_vers}" relocatable=3D"false" overwrite-permissions=3D"false" followSymLi=
nks=3D"false" install-location=3D"${dst_path}" auth=3D"root">
+  <payload installKBytes=3D"${kbytes}" numberOfFiles=3D"${count}"/>
+    <bundle-version/>
+    <upgrade-bundle/>
+    <update-bundle/>
+    <atomic-update-bundle/>
+    <strict-identifier/>
+    <relocate/>
+    <scripts>
+      <preinstall file=3D"./pre-install"/>
+      <postinstall file=3D"./post-install"/>
+  </scripts>
+</pkg-info>
+EOF
+
+sed -e "s#@dst_path@#${dst_path}#g" \
+    ${files}/pre-install.in >scripts/pre-install
+
+cp ${files}/post-install.in scripts/post-install
+cp ${finalize_pkg} scripts/finalize-pkg
+
+chmod +x scripts/finalize-pkg
+chmod +x scripts/pre-install
+chmod +x scripts/post-install
+
+( cd scripts && find . | cpio -o --format odc --owner 0:80 | gzip -c ) >=
 ${flat}/Scripts
+${mkbom} -u 0 -g 80 ${sdk_path} ${flat}/Bom
+
+#
+# linux calls it aarch64; apple calls it arm64
+#
+
+declare -A arch_map
+arch_map["aarch64"]=3D"arm64"
+arch_map["x86_64"]=3D"x86_64"
+
+p_id=3D$(tr -dc 'a-z0-9' < /dev/urandom | head -c 16)
+pki_id=3D"org.openembedded.oesdk.installer.${p_id}"
+
+
+cat >dist/Distribution <<EOF
+<?xml version=3D"1.0" encoding=3D"utf-8"?>
+<installer-gui-script minSpecVersion=3D"2">
+    <title>${pkg_title}</title>
+    <options customize=3D"allow" hostArchitectures=3D"${arch_map[${pkg_a=
rch}]}"/>
+    <domains enable_localSystem=3D"true" enable_anywhere=3D"true" enable=
_currentUserHome=3D"true"/>
+    <installation-check script=3D"canInstall()"/>
+    <script><![CDATA[
+	function canInstall() {
+		var version;
+		var major;
+
+		// ProductVersion is usually "major.minor.patch"
+		if (!system || !system.version || !system.version.ProductVersion) {
+			return false;
+		}
+
+		version =3D system.version.ProductVersion.split(".");
+		major =3D parseInt(version[0], 10);
+
+		if (isNaN(major)) {
+			return false;
+		}
+
+		// Darwin21 =3D=3D  macOS 12+
+		if (major < 12) {
+			return false;
+		}
+
+		return true;
+	}
+
+]]></script>
+    <pkg-ref id=3D"${p_id}" version=3D"1" onConclusion=3D"none">#Package=
.pkg</pkg-ref>
+    <pkg-ref id=3D"${p_id}" packageIdentifier=3D"${pki_id}" installKByte=
s=3D"0" updateKBytes=3D"0">
+        <must-close/>
+        <bundle-version/>
+    </pkg-ref>
+    <choices-outline>
+        <line choice=3D"${p_id}"/>
+    </choices-outline>
+    <choice id=3D"${p_id}" title=3D"Package" start_selected=3D"true">
+        <pkg-ref id=3D"${p_id}"/>
+    </choice>
+    <product id=3D"${pkg_id}" version=3D"${pkg_vers}"/>
+</installer-gui-script>
+EOF
+
+( cd dist && ${xar} --compression none -cf "${pkg_path}" * )
+
diff --git a/conf/files/post-install.in b/conf/files/post-install.in
new file mode 100644
index 0000000..9321f79
--- /dev/null
+++ b/conf/files/post-install.in
@@ -0,0 +1,9 @@
+#!/bin/bash
+#########################################
+#  file: meta-darwin/conf/files/post-install.in
+#
+#  @file    post-install
+#  @version V1.0
+#
+# post install script for meta-darwin SDK
+#
diff --git a/conf/files/pre-install.in b/conf/files/pre-install.in
new file mode 100644
index 0000000..0c488c4
--- /dev/null
+++ b/conf/files/pre-install.in
@@ -0,0 +1,84 @@
+#!/usr/bin/osascript -l JavaScript
+/***************************************************
+ * file: meta-darwin/conf/files/pre-install.in
+ *
+ * @file    pre-install.jxa
+ * @version V1.0
+ *
+ * pre-install script for meta-darwin macOS SDK
+ *
+ * this script gets user options and sets up various things
+ * so that the files are installed properly in their final
+ * destination
+ *
+ */
+
+ObjC.import("stdlib");
+
+var seApp =3D Application("System Events");
+var oProcess =3D seApp.processes.whose({frontmost: true})[0];
+var appName =3D oProcess.displayedName();
+
+app =3D Application.currentApplication();
+
+app.includeStandardAdditions =3D true;
+
+retval =3D []
+
+function run(args) {
+
+  codesign_id=3D""
+  if (true) {
+    idstr =3D app.doShellScript("security -qq find-identity -v -p codesi=
gning |cut -c47- |tr '\n' ';'")
+    idList =3D idstr.split(';').filter(element =3D> element);
+    switch (idList.length) {
+      case 0: // can't sign
+        let dialogText =3D "Could not find any code signing identities, =
binaries will not be signed"
+        app.displayDialog(dialogText)
+      break;
+
+      case 1: // no decisions
+        codesign_id =3D idList[0]
+      break;
+
+      default:
+        codesign_id =3D app.chooseFromList(idList, {
+          withTitle: "Signing ID",
+          withPrompt: "Please select an ID to sign binaries",
+          defaultItems: [idList[0]],
+          okButtonName: "OK",
+          cancelButtonName: "Cancel",
+          multipleSelectionsAllowed: false,
+          emptySelectionAllowed: false
+        })
+      if (codesign_id =3D=3D false) {
+        let dialogText =3D "Cancelled code signing"
+        app.displayDialog(dialogText)
+        return false
+      }
+    }
+  }
+
+  // finalize script
+  // finalize {staging} {new_path} {code_sign}
+  pwd =3D ObjC.unwrap($.NSFileManager.defaultManager.currentDirectoryPat=
h)
+  finalize =3D pwd + "/finalize-pkg";
+  staging =3D $.getenv("INSTALLER_PAYLOAD_DIR") + "@dst_path@"
+  new_path =3D args[1]
+  command =3D `${finalize} "${staging}" "${new_path}" ${codesign_id}`
+
+  var dialogText =3D "Will run a script to relocate and codesign\n\n"
+  dialogText +=3D "\n\n"
+  dialogText +=3D "This may take a few minutes depending on the size of =
the SDK"
+
+  app.displayDialog(dialogText)
+
+  finalize_data =3D app.doShellScript(command + " >/dev/null 2>&1")
+
+  app.displayDialog(finalize_data)
+
+  retval.push("ok")
+  return retval.join("\n")
+}
+
+/* end of pre-install.in */
diff --git a/conf/layer.conf b/conf/layer.conf
index 2f14754..6730f3b 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -9,3 +9,6 @@ BBFILES +=3D "${LAYERDIR}/recipes*/*/*.bb ${LAYERDIR}/rec=
ipes*/*/*.bbappend"
 BBFILE_COLLECTIONS +=3D "meta-darwin"
 BBFILE_PATTERN_meta-darwin :=3D "^${LAYERDIR}/"
 BBFILE_PRIORITY_meta-darwin =3D "8"
+
+DARWINBASE =3D '${@os.path.normpath("${LAYERDIR}")}'
+BB_BASEHASH_IGNORE_VARS:append =3D " DARWINBASE"
diff --git a/conf/machine-sdk/darwin-common.inc b/conf/machine-sdk/darwin=
-common.inc
index cec76a5..3dec2b4 100644
--- a/conf/machine-sdk/darwin-common.inc
+++ b/conf/machine-sdk/darwin-common.inc
@@ -14,8 +14,13 @@ SDKUSE_NLS =3D "no"
 SDKIMAGE_LINGUAS =3D ""
 SDK_DEPENDS:remove =3D "nativesdk-glibc-locale nativesdk-qemuwrapper-cro=
ss"
=20
+SDK_DEPENDS:append =3D "${@bb.utils.contains('DARWIN_INSTALLER_PKG', '1'=
, ' bomutils-native xar-native', '', d)}"
+SDK_DEPENDS:append =3D "${@bb.utils.contains('DARWIN_INSTALLER_IMG', '1'=
, ' hfsprogs-native libdmg-hfsplus-native', '', d)}"
+
 SDKPKGSUFFIX =3D "nativesdk-darwin"
=20
+DARWIN_INSTALL_LOC =3D "${@d.getVar('DARWIN_INSTALLER_PATH') or '/Librar=
y/Developer/org.openembedded.sdk'}"
+
 OSX_TOOLCHAIN_OPTIONS =3D " \
     -mmacosx-version-min=3D12.3 \
     -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/usr/lib \
@@ -24,9 +29,12 @@ OSX_TOOLCHAIN_OPTIONS =3D " \
 "
=20
 TOOLCHAIN_OPTIONS:append:darwin21 =3D " \
-    ${OSX_TOOLCHAIN_OPTIONS}"
+    ${OSX_TOOLCHAIN_OPTIONS} \
+"
+
 TOOLCHAIN_OPTIONS:append:class-cross-canadian =3D " \
-    ${OSX_TOOLCHAIN_OPTIONS}"
+    ${OSX_TOOLCHAIN_OPTIONS} \
+"
=20
 # Remove -rpath-link
 BUILDSDK_LDFLAGS =3D " \
@@ -35,3 +43,46 @@ BUILDSDK_LDFLAGS =3D " \
 "
=20
 MACHINEOVERRIDES .=3D ":darwinsdk"
+
+TOOLCHAIN_SHAR_EXT_TMPL ?=3D "${DARWINBASE}/conf/files/darwin-toolchain-=
shar-extract.sh"
+
+SDK_POSTPROCESS_COMMAND:append =3D "${@bb.utils.contains('DARWIN_INSTALL=
ER_PKG', '1', ' create_macos_pkg', '', d)}"
+SDK_POSTPROCESS_COMMAND:append =3D "${@bb.utils.contains('DARWIN_INSTALL=
ER_IMG', '1', ' create_macos_img', '', d)}"
+
+#
+# remove the .xz and .sh creation if we want to save a bit of time
+SDK_POSTPROCESS_COMMAND:remove =3D "${@bb.utils.contains('DARWIN_INSTALL=
ER_SH', '0', ' archive_sdk', '', d)}"
+SDK_POSTPROCESS_COMMAND:remove =3D "${@bb.utils.contains('DARWIN_INSTALL=
ER_SH', '0', ' create_shar', '', d)}"
+
+fakeroot create_macos_pkg() {
+    sdk_pkg=3D"${SDKDEPLOYDIR}/${TOOLCHAIN_OUTPUTNAME}.pkg"
+    native_sysroot=3D$(basename ${SDKPATHNATIVE})
+
+    sed -e "s#@target_prefix@#${TARGET_PREFIX}#g" \
+        -e "s#@native_sysroot@#${native_sysroot}#g" \
+         ${DARWINBASE}/conf/files/finalize-sdk.sh \
+         > "${B}/finalize-pkg"
+
+    (cd ${B}; \
+        ${DARWINBASE}/conf/files/mk-macos-pkg.sh "${SDK_TITLE}" "${SDK_N=
AME}" "${SDK_ARCH}" "${DISTRO_VERSION}.${SDK_VERSION}" "${SDK_OUTPUT}/${S=
DKPATH}" "${sdk_pkg}" "${B}/finalize-pkg" "${DARWIN_INSTALL_LOC}/${SDK_NA=
ME}" \
+    )
+
+   ls -lh "${sdk_pkg}"
+}
+
+fakeroot create_macos_img() {
+    sdk_img=3D"${SDKDEPLOYDIR}/${TOOLCHAIN_OUTPUTNAME}.img"
+    native_sysroot=3D$(basename ${SDKPATHNATIVE})
+    sed -e "s#@target_prefix@#${TARGET_PREFIX}#g" \
+        -e "s#@native_sysroot@#${native_sysroot}#g" \
+         ${DARWINBASE}/conf/files/finalize-sdk.sh \
+         > "${B}/finalize-img"
+
+    echo 'rm ${0}' >> "${B}/finalize-img"
+
+    ( cd ${B}; \
+        ${DARWINBASE}/conf/files/mk-macos-img.sh "${SDK_TITLE}" "${SDK_N=
AME}" "${SDK_ARCH}" "${DISTRO_VERSION}.${SDK_VERSION}" "${SDK_OUTPUT}/${S=
DKPATH}" "${sdk_img}" "${B}/finalize-img" "${DARWIN_INSTALL_LOC}/${SDK_NA=
ME}" \
+    )
+   bzip2 "${sdk_img}"
+   ls -lh "${sdk_img}.bz2"
+}
--=20
2.50.1 (Apple Git-155)


