Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F5FC43458
	for <webhook@archiver.kernel.org>; Sat, 11 Jul 2026 12:15:39 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3813.1783772135065384196
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 11 Jul 2026 05:15:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=FyOyoeK1;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BFEA34E40D61
	for <yocto-patches@lists.yoctoproject.org>; Sat, 11 Jul 2026 12:15:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8C21060343
	for <yocto-patches@lists.yoctoproject.org>; Sat, 11 Jul 2026 12:15:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CE1011BD03B0;
	Sat, 11 Jul 2026 14:15:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783772132; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ZojurJyXmQhJkoJKPFSgZebRXsnICdQNPAz3OhOzP1Q=;
	b=FyOyoeK1bl1mmxKEqWJ2PL0NR2R9KfINbuXxTS6sRwZ2J9BNbDPWXYRV2DOFwHDTGQuoE4
	llyqLpkTmkBIVonFz6gdiq2aOfZcJgLvcGTd9GQUFG6XZd1Q481ah3EuZqAftZRppfrOmS
	0X4kIGHlrvP2fa5Z6CRcg+tH1VcJ4rcaJmAvZrGkv/ITMO1qrCQlcyO6UgfVEVPK95FvcV
	/hUYGjqgfD7eHLuIB9aEGO5J3qOOf1kCZkNh5hs1pDJIfpoHwFb9SwVz2kJp8lmw38+BPa
	wKwVha5e6BFd8f8Ny7RpUCdbRQerZrydn97zeZqUdzLoJSJ3DVNrbTplmUm6ww==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sat, 11 Jul 2026 14:15:11 +0200
Subject: [PATCH yocto-autobuilder-helper] config.json: Use buildtools on
 Debian 11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-mathieu-buildtools-debian11-v1-1-6ee1c697290f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAM4zUmoC/x2MywrCMBAAf6Xs2YVsC7X4K+IhaVazELMlD1FK/
 93Q4zDM7FA4Cxe4DTtk/kgRTR3oMsAabHoxiu8MoxlncyXCt61BuKFrEn1VjQU9O7GpO0eLn6Z
 l9kQG+mHL/JTveb/DT9eqaFvVM+WMgePGGR7H8Qdhe9vrhwAAAA==
X-Change-ID: 20260711-mathieu-buildtools-debian11-b18d3386d110
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783772131; l=910;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=VoJ7vw2ybLtp6FmLrjOZqVErYO4E3S9Hlu8PGc2g24o=;
 b=01FG6v1IAl/Kk08F2SrGzSZIhqJD9+DgicRQ1mxNC0t0V5QMsnUxYONt4K3mOTP8mVfrKZp6l
 TIOn2MVTLTaAOPr+H9+Puek6+bfVKMlO7yKqI5PJ2b/qGaJ5+ItE7CA
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 11 Jul 2026 12:15:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4470

Debian 11 glibc version is too old for systemd 261: we will have to use
buildtools to support this platform.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index f4ead186e0d4..4d329e3e5ac4 100644
--- a/config.json
+++ b/config.json
@@ -1968,6 +1968,7 @@
         "rocky9*"      : "${BUILDTOOLS_URL}",
         "stream9*"     : "${BUILDTOOLS_URL}",
         "opensuse156*" : "${BUILDTOOLS_URL}",
-        "perf-alma8*"  : "${BUILDTOOLS_URL}"
+        "perf-alma8*"  : "${BUILDTOOLS_URL}",
+        "debian11*"    : "${BUILDTOOLS_URL}"
     }
 }

---
base-commit: 5de9879aee18eb337377a765987b12b3dc3f0dd2
change-id: 20260711-mathieu-buildtools-debian11-b18d3386d110

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


