Return-Path: <charles.embedded@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE1CE8783D
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 14:35:36 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17789.1770129331034172648
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Feb 2026 06:35:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i9QKDIxG;
 spf=pass (domain: gmail.com, ip: 74.125.82.170, mailfrom: charles.embedded@gmail.com)
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b71557299dso5786189eec.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Feb 2026 06:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770129330; x=1770734130; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lne13+uNLzspNhX5rrl7K59lZSUggQWAOwo5cTV/+dU=;
        b=i9QKDIxGzYSZ/5/T5yes2rsXcW9JUSeFnwqQUqh+BMixfQzMDIcKQ/+aIdl8SQtW/a
         lPf7SszsMTnjWRCR8I/RKX4eR+Jc77VgW6tblR12hFb+lXpnr+7u42GHwpfzaSblJl5L
         76LGMnlxvTiL5QCSa9sIJKqrPeHDQBXQeuI0GNlBtIRw8ie1Yw3dTCbe1nGLFWhki0YP
         SvO0D07fsbzTvNPJINdNw7JlrFovAS8hjPfez1PCBO+1yP1gbLyCcObi0UYCdYi6SJ95
         Ja249psBqhs1ArwlkbptOPBEesGxVLxLQSTVynXx13jiv58SirY/wMXH0Df0x/o4WlL/
         rWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129330; x=1770734130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lne13+uNLzspNhX5rrl7K59lZSUggQWAOwo5cTV/+dU=;
        b=gHO1H/3Vovrbgdl/6W8mELP5VEZqyj1OMVPphjNNwRydtu3Z6UL8IOTlervUrwi8gY
         yOVDB0akn24+ILCSIN1Z9hgvWQZk7tzN0VmWAO1lEqkJpZDYi44SBrPWTAom7rSkaOYG
         2Ud1+W93hpEHEbFHF/RwWz8wHO+61z7vXQcIeJ1wdBJyFS4U6RIk2OIT8qh0KUtrnOx2
         E6E4m45UhIpPufaBDqz0MlU81KzGeN4qD5yOR9P1o5GqBeMdm6UfPPXz2vV9MtOyH7ZX
         fpVQGyhrJC6ITb7D3NA5bXiKGMr8u4fZEQPcqGwddZCFklfRF+vgGH9WkjczUV+3CqLO
         Nlhg==
X-Gm-Message-State: AOJu0YzKAYkN+KHzvJENDHXiSiDgJCTYQnYcBvTyGOjUTZv5i8eHfFpN
	/+F2iUTK5HhCXQxx68Rp7StF+uapr4sQCO+739vgYyvR0qwCbFRMhP/Nqxw1vg==
X-Gm-Gg: AZuq6aIn0IVnpMtDlDR2o2112wCEef2MJshOxGbW9/Sjc/QT9YOIr4ySJxOsLygQko6
	tASWMYFWFGJkw/XG4C/7Sn2JtQ7uUsUr7UZjYNziTOX7AUHe/AYoX7Z+QA4Wp3CoSqXfN5hrINJ
	9uveWJ2AU/U8PLcRV7kxkk1eqn1LRSvAgygEfo8BOLYO9WBSR43HGkZVDrZceFunhKeynpOvpNv
	BWf/b6Se0U5SKnM710RMpktZ1f16kQuObuJbb0kgX9FyeDz7/DlyXpKnPI2RAaTS3Ejw4qAPUYr
	0zYqOjZWAIAUbU1jmhsr+oz+a4E/HJDKD3wbGsQwI3C4aqIQQkBgDJuc2UWbD46SF8+acF0p4wG
	OyuN5SWkVRPyyekKkDsTwdpmojGaIZhRQq8AhrxSNT8ysW1/8H+uw/azbbGT+490ou4vN9PK0oN
	t6lk7Yx59aA6op48TI0rTZJ7Jk
X-Received: by 2002:a05:7300:434f:b0:2b7:1abc:a6e9 with SMTP id 5a478bee46e88-2b7c864e186mr6122045eec.12.1770129329890;
        Tue, 03 Feb 2026 06:35:29 -0800 (PST)
Received: from charlesdias.. ([2804:14c:daa3:8233:8473:de65:79dd:cac4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16d01c4sm22347273eec.2.2026.02.03.06.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:35:29 -0800 (PST)
From: charles.embedded@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Charles Dias <charlesdias.cd@outlook.com>
Subject: [meta-zephyr][master][PATCH 1/2] qemu-x86: update QEMU configuration
Date: Tue,  3 Feb 2026 11:35:05 -0300
Message-Id: <20260203143506.119483-2-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203143506.119483-1-charles.embedded@gmail.com>
References: <20260203143506.119483-1-charles.embedded@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Feb 2026 14:35:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3176

From: Charles Dias <charlesdias.cd@outlook.com>

Remove QB_MACHINE and use generic q35 machine, type=pc-q35-2.10 is not
supported.

Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
---
 meta-zephyr-bsp/conf/machine/qemu-x86.conf | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meta-zephyr-bsp/conf/machine/qemu-x86.conf b/meta-zephyr-bsp/conf/machine/qemu-x86.conf
index 9551523..288504f 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-x86.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-x86.conf
@@ -9,8 +9,7 @@ ZEPHYR_INHERIT_CLASSES += "zephyr-qemuboot"
 
 # For runqemu
 QB_SYSTEM_NAME = "qemu-system-i386"
-QB_MACHINE = "-machine type=pc-q35-2.10"
-QB_GRAPHICS = "-nographic -machine acpi=off"
+QB_MACHINE = "-machine type=q35,acpi=off"
 QB_CPU:x86 = "-cpu qemu32,+nx,+pae"
 QB_CPU_KVM:x86 = "-cpu kvm32"
 

