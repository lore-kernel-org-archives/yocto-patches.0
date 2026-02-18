Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB20FE9A04C
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 19:46:42 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2824.1771443994521230282
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Feb 2026 11:46:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=Hzkk6jMO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-202602181946328ca13a8924000207e3-_t_ory@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202602181946328ca13a8924000207e3
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 18 Feb 2026 20:46:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tfb6v4LcyeTEHtOvq4+gjDBOKoHR8fomZWU3HF97STM=;
 b=Hzkk6jMOg5jq0UQKjIrfv6yHrzC1FbdKWB8GeQMKQecQxw55aG0ROcVAIqw6flPMeGX3Wa
 45M5YESnQasV43RylTPEiLVeqGS5NTz9ytO437CKQMN/GrNOfrIFLbskhYZ1coW4z1Q2SnkM
 q/AE2PwLG3e18246KFkB6EGH9ddw1vZH12OdVR3HBKa3XbNT0mmKdRHA6iSVbNaZMqg6FOy7
 QEhPYXEXJz8MkEnkmIY8E+J2JNWuy73UW+coay138nUkUDfck9XjHMJoQkGWr/QCM0lBybK6
 bWcdOkOInqoJ8ZdTImIk+igrs9u7RObX8CKiYeMQw7XxKQL84vbNXrJA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 2/2] conf/layer: switch to golang 1.26
Date: Wed, 18 Feb 2026 20:46:15 +0100
Message-Id: <20260218194615.4136681-2-peter.marko@siemens.com>
In-Reply-To: <20260218194615.4136681-1-peter.marko@siemens.com>
References: <20260218194615.4136681-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Feb 2026 19:46:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3258

From: Peter Marko <peter.marko@siemens.com>

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index d4c6506..6dd3c62 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -14,4 +14,4 @@ LAYERDEPENDS_lts-go-mixin = " \
     core \
 "
 
-GOVERSION = "1.25%"
+GOVERSION = "1.26%"

