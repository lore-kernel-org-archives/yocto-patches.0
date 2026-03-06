Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18980F01834
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 12:50:18 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.68525.1772801416158338836
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 04:50:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=ax/sqcP4;
 spf=pass (domain: smile.fr, ip: 209.85.221.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439d8df7620so522394f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 04:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772801414; x=1773406214; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N7nbZNpBdc5TdxLJJ0k9D30v9PhyYPB15GORXFizXrE=;
        b=ax/sqcP4Dm9EP4q0YiVIv4StG0Nw6OOlNhqmF/FLKCaYIA4vAXnUdG2JHJoTT3ElMJ
         MidT4cTJsx+ncpfDWVjpTw3t7ZnSsSsq0OTz5RqiZ/e9XRiLNCtkwQESYgHaWYdszy+I
         txaii9rZJnmeLAQuLA/7LdoGQx/M6ESs+qry8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772801414; x=1773406214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7nbZNpBdc5TdxLJJ0k9D30v9PhyYPB15GORXFizXrE=;
        b=vhm8JyozznnNMkCop9ZLtP0neIIhqkPTj8cgRe3pNKSGCpgvpnW6gimaM1gwVCTcq9
         a9L9tlvA1j1MAUEb+h8NKj+Q+Vlo9jD/WRkGoBp7F2BfpqIaAbWDsB+Jd0t61li4ps3g
         jSC1ZWxxUtlSBdsUh3tujT4tCs2gvFaun0zGurcU9x2RyiMn4ewrqaVgzGLLhpf2ocLA
         lNm6c+Bwg2ix4fBYQ2SHKewbXx1ox1JMW2qKAJ4DqK5ikB3xti6jdFOOH6NO1Sh8ETiF
         NwHzS5dmsjzMQZUE3MeUgKLY7NrPwAbalTrJicjSgw+rc0+CQ7psNwExGfWvBmHpUxNI
         n6sw==
X-Gm-Message-State: AOJu0YxwdW2oopEk98QxuO5cn/WSJ0lorrAy/WjhHa2MA4f9r/wAhubj
	2RxBVtc1tG8uV3Hs0T/D6BYzQkBCl7eoDithuiCakSPt/70ZXfFfW85Kgq07PcDzFyvx5xkyV+0
	VMIBX
X-Gm-Gg: ATEYQzx35By79kNs6gi+Q6a4htOATxH84YNZhlG4Q9DbID2Ud35ur6X8IiPx9veRXc5
	79hKg1YdwLXKLUSkd/otfunvXAT6fz1Gu27J7CR6fwtRZuCzpkKkhTsaQk0mLayLPaQLysEMReP
	bTP/Ejg+9hO3myexLNtT4Xa423+DN8dOaBpY1hMFiBTsPKtnugvW0aohvth6SHM7k0Rtb6Fgxct
	4XzDt9/SaUWetoEjm8fHmFABLl2T3mPY5duINAiGbXiYREJiCCX/fwQmI/EXWDRaxuiYkqHQZin
	Zs9gywZn1gAAVnf72j/SOIoymdlv9lzrVz7FOExu2Y8jpcvD7ydMoq9d+6Sw6pESBYllFRE2hol
	5Ga7PDNAoytocJGBg165fzctAxCSdj2EM2ltoloG6NTTE289laXIkWydk0cRqsMQ7IvcyGzVcwh
	r1MD2HS3KIBSfhB34tUsKaNHR7CqzGGrwY/cMBGqTmoqwSr57yfBvWXWbipE+/I6u0IUbmEW2cT
	YDg4Wqz9ZLP2hVl76I2ryV6MCpx
X-Received: by 2002:a05:600c:314f:b0:480:4be7:4f53 with SMTP id 5b1f17b1804b1-4852697842dmr29241885e9.31.1772801414194;
        Fri, 06 Mar 2026 04:50:14 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00bdeac353f6fa5aa8.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:bdea:c353:f6fa:5aa8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246f3429sm16003325e9.21.2026.03.06.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:50:13 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] config: add stream9 to scarthgap worker list
Date: Fri,  6 Mar 2026 13:49:52 +0100
Message-ID: <20260306124952.402090-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 12:50:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3348

From: Yoann Congal <yoann.congal@smile.fr>

This is preliminary work for the official support of Centos Stream9 for
scarthgap: this will allow to test scarthgap on stream9* workers.

Related to [YOCTO #16156]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 46d17c6..8aa1817 100644
--- a/config.py
+++ b/config.py
@@ -196,7 +196,7 @@ workers_prev_releases = {
     "whinlatter" : ("alma8", "alma9", "debian11", "debian12", "debian13", "fedora39", "fedora40", "fedora41", "fedora42", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2204", "ubuntu2404", "ubuntu2504", "ubuntu2510", "perf-"),
     "walnascar" : ("alma8", "alma9", "debian11", "debian12", "fedora39", "fedora40", "fedora41", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2410", "perf-"),
     "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
-    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "fedora41", "opensuse154", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
+    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "fedora41", "opensuse154", "rocky8", "rocky9", "stream8", "stream9", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
     "nanbield" : ("alma8", "alma9", "debian11", "debian12", "fedora37", "fedora38", "opensuse153", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "perf-"),
     "mickledore" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
     "langdale" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),

