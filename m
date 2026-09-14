Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF46C88E6F
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:24:03 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5837.1789413841424166449
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 12:24:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=P4nGXObG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-202609141923596588ae8f3600020758-pzp1tv@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202609141923596588ae8f3600020758
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 14 Sep 2026 21:23:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HUfBAPHyQM4AFYKKt9s7ca/Lo5QzSYmfg9pQzVlHPiw=;
 b=P4nGXObGWLgmNCikhnePRrPD5H6G0Qka+G4lMH0PzGaNXhuRCuqHz+cucJm+0bq81VGA5y
 N+paWhJas8oExKadaBQU94ZPR0cv7vxdl0ZM66up764fu3F2A05qa6IqJliI0uDq6QAVxaBm
 Gwo0EQmuvukE7TGmNUk3URsVhEor9i+IhYl7cSqpaV04As+NVktHhhNkhqsCDkT7IkAKMnqp
 LsAK5a3Qe2AkfvUIVcEHpUhl/dhYrAneFHOJfsYSFAZaDrcE8nv3P4iAlaYmpZM5DjLLVhMw
 JjTuvx6MgI8yDHV+rXxYmNds1IgjQkPw3n5PYQyCZ+moPk5Y556zYQOw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 2/4] conf/layer: switch to golang 1.27
Date: Mon, 14 Sep 2026 21:23:13 +0200
Message-ID: <20260914192315.1067308-2-peter.marko@siemens.com>
In-Reply-To: <20260914192315.1067308-1-peter.marko@siemens.com>
References: <20260914192315.1067308-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 19:24:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4840

From: Peter Marko <peter.marko@siemens.com>

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index f621052..55ddc6b 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -14,6 +14,6 @@ LAYERDEPENDS_lts-go-mixin = " \
     core \
 "
 
-GOVERSION = "1.26%"
+GOVERSION = "1.27%"
 
 PTESTS_SLOW:append = " go"

