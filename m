Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE16CAC5B0
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 09:35:50 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.12609.1758620143935355644
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Sep 2025 02:35:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HCW7+86K;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e1cf9fbe6so7221845e9.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Sep 2025 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758620142; x=1759224942; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7guJDX5p+FYwnxjb+bK89z+sB5SbcpUBfZ21AEqHjg0=;
        b=HCW7+86K0a6yXGQpKCdoKjQUFb20RBh9wWiE+F1LwMQZqTuwbKuzrQZ/UOLDfToxhi
         9uovxE4mwbjUZZ0J2yj7T/uuO9V4eRqpW/D/eKdyKv7Rg0S2P9tT7RKv8krp5phm9+H7
         pllsGguhwjNxNSzMTPzKSPnSJSqnPTDOKsiCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620142; x=1759224942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7guJDX5p+FYwnxjb+bK89z+sB5SbcpUBfZ21AEqHjg0=;
        b=hHgcZ3HKom1yTcbO+H+vp91xg4rt16UbtNhM677TtYRxpq1jl2KwAOiaqBJRu96SRM
         t7sb5+DHYiUqcETkm5bAINTxh4jXPGHpDtF46AL6ftWANYhCig0eW3Og9GMH13sPUl7t
         /GykiwA2xKuySRcA3PVWGBIYu+qnm1Kzl1ZbscJyBGV5RcBncvtIOJBWQzIrBSL2WWNB
         N8eUBZI6hUytATIw0RA8b6KhXqzD6LlQuMkl227GvjxHQMO2IEcFIw0/IOgyyVqgfCjT
         q9GM3zsuqfOJEBj3zT3Mt1i+R2X3+AL7KdFyVkyBaGn2UQieoKqD1zeOty6eosGWcas6
         ETOw==
X-Gm-Message-State: AOJu0YymvlRcOAsWC8X+gEt96L1PyNZi63SDAE9stc7Z79VBKOs4gPuM
	ASkP320Jp7WWPBp0VsduwKbTv5uaRn54qXlRgUwdA8MmAlGqwTWpG/eCaNy5SA817n53hncPmBj
	JXSru
X-Gm-Gg: ASbGncvVrl/NxMxvG//fhxGe5y7H40H8Pu/vJC7uPRdLy+UD/wcKFlYBwqUXDZrxcKE
	SR16fzovwjt9zHR3N9OOEDwfpME1kS+fgH5ocvYgmSzEPmTg56r9Ezn4kz/mLhbdPfsroJYnaoU
	8k0OJlC9Wh6711fqj1XML/psy4X1K4R+iGtz7oHEpRzwKFv8DGiQtFqX/YDVL0V6oMu878+DyBV
	XIbIyyaaWM0iwDVmhqUx6vPKFG5PPk+bR9e2wZIF/u3r/3LDPg46oEB1GaUe1sszKLyz26X+YRU
	kZ4XBb7Pr3WT24XNP7OwmKh0nIKPd0ZWbH3X3MKppROioGW0zF15cmeMP7FAM8uxY9XaCrLjqYE
	F3jFZe/Jk0p5RKRrGYejG2cRWyjfSdiGqBSiU1KQ/taRcbsioUKY=
X-Google-Smtp-Source: AGHT+IEYKsgjwXBfew0btQgV3LrsGgmrfHzTvBsga1D216zE2lCBAQbitjHdREzxtXakzonx/7aaDw==
X-Received: by 2002:a05:600c:a06:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-46e1d99517amr19490095e9.4.1758620141695;
        Tue, 23 Sep 2025 02:35:41 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fe09:3ae7:900c:f751])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d33633bsm282125795e9.11.2025.09.23.02.35.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:35:40 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Remove obsolete eclipse references
Date: Tue, 23 Sep 2025 10:35:39 +0100
Message-ID: <20250923093539.2384514-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Sep 2025 09:35:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2233

We stopped building eclipse plugins a long time ago. Remove
the remaining references.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/config.json b/config.json
index 16ff72f..90cb791 100644
--- a/config.json
+++ b/config.json
@@ -1508,23 +1508,6 @@
                 ]
             }
         },
-        "eclipse-plugin-neon" : {
-            "NEEDREPOS" : ["eclipse-poky-neon"],
-            "WRITECONFIG" : false,
-            "SENDERRORS" : false,
-            "EXTRAPLAINCMDS" : [
-                "cd scripts; ./setup.sh; ECLIPSE_HOME=`pwd`/eclipse/ ./build.sh neon-master master development"
-            ]
-
-        },
-        "eclipse-plugin-oxygen" : {
-            "NEEDREPOS" : ["eclipse-poky-oxygen"],
-            "WRITECONFIG" : false,
-            "SENDERRORS" : false,
-            "EXTRAPLAINCMDS" : [
-                "cd scripts; ./setup.sh; ECLIPSE_HOME=`pwd`/eclipse/ ./build.sh oxygen-master master development"
-            ]
-        },
         "buildperf-debian11" : {
             "TEMPLATE" : "buildperf"
         },
@@ -1818,20 +1801,6 @@
             "revision" : "HEAD",
             "no-layer-add" : true
         },
-        "eclipse-poky-neon" : {
-            "url" : "ssh://git@push.yoctoproject.org/eclipse-yocto",
-            "branch" : "neon-master",
-            "revision" : "HEAD",
-            "checkout-dirname" : ".",
-            "no-layer-add" : true
-        },
-        "eclipse-poky-oxygen" : {
-            "url" : "ssh://git@push.yoctoproject.org/eclipse-yocto",
-            "branch" : "oxygen-master",
-            "revision" : "HEAD",
-            "checkout-dirname" : ".",
-            "no-layer-add" : true
-        },
         "meta-mingw" : {
             "url" : "ssh://git@push.yoctoproject.org/meta-mingw",
             "branch" : "master",

