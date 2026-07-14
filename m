Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491F8C43458
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 22:14:12 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.482.1784067247831230213
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Jul 2026 15:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=aYAfniPZ;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490791a3e92so4725565e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784067246; x=1784672046; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FR5kQAPjIBgWRrFsoj+nappvXrc1PazWODFEkX/JOuw=;
        b=aYAfniPZsgBPoudJ+vd4HTwz053rca4HtKYf939FPaymb7i+6kkBC4xjn2QepSe2lr
         /lU1LCS6JWt0DVC3gL/cTrxPQUPf3fINrD+nRTpHz+mmq1KXsf31+dyb63jQDWQMulyL
         6gQWiJQZcVVdaQwh2nX223D0EZDL2lIwr5vCXBBy3joWd6RQnG77vnT0nsjPE3fmscjo
         wPW+n+fqRzEVcFxR4uWCk9U/Ow3FHoY73tYoVo/3JhY5SDGIa2El2e668AN329ykLDAa
         DonQ+iPAA0Ye/PmEyGDuU/M2QutBs9kWFkeQ5BxxusrRH6TDfvmRaDPAV94IIugCLHDD
         Te3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784067246; x=1784672046;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FR5kQAPjIBgWRrFsoj+nappvXrc1PazWODFEkX/JOuw=;
        b=mSW7ilOazmsv7SZ9zIMn4Qu7FZOMGdcJC38xAUV7cTGyKkAP97aouj1LXb/fjXnF4m
         JqAHHUArksS6RFp0EG7pC6w/fBUYNeejjhkcWTcoqibfx5pdbNE1AE0+kGPEnwvw2mIN
         R21cBlRBtlBnNfHnNCbQbuaj4DzuHpD99ZvIbq4NZxhhXwNPNvMJyo5LdpW05xUpUQEm
         pRhWzO/CjwfKYuEz1HGwd05OkkjYJrMKG2cJjSLRNUDy6e6v2G8+dl4vIoWeE8a5OcQw
         3G1vCCjX2VpN+QsF2QRc9Nsu5BZLPbPT2SpDH6JagptXE6riOAQvtuKeqTelewGH9Jjr
         1FWg==
X-Gm-Message-State: AOJu0YzldNY0jByS44GU6wXPMd370xHKhy8dufD99LPgPB5EHiNo5/xw
	vCqJjnaLQpPIy35zMZ2cEIVGmiJja5HHkFp2ejnRTw7op30w+uXwdUGIwrbMHcD9
X-Gm-Gg: AfdE7cn7Oi0u2Z6/wbtmIThAkJW0/FdHmtYwdMmyTvU+ElJwI7rqjQk9VxtCAHnXfHT
	dYfaR0SiQfQ/hQQz7xbkRre0+gvSqI5YzPCgcMuMozcqMk8MYJLYxNiPN9VYhNppMjMp7SaDzgs
	IgtYwzkVOfYPGcIje1mDbuq1r0kAyvIt33e76nqOJ7mdmqIzxpv0F53bWowMlbVEGODQdlX4EHR
	9pAYSR+4vk+uOPt38uyBVpERa9yUckdMF47DF8jsM3VIz9yro4fhe6cLG+UKfga7bMeiqKr0VpX
	O3x2eY1EmtDLiGlGaWkrNIr5sfP9XiyXfY4U8P3amB04S9xqpNEyUWWU+Nw1U9MYPfOu4Eg9uZk
	nifxb7eNldxkSV7yX7Wex3wzC52Nb6y0SFU5oPwyv+fSZPz+pSOgHPFf/CIEJNMf2ulLorJe/15
	z60KEHYTchKtPMrzcXLxFLHz5+DVX4rb5ofLt1esNVbkUouWbopjz1ScDC+OQ=
X-Received: by 2002:a05:600c:e558:10b0:493:f88c:f425 with SMTP id 5b1f17b1804b1-493f88cf69bmr61593965e9.2.1784067246058;
        Tue, 14 Jul 2026 15:14:06 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:355b:e484:ed0c:db71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm10945998f8f.32.2026.07.14.15.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:14:05 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [wic][PATCH] wic: Standardize on percent-style formatting in exceptions
Date: Wed, 15 Jul 2026 00:12:48 +0200
Message-ID: <20260714221248.1634547-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 22:14:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4476

Switch from lazy formatting with exception arguments (WicError("string
%s", var)) to immediate percent operator formatting (WicError("string
%s" % var)) for consistency across the codebase.

This ensures unified string formatting style throughout the project.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
Dear Maintainers,

I made a diff between few plugins, and I figured out that they share
code with few differences.

I made those two changes to reduce these differences with WicError. The
raise of exceptions in the project uses the immediate percent operator
formatting, thus, in the interest of consistency, I switch the lazy
formatting forms to unify formatting style.

Note: There are also differences with logging (83 more lines), and I
have not tested them yet. I may post them if you are interrested in this
unification, so you can make a review.

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


