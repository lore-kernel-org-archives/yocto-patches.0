Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661B0C282EC
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 16:39:52 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.14600.1741711182783678344
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 09:39:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=jb0VLdFf;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39130ee05b0so3595371f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1741711181; x=1742315981; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtdVMgqpywgLZPzzH+VaXGujpIbjQIiLAS30LsyCMmo=;
        b=jb0VLdFf6H+est32WrR6P5JjF0YKNaB8naKcrp7qGlNnhA6H3uBdunxXuBsWZ1AypF
         5acM8Eetdbs85AjybKwZ3KJa4Bw4HsFdXYR/9hoSpIGM0SvMg91RbeKSChP6kWgS7m6p
         2CVSaJhLtuyfejSWnLEoKZ7oDqN1mIc5f+8MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711181; x=1742315981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtdVMgqpywgLZPzzH+VaXGujpIbjQIiLAS30LsyCMmo=;
        b=SOQKXDMPpBtzWn1GlVpDcS1oUxh9XPPOIYyzcaYSvRtQPDQJZ9/RRl3q3BMhwVuOnM
         oEpWRNBk06NPpIptjzD4coZdh6VpkLPddq0FoSXnLct/nLzGtSWcu4Zo8L0mY6EHPDSd
         43lCFwzC0qgp/UJ4UrFelbpP2TatULbZZQahq0eAKPEBbBme+sor6qT9huRhp005Xtcn
         NxP+sv8dbPTIt873jBeQEi24jBw3j0w0hiSUZ7rIUNP5IzH/H7U8zO2avJwgBhXsR6lI
         MO+WEs2HMRLA0/kIpVgE833P2IUFDoZ8PuOA4n48sej6ptdU0hTwxOTs5YhOb+8H/Uce
         XZMQ==
X-Gm-Message-State: AOJu0YwLA+3Il2aHAf2lcFowaWUpPAYBJFhxqpP6KzVzM8ryZoUFZLCX
	SsK7uGch7U/LJVBnaARjT5kE/HCsNcjxDiF/StFaTH8BhVvAGj9EZUPoMJPNHCsiI6iniMahK2f
	i
X-Gm-Gg: ASbGncs0Z3qTBwM93UmH5etNThTEORY3JQuawT+7TVDJfC1/7nGRVv8EnXaX+vART1V
	3adpe0KpSS5hmt6dB3Y7C+biULEtp6H6YdRHuYAPHfSnCC5I/vhJRumtTTvMtQEPdwjf7vk1BJH
	nVgQZxLu1iu+RfG9IYATB7YlcRbJ4mf1EvyRHWzWqHznJL00jz4I3fBZDU4rS3rVQvwOR0xXK2g
	EKG9hwcUz30qxYvY2O+v17Eqygo2kShUBSVBHdqjakpfuICk1XcjR5mDAuCj3TaC5vWwU7yPbca
	d1DFXvFWviLPpNVtgbMSIzWvy1J4hmrGA481tiQhCaRANNAn9yfbEAN1Pf6bmcIb7T5TlvRzQz+
	bwcpBwnlLk7+yefFhWTKwniLlau5pFvK1iZFXOAZLvfJAktoA5yo=
X-Google-Smtp-Source: AGHT+IHC5r3qiVNAYxHuK2Jh7eRI1dc2OvwC/kbcSQcVwFaXXdJCyZORpIPdWxx0OyudhjbXGl+xRQ==
X-Received: by 2002:a05:6000:402a:b0:391:2dea:c9a5 with SMTP id ffacd0b85a97d-39132d6b61cmr15328099f8f.20.1741711181013;
        Tue, 11 Mar 2025 09:39:41 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.home (2a01cb000deef0002cff7470e58ff5dc.ipv6.abo.wanadoo.fr. [2a01:cb00:dee:f000:2cff:7470:e58f:f5dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2bb7sm18848767f8f.63.2025.03.11.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:39:40 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH] config.json: move meta-initramfs repro excludes from AB config.json to meta-initramfs
Date: Tue, 11 Mar 2025 17:39:32 +0100
Message-Id: <20250311163932.3198378-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 16:39:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1189

From: Yoann Congal <yoann.congal@smile.fr>

Somehow, meta-initramfs was missing from the
commit 91c85d95bbd9 ("config.json: move repro excludes from AB config.json to meta-oe")

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/config.json b/config.json
index 798d95e..00d61fd 100644
--- a/config.json
+++ b/config.json
@@ -367,10 +367,8 @@
                     "${BUILDDIR}/../meta-openembedded/meta-initramfs"
                 ],
                 "extravars" : [
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES =  'kexec-klibc kexec-tools-klibc-dbg'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'mtdinfo-klibc ubiattach-klibc ubiblock-klibc ubicrc32-klibc ubidetach-klibc ubiformat-klibc ubimkvol-klibc'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'ubinfo-klibc ubinize-klibc ubirename-klibc ubirmvol-klibc ubirsvol-klibc ubiupdatevol-klibc ubi-utils-klibc-dbg'",
-                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES += 'vmcore-dmesg-klibc kexecboot-klibc kexecboot-klibc-dbg'"
+                    "include conf/include/non-repro-meta-initramfs.inc",
+                    "OEQA_REPRODUCIBLE_EXCLUDED_PACKAGES = '${KNOWN_NON_REPRO_META_INITRAMFS}'"
                 ]
             },
             "step4" : {

