Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C2ECAC5B5
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 09:03:43 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web11.48873.1759135329827443773
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 01:42:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=M3eZ2anx;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: joaomarcos.costa@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2B392C0078E
	for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 08:41:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C7C7D606AE
	for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 08:42:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13C89102F1847;
	Mon, 29 Sep 2025 10:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759135327; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=tsSVKC55WUYNm/NkUkz4Mim5Ax1Q40cApMw80+dQN8Y=;
	b=M3eZ2anxw4zXJXNm7G1dd9RVZ/0zYC6KBPg5lrHSg6sA4ytZDRbZ5JVPha4x0ZdIdukGn4
	4aR9xTp7tMKReNhOqvUC1vdki7bF0Tim17MTG6VJbvUMjtrxG74Q/alEArMSJFCQJhYeAM
	/lo07+cxqqpnSzq6DlfzWFtWJDxlsI2ataGwVQppzGEWy6KivTID3RRWflLj0D4ZSBbcNi
	qfOBaj9Kr8GDCVvcyX3Yp9uRu1j9f8W/9qIo+altNB1er0eSQuDnV9x3fh0ysouySjrigo
	cgkKYZWGrQoRnZpcq1oDArIZJf/UyEW3M5InIeWmYFFsGV80KhulcpcWvGmtAA==
From: "Joao Marcos Costa" <joaomarcos.costa@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
Subject: [meta-selinux][PATCH] initscripts: fix incompatibility with read-only-rootfs
Date: Mon, 29 Sep 2025 10:42:01 +0200
Message-ID: <20250929084201.15383-1-joaomarcos.costa@bootlin.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 09:03:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2249

When the read-only-rootfs feature (in IMAGE_FEATURES) is enabled, the
populate-volatile.sh script runs at build time. This compensates for the
fact that certain essential directories and files cannot be created at
runtime, since the root filesystem is read-only. This is handled in
oe-core's rootfs-postcommands.bbclass, in read_only_rootfs_hook.

However, initscripts-1.0_selinux.inc appends some shell code to
populate-volatile.sh considering it will be run in the target, not on
the host machine. So, if one uses both read-only-rootfs and selinux (in
DISTRO_FEATURES), the recursive call to restorecon is run in the host
machine, since populate-volatile.sh is called in build time. This leads
to errors such as:

| NOTE: Executing read_only_rootfs_hook ...
| DEBUG: Executing shell function read_only_rootfs_hook
| /sbin/restorecon: Could not read /var/lib/AccountsService/users: Permis=
sion denied.
| /sbin/restorecon: Could not read /var/lib/NetworkManager: Permission de=
nied.
| /sbin/restorecon: Could not read /var/lib/bluetooth: Permission denied.
| /sbin/restorecon: Could not read /var/lib/chrony: Permission denied.

As a matter of fact, this scenario is a fair reminder not to call
bitbake with sudo.

This change makes sure the append is only performed if the
read-only-rootfs feature is not used.

Signed-off-by: Jo=C3=A3o Marcos Costa <joaomarcos.costa@bootlin.com>
---
 recipes-core/initscripts/initscripts-1.0_selinux.inc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/recipes-core/initscripts/initscripts-1.0_selinux.inc b/recip=
es-core/initscripts/initscripts-1.0_selinux.inc
index 6530a87..b459d48 100644
--- a/recipes-core/initscripts/initscripts-1.0_selinux.inc
+++ b/recipes-core/initscripts/initscripts-1.0_selinux.inc
@@ -1,6 +1,6 @@
 FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
=20
-do_install:append () {
+do_restore_context() {
 	cat <<-EOF >> ${D}${sysconfdir}/init.d/populate-volatile.sh
 touch /var/log/lastlog
 test ! -x /sbin/restorecon || /sbin/restorecon -iRF /var/volatile/ /var/=
lib /run \
@@ -9,3 +9,8 @@ EOF
 	sed -i '/mount -n -o remount,$rootmode/i\test ! -x /sbin/restorecon || =
/sbin/restorecon -iRF /run' \
 	    ${D}${sysconfdir}/init.d/checkroot.sh
 }
+
+python __anonymous() {
+    if 'read-only-rootfs' not in d.getVar('IMAGE_FEATURES'):
+        d.appendVar('do_install', ' do_restore_context;')
+}
--=20
2.47.0


