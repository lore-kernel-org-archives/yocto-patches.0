Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE3BECD6FB
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 08:40:03 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41269.1770885601536247085
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 00:40:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=fjzwF0pa;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 197DFC23D99
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:40:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F387C606CA
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:39:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64A4B119714D5;
	Thu, 12 Feb 2026 09:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770885599; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hNtypsFhYvbkPhtjb66NiaW8kyxl03ZBZ8sWwU7DQPo=;
	b=fjzwF0paWyV5M3YakGhNG5HfgZQYvWKrcGJOrHI1U8O0yCAVRGMUTTphDJh0NskOE9snIp
	QG3zgeqaSuufLWA2CwoZO1GqbNB27qy0Eg0O4wM3yxo7WsBbBvDKken+83+RWO3JXLMD5a
	HBpKda/QJtvwuOyZvC2Pn11BM56O+ERivXvDZUAR/poLqFUIfDNcpbXwYRW1jIl8Brzgcg
	sUoIibJS/hhtBcbV+8EO3ZQwlujY/FdcsESQjfY0zqB2UaSIhykgEYvQ8vU8WPtzNUqkvY
	4LFxt1jniJs3eON3JJ91AtPpa0P2NlwfXxopoZ5kpdXlqb0nv6Q9iN3P/QUz8g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 12 Feb 2026 09:39:48 +0100
Subject: [yocto-autobuilder-helper][PATCH 2/2] scripts/run-docs-build:
 remove transition from built branches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-fix-switchers-js-ydocs-v1-2-ab1113759747@bootlin.com>
References: <20260212-fix-switchers-js-ydocs-v1-0-ab1113759747@bootlin.com>
In-Reply-To: <20260212-fix-switchers-js-ydocs-v1-0-ab1113759747@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=953;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=nmofInPmUQUkHgY8Oz3UQhubElyKytNnfBsmH+zv/2M=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpjZHddGayQW0qxhFQUuwZXpmw8VP41bnVufNKv
 jq/6uC0/+CJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaY2R3QAKCRDRgEFAKaOo
 NoIxEACtocqPdkz18git4NYgrz/nf5qC2q3wLGhsyO+cFOu7rfUUdwz1c12DPeBmyZc0LXXcJdy
 8b0oR1r9rZ+xl06ZZ/Rqg9S2jnoTQ0woSq+T0il07IalczR++mmbUW3T/EvV/rlGzfRjCB1rWMM
 Y9U4NC63Q6rC+32Rq4ORQkj5whqrPkKq8z7C+Bwz5sV8K7tNG9FT3uRCm59knU9jAGlVU/f2cjC
 v+zpWBbD82CU3UWSSqKXtsW9j9iLquSCpP5a9MJJQMKvDMxJSyc+QW6Ljs/dgjNdIehVWtH2WLA
 9/g19ILAGy1B4SM0e18ugvXGBaQxrJ+I9qAwk87vwgS+uwClYRLr7XuK5cyp2IzRuO+vrU2ylli
 PGjvE0PtY/ucH8wlTsAqn2cMkx4Qz5NF+hCFip53CFDUZ0xS/SUoekQYboCs5pNvOKZzHkLhvoc
 PGfgvCQQW6pJZbgt/XPmHxeacYI3vL+SO9FFv7lPdGqC24qDw2zZHvPA6JE6LFSXoOvHGlr9DL1
 NbFmlxqEynUNKdAYb9HLEiaYpKgxVhxcFJWGiefAWrcnizBIrpmXJrwwtyD0UOvVeRfbawEi/ou
 YRTI7RuD58y676NSQhr53T0AE+YDaF0BXa9fNqtulVcmBEYCPtv0hvBSB3jgjYXr6MRDvUtkY9P
 +Q6ONv9IVBSTItQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:40:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3225

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index afc05d1..07e7ccf 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -167,7 +167,7 @@ latest_tag=$(./set_versions.py getlatest)
 git reset --hard
 git clean -ffdx
 
-for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)') $(git tag --contains "$first_sphinx_commit" --contains "$first_dunfell_sphinx_commit" 'yocto-*') transition; do
+for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)') $(git tag --contains "$first_sphinx_commit" --contains "$first_dunfell_sphinx_commit" 'yocto-*'); do
     if [ "$branch" = "HEAD" ]; then
         continue
     fi

-- 
2.52.0


