Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9672.1795884888952203802
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bAenWXhu;
 spf=pass (domain: konsulko.com, ip: 209.85.128.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso83900705e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884887; x=1796489687; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o/Q9kyoq/CbMGNzhJaxuZAIW6sAr2uwvKWN1t5YT9F4=;
        b=bAenWXhu9K4sLZz1+YIPSOFe5V9P/OZQUdRmNF5Ihmvh1VOPRdTqlUoK5yKsQAdpoR
         aEwlSprTUcgnFWuIjo/+KGtpbKuPRiCxo43ZdrPRpsaGWe7YWmztLEBtR5aJohkWsN34
         EjDlrM8QbRf2IJemUawv/Ym5Uof61fC/fUNZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884887; x=1796489687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o/Q9kyoq/CbMGNzhJaxuZAIW6sAr2uwvKWN1t5YT9F4=;
        b=mJvLmv8/wA3htzoJymfbyOiNp387eb5DDssrwRufYTp7Xze4jGvR+dzaolYgWuGgai
         mRWIQaMVZIwS+/ProIftVjRcwfaU7RXC09N5BgQFr24KTmqgccNu3rlW2pkFFNfCAyzw
         D+k8FGMGML4i2D/Y4+oqg5Qxp2EnE0y3/KxQWadvaO0GpGgH8jufJbSK2V8HKV17cy8B
         xj/3WWSfQO9tgQ9VJZ++EmXavwNmG5Qizq0j62KgEJ6cIAWeOxEoli0zrldaHz7pVZYH
         jjbtkDOzrEIUhyq7JRMrl9g6crUawCYMh7dRAmLtA4WDsVMvSdKDN2TeKB9dudNFd0q8
         nMog==
X-Gm-Message-State: APuU4Z+Fjvqr6mRaVEj58hjLWOdovggSVmLpXv3kXcQ9HL6aqFD3X4Rt
	+zOwRhNn3nyBaOThfB2R6fqYVcxKgHBLt5muIgQ7wzItxhExvQH6tPr6mh6i4Ig1LHM39E82ojP
	DMRLH+ig=
X-Gm-Gg: AZFdTZelvVQbEjtmI3F9lIH5RDssb3aIEr6K2lZaWst9V1P42svx7Ju1Lpg2ZHaaQxH
	tQPifbkWtOV+y2l1nQvQEMr8RSL4nh1DvBlrb4swIGmkCXgq/YBUccuSAOaIRBo4fS0lZFo5ZqQ
	AiuBSI+LCz3ChyX7XwWDngrPsTh2fWIk8wZ7ILhcNpnlPrkATa9bNkBR4xFH6/fAgjPl6T6JJo5
	oDdPDxawiXnJzF2k4WDxD4p9cSN+nfFb8I6JXycyT3ykkNeJzubuYKGwq6P27X7TMZRLELJSFDe
	GiFy35dLh7KFGzzkvkXJsoBonvXkkMBLP0XegYyvPJpNeUo8awdFWq/xnuxDy5K7oI4yTi3Jz+6
	HBIU88ZQuUz+EGFo1gUsFzKtBP26XmO/mQ46NcdJVHJ4UCsvUEZeicP9/6EpiLfn4BCrULXD2X7
	VJXJy3P1Q6zOLR7KsLpj+GwkX6gSSLCWtwk5qnDXYrmWan8a2hiSHvd+fI2gm8qq4V2CtGDxhZW
	g358XpXYFoAvswZjG0i2q+E0QiJVwmfulz++UrwgIMo2YlFm1ahxjw0ygk8ZNHBgoqTHyeuGakN
	8PvacVQqqcHxHKBWsINMUig1DAUFAh9Cmh6IpDZwxCCzIt8xC6i2iHxg7shXN8gpxu4dTiseihz
	0T5Gd/bqUbKHOqWSx7qz6ZfaP8j7rSjE=
X-Received: by 2002:a05:600c:1d29:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4bb88804d4dmr599843475e9.7.1795884886571;
        Sat, 28 Nov 2026 08:54:46 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:46 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 00/14] Assorted updates 11/28
Date: Sat, 28 Nov 2026 18:54:18 +0200
Message-ID: <cover.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:54:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5570
Content-Type: text/plain; charset="utf-8"

This series backports recent contributions along with a handful of
package updates and build fixes from myself.  I have pushed them
to wrynose-next, and plan to merge them sometime on Tuesday, Dec. 1,
if there are no objections.

Some notes:
- The upgrade of python3-tpm2-pytss to work with tpm2-tss 4.2.0 is
  not feasible in wrynose due to latest python-tpm2-pytss needing
  a newer python3-cryptography.  I have upgraded tpm2-tss to the
  latest 4.1.x release, 4.1.6, instead.
- Some modules in the dependencies of crowdsec 1.8.2 need Go 1.27.x,
  ruling it out for wrynose without using the Go mixin layer.
- The oe_cargo_build removal in the suricata recipe has been tested
  with both wrynose's default Rust, 1.94.1, and 1.99.1 from the
  Rust mixin.
- The parsec-tool fix for Rust 1.100 has been backported to cover
  the Rust mixin upgrading to that version in the near future.

Scott


Changes:

Francesco Dolcini (1):
  systemd: do not enable efi for tpm2

Niranjan Reddy Mekala (2):
  swtpm: upgrade 0.10.0 -> 0.10.2
  swtpm: backport sysusers and tmpfiles support

Scott Murray (11):
  glome: update branch name
  ding-libs: update to 0.7.0
  swtpm: Add missing useradd inherit
  dm-verity-image-initramfs: Fix IMAGE_PREPROCESS_COMMAND
  parsec-tool: Fix building with Rust 1.100
  suricata: drop oe_cargo_build usage
  suricata: Upgrade 8.0.6 -> 8.0.8
  python3-suricata-update: Upgrade 1.3.6 -> 1.3.8
  tpm2-tss: Upgrade 4.1.3 -> 4.1.6
  aide: Upgrade 0.19.4 -> 0.19.5
  sssd: Upgrade 2.13.1 -> 2.13.2

 .../sssd/{sssd_2.13.1.bb => sssd_2.13.2.bb}   |   2 +-
 .../0001-Update-picky-asn1-x509-version.patch |  47 ++++++++
 .../parsec-tool/parsec-tool-crates.inc        |   4 +-
 .../parsec-tool/parsec-tool_0.7.0.bb          |   1 +
 .../recipes-core/systemd/systemd_%.bbappend   |   2 +-
 ...ll-sysusers.d-and-tmpfiles.d-configs.patch |  86 +++++++++++++++
 ...2-swtpm-sync-sysuser.d-with-tpm2-tss.patch |  29 +++++
 .../{swtpm_0.10.0.bb => swtpm_0.10.2.bb}      |  13 ++-
 .../{tpm2-tss_4.1.3.bb => tpm2-tss_4.1.6.bb}  |   2 +-
 .../images/dm-verity-image-initramfs.bb       |   2 +-
 .../aide/{aide_0.19.4.bb => aide_0.19.5.bb}   |   2 +-
 ....6.bb => python3-suricata-update_1.3.8.bb} |   2 +-
 recipes-ids/suricata/suricata-crates.inc      | 101 +++++++++---------
 .../{suricata_8.0.6.bb => suricata_8.0.8.bb}  |  13 ++-
 recipes-security/ding-libs/ding-libs_0.7.0.bb |  12 +++
 recipes-security/glome/glome_git.bb           |   2 +-
 recipes-security/libdhash/ding-libs_0.6.1.bb  |  12 ---
 17 files changed, 253 insertions(+), 79 deletions(-)
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.13.1.bb => sssd_2.13.2.bb} (98%)
 create mode 100644 meta-parsec/recipes-parsec/parsec-tool/files/0001-Update-picky-asn1-x509-version.patch
 create mode 100644 meta-tpm/recipes-tpm/swtpm/swtpm/0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch
 create mode 100644 meta-tpm/recipes-tpm/swtpm/swtpm/0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch
 rename meta-tpm/recipes-tpm/swtpm/{swtpm_0.10.0.bb => swtpm_0.10.2.bb} (82%)
 rename meta-tpm/recipes-tpm2/tpm2-tss/{tpm2-tss_4.1.3.bb => tpm2-tss_4.1.6.bb} (97%)
 rename recipes-ids/aide/{aide_0.19.4.bb => aide_0.19.5.bb} (96%)
 rename recipes-ids/suricata/{python3-suricata-update_1.3.6.bb => python3-suricata-update_1.3.8.bb} (90%)
 rename recipes-ids/suricata/{suricata_8.0.6.bb => suricata_8.0.8.bb} (92%)
 create mode 100644 recipes-security/ding-libs/ding-libs_0.7.0.bb
 delete mode 100644 recipes-security/libdhash/ding-libs_0.6.1.bb

-- 
2.47.3

