Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7162CA5FC5
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 15:59:07 +0000 (UTC)
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17147.1790783939758175041
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Sep 2026 08:59:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A3EzDhKT;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.98, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b00a0ac65so560964f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Sep 2026 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790783938; x=1791388738; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4AZ0j5cXbPc0ZzMiAtYDO9uWzfrcmtIzhQ2kj050L9o=;
        b=A3EzDhKTudRI1Cckjdm0QApYyQuOiIH5dZ/AAhH+jaxMWsczcnz7pDFgGXjV2/oRr+
         VvrImSSlxcaTIWHe598X/ZImaw/Q9+/K3I5pyhXLHIS5oF/0LpjLvwF5cXWenIrkmxLy
         cx2IF8X0KNeKLoBSNbI97GhBN7eElO3MsIXVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783938; x=1791388738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4AZ0j5cXbPc0ZzMiAtYDO9uWzfrcmtIzhQ2kj050L9o=;
        b=DPPNnfedCtf5Pl8tHu4jJtd+4h+jdTI6V0FOkdsJ09KAxFdPrkWLggKS+PUlYET6Ov
         tolkF8c5iVOol6nLsISmMfT6Xd96fnOtsPnP0Lt45qXYY9Zk5NOpIXQw0StBxeQNx+WK
         KQFFr8xfkxujriOq/vP6fwpU7NvQtEGgDQJMRA/4A2evRnpsqaM3/QX63UCeRsb7Csk9
         2d+EWUeHKrWXmdYD3wL/lnw6Pmv6mBHYzG0JG5GLGaWKV5RsamRjndCI8YFTcP7Lj711
         B3u7zDZPRMzCWTar8qP4QutSjzyGricHV4f1HriuwNCCQIDEkdcVQ13rQSGshuooyrPj
         etrA==
X-Gm-Message-State: AFq9FYL4GuCqrmT/t2zJkaJ2Pue8bPneDiwoeAGoeHIBndEqxZpvRJUc
	ajxAHMogSVfb8r0Gti5axQQKN8kgT1/JSyfsXZGcnvvpQQ1Uaq3DFV9B2mwtr9DcHC7xpYgKp2D
	rG8lURlU=
X-Gm-Gg: AYBFou0xdYPfs9ATB2jY8XBodqs++Tg2OfVqAT9sd9iJZtt4ItuPwOXAH+9kHeGU/hH
	yer6BeBSgZCNLTwCb1oQiRvhQq6+weRkrMBgn+PTbkyneKcaArP3W3jPsBbmTFWkAQHTu6s6ktK
	HFOGlw+rbIYpfCCBlcS5NGe3P24YdWjdPswf9mGuKlknBUmdOymtElIv7bijydGLoBF/qywKMkV
	zXVTaE7+StB3hxAjFR2FCJU4HXivcW4biWhfcHk0aXQHCMrX/7kfXAzTClB8GYo6D5EmQrQJFnI
	v+zeFBYxbM+c1Fpm6IOZfj6185L5ItZo+EoMkhmdZU4lCPgBzTE9iUOc3MleP4EvQT+coVicSkh
	16FXo0ulJ7P6xrWkJ+tPqULFw4OaN7qZZ4QGRJsmhRhBWCTgiXyM40C++gad1n+2h19zHN0LSfw
	gyH7EIwbimluouxFdPyHYWM3uqVrIB/S/ea0wdxR7IZZCDxnxPlSFAkyrcbp+6v5FQNUz0WgbLH
	CcozFfry7UAOuesZEXsTPp3pg==
X-Received: by 2002:adf:e004:0:10b0:48b:5e2:52dd with SMTP id ffacd0b85a97d-48b05e2600dmr361121f8f.11.1790783937765;
        Wed, 30 Sep 2026 08:58:57 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:349:f135:e106:4c82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b02a0462bsm4490925f8f.33.2026.09.30.08.58.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:58:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 1/2] config.py: Add meta-mingw to check-layer-nightly
Date: Wed, 30 Sep 2026 16:58:55 +0100
Message-ID: <20260930155856.1179553-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Sep 2026 15:59:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4972

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 09736b8f..3275e6fb 100644
--- a/config.py
+++ b/config.py
@@ -24,7 +24,7 @@ buildertorepos = {
     "qemuarm-oecore": ["oecore", "bitbake"],
     "checkuri": baserepos,
     "check-layer": baserepos + ["meta-mingw", "meta-gplv2"],
-    "check-layer-nightly": baserepos + ["meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv", "mixin-wrynose-linux-firmware"],
+    "check-layer-nightly": baserepos + ["meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv", "mixin-wrynose-linux-firmware", "meta-mingw"],
     "docs": ["yocto-autobuilder-helper", "yocto-docs", "bitbake"],
     "reproducible-meta-oe": baserepos + ["meta-openembedded"],
     "patchtest": baserepos + ["meta-patchtest", "meta-openembedded"],

