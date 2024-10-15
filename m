Return-Path: <ben.cownley@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A3BD216BA
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 14:38:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.15255.1729003116115652420
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Oct 2024 07:38:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ben.cownley@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D267FEC;
	Tue, 15 Oct 2024 07:39:05 -0700 (PDT)
Received: from e125927.manchester.arm.com (e125927.arm.com [10.32.102.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB6C73F71E;
	Tue, 15 Oct 2024 07:38:34 -0700 (PDT)
From: Ben <Ben.Cownley@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ben Cownley <ben.cownley@arm.com>
Subject: [PATCH scarthgap 3/3] kas: Include unattended openSUSE test
Date: Tue, 15 Oct 2024 15:38:17 +0100
Message-Id: <20241015143817.64520-3-Ben.Cownley@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015143817.64520-1-Ben.Cownley@arm.com>
References: <20241015143817.64520-1-Ben.Cownley@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Oct 2024 14:38:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/710

Add unattended installation class to openSUSE target

Signed-off-by: Ben Cownley <ben.cownley@arm.com>
---
 kas/arm-systemready-linux-distros-opensuse.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kas/arm-systemready-linux-distros-opensuse.yml b/kas/arm-sys=
temready-linux-distros-opensuse.yml
index cffbdb92..d2d75fa2 100644
--- a/kas/arm-systemready-linux-distros-opensuse.yml
+++ b/kas/arm-systemready-linux-distros-opensuse.yml
@@ -2,6 +2,7 @@ header:
   version: 13
   includes:
     - kas/arm-systemready-firmware.yml
+    - kas/arm-systemready-linux-distros-unattended-installation.yml
=20
 target:
   - arm-systemready-linux-distros-opensuse
--=20
2.34.1


