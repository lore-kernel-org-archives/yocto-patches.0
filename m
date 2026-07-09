Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D380C43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 22:39:40 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1058.1783636771844832377
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Jul 2026 15:39:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lb9NVcXR;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e99ef0902so14054085a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 15:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783636771; x=1784241571; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u8NsXO/hkuvhNDoX9bPC7L60Q1lTgDjhs7pi/BcdUdU=;
        b=lb9NVcXRvQoTcvIAS/mQrDs3IbTQ+insLgBeM0Sto14pvOohZ9P4DYrBkRvcECoRNO
         uZ/elNwUmvHe9cCHtdz4JPpMtVaWvkD6P/nnWnAM2zLsVwSTFyvto/7CxXgzw760YQ+P
         1ovogQLi5fNjltE8mhiLX+4jMp6u2gHbOPEsFkvCiOXAVkRgk4ukcDK/J6UdQ99rcqP6
         ziUPRcZaiunwF48Wuhp/cOTVXba8+p6V7Lv8xCHoh8KGGF63tR5Mi8HyiVzPx95oKeQP
         jbumVb10K4l4M1TCFiKGizv6kSd2vP3erZiBZLAEmWEoZ/Ynl+pQVxJyqv5IHjgZ+oti
         gcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783636771; x=1784241571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u8NsXO/hkuvhNDoX9bPC7L60Q1lTgDjhs7pi/BcdUdU=;
        b=CtNITJmBPTP69UBC2lxgkJRYEWlaQpXUZHrqKQUxM4tjgXs+yGFJ8JLL2t9ZtuLD34
         +LFc7tw6wnwUw9eg9DZ5uVE3v1LAfT9MxcljVJ/6ykADYy98Rf+kvt52zpC3XZ+U/RYo
         LaS+7+1vgqG9rUdwP6upRCQwR1vl4L2j32Ce1L4cAGwkyEoC0Oo7pvdcxMCIPTADIaNu
         qAIhTRWtqA4s6gEq9PAjdKQFyO/lJMaoywAPQhlLHhT9KTZxP/HB/aAvSmSElKcilrT+
         IJiKcXILBwVam3ox/1HitYvRGIVEmjakEu4ZPzr/wfbah9jgPr9+ps9CMfGe9SJzNAPF
         eRjw==
X-Gm-Message-State: AOJu0YzDho5FuJqjjZj5GhgqWSsl61lxqdAt5ifvjDtgwolQIsNVCUeL
	iaM7can+3DGU7I7K1Mco6QuhMjMCzTDVBVX7DQiR5H4r4b0gDZtvfni0o05Dsw==
X-Gm-Gg: AfdE7cmMP84v4V57yLx5dwruJWFODGrkh506yXcdXFNLnod1ZTk/TRjIMuV9ArfLgBx
	Q92/5rxDD+7vupt0C0kTzkB7d2P3xhavsw+9dGyDYiOkj0XcEhg/Ps1tf2+nY62+Ob4h/d04upd
	EAhTx4rBY5H7SR+2+Vgm9/ZYvV8zxd7GZw9XD2aShNZ2NGOst34VqLTCUnZDhjrr/A7DVwMBfkb
	hfsz27D6qYG2/Kdnh2F+xqRhJfoaZiBh/Mlm53Npja4gRQ9I8GLs/TcnpKqsFBYPZQw5mdTkHKi
	89Ru9ilXJirpX1GjHUNmpwCbU7YBGaarYuvJvR4rZEjcUHNToIbIXgAFJle0FHPjJr+F5jGlAaj
	I5yZNHCoNRIh04MEbwU1v/e2NI6Tb+r9xEA9M/FwgfTDXJzDfNsU3HPjvAgNlqLKGZ01W60POoj
	joPmrTcF0uJpnFLcyYCpvvFiRAadvQk3ozDXhiL7lVxalDHxvlIUafPPc=
X-Received: by 2002:a05:620a:4720:b0:92e:cac7:96f8 with SMTP id af79cd13be357-92ecf5dc4acmr1017452085a.50.1783636770584;
        Thu, 09 Jul 2026 15:39:30 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61facsm51331985a.42.2026.07.09.15.39.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 15:39:29 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [rockchip][PATCH] rauc: update keyring path for meta-rauc relocation
Date: Thu,  9 Jul 2026 18:39:24 -0400
Message-ID: <20260709223924.3480606-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 22:39:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4464

meta-rauc moved the keyring installation directory from
${sysconfdir}/rauc (/etc/rauc) to ${nonarch_libdir}/rauc
(/usr/lib/rauc) in rauc-conf.bb [1]. Update system.conf to match
the new location so RAUC can find the verification certificate
at runtime.

[1] meta-rauc: 01f7e1bbde16 ("rauc: prepare for hermetic /usr/")

AI-Generated: codex/claude-sonnet 4.6 (high)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
index 4945c67345c4..06a043c67a79 100644
--- a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
@@ -4,7 +4,7 @@ bootloader=uboot
 data-directory=/data/
 
 [keyring]
-path=/etc/rauc/ca.cert.pem
+path=/usr/lib/rauc/ca.cert.pem
 
 [slot.rootfs.0]
 device=/dev/disk/by-partlabel/rootfsA
-- 
2.50.0.173.g8b6f19ccfc3a


