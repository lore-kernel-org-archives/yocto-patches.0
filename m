Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C25C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 13:42:51 +0000 (UTC)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
 by mx.groups.io with SMTP id smtpd.web10.16046.1716558167965653153
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 May 2024 06:42:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 84.16.66.175, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vm5ny0Zssz3k9;
	Fri, 24 May 2024 15:42:46 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Vm5nx4hWDzKlM;
	Fri, 24 May 2024 15:42:45 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 24 May 2024 15:42:32 +0200
Subject: [PATCH meta-rockchip] add basic b4 config file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-b4-support-v1-1-2e6e5d84781c@cherry.de>
X-B4-Tracking: v=1; b=H4sIAEeZUGYC/x3MQQ5AMBBA0avIrE0yqixcRSyowURoM0Uk4u4ay
 7f4/4HIKhyhyR5QviSK3xOKPAO39PvMKGMyGDKWKmNxsBjPELweONY1ceXIlGQhBUF5kvuftbD
 x0aN6t7pFAnTv+wFuPziPawAAAA==
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 May 2024 13:42:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/188

From: Quentin Schulz <quentin.schulz@cherry.de>

b4[1] is a very nice tool for mail-based contribution. A config[2] file
exists to set up a few defaults. We can use it to set the To recipients
to always add, in our case the mailing list.

This shouldn't be necessary if we had a script that b4 prep --auto-to-cc
could call to find the mail address(es) to send to. While we could do
that, this opens the door to people trying to add a way to notify some
people (e.g. a MAINTAINERS file) which is not somewhere the project
wants to go right now, and this also makes sure the address is always
added even if one forgets to run b4 prep --auto-to-cc (which is part of
the typical workflow for U-Boot and Linux kernel, but is not necessary
thanks to this patch).

Additionally, automatically provide a default prefix so that one doesn't
need to not forget to run `b4 prep --set-prefixes meta-rockchip` for
each series.

[1] https://pypi.org/project/b4/
[2] https://b4.docs.kernel.org/en/latest/config.html

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .b4-config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000..9410efd
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,3 @@
+[b4]
+  send-series-to = yocto-patches@lists.yoctoproject.org
+  send-prefixes = meta-rockchip

---
base-commit: 1f8a8d917b9715acf97fae23bb9bff8bc80b723b
change-id: 20240524-b4-support-d660e5c02304

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


