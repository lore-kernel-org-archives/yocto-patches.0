Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF69CCD1BE
	for <webhook@archiver.kernel.org>; Thu, 23 Oct 2025 14:12:53 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web11.22298.1761228769488928744
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Oct 2025 07:12:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=G7E9VGSC;
 spf=pass (domain: gmail.com, ip: 209.85.210.45, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c2948b774cso667044a34.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Oct 2025 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761228769; x=1761833569; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Odyz1DRoDIGGtt+H+aY0OQnJDkfq8TRiDvjLSgyuMc=;
        b=G7E9VGSCf1zaKQAvgmNjuLlfM8K59G9ZxURHLyqW2PDKYXdnimn0Hu8lVVXaJlgmLL
         9stpm8dt8yFEn2MTVJ+opj8ACc5bJ9x41hzSTw7z3Wk2INmm8KuiICeLeOoMrE52R6lf
         8Yyw8pG5nswLBxq+g0pl8GR7D7ZthHk+GNW0kn6iMZBjmlm4ntYRrB1ekTeefzUKSANi
         L6X62xPxsasl9l2s4ucs8t9djnupjrCKK26X7mMYkB5ODQiMsmCz62HjqmqdJEKHyf9I
         M5kdLchMXwWo9LrJwmLxacSnnIVI+3sz2iZV33pQ+nCKlvuj3WZstxM4BWC7imtbMiVm
         nX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228769; x=1761833569;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Odyz1DRoDIGGtt+H+aY0OQnJDkfq8TRiDvjLSgyuMc=;
        b=lbbiq6p3VijrD3DG757b6Kp21tuMTL9OM+RewgfzNswlesRnZZwdSzX82/gNcialR9
         ++0W0yKFReiafGdxP24+7AfBx2ke7/zYL+lzMh7Gx6hrfgPy/ChV4Dk+B9u9eFVo690B
         OXb6NrrWBzxtTJ9UYCuExfTyK0zNXyYyZFn6D7Pkc3yAqChTn+Zkha8UUSoFg2LNsXYl
         1DBLtzhrQoMpwiIiWKEsS4YfR/13DmX0gfd+yQDhbE0+g4sSydxOom/xmsNflL4qtWod
         +CCL7mYODevQ1du/fGjt2n2gOAPjhJRCsgvxUg+DnOccld5C7M1ZrpMBVzhqq5JJEFoD
         vgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3t3qFaXhhO8GoOWQCWHG5Ig1I7DA4EkUehHr2U3GcRBGIkrDggXHGGtZhY3VlqeiA9/96T6PLn5PFeT66@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzfMn7aNlkpmFcy/Dnv5FCz+Vyc7M9UoJG7ZZ1CXMZZWZbilUUk
	ZsVZDzx9uhml35XN/wfvcdPyPHzNA5IBtPTh8Pa9bGrIFda5O2jnB2MW
X-Gm-Gg: ASbGncvoogLPTXcQ1jRs0a7HFXP30z8ukBsS52Aevo7TCLDBInESIaBIZFZ5ivaST2X
	jKn4+LlG/R51bQNsywfHYKAUbqLojo7KHtcXqHr10BbsB/ENojG9dOqgGclmmAmx21xR1d/4WeN
	Rwmz2Dj3bI/hU82BTAg74wukG1h9jCQt7eFZw0iKQMFmbZ1qlBr0s+7ubWnp9jriTVRQX0Icqhr
	U+gXDltWjTYQS1rsqSMWlPRqWN75D9ayEKxFk1XW3f8K21KAnFAwsivyVZspjTY4ku68UX10NHU
	c7dKUZR9QCTeCGRaSA8PutMJZCGt1iM//AU6LOorOX3YSuSbIBK+QymaWRWzI9hslCi0BZyDUIt
	0Q47IsuQ9m4+vDWFFGXM/T/vCaNDUGTqbY9a+y/3702KsP5IbpUA3bI+2UvjHCQadfwXoZqG+Yg
	Q19f353k8i0bPYIPS4UkpqVtp8xluGLsU9tfPcDkTDse/DcWquovkxIKaz5p6UzKUP
X-Google-Smtp-Source: AGHT+IHfi8pHpqyPAyEe8S8pG7FrUY8zUNoRVwp+UQJRJZbROgcNg0k6bs0x6jUoACZo4w6zug3UFw==
X-Received: by 2002:a05:6830:64cb:b0:79f:19f:805 with SMTP id 46e09a7af769-7c51118c010mr1165444a34.7.1761228768661;
        Thu, 23 Oct 2025 07:12:48 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c51b03d909sm645976a34.20.2025.10.23.07.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:12:48 -0700 (PDT)
Message-ID: <4d8aa739-2dc3-4de4-8820-ae2f4e0547f7@gmail.com>
Date: Thu, 23 Oct 2025 08:12:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][walnascar][PATCH] refpolicy: files - add
 files_delete_var_chr_files interface
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Oct 2025 14:12:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2387

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ernel-files-add-files_delete_var_chr.patch | 44 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0066-policy-modules-kernel-files-add-files_delete_var_chr.patch

diff --git a/recipes-security/refpolicy/refpolicy/0066-policy-modules-kernel-files-add-files_delete_var_chr.patch b/recipes-security/refpolicy/refpolicy/0066-policy-modules-kernel-files-add-files_delete_var_chr.patch
new file mode 100644
index 0000000..9737182
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0066-policy-modules-kernel-files-add-files_delete_var_chr.patch
@@ -0,0 +1,44 @@
+From fb889271b4be21f477f279dc688ac491437797f7 Mon Sep 17 00:00:00 2001
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
+index c590d24de..c6fab80a2 100644
+--- a/policy/modules/kernel/files.if
++++ b/policy/modules/kernel/files.if
+@@ -6186,6 +6186,25 @@ interface(`files_manage_var_symlinks',`
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
index 33c3f32..44ac113 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -81,6 +81,7 @@ SRC_URI += " \
         file://0063-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch \
         file://0064-policy-modules-services-dbus-allow-system_dbusd_t-un.patch \
         file://0065-policy-modules-system-systemd-allow-systemd_logind_t.patch \
+        file://0066-policy-modules-kernel-files-add-files_delete_var_chr.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

