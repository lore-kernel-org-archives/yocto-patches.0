Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7379.1795186079098129915
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Nov 2026 06:47:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=P1SzII/u;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4555DC62220
	for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Nov 2026 14:48:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 89FF9601B9
	for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Nov 2026 14:47:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7F6611BC0273;
	Fri, 20 Nov 2026 15:47:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795186076; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=0r9+iWSRU/Azbi/AFwv/TGI4aL43EokHoqJOhm1tTvo=;
	b=P1SzII/uRJdDgHhkjEAoXJ0wQjBbsA4B2U85VtsAzCQm47U5TebpYsmbtMBkiMtz1Roof/
	Zxpc/3z/6BlwrJ7YUJSlkMRuKHIVbiRZvm17KljVMRxsL8qU/jq4jGF+VjXkemIRPns/ky
	W/Egvs5UPvm6ti+Tjl+HRLeQggdKprtxcpwqAURP6TdCDCHLFwx/42zIjjebCzxA5ZKlRk
	Z6uiT5VE3QGYp9Ec2SUUMH6cszAuD4jaYRvpKbn2InqDCyQw3SfkU5tWW6oXYitvnGa0jn
	r5vCFIyk8D8nCkhX9bHU6SYaci00llFGBOxX/DU8eiT6MLCd+N91/3t5q+uqEw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 20 Nov 2026 15:47:48 +0100
Subject: [yocto-autobuilder2][PATCH] docker/Dockerfile: add jq and
 python3-semver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-add-jq-semver-v1-1-3ec5b13229f3@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBBA0V8hs3aStmgT/RXCoo9BhyjVPgiG8
 O8UXZ7FvSskikwJbs0KkWZOHKYKeWrAPcx0J2RfDUooLaUSaLzH8YOJXjNFbIVo9fmqhR0uUJt
 3pIGX36/r/07FjuTyMem+weWApuRgCz89RdXDtu2V8/DjhQAAAA==
X-Change-ID: 20261120-add-jq-semver-300364960bf5
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=931;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=CzkPwu2Np3DrGbjssQEtdZ86ZkVkv9Ai5wumdPuYhn4=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBrAF2V4o+pVAiZpCPuKcdQzx0D/8eBhGJv0OhRR
 NKDZN5kegOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCawBdlQAKCRDRgEFAKaOo
 Nnk2D/kBOFM0iVpBGzcn+eqOjcgkIIhLPUwHZtqm3RPR7NVJjEwsTHUKrBunSLmLcQZ+m0pC70R
 k1eFL6S6j4gWoEDIodWgheQjCa9JhDlobreZEU+s1leO48gCFqn+4rjHq3DiHX3XUq97P5O+LBX
 l+FBw8vjpZpMGLhoJ4VySdinPYhjpASjcA0zZ2N51iEDFPLgtUC7oZVITVzTLwRZ9zAn3RDO7l9
 pChn0BubES0JJBuAo1SQ+41oLL6NNVMbrwB2Jyp5ogCM7V2mBxxpfB0tnVOnMeC65HKUtwwxii3
 1nJ3KjQNdvO/haAYP9+AlBST5o4i0Sum4tELCBOycUD/BWijrmPFYHB3pTwsMxhXAGj8ZFh68og
 ohRNid3MS//+OHZkFRKcnAnpj+C+Q0bE1VGygCUfwGMTamo6OZ0iupamT2oySq0dKo9I7CF0hnH
 NxW28x4zfIl3oajZocIighRyE0Mwu/V1xFDl599y6ueojR9PXaFjSVFKQx+RsPjVC2WUiqtd185
 XjRHSktGONaDU+bVrPbFLZz050y4Bt7+mFUA3hBlb/6Qc5yBuhmp2APm1wWWpR25q6eU8N/OL/Y
 3TyqbNNgvHpKJ48r3JpUY78KWQenINh/kAQ9jKe6K+yXrhEFzvM94ecvA7yKOpOUD3S/iGwORpF
 JCIIE/vATwyPEfg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Nov 2026 14:48:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5483

jq is needed by the run-docs-build script. python3-semver is needed by
the release-parser.py script. Add both to the pre-installed
worker/controller packages.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 docker/Dockerfile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index 0ddd20d..aabb5a8 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -22,6 +22,7 @@ RUN apt update && \
         iproute2 \
         iputils-ping \
         iptables \
+        jq \
         libacl1 \
         libcairo2 \
         liblz4-tool \
@@ -32,6 +33,7 @@ RUN apt update && \
         python3-jinja2 \
         python3-pexpect \
         python3-pip \
+        python3-semver \
         python3-subunit \
         rsync \
         socat \

---
base-commit: 0f6b97aa62f679948b79babfa26ed5245bd95040
change-id: 20261120-add-jq-semver-300364960bf5

