Return-Path: <louis.rannou@semalibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13165CDE03E
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 08:30:08 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13398.1763109004418537129
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 00:30:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: no key for signature: lookup dkim._domainkey.semalibre.com on 100.100.100.100:53: no such host" header.i=@semalibre.com header.s=dkim header.b=S82Ad2+/;
 spf=pass (domain: semalibre.com, ip: 185.171.202.116, mailfrom: louis.rannou@semalibre.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D5D30C10F60;
	Fri, 14 Nov 2025 08:29:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A06306060E;
	Fri, 14 Nov 2025 08:30:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85952102F2A6F;
	Fri, 14 Nov 2025 09:29:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=semalibre.com;
	s=dkim; t=1763109001;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=0JKGj/Qje8B2mVlfGrv3Ren1Gb/UdAdDq/mf3y3goAw=;
	b=S82Ad2+/NbrIqNCpDHGlGEjsJtXYtA/EtGmuDqzgEajChgIumHIGok5wrelsxKKtbcPQc6
	gFTwI4WVckkHpxo6fzW5J5xjlwybwo58n5rTiZ7my6dtA1yPUjaFLh74KmypwI+7PNnrw3
	v2z8N+EN7BF+8/8miRRWQRMTiKpKQYYicZcsTCdioqMjjboFQPiTmkINLZlr5RC/yk0a01
	F1k34eQdkHl+3AOrAj+pVT5BJ29oVP1s3gbfjBL9O4IfKNZkUTsgEmw9pct3FvgXToG4kL
	fvFXRFXG3OjBlSeB3T/vJfUkKF5mcx+f4//G5y7/O4/AE5bHOWpJe0iWR9k6yQ==
From: Louis Rannou <louis.rannou@semalibre.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com,
	rybczynska@gmail.com,
	pascal.eberhard@non.se.com,
	yi.zhao@windriver.com,
	Louis Rannou <louis.rannou@non.se.com>
Subject: [meta-security][PATCH 0/4] openscap: upgrade 1.4.1 to 1.4.2 with fixes
Date: Fri, 14 Nov 2025 09:29:46 +0100
Message-ID: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251113-openscap_bump-5c33d1ab2ceb
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 08:30:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2553

From: Louis Rannou <louis.rannou@non.se.com>

This series of patches makes an upgrade of openscap and scap-security wit=
h a repends fix
and other minor corrections.

I have based the source on the well formatted github release instead of t=
he commit
sha. So let me know if that's incorrect.

It also includes a runtime test and musl fix.

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
---
Louis Rannou (4):
      openscap: update to 1.4.2
      scap-security-guide: update to 0.1.78
      oeqa: openscap test
      openscap: fix musl compatibility

 lib/oeqa/runtime/cases/openscap.py                 | 48 ++++++++++++++++=
++++++
 .../{openscap_1.4.1.bb =3D> openscap_1.4.2.bb}       | 16 +++++---
 ...ide_0.1.77.bb =3D> scap-security-guide_0.1.78.bb} |  4 +-
 3 files changed, 59 insertions(+), 9 deletions(-)
---
base-commit: 9f1d763bb17bf105cc313a95eb3b07496b34bacc
change-id: 20251113-openscap_bump-5c33d1ab2ceb

Best regards,
-- =20
Louis Rannou <louis.rannou@non.se.com>

