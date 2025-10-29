Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE9ACCF9E9
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 14:25:38 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.7106.1761747935804668396
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Oct 2025 07:25:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=FarwCN1J;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 27FF14E413CD
	for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 14:25:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F3BD8606E8
	for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 14:25:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F7C6102F250A;
	Wed, 29 Oct 2025 15:25:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761747933; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=iZQgObXDTNw59TwDvE8xUDWrt8gT76wNSKqiop0RpVc=;
	b=FarwCN1JyUpr+TWK0ZGajvJP9WRzFRYpP74Lf4nXSf5Eeg9XFKvoRlDQpYgqNBHdzglIwp
	sB0nXykzoDSHZTax20cxaeLi3fiP4+f+5lh9JL3AS7PG38quAIwUn9PVocNZtmNgsusWlc
	4JNiSwxXDxj+OES5LxirvUjgtCaPzq5k3HuSH3sDkf7YD/m2EJwhbVvOOJCR1PLDg9OzB1
	rQvEHQtnizbqMtzaYAwLibBODbmntbjUnGI7U+FmhRBEqyTY4CLmae3AhgpTxebU+ShBBn
	TmjHso3mqEJvw8d6BQIUXI/DNIHk993+EDubtiEyvEwhco9EIGxWQiTz4fFjdw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 29 Oct 2025 15:25:03 +0100
Subject: [PATCH yocto-autobuilder-helper] config: update metrics-gitstats
 needed repos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-contrib-mathieu-metrics-gitstats-bbsetup-v1-1-db66b2ad6c2f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAL4jAmkC/x3NQQqDMBBA0avIrDsQtbbYq5QukjgxA2okMykt4
 t0bunyb/w8QykwCj+aATG8WTltFe2nAR7vNhDxVQ2e6oTXdiD5tmtnhajUyFVyp0gvOrKJWBZ0
 T0rLjjcx4vYehD66HmtszBf78V0/4Jq8JbdHkCi8TZYy07JThdZ4/NiudwZQAAAA=
X-Change-ID: 20251029-contrib-mathieu-metrics-gitstats-bbsetup-6e0947f53fb3
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761747932; l=1082;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=41Cj1aHncnP0FA8YI8Tj6WCUMQmqarC0eMpTXXkxjUY=;
 b=j8Qs1+GQ1qOnvgMWlbX5eBnODWuqg1Lex/HZ8lNJBmrvY2pK1DRe8spSFoIChaMr/KXh9EvA5
 ScNEObsHIfzBHcd7LMBZD1E0gSIVY6OsdwfjkM4hYFv2qdi7BKAX9J4
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 14:25:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2404

Bitbake repository has to be added, in order to have bitbake-setup.
Meta-openembedded repository also has to to be checked-out, as it is
referenced in buildertorepos in yocto-autobuilder2: getproperties.py
will fail if both lists are not inconsistent.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index c4d29aebc9cc..61c751a00634 100644
--- a/config.json
+++ b/config.json
@@ -1305,7 +1305,7 @@
             }
         },
         "metrics-gitstats" : {
-            "NEEDREPOS" : [],
+            "NEEDREPOS" : ["bitbake", "meta-openembedded"],
             "step1" : {
                 "shortname" : "Generate gitstats",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/run-gitstats ${BUILDDIR}/../"]

---
base-commit: 63f4e3954ff26cfd753c3c21f094b751978dda3e
change-id: 20251029-contrib-mathieu-metrics-gitstats-bbsetup-6e0947f53fb3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


