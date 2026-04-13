Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685A3F34C49
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 14:00:41 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.273208.1776088830973381334
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Apr 2026 07:00:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=QTC/vJQy;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 13BB3C5B1AA
	for <yocto-patches@lists.yoctoproject.org>; Mon, 13 Apr 2026 14:01:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 77BBC5FFB9;
	Mon, 13 Apr 2026 14:00:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2EE71045001B;
	Mon, 13 Apr 2026 16:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776088828; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2rSzLUcEplISEHw1lGD45i7+/A+JapVvKF4jvH2atKE=;
	b=QTC/vJQybgVModc9djAqwtM/tAsy35hTWz57EgmTaSeHphKqnfFq8WCwJxpTDCFOTDBVaL
	4VXoyWDFojjdcXXIIVVimSUZKQ8iSnfATO5DPdnvPLxiPXGDV6pQvFe5Y4UBQiEAj+Fy4I
	8NGZyb2QgQRrlEFo6rdaJCkrv/C84INwQsCR604YOatfj6TzLMgrSTJqC2sbEXekQFtN63
	462L+WML+gad2CRFwSujHKjKCdQ82oWzL52KBQQlw4VJY//dZRbvPoSjqoalOcvguNWh3+
	q9qlhuAa/eL8Su7rNvvo8qIGxKfPXiF5ao726tiANMk6Mw85rdBZVDqgGISKsg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 13 Apr 2026 16:00:11 +0200
Subject: [yocto-autobuilder-helper][PATCH] scripts/run-docs-build: checkout
 releases diagram from master
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-checkout-releases-svg-v1-1-c0fb7ba0dcd0@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CIBBG4as0s3YSIcQYr9J0QeG3RUlpGGg0T
 e8u6vJbvLeTIAcI3bqdMrYgIS0N6tSRm+0ygYNvJn3WRil1ZTfDPVMtnBFhBcKyTXwxylulNZw
 11No14x5ev28//C11fMCV76x/J1cS21rSWEP0yDwjrsgDHccHsVslZ5MAAAA=
X-Change-ID: 20241118-checkout-releases-svg-641da122eca4
To: yocto-patches@lists.yoctoproject.org
Cc: docs@lists.yoctoproject.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=UiLGJYuizDnSxD+ay/JoDr3oCHWTnHbwgStkexq3rzI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBp3Pb6YxHSDSKzRbieuWHOnNrmM+C8Q+HnUo5n2
 DK3FlRXTdWJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCadz2+gAKCRDRgEFAKaOo
 NmJtD/4+021rW+Uvi0UpmTAsjc3ayiBlQ5sGV5xHLN2K1QkvQtY/BUmkjXnhIrFclB+tkwbpa75
 CfzgF6eKahvC7skxBlh4wSJ0rLq4RhEKVaaCKCCIQWFAZhkEG0pgULzyoeI9Dt/hQWrU/XS0zZc
 /8FBFdHXJKqZCaqPuduzA/lgM6rHHMq8oN4twX8aGTzil5ePDQGUeGAcizZCwOqgt5/XVKOyg2Q
 Tay0ZF3pa5rUngCxRP1QS7AdbmGGdgahFyjUa6Lktvd6tVPR1/dHkfCNC4GedYDo09qL8vuEmEj
 +l0rXV1AW7GruMmiOj3lgb2RVPVvNxhPLw46AWme00yWXKt3aiM9D9jD8uPhftB64i+E02/Z2d8
 prl1EWN3x5UlI1m5hbqEnboCOjPc79mG8+BFqnNOIAo90/Ly8mQTx3eZYf1dOmV5k2+PW8gdzWc
 nsatwjjHGdKF7cNcJdDMucby5UZjaQVrQ9fG6X2UyRYt0Mp4YKpGQW7NW8xP0tKQL98sHVvBgod
 4gm4w/KJHkRph40pUl9xIb8sbNf0DLyt3iIb/kAlbz+nQZ3cUeQBPSGOmxbAZ1E+PpSzPPf5o5Y
 rY0q1j2GHeS1n92lwISORV9FtQbuTx5o0EQbsO6rqiIWJQ2D7p2MOlqg1YVf8cp4R+ziPf/LCiX
 +8ozssYhAGYJNZA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 Apr 2026 14:00:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3694

This diagram needs to be up-to-date on every release (when the release
has the diagram included), because it represents the list of
dev, current, and EOL releases. Checkout the diagram from master to avoid
having to manually backport it by hand.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 268ce73..acd8a24 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -215,6 +215,9 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
     if [ -e poky.yaml ]; then
         cp poky.yaml poky.yaml.in
     fi
+    if [ -f ref-manual/svg/releases.svg ]; then
+      git checkout origin/master ref-manual/svg/releases.svg
+    fi
 
     (
         # Anything older than scarthgap needs the older buildtools

---
base-commit: 1a4d66183644561412603af75ef5e90e54680a24
change-id: 20241118-checkout-releases-svg-641da122eca4


