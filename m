Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772C7C43458
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 04:53:01 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.62441.1782967976630182904
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 21:52:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=mPi8klBc;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493bb0e2894so2618475e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 21:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782967975; x=1783572775; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Exj+kezKRv0lgvWbNsDiMb4ReJMLRHxAhim6EohuLco=;
        b=mPi8klBcx6AvhLCzYQChKYgHBUFSlxDkrRFfnY0miNwa6Py5BI/6PUqwRInAoXgvIE
         8Z4w2gLOy9Flj1g2iMz+e+whBtRWZXpC0qGQ2QnRIhPaHw+p2HZs6DSBU+enEqgkP3OX
         RIQF4b9Svw5KRh03ZoQz66KADApbIpMPiuPtv57kdm0Tq2kzsINRnnx9qev4PUDXmvya
         1ejR3Xx9FlBNPzascHmfTR4CtWCPS9OP6jJGYIOfWEO40z8rMaJQWN5rAiRrS7SYCbaq
         bkdDBL+oIBmkINoAIG04VpYw9wRC8qX4ZpR/ppCpmQCM1we3IiY/7a/QIo+6miB2WlvY
         SpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782967975; x=1783572775;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Exj+kezKRv0lgvWbNsDiMb4ReJMLRHxAhim6EohuLco=;
        b=AupadT4Um/Xqcb91VJqL9Je/5UErh/26Q708gbE1YOP0RcnQieaSCLU8VjneIUIdCm
         pQ8Tgr5wXfJYgFYZQp2vEIOj5jQMB7KJTkdUsxjoXH4zsOcc5nuA0LpxkaIeyZthEc+O
         M2EibekZ0gFUBtJhBYHkGeVXdEQmD7opcTbeEIqKKIzhW36pkgU/0RKqmiLAaiWtjyA/
         Iy/Ib0OSKtZIQzV6zXFvAJC0Jtzb8u8rGyhKBohB65GHGz85GT/pxHEm6sPTWEAzeRcj
         2gp33UUKgMTxbysjvlP92SiPymtj/tIQEA+Q+eV5Q5O/+2ehPyO1rNNUv38yJsBH4BCM
         Khdw==
X-Gm-Message-State: AOJu0Yx+XOtPxXG/Dbrb8OhQIWASdRya/KYiCznHh4t94Z25Bjpx7rjc
	LE6Dt+lYj6tS0NuxuE0aFShds+YGL24jAOlftq/f3w1HhCREDGolpp2xvDp4dCVn
X-Gm-Gg: AfdE7cnE5v5ybL69wWm/rw/CqO/VDkh3JpbQttkdqTNXWSMgKYxTH8oLmK1VOS2NNGj
	0kcBO6/ClZFeQT817Sr5TQPlst0qkf4nkODujz6FS7vpuhojaixLCToAFBsRBn7IioE4HBKpzlZ
	4SbPaDL+EEBhP3qq5sfOd78Y8PxBiiA9zYX5pCDqq/43lWl7uNRLhL8Xahuyk31+xsYRVNnlPL5
	YBhmIdPT3KsVO0Gthj+wdJlbR7DXRFbxrlY2peqjRk9K4KrLvXpzMERr3EJcqcbzziGaPBFI3qs
	WoGRqe8d1/BqO4WWlQ7/TE7XE41fmFo0L3TEOzr046YkP0YvTLWLA72w99VPGJbXvvBEfyQK7VI
	U6EF7qCbRd1C/GNkrlnIa1EL9xm5v4FVEebCREIH/mrtE3Uu3D8kotWi4fjr+eCmjl9gYQWfZDU
	IpqfcQ3uoKTp/39qI5yq9Bw9MpdV4LgIsVa4zPq2sT4QK3x9jlgjsX3ofU3A==
X-Received: by 2002:a05:600c:3e10:b0:490:ec79:3046 with SMTP id 5b1f17b1804b1-493c2ac71a8mr32933305e9.0.1782967974646;
        Wed, 01 Jul 2026 21:52:54 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:8a40:d7a5:890a:fa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6372368sm17665155e9.12.2026.07.01.21.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 21:52:54 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [PATCH] wic: Standardize on percent-style formatting in exceptions
Date: Thu,  2 Jul 2026 06:52:41 +0200
Message-ID: <20260702045245.848251-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Jul 2026 04:53:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4360

Switch from lazy formatting with logging arguments (logger.debug("string
%s", var)) to immediate percent operator formatting ("string %s" % var)
for consistency across the codebase.

This ensures unified string formatting style throughout the project.
---
Hello,

I may apply that change to logging as well, but there is much more
occurences ;)

Regards,
Gaël
 src/wic/plugins/source/bootimg_efi.py        | 2 +-
 src/wic/plugins/source/isoimage_isohybrid.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/wic/plugins/source/bootimg_efi.py b/src/wic/plugins/source/bootimg_efi.py
index fe6c222..7cdd444 100644
--- a/src/wic/plugins/source/bootimg_efi.py
+++ b/src/wic/plugins/source/bootimg_efi.py
@@ -171,7 +171,7 @@ class BootimgEFIPlugin(SourcePlugin):
                              "%s for systemd-boots's boot.conf", configfile)
             else:
                 raise WicError("configfile is specified but failed to "
-                               "get it from %s.", configfile)
+                               "get it from %s." % configfile)
         else:
             # Create systemd-boot configuration using parameters from wks file
             kernel = get_bitbake_var("KERNEL_IMAGETYPE")
diff --git a/src/wic/plugins/source/isoimage_isohybrid.py b/src/wic/plugins/source/isoimage_isohybrid.py
index 0a3ecd3..15dae01 100644
--- a/src/wic/plugins/source/isoimage_isohybrid.py
+++ b/src/wic/plugins/source/isoimage_isohybrid.py
@@ -101,7 +101,7 @@ class IsoImagePlugin(SourcePlugin):
                              configfile)
             else:
                 raise WicError("configfile is specified "
-                               "but failed to get it from %s", configfile)
+                               "but failed to get it from %s" % configfile)
         else:
             splash = os.path.join(target_dir, "splash.jpg")
             if os.path.exists(splash):
-- 
2.43.0


