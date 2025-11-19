Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4B3CF395F
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9160.1763564757742807854
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=d9MS8VrU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-202511191505557500f511100002077c-vreu09@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202511191505557500f511100002077c
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xKNtNJ/MM0UhNyQ1RBuvO2KIyd0iUUIWNKUKCr5izH4=;
 b=d9MS8VrUrh+LinCDayHzKvXKqqQ0kTuk2GsLiOVLqcWKv/Q8Ms5qAXqFSWOSqgDNXTxlwy
 PYW8qKKfmpWSCC3njW6nXk/Rt9nSwRTXik0lHwGRbzdKNoLxzV4J6u9aFTMRfr5IjmJ3H6No
 dvgGzEHGyXhU/jGcWfTSCJKEsMMpaji3ACfw6LwPS92ANIwwjpe0S1sPycNBkKoC2/LJnuJA
 5oh4QRlSZ+KLiEAIGLB//rSb0QRWoqb6Ob7QnySpBseUxUNQeu/evKIMzRynyTB9D0vUKp7m
 EE8QgsW5AuZEDUQdK88dZOPgRi9rGvHIpu4zt1vujkUWktMqMSqnSNdA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 34/35] readme: update to markdown format
Date: Wed, 19 Nov 2025 16:05:21 +0100
Message-Id: <20251119150522.15477-35-peter.marko@siemens.com>
In-Reply-To: <20251119150522.15477-1-peter.marko@siemens.com>
References: <20251119150522.15477-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 15:05:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2612

From: Peter Marko <peter.marko@siemens.com>

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
index 1aa3809..0000000
--- a/README
+++ /dev/null
@@ -1,15 +0,0 @@
-"Mixin" layer for adding latest Go toolchain versions into the Yocto Project LTS.
-
-At the time Scarthgap was released in April 2024, Go 1.22 was the latest version
-and officially Scarthgap supports only that. This thin special-purpose mixin
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
index 0000000..47cc7b4
--- /dev/null
+++ b/README.md
@@ -0,0 +1,43 @@
+meta-mixins-lts - scarthgap/go
+==============================
+
+"Mixin" layer for adding latest Go toolchain versions into the Yocto Project LTS.
+
+At the time Scarthgap was released in April 2024, Go 1.22 was the latest version
+and officially Scarthgap supports only that. This thin special-purpose mixin
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
+'[meta-lts-mixins][scarthgap/go]' in the subject.
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

