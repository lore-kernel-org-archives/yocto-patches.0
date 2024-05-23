Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36806C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 09:21:00 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.11206.1716456059666395850
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 02:20:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=JbL09g2Q;
 spf=pass (domain: snapchat.com, ip: 209.85.208.44, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5731ffcc905so12388690a12.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1716456057; x=1717060857; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKBMjjYxJ/1shsTRj7Jf/iz0DEbnwK0PGtV8BkVEsgM=;
        b=JbL09g2QkJPxcZAbvPUctltBy9fQm/WEpd5YCujrkEMnoBPcrW6rGhB/6lzAwGFi0z
         oXyyOvIBiZkTnFYgqAfE555f8FDkUNGuiZyffBmKbZGIgNqQaEittFkTMPdljxU9Kgdy
         f+lyrqZlkT5D3Oa1+VAA/56Z2RTSfEh6Zpe5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716456057; x=1717060857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKBMjjYxJ/1shsTRj7Jf/iz0DEbnwK0PGtV8BkVEsgM=;
        b=rK0XmBqus4J+c0JqfhSrRRAyp2oPEKqH7TbgZmkpX7P9lzoWeLuRrBRVy9Zjzf7ffl
         5meLP1XGZy0xvyZY66z5E4QAKGrmzeb/FQlHf4t6QXSMZzFMcxFTBt1iPVDIzUKbKRws
         ffLD8qeuI79Uah2UX81/oi3J/RAXPuSVVB0TVCJymkR7/R2/rw53g7hHDO7RuM+cpyaI
         U6/oB6E3P4A9Wc84m/tyI4Sq3U5+UD1YBwlSj/J2DW929u104jJu04H7yTTtGdMxloNf
         CN1onGBYHQ8Tew7fVGi0lsa5PfxVltN+5KjBGMcoXFnVcBOs7jPekdvdPy0OeblAwZIu
         lKWw==
X-Gm-Message-State: AOJu0YyzrosKctHRbPoDtAoHW2GguGs8RBBpAzB+f+viDofoAhkbacKp
	Ddyr+RAO4xAq1oT9p1pU6zeRTk6Gx03Z7TZfjy1H7tE3M2g+YNwmBhOQcAIzdmVUWrVl4zrrD2Z
	u2uY=
X-Google-Smtp-Source: AGHT+IEFqpMRAPWTY9L5ySzkpBau42Nr7PS1Yt7jcwYh29cnOk5OZ56iknr1JVoAqeJnTwX/Ob+nvQ==
X-Received: by 2002:a17:907:7844:b0:a5a:88ac:fbbe with SMTP id a640c23a62f3a-a62280a2be2mr313830866b.46.1716456057177;
        Thu, 23 May 2024 02:20:57 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cd7asm1934061666b.10.2024.05.23.02.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:20:56 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-selinux][PATCH] selinux-python: make GPLv3 dependency optional
Date: Thu, 23 May 2024 11:20:54 +0200
Message-Id: <20240523092054.3825216-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 09:21:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/176

From: Etienne Cordonnier <ecordonnier@snap.com>

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-security/selinux/selinux-python_3.6.bb | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-security/selinux/selinux-python_3.6.bb b/recipes-security/selinux/selinux-python_3.6.bb
index 79125d0..faf5d28 100644
--- a/recipes-security/selinux/selinux-python_3.6.bb
+++ b/recipes-security/selinux/selinux-python_3.6.bb
@@ -53,8 +53,10 @@ RDEPENDS:${PN}-semanage = "\
         audit-python \
         ${PN} \
 "
+PACKAGECONFIG ??= "sepolicy-generate"
+PACKAGECONFIG[sepolicy-generate] = ",,,"
 RDEPENDS:${PN}-sepolicy = "\
-        binutils \
+        ${@bb.utils.contains('PACKAGECONFIG', 'sepolicy-generate', 'binutils', '', d)} \
         python3-core \
         python3-codecs \
         python3-distro \
-- 
2.36.1.vfs.0.0


