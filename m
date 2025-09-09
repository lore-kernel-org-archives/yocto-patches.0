Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EFCCA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 14:30:44 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.15007.1757428238139490596
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 07:30:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=z5pDsQUv;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4FB314E407A8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  9 Sep 2025 14:30:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1FDD460630
	for <yocto-patches@lists.yoctoproject.org>; Tue,  9 Sep 2025 14:30:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5036E102F2869;
	Tue,  9 Sep 2025 16:30:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757428235; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=eiUwlGmGP+MZ1ga13xWu/RjWvfVzNDYZKPpSgw8SKyk=;
	b=z5pDsQUvvecHpPY3KjLELkLr2Ye9Ut8CNpMGKAr8GR/TH1rV2HGlJ7hM61wecc0hDNCNMA
	VJFZZVHMBG7qIydpbvv5e9SnYEuuwLx+XRRkl0ADMAOHksMup/qjyBJNejss2DCiWgfRRq
	GpI61m5yGWIAWJovZZKhNqK0ikZi3DprTyCJNtU9kVo0LcyOr22dPK1cbRkJ0ZwqMWXzhp
	dGgplC5fAhguRtGztAcUggn6So9EBn7jSSF/um8CaRbX1/RQ/rArItHzFiIFYmpU37UQOm
	UjrgEkomwOndoLFgWdZw7x4ohOnOxQJSMPPpSq+n/QFax57ihojoB7ebvrksdg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder-helper v2 0/2] run-config: Generate a
 file with build properties
Date: Tue, 09 Sep 2025 16:29:59 +0200
Message-Id: <20250909-contrib-mathieu-build_props-v2-0-b607bb47be08@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOc5wGgC/42OUQqDQAxEryL5bsq6VdF+9R5Fisa0BtQsu6tUx
 LtXPEE/B968mQ0Ce+EA92QDz4sE0ekI9pIA9c30YZTuyGCNzU1lMiSdopcWxyb2wjO2swzdy3l
 1AfOMDBFVRVmkcBic57d8T/sTVqWo2MxRzwp77Hlw7KE+yF5CVL+eN5b05P9aXFI0aMuOs9Q2d
 MuqR6saB5mupCPU+77/AH2FXIfiAAAA
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757428233; l=1049;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Zc2CAa15mh+Bu6kSP4i8Uzh+nf3iwVy+KaOeVIvVPxc=;
 b=kY6ZKYwaKIu2vvDs+aE12hC1x3KR0Y9KdDpwVpGz7z83miVncv1nQqM3WD29kyhzMoxuMof1n
 WFiLsKOFGTPCFgT4GZIrbKvX1z0o51+qysbd7iZX4NPw1kmChHPwwCF
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 14:30:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2152

Allows to extract some build data from the config.json, such as MACHINE
or DISTRO. This will be used by the build configuration step in
yocto-autobuilder2.

Also add b4 configuration file, to ease a bit the patch submission process.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Do not modify the list of arguments expected by run-config, allowing
  to merge this commit only on some branches.
- Link to v1: https://lore.kernel.org/r/20250904-contrib-mathieu-build_props-v1-0-28de412ac349@bootlin.com

---
Mathieu Dubois-Briand (2):
      run-config: Generate a file with build properties
      b4-config: Add basic b4 configuration

 .b4-config         |  4 ++++
 scripts/run-config | 35 +++++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 8 deletions(-)
---
base-commit: fa3e15fba7fa96da520343c2ad312cefa6fc9c87
change-id: 20250904-contrib-mathieu-build_props-54c0ccc96861

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


