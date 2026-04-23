Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20733F589DF
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 14:53:47 +0000 (UTC)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21759.1776956022783645904
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Apr 2026 07:53:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=insC8qq7;
 spf=pass (domain: 0leil.net, ip: 83.166.143.175, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g1fH86WFKzD3y;
	Thu, 23 Apr 2026 16:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1776956020;
	bh=4nHprtVn+Hoi3HwQP5SHjnWnbpYJJEeE3euvtGEAjPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=insC8qq7YlKACuOfHjfoXL2I/TmcOpyL8gzwIPK3WUEV8tMX97s2RT1wqU8MoHwut
	 9firqKV1tEt/YZC0ojtxTgDRaqLz2fkUTaqywnSUuBbVX4gjsNfdDBb9s+qA/kP9gD
	 hP2RuR0ezp6gjvqFtkJlxHBz8TImMQB4TQCFtwALvqUyD1SJOniMDjfr5jya+/3np5
	 iuKNr8jq18krfGCBUGuMYJ7oPvYviR0gEhIWdEHBWePeHv/umZXUBeVFjyWcCLHCdQ
	 dSkK0/BMYlbdRp9Cdepv9EXCI4Pe0ZO8I5zOhNI/dOUNW+UVWBNg2yfbJ4VQ83Sats
	 YNZvjpjHRWoFA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4g1fH83l2Jzkrw;
	Thu, 23 Apr 2026 16:53:40 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 23 Apr 2026 16:53:34 +0200
Subject: [PATCH meta-tensorflow 2/3] MAINTAINERS.md: fix mailing list
 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-python3-14-tflite-v1-2-68bca178a550@cherry.de>
References: <20260423-python3-14-tflite-v1-0-68bca178a550@cherry.de>
In-Reply-To: <20260423-python3-14-tflite-v1-0-68bca178a550@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 14:53:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3776

From: Quentin Schulz <quentin.schulz@cherry.de>

In commit 03414faa6a5f ("MAINTAINERS.md: fix e-mail address"), the
mailing list mail address was properly updated, but only in the
git-send-email command and not in the text above.

Also, the mailing list address was incorrect as it was @yoctoproject.org
instead of @lists.yoctoproject.org.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 MAINTAINERS.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS.md b/MAINTAINERS.md
index e049457..4a41d2c 100644
--- a/MAINTAINERS.md
+++ b/MAINTAINERS.md
@@ -14,7 +14,7 @@ Maintainers: Hongxu Jia <jiahongxujia@163.com>
 ### 1. Yocto
 ```
 Contributions and patches can be sent to the Yocto Project mailing
-list: yocto@yoctoproject.org"
+list: yocto-patches@lists.yoctoproject.org"
 
 When sending patches please take a look at the contribution guide available
 here: https://wiki.yoctoproject.org/wiki/Contribution_Guidelines

-- 
2.53.0


