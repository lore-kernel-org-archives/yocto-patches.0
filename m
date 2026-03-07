Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0578FC9EE7
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:30:15 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6728.1772879415069808298
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 02:30:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=d42VS3cV;
 spf=pass (domain: konsulko.com, ip: 209.85.219.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899f79df682so71920196d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 02:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1772879414; x=1773484214; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pM0Fyyq44CZJigiUinmjBGJhX0LEVwVTI+e4fuF3O1w=;
        b=d42VS3cVH0jOT8Y3isphE34sn/c9ek/XYWDFFMR/VAxvuy+UpGx4vFDc/jK4Nv+wO2
         fLx7eBLUl4Riv8P9RYa3urIVTxVDiO4Oz4FBttvnGw6eHm1HizOkQRgS2L3S3QOXGf+j
         mbC2ijX+ByokqtaU3TS62DefiT88a1mGXcFY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879414; x=1773484214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pM0Fyyq44CZJigiUinmjBGJhX0LEVwVTI+e4fuF3O1w=;
        b=ifj3JITHnsreGn3QeysSFmleHgKQ2LCEgl/zixINF2lt7Yj8LUKOMlv9AsJ/TuSGAt
         4jATmykrMroeTsCx2DSDy9Uy5jgxc9ALNUoCG9fD6gmYEnVhetuhHcLLSkicIPVFaj0Y
         CvzUZpO0aThu1dVCAmduDjBx93znZvIx0IoU/rjIZ5mmYOd0jXSqwa34MaTKbbGgvynM
         JSXWspwFygZmjDq9piyuP2KNz6Sy6OnYA6amUWxAIbto8lLGVLLieMKz1EA2Mxn58UsH
         kg8llMByb8j99rVTPlBgCdRZmWs7tNQA0ycm34kXoiZHWiglO4Chxm8Yr6urubfGvjO1
         Vjdw==
X-Gm-Message-State: AOJu0Yyl4ro6etml0F8vRV5WmbRd7RUdUTOlo5UaUSItbSc+K4WXQulF
	/8jDT20acZojT118b8rV+bCI1f8J3LdLSz59jZQyC3sI5yv0fNjd8RFAE1M/CSJ9p2dvG6K0Lw2
	ONmpknzY=
X-Gm-Gg: ATEYQzzwsd+VAa5wRs/ui2ouA+zT1i4QkrIGx904B5vFiEcTlI1df2yMF72F13uRSL+
	Fc/AHQEY1uFCNfOEYVS4O872I1sLRG+1SNRRxzDE3EVvRqLr/a3w8bA2k/1HiHSDuYTG1UQeWfT
	S+Y4FXUEwMJpFFaD+c/JgRbcO++vrwIAMFly+3AUjtziRUXJSryCLh2sf7DHnalbA3/Ely6xY9R
	AWK5nb0JzswML6D5gdoBhAWFq/jW6mXywSk+Fs6UY1kz5rIQm7dVLqaJqpDofIGKhLwJCDBC+qh
	FOG4+ZUD2dNnia6ouEZhgI7foLEijbkGjVuRyPGTVunnJ+ztQvYTDRmhbQgsVpV7QNoOhXOsE20
	2Hr8qnhpmtv0zjD8rhri3+aox4X5A/tPPUXvhKnMd68ZHZkyblkLFcrptLki7pGLCO+tM+G058B
	DuIzKEbfSxQvUrbxQubwZ6g7UhgylpYNHgbgmPn0GGrWMWjRDSFBBV0GLopASlIVbkpt4rXdcRQ
	wiKtb5vuuq9Sa/n7KXirJ3iGfrsDVPpZRYkhd1Yyu+iTFLJyLc8xy4v65yAu7nwH9bvTJ4NoEo=
X-Received: by 2002:a05:6214:2b08:b0:89a:2fe7:91c1 with SMTP id 6a1803df08f44-89a30b1271amr70830606d6.55.1772879413543;
        Sat, 07 Mar 2026 02:30:13 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ea1b1sm31472556d6.36.2026.03.07.02.30.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:30:13 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/7] suricata: improve PACKAGECONFIG[unittests] control
Date: Sat,  7 Mar 2026 05:29:55 -0500
Message-ID: <83008a93aabd14deb6e17a3957094f2049c11549.1772879169.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1772879169.git.scott.murray@konsulko.com>
References: <cover.1772879169.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 10:30:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3366

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

Allow downstream users to explicitly select desired PACKAGECONFIG
options (e.g. via "=").

Users are currently forced to use ":remove" (with "ptest").

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/suricata_7.0.13.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-ids/suricata/suricata_7.0.13.bb b/recipes-ids/suricata/suricata_7.0.13.bb
index b0d2c82..936c057 100644
--- a/recipes-ids/suricata/suricata_7.0.13.bb
+++ b/recipes-ids/suricata/suricata_7.0.13.bb
@@ -46,8 +46,8 @@ PACKAGECONFIG ??= "file \
                    cap-ng \
                    net \
                    ${@bb.utils.filter('DISTRO_FEATURES', 'seccomp', d)} \
+                   ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', 'unittests', '', d)} \
                    "
-PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', 'unittests', '', d)}"
 
 PACKAGECONFIG[pcre2] = "--with-libpcre2-includes=${STAGING_INCDIR} --with-libpcre2-libraries=${STAGING_LIBDIR}, ,libpcre2 ,"
 PACKAGECONFIG[yaml] = "--with-libyaml-includes=${STAGING_INCDIR} --with-libyaml-libraries=${STAGING_LIBDIR}, ,libyaml ,"
-- 
2.51.0


