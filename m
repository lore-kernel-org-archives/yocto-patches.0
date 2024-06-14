Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3582EC27C6E
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 22:03:06 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.1569.1718402576711148781
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Jun 2024 15:02:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=J4kpQEJX;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BCEC7FF804;
	Fri, 14 Jun 2024 22:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718402574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SM5nKWWjC1moUuAHGAEBYkyzqteXQwNVG3+VrrElMRI=;
	b=J4kpQEJXw0DTZHBdUX4JVsDYsjIj9k67AA8MmGDLF7fDN3fSqaia3z0rTPcQQu+E8CGKEa
	JnhRT6Szonx84/3hwwU5iVfdAK9L5nL9nguXxJ519LrOMJjDtxiAVMna3LF13d3/ZmivEX
	ZoC98VOkZrxkuQzaeinlbGurGBQbJvTsaFFZtUWTJKc7kqOxmijzeGVdSx6dNnbvuPtDcb
	9bI4l55CtGmmVXRMNJ1nUgXQriWXjlEv/BqE3UF3eYXyWMeOcaoWykZgaTAmqM7e7IRecj
	3lBNpJuPpsCpk1O9e/FfX9JQOr+WZxqBZL6F1fhnFHWx7P6MlwNGoMi9xfkL1w==
From: alexandre.belloni@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [yocto-autobuilder2][PATCH] schedulers: switch meta-agl branches
Date: Sat, 15 Jun 2024 00:02:50 +0200
Message-ID: <20240614220250.997853-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Jun 2024 22:03:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/332

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 schedulers.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index efd049f547e8..e46428f91f78 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -68,7 +68,7 @@ branchdefaults = {
         'branch_poky': 'scarthgap',
         'branch_bitbake': '2.8',
         'branch_meta-arm': 'scarthgap',
-        'branch_meta-agl': 'next',
+        'branch_meta-agl': 'master',
         'branch_meta-aws': 'scarthgap',
         'branch_meta-gplv2': 'master',
         'branch_meta-intel': 'scarthgap',
@@ -129,7 +129,7 @@ branchdefaults = {
         'branch_poky': 'kirkstone',
         'branch_bitbake': '2.0',
         'branch_meta-arm': 'kirkstone',
-        'branch_meta-agl': 'master',
+        'branch_meta-agl': 'quillback',
         'branch_meta-aws': 'kirkstone',
         'branch_meta-gplv2': 'kirkstone',
         'branch_meta-intel': 'kirkstone',
-- 
2.45.1


