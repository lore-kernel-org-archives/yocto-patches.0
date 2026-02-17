Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB126E68174
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 11:45:45 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10379.1771328735886200319
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Feb 2026 03:45:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VVjBPduZ;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3131729f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 03:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771328734; x=1771933534; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjldkokxtcZHVQRJ8DBazZxInOkfw4TJx3eqfYE1sCc=;
        b=VVjBPduZTNuzlKwBtAql+kyNncxxTbMiw4/Y0hU+iZ9ycJumiD5GPtq7KBg/n8KNr9
         Jgv4CAILGVi2YqWLcmui6xPRZelpP5ikDt7hovbDmIrIWhu9fXCPH18f7lMmAW+9DA7+
         8SQ/IZOfsrQAt1mR4jBf0igFptxQ8eZiT17WN+lzDH/b9oBDYIQQQe83aDgZW02K5/xI
         jV/sXQKPmPy8PA0XdzOU3A65mOsiP94aNiYCZxsZjkVdPrbcxFbluCeggPntkQCWpVNi
         bOjFTFBDZC3ctXYUI3G2rhOlyGa+ROx+Nmu82m6N4FskTqNYDeO+jNamFwCAD6OdZawY
         FSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771328734; x=1771933534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjldkokxtcZHVQRJ8DBazZxInOkfw4TJx3eqfYE1sCc=;
        b=Hszg3m10YTIa6KSRkqLfbB5Tvahn0b9L1H8uOzcvzKmvkU1zhOjYOHXiburpEQyHrj
         0nmDURDPwC9PorscY4dR3lFYGofT7GwAOKfz9DL0XekB9MO5hHpAGuFmdToIc05QTDq2
         Oqg8/1uZQwhMkFdv5HBdGF/+/aLNTvJ50K8qm++A/4DUWbP3mAsbPcUO9Vwm2jLz2psC
         dG84BTSgSyK2sCLqip+Au35qMa1xjNg78rVGEBQeVzfHb/Hq/zdN8Py4L3lV/8iSq12v
         /+ES6tpp8/175/IoLB5tHh3TC7jnKKBNTN8l+7Iv/NxD4XaTwSPV8nLQdCiyOzAJNT3z
         TPjg==
X-Gm-Message-State: AOJu0Yy2WzEf3QnSESe/aGoL+kMCxU/N0W2F5nTdWyfJFqPyjL7sXTrg
	cQK+DknsPNo+VI5PHpJuxXTbweJ4nt0RKOgKWRpJd/jAuGn1K5Qldl3xyvmB3w==
X-Gm-Gg: AZuq6aJVZW1/1FNz9adYrEQVRdOI94NycXvUm5BhgBCSPwfgXdymo5CCWkF9GGoPtIV
	/Z5+yc9lLfZr+v+yVXbIp1iDvm4s4S/znQNG0sO++QqP0DXSa3FrI40GH/PK/NxilM1dKz5P9hJ
	HvwhQgBnji2iQwC8aUqrYp7VeNVusCbzjM+eIoGIkOWhNbRgA+RKR9UtSlY5KWKbOVEpM35Wkic
	wJ5snV8j/k0yqjPZyTqdggqnEqPjeaWHDjFrAygflH3sjd5exTSY52yP32AjkgeKVrMv9ndo0H9
	RpKNXagjH3ji83H3J/keJ4ZfcPrs+d5cfA4DBeRNxZsQ0ShasmWY57je8NBsUD1OyZJSaJDTvx6
	u1Mj6agp74fy6nN+SpA7giDRwi/4UzvTUjc2LzV7hzaaG8BbTKpsjPL08gfBmTLwocV6Mbvh47o
	DwpsoaV1ba5TbRdb0KtS++nDZ5sjSD15JSUHLiRg0e8K5NtaMQwlS3AfsOBqM=
X-Received: by 2002:a05:6000:1ace:b0:437:6963:a115 with SMTP id ffacd0b85a97d-4379dba6814mr20248337f8f.42.1771328734133;
        Tue, 17 Feb 2026 03:45:34 -0800 (PST)
Received: from alex-lx-laptop.lab.linutronix.de ([2a02:2455:86ac:8b00:8de8:97f1:4c58:d8a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a6desm34441008f8f.10.2026.02.17.03.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:45:33 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [yocto-autobuilder-helper][PATCH] config.json: use INIT_MANAGER to select systemd in auh jobs
Date: Tue, 17 Feb 2026 12:45:26 +0100
Message-ID: <20260217114526.318546-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 11:45:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3247

From: Alexander Kanavin <alex@linutronix.de>

Recent changes made systemd incompatible with sysvinit, so rather
than add more tweaks, just use a higher level mechanism where it's
taken care of.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index f306619..9e1d8db 100644
--- a/config.json
+++ b/config.json
@@ -1618,7 +1618,7 @@
                 "DL_DIR = '${TOPDIR}/downloads'",
                 "INHERIT += 'buildhistory'",
                 "LICENSE_FLAGS_ACCEPTED = 'commercial'",
-                "DISTRO_FEATURES:append:libc-glibc = ' systemd usrmerge'",
+                "INIT_MANAGER:libc-glibc = 'systemd'",
                 "DISTRO_FEATURES:append = ' pam'"
             ],
             "step1" : {
-- 
2.51.0


