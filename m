Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F282D44C53
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 14:19:04 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36644.1768486734931189069
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 06:18:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=dwD+J90O;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 832EDC1F1EC
	for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:18:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40CC5606B6
	for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:18:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B5AD10B685B3;
	Thu, 15 Jan 2026 15:18:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768486732; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vX3+qnnRpaSKrvq7kmL6b4McBhNvOZXNPBgmJPRaX8Q=;
	b=dwD+J90OZbaKRSOpfV13OmCU1YJ6GV7LIBBkf0U6Xjak0WCipw08qIPjL/zcAbaylrFeGf
	266BbKBqIYekz0nku8sIclWsdVyNgznKB1DIJE+eA2lWWL/0gRWHSrjvVmqxzrVQPQyp5j
	mp/VXe2xjTDUOfMoNewjIldx3n4WkUk8OFBTzHZluqMSE+zrMnxXugknwzCJdJO2A9tRPV
	eB2vQAyF5QeIeOtOfMPQtLOEKimgw9VvgkJSpvjTzAF0IDDKo2dNCWXvsEbLbmvObPFFx8
	a553JxnHQcjhSlJFJaP4QK6aoqRHKXa6yQf5pS0ikcdx0MWuqZxGvtaqsuJ0TA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [swat-tools][PATCH 0/2] Status bar improvements
Date: Thu, 15 Jan 2026 15:18:46 +0100
Message-Id: <20260115-status-bar-info-v1-0-1386e29bc87a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEb3aGkC/yXMSw7CMAwA0atUXmOpCeUjrlJ1EacuGKEExS4gV
 b17AyzfYmYB5SKscGkWKPwSlZwq3K6BeAvpyihjNfjWH1vnDqgWbFakUFDSlNGPRGdHYd+dItT
 qWXiSz+/YD3/rTHeO9t30+g6GlvNDB1jXDWU4Dih/AAAA
X-Change-ID: 20260115-status-bar-info-2dbb81ba347c
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=433;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=2uI3CICbyN4xglCji+ewaNIw2yhR3Qy2/ZmZJ1tTMSQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpaPdLB7s6UI6nV3ybPoeYvYuSo2Pkw18QPnjTy
 w1kk7cTQW6JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaWj3SwAKCRDRgEFAKaOo
 Nvq0D/44gYAttyKRDx2lWvelFcvC+0HG92SJ4OKiV0DVCk5BJ1LQ2ZtTnn2BX8+8tbYOksLzavZ
 zBmF4iSeGLXojiHgxrNx/669FeY8KSWMZirwOioR4REzFJYk71y/EJ6zRV2BczkSSIFiVbuIMuE
 1bs5I1xrDTkBmTiZysSS++I0d6UUBNGijKJ3Rie0bfJpsZhvEb+NK4MAJ0Dgw2KG1JE/3QUq0Hh
 nM5pSlLjymKOgRATxqEMyRXo8l/OudS2cwWkaS79rBqsovQIMArNEPsQuzlzWDUZJgNJLHExnnY
 6Mo8uVZlPTCNp7kPFo7VmFrXt9P8BtKogWWsqXlcln8ezis6T1PkUn0Da41IxWc4VirdObKtsQn
 rD8hhWaJxyTU0GLoCHtzDpygCFpEvyqWB/7ru/7jMUe82bRzbR43JfIhfKsfjlLVeUhfLkyCByP
 EFbK8b/WwRL+/Uum1Zdx4Hvgox2BAeud6RFn/usU1vDYYiwaL6uT7PC5uNCmNXAGNDtArTMFmqF
 W0Z2SXoQGhxvT0hU7Vgu28DimtNtO9pg4nSrH/vh+RWZo5KOZOFHn2vKK0XB0z0QRF2hluc/dhP
 QrJsQcv097QrDEjsCJBPVzX9UBs0ksrPF4T2IoeUkOi/dr5bJgPJ9kl6iypU4xE9iyjiWa6EBek
 VuAU1ZNfZI/5h2Q==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:19:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2962

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      swattool/review.py: show owner repartition in status bar
      swattool/review.py: status_bar: show number of triaged builds

 swattool/review.py | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)
---
base-commit: 8b38da2933736cbb589a9837e3f1940e925fb842
change-id: 20260115-status-bar-info-2dbb81ba347c


