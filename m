Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.17756.1711636039685200959
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Mar 2024 07:27:19 -0700
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90F8D1476
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 Mar 2024 07:27:52 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92C2A3F64C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 Mar 2024 07:27:18 -0700 (PDT)
From: "Ross Burton" <ross.burton@arm.com>
Subject: [PATCH yocto-autobuilder-helper] README: update patch submission address
Date: Thu, 28 Mar 2024 14:27:15 +0000
Message-Id: <20240328142715.2390692-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

From: Ross Burton <ross.burton@arm.com>

Patches should now be sent to yocto-patches@.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 README | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/README b/README
index 20e0b647..cf693939 100644
--- a/README
+++ b/README
@@ -28,12 +28,9 @@ Authors:
=20
 Contributions:
=20
-Patches for this code should be sent to the yocto@lists.yoctoproject.org=
 mailing list
+Patches for this code should be sent to the yocto-patches@lists.yoctopro=
ject.org mailing list
 with [yocto-autobuilder-helper] in the subject.  This can be configured =
automatically
-with the following commands:
+for the repository with the following commands:
=20
-  git config  --local --add format.subjectprefix 'yocto-autobuilder-help=
er][PATCH'
-  git config  --local --add sendemail.to yocto@lists.yoctoproject.org
-
-When sending single patches, please use something like:
-git send-email -M -1 --to=3Dyocto@lists.yoctoproject.org --subject-prefi=
x=3D'yocto-autobuilder-helper][PATCH'
+  git config --local --add format.subjectprefix 'yocto-autobuilder-helpe=
r][PATCH'
+  git config --local --add sendemail.to yocto-patches@lists.yoctoproject=
.org
--=20
2.34.1

