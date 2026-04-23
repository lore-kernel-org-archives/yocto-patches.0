Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DDBFA1FD6
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 14:53:47 +0000 (UTC)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21758.1776956022268843641
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Apr 2026 07:53:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=cI8kxU0Z;
 spf=pass (domain: 0leil.net, ip: 83.166.143.169, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g1fH83VHGzFWG;
	Thu, 23 Apr 2026 16:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1776956020;
	bh=xXMbXM0DUYE378GQk/EmXptSgbwiGApdQPWYhMvwVgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cI8kxU0ZnHrzBSkYaR4vPrAN2d9iZZKMlgI1WnvdYt0/M+B5CWaSl1JfFXchUlSoc
	 BfiUbw/uoil6R4mxzb6E/+DLRu5lFectsSVcx/YXdzzczttHgt4Heu3799FBL924cb
	 cIcj2ivJ31eF+fC+OFMPe6QtKuuhQGmjoHEc9TzNGmByM6mlsBAZXD3tQeWtbRDsQ9
	 1FT4gG7jmzeKpdjPUfxb83Pjv0xorZPRKIg9GoVLLafpspveQvvTCb0D+qa435qboN
	 9FR9e91PdEAHxEDRMDbJmwGLuqtFP7C7io/iYURX0Sswf/muXramAZGVOv01JQFkW9
	 LymFylU66+TAg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4g1fH80n5mzkcV;
	Thu, 23 Apr 2026 16:53:40 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 23 Apr 2026 16:53:33 +0200
Subject: [PATCH meta-tensorflow 1/3] add basic b4 config file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-python3-14-tflite-v1-1-68bca178a550@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3777

From: Quentin Schulz <quentin.schulz@cherry.de>

b4[1] is a very nice tool for mail-based contribution. A config[2] file
exists to set up a few defaults. We can use it to set the To recipients
to always add, in our case the mailing list.

Additionally, automatically provide a default prefix so that one doesn't
need to not forget to run `b4 prep --set-prefixes meta-tensorflow` for
each series.

[1] https://pypi.org/project/b4/
[2] https://b4.docs.kernel.org/en/latest/config.html
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .b4-config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000..763e1c5
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,3 @@
+[b4]
+  send-series-to = yocto-patches@lists.yoctoproject.org
+  send-prefixes = meta-tensorflow

-- 
2.53.0


