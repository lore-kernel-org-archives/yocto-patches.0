Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AE4CCA476
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:24 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.20526.1759847834079886542
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=myl5hxgv;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 69B861A11CA
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41B9C606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7FE56102F215F;
	Tue,  7 Oct 2025 16:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VrDM1G3CngBI5nYUisXQgn5LzVs3m7+Tp8aUNvb/4UY=;
	b=myl5hxgveOL2sNI7oqc10JnEuWp9iff/r8kCzg/JocIbRRe7hNMr4rxEOhwg4nZLoRQN7k
	zitU+t06WiwDQIx1u2pDAD94UrnqhpD0rDHVFhq1C93PsNnQoRxMRT3zq9CwVeiLHUcAly
	jeTgBmy9T9MvkRPL1OU4xb3dK+gmZfUwrN8IqLiosF4h/CZFCSa4NRVbahi3u1M0lXFlJo
	TxblBFCyaxNQqmfLVGcnkxHp+ywB88cDTVX4w1VekcSe0R9kplUZAQ66APGDuztrinl3k4
	ic2BdXQ+9Uc2xFe/+qA0mha3sX1syLRZ9CPe5OmvRf7UffQTQxMwwlnvQGfVnQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:02 +0200
Subject: [PATCH yocto-autobuilder-helper master-next v3 1/3] b4-config: Add
 basic b4 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-build_props-v3-1-0263f52bd682@bootlin.com>
References: <20251007-contrib-mathieu-build_props-v3-0-0263f52bd682@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-build_props-v3-0-0263f52bd682@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847830; l=666;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=LMkvM8pEFmNQ8f7rOXCTc31rmuIvoSvDqlkrbZpCuYU=;
 b=+1M4HIXNOMrBERPHzxXYP2/Z8u6r7JzW8cx/3PeOfJU7X41rIcG38/dBAVbLzlR/4zd15EVSH
 OvW3EYwAO/gDWq8RquVoi+h5bGdK47P7K5XI4tb+Pze1K2NJjv6RiGX
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2272

Allow to easily prepare mail series with b4. Most of the configuration
was shamelessly stolen from openembedded-core git.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .b4-config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000000000000000000000000000000000..8f8204a78ff1724cf42c2484345a8dc858d75c81
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,4 @@
+[b4]
+  send-series-to = yocto-patches@lists.yoctoproject.org
+  prep-pre-flight-checks = disable-needs-auto-to-cc, disable-needs-checking
+  send-prefixes = yocto-autobuilder-helper

-- 
2.47.3


