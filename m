Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B816CE7DF09
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 16:52:09 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.57803.1770051126640059485
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Feb 2026 08:52:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (165-23-88-160-dynamic.midco.net [165.23.88.160])
	by host.hernesphere.com (Postfix) with ESMTPSA id C0700106C2D;
	Mon,  2 Feb 2026 10:52:02 -0600 (CST)
Authentication-Results: host.hernesphere.com;
        spf=pass (sender IP is 165.23.88.160) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Subject: [meta-darwin][PATCH 0/1] macOS DMG/PKG
Date: Mon,  2 Feb 2026 10:51:46 -0600
Message-ID: <20260202165146.3727-2-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Feb 2026 16:52:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3169

This patch adds support for building both macOS .dmg and .pkg installer f=
iles.

DMG disk images are the most common way to distribute and use macOS softw=
are.
Recent versions of Xcode distribute the internal platform SDKs as .dmgs a=
nd
then Xcode mounts them internally.  This makes it fairly easy to have mul=
tiple
toolchains and sysroots without having to manage a lot of installed files=
.
There is one main obstacle, and a few details to sort out.  The main obst=
acle
is that running unsigned binaries on macOS is becoming more and more
difficult.  It's possible to configure a system allow unsigned binaries, =
but
it's a big security risk and generally not a good idea.  As far as I know=
,
it's only possible to sign binaries on a macOS system.  So here we are st=
uck
with running something on the Mac post-install.  The other main detail is=
 how
to relocate the installed files.  The Yocto SDK is designed to be re-loca=
ted
at install time - with the expectation that there is no way to know the
installed path until the user installing it picks it.  With a .dmg image,=
 this
is more managable at SDK build time, but since we are already running
something on the Mac to sign binaries, we might as well do some relocatin=
g
here and remain somewhat aligned with the standard Linux SDK.

The older, but still supported way of installing software on a Mac is thr=
ough
the .pkg installer files. This is more or less a set of xml files, script=
s,
and archives that allow the system Installer.app to install applications =
or
data on the system.  It does provide a convenient way to install directly=
 to
any macOS volume, or to the user's home directory.  It will appropriately
elevate permissions so that there is no need to explicitly use `sudo` or =
ask
for a password.  Since we are able to run pre-install and post-install
scripts, the .pkg builder sets it up to run the code signing and relocati=
ons
scripts during the install.

To give the developers some control over the darwin SDK, we have the foll=
owing variables:

DARWIN_INSTALLER_PKG =3D "1"
DARWIN_INSTALLER_DMG =3D "1"
DARWIN_INSTALLER_SH =3D "0"
DARWIN_INSTALLER_PATH =3D "/Library/Developer/org.openembedded.sdk"

Setting DARWIN_INSTALLER_PKG to "1" will enable building of the .pkg
installer.  Setting DARWIN_INSTALLER_DMG to "1" will enable building the =
.dmg
file.  If we are building the .dmg or the .pkg (or both), we may not care
about building the regular .sh installer.  That can be disabled by settin=
g
DARWIN_INSTALLER_SH to "0".  We can specify the prefix path to the SDK wi=
th
the "DARWIN_INSTALLER_PATH".  This applies to both in the .dmg and the .p=
kg.
This path will be relative to the root directory in the .dmg; and relativ=
e to
the user's installed location in the .pkg.  For example, with the above
default path, opening the .dmg file through the Finder (or from the termi=
nal
with `open`) will put the sdk files at
"/Volumes/oecore-meta-toolchain-aarch64-armv8a-xxx-xxx/Library/Developer/=
org.openembedded.sdk/oecore-meta-toolchain-aarch64-armv8a-xxx-xxx/".
For the .pkg, the user will select the Volume or home directory, then the
"/library/Developer/org.openembedded.sdk/..." path will be relative to th=
at.
If the user picks "Install for me only" option, it will be in their home
directory (as ~/Library/Developer/...).

Open questions:

1. Both the .dmg and .pkg installer have the ability to attach license
  documents - should we put anything in there?  I suppose this could also=
 have
 some basic instructions for the pathing and use of the SDK.  ` 2. The .p=
kg has
  a few screens and text instructions that can be displayed while running=
 the
  installer.  Should we put anything in there?

3. The .dmg is intentionally set up as an uncompressed image.  This is
  intended to speed up compiles for the target.  Requiring the os to cons=
tantly
  decompress data seems like a waste of time.  However, it is possible th=
at the
  macOS cache will handle it properly and it won't be an issue.  Should w=
e have
  a local.conf option to enable compression?  Alternatively, we could com=
press
  the generated .dmg with `xz` like the .sh installer does.

4. Maybe the most controversial question is what should the default
  DARWIN_INSTALLER_PATH be?  Or should it be DARWIN_INSTALLER_PREFIX, sin=
ce it's
  more of a prefix than a full path?  This is probably depends on whether=
 we
  want the use to be "more macOS" or more "Linux / Yocto".  More macOS wo=
uld
  expect the users to have multiple .dmg's mounted for individual SDKs th=
ey
  intend to use.  Linux / Yocto would have them separated at the lower in=
stalled
  level - as /usr/local/${SDK_NAME_PREFIX}-${SDK_ARCH}", with different S=
DKs
  having different SDK_NAME_PREFIXes.  Should DARWIN_INSTALLER_PATH be re=
placed
  with SDKPATHINSTALL?

5. What does the post-install script really need to do to relocate things=
 on
  macOS?  I've got to admit that I really can't follow all the logic betw=
een
  `toolchain-shar-extract.sh`, `toolchain-shar-relocate.sh`, `relocate_sd=
k.py`,
  and the post-relocate-setup.d/* scripts.  It looks like most of the com=
plexity
  is to deal with linux' ld.so pathing - which isn't relevant on macOS.  =
The
  finalize SDK scripts I have here do two things - run `sed` on text file=
s to
  change the installed paths; and run codesign to sign the binaries.  Is =
there
  more we need to do?

Eric L. Hernes (1):
  Add DMG and PKG SDK installers

 README                                      |  19 ++
 conf/files/darwin-toolchain-shar-extract.sh | 316 ++++++++++++++++++++
 conf/files/finalize-sdk.sh                  |  48 +++
 conf/files/mk-macos-dmg.sh                  |  49 +++
 conf/files/mk-macos-pkg.sh                  | 161 ++++++++++
 conf/files/post-install.in                  |   9 +
 conf/files/pre-install.in                   |  84 ++++++
 conf/layer.conf                             |   3 +
 conf/machine-sdk/darwin-common.inc          |  54 +++-
 9 files changed, 741 insertions(+), 2 deletions(-)
 create mode 100644 conf/files/darwin-toolchain-shar-extract.sh
 create mode 100644 conf/files/finalize-sdk.sh
 create mode 100755 conf/files/mk-macos-dmg.sh
 create mode 100755 conf/files/mk-macos-pkg.sh
 create mode 100644 conf/files/post-install.in
 create mode 100644 conf/files/pre-install.in

--=20
2.50.1 (Apple Git-155)


