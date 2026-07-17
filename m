Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4993EC4451B
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 17:37:59 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2166.1784309872966035455
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Jul 2026 10:37:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=FqVJg4RD;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso9081415e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1784309871; x=1784914671; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AL7d7R0Wg+SNJ9ndfQe1ryIHbIMe13SSQPGAr9Tr92Q=;
        b=FqVJg4RDH9W4X0z2GxCPgiIH792BSWTcf6rUZ+vpXloQwgxj+3wyrhbkEoeyaIxXPS
         qaNgKHAQx4U7IfkCgMzPueap6sqzNs4PpEUHZy57sJCqwxl410HcRXDUQc67Hdu6iDEw
         Lfn0PV11xRpv1ulSgAnn48O8YR2GI/y4kMqBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309871; x=1784914671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AL7d7R0Wg+SNJ9ndfQe1ryIHbIMe13SSQPGAr9Tr92Q=;
        b=Zno6qeZU4XkBVkNlbqNF6lSVG42ubm1Vaq2fiWVV3qRdQsLQN2OoGtFdeOonSGuBly
         k7t09q7iM62DNkPC55VqW3ISEFlLPPw9IzJPOM0dRmIy9qLpuOS5TJoUPs1h9ZceNhgd
         FxvVcJy/UZVaRR+IdhNO1NombBCZ/owhq6nHrCK7ceidxK9PGQGEyc34mrKERBpC7gnT
         7WLUddLbCj5qh1BwXHXc5jQRY3UCrMVzGrd8cCCAMxWl44m7h7fMsahaSvRYot3Exiup
         FopKzv7gsvl8zqxg8zwlG8xVxgztyjlSkv6ydVxlikJXtEAUFP1mgbop5npkbebaqSZL
         r0GQ==
X-Gm-Message-State: AOJu0Yx12nQnb3+zHQztO8/F5KnSS4UqYole25mIoJEQ7xnkV8J2z4U/
	Q6+zo+YS7rQVRHiIRxcYoSvHmOQO0fxFjskzINbF8UK120wuBtiOrG+wPuuhORUdNZy9dKzq/FU
	qQKUUQ1M=
X-Gm-Gg: AfdE7cmljn/DUNVMyRdPQ/buLdrGE+HHnrZ2465gFX6q8ADJHbgse1FhHBOS+jjEdLW
	sZebMU+Zf4bwc9tbyc2BmoDj99HKKGGLQHz+OHN6oNqBijOhHklPUkr+IYQ4sVO3cOeHePeOV45
	+KU1xG4BCooqih1l2JhZq4dF+g/sufGAY7Zwyw8kIpr306CCSc6VC6D8IMNTFhwhqXFDZaW7eek
	YBdX4WW9qJIgR65skKPpFBgS/k+rizQv6Iw/qqbb8qdQ2M0YZ3L1Iu7hW2JmtXaFlc+nDuGGVre
	bvmp8fL1lupVgC4GDIwGBR9hwTcKOcnhCLzprTeVheVUGltoanUjxLwlATF69Xbw4ChnRAcHuL2
	69q0iUBcnpN1Rp6k+pC/YeGHV2hJLuBREqYplnGP7+38G2iVmfcCNyn3++JFUg1cx7Ox7wRumE5
	LL0XUXXTON40iEvpLmPAnu/DXaZaVPZvTR/i4eFi4KQRZhrKsg2IFnryUphYEQvgf0jLZWjhpfn
	QeyBd0=
X-Received: by 2002:a05:600c:1d15:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4954a3f4901mr47288845e9.9.1784309871115;
        Fri, 17 Jul 2026 10:37:51 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0093f4151e9fe9f4b8.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:93f4:151e:9fe9:f4b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954c0a81f7sm28504195e9.1.2026.07.17.10.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:37:50 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] config.py: add wrynose release to workers_prev_releases
Date: Fri, 17 Jul 2026 19:37:20 +0200
Message-ID: <20260717173719.2820271-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 17:37:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4503

From: Yoann Congal <yoann.congal@smile.fr>

The list is based on what we list as supported in the documentation:
https://git.yoctoproject.org/yocto-docs/tree/documentation/ref-manual/system-requirements.rst?h=wrynose&id=9e2e70b7ba20b6ad297fdf83599367f1cdcf24cc
and
Poky's SANITY_TESTED_DISTROS:
https://git.yoctoproject.org/meta-yocto/tree/meta-poky/conf/distro/poky.conf?h=wrynose#n33

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.py b/config.py
index 22ec6b5..cd0ec2b 100644
--- a/config.py
+++ b/config.py
@@ -202,6 +202,7 @@ all_workers = workers + workers_bringup + workers_buildperf + workers_arm
 
 # Worker filtering for older releases
 workers_prev_releases = {
+    "wrynose" : ("alma8", "alma9", "debian11", "debian12", "debian13", "fedora42", "fedora43", "opensuse156", "opensuse160", "rocky8", "rocky9", "stream9", "stream10", "ubuntu2204", "ubuntu2404", "ubuntu2504", "ubuntu2510", "ubuntu2604", "perf-"),
     "whinlatter" : ("alma8", "alma9", "debian11", "debian12", "debian13", "fedora39", "fedora40", "fedora41", "fedora42", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2204", "ubuntu2404", "ubuntu2504", "ubuntu2510", "perf-"),
     "walnascar" : ("alma8", "alma9", "debian11", "debian12", "fedora39", "fedora40", "fedora41", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2410", "perf-"),
     "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),

