Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C601CE95375
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 10:10:36 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17124.1770199834038054361
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 02:10:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=cE+gEZLl;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3C88B1A2B07
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 10:10:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E4FC60745
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 10:10:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC828119A88F7;
	Wed,  4 Feb 2026 11:10:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770199831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=hd5LvhhKTKbMqzF2tSvumyoa1sj2nA/cAccZE30HcEE=;
	b=cE+gEZLlhEpvuaKbvInf7i3WGd14V3hvIhNTRJgnOd1y/yTKwtwkT/TlnoEygoTtppCK3J
	gcvh2a1exY8QB1NBmLK04LFemsRYE+1uUCusIkvesQo75wQDVW7kMKOphjAFauQdd44g26
	6Kz/Mq72qIEskNGWlD6QmzhKjPXZz0thOSQR4cyWhapWoTcWPe4L06tshYYu9ze06hqF4H
	9T8SiSOmDCybbotnK5VGnDnw2wkk4h8C2a3VET82mAqw7vvzNemC1aj6aywn5dc1WUsATP
	Nktj3RMQ8zfhg3FTJ7K6NWnTE0zBAiI1jYux/K8+ifqzYzQ7b4aYT0AGQFeYcg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Feb 2026 11:10:24 +0100
Subject: [yocto-autobuilder-helper][PATCH] scripts/docs-build-patches:
 support custom BitBake switchers.js menu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-bitbake-custom-switchers-v1-1-5b2ec5229fad@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBBG4Vchs3YSKErEVyEsaPmVUaSk03oJ4
 d1FXX6LcxZSBIHSKVso4CEqftpQ7DJyQzddwNJvJpObKjf5nq1E293ALmn0d9anRDcgKNvyWBj
 UNSpzoC2fA87y+q2b9m9N9goXv7/m7V303KXobZKxR+AB44zQ0rp+AFyYgZ+WAAAA
X-Change-ID: 20260204-bitbake-custom-switchers-b3812e99e625
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10339;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ymrzZu8o4+2UfyfrooLAVoNTWTVa0pHcG+AW6PXO5is=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpgxsWditQbgy1sHS+uct1hn1eIlNnn0/5AYKTs
 378XmaQhMqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYMbFgAKCRDRgEFAKaOo
 NpyqEACadZLOrABxpw9V9J/JO6FrZkYLNaffPNMWursLnS+H93sIx98O5Gz9wbOYrSU6aTYJkBi
 yKx/6OeHkzudhR7iNoFRbKrjLvpzGaD+BMqaUo179t+YU0c0JgILAxr5wGl43yu8mgKGYXh1SFb
 2jIt1SdMbAn/KJdkEloVn+bKM30KSNbox/ZqKDN7KXp5VbWTDAGl13yQjMO4TENBgEyuUcWKvBL
 APzXh/X0TzJiSk9RYGQG9xq58KaPOzK0kOVPPT5tnaYAGMyM6A1cOMAs9Ai1u8S8ap9ovY9v2Nq
 45MkDDNR8GuKcOCrEUaj3hZLCQ/AaM7VOWdrUJp+W+rDpT61hbyy6PYVZRz+xEgVrpJf5cEbdx/
 dPj2lGBGfHL2JN7iXpeOc8smjj/+YIUbcp7ip+JaFyASFPYIO0220ZErbW+tvPbcTef1YzF2HKO
 GmRnyHSvzhek19d4cxZIircTYymcUkwPYfPSMUE1S1LtGDD4hKjs7HphL+EN+W//5yMXM28ww7L
 1VNh/HYYxbWA6T+Cy0x4oG3TUB2hr45UD4O/JJAS18OnL38V3TCO5Vdo+qv8JKY9o93jv4MfTN5
 YbD3LduVy+nKRQnpG7FuZnljGm3OXIWeStXVMaHuf524iP1DcliccwpQgNtXt4YF5gi2dSHIZNx
 +5fPokG2f1O2Ydw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 10:10:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3189

Adapt scripts/run-docs-build to pick up the switchers.js.in and
set_versions.py file from bitbake's master branch, like what is done for
yocto-docs.

Since this can't work on its own for older releases, create migration
patches for older releases in order to actually include the previously
checked out files in the build output. Most of the patch files are the
same except for 2.16. Create symlinks to avoid duplication.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
IMPORTANT: this depends on
https://lore.kernel.org/r/20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com
being merged on master.
---
 .../0001-docs-adapt-for-custom-switchers.js.patch  | 60 ++++++++++++++++++
 scripts/docs-build-patches/bitbake/1.48            |  1 +
 scripts/docs-build-patches/bitbake/1.50            |  1 +
 scripts/docs-build-patches/bitbake/1.52            |  1 +
 scripts/docs-build-patches/bitbake/2.0             |  1 +
 scripts/docs-build-patches/bitbake/2.10            |  1 +
 scripts/docs-build-patches/bitbake/2.12            |  1 +
 .../0001-docs-adapt-for-custom-switchers.js.patch  | 71 ++++++++++++++++++++++
 scripts/docs-build-patches/bitbake/2.2             |  1 +
 scripts/docs-build-patches/bitbake/2.4             |  1 +
 scripts/docs-build-patches/bitbake/2.6             |  1 +
 scripts/docs-build-patches/bitbake/2.8             |  1 +
 scripts/run-docs-build                             | 12 ++--
 13 files changed, 148 insertions(+), 5 deletions(-)

diff --git a/scripts/docs-build-patches/bitbake/1.46/0001-docs-adapt-for-custom-switchers.js.patch b/scripts/docs-build-patches/bitbake/1.46/0001-docs-adapt-for-custom-switchers.js.patch
new file mode 100644
index 0000000..70aca99
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/1.46/0001-docs-adapt-for-custom-switchers.js.patch
@@ -0,0 +1,60 @@
+From 0983c3e3a298f5ec601084e4005152d7a1de4f49 Mon Sep 17 00:00:00 2001
+From: Antonin Godard <antonin.godard@bootlin.com>
+Date: Tue, 3 Feb 2026 17:03:09 +0100
+Subject: [PATCH] docs: adapt for custom switchers.js
+
+This is an adaptation of the patch in recent versions of the documentation to
+make the new switchers.js menu available in older versions of the BitBake
+documentation.
+
+Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
+---
+ doc/Makefile        | 3 ++-
+ doc/bitbake.yaml.in | 1 +
+ doc/conf.py         | 8 +++++++-
+ 3 files changed, 10 insertions(+), 2 deletions(-)
+ create mode 100644 doc/bitbake.yaml.in
+
+diff --git a/doc/Makefile b/doc/Makefile
+index 4d721d30f3..0606181999 100644
+--- a/doc/Makefile
++++ b/doc/Makefile
+@@ -27,9 +27,10 @@ publish: Makefile html singlehtml
+ 	sed -i -e 's@index.html#@singleindex.html#@g' $(BUILDDIR)/$(DESTDIR)/singleindex.html
+ 
+ clean:
+-	@rm -rf $(BUILDDIR)
++	@rm -rf $(BUILDDIR) sphinx-static/switchers.js
+ 
+ # Catch-all target: route all unknown targets to Sphinx using the new
+ # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
+ %: Makefile
++	$(SOURCEDIR)/set_versions.py
+ 	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
+diff --git a/doc/bitbake.yaml.in b/doc/bitbake.yaml.in
+new file mode 100644
+index 0000000000..4085582df6
+--- /dev/null
++++ b/doc/bitbake.yaml.in
+@@ -0,0 +1 @@
++DOCCONF_VERSION : "dev"
+diff --git a/doc/conf.py b/doc/conf.py
+index fc2ee08111..8ed72fb0fa 100644
+--- a/doc/conf.py
++++ b/doc/conf.py
+@@ -16,8 +16,14 @@
+ 
+ import sys
+ import datetime
++import yaml
+ 
+-current_version = "dev"
++current_version = 'dev'
++
++with open("bitbake.yaml") as data:
++    buff = data.read()
++    subst_vars = yaml.safe_load(buff)
++    current_version = subst_vars["DOCCONF_VERSION"]
+ 
+ # String used in sidebar
+ version = 'Version: ' + current_version
diff --git a/scripts/docs-build-patches/bitbake/1.48 b/scripts/docs-build-patches/bitbake/1.48
new file mode 120000
index 0000000..644f9b3
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/1.48
@@ -0,0 +1 @@
+1.46
\ No newline at end of file
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
diff --git a/scripts/docs-build-patches/bitbake/2.16/0001-docs-adapt-for-custom-switchers.js.patch b/scripts/docs-build-patches/bitbake/2.16/0001-docs-adapt-for-custom-switchers.js.patch
new file mode 100644
index 0000000..4c8fd7f
--- /dev/null
+++ b/scripts/docs-build-patches/bitbake/2.16/0001-docs-adapt-for-custom-switchers.js.patch
@@ -0,0 +1,71 @@
+From 850e7167e3189ed28dde6804d0f0bf0879db6eeb Mon Sep 17 00:00:00 2001
+From: Antonin Godard <antonin.godard@bootlin.com>
+Date: Tue, 3 Feb 2026 17:03:09 +0100
+Subject: [PATCH] docs: adapt for custom switchers.js
+
+This is an adaptation of the patch in recent versions of the documentation to
+make the new switchers.js menu available in older versions of the BitBake
+documentation.
+
+Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
+---
+ doc/Makefile        |  3 ++-
+ doc/bitbake.yaml.in |  1 +
+ doc/conf.py         | 10 +++++++++-
+ 3 files changed, 12 insertions(+), 2 deletions(-)
+ create mode 100644 doc/bitbake.yaml.in
+
+diff --git a/doc/Makefile b/doc/Makefile
+index 996f01b7d5c..998ba52b8c5 100644
+--- a/doc/Makefile
++++ b/doc/Makefile
+@@ -27,9 +27,10 @@ publish: Makefile html singlehtml
+ 	sed -i -e 's@index.html#@singleindex.html#@g' $(BUILDDIR)/$(DESTDIR)/singleindex.html
+ 
+ clean:
+-	@rm -rf $(BUILDDIR)
++	@rm -rf $(BUILDDIR) sphinx-static/switchers.js
+ 
+ # Catch-all target: route all unknown targets to Sphinx using the new
+ # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
+ %: Makefile
++	$(SOURCEDIR)/set_versions.py
+ 	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
+diff --git a/doc/bitbake.yaml.in b/doc/bitbake.yaml.in
+new file mode 100644
+index 00000000000..4085582df60
+--- /dev/null
++++ b/doc/bitbake.yaml.in
+@@ -0,0 +1 @@
++DOCCONF_VERSION : "dev"
+diff --git a/doc/conf.py b/doc/conf.py
+index bce386624e2..5b28808c590 100644
+--- a/doc/conf.py
++++ b/doc/conf.py
+@@ -14,17 +14,25 @@
+ # import sys
+ # sys.path.insert(0, os.path.abspath('.'))
+ 
++import os
+ import sys
+ import datetime
++import yaml
+ 
+ from pathlib import Path
+ 
+-current_version = "dev"
++current_version = 'dev'
++
++with open("bitbake.yaml") as data:
++    buff = data.read()
++    subst_vars = yaml.safe_load(buff)
++    current_version = subst_vars["DOCCONF_VERSION"]
+ 
+ # String used in sidebar
+ version = 'Version: ' + current_version
+ if current_version == 'dev':
+     version = 'Version: Current Development'
++
+ # Version seen in documentation_options.js and hence in js switchers code
+ release = current_version
+ 
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
index b83799a..48a355b 100755
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
+    git checkout origin/master releases.rst sphinx-static/switchers.js.in set_versions.py
 
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


