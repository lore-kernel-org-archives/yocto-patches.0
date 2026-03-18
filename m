Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD4D107BCF5
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 10:42:24 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11211.1773830539500394308
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 03:42:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UTevC6bH;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so75277585e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773830537; x=1774435337; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPjS5KXeZ+fRCmXSMGbOkxmUjN3FXb74dTbJTCSWUR0=;
        b=UTevC6bHr0d2n2BYgD3lu0K1gREGUr5cK74NItZHn+1Sv+oHT8aRvHkBf0GgPiNJNF
         YdMG5BtrdoBt6TX41XjqUF/Ug4WNtjI3//WpZqMunCUIwNXL5WrbBLaI9p+YrVN7Z8zW
         z/TtrGRw6u6P2Y2oW+eeyz0G0BZm40j4yDSI58A6qVvsgJqj6VDz91EJ5yeNvei0tmuU
         x7KM0czY9DVrv77fMiN6rYcz5cO1OlwPE560mPXpyECp1mzAcvkONW1ZES44lMjQelff
         rIhMXqZePBL5+SSa+lYKYvZQ4QvKBleLayh6OjwZtREFD7SZXrWFQIwakthUonTMejoD
         Y1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773830537; x=1774435337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPjS5KXeZ+fRCmXSMGbOkxmUjN3FXb74dTbJTCSWUR0=;
        b=OKdghYsZMRbxdTh1al9hOtwzy+kw1voWwQaipG8L8DKZYtSdZchHlmicPHVqHFh1zv
         XrnMIH8DorJIoS1NQdNd4ZWlfi44AShG2CaoylF5T9/cR7qNGSkvu/iQoe/n1DpYWCv2
         eBU1Dit5W02nuXfwfLBv5Zof8XKf0CIbe1nTU8sYtQkVJMiRaZFmHyNYYOwizqiLLCln
         WjTHKTpc9pdmf9RYNVthCSGf7rT0jCMYYBkLWRYEmESEtn7C0gQ2uStLR5Wl1tFwszEM
         IzTrtHEWjsTgzOE5dlxIrgEJOy/ibEc20JU8/Cvy8a3Ms8+hwxtvQYYD9l7K1py2TH0l
         R1eA==
X-Gm-Message-State: AOJu0YyFN4bRUjcn0evCVM+9z7t8pFtcFPacAyUKP6W+zraIz3iR4aXP
	aldmtQlBX+/V4KhxPbUWj34MSKBjAdZh7iAFN0ScC9OReHP5d8jwC02ZIqEqiw==
X-Gm-Gg: ATEYQzxC36dEXMGDmRlwblmrnf89lVUkGSWEAxhgMy9UILKpssv3T5kT8jzLlC1SlQf
	tnmR2KwvmBDKdZX4+V7uQbw7q6TI32us7+hq+uB7VWZ660lLFIrFCE29/IsAcVOCR5e1nTljYFL
	AYdiIY7BOFEz4odRh4Rq4LjOUNOqILE0Bbf925Mul1jPtsFd0YKBRvzZNZoV6y7Akzv1IViK0MA
	b7UzfNu7n0qn0csEXIA4P2RJqNERQXWYXmq5AheeYX1Jge155jipVIF5lzRBPKZnhKDfQtk/7pu
	k4ocrWNt2VHyc8sQiF0Dtgy1BPt1eHBlT8KeCBSg+T3a3JI3gxCG8ZtQcI6yjxlST1FIZLO8zDK
	Iod3PtYAVMtD+TAjI64TBMtZAqKrj78FGWKchl0WjyxLZSYE64iBcr4Yv4zXjU3vsOnNjwh77+K
	ZEqwj/A7eUUprpyy88hdb6/TqKWN7+5JIerlRQ3A==
X-Received: by 2002:a05:600c:a43:b0:485:5981:1423 with SMTP id 5b1f17b1804b1-486f442e6f0mr50754685e9.3.1773830537409;
        Wed, 18 Mar 2026 03:42:17 -0700 (PDT)
Received: from toster.lan ([185.228.162.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fb0dsm245268585e9.3.2026.03.18.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 03:42:17 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [PATCH] layers: update for wrynose release series
Date: Wed, 18 Mar 2026 10:42:00 +0000
Message-ID: <20260318104159.1162734-2-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 10:42:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3511

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 conf/layer.conf                | 2 +-
 meta-hardening/conf/layer.conf | 2 +-
 meta-integrity/conf/layer.conf | 2 +-
 meta-tpm/conf/layer.conf       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 7a86054..e08a58a 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
 BBFILE_PATTERN_security = "^${LAYERDIR}/"
 BBFILE_PRIORITY_security = "8"
 
-LAYERSERIES_COMPAT_security = "whinlatter"
+LAYERSERIES_COMPAT_security = "whinlatter wrynose"
 
 LAYERDEPENDS_security = "core openembedded-layer"
 
diff --git a/meta-hardening/conf/layer.conf b/meta-hardening/conf/layer.conf
index 367d3d7..dcc4fa8 100644
--- a/meta-hardening/conf/layer.conf
+++ b/meta-hardening/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "harden-layer"
 BBFILE_PATTERN_harden-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_harden-layer = "6"
 
-LAYERSERIES_COMPAT_harden-layer = "whinlatter"
+LAYERSERIES_COMPAT_harden-layer = "whinlatter wrynose"
 
 LAYERDEPENDS_harden-layer = "core openembedded-layer"
 
diff --git a/meta-integrity/conf/layer.conf b/meta-integrity/conf/layer.conf
index 23d6848..f907385 100644
--- a/meta-integrity/conf/layer.conf
+++ b/meta-integrity/conf/layer.conf
@@ -20,7 +20,7 @@ INTEGRITY_BASE := '${LAYERDIR}'
 # interactive shell is enough.
 OE_TERMINAL_EXPORTS += "INTEGRITY_BASE"
 
-LAYERSERIES_COMPAT_integrity = "whinlatter"
+LAYERSERIES_COMPAT_integrity = "whinlatter wrynose"
 # ima-evm-utils depends on keyutils from meta-oe
 LAYERDEPENDS_integrity = "core openembedded-layer"
 
diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index 582fe1e..94ca4c6 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "tpm-layer"
 BBFILE_PATTERN_tpm-layer = "^${LAYERDIR}/"
 BBFILE_PRIORITY_tpm-layer = "6"
 
-LAYERSERIES_COMPAT_tpm-layer = "whinlatter"
+LAYERSERIES_COMPAT_tpm-layer = "whinlatter wrynose"
 
 LAYERDEPENDS_tpm-layer = " \
     core \
-- 
2.53.0


