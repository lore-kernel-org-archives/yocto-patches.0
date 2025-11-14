Return-Path: <joaomarcos.costa@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D47CE7AAD
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 10:53:08 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15403.1763117581987162462
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 02:53:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=uAnAFT4U;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: joaomarcos.costa@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 20DA61A1A9C
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 10:53:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E60026060E;
	Fri, 14 Nov 2025 10:52:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D238010371C35;
	Fri, 14 Nov 2025 11:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763117579; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mn2olWxSC1n4HRSnxP1E4HgLTamJ9AzjpFVhh3aPj4Q=;
	b=uAnAFT4UdjNrx2t8ytuz4QUEBHhHXi7HavAU2kZ+u1DuXlQYQnSJ0Dmar98Ak+jn67CXg3
	sGQuX25mEggKvt5SjdZfDIP0dXzI8O6yiCvTB7BJtQap6cRYRmaI3Iai3GNT6DgG1PiukB
	mFohpVCa0Zbd0vI1JCmRTFe0tyvSdNHdjvEe5QiTt2wVZBZtdWbvSHQo/kCJQx43XZ0LoS
	ZMGz1SRj/KEI/8o/U1nXn+jSyrHYZTFEGvhiRRKxukaKgAnyoySgPCeSPm0vAo/ny5fVbc
	gmlQ/wej4vkj+/VVW6bXlT5kBtoAFVF7Kco6qNhZ3rAo2OZ4iky1Qis0n3QuRg==
From: =?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com,
	joe.macdonald@siemens.com,
	yi.zhao@windriver.com,
	=?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
Subject: [meta-selinux][scarthgap][PATCH v1 1/1] initscripts: fix incompatibility with read-only-rootfs
Date: Fri, 14 Nov 2025 11:52:42 +0100
Message-ID: <20251114105242.206611-2-joaomarcos.costa@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251114105242.206611-1-joaomarcos.costa@bootlin.com>
References: <20251114105242.206611-1-joaomarcos.costa@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 10:53:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2560

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
 recipes-core/initscripts/initscripts-1.0_selinux.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-core/initscripts/initscripts-1.0_selinux.inc b/recip=
es-core/initscripts/initscripts-1.0_selinux.inc
index 6530a87..6d912cd 100644
--- a/recipes-core/initscripts/initscripts-1.0_selinux.inc
+++ b/recipes-core/initscripts/initscripts-1.0_selinux.inc
@@ -1,6 +1,6 @@
 FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
=20
-do_install:append () {
+restore_context() {
 	cat <<-EOF >> ${D}${sysconfdir}/init.d/populate-volatile.sh
 touch /var/log/lastlog
 test ! -x /sbin/restorecon || /sbin/restorecon -iRF /var/volatile/ /var/=
lib /run \
@@ -9,3 +9,5 @@ EOF
 	sed -i '/mount -n -o remount,$rootmode/i\test ! -x /sbin/restorecon || =
/sbin/restorecon -iRF /run' \
 	    ${D}${sysconfdir}/init.d/checkroot.sh
 }
+
+do_install[postfuncs] +=3D "${@'' if 'read-only-rootfs' in d.getVar('IMA=
GE_FEATURES') else 'restore_context'}"
--=20
2.47.0


