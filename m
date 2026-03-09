Return-Path: <dev@qinc.tv>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F57EFCD72
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 23:13:00 +0000 (UTC)
Received: from host.hernesphere.com (host.hernesphere.com [3.13.130.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28175.1773097976754623374
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 16:12:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: qinc.tv, ip: 3.13.130.34, mailfrom: dev@qinc.tv)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
Received: from localhost.localdomain (165-23-88-160-dynamic.midco.net [165.23.88.160])
	by host.hernesphere.com (Postfix) with ESMTPSA id 6FC66FDD87;
	Mon,  9 Mar 2026 18:12:54 -0500 (CDT)
Authentication-Results: host.hernesphere.com;
        spf=pass (sender IP is 165.23.88.160) smtp.mailfrom=dev@qinc.tv smtp.helo=localhost.localdomain
Received-SPF: pass (host.hernesphere.com: connection is authenticated)
X-Virus-Scanned: Debian amavisd-new at host.hernesphere.com
From: "Eric L. Hernes" <dev@qinc.tv>
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Subject: [PATCH 0/2] macOS img and pkg installers
Date: Mon,  9 Mar 2026 18:12:49 -0500
Message-ID: <20260309231251.99347-1-dev@qinc.tv>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 23:13:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3388

This patch adds support for building the SDK as .img and .pkg installers.

The .img can be mounted and used without having to install all the files =
for the SDK - this is similar to how Xcode deals with the var
ious macOS, iOS, tvOS, visionOS SDKs with versioning.  The main downside =
is that we don't have a way to automatically run the post install script;=
 so that is left to the user after opening the .img file.

The .pkg is the older way for macOS to install applications and data.  It=
 does allow running of the post install script at install time, so in thi=
s sense it's more automated.  The downside is that it does put the files =
in the filesystem individually.  We have to pick the location at build ti=
me - currently though the local.conf file.

In either case, there is a new mac-specific post install script (finalize=
-img and finalize-pkg) that will run the sed path changing commands and c=
odesign the executables.


Eric L. Hernes (2):
  Add IMG and PKG SDK installers
  convert libdispatch to native-only recipe

 README                                        |  19 ++
 conf/files/darwin-toolchain-shar-extract.sh   | 316 ++++++++++++++++++
 conf/files/finalize-sdk.sh                    |  48 +++
 conf/files/mk-macos-img.sh                    |  49 +++
 conf/files/mk-macos-pkg.sh                    | 161 +++++++++
 conf/files/post-install.in                    |   9 +
 conf/files/pre-install.in                     |  84 +++++
 conf/layer.conf                               |   3 +
 conf/machine-sdk/darwin-common.inc            |  55 ++-
 ...patch_git.bb =3D> libdispatch-native_git.bb} |   5 +-
 10 files changed, 744 insertions(+), 5 deletions(-)
 create mode 100644 conf/files/darwin-toolchain-shar-extract.sh
 create mode 100644 conf/files/finalize-sdk.sh
 create mode 100755 conf/files/mk-macos-img.sh
 create mode 100755 conf/files/mk-macos-pkg.sh
 create mode 100644 conf/files/post-install.in
 create mode 100644 conf/files/pre-install.in
 rename recipes-devtools/libdispatch/{libdispatch_git.bb =3D> libdispatch=
-native_git.bb} (94%)

--=20
2.50.1 (Apple Git-155)


