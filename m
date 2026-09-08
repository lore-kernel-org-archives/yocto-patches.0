Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA3EC79FA1
	for <webhook@archiver.kernel.org>; Tue,  8 Sep 2026 21:28:38 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.394.1788902917290749393
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Sep 2026 14:28:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=id6HPyzX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b9320423cso58035925e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Sep 2026 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788902915; x=1789507715; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SbFvje8vuVJpeIESMrex2TS/yZ9eaebHGcui8pzpzVU=;
        b=id6HPyzXMwj7glO9+AJof0oW1AgJZlrS9LEcLZog9sTux3gfNDGcb+RAMqNv3e/eXJ
         3N0S6k5ne7zaWwNQy5MHZiPCkaiWG3GOuIbRcT/Jk9rl75Z/CKP0AzoKRs6c06GySz/T
         ShwkCxO4cOvEjN7zJ8qV10bogLOehV5sWXpLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788902915; x=1789507715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SbFvje8vuVJpeIESMrex2TS/yZ9eaebHGcui8pzpzVU=;
        b=Sh32TJ4CcptMS/NGcN+OKSJYsScUF+JAjSO2Gl6Mqmr8V4TkHAPZwOZUdRGqRNSFSv
         jelnBAMuepuTPf9Voa9mwcRQXEoHV3GUXq+uFYN96elaq6g8/q03MjqPxPx/B+LOM5rW
         Iy6F7/5V3bxk/hsdk+YgP/8igBHK8U3j8ml1+vSEBmSi2KaqbY1lBYOpTc54d29TERPR
         r54Ua9USlNKSFnZ2Qry4Kg4vN/hk0xSPgLna+feNlCYsApGN6JBj3nAHX2yYt6/IK5St
         3zek8pjnbQB0KBMaSIQ2lGdiJj/g/F92yGirVrCxD0NJf6GTC/E1rsdXdG5jR2lzUF20
         vNLA==
X-Gm-Message-State: AFuF++mgPGLaIM2/EmQpVwf+pLJZRhvw1ewqp5fleWu5O5aqq61xBhPW
	PXLOCOQ6PlvV6xSt3bj5Mz5Goyw3M81AMvDduwcJSvH97yo2lzBvOokDDc4guGY26F39FrA4GPm
	kI7PiG3E=
X-Gm-Gg: AYBFou0dzzUVNVF0P+n00WTIfGuKooWJqLiyd7NLUT2ziy4hIJPQT6Aw2nJhhTVlLuE
	vnJfFsmUti4OgQU3TZ6gJwPajop5vGA/rQKuzrhs8Z8G191ZOaL4JdEFPQyQKIYx57zLsqtNgbV
	8Nz4C0NCED77zF0fsdrl+kgzfK5KgFLGT7iVF9q0zh0aHdoog4QA98mX4qFAlUEl+8ba/pAg6JZ
	CKMKp25iKTlb8V+6miWuWFZmbKmAkQv9y+O/9R56yu7/NOjXgIocNbxbYQnTc6Z8bXugufp3y8q
	LoGUKcmvlgBtW0DhKKBaasZY4IhPILSq/1kvq3GggzL9yYsviN/ugjMLFD1RbRf9g7Kwe0abj8u
	xYKAAQ2cTXm3VFiJVZPD/nk6tV1jx9AUasF6sGRADiftVx94KMaxQhQJY5SkNo9EoeVrWL38nJu
	C9B8ny46smKfXezgegQwbzddWBNalZ9MbUDEurZfFM6A3Ywg9OzXYYJLukZQKCM3d93MDidhNSC
	h5NN7usPDTCw8g14g==
X-Received: by 2002:a05:600c:4514:b0:49d:1e09:694a with SMTP id 5b1f17b1804b1-49d1e096970mr77448445e9.11.1788902915126;
        Tue, 08 Sep 2026 14:28:35 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3b52:472d:bd88:cdf3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20daed8esm3815085e9.2.2026.09.08.14.28.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:28:33 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Show bitbake-selftest test durations and progress
Date: Tue,  8 Sep 2026 22:28:31 +0100
Message-ID: <20260908212831.1825824-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Sep 2026 21:28:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4754

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index b887900..6eaeffa 100644
--- a/config.json
+++ b/config.json
@@ -263,7 +263,7 @@
             ],
             "step1" : {
                 "shortname" : "Bitbake Selftest",
-                "EXTRACMDS" : ["bitbake-selftest"]
+                "EXTRACMDS" : ["bitbake-selftest --durations=0 -v"]
             },
             "step2" : {
                 "shortname" : "OE Selftest",

