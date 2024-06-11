Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45029C25B76
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 14:06:27 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web11.10511.1718114780951244553
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 07:06:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XSEBSY+A;
 spf=pass (domain: gmail.com, ip: 209.85.161.41, mailfrom: twoerner@gmail.com)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b9a35a0901so2156018eaf.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718114779; x=1718719579; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Itqo8LWOsf4BySJgm71vyahZdYkytQreA37T4lm6PQw=;
        b=XSEBSY+AXyX6GJocZsrnWEq2UdRjxl7piRnjXzB3ufWu+7ASwkV2V/RT0o7W94BgSU
         vhICkQ+/ZwYWdIPcYn83wDBabCUOjqg91/JDATosefE3EJhqu+1qrxv39v/PSdbeK9FD
         xNXgETGkFumdFb7U583XisKJuxDyik4kUEm4iXHjBAD/FOcGNUglHLIZFzbyujrFEB6h
         qouM8pxEeGxN1dcWODS9245DyK3NefiHX5p14makr2claVG1W//h0u1aFwRBVg5J7Z+F
         ZVEkmCSjUsmHwbgWk6BolNKS4r0vyMPYnKhgyFjmRXcSwkNN9GQxA81iKmG/YfzjNPVZ
         aGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718114779; x=1718719579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Itqo8LWOsf4BySJgm71vyahZdYkytQreA37T4lm6PQw=;
        b=NSmV723tP/95MDv3OHcGuF6ZyqlqXaK0+ZubZTbBuTEpTls2qY/vV8X8h3vdOxi0Py
         s2ZGtwQHiH5YHdJVgkASF407AZpAVTIkLG2lp9OehgLR825h4fe6iXxUP10VQHpd7nVr
         Lpai2Ha3Uf+Jo/U1hnAFwWGvZczzgVLMF/AQFuge8E63rYedkAgt6KWUk0vgVmNqnY0F
         3t4FxJJeuj1V7vmnYM3f+SlLgZKyzlcbDnEn69cFPzyuDLRazkxCLEbguNmbyBCSpTRc
         waNUMVDMiVKFw4qcHRKbvq0wAqLeVurpH2wjHaSxCs3VP8lE+rTP5CiRbUhvKh+ee0MV
         5gpw==
X-Gm-Message-State: AOJu0YzHkgDh/3XauSnZVkedoSIAX0SlZH2uGOuFx85yjUo744TzmVh6
	BjbhLEDgxowbdFKCgW2BVkHP1xE31abLtXBzFfKQLlt++ehaqeAPOsYcDw==
X-Google-Smtp-Source: AGHT+IFnMC1fM0aNFKBKEz9oHLeWqTzb6uvTunl+O52cSRZ3CXbVriTYgYUkqtgeck1N+bnVqg4p0w==
X-Received: by 2002:a05:6358:181:b0:19f:1644:d45e with SMTP id e5c5f4694b2df-19f1fe19849mr1427661055d.8.1718114778779;
        Tue, 11 Jun 2024 07:06:18 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06e9ebee0sm34093106d6.134.2024.06.11.07.06.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 07:06:18 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] linux-yocto-dev: fix build
Date: Tue, 11 Jun 2024 10:06:07 -0400
Message-ID: <20240611140607.2719-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 14:06:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/298

The linux-yocto-dev build was failing with:
	| ERROR: modpost: vmlinux: local symbol 'security_path_rmdir' was exported

Disabling some filesystem-related security options fixes the build.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-yocto-dev.bbappend                | 1 +
 .../linux/linux-yocto-dev/disable-some-fs-security.cfg       | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 recipes-kernel/linux/linux-yocto-dev/disable-some-fs-security.cfg

diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
index b6a63d7b7b29..94bf737c63bd 100644
--- a/recipes-kernel/linux/linux-yocto-dev.bbappend
+++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
@@ -2,4 +2,5 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
 COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
 
+SRC_URI:append = " file://disable-some-fs-security.cfg"
 SRC_URI:append:orangepi-5-plus = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
diff --git a/recipes-kernel/linux/linux-yocto-dev/disable-some-fs-security.cfg b/recipes-kernel/linux/linux-yocto-dev/disable-some-fs-security.cfg
new file mode 100644
index 000000000000..dd2e894eed76
--- /dev/null
+++ b/recipes-kernel/linux/linux-yocto-dev/disable-some-fs-security.cfg
@@ -0,0 +1,5 @@
+CONFIG_SECURITYFS=n
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SECURITY_NETWORK_XFRM=n
+CONFIG_SECURITY_PATH=y
+CONFIG_SECURITY_LANDLOCK=y
-- 
2.44.0.478.g7774cfed6261


