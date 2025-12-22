Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D3CE677FD
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:52:33 +0000 (UTC)
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.84029.1766422343457179671
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 08:52:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=txecK2ap;
 spf=pass (domain: konsulko.com, ip: 209.85.160.196, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-4f34c5f2f98so46819211cf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 08:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1766422342; x=1767027142; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnGX/QYFkTm8wqUJNGWjSubYoT/b+WoJvTreXDTuU1g=;
        b=txecK2apkpq8/qiYBpTZ1UEeF4rscXp/L7ToJUXft473CGAsI5PC6nRGiJlZgYMuPv
         Bq1tJcct62/VFPhqh0U2Sqx4ba/6TjT1dYmMjPDzOdbqLA8IeZuM+0+WBKUZuWRoc1vB
         NKsKAsl+sf830zgWZBJBofQsBKFp2Sxx0ehgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422342; x=1767027142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EnGX/QYFkTm8wqUJNGWjSubYoT/b+WoJvTreXDTuU1g=;
        b=HtQfBPGIeI4J3v5TO/8xGW+lF7TakeB/jcd8PZn2wrCayHWBm7EjLrEGTGlifAvp/D
         ts/mtrkszWOCriulsF6NC9Vf3pBijHlhdIUrOBer4EKGbhzYz4dqEW71bwD4sQdo6Tki
         Ekcq2JvG8O/KRV+CZ2MnUswKjyiCxucuZUWYKaMsR10nWK2DZYBIpeSJOioREMvpTQvh
         tri/ETj3G/2gAewDvC/Ts4u9GsTjxuQfCXtreQP0cap/T0bvNvtOTjHNzXQxkrm8lUTz
         +iVYJg73k0eQ7o9dGgDkqUbh7JqhTrPt0LDAR2XTNC0I77ta1nyuZ+RynEG09eknrlos
         s04g==
X-Gm-Message-State: AOJu0YyWEckVaJY1B0n3sJgdkjmkfRRzmh4L56D80D0GrgNUH/ZEaiuo
	VUTZdJuCitKA0kzS4fFluUI7G589cxJTGbEmBp/0SIj+zXTc3Qv2zJLFZdYGOsZLISFdyesXP+j
	ugd27ss4=
X-Gm-Gg: AY/fxX4qtzrZMPBlOHpA4XFzKM2jL8yWyTVMa9QIzVhlgOOkiIiMArvOP1pNkKLStYX
	NFjmOkVN0p5iLRoPgJbP17jq9WcUVKnKc8Y54evKLkAS43+AuWJH+iGCgp/l23tCJO1bVDdF9xQ
	x7kH+l3TA6tWLWPE8ZyDTZe+uPBZ0ZKiianhaxrkcKpRl9eR0mV+RKkIUgP8qXPnPhbwBDD7mwj
	/uEKh0tZj8Zc6L0cm+aErKy2tb+u9Pl57kW1yOegqtGVXC4MT9SZIzZQ3A9kzjb9UAtB5/V/rfo
	mBB1fgCAIOXJKOLt36QECb1zItL9I3dyfsxia/+rBOX0NLKnjuu1UiODs0DpeY95PkFMu6oKqlL
	DlAyVzL2Ry4x3E6mjIqK3icsKCLqyJR+1Ze0HN+45D1Bl408VBFr2ev0kKW13+qSi3PVGoV7/OE
	447YQziovJT3EqWp02e800ZloPAyZQjjy8cVoaBK5ItWziITTK0L6Bldt8a8Auulv5p7Ohflc31
	+M0xrNY37nj0rz/0rVoifHrxJJGv0ez0vsXb6r5FTxt7IubdCdM
X-Google-Smtp-Source: AGHT+IHcZbGZSIaCO60X0Qni1hIYCu8r6aHibNXvoaIBxjlH50mxR78MeB44is4/jUuu5zI+qbnqyA==
X-Received: by 2002:a05:622a:400e:b0:4ee:d6:7a51 with SMTP id d75a77b69052e-4f4abcceef9mr212479181cf.12.1766422342048;
        Mon, 22 Dec 2025 08:52:22 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fdfdsm87149726d6.5.2025.12.22.08.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:52:21 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][PATCH 4/8] sssd: inherit github-releases class
Date: Mon, 22 Dec 2025 11:51:52 -0500
Message-ID: <3dafa5ded285cd0e0b280141bfefc5f9ce93fe1f.1766420960.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766420960.git.scott.murray@konsulko.com>
References: <cover.1766420960.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:52:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2854

From: Yi Zhao <yi.zhao@eng.windriver.com>

Inherit github-releases class to check the correct latest stable
verison.

Before the patch:
$ devtool latest-version sssd
INFO: Current version: 2.10.2
INFO: Latest version:

After the patch:
$ devtool latest-version sssd
INFO: Current version: 2.10.2
INFO: Latest version: 2.11.1

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../networking-layer/recipes-security/sssd/sssd_2.10.2.bb     | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb
index b02710e..8ee61ce 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb
@@ -26,9 +26,7 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            "
 SRC_URI[sha256sum] = "e8aa5e6b48ae465bea7064048715ce7e9c53b50ec6a9c69304f59e0d35be40ff"
 
-UPSTREAM_CHECK_URI = "https://github.com/SSSD/${BPN}/releases"
-
-inherit autotools pkgconfig gettext python3native features_check systemd useradd
+inherit autotools pkgconfig gettext python3native features_check systemd useradd github-releases
 
 REQUIRED_DISTRO_FEATURES = "pam"
 
-- 
2.51.0


