Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2A6E77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:03 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.152482.1734703499013048400
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:04:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=kAwhBDA0;
 spf=pass (domain: linaro.org, ip: 209.85.208.170, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30033e07ef3so21276711fa.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703497; x=1735308297; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPNv+pAmArJPJEoFodWx5cgDD6i+5wOtp75QbIJ7Xow=;
        b=kAwhBDA0U8rTWqG8Se86UIO0KG6BYaNjnHorpImZK+lsZRfIh0Cp3WOGumkQaSu8NG
         8OlEDnqRhRgVXpJNw53KPlfRYeeQ0t4QJjp08hbOw0r970Uv51FVHtPscETGJdKWhuvK
         XK5Rad+zM0p0nXDgP09oO8EdJ3/M+3AyB5/AyeFy4r9ZScG8DmiEtiuS62oIlGHuFhDo
         NX0vEGBoi9OhK8/96wpstVJ1pOIAEPGX/YNr+6PL2+otEZAs80aJ390cWQiWsk/tV2Me
         sdXRQDCLk9/omNi3ZV6z7tFcPcsnE8REkfcD8EMz7jv5dN0BXD0NylXcCipS3pe+k4sE
         3fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703497; x=1735308297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPNv+pAmArJPJEoFodWx5cgDD6i+5wOtp75QbIJ7Xow=;
        b=ooNT9fE3/J2xyaDHy+ip1dbAqeOWL48NSaymYRdQTCS2Mtto1PfMvOfxlAtFa5UvV9
         k3NWLnPX/IevIAdU2qaJofMCtcn78xiAPa7JSjbKPJKkNggFG3SLYTwMti8qOoKpECQg
         Olt8aWlV6SZpWdieeuglxj9HYMVWjsMo1+UfXy53s0LJJwbpEHqvdwkfXdfZ4s1l16PC
         LZTcMm09qGpzyom+oG6eC3YK+FlsQi9T8QXM8gnMg7Mt2y44ZWjjIQQ+biiqV9SFGNXO
         xKBoVuvHsW4+2XChw7ncyRAzTITfveXYrhuqLnzVeIYfJ6fiIABf3iSSXsa2Hl+Ns1kj
         0v3A==
X-Gm-Message-State: AOJu0YzMYAvaaFmi5Wpz7Wa6M8rU0cDuXZJCkT/ueOKcUyWIagXFejse
	sMc87nJT64FIB5xuGql5AS1kWZHU899kMYo+mq4TftVULuSwp4+gTqcKTJZAK7+X5RvBQjg2hlI
	EUbQ=
X-Gm-Gg: ASbGncs3eCSpb3gUQGfs4nP7/AlZwM77jv/SKf8LpSLcrHRHZsUnMJY22na8cvHExkV
	vyONQrbZglgUGRm8kc0zNq/6dd93S+hkH2fXW+2yymuPd79qyfH0Upd7FJvP+65Py7X7mvRaq0C
	Gjs3l8y4P3OqE727lnqARH0+FHwLGvXjgzdChuk1+GAVT8XdiJlOV5TdIsrO+ke4U3VBWfwYkUV
	H7Iq5oW0+Y5K+G8166OEN8Un4nKBS8wUz0BpXm05y4FGUWQllkwSTYB5I/VXJn06hD85tFNUPLv
	/+fgSQcFNCaaguGNlP5mXeH9gQ==
X-Google-Smtp-Source: AGHT+IHdzhBveIuVPQ6mHFQHKhyMOIH95bsB1R+i3GeAOoSwyCp+kZDWAFpOTamX5STHhM7zNtr7uQ==
X-Received: by 2002:a2e:bc1f:0:b0:2ff:b8f5:5a17 with SMTP id 38308e7fff4ca-30469ac7ae6mr10088731fa.5.1734703496932;
        Fri, 20 Dec 2024 06:04:56 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:04:54 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 00/18] various updates
Date: Fri, 20 Dec 2024 16:04:23 +0200
Message-ID: <20241220140441.271395-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/939

Hi,

I'm trying to setup a build and test configuration
which uses swtpm as discrete TPM device outside of qemu
so that TPM device gets used from u-boot firmware to all the
way in target system with systemd.

The final build and test configuration needs more work but
these updates have been needed so far. A lot of the tests
executed via kas are currently failing on qemuarm64 and hence
these changes. Some issues with smack etc still remain
but these already improve the tests a bit.

I'd like to know if there is some specific test configuration
used in CI or similar, then I can try to make sure things
work there first. I'll do testing on qemuarm, qemuarm64 and
possibly genericarm64 if that would be acceptable upstream.

Mikko Rapeli (18):
  kas-security-base.yml: replace debug-tweaks
  kas-security-alt.yml: fix systemd config
  chkrootkit: change download from Ubuntu to Debian
  apparmor: update from 3.1.3 to 4.0.3
  oeqa runtime clamav.py: use curl if ping fails
  libtpm: update from 0.9.6 to 0.10.0
  libtpm: rename to libtpms
  libtpms: set CVE_PRODUCT
  swtpm: update from 0.8.2 to 0.10.0
  tpm2-tools: add dependency to efivar
  u-boot: enable TPM support via "tpm2" in MACHINE_FEATURES
  systemd: enable TPM support
  systemd-boot: enable TPM support via "tpm2" in DISTRO_FEATURES
  harden.conf: exapand debug-tweaks
  linux-yocto: enable ecryptfs
  ecryptfs-utils: depend on ecryptfs kernel module
  oeqa runtime clamav.py: skip test_freshclam_download with systemd
  oeqa runtime ima.py: skip without "integrity" in DISTRO_FEATURES

 kas/kas-security-alt.yml                      |  2 +-
 kas/kas-security-base.yml                     |  2 +-
 lib/oeqa/runtime/cases/clamav.py              |  4 +-
 meta-hardening/conf/distro/harden.conf        |  2 +-
 meta-integrity/lib/oeqa/runtime/cases/ima.py  |  1 +
 .../distro/include/maintainers-meta-tpm.inc   |  2 +-
 meta-tpm/recipes-bsp/u-boot/u-boot_%.bbappend |  2 +-
 .../packagegroup-security-vtpm.bb             |  2 +-
 .../systemd/systemd-boot_%.bbappend           |  7 ++
 .../recipes-core/systemd/systemd_%.bbappend   | 17 +++++
 .../{libtpm_0.9.6.bb => libtpms_0.10.0.bb}    |  8 +-
 .../swtpm/{swtpm_0.8.2.bb => swtpm_0.10.0.bb} | 10 +--
 .../recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb |  2 +-
 recipes-kernel/linux/linux-yocto_security.inc |  1 +
 .../{apparmor_3.1.3.bb => apparmor_4.0.3.bb}  |  8 +-
 .../0001-fail.py-handle-missing-cgitb.patch   | 74 +++++++++++++++++++
 recipes-scanners/rootkits/chkrootkit_0.57.bb  |  2 +-
 .../ecryptfs-utils/ecryptfs-utils_111.bb      |  5 +-
 18 files changed, 129 insertions(+), 22 deletions(-)
 create mode 100644 meta-tpm/recipes-core/systemd/systemd-boot_%.bbappend
 create mode 100644 meta-tpm/recipes-core/systemd/systemd_%.bbappend
 rename meta-tpm/recipes-tpm/libtpm/{libtpm_0.9.6.bb => libtpms_0.10.0.bb} (76%)
 rename meta-tpm/recipes-tpm/swtpm/{swtpm_0.8.2.bb => swtpm_0.10.0.bb} (92%)
 rename recipes-mac/AppArmor/{apparmor_3.1.3.bb => apparmor_4.0.3.bb} (96%)
 create mode 100644 recipes-mac/AppArmor/files/0001-fail.py-handle-missing-cgitb.patch

-- 
2.43.0


