Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272FCC282DC
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:25:32 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.10381.1741170321805090837
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:25:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aTSNnHiC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so18884375e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 02:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741170320; x=1741775120; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eg04w3vbnkTk5fL4VQwraFB5LVLLWgZMm+PF+J9RXA=;
        b=aTSNnHiC9oiCkPsKdUQXIqtlKbocUXf3jBCPfFfGvJoPCosoSazvNTbZpv/MY2g0CH
         +K1ssCSX4+q6/bfUle42PRzcpwcVeY36f+2H6bVZqM+qQOiSNLJh2gPM5xDYoV4+TmpA
         SbX9ReTYKNmdPDzs9WaEuLnwXa8gRexizHQsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170320; x=1741775120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eg04w3vbnkTk5fL4VQwraFB5LVLLWgZMm+PF+J9RXA=;
        b=Z4AOMsKi/WYvx1ZGbg1hcuTO2Vx4j62uzGkx0yBbH+txj8f6I8f1tOKqRWURije1OB
         RBqWc/uJdvyEI8r8cq5Y80AKWceOAKCQxDFJIwUk53Ci4MYNi3epdHFQAw4aY+qj4eoI
         gJ6xlfvDMBg2SpM7suM3Kq5xy1H5x0P+5Rm4EpVRGu0flwurx72+p0CZsGp1b4LYui+B
         9+gofJoOhcfQ7F4WUnXem1q9pvq6SBPXyk7XjTDxq1deO8IbFtEMP95u9Y48S7CGzoXK
         PMoady4yDaI5n+1yzJjFGmNEBLvaD35wR4fPDBAMiXvRo/bRI/qFJZ1mfIeOC5LqQXQV
         F6rw==
X-Gm-Message-State: AOJu0YxoyeibWXXfOZ0PA4GToxrtf/QDV+RX1ilWYJecAacNv7j2IBIt
	DMNndD3fq6sZ3OG3LS2WBmBpNi8kQYNDSlCCfxXrdSrLPR6bCUBY81DVggrDLYFXfSoGKQOV/zU
	d
X-Gm-Gg: ASbGnctGWHfoWDMBmmEiw4WUrR8bFWZedIwOddxL9Tpw/GLmU5vtu5UzUQgJL/WCfxR
	46T9FtB8/WV5MG5HIawAeGUUP9veCbCOum6QiXZeDNnvo0a1V9H/pU2UuzazHwngX7whbamMgpM
	BMIN11HYPTCKrGjVgsUHTW3q3xN2PGJtUyoBd0wQ8ri0Z3UHdFuE+9bBt6aIaoIwd1CqqHVQRkP
	wZbqFumrERh/BG7KEaYz2bEIalRhdmQ4G3ts/3txlRIioYiUNDZheux3m1RDsvfP/3cCpWjKMFl
	TkaMnDXg9SkZmn7iwqI2Ow85vY9rT/JibcWTrengQ9uXbGIwnmsOHWcr+WNcsoIDyfn7pPMBtA=
	=
X-Google-Smtp-Source: AGHT+IEDjcms7f8LBFHZUOdZEDA58saCnVp0KG63A8vWNBw7pyQ0EodT16iNAu/jOEPvytT/UY6AhA==
X-Received: by 2002:a05:600c:468e:b0:43b:bdf4:1c9 with SMTP id 5b1f17b1804b1-43bd2af4b26mr16867515e9.29.1741170319783;
        Wed, 05 Mar 2025 02:25:19 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm12973495e9.31.2025.03.05.02.25.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:25:18 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 10/11] config.json/utils: Disable buildtools and poky repo for indexing
Date: Wed,  5 Mar 2025 10:25:05 +0000
Message-ID: <20250305102506.2043524-10-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
References: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:25:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1154

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json        | 1 +
 scripts/run-config | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index adb85d1..cdcb2f8 100644
--- a/config.json
+++ b/config.json
@@ -1367,6 +1367,7 @@
             }
         },
         "indexing" : {
+            "NEEDEDREPOS" : [],
             "step1" : {
                 "shortname" : "Generate non-release index",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/generate-testresult-index.py ${BASE_SHAREDDIR}/pub/non-release/"]
diff --git a/scripts/run-config b/scripts/run-config
index fb71721..bf2855f 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -136,7 +136,9 @@ def addstepentry(name, taskdesc, shortname, description, detail, phase, usepty=F
         bbdesc = bbdesc + ": " + detail
     jsonconfig.append({"name" : name, "bbname" : bbname[:46], "phase" : phase, "description" : bbdesc, "usepty" : usepty})
 
-if jcfg:
+if args.target == "indexing":
+    pass
+elif jcfg:
     buildtools = utils.setup_buildtools_tarball(ourconfig, args.workername, None, checkonly=True)
     if buildtools:
         addentry("buildtools", "Setup buildtools tarball", "init")

