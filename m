Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61B9E9D414
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 15:27:01 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23242.1770305220787597318
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Feb 2026 07:27:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=wknBUdBX;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9BCE3C243AD
	for <yocto-patches@lists.yoctoproject.org>; Thu,  5 Feb 2026 15:27:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73C2F606FD
	for <yocto-patches@lists.yoctoproject.org>; Thu,  5 Feb 2026 15:26:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52AA0119A8891;
	Thu,  5 Feb 2026 16:26:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770305218; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=4IerTaq4+M+/46eP/CD7nSYRrJfGbd2zr7Y9hqPcQeM=;
	b=wknBUdBXMfRWtvpOWop9uLeuKcNz6n23P12Ry7KMkuCe6xQMKnKJQf2LN71S3iB5v1cx0V
	oWCcwW2yhxyf7SS8RrWVMTEf+kkdarkNZE35MKQVIFEfTPWjXg5oGh3bCscU5jfir+G7d7
	+lnSkFpIoe4DrNn4o3vFoR3k12n1bxLEzhOjg6ZVf5ZyZmWH4rvzakzTklAaVbMMe8OWUi
	V0Pv+CqrMKlH6Csc7s3qGFgdd/NxkgU4+V0LrtlfKdEsxPnzJEnpMWDkEseJjPjWpKFdDx
	/hchYCAgNAI1rddragtJnDV55gdIjN6LGWQubbbH1kExp+cu6NtcR5++DA9BEA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 05 Feb 2026 16:26:51 +0100
Subject: [yocto-autobuilder-helper][PATCH v2] scripts/docs-build-patches:
 support custom BitBake switchers.js menu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bitbake-custom-switchers-v2-1-7679968e0539@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBAAv0J6dg2sQsST/yAc2rLYVaSkLSgh/
 N2CH/A4h5nMIjw5Ji+uySIcTezZ9hHwkAhtZH8n4CaywBSLFNMzKA5KPgn06IN9gX9z0IacB3W
 6ZEhlSQXmIuqDo5Y/e7qqf+xH9SAdtl41Wx0syDFYNXLXkAND3UCu3lzDMe7m/WrKtsIfA1MGG
 eQKSeeIZSubm7I2dNwftX2Jel3XLx0DzOnuAAAA
X-Change-ID: 20260204-bitbake-custom-switchers-b3812e99e625
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9858;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=qJEKRyHIYp3mSetctcC7bYNTQ8ULy7A3tZcYsvaWzjE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBphLbBtq6Z26EEiJvEeHEY1Hj+qpzK0s2OWt2NS
 v9xpqfLeLyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYS2wQAKCRDRgEFAKaOo
 NtNgEACBPQXi8bCihYHCFtjAmtABlaTwDThvrUYBzB8mUOTmE/GIWS5DusB8Zyjk4j9lff6tVom
 uxsIBaXbtI/vgjRCBgvxrQpCG09bCnnwDj3as3A2w/P633orstBxSeUTPEq7QcqZKfOCV+Fk8a+
 VVTrm2bbX37kF7THAYmGzErYXj5rEKIGX+w1f1wtLMXtjfmNMqYETS1PeMl9CbRG5b7L+pFkmA3
 ZyJGRszlPtw5lJ+GDOj3xSCNE52OhxNmAfwOuHFkqO9mmEOJ7NFe0LB+0T7IiEuwKzuc5/lIFLe
 R91OWRD4CJqG3prpLzgNugcF/hpl/QX13sBuU4hehRHBFyQ5s1xmp5WmbKBRzoDDRCz0d8QlhpR
 5xsCu2M6Un7DFEFh5INTpVbuWiVgmOYWSQAJ9wc/Uu41npe3B8aFunHJZF+nrfCb5+/3yS43cXi
 88pqIuaPyazHhQdmv0xgBkmieQdIkADEKMuP1r6sQPxbcnRWfhwgkcHgGk69VmKso8M8v87SueY
 m8y/OS31fvLASBGAX8xODeK3aUUuy3yzLHHQYbMxp8/8mbgC89bS+0shOSYVEI9UYlaKTZJunbG
 nimYCgLrnxarNkpCfG3gzjEVj1XkSOe9w/Dbym+Sz5zIKjIVPFsJsna/rybKICXcQsR7UXtKIxp
 KnLXFVm/mp+HoNQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Feb 2026 15:27:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3194

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
IMPORTANT: this depends on
https://lore.kernel.org/r/20260205-fix-switchers-js-v3-1-61b4401adfdf@bootlin.com
being merged on master.
---
Changes in v2:
- Re-adapt after bitbake patch was resent.
- Link to v1: https://patch.msgid.link/20260204-bitbake-custom-switchers-v1-1-5b2ec5229fad@bootlin.com
---
 ...doc-conf.py-adapt-for-custom-switchers.js.patch | 39 ++++++++++++++++++++
 ...doc-conf.py-adapt-for-custom-switchers.js.patch | 40 +++++++++++++++++++++
 scripts/docs-build-patches/bitbake/1.50            |  1 +
 scripts/docs-build-patches/bitbake/1.52            |  1 +
 scripts/docs-build-patches/bitbake/2.0             |  1 +
 scripts/docs-build-patches/bitbake/2.10            |  1 +
 scripts/docs-build-patches/bitbake/2.12            |  1 +
 ...doc-conf.py-adapt-for-custom-switchers.js.patch | 41 ++++++++++++++++++++++
 scripts/docs-build-patches/bitbake/2.2             |  1 +
 scripts/docs-build-patches/bitbake/2.4             |  1 +
 scripts/docs-build-patches/bitbake/2.6             |  1 +
 scripts/docs-build-patches/bitbake/2.8             |  1 +
 scripts/run-docs-build                             | 12 ++++---
 13 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/scripts/docs-build-patches/bitbake/1.46/0001-doc-conf.py-adapt-for-custom-switchers.js.patch b/scripts/docs-build-patches/bitbake/1.46/0001-doc-conf.py-adapt-for-custom-switchers.js.patch
new file mode 100644
index 0000000..c089595
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/1.46/0001-doc-conf.py-adapt-for-custom-switchers.js.patch
@@ -0,0 +1,39 @@
+From 9ae0da4650aea70ed85982a5d5121238175e6f21 Mon Sep 17 00:00:00 2001
+From: Antonin Godard <antonin.godard@bootlin.com>
+Date: Thu, 5 Feb 2026 15:50:45 +0100
+Subject: [PATCH] doc/conf.py: adapt for custom switchers.js
+
+Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
+---
+ doc/conf.py | 10 +++++++++-
+ 1 file changed, 9 insertions(+), 1 deletion(-)
+
+diff --git a/doc/conf.py b/doc/conf.py
+index fc2ee081119..4d066101a79 100644
+--- a/doc/conf.py
++++ b/doc/conf.py
+@@ -16,8 +16,12 @@
+ 
+ import sys
+ import datetime
++import os
+ 
+-current_version = "dev"
++sys.path.insert(0, os.path.abspath('.'))
++import setversions
++
++current_version = setversions.get_current_version()
+ 
+ # String used in sidebar
+ version = 'Version: ' + current_version
+@@ -26,6 +30,10 @@ if current_version == 'dev':
+ # Version seen in documentation_options.js and hence in js switchers code
+ release = current_version
+ 
++setversions.write_switchers_js("sphinx-static/switchers.js.in",
++                               "sphinx-static/switchers.js",
++                               current_version)
++
+ # -- Project information -----------------------------------------------------
+ 
+ project = 'Bitbake'
diff --git a/scripts/docs-build-patches/bitbake/1.48/0001-doc-conf.py-adapt-for-custom-switchers.js.patch b/scripts/docs-build-patches/bitbake/1.48/0001-doc-conf.py-adapt-for-custom-switchers.js.patch
new file mode 100644
index 0000000..3d7653a
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/1.48/0001-doc-conf.py-adapt-for-custom-switchers.js.patch
@@ -0,0 +1,40 @@
+From dfe8e1431208a593b0c6f525831d52960a384174 Mon Sep 17 00:00:00 2001
+From: Antonin Godard <antonin.godard@bootlin.com>
+Date: Thu, 5 Feb 2026 15:50:45 +0100
+Subject: [PATCH] doc/conf.py: adapt for custom switchers.js
+
+Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
+---
+ doc/conf.py | 11 ++++++++++-
+ 1 file changed, 10 insertions(+), 1 deletion(-)
+
+diff --git a/doc/conf.py b/doc/conf.py
+index 354dff36f71..4d88286a4b8 100644
+--- a/doc/conf.py
++++ b/doc/conf.py
+@@ -15,8 +15,13 @@
+ # sys.path.insert(0, os.path.abspath('.'))
+ 
+ import datetime
++import os
++import sys
+ 
+-current_version = "dev"
++sys.path.insert(0, os.path.abspath('.'))
++import setversions
++
++current_version = setversions.get_current_version()
+ 
+ # String used in sidebar
+ version = 'Version: ' + current_version
+@@ -25,6 +30,10 @@ if current_version == 'dev':
+ # Version seen in documentation_options.js and hence in js switchers code
+ release = current_version
+ 
++setversions.write_switchers_js("sphinx-static/switchers.js.in",
++                               "sphinx-static/switchers.js",
++                               current_version)
++
+ # -- Project information -----------------------------------------------------
+ 
+ project = 'Bitbake'
diff --git a/scripts/docs-build-patches/bitbake/1.50 b/scripts/docs-build-patches/bitbake/1.50
new file mode 120000
index 0000000..644f9b3
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/1.50
@@ -0,0 +1 @@
+1.46
\ No newline at end of file
diff --git a/scripts/docs-build-patches/bitbake/1.52 b/scripts/docs-build-patches/bitbake/1.52
new file mode 120000
index 0000000..644f9b3
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/1.52
@@ -0,0 +1 @@
+1.46
\ No newline at end of file
diff --git a/scripts/docs-build-patches/bitbake/2.0 b/scripts/docs-build-patches/bitbake/2.0
new file mode 120000
index 0000000..644f9b3
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/2.0
@@ -0,0 +1 @@
+1.46
\ No newline at end of file
diff --git a/scripts/docs-build-patches/bitbake/2.10 b/scripts/docs-build-patches/bitbake/2.10
new file mode 120000
index 0000000..644f9b3
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/2.10
@@ -0,0 +1 @@
+1.46
\ No newline at end of file
diff --git a/scripts/docs-build-patches/bitbake/2.12 b/scripts/docs-build-patches/bitbake/2.12
new file mode 120000
index 0000000..644f9b3
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/2.12
@@ -0,0 +1 @@
+1.46
\ No newline at end of file
diff --git a/scripts/docs-build-patches/bitbake/2.16/0001-doc-conf.py-adapt-for-custom-switchers.js.patch b/scripts/docs-build-patches/bitbake/2.16/0001-doc-conf.py-adapt-for-custom-switchers.js.patch
new file mode 100644
index 0000000..a8224d0
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/2.16/0001-doc-conf.py-adapt-for-custom-switchers.js.patch
@@ -0,0 +1,41 @@
+From ef23395086f4e3d6720d1b137ba4a7dd12f95540 Mon Sep 17 00:00:00 2001
+From: Antonin Godard <antonin.godard@bootlin.com>
+Date: Thu, 5 Feb 2026 15:50:45 +0100
+Subject: [PATCH] doc/conf.py: adapt for custom switchers.js
+
+Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
+---
+ doc/conf.py | 10 +++++++++-
+ 1 file changed, 9 insertions(+), 1 deletion(-)
+
+diff --git a/doc/conf.py b/doc/conf.py
+index bce386624e..e74905b6fc 100644
+--- a/doc/conf.py
++++ b/doc/conf.py
+@@ -16,10 +16,14 @@
+ 
+ import sys
+ import datetime
++import os
+ 
+ from pathlib import Path
+ 
+-current_version = "dev"
++sys.path.insert(0, os.path.abspath('.'))
++import setversions
++
++current_version = setversions.get_current_version()
+ 
+ # String used in sidebar
+ version = 'Version: ' + current_version
+@@ -28,6 +32,10 @@ if current_version == 'dev':
+ # Version seen in documentation_options.js and hence in js switchers code
+ release = current_version
+ 
++setversions.write_switchers_js("sphinx-static/switchers.js.in",
++                               "sphinx-static/switchers.js",
++                               current_version)
++
+ # -- Project information -----------------------------------------------------
+ 
+ project = 'Bitbake'
diff --git a/scripts/docs-build-patches/bitbake/2.2 b/scripts/docs-build-patches/bitbake/2.2
new file mode 120000
index 0000000..644f9b3
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/2.2
@@ -0,0 +1 @@
+1.46
\ No newline at end of file
diff --git a/scripts/docs-build-patches/bitbake/2.4 b/scripts/docs-build-patches/bitbake/2.4
new file mode 120000
index 0000000..644f9b3
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/2.4
@@ -0,0 +1 @@
+1.46
\ No newline at end of file
diff --git a/scripts/docs-build-patches/bitbake/2.6 b/scripts/docs-build-patches/bitbake/2.6
new file mode 120000
index 0000000..644f9b3
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/2.6
@@ -0,0 +1 @@
+1.46
\ No newline at end of file
diff --git a/scripts/docs-build-patches/bitbake/2.8 b/scripts/docs-build-patches/bitbake/2.8
new file mode 120000
index 0000000..644f9b3
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/2.8
@@ -0,0 +1 @@
+1.46
\ No newline at end of file
diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index b83799a..04ae26a 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -118,7 +118,13 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
     git checkout $branch
     git reset --hard
     git clean -ffdx
-    git checkout origin/master releases.rst
+
+    if [ -e "${scriptdir}/docs-build-patches/bitbake/${branch}" ]; then
+        echo Adding patch for $branch
+        git am -3 "${scriptdir}/docs-build-patches/bitbake/${branch}/"000*
+    fi
+
+    git checkout origin/master releases.rst sphinx-static/switchers.js.in setversions.py
 
     (
         . $builddir/buildtools/environment-setup*
@@ -243,10 +249,6 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
     git clean -ffdx
 done
 
-# Update bitbake switchers.js with the copy from master ypdocs
-cd $outputdir/bitbake
-find . -name switchers.js -exec cp $outputdir/current/_static/switchers.js {} \;
-
 if [ "$PUBLISH" -ne 0 ]; then
     cd $outputdir
     rsync -irlp --checksum --ignore-times --delete . docs@docs.yoctoproject.org:docs/

---
base-commit: ec17abb0b2d759b800cefec4fcac61cee74dbefc
change-id: 20260204-bitbake-custom-switchers-b3812e99e625


