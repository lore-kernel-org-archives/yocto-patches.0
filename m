Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE54CD6E52
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23163.1763038637499928743
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=BOrivb8d;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-20251113125715513c7fdeb1000207d9-mceph_@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251113125715513c7fdeb1000207d9
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3xe4ELcFiRqFjVwYRdFpHcPp5WdpzFj6KSFgXR3e75c=;
 b=BOrivb8de96IBSxTQaprtFeiD5hvzBEG1fo1rGay2IRyCztmnuLSHGAuVSfk4oyP8qkkYV
 oi6QYgpkNGTP2sHKyFg61Yo1e8pQwGTIE6UuOz3KXLRULW2ddFAEeDnF1HPdqKXycGv7f8rk
 Ni0yjQl6PlPWWgbZMqbcVIxwrgnsZPVMX73zfvQrAXU33wWm2uX7q+iSWZf+5CXBMlXrR0jr
 ZzePZvTEDBdezmcSIZ5eHgIQAGXnkB1FczOvQchkrH7uaParn1ZtxhIEYAhN6tffCFhVe7ba
 72fZQwBBBWDEa/A7QBBJLkvz/qlmRTVGlVn1RFYLVIF6smi69Dmc/UYQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 33/34] readme: update to markdown format
Date: Thu, 13 Nov 2025 13:57:11 +0100
Message-Id: <20251113125712.18914-34-peter.marko@siemens.com>
In-Reply-To: <20251113125712.18914-1-peter.marko@siemens.com>
References: <20251113125712.18914-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:57:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2539

Changes are inspired by scarthgap/rust README.md file.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 README    | 15 ---------------
 README.md | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 15 deletions(-)
 delete mode 100644 README
 create mode 100644 README.md

diff --git a/README b/README
deleted file mode 100644
index 9e270f2..0000000
--- a/README
+++ /dev/null
@@ -1,15 +0,0 @@
-"Mixin" layer for adding latest Go toolchain versions into the Yocto Project LTS.
-
-At the time Kirkstone was released in April 2024, Go 1.22 was the latest version
-and officially Kirkstone supports only that. This thin special-purpose mixin
-layer is meant to address this issue by backporting Go recipes from the master
-branch of openembedded-core.
-
-The patches can be backport from openembedded-core with:
-
- git -C ../openembedded-core format-patch --stdout -1 origin/master meta/recipes-devtools/go | \
- git am --signoff -p4 --directory=recipes-devtools/go
-
-Maintainers:
-Jose Quaresma <jose.quaresma@foundries.io>
-Peter Marko <peter.marko@siemens.com>
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..e316fc6
--- /dev/null
+++ b/README.md
@@ -0,0 +1,43 @@
+meta-mixins-lts - scarthgap/go
+==============================
+
+"Mixin" layer for adding latest Go toolchain versions into the Yocto Project LTS.
+
+At the time Kirkstone was released in April 2024, Go 1.22 was the latest version
+and officially Kirkstone supports only that. This thin special-purpose mixin
+layer is meant to address this issue by backporting Go recipes from the master
+branch of openembedded-core.
+
+Dependencies
+------------
+
+This layer depends on:
+
+- URI: git://github.com/openembedded/openembedded-core.git  
+  layers: meta  
+  branch: scarthgap
+
+Contributing
+------------
+
+The patches can be backported from openembedded-core with:
+
+ git -C ../openembedded-core format-patch --stdout -1 origin/master meta/recipes-devtools/go | \
+ git am --signoff -p4 --directory=recipes-devtools/go
+
+The yocto-patches mailinglist (yocto-patches@lists.yoctoproject.org) is used
+for questions, comments and patch review. It is subscriber only, so please
+register before posting.
+
+Send pull requests to yocto-patches@lists.yoctoproject.org with
+'[meta-lts-mixins][scarthgap/rust]' in the subject.
+
+When sending single patches, please use something like:
+git send-email -M -1 --to=yocto-patches@lists.yoctoproject.org --subject-prefix='meta-lts-mixins][scarthgap/go][PATCH'
+
+Maintenance
+-----------
+
+Layer maintainers:
+* Jose Quaresma <jose.quaresma@foundries.io>
+* Peter Marko <peter.marko@siemens.com>

