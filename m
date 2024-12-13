Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7177DE7717D
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 14:19:43 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.16651.1734099577149325140
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 06:19:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=NY5bFCj6;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7524740002;
	Fri, 13 Dec 2024 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734099574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ooa+YakIv00B7LmM+R/Ax5zdCu11rYyX49oRleleBWk=;
	b=NY5bFCj6gvmpAjd9qjdWmAIUsyztBVUTQg+fzDwtVWY9oNUOM4yD/tY/LeYGzlsQxhxNW5
	iLU6oxpVpMjPBnX2yH9hb/PNhyO8/Lcf0/burcBoV9/wHzIQbl8zFN4+jSZC63z5GNArDr
	cOQWzvPN+oUOCLtOmeGiR6BdDWwJF3mm4MIGnAvWzlF0xJC6O+T57xle2OZNkW2rY7NMB2
	DWef7yD/ZO5nEFhyq2TV52d2ZRKl3eh5MTOXXyrIiNqg6BPxKiZtpFaR+5Xzz/W76dez9E
	HdGjVOrTEOopLCx3IRORWCGf23RKS+4k3HZoj0nemzXmwTCkB3OJe+szASnmYA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 13 Dec 2024 15:19:19 +0100
Subject: [PATCH] scripts/run-docs-build: update buildtools-docs url
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-update-buildtools-docs-v1-1-f2c1d5bad783@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAGZCXGcC/x3MwQpAQBCA4VfRnE3ZtSivIgfsDFOy2kFK3t3m+
 B3+/wGlKKTQZg9EukQlbAkmz2Bahm0mFJ8MtrDOWFPiufvhIBxPWf0Rwqrow6TIrnANc12V3EC
 K90gs9z/u+vf9ADXf9m1oAAAA
X-Change-ID: 20241213-update-buildtools-docs-f4047ff653f7
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=3IJ70O/9SZo1R9vz6k34HODCIv3geQ3CWSwsMTP4Wzk=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnXEJ2Xjj1/qLnmRzK4qYbWRid3niX42K531+Ja
 0PbTHcy19+JAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ1xCdgAKCRDRgEFAKaOo
 Nr9wD/4hJYkln7JLmYI4klyWoojVZoZH02B0+vr3vnHJkvr8s9h7oulPeiQwCW/at1QwWYxlnTw
 04I027aFvB92fdzKggl0CuNePKywJnmO/FJ9khhbEwgBOgSXky6QkOGceowUrbLiOnTZiMe6Tnp
 DqQrYTzBRjZ9L033Y+i1kcVdMxWfw2C+XK+Wn5rC36sxxe1iSZtfNxSvkrqufJrJzqGpznHQ/0t
 Ci1UYi9xwQD2aVR0ow5a1IDH2c9T4jJMexeP6oSsh8vCRN4Tkzk6CuDxsg3l8rttRjgSZq51473
 OBl269JScuEkp6o1n8KiWvrlt4y3n2gq5id9dFvQzUbHVFmNSBb5jnXxexgP1RuP8ifQNbdjBSb
 nhmHIVHIAy9xXayq8SxI1Yn9ThIicDDyw4MuT3pdTUxV1ZIDYNHtbEsmhXGuzHP+i5ZeYCyNRjn
 RBlorcUyZzOOfVHsBKxapmUrW+dhO1+xUBoeK6sxYTvXOSCvCdraZ5IMH2OOACV8dQwkqL9U+b6
 /jjJxAMtKQ75i51LX2pPQyNxuVmMbIwODyp6cFI4+ZRl8skXjSHUa4qJlpUjOtiTYxNWu5/XhY5
 VVK2fpxN7FNN8eC7f3KH9w+SCz6pxvGPWxoNkp/m7ga0yc266cxN5qb7CGLnAvmWi2U+FYn2/SY
 7HmhS9qbtSthxuw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 14:19:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/897

We were using this one temporarily to use the new Sphinx version and
rsvg-tools. Update the URL now that 5.1.1 is released.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 9945d6b6e15367a54c5725c7dfac636b9f48dbe4..5e2cbc8381c2faa8407ca66e790e1704bb5bf093 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -26,7 +26,7 @@ scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 PUBLISH=${PUBLISH:-1}
 sharedir=`jq -r '.["BASE_SHAREDDIR"]' < $HOME/config-local.json`
 # Modified 5.1 tools image to include rsvg, switch to next released version
-buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.1-modified.sh}
+buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/yocto-5.1.1/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.1.1.sh}
 buildtools_url_old=${buildtools_url_old:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-4.1.2.sh}
 docbookarchive_url=${docbookarchive_url:-https://downloads.yoctoproject.org/mirror/docbook-mirror/docbook-archives-20201105.tar.xz}
 

---
base-commit: d1bee95e8d222932f84cb9aee5d3c4ec65c7c573
change-id: 20241213-update-buildtools-docs-f4047ff653f7

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


