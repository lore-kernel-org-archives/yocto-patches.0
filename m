Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF5FCCD1BC
	for <webhook@archiver.kernel.org>; Thu, 23 Oct 2025 17:26:00 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web11.776.1761240351879819275
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Oct 2025 10:25:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HjufSzT2;
 spf=pass (domain: gmail.com, ip: 209.85.166.179, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430a5fe0c5cso9130565ab.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Oct 2025 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761240351; x=1761845151; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Juh7xiGBG6AVEZEzN/sKTm2cHJV2JGcj+T2JCm7bmAk=;
        b=HjufSzT29JeGdUXFW8t12OBoKL8QF11lATMC3c3uzBSsz374sompa5BVViVz/yKhC5
         sySoH5gB8rSi6pa/QsFhCXQa+QTwwIBk9PHHZ/TYQJtM9u/vdEZzqrmx82J/ClA0Y+38
         wMJzqfX9o7GNKz7K2mHcRaXgEuw11wGsHE3IyoxyYtc6bhEgn7HblRaL84FvyMnVjviX
         6LTo/PRI+7PC7YaAvG7dX/eV5XW0jaLCBEwm3ljEmZXHHd63bZCA3ZBsN7Ge6/I1aTAV
         NJHMTUjU/QHlbTibLhUOPVq/GWODWbtDmuDsF3cHMvPK9yKM0gUG//fQUCPerYBaiHbx
         ulIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761240351; x=1761845151;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Juh7xiGBG6AVEZEzN/sKTm2cHJV2JGcj+T2JCm7bmAk=;
        b=MvnZALPbugGZTza3h40yi7RiWonLHSym5fQVJ/c8u8Mm8YTOB+G+3qHHKTML3Ep20g
         w2IEAA6p1ufIZRqx8J2Tvwj2PHdGDZqT65hDCXPnRZkz7I3C4csnevbRb1j6G0d0ms4L
         tvMYQ4ORZJTAYjUZ8pTYFP3LxF/ry0wEOjUqzFmwAiT7cMMBJVGilrdxpyvTMzhRC/qo
         gzC12DVO9Y1IwFxEm0BtjKUwmtakshIDIYPpB0x1wJmxL/0kqHhgc8upEl/BjRRd4U9G
         a6fQDJ2vZoY8wpMX+dTDQRRVD5mCZVKg94vWf8dfB2qtj5QOPG88yQHZRDo8dx0Z1frP
         e5/w==
X-Forwarded-Encrypted: i=1; AJvYcCWozhlPZNcWqyejGx5gi4FY7I7q4kuyLMH4Mvps/zh4eG6XZuRfD2Zsg3mSFrOI9sMl2zw6jirlI8K+ol4h@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwVtpFkWcToDk4cTicL7zyB097cNVAXr73IHDtleVaEHj8l+uKG
	qZ/xPohoZUoCdtem0Cb+4ESzcjyfA2JpjpJs5E3pF8sy4e+KbavPzTCY
X-Gm-Gg: ASbGncuqDiz4MaSOphfqcOuxvatKjOZFiGqwyV31Modka3/Ra0dzDGo+eiq2s6C9bv3
	kESla5y++08ocJqpqH/e8GwQ3rdutD0Q0AxnF6Uzs5SiZGQn4cXvMLd+LCWpy3XJsVG+C10yEWz
	CX0Q8DFTFFKJI1ppMfgEdCFZHQJeEK+OCfWzwMSyH9M84Khq41iqDEy/oCLdWdd43E6MnNAerWj
	sD4breqFxuIbbbAivdMmqwKwteM0Pqe3FP7icbTpgGfWeb2G+JBPM5zIuWvDl+ZAwdHDIhYoxrY
	aBBmvtPycMXXcZJI61X1dgN6ZxyHV/MRQ4MpEmfFxaxrUySPZDVMVX7oTYS4fwMMvsczY8wUY/I
	vUgOqZyXcVzm+ernOkxzYHwaLOgVaEZyWaLBoW4aO/3FLk4WIAxgTDCFM6pLCO6PjH87wgjt/dw
	wlN4mnGMjlia4gpJI7IZ/OIDgZEfv28g/TnqX8paa0ccmrl3MCAIA/3XJCjkH/ZnmN
X-Google-Smtp-Source: AGHT+IFt0xe94jwi1NhyNE0dTc1M/M7uNVhdBbLAkNnlcoapXHoBbMBj960L6XHGdie1br63j4qbRw==
X-Received: by 2002:a05:6e02:160e:b0:42f:8d40:6c4b with SMTP id e9e14a558f8ab-430c5246f89mr389266595ab.11.1761240350972;
        Thu, 23 Oct 2025 10:25:50 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb0fesm1112509173.34.2025.10.23.10.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 10:25:50 -0700 (PDT)
Message-ID: <6a0ec0dd-a107-4499-af2d-219910649f7e@gmail.com>
Date: Thu, 23 Oct 2025 11:25:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: files - add
 files_delete_var_chr_files interface
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Oct 2025 17:26:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2388

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ernel-files-add-files_delete_var_chr.patch | 44 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0077-policy-modules-kernel-files-add-files_delete_var_chr.patch

diff --git a/recipes-security/refpolicy/refpolicy/0077-policy-modules-kernel-files-add-files_delete_var_chr.patch b/recipes-security/refpolicy/refpolicy/0077-policy-modules-kernel-files-add-files_delete_var_chr.patch
new file mode 100644
index 0000000..ed3ca61
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0077-policy-modules-kernel-files-add-files_delete_var_chr.patch
@@ -0,0 +1,44 @@
+From a8379a82beb37fbe36775575b8d43d1281342bba Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Mon, 12 May 2025 12:39:10 -0600
+Subject: [PATCH] files: add files_delete_var_chr_files interface
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/605ee571a04d7db29f61dc086ad4675793d94864]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/kernel/files.if | 19 +++++++++++++++++++
+ 1 file changed, 19 insertions(+)
+
+diff --git a/policy/modules/kernel/files.if b/policy/modules/kernel/files.if
+index 9ade962a9..7223210f4 100644
+--- a/policy/modules/kernel/files.if
++++ b/policy/modules/kernel/files.if
+@@ -6127,6 +6127,25 @@ interface(`files_manage_var_symlinks',`
+ 	manage_lnk_files_pattern($1, var_t, var_t)
+ ')
+ 
++########################################
++## <summary>
++##	Delete character device nodes in
++##	the var directory.
++## </summary>
++## <param name="domain">
++##	<summary>
++##	Domain allowed access.
++##	</summary>
++## </param>
++#
++interface(`files_delete_var_chr_files',`
++	gen_require(`
++		type var_t;
++	')
++
++	delete_chr_files_pattern($1, var_t, var_t)
++')
++
+ ########################################
+ ## <summary>
+ ##	Create objects in the /var directory
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 5554ef9..9d4f68a 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -92,6 +92,7 @@ SRC_URI += " \
         file://0074-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch \
         file://0075-policy-modules-services-dbus-allow-system_dbusd_t-un.patch \
         file://0076-policy-modules-system-systemd-allow-systemd_logind_t.patch \
+        file://0077-policy-modules-kernel-files-add-files_delete_var_chr.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

