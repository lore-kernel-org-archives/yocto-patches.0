Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B575DEB7EB1
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 08:40:52 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13914.1772613646913023217
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Mar 2026 00:40:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=JziTEKM1;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3F2E91A2B56
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Mar 2026 08:40:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15C0E5FF5C;
	Wed,  4 Mar 2026 08:40:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E5611036971B;
	Wed,  4 Mar 2026 09:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772613644; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1td+57tIFynlmeXmEi8qotcuR0Ia2q6vxQJFuUMBLU8=;
	b=JziTEKM1LgqT4LAZ0kh46dgY9Tc3qyuvv8K2ewLKfG9JRigDlXE+JdyxZ2tjJ6Ydi5o/3R
	gHeEXXGrE3E+IFJIX2eqVmxKlYi3FgsFM61heu+oe8J8kjzln9QabY+z2OtwBcepqLniLZ
	cz2PQYsY4/RhGRZpl4BkGY30DcpFqANDnWaB2pb0JBZu5JrlzK98wnSqHU5IkEAWJ82amJ
	qf8SsnuVcC7gAuYO4vApZa4guWdSLXvGfRM+6bngT0P7pIIlAd7JxcUCIZT9FAFVXWL8mp
	0MhCQh0OzDN6oGVYjQGFln5Yjr6kBlAGsqu7Tjiqw9UiBnDEOMTXHADLmV2c3A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Mar 2026 09:40:37 +0100
Subject: [yocto-autobuilder-helper][PATCH 2/2] scripts/run-docs-build:
 remove an obsolete comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-docs-gen-releases-json-v1-2-174049cbef87@bootlin.com>
References: <20260304-docs-gen-releases-json-v1-0-174049cbef87@bootlin.com>
In-Reply-To: <20260304-docs-gen-releases-json-v1-0-174049cbef87@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=726;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=l5NW0xYfYzUx7OL0Qn5JPTeugSylB6jCQ/mP2YGhWY4=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpp/AKevtmOlfUUtNLnmiFnVz836LnjfunXAyO8
 uW1Kfw1sUWJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaafwCgAKCRDRgEFAKaOo
 NkpoEACYh8rjFHKGjw1Rirv3Sqo9jUb7ffC8tsgL/oQhRA7IRqlAKSBsXlIrIRzsoIYl4RPY5fe
 ewyhBBFX5dR/9GakjDGIqoZIhwCiy4kcm/p20e60hQ0oCEgW2xzMNpDht0JytoT5bcu44II+Nu6
 yfVFWzKyeNcUDLCidj5VAXJgp80eXVCXBRfliSh6rcNnQyRufv18Fa1CN465qoF5fEKxEqqqlGO
 0FDrJu2mGP1pj9bpm4RKgrzp5y3BPxidlr74Rpz+RDZhOHEui3wBMMwprpI8J2HWKMPQnpjWW8h
 D5ZQvAPWcKhKb9BQd4cktPLQi/AxORst7yw7Y1J/m2pX+xw7XiFeebQ1oIZRmdACMUackNwNx/I
 Au9KF9bhDfvz6/G27uIuPfxqckZI3tDaQLJvB/VkAfCUnz1L5Bdcf6kklQWGDeyYusbKtwfaQs6
 m8PybI1GCNp/s0lIHT5DcGnLWBHmqlvO7Copo6eJlJevf7KnvyrxdDbrj0MyRlZt9Ztvpz7l93q
 DzLua4Y6em91DHLN6UGtKNylDQsdOL7sXga+vrmbRZOl7XMMCpwuvGgX03QZ8aVaAQaBa5Opk8Q
 ouV6WuYPeOdXcvcJcFJNJGMUUp4lZLRy0lagath39vg0QmKLQC4V474xI6M4LRXVAtHGdpPV/oO
 3pPAVXrZYMvWSMA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 08:40:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3325

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index b75799e..edd0574 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -173,7 +173,6 @@ ypdocsbranch=$(git symbolic-ref -q --short HEAD || git rev-parse HEAD)
 
 git checkout origin/master set_versions.py
 cp "$builddir"/releases.json "$ypdocs"/
-#latest_tag=$(git tag --contains "$first_sphinx_commit" --contains "$first_dunfell_sphinx_commit" --sort="version:refname" 'yocto-*' | tail -1 | sed 's/yocto-//')
 latest_tag=$(./set_versions.py getlatest)
 git reset --hard
 git clean -ffdx

-- 
2.53.0


