Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17426.1795526102909681759
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 05:15:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=SjqVCUDT;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8D6D7C2C648
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:15:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 19A0B601E1
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:15:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7778411E6992F;
	Tue, 24 Nov 2026 14:14:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795526096; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zptt4DDfWgBwLD9mL4k9BaSYuMvIrBAmZRvUaeZTR1Q=;
	b=SjqVCUDT4DQ3Z3Fv/DNARLb9SFmiJ59TVdmH9laFmlWF7wLrFiwuGxSpxgJYdhl5r1UH+K
	twXv3fHzYUNeJAQsB3DuZHWL9RKONa+KjPJEv2AQdN2CZQmaCtLv7THanZhWOTO2AWVZyK
	kzZoclj6zmOhfIJ2ib1SFokrGyjiDCYM+EAlDnfSI7dl3pK304F3luEW8aGmhgmNnCt9li
	SKwVzT/cEE+BBxDyBkxMEskuSdZJl+V4ODkaKIWO1MEF9MJvldEEmZmzxAFiCOqBPRdTXg
	kjSRQ6sUC/gI8mEdnmKyOPs3uOgufANXvdtnqmi7H3S3sA/HVZY83uvzH8V1Pw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 24 Nov 2026 14:14:37 +0100
Subject: [yocto-autobuilder-helper][PATCH 3/4] scripts/run-docs-build:
 export AUTOBUILDER_BUILD when building the docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-docs-build-oecore-functions-v1-3-ce9f3c4fbad4@bootlin.com>
References: <20261124-docs-build-oecore-functions-v1-0-ce9f3c4fbad4@bootlin.com>
In-Reply-To: <20261124-docs-build-oecore-functions-v1-0-ce9f3c4fbad4@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=984;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=9Qk6eYNwXIR0NCJvSb+la6/FBSNjglXdmBJ0Rp9SdWc=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBrBY29hHOjAoaKhfwFXlbZ9+/HOB1isUZYKBahM
 w/vTgkKQAuJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCawWNvQAKCRDRgEFAKaOo
 NtKREAC0F9agqwhhLLsR2D/p8UPttC2t7Z8BzINnTFZqw3jKPsOF+1wRo0LIGHkgXLnxWtQbJm8
 EfDoQnVL7pvsOn1rhhnJ/iJZhLNzMBh8g+bb//cSnTMrpvzEGgBPtzpOmItfH9/yJ9qJmek/GuI
 NJ5oew8xyMSNirmmJcwQ1tn97RJCPEtpCijMkV4IbHxkUZhcez7BDl7KPpV6e/EnlHzxc6liV3/
 CB/lOTAr+hOXgkWyXDvk0PFgM0mOokcwKBq5VSurWiFn94zKRpacNf1+BRcWmbvz7oY2uI9l7P/
 /BV11pSJhNwWwb5xbBdJ8Q/ZfM/fpTNe00EqxfXso96N4nI1KzE960jU55xOBro/vK1sfncUe45
 x9QZSXsbFlR6aIo5NIPGRzROaUpNh/QLnAAWKo/QGiSTM7eUgaQ3gyVAw1PMG+qgT8emH+AOvjK
 8GxaERxo3Q0n0V3FZgzg0UQCKErwT7gm3qToJxCJcvUUy3Xse2ioYjTt7eDwn5fCYHeiQ/wcHaC
 I/W2gx6e4B4w+mz2sFwc9foKi/QJDRPq9VEvLqaiZef5EAS3y0tSxjTFoJ9U+Dd5WRkYX8reVbe
 oNBT7U7YTNQrCOYb5wgDNZFI5H5CRlu9dQbJXf4xSvEkItm8gBLvG2+K7dTcppj7iCm8w8DI7RV
 tIjERyHLcb4DYYA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:15:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5510

yocto-docs reads this variable to perform stricter checks to make sure
everything is setup correctly for building the docs. This ensures that
docs are built correctly before publishing them. See how it is used in
yocto-docs directly.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 157a201..36e0793 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -21,6 +21,12 @@ set -u
 set -o pipefail
 set -x
 
+# yocto-docs reads this variable to perform stricter checks to make sure
+# everything is setup correctly for building the docs. This ensures that docs
+# are built correctly before publishing them. See how it is used in yocto-docs
+# directly.
+export AUTOBUILDER_BUILD=1
+
 builddir=$(realpath "$1")
 ypdocs=$(realpath "$2/documentation/")
 bbdocs=$(realpath "$3/doc/")

-- 
2.56.0

