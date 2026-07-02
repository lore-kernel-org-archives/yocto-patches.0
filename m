Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6ABC44501
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 04:45:41 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.62843.1782967532720040527
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 21:45:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=hk+SwzCM;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4629324e267so193394f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 21:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782967531; x=1783572331; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y8Qlx9Gi1+5cZqGdq5i223nty1/RTL99QPH+br8kJGw=;
        b=hk+SwzCMEm0nQlMCfRIa7gTgjAEgNpmv9wMtouUOksvkruvA4NXgisRjexsmfhLTX4
         yAhDzmQ/urmOYgk1NCb6F5nn/ZmKUtP178A+9yQcags6tGT+8IPJXuH1AXF8TRWkxcZL
         2ZDwtoVvRZbESQytbpPuo+/ShDdz9BlIKIprF5mPSvP5EuLcm5iO+xCGR++jfDz97b15
         cDQlQiZHbgF5a/48RoMFDKcXJ6yzKXXoYuiJBKEuTQTfWjyZaHCbSYNRv8+LqQMdADWK
         xofEHnPjQxC1nooXOkaeU2IeMDGxMPAvxh8R3DFEOYM87ADQ/ecND6fd96dc6OLwwiLo
         KMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782967531; x=1783572331;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8Qlx9Gi1+5cZqGdq5i223nty1/RTL99QPH+br8kJGw=;
        b=tL1sPmMrDpC5XBGl88LBPFnQYXG/tCUGayNIwSPv0i3biv1RM06RiNKqV7Mrw085qk
         LvusL1dbdvxVQEdECq8BWAvmWz0tkNEQOOyvkO7pEbem/PIG1SX/enwl2VI5gIfH9jmg
         4C+xB0G5/vh7kHWDc4oDAwFmCdkFw18/BgiE1wH88yRQCcHqG7xPtXKBTN9H+/oJLf7U
         CRCYFNJnBXT+tP0InORUda6dt1nI4vzVqpuAwxxwBGKXTl4yfyPhrI2fN9LTfHZ2MiUy
         f85zNoB2Q+qj9v7VqX+322vkjncYGrM0tYfchhl9CmLcFxgsV8f0ZVET/gSH6vdXPwOi
         rA3Q==
X-Gm-Message-State: AOJu0YzlZVNpCS/ZQLCF645vjYby1DICoSphL/YeXw6q/ngKudZmIxn8
	xfXECQelDlkvgm3/WQyZgOONS2Lujd0gT4fjK02kJ7qr71enHxLw3Zo+AY3Eh2fk
X-Gm-Gg: AfdE7clYhcLFXusxCsJXk8ydo1V6OlhxEIiw2bWZfEyE/TBwbP7xKF4AbBOPR+W+vmF
	cmuHCmwSUwdW4641MqiGoZW/xAiO4aii1S2ZnrobYziIQTIzviODQDCqATDAoqpHR9tGJKSo511
	g2QMs0zZItxetH7rVbZ1tQcXS1xEg53j02ZCNyyxKSD1lH2hW2/2oFQ+4hSzumrgpoeKyLchGvu
	gf8QEIn091VH3c28jDCl3es1kCR9vyyg+VynRBFSaqPup56m96OLqxtu8q9AlsfUPEVoFxX35TL
	Gx/51cIMUzqFDtpmFUjBwF9dNJpV43FJfJTRlGSEdUX1FwWJAElsFkp9mhtgdf9GM6N/ntBfMPI
	uDixiixF+b9mFmh8lzcboj7aJlRSjPhZqBK3i0juUBxODQd95yTIlRagDsxMHwSrdwWQspxnEvk
	+rem9Chwp3ZMlbDG9QdSNpj9rejh09PFN2qKYQWCFXv7csRfn1WQSaJwZ+BQ==
X-Received: by 2002:a05:600c:46c7:b0:493:bda2:8d92 with SMTP id 5b1f17b1804b1-493c2b906a2mr43763195e9.5.1782967530795;
        Wed, 01 Jul 2026 21:45:30 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:8a40:d7a5:890a:fa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm15405275e9.6.2026.07.01.21.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 21:45:30 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [PATCH 1/6] wic/help: Drop removed --infile option from help string
Date: Thu,  2 Jul 2026 06:44:19 +0200
Message-ID: <20260702044425.846351-2-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
References: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Jul 2026 04:45:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4354

The option --infile has been removed since commit 28129187482 (wic:
removed unused command line option).

A reference to removed option were dropped from usage string by commit
c967cb25c68 (wic: Add missing text to usage and help strings); but a
reference in help string has survived up to now.

This kills the very last reference to --infile removed option.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 src/wic/help.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/wic/help.py b/src/wic/help.py
index 7bc9d70..1d0284f 100644
--- a/src/wic/help.py
+++ b/src/wic/help.py
@@ -708,7 +708,6 @@ DESCRIPTION
        Create a new OpenEmbedded image
 
        usage: wic create <wks file or image name> [-o <DIRNAME> | ...]
-            [-i <JSON PROPERTY FILE> | --infile <JSON PROPERTY_FILE>]
             [-e | --image-name] [-s, --skip-build-check] [-D, --debug]
             [-r, --rootfs-dir] [-b, --bootimg-dir] [-k, --kernel-dir]
             [-n, --native-sysroot] [-f, --build-rootfs]
-- 
2.43.0


