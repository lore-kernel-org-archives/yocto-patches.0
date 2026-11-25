Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45647.1795624094402577726
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 08:28:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=oh8jdvk+;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0C6301A17F5
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 16:28:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D4B2360480
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 16:28:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34DD611E6AD5F;
	Wed, 25 Nov 2026 17:28:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795624087; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=OE44Dp9NimdmNt185N8jz8GjUwq+dT4a9idZUu3nvGs=;
	b=oh8jdvk++H7pbzuzxFy+NanM+E1eHbWyfKED9XTQbAESw9wwtp3v83oc4+tFmBNfTjgATM
	ivlMk4zuq2gFdoH/3b3SPdG8HykkqnrRwWMrpAw/w1166BE1VTbYCSdli7GMGvn6+DF9Ge
	IsePxL9d/SZs4E+rUVPnHGX+KV/ghgzBNj2jZCzG6PejBFn5pI7EuwxRnZEOjP2fFd9sup
	hcCqtac4YrmeQSnT1FZTgEX8r+i/MnC73ubw31jZc+n0pPnzI3ckGVjkSVHoa0rJUFHlw5
	WdgRvBqKMCqZTdEueCznSiBJ/nYMOANvYYzq1x21Yjc65U+eRwUfOSzjCvnAng==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 25 Nov 2026 17:27:50 +0100
Subject: [psplash][PATCH] .b4-config: add file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-add-b4-config-v1-1-369bba9f4af0@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDtgQtJCryIuJsmoU0oMmbYUx
 Ls32uVb/L+BchVWuHcbVP6IypobzKWDuFCeGSU1g+3t1RjrkVLC4DCueZIZg/dkb96RMz20plS
 e5Hv+hvFvfYcHx9cxGYqWJ+kywr7/AGCjfMN6AAAA
X-Change-ID: 20261125-add-b4-config-b55a2754a410
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=712;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=M7rDKgu28Cj6j42Stj4qzsx4taDpmiHplxNkcSqLg0I=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBrBwyLJTjy85D/rxuEbflzh++E+LMCdyb2yFw9M
 pltK9gTXk+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCawcMiwAKCRDRgEFAKaOo
 NoTOD/9e0CW7Of7MRreDUZQGlGsZGR2khBHpXviv7dkKXTeNZeQyHKeyd2kriFrE5N1CIbSVAqi
 DcSHeHN0R6Z/4IaWB9oqIfUBGX5qndW40/Q82ZATIzJt1wqsdLDqw8bZijEE68zTbCumvDAj04x
 yKt/nM8XjlnDW3LrArhm/OJvr7OxPav2DQvrV5pesfd0P/dlNks/MKl/TD0zVKtZbotavGnouRE
 Ob6ealqrCcrR8EplX8CdoDh66h2lNqOsxGUV17dKk64XbpDqwvBaWGVt8yJxcwHet/0/poR21sF
 Wf2O5KyBBgMfMaV/DRUoWil/MooGj4Dzynn5Llv5AWFS5OJVRoMSLaICLB/0LTzigHaRMLq2zK+
 ycJ5TdakLPccJOIf9Gf4wHIfCCZ/i8ZEPpfu0CXAJPWQhi2XtViGZX5LbgC6a6IVHy5oOA7uloK
 ZHtbr/4S6exJz4yCUZG7T6nHwYIhVcKPdQ/vaY3Mk0WGhcCDww8rIgrca3WNMxicx9vdx3t7YzC
 v/E7W5hAsBEZ31DzQklWRcy0PUAtCnLyMEnrzk675B6hXwpv56KeRbPzhs34jYi0KoJhby5D33Z
 1eeRqjs9Nq2WSx3PXTvjxlMutOzDLeyY7QsumB77Y3KMrClCqV33kxTrKPdEoZsyAG+TBzBSHTa
 z9FylCkh7YIj/wA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 16:28:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5516

The .b4-config allows configuring b4 properly when sending patches to
mailing. Inspired by the one on openembedded-core, add the file to the
root of the repository.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .b4-config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000..66bedda
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,4 @@
+[b4]
+  send-series-to = yocto-patches@lists.yoctoproject.org
+  prep-pre-flight-checks = disable-needs-auto-to-cc, disable-needs-checking
+  send-presubject = [psplash]

---
base-commit: 53ae74a36bf17675228552abb927d2f981940a6a
change-id: 20261125-add-b4-config-b55a2754a410

