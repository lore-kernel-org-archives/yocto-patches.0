Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A898AEB7EA1
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 08:40:52 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13807.1772613646048998862
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Mar 2026 00:40:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=dc8AFmMM;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 12E2F4E42534
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Mar 2026 08:40:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC39E5FF5C;
	Wed,  4 Mar 2026 08:40:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F3C2D103695DA;
	Wed,  4 Mar 2026 09:40:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772613643; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=1f3QafhKCV9/U6xS3+21jX1uvaGdGLAfAAiSchbxhx8=;
	b=dc8AFmMM3yD/wMFtrioxiI2u74NH/8quqcYgGsthGayvqAK84u2dUNIIUCgq1KsTqLyXlO
	OrIqB8LhQ/txA84jlnF6AtEbzK4CmpgAU1ZLK8rEahWumMjYUmrHGDWt2skIgpeaIDZDFS
	nmqk/4p/3kvMqNqJ9Ut+kH8xcgwGPUgyo8zS3rZodWRV1ye/t9J66/XAlhXbEytoc27TTX
	cX8vKJoNkqEYPgZYSGe7JFR/loI9sBFRd6JfiYviRQwR4cN7R7rM3WQgQRQ9wePeGk4rA7
	HqjQrNh1m3mIWYYkfgNOK6mao/SiI/1VpOqLf3rH6QtO6HEmlBnHG5kQCI1LCA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 0/2] scripts/run-docs-build:
 build using generated releases.json
Date: Wed, 04 Mar 2026 09:40:35 +0100
Message-Id: <20260304-docs-gen-releases-json-v1-0-174049cbef87@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTsJrbESr0JYlPYXSkhLOpRoC
 HcXdfkt3ttJkAOEHtVOGVuQkOIJdanIjTYO4OBPk661qbU27JMTHhA5Y4YVCE+SItdorg7N/Wa
 UojNeMp7h9Ru33d9S+glu/d7ad3JrYlvW1Jcwe2QeMS/IHR3HB2VZNCOUAAAA
X-Change-ID: 20260226-docs-gen-releases-json-0e83ce875611
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=562;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=0hPIl7ukDore72V1kkrvsjL8NlOTzleAx/sFWDrXHkU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpp/AK0vClRicMNA9FnTHUiRzLUbx1cJozKxRUB
 UitgBZ0rFOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaafwCgAKCRDRgEFAKaOo
 NhLXD/9pr3i34yRs35gvjhAKtnUoeI8RTDu9e4y9EK2L+eICkZbdARSl+rrCJi+okuadzrI4g7e
 M+Lbd3lZLRCh4Jx+PJJ+TtcfH8uTxf0Hd5xoDNgpaJPKqlkhJO87gNQIIy0EI+Feuybnm7QBdKh
 DXtqdV2kJnnPv4S0r9k1dx8H7JUJ+thRZzIc2FgAO5x0xtyd8iWA70rJ195llFynwzFSZMLG8EQ
 8LvyyMSFlS1SzYWBiGYPWs+Tmqh6ca6/gmNqIvKNcIR55a6ZcZ6F8vZPyp0xHtY9zkR5hwMUv5C
 85Gsv66E+O3ezXDZfbKav9VN/NadDgDIPZKJzFE5W63RUniuZjiPda2PELBFIfJqXFKUykpmdwD
 aRv6swXXQh77/xrvF5v1wy2Mzx5i21H7zievBw/V6pk8+qH76Nktppv3mvxnbr58UIPjm9hp8xY
 /aRm0S5eqj3QeouWLa3MW7XV+RNNP6btDEDdVyyggLCgV2dnr84h/Vcat3gFUykHrR6daxoqgXE
 tJmxV9BY8M1hLnFB5ANAtSWPPC5BQ3Um33JjFdYa9MFcdrnZQUiJjDzwzYPhumjlD22Z81kiXy5
 jMsa97w1uWV1Nq3UF7xH/TQs0gRKYzrkXgoH/BrOtmazPPY+PmiDVDIj47FvjW9AIUqcV978Oes
 B12ylU+N6gTEq/w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 08:40:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3324

WARNING: this depends on [1] being merged on yocto-docs.

I will try to do the same for the bitbake documentation build as a
follow-up.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      scripts/run-docs-build: build using generated releases.json
      scripts/run-docs-build: remove an obsolete comment

 scripts/run-docs-build | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
---
base-commit: b880494dfbe888193a9d39dc7694a29c03b4e5ec
change-id: 20260226-docs-gen-releases-json-0e83ce875611


