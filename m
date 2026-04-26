Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE629FF8850
	for <webhook@archiver.kernel.org>; Sun, 26 Apr 2026 21:30:40 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28035.1777239037311717072
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 Apr 2026 14:30:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qP/W2QWr;
 spf=pass (domain: gmail.com, ip: 209.85.214.169, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9a9be502so59309125ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 26 Apr 2026 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777239036; x=1777843836; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/3r8jWNNkbF/f3vpF/ZiHCshJvbeDTZjh/qjCg8GzE=;
        b=qP/W2QWr6pVp/pwN9KIxOOf7cDD0bnkan0RDXmvtCJc+0MBtIOg2MOm7uMbkYYMgZv
         VGbLmsj02HZIbcFr5SDMBXFmsfPSzkIFm1VreMPpOLncMtA0b4u5k8QMJKUYJC314ivS
         /CXAeLyHU/4nzf3mTz+cupa7FvTYQsV4pDc4zapXJ9Y5nfLpOCkiodIOHsKucgM0eP31
         S7esZHgr/M0fwUi+Co9np7iD2+o8hs0dUeuSkDvCebN6NA04qEJ1Eml21TkhUc/R5FPD
         tVG0mLhwL8w+UWy/tgxjXgnHh3DGok5QrzJufgLvrs5VTQz/oqlU/1s854Df0o2xGU+Z
         L8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777239036; x=1777843836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/3r8jWNNkbF/f3vpF/ZiHCshJvbeDTZjh/qjCg8GzE=;
        b=rM/EMx92kcsDxiDAGZihK82YPc8ec+TQxCY1xYnueANozXaXBRXbKWh+wNIvcEOeRS
         3cjn2V/nlDYVj8bos/GN7OWWodpVpkrYVPB0JfwuQFKuCFGWR0Hxy20vdB2XecfPRgOt
         A5H5x2Yz5YxBvlPKWLEXgUhzOulVgp/jB1SnMGwOOBQOShGWIhe+eLce1yguABfVTdK4
         D2d1fy2Lsi75tdRMJh2BCTt5XvVM8poE1sVA9rvA5iM7l7yxTK+f565smEFjyH8qU52t
         5K2cMEuQ++wFRfSrH2jI+ZTwSwt5evCaH95vHU6npuC0zQPdIM/Eb2Jk/ArGdtc+39BD
         CqJw==
X-Gm-Message-State: AOJu0Yx9pB7wL4rs4vvFQPAH8LOp7FSzxy3xO8ZakS6oDa2elCbJ25YX
	WK79sYZy1D2UoFS7t0ufJ0tN6UCyTjIabl37r3nfC7NTaCBevcDESBgsqHgx00Hk
X-Gm-Gg: AeBDieuDNltqWf5WFkf41yl+1k2byiN6dlIAmvvZt6nYndyeYfH/E0qhE3W1bNmH6wB
	abU1DfzptLrnv5wtmGHw+kFOP8WhnCxxVHC8fwbyX2asWFtzne44Fs5GnWLAKc+lW5dDrsV7D1T
	10VGGtcM3EGbkQ1dfT1tBeZBcSVuE/88EvirF9ac+ffNXlYbnwUR50q4Qzc/Fzcux7sd7hLWoZy
	6VCyKHc88r/OlaVistkj9im0mzGkLQBqpIXi04/bLAA4HIffkpvqA0bWgZ0FnIHDXVcky29yBi6
	bXlpfO5fV5vm/dTtZ3e8WTnokYSS228rPastDYRVNNolCXQhmTn4URMLbGJFsOjHKyX6OvFY+2t
	UTh01fyIc8ti9dW1PlQKojrDIIhWI6HX73KDGIX1IYLnsNJSiaWQVlfj7Be5qvlS9aJs5XJdv+e
	nlHlaNLRcysSXGbakSlCQf/Jm2EdnPjBr8S1EyElNED0NZTs/LSirlBQJxZUiG8d0CXsUSmE5ac
	bm47ckU/utF5q1z+B1yzUigJojUkWqqPw==
X-Received: by 2002:a17:902:d652:b0:2b4:62bd:ee3 with SMTP id d9443c01a7336-2b5f9f5eac7mr322725635ad.33.1777239036160;
        Sun, 26 Apr 2026 14:30:36 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab297c8sm271641765ad.67.2026.04.26.14.30.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Apr 2026 14:30:33 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [yocto-autobuilder-helper][PATCH] config.json: fix tabs in patchtest-selftest
Date: Sun, 26 Apr 2026 14:30:16 -0700
Message-ID: <20260426213026.40406-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 26 Apr 2026 21:30:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3818

Normalize whitespace to spaces instead of tabs

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/config.json b/config.json
index beb03d5..3c067d2 100644
--- a/config.json
+++ b/config.json
@@ -1879,13 +1879,13 @@
                 "BBTARGETS" : "core-image-patchtest"
             }
         },
-	"patchtest-selftest" : {
-	    "NEEDREPOS" : ["bitbake"],
-	    "EXTRACMDS" : ["${SCRIPTSDIR}/run-patchtest-selftest ${HELPERBUILDDIR}/.."],
-	    "ADDLAYER" : [
-	        "${BUILDDIR}/../layers/openembedded-core/meta-selftest"
-	    ]
-	},
+        "patchtest-selftest" : {
+            "NEEDREPOS" : ["bitbake"],
+            "EXTRACMDS" : ["${SCRIPTSDIR}/run-patchtest-selftest ${HELPERBUILDDIR}/.."],
+            "ADDLAYER" : [
+                "${BUILDDIR}/../layers/openembedded-core/meta-selftest"
+            ]
+        },
         "toaster" : {
             "EXTRACMDS" : ["${SCRIPTSDIR}/run-toaster-tests ${HELPERBUILDDIR} ${HELPERBUILDDIR}/../layers/bitbake"]
         }
-- 
2.50.1 (Apple Git-155)


