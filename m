Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCD9CCFA1A
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 08:54:12 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44210.1762764848127612507
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 00:54:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=ThLAAInD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-256628-20251110085404b256c6341a00020748-kqqfnl@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20251110085404b256c6341a00020748
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 10 Nov 2025 09:54:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=MkIbmHZyI3NmPtRAK24XLj0q+B5MZwFjGRU2MU4H9hY=;
 b=ThLAAInD9fzwU7Qcob5DZW9mNeP3qEJZLaWrINyohkJt2KRyZNYv4NlO+F+ZAMIyI7VC4B
 B0ZHMVNQ3tmBlVeWKbzSnr25al6cUfXQVfoVL+WgpN4aIvWCsDEQNzJePL1/XQvJfm+cFiGs
 r7xkWjTb+JHjLsfUR70XnK2kWfhkvkkjpwiX24VRc1F1b/sJv3dDvRS9R0a5P/AqIb1ssBIn
 tEE3VEjTtxH+ZAlQsRGifu/HxKEimZVzMqqPo7G70zh4Kb5XS1gOvjwrsoA3ENn7e+51Czh+
 3uF+KfY+UmptdK5XCLJMPStGEInC6MWRlJWtcejDt49fWSKPdtANzA+w==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>,
	Jose Quaresma <jose.quaresma@foundries.io>
Subject: [meta-lts-mixins][kirkstone/go][PATCH] README: add myself as maintainer
Date: Mon, 10 Nov 2025 09:53:56 +0100
Message-Id: <20251110085356.11336-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 08:54:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2469

From: Peter Marko <peter.marko@siemens.com>

I'm already very active contributor backporting all go recipe updates
and it makes sense to have at least two maintainers to be able to handle
contributions in timely manner.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Cc: Jose Quaresma <jose.quaresma@foundries.io>
---
 README | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README b/README
index d0b6bc4..6752254 100644
--- a/README
+++ b/README
@@ -12,3 +12,4 @@ The patches can be backport from openembedded-core with:
 
 Maintainers:
 Jose Quaresma <jose.quaresma@foundries.io>
+Peter Marko <peter.marko@siemens.com>

