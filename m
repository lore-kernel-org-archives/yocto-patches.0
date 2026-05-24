Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45D7CD5BC9
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:04 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7154.1779624957937045284
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:15:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Rnx8WFUb;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so57666456d6.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624957; x=1780229757; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjgEv1TTEJQV513bNSK6N9EOPJsM0CArvbqQfw1cdgE=;
        b=Rnx8WFUbCrGfHRcHUix0zVEzZkZ7VGjR2UIXBnAzbzyAH7ZEkDy3lgEa3mAkwtlPjl
         IJ+vrmorfogianqRtdM/cEpvo9OKZ9+sQkqwaWbOJRBoJPGGSptUCa3SRwtkD7xIiFru
         g+Lg1k9ZdQYSlygQQvQj9Dn99aTMu6lAhTAZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624957; x=1780229757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vjgEv1TTEJQV513bNSK6N9EOPJsM0CArvbqQfw1cdgE=;
        b=WfGZ2TA/9+PQQaRGGZRxGRHy1++XMpBFu8n6jZlBbGyZHVF+nqdqyGoYJrdMtX2UzJ
         FTjPM+PimNMNCrqrmZ2iKRpTSSjRBU9ubJQCUJt9scPn0oMjQ2uU/GE5HtV4J0SXcsTg
         LsCcFmXqhF44TzVlrpWaxsEQPuhQCUAMu2ODL2fACcuU70uR9ZE6JyM1Cw0ZkOKU5VGV
         eWDKm4aMlATCzth5PLpyIGhQt2VFpdtcDHwiQXhbvK3Xvq9G7vGQSr3YeZIhKAPDrzWO
         QwPjB8lunzYUnFIgekKTyUx3Q/pchdRma7/wQj8kqh+M6K+++/723n17gWjExkZ/zHct
         hACA==
X-Gm-Message-State: AOJu0YyrvqLvVs7+Lqzt99d7zB+Bqh8Zwblr7Tvrxfqiapke/qylti+U
	wwzFb97jbeYyxEWX11St4uszHH/yNLQdjIZxUeXfHeZT2h/RuqjmdYj/rzHFdVZ1I0UcoA+j3Ut
	CSWbx
X-Gm-Gg: Acq92OGWUAuV9wMlE7u3d47CyPR9ozoeShZ7LPxqVaIEBcyvIpMAtfYy2eytdO7To7b
	Yj5O4ZFYSXNXxTIkIz/YlIoxvJFsfodxCjvoGGLsL109PkCCb1hgC0PGkvxi1tHTlT5l9KimRw6
	8LWmV0ipGKE/mRp756KxUohmrXZH8rcSJA2MXCWwV0bBSk+jbbPcsOswFPqLyFySKqrMqnQ1InT
	YsQV2G4B2qadrQHNaLZ3c9orTp0kR7Dj0WZ58ngB1f1XTkBDhsTb1GNY+zSXkeCPwQjB0VAkRua
	Z6RpaUzIYmX1sl7iD506GgW04lgBWQ4EIgmrRNXAQhboaGaUDOzvsgi8XCBRbRN9bbm1UjjL+NA
	4BTwnGayqysnEWrDZBJGhyGq308QA4a7k5wG8wMGTi+VfJvvLMkdNPgDUNR4wHXV8j25AWBEOAW
	NEG4JRixpPFNEjBQxsfewNyuxt4UKL73qBbeDkWdEn0QAy8hxTFjg+mKao8ByK9BfuBkqj/70Gu
	i5TlDlpXGD47pNZs8f3FCZvvdTSRtL03wnEgFFSpi8vV4o6dTCRAddU3NWM/i8l
X-Received: by 2002:a05:6214:19c7:b0:8ac:b677:c3fc with SMTP id 6a1803df08f44-8cc7b5e9393mr185309626d6.51.1779624956793;
        Sun, 24 May 2026 05:15:56 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.15.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:15:56 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 01/13] firejail: fix COMPATIBLE_MACHINE setting
Date: Sun, 24 May 2026 08:15:28 -0400
Message-ID: <1608741508cddd3a263dca5b4d7a646dcd438d01.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4007

From: Li Zhou <li.zhou@windriver.com>

Because "x86_64" and "arm64" aren't valid in bitbake OVERRIDES,
they should be corrected to "x86-64" and "aarch64".
On the other side, "x86_64" and "arch64" aren't valid MACHINE
name.
So correct the way to "only allow x86-64 and arm64 to build":
COMPATIBLE_MACHINE = "(-)"          => disallow all machine first
COMPATIBLE_MACHINE:aarch64 = "(.*)" => when arch "aarch64" in
OVERRIDES, allow all machines.
COMPATIBLE_MACHINE:x86-64 = "(.*)"  => when arch "x84-64" in
OVERRIDES, allow all machines.

Fix 1dd076d3a76f ("firejail: only allow x86-64 and arm64 to build")

Signed-off-by: Li Zhou <li.zhou@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/Firejail/firejail_0.9.72.bb | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-security/Firejail/firejail_0.9.72.bb b/recipes-security/Firejail/firejail_0.9.72.bb
index cf0190d..746f788 100644
--- a/recipes-security/Firejail/firejail_0.9.72.bb
+++ b/recipes-security/Firejail/firejail_0.9.72.bb
@@ -57,7 +57,8 @@ pkg_postinst_ontarget:${PN} () {
     ${libdir}/${BPN}/fseccomp memory-deny-write-execute ${libdir}/${BPN}/seccomp.mdwx
 }
 
-COMPATIBLE_MACHINE:x86_64 = "x86_64"
-COMPATIBLE_MACHINE:arm64 = "arch64"
+COMPATIBLE_MACHINE = "(-)"
+COMPATIBLE_MACHINE:aarch64 = "(.*)"
+COMPATIBLE_MACHINE:x86-64 = "(.*)"
 
 RDEPENDS:${PN} = "bash"
-- 
2.53.0


