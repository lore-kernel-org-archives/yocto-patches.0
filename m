Return-Path: <hfranco@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9221CFD7091
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 20:28:33 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.86372.1773779306087823624
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 13:28:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=mXyKAO47;
 spf=pass (domain: baylibre.com, ip: 74.125.82.178, mailfrom: hfranco@baylibre.com)
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0e38f3f60so165329eec.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773779305; x=1774384105; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/MqlCtcwAwQ9q6ef2lrCv3LzUeLsdp6rFX6Irtz1AM=;
        b=mXyKAO47/DiLeQbn4En+4vFv0nhQIRrw4fak9qkKcSjYHtPiSqHGfV0p/75QJio+kb
         I3CdtylbxnQ1rCtI9kmCso0RLj35Xz2AV8dSDrR+3Uvvq2X+OB0Caq016elmOrAVfMLm
         t3qv0M22eS/HRN6SXDFayBV9H9kIlj6WztZPBPqOhQvnZtaTvL7C2lVlN/ZmytPmffHR
         b38Oxn2W71cYXIHC9+mbdX77IbFPEB3AudgzEdIGPUp1tQ9PTULWql0r4jGaKHlmwDaH
         6MbyfkNRLD1FjyLr4OWb1dhxMx0Iij/Kxub2RwVFssJKEz0BErB76pyFeVSRaimE8Bvz
         wffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773779305; x=1774384105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/MqlCtcwAwQ9q6ef2lrCv3LzUeLsdp6rFX6Irtz1AM=;
        b=QqA/53eakuIkkZIz1QBb5iQtW7fh9BhFvh8FKkSLQxCZXYbFAeaKoXaVkwfZvdTSKi
         v7LUa3PjucQksdz2fsP5APFlf8Vn/JELTOUPSIzSaObeGgfK/cLW29H5HF8Ifp1xam+Q
         /mRo3aTBh2nKIMErY2xnsscnJMXPCRXdiUfAlifTkeeKyJ3yoRjBbtglGjCikfrkaJ69
         dmMG8lG1uBYj9jKLiATcQ424yghPthEkDX0JGQsE4MSEjvSqaJIiTvIdDGkTYPqMxPpN
         RxMJLlJ6FUFYu+L4QfcNYXDtTdzgHo9sqiJ6r/8I8B2ZbxoNCW7VYcgImKBGCTOBnsHY
         I40g==
X-Gm-Message-State: AOJu0Yx3jtnLhanxI+GttSK9cI2U3e760pLCf49LX+RJa0AZxKMbBqGq
	d8Ny3UDrIF37P4bK3SfLQpdbQnl/+giVRXPnTexhfdywLtRmGyg/GqdseHgW/HSpeQf1jGFnpzR
	RA6dLD7o=
X-Gm-Gg: ATEYQzwZ/DlFQCTSiCPAJ8JwjDvHJ8NbeicETMfU4veErAHMGB5A3yzoPlZi8dOnj9P
	oTV+29WFr6HQ1apPXKoXd7130c9LuG3v/Q3tShfp3XyyE9D6ncYcqQAdO7oIjxrZ0LPaVDBaRz4
	2AjAx5wbO81c4VTKQHo5TStPqGHXs5FEa1IY+Tnd/CKRea+O+SaU+dQmT/Vne397BOVua6M2Pyw
	CimKngjupNwH7CVFeLBJmsQzhKFMJfcjqxC9wTOL3OGWYiXiKiBEPvVXlw4I/6i9Ob/XteB/KfS
	6KUq5BULWe2Ro8bMiv3wtSycjxYMBoFMyCoVnGRAk1BvWUZb6c6V/0j0Km6R3BEj2XYFmdbpNyi
	1PhHVyELelMVZWmD4G2GPXNmlgKbxZzzEYP1mucYiz8IoDnjFwyUBNVXBg/tkGkzay+8hNzXE49
	2x2VC77hVulYbZmGANQqHcEuQ5a8nxbyo4dhiLMg6tUTmnhBVYDj9xL0n5ZB0ePYZjw5Wi50BvD
	FqJ5Vkvth8aDm4rRfR5
X-Received: by 2002:a05:7300:fd13:b0:2ba:9cc4:aebb with SMTP id 5a478bee46e88-2c0e47efbf2mr443874eec.10.1773779304904;
        Tue, 17 Mar 2026 13:28:24 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c0:c4f1:ec8d:3c3c:583d:3ed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e51dd413sm931442eec.0.2026.03.17.13.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 13:28:24 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [meta-selinux][PATCH v2] enable-selinux.bbclass: enable SELinux support in native packages
Date: Tue, 17 Mar 2026 17:25:36 -0300
Message-ID: <20260317202754.920902-1-hfranco@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 20:28:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3494

With SELinux enabled for the target it makes sense to have SELinux
support enabled for the native tools, too.

Note that for native packages DISTRO_FEATURES is filtered, thus up to
now it never contained "selinux". Replace the target_selinux() with
bb.utils.filter(), allowing native packages to pick up "selinux" when
DISTRO_FEATURES_FILTER_NATIVE is configured.

Document in README how to enable SELinux support for native tools by
appending "selinux" to DISTRO_FEATURES_FILTER_NATIVE.

Co-developed-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
Hello,

This is the v2 patch following the patch sent by Uwe [0].

v1 -> v2:
- Dropped local.conf changes.
- Added a new section to README, as asked by the v1 review.
- Commit description and title updated.

[0] https://lore.kernel.org/yocto-patches/20260213154238.4093604-2-u.kleine-koenig@baylibre.com/

Regards,
Hiago.
---
 README                         | 8 ++++++++
 classes/enable-selinux.bbclass | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/README b/README
index ae011f3..3e343fc 100644
--- a/README
+++ b/README
@@ -63,6 +63,14 @@ labeling on first boot. Set FIRST_BOOT_RELABEL to 1 in local.conf:
 
 FIRST_BOOT_RELABEL = "1"
 
+Enable SELinux support on native tools
+--------------------------------------
+By default, native tools are not built with SELinux support. With target
+support for SELinux it is very helpful during debug when the native tools
+support SELinux, too. This can be achieved, for example, by adding to
+local.conf:
+
+DISTRO_FEATURES_FILTER_NATIVE:append = " selinux"
 
 Starting up the system
 ----------------------
diff --git a/classes/enable-selinux.bbclass b/classes/enable-selinux.bbclass
index 3dc61d6..0c9f52e 100644
--- a/classes/enable-selinux.bbclass
+++ b/classes/enable-selinux.bbclass
@@ -1,3 +1,3 @@
 inherit selinux
 
-PACKAGECONFIG:append = " ${@target_selinux(d, 'selinux')}"
+PACKAGECONFIG:append = " ${@bb.utils.filter('DISTRO_FEATURES', 'selinux', d)}"
-- 
2.47.3


