Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCF1CCD185
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.20400.1759847846021726345
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=AKDLOETr;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B6F9D1A1167
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FC5B606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5EDE102F2166;
	Tue,  7 Oct 2025 16:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847844; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7BoPqoyea16+BP6K3is30rOD1ciSF2uXtzm3xC7FQ/g=;
	b=AKDLOETrFoNUjyViBLeTqnHStOpIRoGaUnFmlEyVQ9WyYvedrOtKCLXCF+0ocqI8UjtHOs
	Jug9wIxFKsK/iPeOb5veXA1YQmK7hdHjNt8CN39H/bbhPK7FQxB4MOqCL8Oky5qLScVcdB
	8VcoDLIJcoY3rBduIpjOoAfE0YBPyQ/SV5sHiBb+59oEpuE0qCfqmGDtWbbZ2PPeLGSWmd
	2DpubB0mIsmZUjOO7FNsvQf1OM8JQ9u36hs/vLAxtSUOFzFZkptD6jw238CUKDiM8wKz7X
	F7/PXImfmSM5h20JKiHw93PgsCX6Eewq5GDZMsDGvq1RSvDEXdgcQaItKm2PVQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:19 +0200
Subject: [PATCH yocto-autobuilder2 03/10] docker: Fix missing directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-bb-setup-links-v1-3-bb1d79289c3f@bootlin.com>
References: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847841; l=846;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=XYmdOYvI1zcJHTmYbQPjtxSaGfeU/l14d16SjTvUAiw=;
 b=yshFTTCVw5rJDk2cbj6mGrA3ndabTey3OaSoPGnpBfbnFYOYqoFImcG1dM0E866wLRj+RemIo
 HVQ6V8r2vTQAY6WcbKNy2vfbvEKucAmPHPsIx2nYUNbQuyyXo2hFMgM
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2279

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index 5de05c40853ad5aad478cd8521384249477f153e..b1df8602252080c6bceeb5da24db209a6a70a407 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -89,7 +89,7 @@ RUN useradd -m --system pokybuild && \
     git clone https://git.yoctoproject.org/git/yocto-autobuilder-helper && \
     pip install --break-system-packages \
         yocto-controller/yoctoabb/yocto_console_view/ && \
-    mkdir -p /home/pokybuild/git/ && \
+    mkdir -p /home/pokybuild/git/trash && \
     mkdir -p /home/pokybuild/tmp/ && \
     echo "[user]\nname=pokybuild\nemail=pokybuild@none\n" > \
         /home/pokybuild/.gitconfig && \

-- 
2.47.3


