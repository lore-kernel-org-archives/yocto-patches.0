Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23496FEFB46
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 12:15:52 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.94563.1772194545703952205
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Feb 2026 04:15:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=IipFIkO1;
 spf=pass (domain: snapchat.com, ip: 209.85.128.49, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso16007545e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 04:15:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772194543; cv=none;
        d=google.com; s=arc-20240605;
        b=GL9pM003kCdf1Ca8jGtlPZ7gc7/gi68rYQAPBgOTkO6uzJVOCYpPWbsiPrrHX/rDZz
         RmVnqc+gWKaFxP7M/XGAE98MJxEhqtxtvyaieTntAOQr7FF04ayt5iF0lLOHFweWfeWA
         cD05Fcgb7i9ygxbdodCLYqBU921s+dvA+/QgIJQMmcGfKXCA/SIulGecshqsa8be2jWQ
         UvcFDTUjEjwbXN0eMXoeOvzlncSAGhTZqMhJqLgVqPtpMD1mUW8zk4yMGEEVWVJ/AUXO
         YLIZNalasnM6F6MzCOupAgtwvBH/8RVXxaK6hUFGFAhnbR8YUj7sLQGqoiaPQ/qPHshf
         yv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N9yLoUYSSdPBqswoxohzgUMWvxaU1W8F8Uj6G5meouM=;
        fh=vnwvjJBmT4xP5bZnotRs811IpgK/To6PNpBe4whKe/M=;
        b=H5Azx6RpYKtSMn0QnRhPwU6h8xOWgIrW8IQVL0eARZoZnwXfCru3Qul+XBdQo0OyEr
         HLIgDBJM7P6U/vl1lbIBMSOr+T2zSYEBvdeoXM+gKxzrJ5lH9m15QnueT/8wdDBSLEq5
         4m3WVdmsQisRZQbM3o/dPAgs5wTculsoifTaboZwRvbVjRipR8h9Kd2bMN7WzRUFxhAB
         Q3Rf4lQpks1gE4EK5H9nuVpXefZbLT6RPIjATT7T0zdbux+D+b/7r6A3xk8bbSxuNmXA
         3G7sXB+xkvBKFNOqsmU9zRaeo6ZQ+MbbJ+GNwT84AAhI2ZM0xVDm/HjXQDAL2hNWvjzo
         rcig==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1772194543; x=1772799343; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N9yLoUYSSdPBqswoxohzgUMWvxaU1W8F8Uj6G5meouM=;
        b=IipFIkO1tDnfvyF8xxEPzFIfr10t+H/Ttv1TFHPz//72ppDClE0Op9Dm+EA767SbrZ
         c3VGsfC5tStJtIJUgM3DRKkLslcERU+F9yVwMM2ri7yu0QuqrdBGajkWhqPsWXjoVv/n
         9ak2Ae7km5mtrSbx9FWXb2hRyXJkTzRK3NofY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772194543; x=1772799343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9yLoUYSSdPBqswoxohzgUMWvxaU1W8F8Uj6G5meouM=;
        b=qrVO4p0iwFFTF5xscYVhpJJ/lf/WDBB0SlkPFoO+KcDejSvCdsWRoab5+fzVZJYIPf
         5MvKkkDdRqncLcYzm7gqvX00bYikyLf3baH/41qGM8gyUsgAeLZFzdgdDLsIxCu9ZaP/
         OYuZqeqa1gk0A4ALsK7kXmFRQ+S2HnUhxwQogqOjUdx3ngAWgEi3TBcbJtJJ7IUMNw2r
         /vBgvVMg02kga7B4JLcP+loM7WTP8yg682KaGsyIEpnxocIyMEVQR8V48JmYUZD7e62F
         B5Qm36qdPdsq9NZRUiEH5px+FhMAKuptSdLzlWYTilLTosiejtJavpY2+I3WjWHHyCMp
         iLHw==
X-Gm-Message-State: AOJu0YzfGdIThKBAsd6ImKCLiPCKPn+Dl5Pltip5bdK2j0UYJGj7BXlK
	2Sdt627ZBp3FaXTuKKrA5CrdCVU+An0O9mVTaM0pHbpUaMuoQ3DFaXRxYutkLKmrzHmN4XORcBU
	qfkI5gFq1lqAjpdoT63yLisCmWRQgtb7QHhxbSnekuyftH1GKDawQsb5ncg==
X-Gm-Gg: ATEYQzxQKiNepGtvkj0Ss2fFyPnQk9iGWwWzVUZuhhfCR/imo3nQgUX1roxUjhpHQ3h
	ARi/dPN5W2ZwxIaAgHfRxZu/okhATV5pBC6EmNhNTPviG1iqYLMmUnzPzKXv7NTzMI+4dVSmMbv
	8UYHPf64Np4qiMz9EWR35a8OcC/sYc1g/crSd4VVhNnAlvQS8FrVO9NiojbBXsau7qK0oZ2CFES
	ZSf3/GKLcIo5EwITcPwLHPmLj+846+qDQCjaKmyHA1zI4/xq0nYim+vui8o5jskAOLetNVdpE/8
	BMXJwV3V4egiZ6YUZPs/HyXhkoy5ds/nsHZbEl46kAXldp0Sdxc=
X-Received: by 2002:a05:600c:1c15:b0:483:6d4e:9811 with SMTP id
 5b1f17b1804b1-483c9c0b6ddmr45621525e9.31.1772194542712; Fri, 27 Feb 2026
 04:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20260202165146.3727-2-dev@qinc.tv> <20260202165146.3727-3-dev@qinc.tv>
In-Reply-To: <20260202165146.3727-3-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Fri, 27 Feb 2026 13:15:31 +0100
X-Gm-Features: AaiRm52zrzbPlulJAVnxoSvIZJaT8zU_HuE2IIFSpi5CUi26twbQk57cf20APas
Message-ID: <CAHUKmYZW+-5=5q8mz_NOjECnG00yuZkPg1ZQ7g07BzqQqEUzdA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH 1/1] Add DMG and PKG SDK installers
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Content-Type: multipart/alternative; boundary="000000000000312c8c064bcd3298"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 12:15:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3301

--000000000000312c8c064bcd3298
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
sorry for the delay.
- I have tested some local build of some custom image, and it seems the pkg
and dmg packages are quite big, compared to the traditional sh files. I'm
not familiar with those packaging formats so I'm not sure whether it is
normal? For a 554MB sh file, I've got a 908MB pkg file and a 3.5GB dmg
file. I have also tested local installation on macOS and it principle it
works, even though of course there are warnings related to the lack of
signature.

Here is some feedback on the patch (partly AI generated, but reviewed
manually by me):

1. **Variable typo in darwin-toolchain-shar-extract.sh (line 198-199)**
   - Declares `fs_dev_type` but uses `fsdevtype` on next line
   - NFS filesystem check will silently fail, never triggering abort
condition
   - Fix: Change `fsdevtype` to `fs_dev_type` on line 199

2. **Undefined variable in mk-macos-pkg.sh (line 72)**
   - Script defines `pkg_vers` (line 22) but references `pkg_version` (line
72)
   - Generated PackageInfo will have empty version string
   - Fix: Change `${pkg_version}` to `${pkg_vers}` in PackageInfo XML

3. **Missing quotes in darwin-common.inc (line 66)**
   - Unquoted `${DARWIN_INSTALL_LOC}/${SDK_NAME}` passed to mk-macos-pkg.sh
   - Will break if DARWIN_INSTALLER_PATH contains spaces
   - Fix: Quote argument as `"${DARWIN_INSTALL_LOC}/${SDK_NAME}"`
   - Same issue on line 75 for mk-macos-dmg.sh call

4. **Incorrect sed command in mk-macos-pkg.sh (line 89)**
   - `sed -e 's,$,&,' ${files}/post-install.in >scripts/post-install`
   - Pattern 's,$,&,' does nothing (replaces end-of-line with itself)
   - Since post-install.in is intentionally empty (per cover letter Q5),
just use `cp` instead
   - Or remove the sed and the empty post-install.in file entirely if not
needed

5. **Typo in README (line 33)**
   - "follwing" should be "following"





On Mon, Feb 2, 2026 at 5:52=E2=80=AFPM Eric L. Hernes via lists.yoctoprojec=
t.org
<dev=3Dqinc.tv@lists.yoctoproject.org> wrote:

> This adds support for generating both .dmg and .pkg installers.
>
> The .dmg will require running the `finalize-dmg` to relocate and sign
> the executables.
>
> The .pkg automates the process and integrates the relocation and
> signage into the installer.
>
> Signed-off-by: Eric L. Hernes <dev@qinc.tv>
> ---
>  README                                      |  19 ++
>  conf/files/darwin-toolchain-shar-extract.sh | 316 ++++++++++++++++++++
>  conf/files/finalize-sdk.sh                  |  48 +++
>  conf/files/mk-macos-dmg.sh                  |  49 +++
>  conf/files/mk-macos-pkg.sh                  | 161 ++++++++++
>  conf/files/post-install.in                  |   9 +
>  conf/files/pre-install.in                   |  84 ++++++
>  conf/layer.conf                             |   3 +
>  conf/machine-sdk/darwin-common.inc          |  54 +++-
>  9 files changed, 741 insertions(+), 2 deletions(-)
>  create mode 100644 conf/files/darwin-toolchain-shar-extract.sh
>  create mode 100644 conf/files/finalize-sdk.sh
>  create mode 100755 conf/files/mk-macos-dmg.sh
>  create mode 100755 conf/files/mk-macos-pkg.sh
>  create mode 100644 conf/files/post-install.in
>  create mode 100644 conf/files/pre-install.in
>
> diff --git a/README b/README
> index 89845b5..97d176d 100644
> --- a/README
> +++ b/README
> @@ -30,3 +30,22 @@
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2ep=
ckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DocDt_LbHjapIywNY=
WeZjpn13nP4qi8M-ViMysQ42MEAh4pLHUAUi7nHPV2HAzLgY&s=3Dwo9y9WkvtD-73r84EwDgaS=
oRq1s2Q7o6YOy5P5FZRV8&e=3D
> before being able to post.
>  When sending single patches, please use something like:
>  'git send-email -M -1 --to yocto-patches@lists.yoctoproject.org
> --subject-prefix=3D"meta-darwin][PATCH"'
>
> +The follwing variables can be set in the local.conf or elsewhere:
> +
> +To enable building the .pkg installer, set:
> +DARWIN_INSTALLER_PKG =3D "1"
> +
> +To enable building a .dmg installer, set:
> +DARWIN_INSTALLER_DMG =3D "1"
> +
> +To save some time during builds, you can disable the shell script
> installer with:
> +DARWIN_INSTALLER_SH =3D "0"
> +
> +To specify the path in the .dmg and path that the .pkg will install to,
> set
> +DARWIN_INSTALLER_PATH =3D "/Library/Developer/org.openembedded.sdk"
> +
> +The .dmg will require running the `finalize-dmg` to relocate and sign
> +the executables.
> +
> +The .pkg automates the process and integrates the relocation and
> +signage into the installer.
> diff --git a/conf/files/darwin-toolchain-shar-extract.sh
> b/conf/files/darwin-toolchain-shar-extract.sh
> new file mode 100644
> index 0000000..4417010
> --- /dev/null
> +++ b/conf/files/darwin-toolchain-shar-extract.sh
> @@ -0,0 +1,316 @@
> +#!/bin/sh
> +
> +export LC_ALL=3Den_US.UTF-8
> +
> +# The pipefail option is now part of POSIX (POSIX.1-2024) and available
> in more
> +# and more shells. Enable it if available to make the SDK installer more
> robust.
> +(set -o pipefail 2> /dev/null) && set -o pipefail
> +
> +#Make sure at least one python is installed
> +INIT_PYTHON=3D$(which python3 2>/dev/null )
> +[ -z "$INIT_PYTHON" ] && INIT_PYTHON=3D$(which python2 2>/dev/null)
> +[ -z "$INIT_PYTHON" ] && echo "Error: The SDK needs a python installed"
> && exit 1
> +
> +# Remove invalid PATH elements first (maybe from a previously setup
> toolchain now deleted
> +PATH=3D`$INIT_PYTHON -c 'import os; print(":".join(e for e in
> os.environ["PATH"].split(":") if os.path.exists(e)))'`
> +
> +tweakpath () {
> +    case ":${PATH}:" in
> +        *:"$1":*)
> +            ;;
> +        *)
> +            PATH=3D$PATH:$1
> +    esac
> +}
> +
> +# Some systems don't have /usr/sbin or /sbin in the cleaned environment
> PATH but we make need it
> +# for the system's host tooling checks
> +tweakpath /usr/sbin
> +tweakpath /sbin
> +
> +# linux calls it aarch64; Apple calls it arm64
> +if [ @SDK_ARCH@ =3D=3D aarch64 ]; then
> +    OSX_SDK_ARCH=3Darm64
> +else
> +    OSX_SDK_ARCH=3D@SDK_ARCH@
> +fi
> +
> +INST_ARCH=3D$(uname -m | gsed -e "s/i[3-6]86/ix86/" -e
> "s/x86[-_]64/x86_64/")
> +SDK_ARCH=3D$(echo ${OSX_SDK_ARCH} | gsed -e "s/i[3-6]86/ix86/" -e
> "s/x86[-_]64/x86_64/")
> +
> +INST_GCC_VER=3D$(gcc --version 2>/dev/null | gsed -ne 's/.*
> \([0-9]\+\.[0-9]\+\)\.[0-9]\+.*/\1/p')
> +SDK_GCC_VER=3D'@SDK_GCC_VER@'
> +
> +verlte () {
> +       [  "$1" =3D "`printf "$1\n$2" | sort -V | head -n1`" ]
> +}
> +
> +verlt() {
> +       [ "$1" =3D "$2" ] && return 1 || verlte $1 $2
> +}
> +
> +verlt `uname -r` @OLDEST_KERNEL@
> +if [ $? =3D 0 ]; then
> +       echo "Error: The SDK needs a kernel > @OLDEST_KERNEL@"
> +       exit 1
> +fi
> +
> +if [ "$INST_ARCH" !=3D "$SDK_ARCH" ]; then
> +       # Allow for installation of ix86 SDK on x86_64 host
> +       if [ "$INST_ARCH" !=3D x86_64 -o "$SDK_ARCH" !=3D ix86 ]; then
> +               echo "Error: Incompatible SDK installer! Your host is
> $INST_ARCH and this SDK was built for $SDK_ARCH hosts."
> +               exit 1
> +       fi
> +fi
> +
> +if ! xz -V > /dev/null 2>&1; then
> +       echo "Error: xz is required for installation of this SDK, please
> install it first"
> +       exit 1
> +fi
> +
> +SDK_BUILD_PATH=3D"@SDKPATH@"
> +DEFAULT_INSTALL_DIR=3D"@SDKPATHINSTALL@"
> +SUDO_EXEC=3D""
> +EXTRA_TAR_OPTIONS=3D""
> +target_sdk_dir=3D""
> +answer=3D""
> +relocate=3D1
> +savescripts=3D0
> +verbose=3D0
> +publish=3D0
> +listcontents=3D0
> +while getopts ":yd:npDRSl" OPT; do
> +       case $OPT in
> +       y)
> +               answer=3D"Y"
> +               ;;
> +       d)
> +               target_sdk_dir=3D$OPTARG
> +               ;;
> +       n)
> +               prepare_buildsystem=3D"no"
> +               ;;
> +       p)
> +               prepare_buildsystem=3D"no"
> +               publish=3D1
> +               ;;
> +       D)
> +               verbose=3D1
> +               ;;
> +       R)
> +               relocate=3D0
> +               savescripts=3D1
> +               ;;
> +       S)
> +               savescripts=3D1
> +               ;;
> +       l)
> +               listcontents=3D1
> +               ;;
> +       *)
> +               echo "Usage: $(basename "$0") [-y] [-d <dir>]"
> +               echo "  -y         Automatic yes to all prompts"
> +               echo "  -d <dir>   Install the SDK to <dir>"
> +               echo "=3D=3D=3D=3D=3D=3D=3D=3D Extensible SDK only option=
s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
> +               echo "  -n         Do not prepare the build system"
> +               echo "  -p         Publish mode (implies -n)"
> +               echo "=3D=3D=3D=3D=3D=3D=3D=3D Advanced DEBUGGING ONLY OP=
TIONS =3D=3D=3D=3D=3D=3D=3D=3D"
> +               echo "  -S         Save relocation scripts"
> +               echo "  -R         Do not relocate executables"
> +               echo "  -D         use set -x to see what is going on"
> +               echo "  -l         list files that will be extracted"
> +               exit 1
> +               ;;
> +       esac
> +done
> +
> +payload_offset=3D$(($(grep -na -m1 "^MARKER:$" "$0"|cut -d':' -f1) + 1))
> +if [ "$listcontents" =3D "1" ] ; then
> +    if [ @SDK_ARCHIVE_TYPE@ =3D "zip" ]; then
> +        tail -n +$payload_offset "$0" > sdk.zip
> +        if unzip -l sdk.zip;then
> +            rm sdk.zip
> +        else
> +            rm sdk.zip && exit 1
> +        fi
> +    else
> +        tail -n +$payload_offset "$0"| gtar tvJ || exit 1
> +    fi
> +    exit
> +fi
> +
> +titlestr=3D"@SDK_TITLE@ installer version @SDK_VERSION@"
> +printf "%s\n" "$titlestr"
> +printf "%${#titlestr}s\n" | tr " " "=3D"
> +
> +if [ $verbose =3D 1 ] ; then
> +       set -x
> +fi
> +
> +@SDK_PRE_INSTALL_COMMAND@
> +
> +# SDK_EXTENSIBLE is exposed from the SDK_PRE_INSTALL_COMMAND above
> +if [ "$SDK_EXTENSIBLE" =3D "1" ]; then
> +       DEFAULT_INSTALL_DIR=3D"@SDKEXTPATH@"
> +       if [ "$INST_GCC_VER" =3D '4.8' -a "$SDK_GCC_VER" =3D '4.9' ] || [
> "$INST_GCC_VER" =3D '4.8' -a "$SDK_GCC_VER" =3D '' ] || \
> +               [ "$INST_GCC_VER" =3D '4.9' -a "$SDK_GCC_VER" =3D '' ]; t=
hen
> +               echo "Error: Incompatible SDK installer! Your host gcc
> version is $INST_GCC_VER and this SDK was built by gcc higher version."
> +               exit 1
> +       fi
> +fi
> +
> +if [ "$target_sdk_dir" =3D "" ]; then
> +       if [ "$answer" =3D "Y" ]; then
> +               target_sdk_dir=3D"$DEFAULT_INSTALL_DIR"
> +       else
> +               read -p "Enter target directory for SDK (default:
> $DEFAULT_INSTALL_DIR): " target_sdk_dir
> +               [ "$target_sdk_dir" =3D "" ] &&
> target_sdk_dir=3D$DEFAULT_INSTALL_DIR
> +       fi
> +fi
> +
> +eval target_sdk_dir=3D$(echo "$target_sdk_dir"|gsed 's/ /\\ /g')
> +if [ -d "$target_sdk_dir" ]; then
> +       target_sdk_dir=3D$(cd "$target_sdk_dir"; pwd)
> +else
> +       target_sdk_dir=3D$(greadlink -m "$target_sdk_dir")
> +fi
> +
> +# limit the length for target_sdk_dir, ensure the relocation behaviour i=
n
> relocate_sdk.py has right result.
> +# This is due to ELF interpreter being set to 'a'*1024 in
> +# meta/recipes-core/meta/uninative-tarball.bb
> +if [ ${#target_sdk_dir} -gt 1024 ]; then
> +       echo "Error: The target directory path is too long!!!"
> +       exit 1
> +fi
> +
> +if [ "$SDK_EXTENSIBLE" =3D "1" ]; then
> +       # We're going to be running the build system, additional
> restrictions apply
> +       if echo "$target_sdk_dir" | grep -q '[+\ @$]'; then
> +               echo "The target directory path ($target_sdk_dir) contain=
s
> illegal" \
> +                    "characters such as spaces, @, \$ or +. Abort!"
> +               exit 1
> +       fi
> +       # The build system doesn't work well with /tmp on NFS
> +       fs_dev_path=3D"$target_sdk_dir"
> +       while [ ! -d "$fs_dev_path" ] ; do
> +               fs_dev_path=3D`dirname $fs_dev_path`
> +        done
> +       fs_dev_type=3D`stat -f -c '%t' "$fs_dev_path"`
> +       if [ "$fsdevtype" =3D "6969" ] ; then
> +               echo "The target directory path $target_sdk_dir is on NFS=
,
> this is not possible. Abort!"
> +               exit 1
> +       fi
> +else
> +       if [ -n "$(echo $target_sdk_dir|grep ' ')" ]; then
> +               echo "The target directory path ($target_sdk_dir) contain=
s
> spaces. Abort!"
> +               exit 1
> +       fi
> +fi
> +
> +if [ -e "$target_sdk_dir/environment-setup-@REAL_MULTIMACH_TARGET_SYS@"
> ]; then
> +       echo "The directory \"$target_sdk_dir\" already contains a SDK fo=
r
> this architecture."
> +       printf "If you continue, existing files will be overwritten!
> Proceed [y/N]? "
> +
> +       default_answer=3D"n"
> +else
> +       printf "You are about to install the SDK to \"$target_sdk_dir\".
> Proceed [Y/n]? "
> +
> +       default_answer=3D"y"
> +fi
> +
> +if [ "$answer" =3D "" ]; then
> +       read answer
> +       [ "$answer" =3D "" ] && answer=3D"$default_answer"
> +else
> +       echo $answer
> +fi
> +
> +if [ "$answer" !=3D "Y" -a "$answer" !=3D "y" ]; then
> +       echo "Installation aborted!"
> +       exit 1
> +fi
> +
> +# Try to create the directory (this will not succeed if user doesn't hav=
e
> rights)
> +mkdir -p $target_sdk_dir >/dev/null 2>&1
> +
> +# if don't have the right to access dir, gain by sudo
> +if [ ! -x $target_sdk_dir -o ! -w $target_sdk_dir -o ! -r $target_sdk_di=
r
> ]; then
> +       if [ "$SDK_EXTENSIBLE" =3D "1" ]; then
> +               echo "Unable to access \"$target_sdk_dir\", will not
> attempt to use" \
> +                    "sudo as as extensible SDK cannot be used as root."
> +               exit 1
> +       fi
> +
> +       SUDO_EXEC=3D$(which "sudo")
> +       if [ -z $SUDO_EXEC ]; then
> +               echo "No command 'sudo' found, please install sudo first.
> Abort!"
> +               exit 1
> +       fi
> +
> +       # test sudo could gain root right
> +       $SUDO_EXEC pwd >/dev/null 2>&1
> +       [ $? -ne 0 ] && echo "Sorry, you are not allowed to execute as
> root." && exit 1
> +
> +       # now that we have sudo rights, create the directory
> +       $SUDO_EXEC mkdir -p $target_sdk_dir >/dev/null 2>&1
> +fi
> +
> +printf "Extracting SDK..."
> +if [ @SDK_ARCHIVE_TYPE@ =3D "zip" ]; then
> +    tail -n +$payload_offset "$0" > sdk.zip
> +    if $SUDO_EXEC unzip $EXTRA_TAR_OPTIONS sdk.zip -d $target_sdk_dir;th=
en
> +        rm sdk.zip
> +    else
> +        rm sdk.zip && exit 1
> +    fi
> +else
> +    tail -n +$payload_offset "$0"| $SUDO_EXEC gtar mxJ -C $target_sdk_di=
r
> --checkpoint=3D.2500 $EXTRA_TAR_OPTIONS || exit 1
> +fi
> +echo "done"
> +
> +printf "Setting it up..."
> +# fix environment paths
> +real_env_setup_script=3D""
> +for env_setup_script in `ls $target_sdk_dir/environment-setup-*`; do
> +       if grep -q 'OECORE_NATIVE_SYSROOT=3D' $env_setup_script; then
> +               # Handle custom env setup scripts that are only named
> +               # environment-setup-* so that they have relocation
> +               # applied - what we want beyond here is the main one
> +               # rather than the one that simply sorts last
> +               real_env_setup_script=3D"$env_setup_script"
> +       fi
> +       $SUDO_EXEC gsed -e "s:@SDKPATH@:$target_sdk_dir:g" -i
> $env_setup_script
> +done
> +if [ -n "$real_env_setup_script" ] ; then
> +       env_setup_script=3D"$real_env_setup_script"
> +fi
> +
> +@SDK_POST_INSTALL_COMMAND@
> +
> +# delete the relocating script, so that user is forced to re-run the
> installer
> +# if he/she wants another location for the sdk
> +if [ $savescripts =3D 0 ] ; then
> +       $SUDO_EXEC rm -f ${env_setup_script%/*}/relocate_sdk.py
> ${env_setup_script%/*}/relocate_sdk.sh
> +fi
> +
> +# Execute post-relocation script
> +post_relocate=3D"$target_sdk_dir/post-relocate-setup.sh"
> +if [ -e "$post_relocate" ]; then
> +       $SUDO_EXEC gsed -e "s:@SDKPATH@:$target_sdk_dir:g" -i
> $post_relocate
> +       $SUDO_EXEC /bin/sh $post_relocate "$target_sdk_dir" "@SDKPATH@"
> +       if [ $? -ne 0 ]; then
> +               echo "Executing $post_relocate failed"
> +               exit 1
> +       fi
> +       $SUDO_EXEC rm -f $post_relocate
> +fi
> +
> +echo "SDK has been successfully set up and is ready to be used."
> +echo "Each time you wish to use the SDK in a new shell session, you need
> to source the environment setup script e.g."
> +for env_setup_script in `ls $target_sdk_dir/environment-setup-*`; do
> +       echo " \$ . $env_setup_script"
> +done
> +
> +exit 0
> +
> +MARKER:
> diff --git a/conf/files/finalize-sdk.sh b/conf/files/finalize-sdk.sh
> new file mode 100644
> index 0000000..bd4f313
> --- /dev/null
> +++ b/conf/files/finalize-sdk.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +##################################################
> +## file: finalize-sdk.sh
> +##
> +##
> +## /bin/sh script to finalize oesdk files
> +##
> +## 1. change pathing from hardcoded path to install path
> +## 2. codesign binaries and dylibs
> +##
> +## This can be run on the final installed files; or during install in a
> staging area if we know
> +## what the final destination path will be.
> +##
> +
> +x_path=3D$(realpath $(dirname "${0}"))
> +first_csid=3D$(security -qq find-identity -v -p codesigning |cut -c47-
> |head -1 | tr -d '"')
> +
> +staging=3D${1:-"${x_path}"}
> +new_path=3D${2:-"${x_path}"}
> +codesign_id=3D${3:-"${first_csid}"}
> +
> +native_sysroot=3D"@native_sysroot@"
> +
> +do_relocate=3Dyes
> +do_codesign=3Dyes
> +
> +if [ "${do_relocate}" =3D yes ]; then
> +    old_path=3D"/usr/local/oe-sdk-hardcoded-buildpath"
> +
> +    find "${staging}" -type f -exec file {} +| grep -i
> ":.*\(ASCII\|script\|source\).*text" |cut -d: -f1  |
> +        while read fn; do
> +            sed -i "" "s,${old_path},${new_path},g" "${fn}" || echo
> "${fn}"
> +        done
> +fi
> +
> +if [ "${do_codesign}" =3D yes ]; then
> +    if [ -z "${codesign_id}" ]; then
> +        echo "requested codesigning, but did not find a codesigning
> identity"
> +    else
> +        find "${staging}/sysroots/${native_sysroot}" -type f -exec file
> {} + |
> +            grep Mach-O |
> +            cut -d: -f1 |
> +            sed -e "s,^,'," -e "s,$,'," |
> +            xargs codesign --continue --force --timestamp --sign
> "${codesign_id}"
> +    fi
> +fi
> +
> +exit 0
> diff --git a/conf/files/mk-macos-dmg.sh b/conf/files/mk-macos-dmg.sh
> new file mode 100755
> index 0000000..ebf95d0
> --- /dev/null
> +++ b/conf/files/mk-macos-dmg.sh
> @@ -0,0 +1,49 @@
> +#!/bin/bash
> +##################################################
> +## file: meta-darwin/conf/files/mk-macos-dmg.sh
> +##
> +## Original Author: Eric L. Hernes <eric@qinc.tv>
> +##
> +## /bin/sh script to do create macos .dmg image for openembedded sdk
> +##
> +
> +# $1 =3D SDK Title
> +# $2 =3D SDK Name
> +# $3 =3D SDK Architecture
> +# $4 =3D SDK Version
> +# $5 =3D path to SDK path files
> +# $6 =3D SDK dmg output filename
> +# $7 =3D path to finalize script
> +# $8 =3D destination path within the DMG
> +
> +pkg_title=3D${1:-"OpenEmbedded SDK"}
> +pkg_name=3D${2:-"oesdk-darwin21"}
> +pkg_arch=3D${3:-"aarch64"}
> +pkg_vers=3D${4:-"x.x.x.y"}
> +sdk_path=3D${5:-".../tmp/work/armv8a-oe-linux/meta-toolchain/1.0/sdk/ima=
ge"}
> +dmg_path=3D${6:-".../tmp/deploy/sdk/macos-test-sdk.dmg"}
> +finalize_dmg=3D${7:-"finalize-dmg"}
> +dst_path=3D${8-"/Library/Developer/org.openembedded.sdk/${pkg_name}"}
> +
> +dmg_finalize=3D"${dst_path}/"$(basename "${finalize_dmg}")
> +
> +set $(du -sm ${sdk_path})
> +
> +# add 10% for overhead
> +size_mb=3D$((${1} * 11 / 10))
> +
> +dd if=3D/dev/zero of=3D"${dmg_path}" bs=3D1M count=3D${size_mb}
> +mkfs.hfsplus -s -v "${pkg_name}" "${dmg_path}"
> +
> +hfsplus "${dmg_path}" mkdir-p "${dst_path}"
> +
> +hfsplus "${dmg_path}" addall "${sdk_path}" "${dst_path}"
> +
> +hfsplus "${dmg_path}" add "${finalize_dmg}" "${dmg_finalize}"
> +hfsplus "${dmg_path}" chmod 755 "${dmg_finalize}"
> +
> +hfsplus "${dmg_path}" rm "${dst_path}/relocate_sdk.py"
> +
> +hfsplus "${dmg_path}" rm "${dst_path}/post-relocate-setup.sh"
> +
> +
> diff --git a/conf/files/mk-macos-pkg.sh b/conf/files/mk-macos-pkg.sh
> new file mode 100755
> index 0000000..283a0e3
> --- /dev/null
> +++ b/conf/files/mk-macos-pkg.sh
> @@ -0,0 +1,161 @@
> +#!/bin/bash
> +##################################################
> +## file: meta-darwin/conf/files/mk-macos-pkg.sh
> +##
> +## Original Author: Eric L. Hernes <eric@qinc.tv>
> +##
> +## /bin/sh script to do create macos .pkg installer for openembedded sdk
> +##
> +
> +# $1 =3D SDK Title
> +# $2 =3D SDK Name
> +# $3 =3D SDK Architecture
> +# $4 =3D SDK Version
> +# $5 =3D path to SDK path files
> +# $6 =3D SDK dmg output filename
> +# $7 =3D path to finalize script
> +# $8 =3D destination path relative to the user's selected volume
> +
> +pkg_title=3D${1:-"OpenEmbedded SDK"}
> +pkg_name=3D${2:-"oesdk-darwin21"}
> +pkg_arch=3D${3:-"aarch64"}
> +pkg_vers=3D${4:-"x.x.x.y"}
> +sdk_path=3D${5:-".../tmp/work/armv8a-oe-linux/meta-toolchain/1.0/sdk/ima=
ge"}
> +pkg_path=3D${6:-".../tmp/deploy/sdk/macos-test-sdk.pkg"}
> +finalize_pkg=3D${7:-"finalize-pkg"}
> +dst_path=3D${8-"/Library/Developer/org.openembedded.sdk/${pkg_name}/x"}
> +
> +echo "pkg_title: ${pkg_title}"
> +echo "pkg_name: ${pkg_name}"
> +echo "pkg_arch: ${pkg_arch}"
> +echo "pkg_vers: ${pkg_vers}"
> +echo "sdk_path: ${sdk_path}"
> +echo "pkg_path: ${pkg_path}"
> +echo "dst_path: ${dst_path}"
> +
> +count=3D$(find ${sdk_path} -type f | wc -l)
> +set $(du -sk ${sdk_path})
> +kbytes=3D$1
> +
> +echo "SDK will contain ${count} files and consume ${kbytes}K bytes"
> +
> +org_id=3Dorg.openembedded.sdk
> +
> +pkg_id=3D"${org_id}.${pkg_name}.pkg"
> +
> +flat=3Ddist/Package.pkg
> +
> +build=3Dbuild
> +mkbom=3Dmkbom
> +xar=3Dxar
> +
> +files=3D$(realpath $(dirname $0))
> +
> +rm -rf ${build}
> +rm -f "${pkg_path}"
> +
> +mkdir ${build}
> +cd ${build}
> +
> +mkdir -p ${flat}
> +mkdir scripts
> +
> +( cd ${sdk_path} && find . | cpio -o --format odc --owner 0:80 | gzip -c
> ) > ${flat}/Payload
> +
> +#
> +# Swift installs stuff to /Library/org.swift.swiftpm;
> +#
> +# So let's do something similar
> +# Install files to /Library/Developer/org.openembedded.sdk
> +#
> +cat > ${flat}/PackageInfo <<EOF
> +<pkg-info format-version=3D"2" identifier=3D"${pkg_id}"
> version=3D"${pkg_version}" relocatable=3D"false" overwrite-permissions=3D=
"false"
> followSymLinks=3D"false" install-location=3D"${dst_path}" auth=3D"root">
> +  <payload installKBytes=3D"${kbytes}" numberOfFiles=3D"${count}"/>
> +    <bundle-version/>
> +    <upgrade-bundle/>
> +    <update-bundle/>
> +    <atomic-update-bundle/>
> +    <strict-identifier/>
> +    <relocate/>
> +    <scripts>
> +      <preinstall file=3D"./pre-install"/>
> +      <postinstall file=3D"./post-install"/>
> +  </scripts>
> +</pkg-info>
> +EOF
> +
> +sed -e "s#@dst_path@#${dst_path}#g" \
> +    ${files}/pre-install.in >scripts/pre-install
> +
> +sed -e 's,$,&,' ${files}/post-install.in >scripts/post-install
> +cp ${finalize_pkg} scripts/finalize-pkg
> +
> +chmod +x scripts/finalize-pkg
> +chmod +x scripts/pre-install
> +chmod +x scripts/post-install
> +
> +( cd scripts && find . | cpio -o --format odc --owner 0:80 | gzip -c ) >
> ${flat}/Scripts
> +${mkbom} -u 0 -g 80 ${sdk_path} ${flat}/Bom
> +
> +#
> +# linux calls it aarch64; apple calls it arm64
> +#
> +
> +declare -A arch_map
> +arch_map["aarch64"]=3D"arm64"
> +arch_map["x86_64"]=3D"x86_64"
> +
> +p_id=3D$(tr -dc 'a-z0-9' < /dev/urandom | head -c 16)
> +pki_id=3D"org.openembedded.oesdk.installer.${p_id}"
> +
> +
> +cat >dist/Distribution <<EOF
> +<?xml version=3D"1.0" encoding=3D"utf-8"?>
> +<installer-gui-script minSpecVersion=3D"2">
> +    <title>${pkg_title}</title>
> +    <options customize=3D"allow"
> hostArchitectures=3D"${arch_map[${pkg_arch}]}"/>
> +    <domains enable_localSystem=3D"true" enable_anywhere=3D"true"
> enable_currentUserHome=3D"true"/>
> +    <installation-check script=3D"canInstall()"/>
> +    <script><![CDATA[
> +       function canInstall() {
> +               var version;
> +               var major;
> +
> +               // ProductVersion is usually "major.minor.patch"
> +               if (!system || !system.version ||
> !system.version.ProductVersion) {
> +                       return false;
> +               }
> +
> +               version =3D system.version.ProductVersion.split(".");
> +               major =3D parseInt(version[0], 10);
> +
> +               if (isNaN(major)) {
> +                       return false;
> +               }
> +
> +               // Darwin21 =3D=3D  macOS 12+
> +               if (major < 12) {
> +                       return false;
> +               }
> +
> +               return true;
> +       }
> +
> +]]></script>
> +    <pkg-ref id=3D"${p_id}" version=3D"1"
> onConclusion=3D"none">#Package.pkg</pkg-ref>
> +    <pkg-ref id=3D"${p_id}" packageIdentifier=3D"${pki_id}" installKByte=
s=3D"0"
> updateKBytes=3D"0">
> +        <must-close/>
> +        <bundle-version/>
> +    </pkg-ref>
> +    <choices-outline>
> +        <line choice=3D"${p_id}"/>
> +    </choices-outline>
> +    <choice id=3D"${p_id}" title=3D"Package" start_selected=3D"true">
> +        <pkg-ref id=3D"${p_id}"/>
> +    </choice>
> +    <product id=3D"${pkg_id}" version=3D"${pkg_vers}"/>
> +</installer-gui-script>
> +EOF
> +
> +( cd dist && ${xar} --compression none -cf "${pkg_path}" * )
> +
> diff --git a/conf/files/post-install.in b/conf/files/post-install.in
> new file mode 100644
> index 0000000..9321f79
> --- /dev/null
> +++ b/conf/files/post-install.in
> @@ -0,0 +1,9 @@
> +#!/bin/bash
> +#########################################
> +#  file: meta-darwin/conf/files/post-install.in
> +#
> +#  @file    post-install
> +#  @version V1.0
> +#
> +# post install script for meta-darwin SDK
> +#
> diff --git a/conf/files/pre-install.in b/conf/files/pre-install.in
> new file mode 100644
> index 0000000..0c488c4
> --- /dev/null
> +++ b/conf/files/pre-install.in
> @@ -0,0 +1,84 @@
> +#!/usr/bin/osascript -l JavaScript
> +/***************************************************
> + * file: meta-darwin/conf/files/pre-install.in
> + *
> + * @file    pre-install.jxa
> + * @version V1.0
> + *
> + * pre-install script for meta-darwin macOS SDK
> + *
> + * this script gets user options and sets up various things
> + * so that the files are installed properly in their final
> + * destination
> + *
> + */
> +
> +ObjC.import("stdlib");
> +
> +var seApp =3D Application("System Events");
> +var oProcess =3D seApp.processes.whose({frontmost: true})[0];
> +var appName =3D oProcess.displayedName();
> +
> +app =3D Application.currentApplication();
> +
> +app.includeStandardAdditions =3D true;
> +
> +retval =3D []
> +
> +function run(args) {
> +
> +  codesign_id=3D""
> +  if (true) {
> +    idstr =3D app.doShellScript("security -qq find-identity -v -p
> codesigning |cut -c47- |tr '\n' ';'")
> +    idList =3D idstr.split(';').filter(element =3D> element);
> +    switch (idList.length) {
> +      case 0: // can't sign
> +        let dialogText =3D "Could not find any code signing identities,
> binaries will not be signed"
> +        app.displayDialog(dialogText)
> +      break;
> +
> +      case 1: // no decisions
> +        codesign_id =3D idList[0]
> +      break;
> +
> +      default:
> +        codesign_id =3D app.chooseFromList(idList, {
> +          withTitle: "Signing ID",
> +          withPrompt: "Please select an ID to sign binaries",
> +          defaultItems: [idList[0]],
> +          okButtonName: "OK",
> +          cancelButtonName: "Cancel",
> +          multipleSelectionsAllowed: false,
> +          emptySelectionAllowed: false
> +        })
> +      if (codesign_id =3D=3D false) {
> +        let dialogText =3D "Cancelled code signing"
> +        app.displayDialog(dialogText)
> +        return false
> +      }
> +    }
> +  }
> +
> +  // finalize script
> +  // finalize {staging} {new_path} {code_sign}
> +  pwd =3D ObjC.unwrap($.NSFileManager.defaultManager.currentDirectoryPat=
h)
> +  finalize =3D pwd + "/finalize-pkg";
> +  staging =3D $.getenv("INSTALLER_PAYLOAD_DIR") + "@dst_path@"
> +  new_path =3D args[1]
> +  command =3D `${finalize} "${staging}" "${new_path}" ${codesign_id}`
> +
> +  var dialogText =3D "Will run a script to relocate and codesign\n\n"
> +  dialogText +=3D "\n\n"
> +  dialogText +=3D "This may take a few minutes depending on the size of =
the
> SDK"
> +
> +  app.displayDialog(dialogText)
> +
> +  finalize_data =3D app.doShellScript(command + " >/dev/null 2>&1")
> +
> +  app.displayDialog(finalize_data)
> +
> +  retval.push("ok")
> +  return retval.join("\n")
> +}
> +
> +/* end of pre-install.in */
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 2f14754..6730f3b 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -9,3 +9,6 @@ BBFILES +=3D "${LAYERDIR}/recipes*/*/*.bb
> ${LAYERDIR}/recipes*/*/*.bbappend"
>  BBFILE_COLLECTIONS +=3D "meta-darwin"
>  BBFILE_PATTERN_meta-darwin :=3D "^${LAYERDIR}/"
>  BBFILE_PRIORITY_meta-darwin =3D "8"
> +
> +DARWINBASE =3D '${@os.path.normpath("${LAYERDIR}")}'
> +BB_BASEHASH_IGNORE_VARS:append =3D " DARWINBASE"
> diff --git a/conf/machine-sdk/darwin-common.inc
> b/conf/machine-sdk/darwin-common.inc
> index cec76a5..2f1aec9 100644
> --- a/conf/machine-sdk/darwin-common.inc
> +++ b/conf/machine-sdk/darwin-common.inc
> @@ -14,8 +14,13 @@ SDKUSE_NLS =3D "no"
>  SDKIMAGE_LINGUAS =3D ""
>  SDK_DEPENDS:remove =3D "nativesdk-glibc-locale nativesdk-qemuwrapper-cro=
ss"
>
> +SDK_DEPENDS:append =3D "${@bb.utils.contains('DARWIN_INSTALLER_PKG', '1'=
, '
> bomutils-native xar-native', '', d)}"
> +SDK_DEPENDS:append =3D "${@bb.utils.contains('DARWIN_INSTALLER_DMG', '1'=
, '
> hfsprogs-native libdmg-hfsplus-native', '', d)}"
> +
>  SDKPKGSUFFIX =3D "nativesdk-darwin"
>
> +DARWIN_INSTALL_LOC =3D "${@d.getVar('DARWIN_INSTALLER_PATH') or
> '/Library/Developer/org.openembedded.sdk'}"
> +
>  OSX_TOOLCHAIN_OPTIONS =3D " \
>      -mmacosx-version-min=3D12.3 \
>      -L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/usr/lib \
> @@ -24,9 +29,12 @@ OSX_TOOLCHAIN_OPTIONS =3D " \
>  "
>
>  TOOLCHAIN_OPTIONS:append:darwin21 =3D " \
> -    ${OSX_TOOLCHAIN_OPTIONS}"
> +    ${OSX_TOOLCHAIN_OPTIONS} \
> +"
> +
>  TOOLCHAIN_OPTIONS:append:class-cross-canadian =3D " \
> -    ${OSX_TOOLCHAIN_OPTIONS}"
> +    ${OSX_TOOLCHAIN_OPTIONS} \
> +"
>
>  # Remove -rpath-link
>  BUILDSDK_LDFLAGS =3D " \
> @@ -35,3 +43,45 @@ BUILDSDK_LDFLAGS =3D " \
>  "
>
>  MACHINEOVERRIDES .=3D ":darwinsdk"
> +
> +TOOLCHAIN_SHAR_EXT_TMPL ?=3D
> "${DARWINBASE}/conf/files/darwin-toolchain-shar-extract.sh"
> +
> +SDK_POSTPROCESS_COMMAND:append =3D
> "${@bb.utils.contains('DARWIN_INSTALLER_PKG', '1', ' create_macos_pkg', '=
',
> d)}"
> +SDK_POSTPROCESS_COMMAND:append =3D
> "${@bb.utils.contains('DARWIN_INSTALLER_DMG', '1', ' create_macos_dmg', '=
',
> d)}"
> +
> +#
> +# remove the .xz and .sh creation if we want to save a bit of time
> +SDK_POSTPROCESS_COMMAND:remove =3D
> "${@bb.utils.contains('DARWIN_INSTALLER_SH', '0', ' archive_sdk', '', d)}=
"
> +SDK_POSTPROCESS_COMMAND:remove =3D
> "${@bb.utils.contains('DARWIN_INSTALLER_SH', '0', ' create_shar', '', d)}=
"
> +
> +fakeroot create_macos_pkg() {
> +    sdk_pkg=3D"${SDKDEPLOYDIR}/${TOOLCHAIN_OUTPUTNAME}.pkg"
> +    native_sysroot=3D$(basename ${SDKPATHNATIVE})
> +
> +    sed -e "s#@target_prefix@#${TARGET_PREFIX}#g" \
> +        -e "s#@native_sysroot@#${native_sysroot}#g" \
> +         ${DARWINBASE}/conf/files/finalize-sdk.sh \
> +         > "${B}/finalize-pkg"
> +
> +    (cd ${B}; \
> +        ${DARWINBASE}/conf/files/mk-macos-pkg.sh "${SDK_TITLE}"
> "${SDK_NAME}" "${SDK_ARCH}" "${DISTRO_VERSION}.${SDK_VERSION}"
> "${SDK_OUTPUT}/${SDKPATH}" "${sdk_pkg}" "${B}/finalize-pkg"
> ${DARWIN_INSTALL_LOC}/${SDK_NAME} \
> +    )
> +
> +   ls -lh "${sdk_pkg}"
> +}
> +
> +fakeroot create_macos_dmg() {
> +    sdk_dmg=3D"${SDKDEPLOYDIR}/${TOOLCHAIN_OUTPUTNAME}.dmg"
> +    native_sysroot=3D$(basename ${SDKPATHNATIVE})
> +    sed -e "s#@target_prefix@#${TARGET_PREFIX}#g" \
> +        -e "s#@native_sysroot@#${native_sysroot}#g" \
> +         ${DARWINBASE}/conf/files/finalize-sdk.sh \
> +         > "${B}/finalize-dmg"
> +
> +    echo 'rm ${0}' >> "${B}/finalize-dmg"
> +
> +    ( cd ${B}; \
> +        ${DARWINBASE}/conf/files/mk-macos-dmg.sh "${SDK_TITLE}"
> "${SDK_NAME}" "${SDK_ARCH}" "${DISTRO_VERSION}.${SDK_VERSION}"
> "${SDK_OUTPUT}/${SDKPATH}" "${sdk_dmg}" "${B}/finalize-dmg"
> "${DARWIN_INSTALL_LOC}/${SDK_NAME}" \
> +    )
> +   ls -lh "${sdk_dmg}"
> +}
> --
> 2.50.1 (Apple Git-155)
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3170):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3170&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DocD=
t_LbHjapIywNYWeZjpn13nP4qi8M-ViMysQ42MEAh4pLHUAUi7nHPV2HAzLgY&s=3DRI7TbVVDb=
1JI4t7V-VwIOzosoaA0QogUxTcPBqFWles&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_117599656_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DocDt_LbHjapIy=
wNYWeZjpn13nP4qi8M-ViMysQ42MEAh4pLHUAUi7nHPV2HAzLgY&s=3DHmiWukrayw1P0qfPuQg=
y18xIGA9t7RYJ8nplxk4fUc8&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3DocDt_LbHjapIywNYWeZjpn13nP4qi8M-ViMysQ42MEAh4pLHUAU=
i7nHPV2HAzLgY&s=3D_VBIT28ALkqgS9F91h-sUFpZJjfOKwlRhJMIfmw9GqM&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000312c8c064bcd3298
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br>sorry for the delay.<br>- I have tested some l=
ocal build of some custom image, and it seems the pkg and dmg packages are =
quite big, compared to the traditional sh files. I&#39;m not familiar with =
those packaging formats so I&#39;m not sure whether it is normal? For a 554=
MB sh file, I&#39;ve got a 908MB pkg file and a 3.5GB dmg file. I have also=
 tested local installation on macOS and it principle it works, even though =
of course there are warnings related to the lack of signature.<br><br>Here =
is some feedback on the patch (partly AI generated, but reviewed manually b=
y me):<br><br>1. **Variable typo in darwin-toolchain-shar-extract.sh (line =
198-199)**<br>=C2=A0 =C2=A0- Declares `fs_dev_type` but uses `fsdevtype` on=
 next line<br>=C2=A0 =C2=A0- NFS filesystem check will silently fail, never=
 triggering abort condition<br>=C2=A0 =C2=A0- Fix: Change `fsdevtype` to `f=
s_dev_type` on line 199<br><br>2. **Undefined variable in mk-macos-pkg.sh (=
line 72)**<br>=C2=A0 =C2=A0- Script defines `pkg_vers` (line 22) but refere=
nces `pkg_version` (line 72)<br>=C2=A0 =C2=A0- Generated PackageInfo will h=
ave empty version string<br>=C2=A0 =C2=A0- Fix: Change `${pkg_version}` to =
`${pkg_vers}` in PackageInfo XML<br><br>3. **Missing quotes in darwin-commo=
n.inc (line 66)**<br>=C2=A0 =C2=A0- Unquoted `${DARWIN_INSTALL_LOC}/${SDK_N=
AME}` passed to mk-macos-pkg.sh<br>=C2=A0 =C2=A0- Will break if DARWIN_INST=
ALLER_PATH contains spaces<br>=C2=A0 =C2=A0- Fix: Quote argument as `&quot;=
${DARWIN_INSTALL_LOC}/${SDK_NAME}&quot;`<br>=C2=A0 =C2=A0- Same issue on li=
ne 75 for mk-macos-dmg.sh call<br><br>4. **Incorrect sed command in mk-maco=
s-pkg.sh (line 89)**<br>=C2=A0 =C2=A0- `sed -e &#39;s,$,&amp;,&#39; ${files=
}/<a href=3D"http://post-install.in">post-install.in</a> &gt;scripts/post-i=
nstall`<br>=C2=A0 =C2=A0- Pattern &#39;s,$,&amp;,&#39; does nothing (replac=
es end-of-line with itself)<br>=C2=A0 =C2=A0- Since <a href=3D"http://post-=
install.in">post-install.in</a> is intentionally empty (per cover letter Q5=
), just use `cp` instead<br>=C2=A0 =C2=A0- Or remove the sed and the empty =
<a href=3D"http://post-install.in">post-install.in</a> file entirely if not=
 needed<br><br>5. **Typo in README (line 33)**<br>=C2=A0 =C2=A0- &quot;foll=
wing&quot; should be &quot;following&quot;<br><br><br>=C2=A0<br><br></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Feb 2, 2026 at 5:52=E2=80=AFPM Eric L. Hernes via <=
a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;dev=
=3D<a href=3D"mailto:qinc.tv@lists.yoctoproject.org">qinc.tv@lists.yoctopro=
ject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">This adds support for generating both .dmg and .pkg installers.<br>
<br>
The .dmg will require running the `finalize-dmg` to relocate and sign<br>
the executables.<br>
<br>
The .pkg automates the process and integrates the relocation and<br>
signage into the installer.<br>
<br>
Signed-off-by: Eric L. Hernes &lt;<a href=3D"mailto:dev@qinc.tv" target=3D"=
_blank">dev@qinc.tv</a>&gt;<br>
---<br>
=C2=A0README=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 19 ++<br>
=C2=A0conf/files/darwin-toolchain-shar-extract.sh | 316 +++++++++++++++++++=
+<br>
=C2=A0conf/files/finalize-sdk.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 48 +++<br>
=C2=A0conf/files/mk-macos-dmg.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 49 +++<br>
=C2=A0conf/files/mk-macos-pkg.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 161 ++++++++++<br>
=C2=A0conf/files/<a href=3D"http://post-install.in" rel=3D"noreferrer" targ=
et=3D"_blank">post-install.in</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
=C2=A0conf/files/<a href=3D"http://pre-install.in" rel=3D"noreferrer" targe=
t=3D"_blank">pre-install.in</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 84 ++++++<br>
=C2=A0conf/layer.conf=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0conf/machine-sdk/darwin-common.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 54 +++-<br>
=C2=A09 files changed, 741 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 conf/files/darwin-toolchain-shar-extract.sh<br>
=C2=A0create mode 100644 conf/files/finalize-sdk.sh<br>
=C2=A0create mode 100755 conf/files/mk-macos-dmg.sh<br>
=C2=A0create mode 100755 conf/files/mk-macos-pkg.sh<br>
=C2=A0create mode 100644 conf/files/<a href=3D"http://post-install.in" rel=
=3D"noreferrer" target=3D"_blank">post-install.in</a><br>
=C2=A0create mode 100644 conf/files/<a href=3D"http://pre-install.in" rel=
=3D"noreferrer" target=3D"_blank">pre-install.in</a><br>
<br>
diff --git a/README b/README<br>
index 89845b5..97d176d 100644<br>
--- a/README<br>
+++ b/README<br>
@@ -30,3 +30,22 @@ <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3D=
https-3A__lists.yoctoproject.org_g_yocto-2Dpatches&amp;d=3DDwIFAg&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3DocDt_LbHjapIywNYWeZjpn13nP4qi8M-ViMysQ42MEAh4pL=
HUAUi7nHPV2HAzLgY&amp;s=3Dwo9y9WkvtD-73r84EwDgaSoRq1s2Q7o6YOy5P5FZRV8&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com=
/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches&amp;d=3DDwIF=
Ag&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIG=
RfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DocDt_LbHjapIywNYWeZjpn13nP4qi8M-ViM=
ysQ42MEAh4pLHUAUi7nHPV2HAzLgY&amp;s=3Dwo9y9WkvtD-73r84EwDgaSoRq1s2Q7o6YOy5P=
5FZRV8&amp;e=3D</a>=C2=A0 before being able to post.<br>
=C2=A0When sending single patches, please use something like:<br>
=C2=A0&#39;git send-email -M -1 --to <a href=3D"mailto:yocto-patches@lists.=
yoctoproject.org" target=3D"_blank">yocto-patches@lists.yoctoproject.org</a=
> --subject-prefix=3D&quot;meta-darwin][PATCH&quot;&#39;<br>
<br>
+The follwing variables can be set in the local.conf or elsewhere:<br>
+<br>
+To enable building the .pkg installer, set:<br>
+DARWIN_INSTALLER_PKG =3D &quot;1&quot;<br>
+<br>
+To enable building a .dmg installer, set:<br>
+DARWIN_INSTALLER_DMG =3D &quot;1&quot;<br>
+<br>
+To save some time during builds, you can disable the shell script installe=
r with:<br>
+DARWIN_INSTALLER_SH =3D &quot;0&quot;<br>
+<br>
+To specify the path in the .dmg and path that the .pkg will install to, se=
t<br>
+DARWIN_INSTALLER_PATH =3D &quot;/Library/Developer/org.openembedded.sdk&qu=
ot;<br>
+<br>
+The .dmg will require running the `finalize-dmg` to relocate and sign<br>
+the executables.<br>
+<br>
+The .pkg automates the process and integrates the relocation and<br>
+signage into the installer.<br>
diff --git a/conf/files/darwin-toolchain-shar-extract.sh b/conf/files/darwi=
n-toolchain-shar-extract.sh<br>
new file mode 100644<br>
index 0000000..4417010<br>
--- /dev/null<br>
+++ b/conf/files/darwin-toolchain-shar-extract.sh<br>
@@ -0,0 +1,316 @@<br>
+#!/bin/sh<br>
+<br>
+export LC_ALL=3Den_US.UTF-8<br>
+<br>
+# The pipefail option is now part of POSIX (POSIX.1-2024) and available in=
 more<br>
+# and more shells. Enable it if available to make the SDK installer more r=
obust.<br>
+(set -o pipefail 2&gt; /dev/null) &amp;&amp; set -o pipefail<br>
+<br>
+#Make sure at least one python is installed<br>
+INIT_PYTHON=3D$(which python3 2&gt;/dev/null )<br>
+[ -z &quot;$INIT_PYTHON&quot; ] &amp;&amp; INIT_PYTHON=3D$(which python2 2=
&gt;/dev/null)<br>
+[ -z &quot;$INIT_PYTHON&quot; ] &amp;&amp; echo &quot;Error: The SDK needs=
 a python installed&quot; &amp;&amp; exit 1<br>
+<br>
+# Remove invalid PATH elements first (maybe from a previously setup toolch=
ain now deleted<br>
+PATH=3D`$INIT_PYTHON -c &#39;import os; print(&quot;:&quot;.join(e for e i=
n os.environ[&quot;PATH&quot;].split(&quot;:&quot;) if os.path.exists(e)))&=
#39;`<br>
+<br>
+tweakpath () {<br>
+=C2=A0 =C2=A0 case &quot;:${PATH}:&quot; in<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *:&quot;$1&quot;:*)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PATH=3D$PATH:$1<br>
+=C2=A0 =C2=A0 esac<br>
+}<br>
+<br>
+# Some systems don&#39;t have /usr/sbin or /sbin in the cleaned environmen=
t PATH but we make need it <br>
+# for the system&#39;s host tooling checks<br>
+tweakpath /usr/sbin<br>
+tweakpath /sbin<br>
+<br>
+# linux calls it aarch64; Apple calls it arm64<br>
+if [ @SDK_ARCH@ =3D=3D aarch64 ]; then<br>
+=C2=A0 =C2=A0 OSX_SDK_ARCH=3Darm64<br>
+else<br>
+=C2=A0 =C2=A0 OSX_SDK_ARCH=3D@SDK_ARCH@<br>
+fi<br>
+<br>
+INST_ARCH=3D$(uname -m | gsed -e &quot;s/i[3-6]86/ix86/&quot; -e &quot;s/x=
86[-_]64/x86_64/&quot;)<br>
+SDK_ARCH=3D$(echo ${OSX_SDK_ARCH} | gsed -e &quot;s/i[3-6]86/ix86/&quot; -=
e &quot;s/x86[-_]64/x86_64/&quot;)<br>
+<br>
+INST_GCC_VER=3D$(gcc --version 2&gt;/dev/null | gsed -ne &#39;s/.* \([0-9]=
\+\.[0-9]\+\)\.[0-9]\+.*/\1/p&#39;)<br>
+SDK_GCC_VER=3D&#39;@SDK_GCC_VER@&#39;<br>
+<br>
+verlte () {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[=C2=A0 &quot;$1&quot; =3D &quot;`printf &quot;=
$1\n$2&quot; | sort -V | head -n1`&quot; ]<br>
+}<br>
+<br>
+verlt() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$1&quot; =3D &quot;$2&quot; ] &amp;&amp=
; return 1 || verlte $1 $2<br>
+}<br>
+<br>
+verlt `uname -r` @OLDEST_KERNEL@<br>
+if [ $? =3D 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Error: The SDK needs a kernel &gt; @=
OLDEST_KERNEL@&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+fi<br>
+<br>
+if [ &quot;$INST_ARCH&quot; !=3D &quot;$SDK_ARCH&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# Allow for installation of ix86 SDK on x86_64 =
host<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ &quot;$INST_ARCH&quot; !=3D x86_64 -o &quo=
t;$SDK_ARCH&quot; !=3D ix86 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Error: I=
ncompatible SDK installer! Your host is $INST_ARCH and this SDK was built f=
or $SDK_ARCH hosts.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+fi<br>
+<br>
+if ! xz -V &gt; /dev/null 2&gt;&amp;1; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Error: xz is required for installati=
on of this SDK, please install it first&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+fi<br>
+<br>
+SDK_BUILD_PATH=3D&quot;@SDKPATH@&quot;<br>
+DEFAULT_INSTALL_DIR=3D&quot;@SDKPATHINSTALL@&quot;<br>
+SUDO_EXEC=3D&quot;&quot;<br>
+EXTRA_TAR_OPTIONS=3D&quot;&quot;<br>
+target_sdk_dir=3D&quot;&quot;<br>
+answer=3D&quot;&quot;<br>
+relocate=3D1<br>
+savescripts=3D0<br>
+verbose=3D0<br>
+publish=3D0<br>
+listcontents=3D0<br>
+while getopts &quot;:yd:npDRSl&quot; OPT; do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case $OPT in<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0y)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0answer=3D&quot;Y&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_sdk_dir=3D$O=
PTARG<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0n)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prepare_buildsystem=
=3D&quot;no&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0p)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prepare_buildsystem=
=3D&quot;no&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0publish=3D1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0D)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verbose=3D1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0R)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0relocate=3D0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0savescripts=3D1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0S)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0savescripts=3D1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0l)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0listcontents=3D1<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Usage: $=
(basename &quot;$0&quot;) [-y] [-d &lt;dir&gt;]&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=C2=A0 -=
y=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Automatic yes to all prompts&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=C2=A0 -=
d &lt;dir&gt;=C2=A0 =C2=A0Install the SDK to &lt;dir&gt;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=3D=3D=
=3D=3D=3D=3D=3D=3D Extensible SDK only options =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=C2=A0 -=
n=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Do not prepare the build system&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=C2=A0 -=
p=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Publish mode (implies -n)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=3D=3D=
=3D=3D=3D=3D=3D=3D Advanced DEBUGGING ONLY OPTIONS =3D=3D=3D=3D=3D=3D=3D=3D=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=C2=A0 -=
S=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Save relocation scripts&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=C2=A0 -=
R=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Do not relocate executables&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=C2=A0 -=
D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use set -x to see what is going on&quot;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=C2=A0 -=
l=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list files that will be extracted&quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0esac<br>
+done<br>
+<br>
+payload_offset=3D$(($(grep -na -m1 &quot;^MARKER:$&quot; &quot;$0&quot;|cu=
t -d&#39;:&#39; -f1) + 1))<br>
+if [ &quot;$listcontents&quot; =3D &quot;1&quot; ] ; then<br>
+=C2=A0 =C2=A0 if [ @SDK_ARCHIVE_TYPE@ =3D &quot;zip&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tail -n +$payload_offset &quot;$0&quot; &gt; s=
dk.zip<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if unzip -l sdk.zip;then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm sdk.zip<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm sdk.zip &amp;&amp; exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tail -n +$payload_offset &quot;$0&quot;| gtar =
tvJ || exit 1<br>
+=C2=A0 =C2=A0 fi<br>
+=C2=A0 =C2=A0 exit<br>
+fi<br>
+<br>
+titlestr=3D&quot;@SDK_TITLE@ installer version @SDK_VERSION@&quot;<br>
+printf &quot;%s\n&quot; &quot;$titlestr&quot;<br>
+printf &quot;%${#titlestr}s\n&quot; | tr &quot; &quot; &quot;=3D&quot;<br>
+<br>
+if [ $verbose =3D 1 ] ; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0set -x<br>
+fi<br>
+<br>
+@SDK_PRE_INSTALL_COMMAND@<br>
+<br>
+# SDK_EXTENSIBLE is exposed from the SDK_PRE_INSTALL_COMMAND above<br>
+if [ &quot;$SDK_EXTENSIBLE&quot; =3D &quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DEFAULT_INSTALL_DIR=3D&quot;@SDKEXTPATH@&quot;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ &quot;$INST_GCC_VER&quot; =3D &#39;4.8&#39=
; -a &quot;$SDK_GCC_VER&quot; =3D &#39;4.9&#39; ] || [ &quot;$INST_GCC_VER&=
quot; =3D &#39;4.8&#39; -a &quot;$SDK_GCC_VER&quot; =3D &#39;&#39; ] || \<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$INST_GCC_V=
ER&quot; =3D &#39;4.9&#39; -a &quot;$SDK_GCC_VER&quot; =3D &#39;&#39; ]; th=
en<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Error: I=
ncompatible SDK installer! Your host gcc version is $INST_GCC_VER and this =
SDK was built by gcc higher version.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+fi<br>
+<br>
+if [ &quot;$target_sdk_dir&quot; =3D &quot;&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ &quot;$answer&quot; =3D &quot;Y&quot; ]; t=
hen<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_sdk_dir=3D&q=
uot;$DEFAULT_INSTALL_DIR&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read -p &quot;Enter=
 target directory for SDK (default: $DEFAULT_INSTALL_DIR): &quot; target_sd=
k_dir<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$target_sdk=
_dir&quot; =3D &quot;&quot; ] &amp;&amp; target_sdk_dir=3D$DEFAULT_INSTALL_=
DIR<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+fi<br>
+<br>
+eval target_sdk_dir=3D$(echo &quot;$target_sdk_dir&quot;|gsed &#39;s/ /\\ =
/g&#39;)<br>
+if [ -d &quot;$target_sdk_dir&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0target_sdk_dir=3D$(cd &quot;$target_sdk_dir&quo=
t;; pwd)<br>
+else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0target_sdk_dir=3D$(greadlink -m &quot;$target_s=
dk_dir&quot;)<br>
+fi<br>
+<br>
+# limit the length for target_sdk_dir, ensure the relocation behaviour in =
relocate_sdk.py has right result.<br>
+# This is due to ELF interpreter being set to &#39;a&#39;*1024 in<br>
+# meta/recipes-core/meta/<a href=3D"http://uninative-tarball.bb" rel=3D"no=
referrer" target=3D"_blank">uninative-tarball.bb</a><br>
+if [ ${#target_sdk_dir} -gt 1024 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Error: The target directory path is =
too long!!!&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+fi<br>
+<br>
+if [ &quot;$SDK_EXTENSIBLE&quot; =3D &quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# We&#39;re going to be running the build syste=
m, additional restrictions apply<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if echo &quot;$target_sdk_dir&quot; | grep -q &=
#39;[+\ @$]&#39;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;The targ=
et directory path ($target_sdk_dir) contains illegal&quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;characters such as spaces, @, \$ or +. Abort!&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# The build system doesn&#39;t work well with /=
tmp on NFS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fs_dev_path=3D&quot;$target_sdk_dir&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while [ ! -d &quot;$fs_dev_path&quot; ] ; do<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fs_dev_path=3D`dirn=
ame $fs_dev_path`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 done<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fs_dev_type=3D`stat -f -c &#39;%t&#39; &quot;$f=
s_dev_path&quot;`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ &quot;$fsdevtype&quot; =3D &quot;6969&quot=
; ] ; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;The targ=
et directory path $target_sdk_dir is on NFS, this is not possible. Abort!&q=
uot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -n &quot;$(echo $target_sdk_dir|grep &#39;=
 &#39;)&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;The targ=
et directory path ($target_sdk_dir) contains spaces. Abort!&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+fi<br>
+<br>
+if [ -e &quot;$target_sdk_dir/environment-setup-@REAL_MULTIMACH_TARGET_SYS=
@&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;The directory \&quot;$target_sdk_dir=
\&quot; already contains a SDK for this architecture.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0printf &quot;If you continue, existing files wi=
ll be overwritten! Proceed [y/N]? &quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default_answer=3D&quot;n&quot;<br>
+else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0printf &quot;You are about to install the SDK t=
o \&quot;$target_sdk_dir\&quot;. Proceed [Y/n]? &quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default_answer=3D&quot;y&quot;<br>
+fi<br>
+<br>
+if [ &quot;$answer&quot; =3D &quot;&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0read answer<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$answer&quot; =3D &quot;&quot; ] &amp;&=
amp; answer=3D&quot;$default_answer&quot;<br>
+else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0echo $answer<br>
+fi<br>
+<br>
+if [ &quot;$answer&quot; !=3D &quot;Y&quot; -a &quot;$answer&quot; !=3D &q=
uot;y&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Installation aborted!&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+fi<br>
+<br>
+# Try to create the directory (this will not succeed if user doesn&#39;t h=
ave rights)<br>
+mkdir -p $target_sdk_dir &gt;/dev/null 2&gt;&amp;1<br>
+<br>
+# if don&#39;t have the right to access dir, gain by sudo <br>
+if [ ! -x $target_sdk_dir -o ! -w $target_sdk_dir -o ! -r $target_sdk_dir =
]; then <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ &quot;$SDK_EXTENSIBLE&quot; =3D &quot;1&qu=
ot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Unable t=
o access \&quot;$target_sdk_dir\&quot;, will not attempt to use&quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;sudo as as extensible SDK cannot be used as root.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SUDO_EXEC=3D$(which &quot;sudo&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -z $SUDO_EXEC ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;No comma=
nd &#39;sudo&#39; found, please install sudo first. Abort!&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# test sudo could gain root right<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$SUDO_EXEC pwd &gt;/dev/null 2&gt;&amp;1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[ $? -ne 0 ] &amp;&amp; echo &quot;Sorry, you a=
re not allowed to execute as root.&quot; &amp;&amp; exit 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# now that we have sudo rights, create the dire=
ctory<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$SUDO_EXEC mkdir -p $target_sdk_dir &gt;/dev/nu=
ll 2&gt;&amp;1<br>
+fi<br>
+<br>
+printf &quot;Extracting SDK...&quot;<br>
+if [ @SDK_ARCHIVE_TYPE@ =3D &quot;zip&quot; ]; then<br>
+=C2=A0 =C2=A0 tail -n +$payload_offset &quot;$0&quot; &gt; sdk.zip<br>
+=C2=A0 =C2=A0 if $SUDO_EXEC unzip $EXTRA_TAR_OPTIONS sdk.zip -d $target_sd=
k_dir;then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm sdk.zip<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm sdk.zip &amp;&amp; exit 1<br>
+=C2=A0 =C2=A0 fi<br>
+else<br>
+=C2=A0 =C2=A0 tail -n +$payload_offset &quot;$0&quot;| $SUDO_EXEC gtar mxJ=
 -C $target_sdk_dir --checkpoint=3D.2500 $EXTRA_TAR_OPTIONS || exit 1<br>
+fi<br>
+echo &quot;done&quot;<br>
+<br>
+printf &quot;Setting it up...&quot;<br>
+# fix environment paths<br>
+real_env_setup_script=3D&quot;&quot;<br>
+for env_setup_script in `ls $target_sdk_dir/environment-setup-*`; do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if grep -q &#39;OECORE_NATIVE_SYSROOT=3D&#39; $=
env_setup_script; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Handle custom env=
 setup scripts that are only named<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# environment-setup=
-* so that they have relocation<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# applied - what we=
 want beyond here is the main one<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# rather than the o=
ne that simply sorts last<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0real_env_setup_scri=
pt=3D&quot;$env_setup_script&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$SUDO_EXEC gsed -e &quot;s:@SDKPATH@:$target_sd=
k_dir:g&quot; -i $env_setup_script<br>
+done<br>
+if [ -n &quot;$real_env_setup_script&quot; ] ; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0env_setup_script=3D&quot;$real_env_setup_script=
&quot;<br>
+fi<br>
+<br>
+@SDK_POST_INSTALL_COMMAND@<br>
+<br>
+# delete the relocating script, so that user is forced to re-run the insta=
ller<br>
+# if he/she wants another location for the sdk<br>
+if [ $savescripts =3D 0 ] ; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$SUDO_EXEC rm -f ${env_setup_script%/*}/relocat=
e_sdk.py ${env_setup_script%/*}/relocate_sdk.sh<br>
+fi<br>
+<br>
+# Execute post-relocation script<br>
+post_relocate=3D&quot;$target_sdk_dir/post-relocate-setup.sh&quot;<br>
+if [ -e &quot;$post_relocate&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$SUDO_EXEC gsed -e &quot;s:@SDKPATH@:$target_sd=
k_dir:g&quot; -i $post_relocate<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$SUDO_EXEC /bin/sh $post_relocate &quot;$target=
_sdk_dir&quot; &quot;@SDKPATH@&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Executin=
g $post_relocate failed&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$SUDO_EXEC rm -f $post_relocate<br>
+fi<br>
+<br>
+echo &quot;SDK has been successfully set up and is ready to be used.&quot;=
<br>
+echo &quot;Each time you wish to use the SDK in a new shell session, you n=
eed to source the environment setup script e.g.&quot;<br>
+for env_setup_script in `ls $target_sdk_dir/environment-setup-*`; do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; \$ . $env_setup_script&quot;<br>
+done<br>
+<br>
+exit 0<br>
+<br>
+MARKER:<br>
diff --git a/conf/files/finalize-sdk.sh b/conf/files/finalize-sdk.sh<br>
new file mode 100644<br>
index 0000000..bd4f313<br>
--- /dev/null<br>
+++ b/conf/files/finalize-sdk.sh<br>
@@ -0,0 +1,48 @@<br>
+#!/bin/sh<br>
+##################################################<br>
+## file: finalize-sdk.sh<br>
+##<br>
+##<br>
+## /bin/sh script to finalize oesdk files<br>
+##<br>
+## 1. change pathing from hardcoded path to install path<br>
+## 2. codesign binaries and dylibs<br>
+##<br>
+## This can be run on the final installed files; or during install in a st=
aging area if we know<br>
+## what the final destination path will be.<br>
+##<br>
+<br>
+x_path=3D$(realpath $(dirname &quot;${0}&quot;))<br>
+first_csid=3D$(security -qq find-identity -v -p codesigning |cut -c47- |he=
ad -1 | tr -d &#39;&quot;&#39;)<br>
+<br>
+staging=3D${1:-&quot;${x_path}&quot;}<br>
+new_path=3D${2:-&quot;${x_path}&quot;}<br>
+codesign_id=3D${3:-&quot;${first_csid}&quot;}<br>
+<br>
+native_sysroot=3D&quot;@native_sysroot@&quot;<br>
+<br>
+do_relocate=3Dyes<br>
+do_codesign=3Dyes<br>
+<br>
+if [ &quot;${do_relocate}&quot; =3D yes ]; then<br>
+=C2=A0 =C2=A0 old_path=3D&quot;/usr/local/oe-sdk-hardcoded-buildpath&quot;=
<br>
+<br>
+=C2=A0 =C2=A0 find &quot;${staging}&quot; -type f -exec file {} +| grep -i=
 &quot;:.*\(ASCII\|script\|source\).*text&quot; |cut -d: -f1=C2=A0 |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while read fn; do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sed -i &quot;&quot; &quot;s,${ol=
d_path},${new_path},g&quot; &quot;${fn}&quot; || echo &quot;${fn}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 done<br>
+fi<br>
+<br>
+if [ &quot;${do_codesign}&quot; =3D yes ]; then<br>
+=C2=A0 =C2=A0 if [ -z &quot;${codesign_id}&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;requested codesigning, but did not =
find a codesigning identity&quot;<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 find &quot;${staging}/sysroots/${native_sysroo=
t}&quot; -type f -exec file {} + |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grep Mach-O | <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cut -d: -f1 |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sed -e &quot;s,^,&#39;,&quot; -e=
 &quot;s,$,&#39;,&quot; |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xargs codesign --continue --forc=
e --timestamp --sign &quot;${codesign_id}&quot;<br>
+=C2=A0 =C2=A0 fi<br>
+fi<br>
+<br>
+exit 0<br>
diff --git a/conf/files/mk-macos-dmg.sh b/conf/files/mk-macos-dmg.sh<br>
new file mode 100755<br>
index 0000000..ebf95d0<br>
--- /dev/null<br>
+++ b/conf/files/mk-macos-dmg.sh<br>
@@ -0,0 +1,49 @@<br>
+#!/bin/bash<br>
+##################################################<br>
+## file: meta-darwin/conf/files/mk-macos-dmg.sh<br>
+##<br>
+## Original Author: Eric L. Hernes &lt;<a href=3D"mailto:eric@qinc.tv" tar=
get=3D"_blank">eric@qinc.tv</a>&gt;<br>
+##<br>
+## /bin/sh script to do create macos .dmg image for openembedded sdk<br>
+##<br>
+<br>
+# $1 =3D SDK Title<br>
+# $2 =3D SDK Name<br>
+# $3 =3D SDK Architecture<br>
+# $4 =3D SDK Version<br>
+# $5 =3D path to SDK path files<br>
+# $6 =3D SDK dmg output filename<br>
+# $7 =3D path to finalize script<br>
+# $8 =3D destination path within the DMG<br>
+<br>
+pkg_title=3D${1:-&quot;OpenEmbedded SDK&quot;}<br>
+pkg_name=3D${2:-&quot;oesdk-darwin21&quot;}<br>
+pkg_arch=3D${3:-&quot;aarch64&quot;}<br>
+pkg_vers=3D${4:-&quot;x.x.x.y&quot;}<br>
+sdk_path=3D${5:-&quot;.../tmp/work/armv8a-oe-linux/meta-toolchain/1.0/sdk/=
image&quot;}<br>
+dmg_path=3D${6:-&quot;.../tmp/deploy/sdk/macos-test-sdk.dmg&quot;}<br>
+finalize_dmg=3D${7:-&quot;finalize-dmg&quot;}<br>
+dst_path=3D${8-&quot;/Library/Developer/org.openembedded.sdk/${pkg_name}&q=
uot;}<br>
+<br>
+dmg_finalize=3D&quot;${dst_path}/&quot;$(basename &quot;${finalize_dmg}&qu=
ot;)<br>
+<br>
+set $(du -sm ${sdk_path})<br>
+<br>
+# add 10% for overhead<br>
+size_mb=3D$((${1} * 11 / 10))<br>
+<br>
+dd if=3D/dev/zero of=3D&quot;${dmg_path}&quot; bs=3D1M count=3D${size_mb}<=
br>
+mkfs.hfsplus -s -v &quot;${pkg_name}&quot; &quot;${dmg_path}&quot;<br>
+<br>
+hfsplus &quot;${dmg_path}&quot; mkdir-p &quot;${dst_path}&quot;<br>
+<br>
+hfsplus &quot;${dmg_path}&quot; addall &quot;${sdk_path}&quot; &quot;${dst=
_path}&quot;<br>
+<br>
+hfsplus &quot;${dmg_path}&quot; add &quot;${finalize_dmg}&quot; &quot;${dm=
g_finalize}&quot;<br>
+hfsplus &quot;${dmg_path}&quot; chmod 755 &quot;${dmg_finalize}&quot;<br>
+<br>
+hfsplus &quot;${dmg_path}&quot; rm &quot;${dst_path}/relocate_sdk.py&quot;=
<br>
+<br>
+hfsplus &quot;${dmg_path}&quot; rm &quot;${dst_path}/post-relocate-setup.s=
h&quot;<br>
+<br>
+<br>
diff --git a/conf/files/mk-macos-pkg.sh b/conf/files/mk-macos-pkg.sh<br>
new file mode 100755<br>
index 0000000..283a0e3<br>
--- /dev/null<br>
+++ b/conf/files/mk-macos-pkg.sh<br>
@@ -0,0 +1,161 @@<br>
+#!/bin/bash<br>
+##################################################<br>
+## file: meta-darwin/conf/files/mk-macos-pkg.sh<br>
+##<br>
+## Original Author: Eric L. Hernes &lt;<a href=3D"mailto:eric@qinc.tv" tar=
get=3D"_blank">eric@qinc.tv</a>&gt;<br>
+##<br>
+## /bin/sh script to do create macos .pkg installer for openembedded sdk<b=
r>
+##<br>
+<br>
+# $1 =3D SDK Title<br>
+# $2 =3D SDK Name<br>
+# $3 =3D SDK Architecture<br>
+# $4 =3D SDK Version<br>
+# $5 =3D path to SDK path files<br>
+# $6 =3D SDK dmg output filename<br>
+# $7 =3D path to finalize script<br>
+# $8 =3D destination path relative to the user&#39;s selected volume<br>
+<br>
+pkg_title=3D${1:-&quot;OpenEmbedded SDK&quot;}<br>
+pkg_name=3D${2:-&quot;oesdk-darwin21&quot;}<br>
+pkg_arch=3D${3:-&quot;aarch64&quot;}<br>
+pkg_vers=3D${4:-&quot;x.x.x.y&quot;}<br>
+sdk_path=3D${5:-&quot;.../tmp/work/armv8a-oe-linux/meta-toolchain/1.0/sdk/=
image&quot;}<br>
+pkg_path=3D${6:-&quot;.../tmp/deploy/sdk/macos-test-sdk.pkg&quot;}<br>
+finalize_pkg=3D${7:-&quot;finalize-pkg&quot;}<br>
+dst_path=3D${8-&quot;/Library/Developer/org.openembedded.sdk/${pkg_name}/x=
&quot;}<br>
+<br>
+echo &quot;pkg_title: ${pkg_title}&quot;<br>
+echo &quot;pkg_name: ${pkg_name}&quot;<br>
+echo &quot;pkg_arch: ${pkg_arch}&quot;<br>
+echo &quot;pkg_vers: ${pkg_vers}&quot;<br>
+echo &quot;sdk_path: ${sdk_path}&quot;<br>
+echo &quot;pkg_path: ${pkg_path}&quot;<br>
+echo &quot;dst_path: ${dst_path}&quot;<br>
+<br>
+count=3D$(find ${sdk_path} -type f | wc -l)<br>
+set $(du -sk ${sdk_path})<br>
+kbytes=3D$1<br>
+<br>
+echo &quot;SDK will contain ${count} files and consume ${kbytes}K bytes&qu=
ot;<br>
+<br>
+org_id=3Dorg.openembedded.sdk<br>
+<br>
+pkg_id=3D&quot;${org_id}.${pkg_name}.pkg&quot;<br>
+<br>
+flat=3Ddist/Package.pkg<br>
+<br>
+build=3Dbuild<br>
+mkbom=3Dmkbom<br>
+xar=3Dxar<br>
+<br>
+files=3D$(realpath $(dirname $0))<br>
+<br>
+rm -rf ${build}<br>
+rm -f &quot;${pkg_path}&quot;<br>
+<br>
+mkdir ${build}<br>
+cd ${build}<br>
+<br>
+mkdir -p ${flat}<br>
+mkdir scripts<br>
+<br>
+( cd ${sdk_path} &amp;&amp; find . | cpio -o --format odc --owner 0:80 | g=
zip -c ) &gt; ${flat}/Payload<br>
+<br>
+#<br>
+# Swift installs stuff to /Library/org.swift.swiftpm;<br>
+#<br>
+# So let&#39;s do something similar<br>
+# Install files to /Library/Developer/org.openembedded.sdk<br>
+#<br>
+cat &gt; ${flat}/PackageInfo &lt;&lt;EOF<br>
+&lt;pkg-info format-version=3D&quot;2&quot; identifier=3D&quot;${pkg_id}&q=
uot; version=3D&quot;${pkg_version}&quot; relocatable=3D&quot;false&quot; o=
verwrite-permissions=3D&quot;false&quot; followSymLinks=3D&quot;false&quot;=
 install-location=3D&quot;${dst_path}&quot; auth=3D&quot;root&quot;&gt;<br>
+=C2=A0 &lt;payload installKBytes=3D&quot;${kbytes}&quot; numberOfFiles=3D&=
quot;${count}&quot;/&gt;<br>
+=C2=A0 =C2=A0 &lt;bundle-version/&gt;<br>
+=C2=A0 =C2=A0 &lt;upgrade-bundle/&gt;<br>
+=C2=A0 =C2=A0 &lt;update-bundle/&gt;<br>
+=C2=A0 =C2=A0 &lt;atomic-update-bundle/&gt;<br>
+=C2=A0 =C2=A0 &lt;strict-identifier/&gt;<br>
+=C2=A0 =C2=A0 &lt;relocate/&gt;<br>
+=C2=A0 =C2=A0 &lt;scripts&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;preinstall file=3D&quot;./pre-install&quot;/&gt;<=
br>
+=C2=A0 =C2=A0 =C2=A0 &lt;postinstall file=3D&quot;./post-install&quot;/&gt=
;<br>
+=C2=A0 &lt;/scripts&gt;<br>
+&lt;/pkg-info&gt;<br>
+EOF<br>
+<br>
+sed -e &quot;s#@dst_path@#${dst_path}#g&quot; \<br>
+=C2=A0 =C2=A0 ${files}/<a href=3D"http://pre-install.in" rel=3D"noreferrer=
" target=3D"_blank">pre-install.in</a> &gt;scripts/pre-install<br>
+<br>
+sed -e &#39;s,$,&amp;,&#39; ${files}/<a href=3D"http://post-install.in" re=
l=3D"noreferrer" target=3D"_blank">post-install.in</a> &gt;scripts/post-ins=
tall<br>
+cp ${finalize_pkg} scripts/finalize-pkg<br>
+<br>
+chmod +x scripts/finalize-pkg<br>
+chmod +x scripts/pre-install<br>
+chmod +x scripts/post-install<br>
+<br>
+( cd scripts &amp;&amp; find . | cpio -o --format odc --owner 0:80 | gzip =
-c ) &gt; ${flat}/Scripts<br>
+${mkbom} -u 0 -g 80 ${sdk_path} ${flat}/Bom<br>
+<br>
+#<br>
+# linux calls it aarch64; apple calls it arm64<br>
+#<br>
+<br>
+declare -A arch_map<br>
+arch_map[&quot;aarch64&quot;]=3D&quot;arm64&quot;<br>
+arch_map[&quot;x86_64&quot;]=3D&quot;x86_64&quot;<br>
+<br>
+p_id=3D$(tr -dc &#39;a-z0-9&#39; &lt; /dev/urandom | head -c 16)<br>
+pki_id=3D&quot;org.openembedded.oesdk.installer.${p_id}&quot;<br>
+<br>
+<br>
+cat &gt;dist/Distribution &lt;&lt;EOF<br>
+&lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;utf-8&quot;?&gt;<br>
+&lt;installer-gui-script minSpecVersion=3D&quot;2&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;title&gt;${pkg_title}&lt;/title&gt;<br>
+=C2=A0 =C2=A0 &lt;options customize=3D&quot;allow&quot; hostArchitectures=
=3D&quot;${arch_map[${pkg_arch}]}&quot;/&gt;<br>
+=C2=A0 =C2=A0 &lt;domains enable_localSystem=3D&quot;true&quot; enable_any=
where=3D&quot;true&quot; enable_currentUserHome=3D&quot;true&quot;/&gt;<br>
+=C2=A0 =C2=A0 &lt;installation-check script=3D&quot;canInstall()&quot;/&gt=
;<br>
+=C2=A0 =C2=A0 &lt;script&gt;&lt;![CDATA[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0function canInstall() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0var version;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0var major;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// ProductVersion i=
s usually &quot;major.minor.patch&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!system || !sys=
tem.version || !system.version.ProductVersion) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0version =3D system.=
version.ProductVersion.split(&quot;.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0major =3D parseInt(=
version[0], 10);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (isNaN(major)) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// Darwin21 =3D=3D=
=C2=A0 macOS 12+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (major &lt; 12) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+]]&gt;&lt;/script&gt;<br>
+=C2=A0 =C2=A0 &lt;pkg-ref id=3D&quot;${p_id}&quot; version=3D&quot;1&quot;=
 onConclusion=3D&quot;none&quot;&gt;#Package.pkg&lt;/pkg-ref&gt;<br>
+=C2=A0 =C2=A0 &lt;pkg-ref id=3D&quot;${p_id}&quot; packageIdentifier=3D&qu=
ot;${pki_id}&quot; installKBytes=3D&quot;0&quot; updateKBytes=3D&quot;0&quo=
t;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;must-close/&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;bundle-version/&gt;<br>
+=C2=A0 =C2=A0 &lt;/pkg-ref&gt;<br>
+=C2=A0 =C2=A0 &lt;choices-outline&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;line choice=3D&quot;${p_id}&quot;/&gt;<br>
+=C2=A0 =C2=A0 &lt;/choices-outline&gt;<br>
+=C2=A0 =C2=A0 &lt;choice id=3D&quot;${p_id}&quot; title=3D&quot;Package&qu=
ot; start_selected=3D&quot;true&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;pkg-ref id=3D&quot;${p_id}&quot;/&gt;<br>
+=C2=A0 =C2=A0 &lt;/choice&gt;<br>
+=C2=A0 =C2=A0 &lt;product id=3D&quot;${pkg_id}&quot; version=3D&quot;${pkg=
_vers}&quot;/&gt;<br>
+&lt;/installer-gui-script&gt;<br>
+EOF<br>
+<br>
+( cd dist &amp;&amp; ${xar} --compression none -cf &quot;${pkg_path}&quot;=
 * )<br>
+<br>
diff --git a/conf/files/<a href=3D"http://post-install.in" rel=3D"noreferre=
r" target=3D"_blank">post-install.in</a> b/conf/files/<a href=3D"http://pos=
t-install.in" rel=3D"noreferrer" target=3D"_blank">post-install.in</a><br>
new file mode 100644<br>
index 0000000..9321f79<br>
--- /dev/null<br>
+++ b/conf/files/<a href=3D"http://post-install.in" rel=3D"noreferrer" targ=
et=3D"_blank">post-install.in</a><br>
@@ -0,0 +1,9 @@<br>
+#!/bin/bash<br>
+#########################################<br>
+#=C2=A0 file: meta-darwin/conf/files/<a href=3D"http://post-install.in" re=
l=3D"noreferrer" target=3D"_blank">post-install.in</a><br>
+#<br>
+#=C2=A0 @file=C2=A0 =C2=A0 post-install<br>
+#=C2=A0 @version V1.0<br>
+#<br>
+# post install script for meta-darwin SDK<br>
+#<br>
diff --git a/conf/files/<a href=3D"http://pre-install.in" rel=3D"noreferrer=
" target=3D"_blank">pre-install.in</a> b/conf/files/<a href=3D"http://pre-i=
nstall.in" rel=3D"noreferrer" target=3D"_blank">pre-install.in</a><br>
new file mode 100644<br>
index 0000000..0c488c4<br>
--- /dev/null<br>
+++ b/conf/files/<a href=3D"http://pre-install.in" rel=3D"noreferrer" targe=
t=3D"_blank">pre-install.in</a><br>
@@ -0,0 +1,84 @@<br>
+#!/usr/bin/osascript -l JavaScript<br>
+/***************************************************<br>
+ * file: meta-darwin/conf/files/<a href=3D"http://pre-install.in" rel=3D"n=
oreferrer" target=3D"_blank">pre-install.in</a><br>
+ *<br>
+ * @file=C2=A0 =C2=A0 pre-install.jxa<br>
+ * @version V1.0<br>
+ *<br>
+ * pre-install script for meta-darwin macOS SDK<br>
+ *<br>
+ * this script gets user options and sets up various things<br>
+ * so that the files are installed properly in their final<br>
+ * destination<br>
+ *<br>
+ */<br>
+<br>
+ObjC.import(&quot;stdlib&quot;);<br>
+<br>
+var seApp =3D Application(&quot;System Events&quot;);<br>
+var oProcess =3D seApp.processes.whose({frontmost: true})[0];<br>
+var appName =3D oProcess.displayedName();<br>
+<br>
+app =3D Application.currentApplication();<br>
+<br>
+app.includeStandardAdditions =3D true;<br>
+<br>
+retval =3D []<br>
+<br>
+function run(args) {<br>
+<br>
+=C2=A0 codesign_id=3D&quot;&quot;<br>
+=C2=A0 if (true) {<br>
+=C2=A0 =C2=A0 idstr =3D app.doShellScript(&quot;security -qq find-identity=
 -v -p codesigning |cut -c47- |tr &#39;\n&#39; &#39;;&#39;&quot;)<br>
+=C2=A0 =C2=A0 idList =3D idstr.split(&#39;;&#39;).filter(element =3D&gt; e=
lement);<br>
+=C2=A0 =C2=A0 switch (idList.length) {<br>
+=C2=A0 =C2=A0 =C2=A0 case 0: // can&#39;t sign<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 let dialogText =3D &quot;Could not find any co=
de signing identities, binaries will not be signed&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app.displayDialog(dialogText)<br>
+=C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 case 1: // no decisions<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 codesign_id =3D idList[0]<br>
+=C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 codesign_id =3D app.chooseFromList(idList, {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 withTitle: &quot;Signing ID&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 withPrompt: &quot;Please select an ID t=
o sign binaries&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defaultItems: [idList[0]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 okButtonName: &quot;OK&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cancelButtonName: &quot;Cancel&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multipleSelectionsAllowed: false,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emptySelectionAllowed: false<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 })<br>
+=C2=A0 =C2=A0 =C2=A0 if (codesign_id =3D=3D false) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 let dialogText =3D &quot;Cancelled code signin=
g&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app.displayDialog(dialogText)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 }<br>
+<br>
+=C2=A0 // finalize script<br>
+=C2=A0 // finalize {staging} {new_path} {code_sign}<br>
+=C2=A0 pwd =3D ObjC.unwrap($.NSFileManager.defaultManager.currentDirectory=
Path)<br>
+=C2=A0 finalize =3D pwd + &quot;/finalize-pkg&quot;;<br>
+=C2=A0 staging =3D $.getenv(&quot;INSTALLER_PAYLOAD_DIR&quot;) + &quot;@ds=
t_path@&quot;<br>
+=C2=A0 new_path =3D args[1]<br>
+=C2=A0 command =3D `${finalize} &quot;${staging}&quot; &quot;${new_path}&q=
uot; ${codesign_id}`<br>
+<br>
+=C2=A0 var dialogText =3D &quot;Will run a script to relocate and codesign=
\n\n&quot;<br>
+=C2=A0 dialogText +=3D &quot;\n\n&quot;<br>
+=C2=A0 dialogText +=3D &quot;This may take a few minutes depending on the =
size of the SDK&quot;<br>
+<br>
+=C2=A0 app.displayDialog(dialogText)<br>
+<br>
+=C2=A0 finalize_data =3D app.doShellScript(command + &quot; &gt;/dev/null =
2&gt;&amp;1&quot;)<br>
+<br>
+=C2=A0 app.displayDialog(finalize_data)<br>
+<br>
+=C2=A0 retval.push(&quot;ok&quot;)<br>
+=C2=A0 return retval.join(&quot;\n&quot;)<br>
+}<br>
+<br>
+/* end of <a href=3D"http://pre-install.in" rel=3D"noreferrer" target=3D"_=
blank">pre-install.in</a> */<br>
diff --git a/conf/layer.conf b/conf/layer.conf<br>
index 2f14754..6730f3b 100644<br>
--- a/conf/layer.conf<br>
+++ b/conf/layer.conf<br>
@@ -9,3 +9,6 @@ BBFILES +=3D &quot;${LAYERDIR}/recipes*/*/*.bb ${LAYERDIR}/=
recipes*/*/*.bbappend&quot;<br>
=C2=A0BBFILE_COLLECTIONS +=3D &quot;meta-darwin&quot;<br>
=C2=A0BBFILE_PATTERN_meta-darwin :=3D &quot;^${LAYERDIR}/&quot;<br>
=C2=A0BBFILE_PRIORITY_meta-darwin =3D &quot;8&quot;<br>
+<br>
+DARWINBASE =3D &#39;${@os.path.normpath(&quot;${LAYERDIR}&quot;)}&#39;<br>
+BB_BASEHASH_IGNORE_VARS:append =3D &quot; DARWINBASE&quot;<br>
diff --git a/conf/machine-sdk/darwin-common.inc b/conf/machine-sdk/darwin-c=
ommon.inc<br>
index cec76a5..2f1aec9 100644<br>
--- a/conf/machine-sdk/darwin-common.inc<br>
+++ b/conf/machine-sdk/darwin-common.inc<br>
@@ -14,8 +14,13 @@ SDKUSE_NLS =3D &quot;no&quot;<br>
=C2=A0SDKIMAGE_LINGUAS =3D &quot;&quot;<br>
=C2=A0SDK_DEPENDS:remove =3D &quot;nativesdk-glibc-locale nativesdk-qemuwra=
pper-cross&quot;<br>
<br>
+SDK_DEPENDS:append =3D &quot;${@bb.utils.contains(&#39;DARWIN_INSTALLER_PK=
G&#39;, &#39;1&#39;, &#39; bomutils-native xar-native&#39;, &#39;&#39;, d)}=
&quot;<br>
+SDK_DEPENDS:append =3D &quot;${@bb.utils.contains(&#39;DARWIN_INSTALLER_DM=
G&#39;, &#39;1&#39;, &#39; hfsprogs-native libdmg-hfsplus-native&#39;, &#39=
;&#39;, d)}&quot;<br>
+<br>
=C2=A0SDKPKGSUFFIX =3D &quot;nativesdk-darwin&quot;<br>
<br>
+DARWIN_INSTALL_LOC =3D &quot;${@d.getVar(&#39;DARWIN_INSTALLER_PATH&#39;) =
or &#39;/Library/Developer/org.openembedded.sdk&#39;}&quot;<br>
+<br>
=C2=A0OSX_TOOLCHAIN_OPTIONS =3D &quot; \<br>
=C2=A0 =C2=A0 =C2=A0-mmacosx-version-min=3D12.3 \<br>
=C2=A0 =C2=A0 =C2=A0-L${STAGING_DIR_TARGET}${SDKPATHNATIVE}/usr/lib \<br>
@@ -24,9 +29,12 @@ OSX_TOOLCHAIN_OPTIONS =3D &quot; \<br>
=C2=A0&quot;<br>
<br>
=C2=A0TOOLCHAIN_OPTIONS:append:darwin21 =3D &quot; \<br>
-=C2=A0 =C2=A0 ${OSX_TOOLCHAIN_OPTIONS}&quot;<br>
+=C2=A0 =C2=A0 ${OSX_TOOLCHAIN_OPTIONS} \<br>
+&quot;<br>
+<br>
=C2=A0TOOLCHAIN_OPTIONS:append:class-cross-canadian =3D &quot; \<br>
-=C2=A0 =C2=A0 ${OSX_TOOLCHAIN_OPTIONS}&quot;<br>
+=C2=A0 =C2=A0 ${OSX_TOOLCHAIN_OPTIONS} \<br>
+&quot;<br>
<br>
=C2=A0# Remove -rpath-link<br>
=C2=A0BUILDSDK_LDFLAGS =3D &quot; \<br>
@@ -35,3 +43,45 @@ BUILDSDK_LDFLAGS =3D &quot; \<br>
=C2=A0&quot;<br>
<br>
=C2=A0MACHINEOVERRIDES .=3D &quot;:darwinsdk&quot;<br>
+<br>
+TOOLCHAIN_SHAR_EXT_TMPL ?=3D &quot;${DARWINBASE}/conf/files/darwin-toolcha=
in-shar-extract.sh&quot;<br>
+<br>
+SDK_POSTPROCESS_COMMAND:append =3D &quot;${@bb.utils.contains(&#39;DARWIN_=
INSTALLER_PKG&#39;, &#39;1&#39;, &#39; create_macos_pkg&#39;, &#39;&#39;, d=
)}&quot;<br>
+SDK_POSTPROCESS_COMMAND:append =3D &quot;${@bb.utils.contains(&#39;DARWIN_=
INSTALLER_DMG&#39;, &#39;1&#39;, &#39; create_macos_dmg&#39;, &#39;&#39;, d=
)}&quot;<br>
+<br>
+#<br>
+# remove the .xz and .sh creation if we want to save a bit of time<br>
+SDK_POSTPROCESS_COMMAND:remove =3D &quot;${@bb.utils.contains(&#39;DARWIN_=
INSTALLER_SH&#39;, &#39;0&#39;, &#39; archive_sdk&#39;, &#39;&#39;, d)}&quo=
t;<br>
+SDK_POSTPROCESS_COMMAND:remove =3D &quot;${@bb.utils.contains(&#39;DARWIN_=
INSTALLER_SH&#39;, &#39;0&#39;, &#39; create_shar&#39;, &#39;&#39;, d)}&quo=
t;<br>
+<br>
+fakeroot create_macos_pkg() {<br>
+=C2=A0 =C2=A0 sdk_pkg=3D&quot;${SDKDEPLOYDIR}/${TOOLCHAIN_OUTPUTNAME}.pkg&=
quot;<br>
+=C2=A0 =C2=A0 native_sysroot=3D$(basename ${SDKPATHNATIVE})<br>
+<br>
+=C2=A0 =C2=A0 sed -e &quot;s#@target_prefix@#${TARGET_PREFIX}#g&quot; \<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 -e &quot;s#@native_sysroot@#${native_sysroot}#=
g&quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0${DARWINBASE}/conf/files/finalize-sdk.sh=
 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &quot;${B}/finalize-pkg&quot;<br>
+<br>
+=C2=A0 =C2=A0 (cd ${B}; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ${DARWINBASE}/conf/files/mk-macos-pkg.sh &quot=
;${SDK_TITLE}&quot; &quot;${SDK_NAME}&quot; &quot;${SDK_ARCH}&quot; &quot;$=
{DISTRO_VERSION}.${SDK_VERSION}&quot; &quot;${SDK_OUTPUT}/${SDKPATH}&quot; =
&quot;${sdk_pkg}&quot; &quot;${B}/finalize-pkg&quot; ${DARWIN_INSTALL_LOC}/=
${SDK_NAME} \<br>
+=C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0ls -lh &quot;${sdk_pkg}&quot;<br>
+}<br>
+<br>
+fakeroot create_macos_dmg() {<br>
+=C2=A0 =C2=A0 sdk_dmg=3D&quot;${SDKDEPLOYDIR}/${TOOLCHAIN_OUTPUTNAME}.dmg&=
quot;<br>
+=C2=A0 =C2=A0 native_sysroot=3D$(basename ${SDKPATHNATIVE})<br>
+=C2=A0 =C2=A0 sed -e &quot;s#@target_prefix@#${TARGET_PREFIX}#g&quot; \<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 -e &quot;s#@native_sysroot@#${native_sysroot}#=
g&quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0${DARWINBASE}/conf/files/finalize-sdk.sh=
 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &quot;${B}/finalize-dmg&quot;<br>
+<br>
+=C2=A0 =C2=A0 echo &#39;rm ${0}&#39; &gt;&gt; &quot;${B}/finalize-dmg&quot=
;<br>
+<br>
+=C2=A0 =C2=A0 ( cd ${B}; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ${DARWINBASE}/conf/files/mk-macos-dmg.sh &quot=
;${SDK_TITLE}&quot; &quot;${SDK_NAME}&quot; &quot;${SDK_ARCH}&quot; &quot;$=
{DISTRO_VERSION}.${SDK_VERSION}&quot; &quot;${SDK_OUTPUT}/${SDKPATH}&quot; =
&quot;${sdk_dmg}&quot; &quot;${B}/finalize-dmg&quot; &quot;${DARWIN_INSTALL=
_LOC}/${SDK_NAME}&quot; \<br>
+=C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0ls -lh &quot;${sdk_dmg}&quot;<br>
+}<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3170): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3170&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DocDt_LbHjapIywNYWeZjpn13nP=
4qi8M-ViMysQ42MEAh4pLHUAUi7nHPV2HAzLgY&amp;s=3DRI7TbVVDb1JI4t7V-VwIOzosoaA0=
QogUxTcPBqFWles&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3170&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Do=
cDt_LbHjapIywNYWeZjpn13nP4qi8M-ViMysQ42MEAh4pLHUAUi7nHPV2HAzLgY&amp;s=3DRI7=
TbVVDb1JI4t7V-VwIOzosoaA0QogUxTcPBqFWles&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_117599656_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DocDt_LbHjapIywNYWeZjpn13nP4qi8M-ViMysQ42MEAh4p=
LHUAUi7nHPV2HAzLgY&amp;s=3DHmiWukrayw1P0qfPuQgy18xIGA9t7RYJ8nplxk4fUc8&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_117599656_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DocDt_LbHjapIywNYWeZjpn13nP4qi8M=
-ViMysQ42MEAh4pLHUAUi7nHPV2HAzLgY&amp;s=3DHmiWukrayw1P0qfPuQgy18xIGA9t7RYJ8=
nplxk4fUc8&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DocDt_LbHjapIy=
wNYWeZjpn13nP4qi8M-ViMysQ42MEAh4pLHUAUi7nHPV2HAzLgY&amp;s=3D_VBIT28ALkqgS9F=
91h-sUFpZJjfOKwlRhJMIfmw9GqM&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DocDt_LbHjapIywNYWeZjpn13nP4qi8M-ViMy=
sQ42MEAh4pLHUAUi7nHPV2HAzLgY&amp;s=3D_VBIT28ALkqgS9F91h-sUFpZJjfOKwlRhJMIfm=
w9GqM&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--000000000000312c8c064bcd3298--

