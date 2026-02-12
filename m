Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B728EB2719
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 08:40:03 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41268.1770885601020531800
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 00:40:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=anx+RwZo;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 95BA2C23D94
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:40:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E4D0606CA
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:39:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB74B1197149B;
	Thu, 12 Feb 2026 09:39:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770885599; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kU5LY2EuH8uF533RvfDFFn7zS6jpUSl+YYPEfJ8nakU=;
	b=anx+RwZobr8sFuPQL9j3homRkw5s6osce5I71aA4duTIrECl9cUSwvLkmKm3rW/onY6IXr
	q8Ixf2ENFAcJ8ZGquPHHOFC1uE7YSW1ozLa4E4p0vPIqxj0WAqdqPDSD1DZkwSNpi5Ok11
	BjSfIDj+MSwJB4dHHp2f2JjICdAbyrh6tSBt9+lPeGHuk0WjuJZI5eID+pfKPjz4c3ij2w
	CGR0fHrVrPV7qHII8hB6g3iM1MpqI6AM3sYKxLXrLngfxDirm0HqL+a2pzJYrWYNz2K5ED
	1OGqhWIW9mNXXBwJaVwvFbXdDM3WRvzMNt0wgmTPG4zTHfefhQ9pvu+VkAhouw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 12 Feb 2026 09:39:47 +0100
Subject: [yocto-autobuilder-helper][PATCH 1/2] scripts/run-docs-build: do
 not run set_versions.py manually
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-fix-switchers-js-ydocs-v1-1-ab1113759747@bootlin.com>
References: <20260212-fix-switchers-js-ydocs-v1-0-ab1113759747@bootlin.com>
In-Reply-To: <20260212-fix-switchers-js-ydocs-v1-0-ab1113759747@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=943;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=n9XuWjohzLFviGbleXSVGhwOMsVq/ONK2sQfe4qzuEE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpjZHdOfRDfPs1XmPz4NABYcfRF51Dzqn8K1rvW
 z3R0j8UQeaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaY2R3QAKCRDRgEFAKaOo
 NijGD/40C0IySdyj6GUd5UBQ46Utr9IAScv+G2Gv+hf0EJQlH/cFa0SR7HMcKFeUV+YC36ifJnu
 r8kWy2mFHdKxWRPVKgAAh323yxqw7MgsbPFtMSYw2J8+IYcBnW1O9/qts82KeW1VxgHClAEcbQL
 BntzBeecOjJbdtwju3UNmuHCpP1xEExqExzO7fx0Nkm//dgsE40JIL9LwhSM1hGLnv5L/JA8Gkl
 YeBA2EC2NqxIQGEUOjqYGu33MMF7nwfNXuGlS5RbcpRZwbcL/PUWlhOTPfT/zastFapmoXPMEtH
 C84W6XyVORqqZ292RGKl4GNJNP3+uyNMnqvSzfLSkxuTNDM4WSs10bEujaPoappZJfNSjINF+Ma
 bz/2dzo7lN45VSClZHEhLsAhC2+FlMofxFHzBl2cJD0P+qbffRfcXi8lujfJjm9Mv06GM2K5Uad
 g0a9hjoq5qqOnhAz9IvE9M3PV5VoUequh/+6eLUuzl5LYXeVxWSxj00Le4Qj7ZzfPfCiJ/FXyzn
 8lyd3tj5PKzG5tdEUmNeVgiI9yoqycAnZ+i/7/hRpCYXyep+CGDxO4WsiTjV3SatIQfI07j0jBt
 Yg1THbyWIddifsUw5iviQQ1nDBvVvDL+ctL0xNHz5a9scjawAXV5Q2JMsJuakD1wkBOSeh9bFP7
 rmJq/sl9AWpyY8A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:40:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3224

Recent changes to the set_versions.py script make this unnecessary, as
the version is automatically deduced in the script already.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 67473e6..afc05d1 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -196,14 +196,6 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
     git checkout origin/master sphinx-static/switchers.js.in set_versions.py
     if [ -e poky.yaml ]; then
         cp poky.yaml poky.yaml.in
-        case $branch in
-            yocto-*)
-                ./set_versions.py $(echo "$branch" | sed 's/yocto-//')
-                ;;
-            *)
-                ./set_versions.py
-                ;;
-        esac
     fi
 
     (

-- 
2.52.0


