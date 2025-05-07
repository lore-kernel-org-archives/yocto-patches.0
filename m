Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E6CC3ABC5
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 08:27:51 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web11.3809.1746606464134266611
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 01:27:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=lBRHGN5y;
 spf=pass (domain: linaro.org, ip: 209.85.167.44, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54d6f933152so9024180e87.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 01:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746606462; x=1747211262; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm6znr5clwOYE3PL4WI29yaYIrrH6L5OIh9g+a7uykg=;
        b=lBRHGN5ybpCMVVEJGb2c3HwYK7ZrXST0RYyURR8VM6LkYVunkE4SWYbYtlzJVPKYel
         SjC3HbkuoYHYDnmfVbg64uMsa8Br1o/ihIDmpjmeh/gV8SkytSKJhQB7hjObvuROJGoO
         kDNKmpk2sHJ1M+V11GfUq9jqJROZHOVA629JupYyXau3jRolaz4VtNi8DmYmzxg6+olE
         dfpx3xNgc1Nas/w8Vvzob89XNnt3Zmob4qSKCeZ30yIM2B/e6Z9yfwVifsgFS8gAGisV
         25QfSekUdtFyMKsZ/WNR0vv6DGFg572+e0u3fUTBBH8kl/Z3JTzlKQmCeXOwqm+pp2Ko
         dNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746606462; x=1747211262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nm6znr5clwOYE3PL4WI29yaYIrrH6L5OIh9g+a7uykg=;
        b=BaHcUymt5wLmDA3yajHHe9wBXeSsqf67DCFCbIpci7fjIibON1YadVhzV9Xfr/PONS
         3QsiYbaG1A1m2DzCCRhQhuOF1JhhSyQXKbUFtObchnoGV9TNPBhHniizztDiQWimwV+I
         1TAzr3t5r9Y7lrQv1oUuFAhiSAIAqJLagLuidOklhV6fbwtj7WpGhIn8Zndoeg/D44x+
         JUR29ZjyF2znVLS1E8Lw0zDkrjwiiChQLqqR7blzRzz3qKQ5fqsTOHavVlwQzu21PpN3
         RD4AjgYwb/MTE5jBLFaxIBdeX+R21Mw6a0R2/jIc/DsCu2QOlK2r9Iv4Iovh3Fqy6NH4
         uOiw==
X-Gm-Message-State: AOJu0Yxj/+rJbQU+nsee0iRvUTLLJAsl+EBehckVmzBu+EhNlcIcUREj
	wvUeV4IlkWvl2NtfsQftl2WbkY7ijft8kDDkOfVtomlD8PV0A3DCSYky3kGqv7NJ2jdw1cO86EW
	gSvw=
X-Gm-Gg: ASbGnctSeo/zh1WmBPSDjGptFPnFq5lhXHQv3IrnkD1SN5DWOHo8qHb7daF5IYgcN31
	t/GL1XppUpKp4ETCvur5o5DjDNi/PbCUn0D5gV7nE+5pnWKzUcT/uYCK+SDxyjWUy/gVvreJJ8Y
	SfXyeTlu4BCXp4T3RSkAwxFMf+uhtd3B7fJTWOtzGvrzVIHTt+X4/fa+E8IEm8FjJWYsZeTFOri
	vzwi8wn/2YgBzS3bHR9KI8jK8nHBMsNtwW77LSN1S2mDTIQQpZKXoADJDeuoBgFSUjwjDfjCsSa
	qE2pYl/xcF3jCy2W6CsXi6RHKaDp/vjUXOyL/DPggqk1aYg+EbALURpTv7vg5GcUp12SgrJyKVL
	dffjy1FS6QfN6hrMpmJRuDKh2fOpu
X-Google-Smtp-Source: AGHT+IGm00VcUtEQVKjIVqbEs1MmZs4xszdsRzW0/H15ZSkpSsdYVtTl5CBQXoEG5wWlWj0hAAkKWA==
X-Received: by 2002:a05:6512:308f:b0:54e:9097:6cb6 with SMTP id 2adb3069b0e04-54fb9630137mr802113e87.40.1746606462182;
        Wed, 07 May 2025 01:27:42 -0700 (PDT)
Received: from localhost.localdomain (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94c8e7bsm2266719e87.101.2025.05.07.01.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 01:27:41 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
	Sathishkumar Duraisamy <sathishkumar.d.cbe@gmail.com>,
	Khem Raj <raj.khem@gmail.com>,
	Max Krummenacher <max.krummenacher@toradex.com>
Subject: [meta-security][PATCH 3/3] systemd: disable linker warnings as errors on aarch64
Date: Wed,  7 May 2025 11:27:19 +0300
Message-ID: <20250507082719.1220303-3-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507082719.1220303-1-mikko.rapeli@linaro.org>
References: <20250507082719.1220303-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 08:27:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1524

openssl asm code is missing GCS branch protections and
linker throws a warning which currently fails the build.
Ignore the warnings for now since some branch protection
is still applied and only GCS is missing. Works around:

.../recipe-sysroot/usr/lib/libcrypto.so: warning: GCS is required by -z gcs, but this shared library lacks the necessary property note. The dynamic loader might not enable GCS or refuse to load the program unless all the shared library dependencies have the GCS marking.
collect2: error: ld returned 1 exit status

Cc: Sathishkumar Duraisamy <sathishkumar.d.cbe@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 ...ild-disable-linker-warnings-as-error.patch | 31 +++++++++++++++++++
 .../recipes-core/systemd/systemd_%.bbappend   |  3 ++
 2 files changed, 34 insertions(+)
 create mode 100644 meta-tpm/recipes-core/systemd/files/0001-systemd-meson.build-disable-linker-warnings-as-error.patch

diff --git a/meta-tpm/recipes-core/systemd/files/0001-systemd-meson.build-disable-linker-warnings-as-error.patch b/meta-tpm/recipes-core/systemd/files/0001-systemd-meson.build-disable-linker-warnings-as-error.patch
new file mode 100644
index 0000000..457921d
--- /dev/null
+++ b/meta-tpm/recipes-core/systemd/files/0001-systemd-meson.build-disable-linker-warnings-as-error.patch
@@ -0,0 +1,31 @@
+From 3bb29e3e924af117c0ade4f38d7c051897dd84e0 Mon Sep 17 00:00:00 2001
+From: Mikko Rapeli <mikko.rapeli@linaro.org>
+Date: Wed, 7 May 2025 08:02:17 +0000
+Subject: [PATCH] systemd meson.build: disable linker warnings as errors
+
+aarch64 builds with GCS branch protection have issues when linking
+to asm code in libraries without GCS support and linking fails.
+This happens with openssl. Ignore the non-fatal error for now.
+
+Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
+---
+ meson.build | 1 -
+ 1 file changed, 1 deletion(-)
+
+Upstream-Status: Inappropriate [configuration]
+
+diff --git a/meson.build b/meson.build
+index 957e00ecadf..0295a65253c 100644
+--- a/meson.build
++++ b/meson.build
+@@ -455,7 +455,6 @@ endif
+ # --as-needed and --no-undefined are provided by meson by default,
+ # run 'meson configure' to see what is enabled
+ possible_link_flags = [
+-        '-Wl,--fatal-warnings',
+         '-Wl,-z,now',
+         '-Wl,-z,relro',
+ ]
+-- 
+2.43.0
+
diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
index c53b1e8..ca470fe 100644
--- a/meta-tpm/recipes-core/systemd/systemd_%.bbappend
+++ b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
@@ -1,3 +1,6 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+SRC_URI:append:aarch64 = " file://0001-systemd-meson.build-disable-linker-warnings-as-error.patch"
+
 PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'tpm2', '', d)}"
 
 # for encrypted filesystems
-- 
2.43.0


