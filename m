Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6962.1795184820251092006
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Nov 2026 06:27:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=DspgYZkJ;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0D14F1A174B
	for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Nov 2026 14:26:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C70F0601B9
	for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Nov 2026 14:26:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3FFF211BC0232;
	Fri, 20 Nov 2026 15:26:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795184813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Z+7ZGrp02xtQa8RW5HHdK8V0Xu6YjJPKHafXNT+8utM=;
	b=DspgYZkJjwPUhGtn9V0GEnXJTovu8W7BHXqLghqv+EWpKieXJPcMqw9W6J2IL20rRRVHaO
	vkH0t7/DhLondYcg+JZ0cdCECNSoVPaveY7IvKSJtGWBp1io9XLqK7aqPjYXa7aV1so8M/
	7I9edpSG3U1nhSPnwvPgU5Azwj6G+zHRH4csthXBh5KGx4gVDa6pvWpsvoMheQfXZ9w6ZD
	D5mS69/CkUmrp6tP0gxJNGjIlgj6dt+RX217VcqRBc8hsRblx6d6TLR5dlIT745wOusvK2
	KXqCWdoifcLIMDDQ4kM4RmoMCS0BhHjT880oE6Jm14P0k6iayFFphRyXMNdkeg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 20 Nov 2026 15:26:46 +0100
Subject: [yocto-autobuilder2][PATCH] docs: clone openembedded-core when
 building the documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-run-docs-build-with-oecore-v1-1-75124e549421@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMOw7DIAwA0KtEnmsJGJqoV4kyJGAaVxWuDPSjK
 HcvTce3vA0yKVOGS7eB0pMzS2qwpw78OqcrIYdmcMadrTUOtSYM4jMule8BX1xWFPKihNaEOPe
 Rhn6I0IKHUuT3kY/T37kuN/LlN44f8UVwrkWOitRNsO9f/1diJZIAAAA=
X-Change-ID: 20261102-run-docs-build-with-oecore-10dfa7fe878f
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3756;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=8RfDjNXIseWssiUk73gMfnYrnx/6EWuvtu/CWXkLfVM=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBrAFipBlP/7DrEhDmXfA9KmIbmUBJBbcRuwbfiy
 QnSQ2C1v3KJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCawBYqQAKCRDRgEFAKaOo
 Nrg4D/9myKy0g2+WhH4nO3GsP16mjYFPlPCPZBG4wAe9TDlScAsads33JZOOj/yu8Hfs2vHDABO
 6heaCdkjt5VcRj+aBOb9fpHbZyjhppFEcJrpaa3WnCmJxqv58FXHTZLpSNgeUFpaYG7rP0CXVa3
 79s5V13lwro9czlg/jxHlZK0GtKss1qHQfjLuLuJA/ZYZNMRsKDEIMmT7mEawt5XIKkBjCq+Xws
 w2GjlOcyDUPaf8lYFJ9/cWwBgs7txue0y8TaXF53HmIxXuYXe4x7qbjsgyFhMzbvPSMXbkqL1kh
 +h+PwUS/XlwkHOIHy9BeRuUw90aOXlJSi2p24rsgxalsaWmzp/LFCikACvXSW9bOpuXMg3E6VOh
 XJMO0EaZkGs5ejOy6/XkTxme1ohk4KUIvul9/VJ4vQPoGqPFHfD4/KCx6EPCfVw6KHkO8R/OdMI
 nl5yWuA75pscGYxXjyfcDME0OOhqcQPljPIoDnuQZRQqSrSv33Ohlr/XM4ZzXpUwAjR9c6Xi1zx
 I4/8nyu4e8O4uhUJ2r1YAx71gSJmqqR2BN+EU7biODQ5HWt/21EBZ/wwdJnK5UH9rz7+bln7W2f
 TOcQP1Agxg8P3Dn46u5tVlh1Pz0QyUiNpaejVBuwa2kQ2e/ROLcwKkc2RUvBvwNEjBKvqab5Dra
 GDOCOUcv3XCDTXw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Nov 2026 14:27:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5482

In preparation for automatically documenting openembedded-core utilities
from docstrings, we need to clone openembedded-core as part of the docs
build. Add the repository to the build steps, and to the form when
manually starting a build.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Note: tested with a local Autobuilder instance.
---
 builders.py   | 11 ++++++++++-
 config.py     |  2 +-
 schedulers.py |  6 ++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builders.py b/builders.py
index 2d42d07..8ecf688 100644
--- a/builders.py
+++ b/builders.py
@@ -486,11 +486,20 @@ def create_doc_builder_factory():
         mode='incremental',
         haltOnFailure=True,
         name='Fetch bitbake'))
+    f.addStep(steps.Git(
+        repourl=util.Interpolate("%(prop:repo_oecore)s"),
+        branch=util.Property('branch_oecore'),
+        codebase='oecore',
+        workdir=util.Interpolate("%(prop:builddir)s/openembedded-core"),
+        mode='incremental',
+        haltOnFailure=True,
+        name='Fetch openembedded-core'))
     f.addStep(steps.ShellCommand(
         command=[util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/run-docs-build"),
                  util.Interpolate("%(prop:builddir)s"),
                  util.Interpolate("%(prop:builddir)s/yocto-docs"),
-                 util.Interpolate("%(prop:builddir)s/bitbake")],
+                 util.Interpolate("%(prop:builddir)s/bitbake"),
+                 util.Interpolate("%(prop:builddir)s/openembedded-core")],
         haltOnFailure=True,
         name="Run documentation Build"))
     return f
diff --git a/config.py b/config.py
index 7c675ab..c84af33 100644
--- a/config.py
+++ b/config.py
@@ -26,7 +26,7 @@ buildertorepos = {
     "checkuri": baserepos,
     "check-layer": baserepos + ["meta-mingw"],
     "check-layer-nightly": baserepos + ["meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv", "mixin-wrynose-linux-firmware", "meta-mingw"],
-    "docs": ["yocto-autobuilder-helper", "yocto-docs", "bitbake"],
+    "docs": ["yocto-autobuilder-helper", "yocto-docs", "bitbake", "oecore"],
     "reproducible-meta-oe": baserepos + ["meta-openembedded"],
     "patchtest": baserepos + ["meta-patchtest", "meta-openembedded"],
     "meta-oe-mirror":  baserepos + ["meta-openembedded"],
diff --git a/schedulers.py b/schedulers.py
index 5b5cf64..0022393 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -675,6 +675,12 @@ schedulers.append(sched.ForceScheduler(
                                           revision=util.FixedParameter(name="revision", default=""),
                                           repository=util.FixedParameter(name="repository", default=""),
                                           project=util.FixedParameter(name="project", default="")),
+                   util.CodebaseParameter(codebase='oecore',
+                                          label="openembedded-core:",
+                                          branch=util.FixedParameter(name="branch", default=""),
+                                          revision=util.FixedParameter(name="revision", default=""),
+                                          repository=util.FixedParameter(name="repository", default=""),
+                                          project=util.FixedParameter(name="project", default="")),
                    ],
         reason=util.StringParameter(
                 name="reason",

---
base-commit: b04a4c18e6c77731050c303e0ead4c9be0284407
change-id: 20261102-run-docs-build-with-oecore-10dfa7fe878f

