Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECF7FC9EEB
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:30:25 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6731.1772879417313540041
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 02:30:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qxUxz/7L;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899a9f445cbso124252956d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 02:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1772879416; x=1773484216; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwC1L+bUrWU1MvMN/+EZsfC8wocMbm/+GuqsfxpatoI=;
        b=qxUxz/7LGeWYLyGVK7LypJmoec629jvjgecQwv6dtb3OP1dToNScv4/YQVbQo57W1q
         S+Ih8EMVcA2Phk+HK8Pf0r5dtl/kTFgTJjbnKUMybj/I1FrgRf347ccKzSKfxboUl7nQ
         +/XuPc51cKHiwummyEK+an3Ix3FuusdwrfuNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879416; x=1773484216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwC1L+bUrWU1MvMN/+EZsfC8wocMbm/+GuqsfxpatoI=;
        b=uf2jtCzcLb+IAfZREufNVLi5inE8bzZ+EypVC8Si2WvmKsqo5H2TRSaPbhLon8epoe
         JcBzH8cz8P0gEFLHsjZS01Hv4YIiEUYBwpO7EdcAV3tWWOHP3ZxBdb7oZ2IMNkKTlQ74
         HDWG2HHqDCfaUC/xsxhVmJIHDESFwcwm8ECJW+qzzdo1w4qyvnTVO5+ddzRPUuCaeWA4
         UcZI6JmgsgMiR/Dg8tJf4H6KQIf60zPwx5q9KJZMIOl5Gbeu3LI616Zp620oLEoRfV1G
         2pi3ZBZnkSthK+wQaufI7EALeJ/r9pC2xNCYsgZUrklNSxcmwHvnhYmwa+G+JNWv2BRI
         FJtw==
X-Gm-Message-State: AOJu0Yw8ugHZOQ2F2uhWM0/D2wx38HP4JFG3mXT+N8dhUr8AUWPLBTj4
	tb8jaur4c9BExaXIAYYiX7hGjef5Urv58uIf+g/ngU9H+XfcK7bMZ0NWVlf/nZW1q5ayFHAXAXz
	or8PS9Ag=
X-Gm-Gg: ATEYQzw6qiauGJx/0a7oQddN7RduUFaw+fW0S08EXx0eSnlfwb7HHXvNsHcTrPZ99Z6
	zbGL9zZoAFOfeNFrcmt3cRffZf282ECSwdDPkyR+jCFBoUArax9XR1iCiroqD1GE4Qlo3CPIH8Y
	4Az7OPPA3MkVu5XMqce/wIyehtMTDhD2i5NS5/e4qZhrloq7dL8d6kpppwIF7dhG/uYkMOOe4EZ
	jt1ypSm2u8NTSXnOZezaZw+tpu/uDHcxZYZ7KvQnn0+t4mSh7TyOT9SU8ThrVyUCO586UPQLQAf
	h3w5hJzKKNYpqlw/bXxU35GjfOIQ7bocYplkhU2UHNqOkWrYy6MvkIa+OunDexuIyAAvzc3J5PV
	I5p4sj5YjqST7v4NwFuylulH9s6dUKsAShiuqzYlV93hX6TkteGAIU3tfgpOr8Kbe0DuMnNeJ9J
	kX21N9PVAbqaqYTrvf4Lbo23id2Al+awAMwLYBEk7YUhZ4tWaF0KsY3NnadkIWJFriM159CIuWD
	SHQY/qs61PLowujh4d9Bt4c8ltCEsBE/1a2FIjsdiz7RRFgFikeVSWWi28kPfSW
X-Received: by 2002:a05:6214:519e:b0:896:f5b1:87b2 with SMTP id 6a1803df08f44-89a30acec5cmr72098406d6.40.1772879416019;
        Sat, 07 Mar 2026 02:30:16 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ea1b1sm31472556d6.36.2026.03.07.02.30.15
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:30:15 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 4/7] fscryptctl: Use ${prefix} rather than /usr
Date: Sat,  7 Mar 2026 05:29:58 -0500
Message-ID: <e47afa9ea40319effbf52af6451d82ebb3adced3.1772879169.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1772879169.git.scott.murray@konsulko.com>
References: <cover.1772879169.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 10:30:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3369

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/fscryptctl/fscryptctl_1.1.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb b/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
index edd6943..81cc1ea 100644
--- a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
+++ b/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
@@ -18,7 +18,7 @@ do_compile:prepend() {
 }
 
 do_install() {
-    oe_runmake DESTDIR=${D} PREFIX=/usr install
+    oe_runmake DESTDIR=${D} PREFIX=${prefix} install
 }
 
 RRECOMMENDS:${PN} += "\
-- 
2.51.0


