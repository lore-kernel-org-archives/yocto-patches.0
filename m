Return-Path: <max.oss.09@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994E0C369CB
	for <webhook@archiver.kernel.org>; Sat, 26 Apr 2025 10:31:00 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.6657.1745663451398005516
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 26 Apr 2025 03:30:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nY0ceJ6x;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: max.oss.09@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso2211601f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 26 Apr 2025 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745663449; x=1746268249; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GRnvwbvKSd60FUmRI1QGv/ZLlihKaGbvoua8m0xeQA=;
        b=nY0ceJ6xihMc2oo/ONdpPZOfeNbbTDEdfw18Ws2V7MUveKb+uAWWF28SP9ku8+2u61
         6L7PyO7r9yC+PlY6ItHsarRY97RURlg3yt2afcN2HxUjFd6LNgfLXQ7nIoNXvVYxd3sf
         8BjkNUKkFEvi/81gWwiLdaCrTp1C52vjZ0gHMidRm3saPPEYvbS//+5m1NMsxmLQI1lm
         D4O5/1y6GACHh4REnKOnGJuSddxOpJTywaPzZ2diqRZOvr1Eq8LhpZipgFxA75G3TouU
         21XvPZr8zz7GSjGxxjdvosNwRYKxTs9tr/x3x369FtasDD6fhKypR18WhOnrvnv21ZVq
         6m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745663449; x=1746268249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GRnvwbvKSd60FUmRI1QGv/ZLlihKaGbvoua8m0xeQA=;
        b=lkCoj/nEQtJg69MksBDzPlr+P+qKBtJXZKuFC4AEUqLw/eqUsD21dBZDP9blNZ1KMi
         ACsUH+Hby+fznpbefp3qm68R8oaTYSDgPJ81ost3yhkVLavVYJwmUnuzgKEpbxAt2Mrw
         YIh2e8purn0GVXSlFEN/tj5c8zpT+WpCCWv45zqsO1aW5Vlw321ix7TjlfYh+hSaAt8y
         j03RzJYwy8nqzNbnRuNXcJZkWpA8yPQB+gx30abqUg70orY8WJ42mLws4LmhCaIpZNvY
         MIL60yGaitUgFV8Q8FIlnXdbjaYyTFeF+i1/l7PRIYRPWrrwGxVm74frpc5Vp+m30I78
         BrXg==
X-Gm-Message-State: AOJu0Yyiq0/xQmWPOXnbggGK8t9jlJ+p1nLLOCwGA7/4IzmAsWeimbtt
	6PobItJZ+rYgIbk/T+BF4E9VP51Vuj9iLDLaGG+xdNCoAyApceI8yknf0A==
X-Gm-Gg: ASbGncvFKSWSp7h3fqmjr7LrtFH6yothokyFgCHEdsM5yBgA70U0aXEbaYSwGr4Dh+J
	1v1QTVp5jgysYeYTDLRzoBSP2FN+CewIPqQeJ2VMxSeN8Ba7dr3RvWGJ4SzAVDHG1j6WmpnKO89
	acbyV5KgM0v/o9+MeBEk5Lx9TSWaij952Gj8MEVJ2EwYHztTDxHSEie4VN8lg4v27+6O7Cd+dh+
	NdgkTYu4f8UbSqg6dzzvYTXkXvWfUxt+rIqPu+5VInOH+DYPCMQSJtglWoZND8aJAmWqXdZhA6A
	HOpG202WuYfQ01JAQxGmhXB17FK6xrp81Hd3mk+d8+3obYo/yYw6gf8TOUhMI4vfeUEiuTjXh/V
	wvZBg9EkJ
X-Google-Smtp-Source: AGHT+IFtuUMJJLnBJlm8zBJg5xKt+TVxcZbgLjuwk9gcbZox7Ve5qH+i+1ORgA88qpx8H97qKXCHmA==
X-Received: by 2002:a5d:5985:0:b0:39f:ed8:d6c2 with SMTP id ffacd0b85a97d-3a074e102fdmr3999870f8f.4.1745663449329;
        Sat, 26 Apr 2025 03:30:49 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46976sm5049071f8f.63.2025.04.26.03.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 03:30:48 -0700 (PDT)
From: max.oss.09@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Max Krummenacher <max.krummenacher@toradex.com>
Subject: [meta-security][meta-tpm][PATCH] recipes: fix whitespace warnings
Date: Sat, 26 Apr 2025 12:30:01 +0200
Message-ID: <20250426103001.3937435-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 26 Apr 2025 10:31:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1401

From: Max Krummenacher <max.krummenacher@toradex.com>

Since OE bitbake commit 24772dd2ae6c ("parse/ConfHandler: Add warning for
deprecated whitespace usage"), the current build generates the following
warning (as example):

| WARNING: ...meta-security/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend:7
| has a lack of whitespace around the assignment:
| 'EXTRA_OEMESON:append= "    ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', '-Dtpm2=true', '', d)} "'

Fix all the warnings.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---
 meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend | 2 +-
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb            | 4 ++--
 meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend b/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend
index 712a764f5900..55323aa52c0d 100644
--- a/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend
+++ b/meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend
@@ -2,6 +2,6 @@ DEPENDS += "\
     ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'tpm2-tss libtss2 libtss2-tcti-device', '', d)} \
 "
 
-EXTRA_OEMESON:append= "\
+EXTRA_OEMESON:append = "\
     ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', '-Dtpm2=true', '', d)} \
 "
diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
index 3e58c3313236..c7159e04938e 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
@@ -15,8 +15,8 @@ S = "${WORKDIR}/git"
 PARALLEL_MAKE = ""
 inherit autotools pkgconfig perlnative
 
-TSS_USER="tss"
-TSS_GROUP="tss"
+TSS_USER = "tss"
+TSS_GROUP = "tss"
 
 PACKAGECONFIG ?= "openssl gnutls"
 PACKAGECONFIG += "${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux', '', d)}"
diff --git a/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb b/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
index 24fd5b535d6b..1b8eff149df2 100644
--- a/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
@@ -35,7 +35,7 @@ USERADD_PACKAGES = "${PN}"
 GROUPADD_PARAM:${PN} = "tss"
 USERADD_PARAM:${PN} = "--system -M -d /var/lib/tpm -s /bin/false -g tss tss"
 
-PACKAGECONFIG ?="${@bb.utils.contains('DISTRO_FEATURES','systemd','systemd', '', d)}"
+PACKAGECONFIG ?= "${@bb.utils.contains('DISTRO_FEATURES','systemd','systemd', '', d)}"
 PACKAGECONFIG[systemd] = "--with-systemdsystemunitdir=${systemd_system_unitdir}, --with-systemdsystemunitdir=no"
 
 do_install:append() {
-- 
2.42.0


