Return-Path: <charles.embedded@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39662E87834
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 14:35:36 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17790.1770129333390964929
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Feb 2026 06:35:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BB37bXsT;
 spf=pass (domain: gmail.com, ip: 74.125.82.175, mailfrom: charles.embedded@gmail.com)
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b82c605dbdso283729eec.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Feb 2026 06:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770129332; x=1770734132; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGevi842v49nL0C3q5Fo+HMI4yv+MIWq+ueIuwVXLSc=;
        b=BB37bXsT9RYo7iyMw4p+Hz28QcEVGL+TTgLq4lZI7u7XadC5d0cOlhowJULNsBrGPa
         8FLAvuAHi8U6PNOY026y4BCqVSKlfT57Eo60nm3UMk+pJUCjMxLrxm7XwLwAr6AIwm05
         fFSygm/gsZdIPy338bfohtEGfGKkGpVj70nZEhiPIbVwe58ndnYlN4BeiWM9RpAKMz1i
         T9DzCbxQZT1o3Fzn0xJ1HMFlrw58eEAvvbkggVrhH3GLxvAP7bUs/8ow+OGina99EV+t
         vt3iFFaJaNYPs0EtKLBfKjgiPmgdFuPhq+I81iCMy4LhXIu070+1UxIwL7TmisQx+5eX
         5AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129332; x=1770734132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGevi842v49nL0C3q5Fo+HMI4yv+MIWq+ueIuwVXLSc=;
        b=D5qmFp9oTI5sVvM1zYKtEtdO11qp2NEXDRwUJl3BuEZUuQHUcvSDrPlpAZbDurxcR9
         zHQpxpC/EYWaiwi4fVPeA1csg/UE3lH1MUROHcjbd2tfA3zgP4+/cllwP6ayxdmFM5FL
         q3G7TORYjhZDErnBnG5DKhRiXB2eZFHktzJiqsUfFPOs7QxmIo41llQy/EW8qAZmJXzN
         mqM3TcmFDWxZIxEn7bgjM3IlcusJ2vQ0eD3DUN4apJr870zg0Vpcth3UdPnipMhto8wh
         T/d3FbvLOCFWcUsMJhiZQ6BsASAjNxy3j4fXjAovY8D/VljWQ6tj+fExF+uvCpvFdqdL
         JAMA==
X-Gm-Message-State: AOJu0Yw1WnqR8mEO0ocqphPvTZV8XDLEQKQtQCVp0blkkC5nlHyv8MmC
	18HSGN8DzrxJfOCp5d2QEawEkMR/KYYN43V+UPxvtVbowA2Yk6cXTFisxYXROQ==
X-Gm-Gg: AZuq6aKyAGvQGAwrak5gdd9H9vlEGG8fA0ZbNLtFVrYdSi5xzWOKvCfAc1FzEGIE8Jd
	N/FI9eoTeWNd5q7VUdtV8e/Gq+UY3NVJmWxGIBOnl01wemC72fx/8fvQlvfJMggL//d1mvsXB5R
	x3YC2+Kt1mLjoaorr3Z6P58L6WPoH7Nnwrcukdmag3n5KibOPZRV+StkjxHg+nrfWoOaPqwaDog
	Wgzn5+S+d1xRgGtvlHHEWEU3D73nQk7y/o0rghRrxrb6kqbgPBQOHAK7bZH0lhhx2Os/jbj4hZR
	F1USdyoU8dzzWvjtdS30euBjp/XPBM+CAJS83gxBKKDUSDg6n/mRq/DJTxG2QKx6Kr2+BTabKtn
	4y8L3LnkB7G074iwc79cKFX+qkasRtIgO7HQIlXvNAunpFjTXbQyQ4PkzJaDSGvY3pWTUb6isEH
	ANlQ+VMAmeyaiOSyvFDMNUJOS+
X-Received: by 2002:a05:693c:2b12:b0:2b7:32a6:82d1 with SMTP id 5a478bee46e88-2b7c865033cmr6666498eec.13.1770129332138;
        Tue, 03 Feb 2026 06:35:32 -0800 (PST)
Received: from charlesdias.. ([2804:14c:daa3:8233:8473:de65:79dd:cac4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16d01c4sm22347273eec.2.2026.02.03.06.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:35:31 -0800 (PST)
From: charles.embedded@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Charles Dias <charlesdias.cd@outlook.com>
Subject: [meta-zephyr][master][PATCH 2/2] README: mention runqemu nographic
Date: Tue,  3 Feb 2026 11:35:06 -0300
Message-Id: <20260203143506.119483-3-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203143506.119483-1-charles.embedded@gmail.com>
References: <20260203143506.119483-1-charles.embedded@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Feb 2026 14:35:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3177

From: Charles Dias <charlesdias.cd@outlook.com>

Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
---
 README.md | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 4094eb8..d360de1 100644
--- a/README.md
+++ b/README.md
@@ -42,7 +42,7 @@ Initialize default build configuration with bitbake-setup:
 ```console
 ./bitbake/bin/bitbake-setup init --non-interactive \
   ./meta-zephyr/zephyr-master.conf.json \
-  zephyr-default distro/zephy machine/qemu-x86
+  zephyr-default distro/zephyr machine/qemu-x86
 ```
 
 Alternatively, run bitbake-setup with interactive mode to choose for
@@ -82,6 +82,9 @@ You can then run the created "philosophers" image in qemu:
 runqemu
 ```
 
+For a terminal-only console, pass `nographic` on the runqemu command line, for example
+`runqemu nographic`.
+
 The same sample can be built for other machines/boards, for example ARM Cortex-M3:
 
 ```console

