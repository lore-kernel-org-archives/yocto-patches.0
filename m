Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F14E77194
	for <webhook@archiver.kernel.org>; Tue, 31 Dec 2024 03:12:36 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
 by mx.groups.io with SMTP id smtpd.web10.76564.1735614751946844282
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 30 Dec 2024 19:12:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Idrr/J7C;
 spf=pass (domain: gmail.com, ip: 209.85.219.179, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso14049429276.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 30 Dec 2024 19:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735614751; x=1736219551; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vAa7Ih7nzJq9xZlz5r17eMKPYnm+CSXsXNmfwyoShE8=;
        b=Idrr/J7CuzZqit/q6FEfbuYM7JZSheUUsx6Vb8CljCyGGVf0HJu5H0jJ5IyEJPbfcU
         VSsPWrdy9wGQMya/XGSy3GHg6i+B+Bpa16/8ZHgkaI8KXuspVYcosSy8YxozEgr5RkA+
         a3eeZX0mroNVF7lK5unX1kmir0/YgMDfGdYCkwLug9nFVLv58PAzX+vVChmMH7sTX7pe
         jixS2R3oQnaW/QACPQaB3Fw6YK8YdjrpvtI2kS1e52t/ZmYh0LiiC96ezKKKTz2A6L3T
         PCgBP3X2U5/IWadn+qQNB0W+vxDKh7qoZ0V2p+h3z8gKXmtWiEoeVm5K3poobpdzu1Ce
         fcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735614751; x=1736219551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAa7Ih7nzJq9xZlz5r17eMKPYnm+CSXsXNmfwyoShE8=;
        b=PcfUheRZMMaMbjGK+OAgt6pML8HK3l1r6n1LaL3VEme3XCP0Ga9GpzlQlKj9LmLItN
         E0k6YCRflKzPb0okyQy8Neuel+Tp2b0b2/xrUy/2NNB9R8puw2JDloVDJIGM9qsZS5+S
         jL+Q78iq3Ah90SHCyfum7yszNm4AN80g9agEqsEl4tHQ2BRX8XYKUPjkuXL8D2gEylWq
         17McBeS/4BnLZfJWnhD+9D1F4u+yzAv8aHp8cdeOJcetngKNzYSx5lEoLUj/50PPgvS9
         3LOtOXOP053xq3FZBQ3r5QzlluwI4bCIlzFV1gI2/i5vnf72fXALr8NNhM6JdjTNgEer
         LzGg==
X-Gm-Message-State: AOJu0YyDO95oeAcoUjqAGX+AVylDz1i7i/WWQIyAPqsBTGZop0sArInT
	PgWu5llydQSmI/55hemsETDntq0zWP03WqzTGhMh+o++esUADXs/Ojy/EzIa
X-Gm-Gg: ASbGnctpXS/rN70y28zceANk2nhPy/gH7mUzE/ybNwOh+IBrJ+I3ba5HqK8xDosmfTT
	gI4gWE5RfRwVWv1uwxwTsa3xUMDVSzqvXGNczIyIerXh1cxG/m/Hn/pw0Bxx3YL+u6TFUsr1QZ1
	JE8E03S2FQj5zs5cd2iBxuwOLiGSW5cr+7xzGQ4ONJVHhbgty+wOg7ZhNZc2RrZvynpMT0InX2t
	zaeNK5qZhxy62Va+qVXHPezLi8D6H/p/hCju1sjXsWbU6UMMD7U4Af9u0Dxy9iI/7Qf
X-Google-Smtp-Source: AGHT+IEiwiFVSJo4fuwFcqmNZFIRquY8125XnsibmzEFnZLv/RjikWpQUS760LsCG+cldQ3JY/4S0w==
X-Received: by 2002:a05:6902:842:b0:e38:bf8b:e2d0 with SMTP id 3f1490d57ef6-e538c414d56mr24777408276.46.1735614750921;
        Mon, 30 Dec 2024 19:12:30 -0800 (PST)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:c83e:ad2:5c14:ece])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cbeb0b4sm6270546276.6.2024.12.30.19.12.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 19:12:30 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/2] kas: tweak to improve CI work flow
Date: Mon, 30 Dec 2024 22:12:28 -0500
Message-ID: <20241231031229.2640925-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 31 Dec 2024 03:12:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/960

drop ptest from base builds.
Enable ptest in test image only

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 kas/kas-security-base.yml | 1 +
 kas/qemux86-test.yml      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index bdd74b1..6d53071 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -46,6 +46,7 @@ local_conf_header:
     PACKAGE_CLASSES = "package_ipk"
 
     DISTRO_FEATURES:append = " security pam apparmor smack ima tpm tpm2"
+    DISTRO_FEATURES:remove = "ptest"
     MACHINE_FEATURES:append = " tpm tpm2"
 
   diskmon: |
diff --git a/kas/qemux86-test.yml b/kas/qemux86-test.yml
index 83a5353..98f1e7f 100644
--- a/kas/qemux86-test.yml
+++ b/kas/qemux86-test.yml
@@ -3,4 +3,8 @@ header:
   includes:
     - kas-security-base.yml
 
+local_conf_header:
+  ptest: |
+      DISTRO_FEATURES:append = " ptest"
+
 machine: qemux86
-- 
2.43.0


