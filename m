Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47474C282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 13:15:57 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web10.37350.1741612553251588926
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Mar 2025 06:15:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GTMeVB2s;
 spf=pass (domain: gmail.com, ip: 209.85.166.174, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3cfc8772469so11997465ab.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Mar 2025 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741612552; x=1742217352; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMBrx6hI2GGXb9EG2q/TlJOp4P1M8dxz6BTIUbdr8A8=;
        b=GTMeVB2sdXNdr5jwpYv8kAZwXIFPXdIPz7CUY2MPZ7VYwnqFRg6Q6hvdbVVC/Wg5ts
         OP26LxPo2j8y7H4VITQO7TzznPJo0R0l1OppymZZLf2vGYtjLOCWN5vnN4uJMG1H6rD6
         ZiPZaUFQWJYsHsKCpuviRjYb5TwHU8/MrwolUrPeKcYox7ceQFaTPr3xtXoAw605cYJb
         oE84AFKu2/ld4ylOnvOO4G9/26QKqSPnCICdUxZ4r2GcT/NoKOg5+rQcHkzImpOEJ3jk
         CZ93tXMT1cJ2B4vtDjaPk7Txi3XEeYnbgUWzPiWqJ3u3xsxHSDfiTjr81F35360azs+O
         /qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741612552; x=1742217352;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SMBrx6hI2GGXb9EG2q/TlJOp4P1M8dxz6BTIUbdr8A8=;
        b=hXbvIt/VIRQ56N0TJupxYqg3RPICKF0bYSegu9N6D7X1N2CIz6n8VGpsTVSf7rReyo
         sx3KIGxBVo14w+0mhbz1ym/wrwH8eHTznIdeY7ElOHXssW6++soRll7vkl6rUDbe/ASL
         Xyx1TzcbvynnCImGGe2Cb+GdZHxxLOjrr+RI4B5JBCJMjLHn2Dk7OX1K9mJi5eGiwwtn
         HdIxyvFcNzTzqYOzy/USB4af94Kf5j2eEPd8sXDhzLgLoqdGeph6ym3BJ5CxIsKLtlJ6
         tvefsAQvlDybDXhqnrc0WRsWJV337Xi4qkyRM3tp+seeUVVaOa893XrzQ3QizL7GpbxN
         VMpw==
X-Forwarded-Encrypted: i=1; AJvYcCU0hxJZsPy2aTYqRR8KE4drHLSe4aCsdztDZzAFzMERKZiU5wXfHseFfba0rs7ax8ZBtEEFvCPtZBO1b4vP@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxK30m+oj0w6Qo/VhyLCQor7dcl6s6aWg/EdXbsTXH6GZDhXG/J
	M8cMNJg5HKdA2BISXL3BHGrkUgDqFtcxtMmYIhnmuHiBRi9xf4H/r+rWWQ==
X-Gm-Gg: ASbGncuCkCtx6Tidln8x/mZO9Hq0IVezLOd+u7V5aQ7hkHqRMP7KajZU31Uw8q24tx/
	42CQDqujnoQGkjgwfWACvSVePi6m8e6xjkHj527XMtj4M6aauuT2c4fiWldJgqxHH3/Anrv2n5f
	ohAmfHM8Iw1winsouQ0XSCRbFyB2dZNozbGj1HOoWhXPjqsm85rK60fPs3Eag2MnqUMf8szNDgy
	sIJTfWyoPaQ4rQdR4XFqBb2X8cl5sUXW+7XtdsvBUYrsdRxbrlc1RzIMtta0ahgKdSssWDwMXpJ
	s8ruFT7SD1feywAkEKWjZMtqANAZin2e8CXncsgzW5lFYoK7ErEqDXSc/m4DtsMICUtAd5QG+0x
	d6t3tLR/te993jg4CIK6EYA==
X-Google-Smtp-Source: AGHT+IE7l8C0KjmWE+KNAbqIbTo+sNP7PEv1XTSsUp2UkHUz273wR3EpzR0Qs24cqtUw2sgtOn0k6g==
X-Received: by 2002:a05:6e02:3f89:b0:3d3:e284:afbb with SMTP id e9e14a558f8ab-3d441992552mr149645615ab.11.1741612552410;
        Mon, 10 Mar 2025 06:15:52 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2273ef14dsm1235168173.140.2025.03.10.06.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 06:15:52 -0700 (PDT)
Message-ID: <9de40596-ec6d-475e-b039-a6c80547761f@gmail.com>
Date: Mon, 10 Mar 2025 07:15:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][styhead][PATCH] refpolicy: authlogin - allow
 unix_chkpwd to run
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Mar 2025 13:15:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1171

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

Maintainers - resending as mailing list bounced

 ...ystem-authlogin-chkpwd_t-dac_read_se.patch | 30 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch

diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch
new file mode 100644
index 0000000..9155c85
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch
@@ -0,0 +1,30 @@
+From 390fc1607c9c9f7e79adc74386d8503a7c9bf9cf Mon Sep 17 00:00:00 2001
+From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+Date: Mon, 30 Dec 2024 15:58:17 +0800
+Subject: authlogin: allow unix_chkpwd to run
+
+denied  { dac_read_search } for  pid=27506 comm="unix_chkpwd" capability=2  scontext=system_u:system_r:chkpwd_t:s0-s15:c0.c1023 tcontext=system_u:system_r:chkpwd_t:s0-s15:c0.c1023 tclass=capability permissive=1
+
+Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/796d0335f6b975c9d075525d62ec8e854ce5beef]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+
+---
+ policy/modules/system/authlogin.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/authlogin.te b/policy/modules/system/authlogin.te
+index f33a8095f..3c3740dc4 100644
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
index f8e5f10..0c3966d 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -72,6 +72,7 @@ SRC_URI += " \
         file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

