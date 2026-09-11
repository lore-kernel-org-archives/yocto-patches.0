Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AABC88E53
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:17 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48537.1789157647604786529
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NXiFeWvZ;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5218927884fso20259031cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157646; x=1789762446; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xjw98cBXr4Spwat0QK5ITNPpY9uDEqLDqNz99HZnnNY=;
        b=NXiFeWvZmPRZ+TlN1iRn/4ATiWnsBEYhTT0XhZ4F2xLvF5omq7tWAMZb5KJOrOTSrr
         rxNvRVkEpZ5IeoIXK78khWcfrfdsjwbxDE9N34qE8nZsnhAgOBd9TSKi61Y8oqQcO+Wp
         7sgfD/HrycDi+TKjrQXsvoim7c4sPvbSBOrzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157646; x=1789762446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xjw98cBXr4Spwat0QK5ITNPpY9uDEqLDqNz99HZnnNY=;
        b=KHvRjMBqcTX0DAiYhq6WXEKfnHvGfs45JMFEhZD9W+V44IISEtJdOquvzkxG3GGGqJ
         KC+iau73Q+XixNUPodfO6pPgblJto58UILAEoWrVPi1678lTRIAyMsT4CVrr8KjBevwr
         eHYiQ9sfJHiFg0Cfc3J1Xezq2XUGstnijjDHUlEosqpZucPSseSptnkQlutLuVi8HOjr
         HsjbFulSTQBW44tJQ9SE7PAZIPW/58Mp/wYtVNZUjE1eII8XiscWy5WV5fBfV4umpWDz
         ws0a4D+FsPhQp9o45l41HZN7xUmvXO3JzzTicawONlYMsebNai+ivhxg+kEnHujFOfCK
         J/Ag==
X-Gm-Message-State: AFuF++lwyvf/6zj/qioVm5k87y6KsHVXFuA7kyRojq8eZeZDdAZNscRb
	+VylVYuHc6U8VtQ6runloLLqphR98pmQ07Hegfzkn0ZxFvB1I+K1OpR3RKWByvSPluasUQnw5wq
	SSIa6
X-Gm-Gg: AYBFou2QQ85kZAvTGxOPQpYrbCd8X7456vHX8SOaD4GZFnq3E6NxopY/8jqQhLXoP5E
	oBzcPUocaSLmkvmtb+385qyv3uvIKWKGYoWYfwXzr4GfcxkEfcGVwwYrrNQGNVVC79hOZb0enmV
	DUwbGngwqrEIpIN4B6A7u55iu5RA1dszhPtXO4y+lyLPegDWoAFla5EHnuZhOcSNgUJFiNr+QeI
	X/Jr/iggvMA303gTfQlsYkXTbl53H/LG9d6DiCMaggUfO1U0anuAz++f7iWVDnDtHayH+ZBfjBw
	oFZLGW1J0VbCnUYjAPRVlasP+C/ocWGz7BiJSCwDS16lECLco/xDi22yOopdxOWBi73HCaXU7mA
	PgIMGQbmSL7dcimrLScXk7kCINEGMarEascYcTV7LwqZEpSao1In7BeGgIboDH8Yb2vzm2XsG6w
	F8ZGEsOt/di7pOorAOp4W8+eC1oFnAWDvqKw5yVFphP6QiWn08slvHAOBLHwwXw500HF7rtvKyt
	AnYE1JVYWvfSMQOzFVxmclEg+3UOgWPmBCqK9icwLymzArVsheu5X6d5GICSWySsD+MS/KkzPwg
	22oCso+yrk2gp52kZtl4NVfa1dBWtiA5Jv+euYMskCVS3Q==
X-Received: by 2002:a05:622a:1e10:b0:530:de20:2bdb with SMTP id d75a77b69052e-530de203e9cmr42791421cf.29.1789157646432;
        Fri, 11 Sep 2026 13:14:06 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.14.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:14:06 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 30/37] classes-recipe: fix trailing whitespace
Date: Fri, 11 Sep 2026 16:13:16 -0400
Message-ID: <772b2a832bcf65188901c81909b597782b349ae7.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4796

From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>

Fix trailing whitespace in classes-recipe bbclass files to resolve
bitbake parsing warnings.

Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 3aa7dfc7d409194639b52cc3fb7d3f5dcc85b3b6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/ptest-cargo.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes-recipe/ptest-cargo.bbclass b/classes-recipe/ptest-cargo.bbclass
index 2e008b3..62444e9 100644
--- a/classes-recipe/ptest-cargo.bbclass
+++ b/classes-recipe/ptest-cargo.bbclass
@@ -107,7 +107,7 @@ python do_install_ptest_cargo() {
             f.write("#!/bin/sh\n")
         else:
             f.write(f"\necho \"\"\n")
-            f.write(f"echo \"## starting to run rust tests ##\"\n")               
+            f.write(f"echo \"## starting to run rust tests ##\"\n")
         f.write("if [ -z \"$rc\" ]; then rc=0; fi\n")
         for test_path in test_paths:
             script = textwrap.dedent(f"""\
@@ -120,7 +120,7 @@ python do_install_ptest_cargo() {
                 fi
             """)
             f.write(script)
-        
+
         f.write("exit $rc\n")
 
     if not script_exists:
-- 
2.55.0


