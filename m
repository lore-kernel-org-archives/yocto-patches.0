Return-Path: <ukleinek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D94EDF17C
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 15:42:54 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.74780.1770997372531770291
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Feb 2026 07:42:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=gKvNYgVx;
 spf=pass (domain: baylibre.com, ip: 209.85.128.42, mailfrom: ukleinek@baylibre.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so8663765e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 07:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770997370; x=1771602170; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=leSHR3aed9TrUWLk8QPGlNfD0zlFW6mgLefgp1bkssc=;
        b=gKvNYgVxhoU22YGVoQ16iwD3kkAaKnFQ2vXSWylHDbwSJYK9KPiUBUyuOu1xufKGY3
         7eZw7l7ZVMUTHawhuoQmTndodMofohGAfbqt1mdT2bsP7jDKawhtfoLefqj+XCw189Ax
         /dCFI5qQ85lIcZjzKv89ro0W0eBGi9dZaGiHfYhLUX3jv/bz0EUU5sXyXUP1qEWmFdm8
         Kxn51q2gMRwUh4O/MR/Ey2ORNWhMGyKInNQjR0J6VhGSyx4tgvF4jdneUNL7WG4yi+dG
         E6fJKwTlR+yI1S3Lgk0OSMph1vtkjGxSaf81286C9T1ksA4+v+pk/Mq569L10Ash4rh8
         NCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770997370; x=1771602170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leSHR3aed9TrUWLk8QPGlNfD0zlFW6mgLefgp1bkssc=;
        b=Lp9nUkdjjepwI3HcGGefERUI7TQiddzqtzWSB5itmyPDT1LRen5f4BuvpSttp6Nt7C
         8GxZryfDTIVfZlyhhML3xK4riCoAY+iBMo+Rbw9Nx0R+hkPfDsMrsw/sHD0t7jC6w/mM
         Js1L3908uZG50DXUC5w4ULtRSaBQ1nuv9pd/4d+CUyTUxf6Y/tsALSInDv1aPuXMJG/9
         q00HpIPFeAxtzkF1AJPEZ02IULUY0KZpAWbTr7Fgy+v+KpibyLZ44+lc9CVVPc3mBaib
         Ury19VcIzuEQVqQaP6rRmOKyTKiVfBt9hOmqalUB3WSFr7CjWTrWQARCQSktYXARK8m5
         BPLg==
X-Gm-Message-State: AOJu0Yyx0nzT6B5++ymGJttydKVLDMIAoQgbUAU0oqnKhnrk4cBTAELh
	/JAkFf3Da6exrry4TEZWagqCvxfWs9J45/DaBs1cK1VSwDDrKt7xcgW7HV4kKsBMf2eBSn/ciBt
	yWcE+
X-Gm-Gg: AZuq6aLmvet2sO1RpNMKPgqQ7ti/BW+gcZCIEqzowWK0vqcMh9dZwSBwMfNDU4TfKdY
	LsmUdYxn9MEu/QoK2SFsLraWsofLfFYXmwIBTf/+jaX9shj1W1lAUpWuW1mTaCA+BzVyobbbvaY
	21ZnW9h6FRnCMW4hlDlx79y4ur8tNDJfnqjXLUqBizxhptRFrobb73jVUSd1BNbjXfJgG4e5Xlq
	7nAdixrCUgwL2ctAMdPCEywLG06fJYUR9fTRcW7KpaLllZfYY8um5tz7S6cwo1dKL+5wAKk5JCk
	cNaIpXPp4viQiDc4chrPMgKwuhK+gxr754tF/oFz/q+T1sz+rNcDY9jNy/ES5OUcy8cAtXLK4k9
	uYQHivbP5y0HjDU7VdYIDR+MpJsVLfUItAcv684MxZQOeOaEFTrFtaSQG9GzQbyZcjyxndZG95r
	7K+ILoKwqTj8/SdWSKIF5fM7yvW0RCUXWx4GfSfm8FVFbdPrB/r6MXQciv7L8TkulfR5Au35NwO
	Lw5ecxOQ4JrwKX8hZz0ACsK
X-Received: by 2002:a05:600c:870b:b0:483:6f37:1b56 with SMTP id 5b1f17b1804b1-48371051b15mr56044335e9.10.1770997370381;
        Fri, 13 Feb 2026 07:42:50 -0800 (PST)
Received: from localhost (p200300f65f20eb040f063ace48d98e4a.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:f06:3ace:48d9:8e4a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4836ff00332sm67622665e9.2.2026.02.13.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 07:42:50 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] Enable SELinux support in native packages
Date: Fri, 13 Feb 2026 16:42:39 +0100
Message-ID: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=2C8SDTlG7NmIuoFspGpH1B5JecyJDYs6VKIn1eDXVus=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpj0Zu8M1PDhv1s6/wctuNyQ2AjH3gwCC+Kwbi/ JnM3tmt7NeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaY9GbgAKCRCPgPtYfRL+ Tv6kB/wOB4j804jV7b2Mxb1ICbvrOsrFKOB05L1KZnAWDl75RfITmsy/fPKmSnGJWCWd6dmuvVi BI3lKV9zlH6EAltLViA7pQNcLzdmoh2L9+vxt1aAF4T4g0kzZlOEM9QPnooXVrX62rZsFe9RyTl /j8+E+QL+t11rpIil3KcrOvTWx1Yazr/MOxVtls3AOPzcTIHpaGlW8bgtgZ7WTnn1P6X/5t8Hf1 uLUfmx62snAQsN+ZzuUXt6NlizK0X5jTqRVeh62bDPi5sLErup5y+3kEMQoReNN9O4l5wSlC0MZ rM4KYymQEDN3P3x3WWBNIxR9oG0SLe28jA2enVyioEGNCtAg
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 15:42:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3237

With SELinux enabled for the target it makes sense to have SELinux
support enabled for the native tools, too.

Note that for native packages DISTRO_FEATURES is filtered, thus up to now
it never contained "selinux". Append to DISTRO_FEATURES_FILTER_NATIVE to
make "selinux" propagate also to DISTRO_FEATURES for native packages.
---
Hello,

I use this on scarthgap, but the patch applies fine to master, too.

During a debug session it took me quite a while to find out why

	ls -lZ "${IMAGE_ROOTFS}

at the end of selinux_set_labels() didn't show the labels added by
setfiles.

Best regards
Uwe

 classes/enable-selinux.bbclass | 2 +-
 conf/layer.conf                | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/classes/enable-selinux.bbclass b/classes/enable-selinux.bbclass
index 3dc61d6931ff..0c9f52e74cec 100644
--- a/classes/enable-selinux.bbclass
+++ b/classes/enable-selinux.bbclass
@@ -1,3 +1,3 @@
 inherit selinux
 
-PACKAGECONFIG:append = " ${@target_selinux(d, 'selinux')}"
+PACKAGECONFIG:append = " ${@bb.utils.filter('DISTRO_FEATURES', 'selinux', d)}"
diff --git a/conf/layer.conf b/conf/layer.conf
index 4e04e5cc7e6a..ca981db57019 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -25,3 +25,7 @@ LAYERDEPENDS_selinux = " \
 "
 
 PREFERRED_PROVIDER_virtual/refpolicy ??= "refpolicy-targeted"
+
+# With target support for SELinux it is very helpful during debug when the
+# native tools support SELinux, too.
+DISTRO_FEATURES_FILTER_NATIVE:append = " selinux"

base-commit: 536df5a4fbce3c9fd63f51580f43d248a0d1b0ef
-- 
2.47.3


