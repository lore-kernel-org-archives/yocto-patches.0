Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D9DD7235E
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 09:00:27 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.64026.1769158817752688723
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 01:00:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=H/is9ZDk;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6860BC21ABC
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3FA296070A
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B7E0119A879A;
	Fri, 23 Jan 2026 10:00:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158815; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c6lHXwv8j/5EWqWTI6KG1Gq7iK2WW6oxisp8oHLA2Ro=;
	b=H/is9ZDkCLkjuQqzBQBAlx+ghywIZjHxCo9R/x+xZo7kQXWyU+OjE4cyd4zn/iXBF+OxTq
	Z14h25UpB8dQbsUiCsQMuduM8gnte5BKP95bQ+HjbsafQQEC/WxJ9IiGUGsKYEkTQsd8Sx
	RJ+oeK4DW5OpocFMdWpJ/T9vBjC0TjiDs4fpU1xuV5pp7a3I8eVJaVlqP8xhNqt9233wr3
	FDWEtto4rBketJrVZhH8CiAx52/lfiF6WXqYg3oq62vg9abaZH7164nJmX5Q4/FoFpFJXX
	vDshFeKjSfFy0j2EteWsYRHf5LYQE642k5jY6ifno8+QZBI4Q0BDUbCcM8ciCQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 09:59:52 +0100
Subject: [yocto-autobuilder-helper][PATCH v2 9/9]
 scripts/release-parser.py: use latest_tag to get branch name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-releases-parser-updates-v2-9-c24c30da807b@bootlin.com>
References: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
In-Reply-To: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=HHmrjMMM8KykJQ8R8oK3pf0PhS7H+U3D6/duM40s2QU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcziWv9gdSEzzCLwBcJJ7VEb7XPHkQzoL+ijxc
 Iw2Lrf9gXqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXM4lgAKCRDRgEFAKaOo
 NoSYEAC656P6L3iUMibv62IU/tjiaq5TznlynnPGuKl18Np8vHne9v6LdWEvVVxHW11Bhh7ZuWt
 CK0KK9ENEg20DSVfNGWB24ePW1ORYC/vn56wAhi0FanMFVV8eOLey9hhqlWobcOHjSo80X9lnRK
 zsLDfjpfu+dY7g0RtuXHAqQMbQlARPCM5+CJXeWUdV5DKtoCOpJDzdBdBtI3bzdqUjv62Li858A
 Z6RObvwzPpTLdEhv/mdY8y3Q4znbwduQzhWLBU1iIv3t84GhFPTWUANAZrtEwDfe0HvBOhOMKYm
 WSbgkztDGKhF2cfRLn0kwR0ZUxcgpotln1uV18NJ2TFTcdLHqcSBWi4up5/V6v6G9FAPTpPEp/X
 +EzmoyfAd3HJpFlQnvexJ0YsIuYTOXXesuW5+vwakupOYhcQg/+rV+M1dOEMBkUn9HosdxG4WmH
 fE9MQrO6kDfZ8naWaf40Gb5LYtQmuFsOo8Y0M+2PHM4rgpI4amxBz3jp7IS/rXiZPIinsvUhuKl
 1z8oKHyefcKixn5IRuMaLzqawNldk6MSF9appZl0bD93pMK6EHNa4frES/zO4ipMlYVkgQ2WkNF
 fJci4I6pe164UNqtxclz1ULZaocUz30qJwjB9vb+PcMWEsxxPwOrAAaH2u2RlSNCvZI+KL8Cz8S
 HD6c1vNtoiUfBhw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3064

On yocto-docs the latest tag seems more accurate to when the
corresponding "branch tag" (i.e. yocto-3.1.33 also has dunfell-23.0.33).
Use this tag to find the correponding branch.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 10c7df6..a2b5aca 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -95,7 +95,7 @@ def get_git_tags():
             "series_version": re.sub(r"[^\d\.]", "", tags[0].name),
             "original_release_date": tags[0].commit.committed_datetime.isoformat(),
             "latest_release_date": latest_tag.commit.committed_datetime.isoformat(),
-            "release_codename": convert_name(tags[0]),
+            "release_codename": convert_name(latest_tag),
             "latest_tag": str(max(tag_names)),
             "releases": tag_strings,
             "status": status,

-- 
2.52.0


