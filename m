Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB57CF394D
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9146.1763564756222933574
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=J+GWjx7z;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-20251119150554cbb0bbd71000020790-dtlwqe@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251119150554cbb0bbd71000020790
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2INf2orSiUTKc0yKfw2edclAJRXbVzxVBXnxWi/rYmM=;
 b=J+GWjx7zoDsxhZX07mCiWQvsOZuI2Ku7VRhLVrfFpwg4WbX8RaPpdKMtxjOnvzykB8YZrD
 VsIm0st6/m4Ety59ShFq0E3x2lfz78o148hJMT+P5Yi0lhCPUyCR1kmrT7dq+FWp/RMz6hcy
 8ngEUWv5dDx8PBm0PvuDQsXuwrIJvKdRpysp5WD8Rc7oc7Ispip2XZm7uVl8ATK5ROKUzQnk
 JpFoa3SfeiwQCaIFBYqgn2qXkJtaYt2T+iva5HNzxeHBXeJgAT62YGbKz7mzxT8zmr6KLOax
 IQXlBzbZ/Fy6nL9gi97vZ3akQ9qIKnTl/jpMz0tUHDTsidr1SPXldMUA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 02/35] go-helloworld: add from openembedded-core scarthgap
Date: Wed, 19 Nov 2025 16:04:49 +0100
Message-Id: <20251119150522.15477-3-peter.marko@siemens.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2594

From: Peter Marko <peter.marko@siemens.com>

This allows a quick smoke test for whether go toolchain produces
working executables.

Last release where go-helloworld recipe was identical on scarthgap and
master is yocto-5.0.11. Afterwards license was fixed on scarthgap and
no further updates were done.
* fa45d6d5bec8fe503ff6b9166a3b4af31ea95369 go-helloworld: fix license
This commit is missing on master and will be submitted there.

Version copied here is from yocto-5.0.11 as a clean cherry-pick base.
* https://git.openembedded.org/openembedded-core/tree/meta/recipes-extended/go-examples?h=yocto-5.0.11

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 .../go-examples/go-helloworld_0.1.bb          | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 recipes-extended/go-examples/go-helloworld_0.1.bb

diff --git a/recipes-extended/go-examples/go-helloworld_0.1.bb b/recipes-extended/go-examples/go-helloworld_0.1.bb
new file mode 100644
index 0000000..98cd4d8
--- /dev/null
+++ b/recipes-extended/go-examples/go-helloworld_0.1.bb
@@ -0,0 +1,22 @@
+SUMMARY = "This is a simple example recipe that cross-compiles a Go program."
+SECTION = "examples"
+HOMEPAGE = "https://golang.org/"
+
+LICENSE = "MIT"
+LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
+
+SRC_URI = "git://go.googlesource.com/example;branch=master;protocol=https"
+SRCREV = "d9923f6970e9ba7e0d23aa9448ead71ea57235ae"
+UPSTREAM_CHECK_COMMITS = "1"
+
+GO_IMPORT = "golang.org/x/example"
+GO_INSTALL = "${GO_IMPORT}/hello"
+
+export GO111MODULE="off"
+
+inherit go
+
+# This is just to make clear where this example is
+do_install:append() {
+    mv ${D}${bindir}/hello ${D}${bindir}/${BPN}
+}

