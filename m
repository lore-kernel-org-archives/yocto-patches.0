Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549F9C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.9939.1742482562305306724
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Mar 2025 07:56:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79BF3106F
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 07:56:09 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 522F53F673
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 07:56:01 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 1/2] scripts/list-ab-workers.py: make executable
Date: Thu, 20 Mar 2025 14:55:56 +0000
Message-ID: <20250320145557.1939762-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 14:56:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1232

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/list-ab-workers.py | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 =3D> 100755 scripts/list-ab-workers.py

diff --git a/scripts/list-ab-workers.py b/scripts/list-ab-workers.py
old mode 100644
new mode 100755
--=20
2.43.0


