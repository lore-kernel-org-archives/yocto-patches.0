Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86F0EDF16D
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 14:28:23 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72854.1770992899339729956
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Feb 2026 06:28:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=rByM/qwF;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 90E631A0EC1
	for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 14:28:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67AC5606BE
	for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 14:28:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9C4610368E95;
	Fri, 13 Feb 2026 15:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770992897; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4RxVOYzxvpKQnfvJ9oZjjvLJVQx7cFkIUqmTwfI1F5s=;
	b=rByM/qwFfVNf4urMywREIGqMa+Chr4nlRGodMqBlAIlPbt+JOPsWYUawvoUo1UhzDCnFyT
	JIx7d0SJ/wgkv6sPlpvPHYXfzF4FEBACW8tBeAymBKa0yobtPG0dY+2G3rJKEtmgxKBrZI
	sb3/I5MkXHeVESB0EgHASfk4S81b7qgaeU6qEZDK64fdyOvkLamI6iSggnwrzk/avq013R
	89ZWzMtdJs4egVGD0/Owcg+ymfBfomcw9fhmAceeM0OjjeFIlOhw5LXB9stBVpTvMRPGis
	69J9qmYVna/Ey53PoqoZ0et72zU6AyMoVdQ5SyjEXDgzGh++PeUPpRMUJ6386w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 13 Feb 2026 15:28:09 +0100
Subject: [PATCH error-report-web 1/2] views: Return descriptive error on
 too big request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-mathieu-too-big-data-v1-1-2f2c28ebb28a@bootlin.com>
References: <20260213-mathieu-too-big-data-v1-0-2f2c28ebb28a@bootlin.com>
In-Reply-To: <20260213-mathieu-too-big-data-v1-0-2f2c28ebb28a@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770992895; l=1532;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=WURFg1bymxyEe4yyouJ00DX0khygkuuCTfKwBjPndiM=;
 b=8D4A4DNhStI4U2kFJNyZVgRj8SeiJHNoqWtpvCehLMGPVALmWkQAl4zGhaEOqKgU+qpVLuqdL
 U8bhS5xqZWwATP9DlOHKoRZY2GAVTv4Wn9iLJSryfywG2jICn5fspcN
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 14:28:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3236

Return descriptive error when client requests are too big in regard of
configured maximum request size. This should be easier too debug than a
generic 500 HTTP error.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 Post/views.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Post/views.py b/Post/views.py
index c294afdbee03..89a57cf50a88 100644
--- a/Post/views.py
+++ b/Post/views.py
@@ -19,7 +19,7 @@ from Post.parser import Parser
 from django.conf import settings
 from Post.createStatistics import Statistics
 from django.core.paginator import Paginator, EmptyPage
-from django.core.exceptions import FieldError, ObjectDoesNotExist
+from django.core.exceptions import FieldError, ObjectDoesNotExist, RequestDataTooBig
 from django.http import JsonResponse
 from django.db.models import Q
 import json
@@ -59,7 +59,11 @@ def addData(request, return_json=False):
             version = m.group(1)
             version_parts = [int(part) for part in version.split('.')]
         if version_parts and version_parts >= [0, 3]:
-            data = request.body
+            try:
+                data = request.body
+            except RequestDataTooBig:
+                response = HttpResponse("Request content is too big", status=413)
+                return response
         else:
             # Backward compatibility with send-error-report < 0.3
             # The json is url encoded so we need to undo this here.

-- 
2.47.3


