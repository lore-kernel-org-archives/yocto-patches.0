Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2226DCD98C5
	for <webhook@archiver.kernel.org>; Sat, 13 Jun 2026 07:50:45 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.87200.1781337035792385594
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 13 Jun 2026 00:50:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=RZvHbUc5;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-20260613075031d6e19dddbd000207d7-dgpyx0@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260613075031d6e19dddbd000207d7
        for <yocto-patches@lists.yoctoproject.org>;
        Sat, 13 Jun 2026 09:50:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=8EK9F5XFtMlzEl+jckmmIjUoduocyj7Vi1+FOpaU7Oo=;
 b=RZvHbUc5Su4NGmzdjzcg2hEtTCm3gC8jNoAwdsPwV5DltnVQH0Ivvc68SDv/F1HzVxa4Mx
 XcEbxSOesyEY0OFb0Rbfnm4zypyDS1peWEjKCcG5h4AMxXH5cMWw/TsCgR2qJsQ5UTXqt+nq
 7lfT35Dh0DsiBDHIaWKp4TRss9dZYEnsI857Cx1jLpkV2V9IsQRAFux2xuaB5icrs9j6ZwhL
 5qJmreSW3ZbmV2jgSCOBxKNc39rCsZqf6lX0LFbMr6Fe9ppgcDaohAFkmQG3VXMilqBEcitt
 KETQaSPyQauGxvNL5qKG7naSMKY+pN393aYFS8+g82sH4Vuv4aqkcpBQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	Peter Marko <peter.marko@siemens.com>
Subject: [meta-lts-mixins][scarthgap/go][PATCH] gitignore: add pyc files
Date: Sat, 13 Jun 2026 09:50:09 +0200
Message-ID: <20260613075009.5406-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 13 Jun 2026 07:50:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4221

From: Peter Marko <peter.marko@siemens.com>

Adding go_mixins lib needs ignoring pyc files as if gets compiled and
creates temporary files.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 .gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..0d20b64
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1 @@
+*.pyc

