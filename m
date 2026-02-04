Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC2E83EE8
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 08:08:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15405.1770192531364408803
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 00:08:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=SXcSp/ne;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6B8D84E423F9
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 42A9160745
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF5B3119A865B;
	Wed,  4 Feb 2026 09:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770192528; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c6lHXwv8j/5EWqWTI6KG1Gq7iK2WW6oxisp8oHLA2Ro=;
	b=SXcSp/ne50sKeh6vdeKGoN8y5BiLrk+tQ24RO+BooVFHwwj5esg2/kDGTyJ113TUqHhwHV
	aMWNsmJBzKd70yHo1w+sa879bLxu+6upucLNtdpAnlQEE3sWhnw2lYLXfv3jFmtyArMvFC
	dfEKEWWuirOTsxjIQwLYICWaBlz14Hzz85pEGGXIT0Bgmlvt72Mc2J6BvFQMMfy2gfi//Z
	ySlwkJIi8qPyh0REySj+Tjpl3nIkRM4L2FZB/p+ZoDONEyEQE6ZtN9Enb7brANsabZuj14
	91iQi8Y2d/vceyntJKoyiwwDjnGbptFAHjaXOvK5ADX2bEuSSA/ych0rvqDKDQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Feb 2026 09:08:27 +0100
Subject: [yocto-autobuilder-helper][PATCH v3 7/7]
 scripts/release-parser.py: use latest_tag to get branch name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-releases-parser-updates-v3-7-be208a7748b1@bootlin.com>
References: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
In-Reply-To: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=HHmrjMMM8KykJQ8R8oK3pf0PhS7H+U3D6/duM40s2QU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpgv6MRChFCNyBd4t3liho9liQ8HrVB0FxFUneR
 QbcvJKTYLmJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYL+jAAKCRDRgEFAKaOo
 Nr5DD/9F3Aaq69jfgDGEbu+0ut1AHHtRKea5Rapj5vqbFdLNPdkqbixbPwD7LE4F9x9LWK9sJ7l
 MMfhwOJve88W8Vmj5cf928E/FYEJBz7+j0P/wbZT+1UNCOReX8hwtqC2z/jnS10FAjLtuDxUdZ1
 eWhhVjw3JMtahRh/fesarVsTYwgQ59b6RARVXu1+3/DVbS/48FrSfZswkDTin7Q4eLif1zQABIS
 2fHktTbzfRtMF0i9A19ejlf19Hc3Cl8q7rCqXaQgfyp8kJOu1JwJBhsScMqfZc+yebZMz4IamLy
 HJOEjyFsZvRkEBBE4kEuUJ6JirfWL3ushLPezm1BVmMvbVZYvBzwHQKBy3t2I/56juI/fXspKEh
 TQLPVAOZBk8eVfocScZKxF6m8/cSuGmtgCLFzs8SrgI/DM4gp+4/JAgex4VHC/oFW7xz01vci/Q
 iEXrVQm7hDnlmcfZJYuGu2rqIzioupZ3QNkv5KodrWJPz6oZvt7uYZtsOA1CnR061OWZmMKhWHE
 vuwwN4tySglxdQZYVJXDcxLIrTQwq8lOTMSg5SI3WrAF9AGLALuJzsnV9UUQgdo5M9nQXW6bKob
 clTnvC9MBYYbDt9qrgjj7kIdt2+hUMK3aqbVpyfY94pvM0Eq4eKrU/s4p6fwfZkTzKgqQ5o08gt
 0evCNRv0YTPhgIQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 08:08:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3188

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


