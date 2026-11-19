Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14146.1795094388417627368
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Nov 2026 05:19:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=YNxPPVNS;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 08AF04E41665;
	Thu, 19 Nov 2026 13:19:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BE25460237;
	Thu, 19 Nov 2026 13:19:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4583311BC0B0C;
	Thu, 19 Nov 2026 14:19:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795094385; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=cE0Nvl/jaJQrnLT+S15J04pKtRLBrNtLgkHMgR6c4jc=;
	b=YNxPPVNSS9NedGY3MCPyD20aSURqOziItF5GhZMA/PXmeoLxlz75xhsAIJAJN8ZlfCRfBl
	aLNiuYk5Kxd5C54DVJ9L/Sy92Rcq7KwtwV72s2neF9wqjmIBD60l/Gr64xxS6+0iVD56t8
	HyDFdTjmd1P235UBhyMpeM1AfNphcOlaEs0tSGGj/88wLZ+lvTt2RO7MKVyvuAkxyDKmuV
	GEMKTJzUc43MuZs894bGrdxpK/Ct8u5vVI2bRERRrxUyx4BPWNRdnLnrYB8TpOdS3WhmKd
	At2p/HU9d+8BC6eCotRsn3glDR3PGuy8P050QTZ4liAUdecCetOyZvicvB9k4w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 0/3] Fix buildbot configuration for v4.4
Date: Thu, 19 Nov 2026 14:19:32 +0100
Message-Id: <20261119-mathieu-buildbot-4-4-b4-v1-0-76774afaee1d@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGT3/moC/x2MzQqDMBAGX0X23IVmDUL7KqWHJH7WhdaU/EiL+
 O4GmdMcZjbKSIpM926jhFWzxqWJuXQUZre8wDo2J7nKYIy58ceVWVHZV32PPha2DW9ZEGRw/YQ
 AS63+Jkz6O88P+sdQIrta4pkhCT33/QAVcBegfQAAAA==
X-Change-ID: 20261119-mathieu-buildbot-4-4-b4-2ec26a3fece4
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michael Halstead <mhalstead@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795094383; l=903;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=bTSUdygiJ8VJC5UOzM+D7GPQ7wChQ4RUgvkwhz5ZIIw=;
 b=ozRGIWJITqLFL5Kvx1eUTDqz6uld8f/z6Evgt3TkHeF3/nDSWazIyNO985LmcEMRDeQ/IRDXd
 +wewRLFp3jNA7VTX9LtZXOEuh/lzxXrHH1JGxXRWYAAlbMCen8SgD7k
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Nov 2026 13:19:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5479

Buildbot v4.4.0rc1 is out. A few small fixes are needed in our
configuration before we can use it.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (3):
      yocto_console_view: switch to pyproject.toml
      docker: Fix for buildbot 4.4
      yocto_console_view: Fix CSS for buildbot 4.4

 docker/Dockerfile                                  | 29 ++++++-------
 yocto_console_view/pyproject.toml                  | 34 +++++++++++++++
 yocto_console_view/setup.py                        | 49 ----------------------
 .../src/views/ConsoleView/ConsoleView.scss         | 29 +++++++++----
 4 files changed, 70 insertions(+), 71 deletions(-)
---
base-commit: 0f6b97aa62f679948b79babfa26ed5245bd95040
change-id: 20261119-mathieu-buildbot-4-4-b4-2ec26a3fece4

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

