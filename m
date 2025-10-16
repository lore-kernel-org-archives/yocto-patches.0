Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B998CCD19A
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 13:21:03 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.8278.1760620855616422796
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 06:20:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=s1Y0ocg2;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 47AF94E41102
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1D7836062C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49458102F22FC;
	Thu, 16 Oct 2025 15:20:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760620853; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=AuDdX05DgznQMmtjOKfX1jINMMU8hok66fCQgcdQIh4=;
	b=s1Y0ocg2xgdwGPbMYvOLpv7VRsGZT8akzY6l0W8STxpn/EtBgI8ZZ1QshmhJ73yeZ6W0zH
	qbizcKdey5vH0svcoZZE1dQc1yprjDu95Zxaw3gwGEHhetEh4nOMuWiOMFQhk/UfMiV3tL
	QBoRN5tAGYQcdQmhthd0oA0omULbAkftTmPAzhwaCUgx09gr3heoZ9Fj+t0dcCS/0OBQeN
	OhVRrGVkXP8fSmsj5o/sPzfgf9kw6T+KL8QsqP5D0Ie6iqV9vnMJCkDsCTTJF7gkCgrVgM
	Jjp1S1E4XPDg5jXAgBVPICU9E43dYmVCh09begdyTxN/3bL3iekxFb8mK0uOaw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder-helper master-next v4 0/2] run-config:
 Export some build properties
Date: Thu, 16 Oct 2025 15:20:49 +0200
Message-Id: <20251016-contrib-mathieu-build_props-v4-0-1f2f6700e06b@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADHx8GgC/43OwWrEIBDG8VcJnmtRY0zSU9+jlKJmthlInKAm7
 LLk3SseSkth6fE7/H8zd5YgIiT20txZhAMTUihDPzXMzzZ8AsepbKaE6sQoNPcUckTHV5tnhJ2
 7HZfpY4u0Jd5pL7z3oxmMZEXYIlzwWvU3diOfids9U00g8hmWDWKz2pTLCnDN7L1UM6ZM8VZfO
 mRt/3X9kFxwNUygpbK+1eOrI8oLhmdPa5UP9VMbH2uqaM6I3jndOxDDX6391qQQ/WOtLZpQpr1
 0yk1mUL+18zy/AM8auNSKAQAA
X-Change-ID: 20250904-contrib-mathieu-build_props-54c0ccc96861
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760620853; l=1672;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=c9YVrofuHObmtAcbX6L36orEvOASayj7iQ1mYljPYXc=;
 b=oQSFP7g3ZRLBuF4RcVJFaqjUN0TxLHCSNJ3y0E5yW9TM7aOr/EXNmG+cmb+ai4TB1iAWkK3uY
 lI0p0W0dMfjD5FtJbN/rsXeN3BYTdloVI0drLmzkVyswKfbdbZTUJ14
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:21:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2320

Allows to extract some build data from the config.json, such as MACHINE
or DISTRO. This will be used by the build configuration step in
yocto-autobuilder2.

Additionally, add a property explicitly saying this build use
bitake-setup. This is used to either show poky or bitbake/oe-core
revisions on the console view.

Also add b4 configuration file, to ease a bit the patch submission process.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v4:
- Improve comments in scripts/getproperties.py changes.
- Link to v3: https://lore.kernel.org/r/20251007-contrib-mathieu-build_props-v3-0-0263f52bd682@bootlin.com

Changes in v3:
- Use scripts/getproperties.py instead of scripts/run-config, easing the
  integration on the autobuilder.
- Add a build property to show we use bibake-setup.
- Link to v2: https://lore.kernel.org/r/20250909-contrib-mathieu-build_props-v2-0-b607bb47be08@bootlin.com

Changes in v2:
- Do not modify the list of arguments expected by run-config, allowing
  to merge this commit only on some branches.
- Link to v1: https://lore.kernel.org/r/20250904-contrib-mathieu-build_props-v1-0-28de412ac349@bootlin.com

---
Mathieu Dubois-Briand (2):
      getproperties: Also extract build properties
      getproperties: Add property to indicate we use bitbake-setup

 scripts/getproperties.py | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)
---
base-commit: 1a41841cf310adb608e88763f0ebb308c8cd897b
change-id: 20250904-contrib-mathieu-build_props-54c0ccc96861

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


