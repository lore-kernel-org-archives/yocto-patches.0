Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20940.1792668835511646641
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Oct 2026 04:33:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=fjvLz2HY;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2F8414E412AE
	for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 11:33:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F2D3C60360
	for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 11:33:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D5F810328E83;
	Thu, 22 Oct 2026 13:33:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792668832; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=XOOdNz+IQXYvlrxvD+I4m+RcQWKOozZGntYDTXVytsU=;
	b=fjvLz2HYnuZa9CcvVK6TIBwU5Y1/340vmoTlQPqka331/MRLgjVrvYKHbYIcUS3uvext9e
	2QP/KFfoCTO1KGQV0wILsuYPmHQ85bBfp7imiEIFetbO3CfeGrJhWAUYae8oCt4YQSM0zB
	snln28JjJqPI20ZTtoPOugQK92A11Q/xDpRlYHMLHCr/Edb5LWgpSbbH15CKd65+tW8cPy
	Ou7G+vPIeYK4VJl3ei+xvnJVnwUtom/Kz6BClz0KTffMAakdEJRfKMalmukdUJxSE8J03r
	cVve/ytlDaC/JNOq1Y/kJOsxJTh8acoOf1BUi4Z6KM0Im0w1dFCKQEWYjtdSNw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 22 Oct 2026 13:33:24 +0200
Subject: [yocto-autobuilder-helper][PATCH] scripts/release-parser.py:
 update for Garburn
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-update-release-parser-v1-1-f9539dfc34e5@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CIBBG4as0s5akJYiJV2m6oPBrxzSFDGA0T
 e8u6vIt3rdThjAyXbudBE/OHLcWw6kjv7jtDsWhNele26HXWtUUXIESrHAZKjlpgtJn6429BGu
 sofYmwY1fP3ec/p3r/IAvX2x8R1+icrXEufIaGrBgTZCJjuMDrZHhxpMAAAA=
X-Change-ID: 20261022-update-release-parser-256c467d6464
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=1iueO7ht88LUlFU2m0IWorNgHYF5DFWqMxcJ2iD5MNQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBq2fSH6sQ3N/MlTsHS9ZzDE5opw1dvf30tUe2Qg
 Y9ai6fN9nOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCatn0hwAKCRDRgEFAKaOo
 NrR1EACUAKU2c39OohKKxQDog7klNfcQhWtM97CrYIy4pP5TfxOSrdEy9Qg2kZf0wbFsMkzMiGD
 im4KJ6oRKLSHKRMAoDu/5iVaWetatUu8rIbEvZeVggpmC0lIUw6QrJYZ9qx/tlJhjsfa+rzTxZs
 xwZ8pqoVlJzCqFGrvGRVvLfPl86JNyFYY3+cv1GO4kxJwQ54lFLo8ASImhNtZb2nTWd+5GyVgpJ
 B0GSt0WqhYlTdk5Af7E1b/lB1mR6FICBXZFyeOe7IKdIdXpihTCC+H/bwTyAFtAmg5x17s2cZrb
 baBXj/RE2JYonDRcn5b7DDvOGkDug6KYPEZbzGl9Uyhrdr2Yk08/DQhf96BnkJUTrZqYqdoC0G+
 GPd2l+B9naxTbupWEN9qY8z2BpG99qW+j4AZWhVXYg1TqS1T6VvdPalT6jqMBNnCoZ6nqjzxeiz
 MgojvII4wi6yXsSqABNctt013e1q6JXes9MSDQnXeYDWhHyBC1o390oq4nRftMIyHu6ncyerSWq
 BMvz9my/zQYO/eds41vtRRweOWZkgs150tHAEcJKLZvSDyVXfIPnQBKwHJ3/usfp4XCAfC1TpPM
 OUAEbMwIvDJ5xsht5vnEaPUrppZcHLmn5Dw/S9bfpsnld/pCC5ClnGpNz3Y5sJslu49fyp1ptVN
 Mt/RKzjV1ykAxeQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 11:34:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5130

Set Garburn as the development branch, set Blacksail as the current
stable release, keep Wrynose and Scarthgap as LTS releases.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index e4ed5ff..e3167ec 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -21,16 +21,17 @@ BITBAKE_REPO = args.bitbake_repo
 print(f"Reading tag information in {GIT_REPO}")
 
 SUPPORTED_RELEASES = {
-     "yocto-6.0": "LTS until Apr. 2030",
-     "yocto-5.0": "LTS until Apr. 2028",
+    "yocto-6.1": "Stable Release until Apr. 2027",
+    "yocto-6.0": "LTS until Apr. 2030",
+    "yocto-5.0": "LTS until Apr. 2028",
 }
 
-CURRENT_ACTIVE_DEV_CODENAME = "Blacksail"
-CURRENT_ACTIVE_DEV_VERSION = "6.1"
+CURRENT_ACTIVE_DEV_CODENAME = "Garburn"
+CURRENT_ACTIVE_DEV_VERSION = "6.2"
 CURRENT_ACTIVE_DEV_MAINTAINER_NAME = "Richard Purdie"
 CURRENT_ACTIVE_DEV_MAINTAINER_EMAIL = "richard.purdie@linuxfoundation.org"
-CURRENT_ACTIVE_DEV_BITBAKE_MAPPING = "2.20"
-CURRENT_STABLE_BRANCH = "6.0"
+CURRENT_ACTIVE_DEV_BITBAKE_MAPPING = "2.22"
+CURRENT_STABLE_BRANCH = "6.1"
 CURRENT_STABLE_MAINTAINER_NAME = "Yoann Congal"
 CURRENT_STABLE_MAINTAINER_EMAIL = "yoann.congal@smile.fr"
 

---
base-commit: c6b9dd6a87ae1650588b05eef0a623a727e4512f
change-id: 20261022-update-release-parser-256c467d6464

