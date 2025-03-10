Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D06C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 15:08:28 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web11.40178.1741619300887139646
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Mar 2025 08:08:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I6ZkRQS9;
 spf=pass (domain: gmail.com, ip: 209.85.166.179, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d44ce2b5d5so4916575ab.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Mar 2025 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741619300; x=1742224100; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU5iHjhVqdNEHobGSY5drV1Ihu6CZTeds0bBPr11zP8=;
        b=I6ZkRQS9MDpkaj2luVWshCr5UtbPgw/ApwmFFeTXac3XUA+/2PkdER8WCfpKp8Fspf
         ERb/b8x16eytWRwQ/IL2NdfwRxxBpNP+32Cj9QC7ux3eYOIKjGK+Z8alFqQE1ykRcZgd
         hI/Xxm0f2P+UbaFGvgak/cavjTIncgW5KyVNFuEU5ZZrqKr9TCSzyDcaOTcEc63zoSS3
         tITYcCTlBF8LdotxiaU7vBSCbA4wssekNoD3GTIJXx2qSKRXOpkrx42EAAjzqJA6U/d4
         hE/UShwYwfZ+iBgB+6nz3t/W1fBPHfMEYOyV4QqCh2rv/M5thZbDX2CaW2OQlleeGLnp
         e1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619300; x=1742224100;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PU5iHjhVqdNEHobGSY5drV1Ihu6CZTeds0bBPr11zP8=;
        b=pYAczSdN5Jch0Nl+7r1YX4Y1V7BkrMJ+KUL5VzngarMJa1JKn1ilZwCrGAXB6bVKtc
         mu75MCt8D8JSPbvJeJWzMNibStSRD0jsSfgBEc+eY2HcMlTJLvXnKpCjnG4J0qi7WIfF
         oyZ7XBsC+BA6WS/jeUpZnbEnDVAcY8tu8LNHbTAITzwVmpLDfDe887MPtVm2ObppBvE/
         uhMajek55dMVn7lB69fLhU18RWZiKZWEbqQ2tZwRheiZ9EGo6juQqG4/3MGANXqtobN7
         5Ow/cxEh667X8gP7GjET1WKPY7F2bsS5AHEp+vHlG0uLV4IRcR8F/6JOiTU6cgSAKYHr
         1W1g==
X-Forwarded-Encrypted: i=1; AJvYcCUygNjz8m0cE4f+EWSz4nlGaGYoINm2n6cj2seHXVSFfkwH53yDMp+/q95Z4FhxOIK924y5y49uN6yMXFjr@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyZb/uoC3RRaiZgRzEkvQ9AtpQYgRoltnS+n5LiB/JQkeYCBynR
	+MQBssW1aMcV8IOYCpk30th0Vy9wnToE8mvB85E6WkPIiawAKOc+
X-Gm-Gg: ASbGncscqsdp/AmdpfzceflzEDnaO/q6iSU0E8vjlzDpPe/AJPru47YZZQ5k0t/yd3S
	5gAxmT+YF6qDeqcKnOv/dCtHlryUh3cI/EFnAY+SBKfHEljeiqe8wj4GM6nuV3fu28z8JdZljV8
	4xNTJMYy54xLsJj+rL0V+zHTVaQm+fuiwAAQbFLXuLb/Kb/pavfGgCmtDyqe/5RPJwmAJmEqkcG
	yx068LVFD0ovJjuEONdUZiS1C+RzOr3IzHLAp13mWrAGgGeAUEUbMKJMZ++/spgi6JG15F4IW7c
	ygQfB54DXlPOhOtcBofV2VQvNmTGsxiqRL9NuPg113n6wPIvd2iaiiXlNo5jXhamKZLEXkEB/pX
	GdH1UflPQnNrqHQqQNNEb+A==
X-Google-Smtp-Source: AGHT+IGA4WyHkG+Dog0+RiM9sM+XS3a3RGqolDpEVbrzLCreEDBHZ7AHo2nEnWqaKBgNinFPfxpOIQ==
X-Received: by 2002:a05:6e02:156d:b0:3d3:fdb8:1792 with SMTP id e9e14a558f8ab-3d441a39d87mr107457435ab.14.1741619299833;
        Mon, 10 Mar 2025 08:08:19 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d45bf4728dsm5241295ab.57.2025.03.10.08.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 08:08:19 -0700 (PDT)
Message-ID: <85d754cb-489c-40fe-97af-d5a2452f068c@gmail.com>
Date: Mon, 10 Mar 2025 09:08:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: authlogin - allow
 unix_chkpwd to run
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Mar 2025 15:08:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1172

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

 ...ystem-authlogin-chkpwd_t-dac_read_se.patch | 29 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 30 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch

diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch
new file mode 100644
index 0000000..d631a28
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch
@@ -0,0 +1,29 @@
+From 92091366d5beda7096a8845b822049372e57ca97 Mon Sep 17 00:00:00 2001
+From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+Date: Mon, 30 Dec 2024 15:58:17 +0800
+Subject: [PATCH] authlogin: allow unix_chkpwd to run
+
+denied  { dac_read_search } for  pid=27506 comm="unix_chkpwd" capability=2  scontext=system_u:system_r:chkpwd_t:s0-s15:c0.c1023 tcontext=system_u:system_r:chkpwd_t:s0-s15:c0.c1023 tclass=capability permissive=1
+
+Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/796d0335f6b975c9d075525d62ec8e854ce5beef]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/authlogin.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/authlogin.te b/policy/modules/system/authlogin.te
+index c8e2954cb..1c862bbab 100644
+--- a/policy/modules/system/authlogin.te
++++ b/policy/modules/system/authlogin.te
+@@ -109,7 +109,7 @@ optional_policy(`
+ # Check password local policy
+ #
+ 
+-allow chkpwd_t self:capability { dac_override setuid };
++allow chkpwd_t self:capability { dac_override dac_read_search setuid };
+ dontaudit chkpwd_t self:capability sys_tty_config;
+ allow chkpwd_t self:process { getattr signal };
+ dontaudit chkpwd_t self:process getcap;
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index cc3bb4e..c8a8ac2 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -72,6 +72,7 @@ SRC_URI += " \
         file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

