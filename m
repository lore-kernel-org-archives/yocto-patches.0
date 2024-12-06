Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C9E7717B
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 16:43:02 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.42017.1733503374792211148
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Dec 2024 08:42:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=AltXcgpj;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2481240002;
	Fri,  6 Dec 2024 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733503373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LUy8EB2hOhBYtgUKaaSwN9JOM39nUmoEzLdSfKpmvGI=;
	b=AltXcgpj+UiTFoA+hiFgYMOSxfx0xBU4noDZpO+hSHK3Jl4BlhbsMkJOkhEgDhOH/Qkb+H
	Ry8HUD/hArVe1+scsZftEwP12Z7D6rqSNSvz81bqv1b/nJeHwJNXksBYDm8jIxqCNf3557
	TJPXxzFhq10Irx0HM+L9V1PKkOn2vlVxO+YCShy7DsoRMY8lWLuqYHgYzbNDFn3C6kM07G
	WssvsC9ORSMhDXc+POnVLT3Zs4DHtO/jj9GqFFfgvi6zXstuShtgyxaNaA2iHTqhoep2xa
	11G5W13kY60F5avFPaEAxNbpeOy8NNd0/NFfDGD16YTqiKViCT58nMtpdYpMCA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 06 Dec 2024 17:42:30 +0100
Subject: [PATCH] qemurunner: Fix stack trace generation in exception
 handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-mathieu-qemurunner_exception-v1-1-351a8ea80621@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAHUpU2cC/x3MQQqDMBBG4avIrBswIabYq5QiIf7WWZjaiREhe
 HeDy2/xXqEEYSR6NYUEOyf+xQr9aCjMPn6heKwm0xqrTevU4reZkdUfS5YcI2TAEbBuNVTovQ6
 2t50bn1QXq2Di496/P+d5AVtUSlRuAAAA
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Dec 2024 16:43:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/864

Qemurunner exception handling code currently formats the stack trace
using traceback.format_exception(), with parameters introduced in python
3.10. This will fail on platforms with an older python version.

Change this to the old parameter order, still supported in current
python versions.

https://docs.python.org/3/library/traceback.html#traceback.format_exception

Fixes [YOCTO #15675]

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 meta/lib/oeqa/utils/qemurunner.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meta/lib/oeqa/utils/qemurunner.py b/meta/lib/oeqa/utils/qemurunner.py
index 98a11e1a2c3c..6cab9aa6b202 100644
--- a/meta/lib/oeqa/utils/qemurunner.py
+++ b/meta/lib/oeqa/utils/qemurunner.py
@@ -746,8 +746,10 @@ class LoggingThread(threading.Thread):
     def threadtarget(self):
         try:
             self.eventloop()
-        except Exception as e:
-            self.logger.warning("Exception %s in logging thread" % traceback.format_exception(e))
+        except Exception:
+            exc_type, exc_value, exc_traceback = sys.exc_info()
+            self.logger.warning("Exception %s in logging thread" %
+                                traceback.format_exception(exc_type, exc_value, exc_traceback))
         finally:
             self.teardown()
 

---
base-commit: 942b6ab25f0c1df02920997b63db89187fbdeea1
change-id: 20241206-mathieu-qemurunner_exception-e9a1c49456d7

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


