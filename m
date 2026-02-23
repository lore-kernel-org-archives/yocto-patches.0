Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E64EA4FAD
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 11:03:35 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32897.1771844613141099995
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Feb 2026 03:03:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=SfzzQb+p;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9FD81C143C8
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8CD1B5FD43
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D02C110368F7F;
	Mon, 23 Feb 2026 12:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771844611; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PO8Yhg5U4zSpnAdoLDzoREAv1us3gFIETQQlhquL9cg=;
	b=SfzzQb+pNQA9V2X2rxf8uIWOoAAdkXWbYPBytMeSwKV1SF7Nb48w5bLTLKztU9NWUma6Oc
	FwdR52o3gfhjBZ3nyR9d60gWm0CcR2kxTYG10oaJnGefyjSELn2ugbdhykKW+wG8R9Nihy
	tGUTQhNKc2YW863sftSyAwL+iX50+ZV5ZdZq6s9r80dxugL/UgB2Ndn8KxC5zh1a1bBVRe
	gi8dQ4RCmhFEyNTmsXpf2PgV85kzbua6avuhBOma01dQWgfRHqj3WKFhS/1sTBU1tvR8dM
	jeLjLBZ9KKcweEtSsPFjbKE1JiB/9N7jSjUwT5wS7emty9n9MEJfAehje5C27g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 23 Feb 2026 12:03:23 +0100
Subject: [yocto-autobuilder-helper][PATCH 4/4] scripts/run-docs-build:
 backport the footer.html file to all releases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-fix-switchers-js-ydocs-v1-4-6f58a78ee8c3@bootlin.com>
References: <20260223-fix-switchers-js-ydocs-v1-0-6f58a78ee8c3@bootlin.com>
In-Reply-To: <20260223-fix-switchers-js-ydocs-v1-0-6f58a78ee8c3@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=877;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=OldEOsjtRB/cIqmg0lw+4hmVLQEcr8hOJe8SBOByfPA=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpnDP/QD98h/DPs1J9pcE1mqKoZdXOoI8UjNz1K
 sjvr74jNWWJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZwz/wAKCRDRgEFAKaOo
 Nu4gEADHHm6KjJFfK72e0iPy9jaCgo6nNWV3vk27OZUhHwBMhfd0WhmW60vMYOrDH0WpbNGGGSe
 xuzdGqhud9Eo0AMUzOPFzMAw004XWB6I5IHG4OwpQjxZ3nbDA3+17cBoaEkJ92GOljgL9yqmdAY
 Yk8icbARhpiT3dttLY2a4+vpaRPK8KQ6BTxwBCJli5lztLgeFon0nAAw6yKhhX9A4rgQgF/Nxr3
 Qrtd0sHvcw4DEVUbuPT5gxiYWL0phFMTcrSgaatHG4IsRnE6OLUFXa/zMT+oESjpke24nV9lZUX
 NJVPVp0SS0gMlnf1vB2XVp9veLVcXhlWCxH7Bw+5pcLQfMA4rhjfhgpxLezzxW+D/gqN+PFBcIZ
 ZS+VQxkeMDkxMPCwfEnz07owTAE5cqFL4JM1OVEhCX1YJ9srLpqr2p3sDAgiA+9nSRK0lL9QpFn
 PhZsX0Akl59mzDT+AbBvJ3Cah4xCwh9ySRCF/cU/KhHDnuKCbeyXwTQ5AGsLpFZoN6c2ivnDKJz
 lsaShoGKPVMOJdvHBTmKSsCXqMfU/fb7qYXdmiNHvh44WRoT/Ww0lgqa12yXDLC4MREiO2yj3TZ
 LVMkp7ErrjVzSgZo4dA+bpbkxaKNFV1GWPGrb/+cQr1br6B2mN1k1p86jiKw8wiz0CDwiHFBu/y
 yl+j9DGmjdf0JuA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3267

We want the footer to be consistent accross all releases that build with
Sphinx, fetch it from the master branch.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index fed5e61..b97f20c 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -199,7 +199,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
         git apply -3 "${scriptdir}/docs-build-patches/${branch}/"000*
     fi
 
-    git checkout origin/master sphinx-static/switchers.js.in set_versions.py
+    git checkout origin/master sphinx-static/switchers.js.in set_versions.py _templates/footer.html
     if [ -e poky.yaml ]; then
         cp poky.yaml poky.yaml.in
     fi

-- 
2.52.0


