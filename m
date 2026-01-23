Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDBFD7235E
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 09:00:17 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63625.1769158812841511283
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 01:00:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=l9r/pEuD;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4A1F9C21ABD
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2159B6070A
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B06A119A879C;
	Fri, 23 Jan 2026 10:00:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158810; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=taROIC6bFNyPnJGCZbSgxjrTGmp0vR3br4mTvGTlKmc=;
	b=l9r/pEuDhHUbpTRpgBK08VbXrQm1aNwa9EEmnkyOsd6oQx7XJz342VlhtGFELSj0wag3Ky
	mrl2gO2ZmH2aZ5wy6JrJzl1ujNUsK95gpHkp6muWp7FDfgL7B0cczWsu+sFEhtExv0KedW
	qLPJaWev4Q9E2oxzGYCg4F6HpZ+xu6QKGkVcJ90zFFJds1wyHhCrUBShTrbcV+0Q2itTEI
	AA0AeYE8QYZ4Rb3bhR5v1R5DdiqWoyyXGDcuxFTZnze/nsw78JmGUD/7J7C3XeOfMz9Ag0
	s+SMCMZ1h87LHLZSMUsf7l+KwD2zusHA5x/UvdKvDL1TEGsY1WUQ/hHifmxIKQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 09:59:46 +0100
Subject: [yocto-autobuilder-helper][PATCH v2 3/9]
 scripts/release-parser.py: define globals for stable/active versions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-releases-parser-updates-v2-3-c24c30da807b@bootlin.com>
References: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
In-Reply-To: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=dp5dWhAQbAQ2jzTEjrCwlVF+zb+h88SOi78/jTWg2Yw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcziVqk+7ZBtPKiO6nxosq/3Zr7keYQLkI3Znk
 1c4rxtpR9aJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXM4lQAKCRDRgEFAKaOo
 NlLEEACFsr8gsy3kfoVf5bnDu8KjCswfOpPWUZk7wTEtBAhmHF+2PtHigkMV+VVlknYcw9TF+Tf
 CHuzRgJHu7I9JeiXoI0R2a+Pf8o16Z5hQeBGkN8qF41miHNJ6XLaC1CgrZ258eGOXxa1ylFPhbh
 bF6QM4PTaGAd8UXG/Q/iKe6CUbeAb+tgGMcC3E82g7npVygeP9uOsaXEwMx+qvJxJZVewvPgCAJ
 lbMkcQz3cUBR61rX6uCXW3eN8HRWyOwF+dUmQhvoFW3YAGeWLAUbjXtvOaP4XVT6E/vvWth3ObB
 PIZsMATIs716yfl8kxkY4r0dLR44XReQpPeby9zejQXaDe9sGN+Ixp3EfPwJ1q4uPz6OCVb/vAu
 tHH5MLH/FqQm6XzaKpHsaZcRkrPcnHVgYA3K953ufdpbbiY+sIN1Z5RgVXKfZe5cmOuGp6N44HA
 HaeMdvGIgTjyG7tmSWTiwfo3TtQEg8liXnBNUK4uHtSKkTv2JuxNbRZ5SSVNFZmX5ms6n8ENwjc
 hQ8+witYXcdGJK1vvlPSiagc4SKma3UwrloRFNntTNVbEOF9HL4VmYSMyQqFzgfz4HXSo60vCnl
 yvJBU3hZzv65WRpV9eeSCZt3Ar2dYQISgKyf97ZkOIktswwvq1sDIEj1ZtT4lz5NHS/EA1qjUL9
 3YodR3/X/xHOqOw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3057

To avoid forgetting a spot where the we need to update this information,
define it at the top of the file and use it in the code below.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index e882569..33c5fe7 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -17,6 +17,9 @@ SUPPORTED_RELEASES = {
      "yocto-5.0": "LTS until Apr. 2028",
      "yocto-5.3": "Stable Release until Apr. 2026",
 }
+CURRENT_ACTIVE_DEV_CODENAME = "Wrynose"
+CURRENT_ACTIVE_DEV_VERSION = "6.0"
+CURRENT_STABLE_BRANCH = "5.3"
 
 repo = Repo(GIT_REPO)
 
@@ -109,12 +112,12 @@ tags = sorted(get_git_tags(), key=lambda x: x["original_release_date"], reverse=
 
 tags.append(
     {
-        "series_version": "6.0",
+        "series_version": CURRENT_ACTIVE_DEV_VERSION,
         "original_release_date": "",
         "latest_release_date": "",
-        "release_codename": "Wrynose",
+        "release_codename": CURRENT_ACTIVE_DEV_CODENAME,
         "latest_tag": "",
-        "releases" : list(e.name for e in filter(lambda e: e.name.startswith("6.0"), repo.tags)),
+        "releases" : list(e.name for e in filter(lambda e: e.name.startswith(CURRENT_ACTIVE_DEV_VERSION), repo.tags)),
         "status": "Active Development",
         "download": "",
     }

-- 
2.52.0


