Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057B2CD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 12:42:25 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44467.1781181740455449408
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Jun 2026 05:42:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=q9dmB40Q;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-915d17e2721so562206585a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781181739; x=1781786539; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQPocA3UK3mlwdbxd4nT64dacnzcV3nE50BN+nCKi8M=;
        b=q9dmB40Q5QWz+dkb2FU9Q/SDor/XcYPT7XSGJZmRRs+zIow2r58EgugPjjAjMi4qXk
         zvomZajJZ4yqHHm14duOF+bddLt6kOFxeU063/rok+xhru/S7EpJLBnsjtb88IAhK6PG
         VqPjktvKWztQweXtXmSLgpmj9C0y4L1/8MYrbqI3TkzedCZ3/BHxsSQhkeeIDykkBAbL
         ZUKwjorqCM6LtkA1BQp0WatljldSl+ftFKepYjSdD1Si9ntI1Y4yFBMijDiBCkuRkMsB
         t/ERxC8tLkbkuM2qp1chLDc13uUq10iErJ6HyL81rdxu/kmMeV/0ckMT0W1KUULL3RqH
         mj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181739; x=1781786539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQPocA3UK3mlwdbxd4nT64dacnzcV3nE50BN+nCKi8M=;
        b=La7sISs5UzQSceaYjQSlN0wvFnuGaGqY+BGgeLzKQKktFpp6JT5fdfGjIYN3iuWGME
         bf2CKkKDRkXA8se9G7OD+Z0QSADD/chHNmTziKQOFlmFcuGp3fDBU81o9Rra6rU7Kdx9
         BNoldxdKpOFWlpZDY+DwNqWvxZR+f3KTp4ynzW5qxsDY9PUIoWRA26PlxqwGjsH3vBPJ
         nhV2X6xDtv2QbYqab7+1sRcBIhhG0KOENr49MRxrUHwILxr7w3IQZE55ELZ1QOW2jMmi
         BED4XmKPyLuHIOg8BSfqD2t5InfPgo18aLrSO4mupse7VJ4ekNxscTGPgQwaQAGqhlE4
         FTgg==
X-Gm-Message-State: AOJu0YzVFp5XOtR7uskumgC5GW1GCewqJABg1c7SRpDuEY7RKjrjqsFQ
	uFTtVE5Y3CptJR0wk0jKW0NOML+SjAIU7IQkkgmX3tTUJ1kbVUv7yqavh6COkw==
X-Gm-Gg: Acq92OGqPLWYTIavH+GjwgRpMG7/Y/o3czyiH1yQ1wheYHzJ1ilCWNlpP7VqqqxlKpk
	BJ2hI8rOyvk9IiW64xLxcvscVsG+ODALsYLfFUwIIwVQr1wLQ/Uz7frLuR5FjCYFLNilOM1zqFC
	sZAhSwsVeOyMqgRj1gBGXGD2Uvebp6hN/5I+VhPAdgEQpXq0ZbTkXq6h1XNFvreKzPDUsG99m+M
	B8fJdY3HSji/xnyaZw1D2nVoR8ikIfvN3xNeDLKCB/zt9ToEtHnr2f+vQ8s4T5o98DQzWbz1FAz
	aj3qxUlF5tgHWriNil+ROPH/Psr/HiNdMhLEU/NpDiPF+phdyasOf9LPW7dQbM6AmCXZAhWeviC
	ly+0sX3vzpQPuucPg3uW/bRKyzkLW7Jel9hhNePnm5MYL1V/19Cls7sVReZxBrl1br7x68N90j+
	Gur1dM3Gtu4YVCvvAkzPFxzU4lqRF/8r6gTQr6O8sN52nWJFS/tDUsyFI6DG2javkuP0mxGyvQo
	nRM
X-Received: by 2002:a05:620a:2783:b0:914:9ecb:9adb with SMTP id af79cd13be357-9160b05c6b8mr365467785a.50.1781181739379;
        Thu, 11 Jun 2026 05:42:19 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160ae26238sm173315785a.33.2026.06.11.05.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:42:18 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com
Subject: [wic][PATCH] README.md: literal cleanups
Date: Thu, 11 Jun 2026 08:42:08 -0400
Message-ID: <20260611124208.3292869-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 12:42:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4210

Using ```bash works in almost all markdown renderers, but unfortunately
does not work on git.yoctoproject.org. Instead it inserts "bash" at the
start of any such literal code block that uses it.

Technically a code block in markdown requires 4 spaces, not 3. Therefore
the "git send-email ..." command would not be offset correctly in most
markdown renderers. Either add another space, or delimit with ``` to
match the other code blocks; I chose the latter.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 README.md | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/README.md b/README.md
index 32590195fae1..75229421763c 100644
--- a/README.md
+++ b/README.md
@@ -10,33 +10,33 @@ environment file or folder (generated via `bitbake -c rootfs_wicenv
 ### Using wicenv (one environment file)
 1. Ensure you have a BitBake-generated `<image>.env` file (from `rootfs_wicenv`).
 2. Install locally for development:
-   ```bash
+   ```
    hatch shell
    ```
 3. Run the CLI:
-   ```bash
+   ```
    hatch run wic --vars /path/to/<image>.env --help
    ```
 
 ### Using wicenv (environment folder)
 1. Ensure you have a folder with BitBake-generated `<image>.env` files (from `rootfs_wicenv`).
 2. Install locally for development:
-   ```bash
+   ```
    hatch shell
    ```
 3. Run the CLI:
-   ```bash
+   ```
    hatch run wic --vars /path/to/envfiledir --help
    ```
 
 ### With bitbake
 1. Ensure you have bitbake available in your PATH.
 2. Install locally for development:
-   ```bash
+   ```
    hatch shell
    ```
 3. Run the CLI:
-   ```bash
+   ```
    hatch run wic --help
    ```
 
@@ -63,7 +63,9 @@ recipients.
 
 When generating the patches manually, this will generate what's expected:
 
-   git send-email -M -1 --to yocto-patches@lists.yoctoproject.org --cc twoerner@gmail.com --subject-prefix='wic][PATCH'
+```
+git send-email -M -1 --to yocto-patches@lists.yoctoproject.org --cc twoerner@gmail.com --subject-prefix='wic][PATCH'
+```
 
 Nothing, except running `b4 send` to actually send the patches, needs to be done
 when using [b4](https://b4.docs.kernel.org/).
-- 
2.51.0


