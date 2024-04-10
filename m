Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.161669.1712742117999606055
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Apr 2024 02:41:58 -0700
From: "Ross Burton" <ross.burton@arm.com>
Subject: [meta-mingw] [PATCH] README: change patch submission list to yocto-patches@
Date: Wed, 10 Apr 2024 09:41:54 +0000
Message-Id: <20240410094154.1248824-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: yocto-patches@lists.yoctoproject.org
Cc: nd@arm.com, jpewhacker@gmail.com
List-ID: <yocto-patches.lists.yoctoproject.org>

Patches are being moved off yocto@ to yocto-patches@.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 README | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/README b/README
index af3ace9..fdb3cd5 100644
--- a/README
+++ b/README
@@ -13,11 +13,11 @@ This layer depends on:
=20
 Layer Maintainer: Joshua Watt <jpewhacker@gmail.com>
=20
-Please send changes to the yocto mailing list with [meta-mingw] in the s=
ubject line,
-cc'ing the maintainer.
+Please send changes to the yocto-patches mailing list with [meta-mingw] =
in the
+subject line, cc'ing the maintainer.
=20
 This can be configured within the repository with the commands:
=20
-git config sendemail.to yocto@lists.yoctoproject.org
+git config sendemail.to yocto-patches@lists.yoctoproject.org
 git config sendemail.cc jpewhacker@gmail.com
 git config format.subjectprefix "meta-mingw] [PATCH"
--=20
2.34.1

