Return-Path: <niels@nobi.life>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E927BC36010
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 06:48:18 +0000 (UTC)
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
 by mx.groups.io with SMTP id smtpd.web11.19449.1744354090052743319
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 23:48:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nobi.life header.s=google header.b=Xpbhw7CO;
 spf=pass (domain: nobi.life, ip: 209.85.128.98, mailfrom: niels@nobi.life)
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso11998645e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 23:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744354088; x=1744958888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g52dqjGRgWyMDk8fnsAypJUrHENb5yssRUQUH0nzUy0=;
        b=sJF4cmTGjR6VLKuNfaFzMjGrWruUlmbjOdOLbbdTaqoUWA0oKK8PJ8kxr6WUHWMUak
         2gjkuR/oQR2HdxhMec9s8gBnqLGP0NKWn4cP9KMbYTSfGLcUIv4jDx9UXbH4uzMNQe3I
         sCsu/GxLqj5kGZpkjUqQtw7h0DsSja8Sd2MbHf9YV0iN/v9cWgQHIqBLhZeqevK3Hk4V
         yrTGRzj8tnMvg3jGsR0sn25u6PRJUBZv+c4YhZ/OfROfnxVaHTd1szzPEjx4fgcrjUMT
         x8ozY+GRwwpilz9ldo9fyGtxbskFvqmnwEyT+jM24RnDl2sQBrb2AW8vVlvQhVTUJUSD
         4dlw==
X-Gm-Message-State: AOJu0YwT55Y4CPTwx9iI+LHO89nGlfnELzMyTI0NSNuzvFzD1BYUBfqR
	AxuZHAZwq86QZNQ1aR1g43CKVP5by4Sq9972r/s37EhxBXbshof7s6spc1plq10qgr0KC3EEAhu
	/GAGavTAJTXFpogA71wMTHIZ4xoKjYJYN1b6nBgGh
X-Gm-Gg: ASbGncv811weRScvBhqXYyTUOGIota8qkLx/3Pln5QKYJ6xFovg+tn5Mm3XBRKeIWwY
	AzpRMdWSbt/0O3lZjgFaoqbX2Bw7ZHwe0pGCCYL5Oaaqpr/KbvJFxDdOTqlMj3LAPxWIYGEYrGM
	Far6KtdkGrXRjK67do1nfbdMuhbBTiOT2f2UEjkt9czTFPbzRsb1RRMPpKVVyaw4xMk9yuIu2cG
	YR4/QE88tmT+ux6GBK3p2BftRdd64b5p3guey2NM5ZI0+mZMBx1QowBUGwywTsld+ea88KgDTI4
	I+QT6MTX8pvbNri6tafPQwXossjbQxz5xcKUaL6lkje57SbClE43PATFW/GhU/qLRx9h1g==
X-Google-Smtp-Source: AGHT+IGYfcdPM0jFsJ30/B/4pxEf7w/ROyskYXNjttF+9AhyTRgbwExmnIQsl5TDA0RYW0OgrnP1rNjKlnc8
X-Received: by 2002:a05:600c:3baa:b0:43d:fa58:8378 with SMTP id 5b1f17b1804b1-43f3a9afbb2mr7684415e9.33.1744354087401;
        Thu, 10 Apr 2025 23:48:07 -0700 (PDT)
Received: from smtpproxy-deployment-65bdf7d894-rdsqd.eu1.smtp.exclaimer.net ([20.50.220.147])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-39eaf440bd5sm55518f8f.86.2025.04.10.23.48.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:48:07 -0700 (PDT)
X-Relaying-Domain: nobi.life
Received: from mail-ej1-f69.google.com (209.85.218.69) by
	 smtpproxy-deployment-65bdf7d894-rdsqd.eu1.smtp.exclaimer.net
	 (20.50.220.144/28) with Exclaimer Signature Manager ESMTP Proxy
	 smtpproxy-deployment-65bdf7d894-rdsqd.eu1.smtp.exclaimer.net
	 (tlsversion=TLS12, tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Fri, 11
	 Apr 2025 06:48:07 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 4739595
X-ExclaimerImprintLatency: 2827170
X-ExclaimerImprintAction: d5ec2f20390a4f9592fddaa04d8e4206
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac3d3cd9accso144320166b.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 23:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nobi.life; s=google; t=1744354086; x=1744958886; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g52dqjGRgWyMDk8fnsAypJUrHENb5yssRUQUH0nzUy0=;
        b=Xpbhw7COfaEd690VE+ZZo0bf91e3UqxueQDuUVToSIqaUcu7MNS61pkH83PlxikBMB
         rc0qxeTGLC5/NihCvdVJwVgAEJyM+injfgQ1z6sg8KIxSuqyVmLz/RrjdU60rkzx8DBU
         2Xp4HrOrnO14RX7mttPEFcFA+zwjtr23LRn8o=
X-Received: by 2002:a17:907:3f19:b0:ac4:76e:cdc1 with SMTP id a640c23a62f3a-acad349eb53mr115459066b.21.1744354086163;
        Thu, 10 Apr 2025 23:48:06 -0700 (PDT)
X-Received: by 2002:a17:907:3f19:b0:ac4:76e:cdc1 with SMTP id a640c23a62f3a-acad349eb53mr115457566b.21.1744354085767;
        Thu, 10 Apr 2025 23:48:05 -0700 (PDT)
Received: from localhost.localdomain (118.6-200-80.adsl-dyn.isp.belgacom.be. [80.200.6.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be8d19sm390257666b.45.2025.04.10.23.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 23:48:05 -0700 (PDT)
From: Niels Avonds <niels@nobi.life>
To: yocto-patches@lists.yoctoproject.org
Cc: Niels Avonds <niels@nobi.life>
Subject: [meta-lts-mixins][kirkstone/go][PATCH] go: upgrade 1.24.1 -> 1.24.2
Date: Fri, 11 Apr 2025 08:48:02 +0200
Message-Id: <20250411064802.1473179-1-niels@nobi.life>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Apr 2025 06:48:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1359

Upgrade to latest 1.24.x release [1]:

$ git --no-pager log --oneline go1.24.1..go1.24.2
49860cf92a (tag: go1.24.2) [release-branch.go1.24] go1.24.2
f3a302358f [release-branch.go1.24] testing: detect a stopped timer in B.Loop
1d755aa488 [release-branch.go1.24] testing: detect early return from B.Loop
9204aca6c2 [release-branch.go1.24] testing: separate b.Loop counter from b.N
0ae3ca0a20 [release-branch.go1.24] runtime: explicitly disable async preempt for internal/runtime
dae59b594c [release-branch.go1.24] runtime: skip TestCgoCallbackPprof on platforms with broken profiling
b7fd97ae3e [release-branch.go1.24] runtime: only set isExtraInC if there are no Go frames left
311096a6a2 [release-branch.go1.24] go/types,types2: allocate the used* maps in initFiles
e9162e7e22 [release-branch.go1.24] go/types,types2: externalize used objects
d107ee90df [release-branch.go1.24] testing: allow manual timer control in testing.B.Loop
213f1566ee [release-branch.go1.24] internal/godebugs: fix changed version for winsymlink and winreadlinkvolume to 1.23
ac1f5aa3d6 [release-branch.go1.24] net/http: reject newlines in chunk-size lines
fd29397dca [release-branch.go1.24] net/http: don't modify caller's tls.Config.NextProtos
4524009ba6 [release-branch.go1.24] runtime: Added usage example for the runtime.AddCleanup() function.
bd1bc8a6e7 [release-branch.go1.24] crypto/tls: allow P-521 in FIPS 140-3 mode and Go+BoringCrypto
c2a34bedee [release-branch.go1.24] cmd/compile: use inline-Pos-based recursion test
0ace2d8aca [release-branch.go1.24] cmd/compile: fix out of memory when inlining closure
e4119e9b74 [release-branch.go1.24] all: updates vendored x/net

Fixes CVE-2025-22871

[1] https://github.com/golang/go/compare/go1.24.1...go1.24.2

Signed-off-by: Niels Avonds <niels@nobi.life>
---
 recipes-devtools/go/{go-1.24.1.inc => go-1.24.2.inc}        | 2 +-
 ...o-binary-native_1.24.1.bb => go-binary-native_1.24.2.bb} | 6 +++---
 ...cross-canadian_1.24.1.bb => go-cross-canadian_1.24.2.bb} | 0
 .../go/{go-cross_1.24.1.bb => go-cross_1.24.2.bb}           | 0
 .../go/{go-crosssdk_1.24.1.bb => go-crosssdk_1.24.2.bb}     | 0
 .../go/{go-runtime_1.24.1.bb => go-runtime_1.24.2.bb}       | 0
 recipes-devtools/go/{go_1.24.1.bb => go_1.24.2.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.24.1.inc => go-1.24.2.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.24.1.bb => go-binary-native_1.24.2.bb} (78%)
 rename recipes-devtools/go/{go-cross-canadian_1.24.1.bb => go-cross-canadian_1.24.2.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.24.1.bb => go-cross_1.24.2.bb} (100%)
 rename recipes-devtools/go/{go-crosssdk_1.24.1.bb => go-crosssdk_1.24.2.bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.24.1.bb => go-runtime_1.24.2.bb} (100%)
 rename recipes-devtools/go/{go_1.24.1.bb => go_1.24.2.bb} (100%)

diff --git a/recipes-devtools/go/go-1.24.1.inc b/recipes-devtools/go/go-1.24.2.inc
similarity index 91%
rename from recipes-devtools/go/go-1.24.1.inc
rename to recipes-devtools/go/go-1.24.2.inc
index 4cf66e7..cb4ae9e 100644
--- a/recipes-devtools/go/go-1.24.1.inc
+++ b/recipes-devtools/go/go-1.24.2.inc
@@ -17,4 +17,4 @@ SRC_URI += "\
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
     file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
 "
-SRC_URI[main.sha256sum] = "8244ebf46c65607db10222b5806aeb31c1fcf8979c1b6b12f60c677e9a3c0656"
+SRC_URI[main.sha256sum] = "9dc77ffadc16d837a1bf32d99c624cb4df0647cee7b119edd9e7b1bcc05f2e00"
diff --git a/recipes-devtools/go/go-binary-native_1.24.1.bb b/recipes-devtools/go/go-binary-native_1.24.2.bb
similarity index 78%
rename from recipes-devtools/go/go-binary-native_1.24.1.bb
rename to recipes-devtools/go/go-binary-native_1.24.2.bb
index ffe3d50..690b854 100644
--- a/recipes-devtools/go/go-binary-native_1.24.1.bb
+++ b/recipes-devtools/go/go-binary-native_1.24.2.bb
@@ -9,9 +9,9 @@ PROVIDES = "go-native"
 
 # Checksums available at https://go.dev/dl/
 SRC_URI = "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;name=go_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] = "cb2396bae64183cdccf81a9a6df0aea3bce9511fc21469fb89a0c00470088073"
-SRC_URI[go_linux_arm64.sha256sum] = "8df5750ffc0281017fb6070fba450f5d22b600a02081dceef47966ffaf36a3af"
-SRC_URI[go_linux_ppc64le.sha256sum] = "0fb522efcefabae6e37e69bdc444094e75bfe824ea6d4cc3cbc70c7ae1b16858"
+SRC_URI[go_linux_amd64.sha256sum] = "68097bd680839cbc9d464a0edce4f7c333975e27a90246890e9f1078c7e702ad"
+SRC_URI[go_linux_arm64.sha256sum] = "756274ea4b68fa5535eb9fe2559889287d725a8da63c6aae4d5f23778c229f4b"
+SRC_URI[go_linux_ppc64le.sha256sum] = "5fff857791d541c71d8ea0171c73f6f99770d15ff7e2ad979104856d01f36563"
 
 UPSTREAM_CHECK_URI = "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX = "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.24.1.bb b/recipes-devtools/go/go-cross-canadian_1.24.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.24.1.bb
rename to recipes-devtools/go/go-cross-canadian_1.24.2.bb
diff --git a/recipes-devtools/go/go-cross_1.24.1.bb b/recipes-devtools/go/go-cross_1.24.2.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.24.1.bb
rename to recipes-devtools/go/go-cross_1.24.2.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.24.1.bb b/recipes-devtools/go/go-crosssdk_1.24.2.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.24.1.bb
rename to recipes-devtools/go/go-crosssdk_1.24.2.bb
diff --git a/recipes-devtools/go/go-runtime_1.24.1.bb b/recipes-devtools/go/go-runtime_1.24.2.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.24.1.bb
rename to recipes-devtools/go/go-runtime_1.24.2.bb
diff --git a/recipes-devtools/go/go_1.24.1.bb b/recipes-devtools/go/go_1.24.2.bb
similarity index 100%
rename from recipes-devtools/go/go_1.24.1.bb
rename to recipes-devtools/go/go_1.24.2.bb
-- 
2.34.1


