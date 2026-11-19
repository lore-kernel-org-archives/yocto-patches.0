Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14148.1795094388940367530
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Nov 2026 05:19:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Ydb9eA6O;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C2BDEC4CBF1
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Nov 2026 13:19:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7C45260237;
	Thu, 19 Nov 2026 13:19:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B15F11BC0B6D;
	Thu, 19 Nov 2026 14:19:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795094385; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RUiSrg6VclG38N4+D0Kw5igikwHxdzzhQlFFfqoxV50=;
	b=Ydb9eA6OuK39QGP5faYcMzt9Gun+t85GK0PuNK26PQBWchb51JZF4KLkuauXaebb5owYe3
	YJLbivkSR2/oLELqmdAhNC8JLMIhokFgvOAd0X+KnS8vOuG/ZMZfOwnBA5ryCYxYG+m0U5
	BELT8s0PWPubEOJtsz0+/wvV3lai06x0GdI9nr+CGLQ4VSjzRp9/+IJIkUyP8WagNbKQwk
	3FT3j9ERwv4aqBXXO64tocc9hIDFH75EApAVo3vhusZDuzSkVhprFV3kPINRoAd9Euxr+H
	HmeruBsQUOH+nGad4yGxveMTauX2zeEZ/7gMQw5rFJieI/TuiMvOrYKCna3lkQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 19 Nov 2026 14:19:33 +0100
Subject: [PATCH yocto-autobuilder2 1/3] yocto_console_view: switch to
 pyproject.toml
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-mathieu-buildbot-4-4-b4-v1-1-76774afaee1d@bootlin.com>
References: <20261119-mathieu-buildbot-4-4-b4-v1-0-76774afaee1d@bootlin.com>
In-Reply-To: <20261119-mathieu-buildbot-4-4-b4-v1-0-76774afaee1d@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michael Halstead <mhalstead@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795094383; l=3182;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=aYTJvfD5sKid0TV3afyuBkVz4VWXoYMGyYzNtgUZUxs=;
 b=KOq30UVAJ3cKcMcWRelK9dC0bgCCF5/GumpB9u74l2OVUfn4rtOEICEz2ySHC8HXHS+GEgWym
 Q7wrVwAE0f0DpZMfyAy+33CYnwTCXxD7QoaM8w6M5s57r7iB0llm369
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Nov 2026 13:19:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5478

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/pyproject.toml | 34 +++++++++++++++++++++++++++
 yocto_console_view/setup.py       | 49 ---------------------------------------
 2 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/yocto_console_view/pyproject.toml b/yocto_console_view/pyproject.toml
new file mode 100644
index 000000000000..3a417f4ffa3d
--- /dev/null
+++ b/yocto_console_view/pyproject.toml
@@ -0,0 +1,34 @@
+[build-system]
+requires = [
+    "setuptools>=80",
+    "setuptools-scm>=9",
+]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "yocto-console-view"
+authors = [
+    { name = "Richard Purdie", email = "richard.purdie@linuxfoundation.org" },
+]
+description = "Yocto Project Console View plugin."
+license = {text = "GPL-2.0-only"}
+version = "1.0.0"
+
+[project.entry-points."buildbot.www"]
+yocto_console_view = "yocto_console_view:ep"
+
+[project.urls]
+Homepage = "http://autobuilder.yoctoproject.org/"
+
+[tool.setuptools]
+include-package-data = false
+packages = [
+    "yocto_console_view",
+]
+
+[tool.setuptools.package-data]
+"yocto_console_view" = [
+    "static/*",
+    "static/assets/*",
+]
+
diff --git a/yocto_console_view/setup.py b/yocto_console_view/setup.py
deleted file mode 100644
index 604f4a50da30..000000000000
--- a/yocto_console_view/setup.py
+++ /dev/null
@@ -1,49 +0,0 @@
-#!/usr/bin/env python
-#
-# This file is part of Buildbot.  Buildbot is free software: you can
-# redistribute it and/or modify it under the terms of the GNU General Public
-# License as published by the Free Software Foundation, version 2.
-#
-# This program is distributed in the hope that it will be useful, but WITHOUT
-# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
-# details.
-#
-# You should have received a copy of the GNU General Public License along with
-# this program; if not, write to the Free Software Foundation, Inc., 51
-# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Copyright Buildbot Team Members
-
-try:
-    from buildbot_pkg import setup_www_plugin
-except ImportError:
-    import sys
-
-    print(
-        'Please install buildbot_pkg module in order to install that '
-        'package, or use the pre-build .whl modules available on pypi',
-        file=sys.stderr,
-    )
-    sys.exit(1)
-
-setup_www_plugin(
-    name='yocto-console-view',
-    description='Yocto Project Console View plugin.',
-    author=u'Richard Purdie',
-    author_email=u'richard.purdie@linuxfoundation.org',
-    url='http://autobuilder.yoctoproject.org/',
-    packages=['yocto_console_view'],
-    package_data={
-        '': [
-            'VERSION',
-            'static/*',
-            'static/assets/*',
-        ]
-    },
-    entry_points="""
-        [buildbot.www]
-        yocto_console_view = yocto_console_view:ep
-    """,
-    classifiers=['License :: OSI Approved :: GNU General Public License v2 (GPLv2)'],
-)

-- 
2.47.3

