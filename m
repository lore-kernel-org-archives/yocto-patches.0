Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E86CC6FD3A
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:09:55 +0000 (UTC)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
 by mx.groups.io with SMTP id smtpd.web10.5961.1724875790785705707
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=jYaniQSN;
 spf=pass (domain: konsulko.com, ip: 209.85.166.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-829e856a159so134851739f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875790; x=1725480590; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sd+S4roCRH/5pwCdFEuAlnHrnag6FLgXQtYNf9PPwlo=;
        b=jYaniQSNOUnzEZse2630RHysMCKx+PWfG3ezU69GBw3nROdPjv2oRq6pdL1wdujdI/
         C/8D8SNAFNprwaOYYXxEil57C0gm17Y8l/z4LBYF3ro/EvdHJGlHSYMTCvnoARHumiuF
         5St/XCrpoJIeJy7Xn9BnNWdjAKHYzsk4EZe5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875790; x=1725480590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd+S4roCRH/5pwCdFEuAlnHrnag6FLgXQtYNf9PPwlo=;
        b=DovlQMz29k9lzUMCdK+/BgENXTvl9eJytYYRea0bAPFKIEi/m3hI9F+FlR8nVx1dok
         QbxdU2XspfLTNw+IcRVp5FKmSCsrweGpT2dAd33Tpsue9qg1l9VPCiPkwCoP5BfZEqVr
         S+bclw4rESwaRMnOdqFbZBBxwlZts1fWbfv0LhG4kVp37sJ7PGRDpuAnUA1nYkeYvWrY
         SBo98Ob/7UJRz0Y68qqpD1hlEoV9vM09YHcRqedFLvUBbWBQqeVjqGDj9txRSQbYEUUb
         FgPnyU2NhlEwKCSeB57AEkYcCcTHvCVaV7268lIfMsSS1xBcOj+9kVnW/Bevl57G+fA9
         qNvQ==
X-Gm-Message-State: AOJu0Yz8g4Gvg2+C+pMEtc/SrAANsL8y6i/WVSwJEyOLr4FSVix2+gHE
	LsJPShfix58R6Bp4PwjWJYOHGOM1i3nPD1Ssh3jn3rniM3yBoxtFWgw4YtnpPbsXkmXgRWELIk3
	f
X-Google-Smtp-Source: AGHT+IGnZkQXYKcB9Zp6rFi7SN53r8qihyh6veAZQzuazSwJ1r5OvyXAxEMcBzcz3BGoP/zZvWICjw==
X-Received: by 2002:a05:6602:6c15:b0:81f:803d:cbe7 with SMTP id ca18e2360f4ac-82a110887d5mr80390439f.12.1724875789702;
        Wed, 28 Aug 2024 13:09:49 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 02/33]  packagegroup-rust-sdk-target: Add Rust SDK target packagegroup
Date: Wed, 28 Aug 2024 16:08:48 -0400
Message-ID: <0af4bf0ee9f2a3810a7bc89d8b23121242bf0577.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:09:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/569

From: Alex Kiernan <alex.kiernan@gmail.com>

Signed-off-by: Alex Kiernan <alex.kiernan@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 5bfa5bfa942a29f6670213933e456ed00c43a245)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../packagegroups/packagegroup-rust-sdk-target.bb   | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 recipes-core/packagegroups/packagegroup-rust-sdk-target.bb

diff --git a/recipes-core/packagegroups/packagegroup-rust-sdk-target.bb b/recipes-core/packagegroups/packagegroup-rust-sdk-target.bb
new file mode 100644
index 0000000..334b249
--- /dev/null
+++ b/recipes-core/packagegroups/packagegroup-rust-sdk-target.bb
@@ -0,0 +1,13 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+SUMMARY = "Target packages for the Rust SDK"
+
+inherit packagegroup
+
+RDEPENDS:${PN} = " \
+    rust \
+"
-- 
2.46.0


