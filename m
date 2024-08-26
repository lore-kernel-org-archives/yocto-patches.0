Return-Path: <elinor.montmasson@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBE3C5321E
	for <webhook@archiver.kernel.org>; Mon, 26 Aug 2024 11:26:31 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.50799.1724671584560273302
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Aug 2024 04:26:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=edJQ4I/r;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: elinor.montmasson@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 64E619C60FF
	for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Aug 2024 07:26:23 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ycuwaLFDGRL9; Mon, 26 Aug 2024 07:26:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EBA319C5DDB;
	Mon, 26 Aug 2024 07:26:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com EBA319C5DDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1724671583; bh=El8zOSUoszvq52/aSxmHFtTh5j16XPYwSFKLfgUEVzU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=edJQ4I/rqosXKTJ+C9A4EP0wmFpm9Y10Mphob9o0BgBSh7fNSM6JyiwOpEUxEYI9Z
	 T+LjwxCBziZJR1UaRK70p6ScHJTPYRW6N3lmQi01APlRk/jSUyV8az/taBvJMq3e6+
	 Qrlm4HMynJkbq8q83LLDUYNw1uY/lJuzf5JU8un0eBT5kyUnEcMot3CSpA5YqDsu2L
	 WQe4zcw8rGN5ap9zGwno685yg85dzVOim6X/vJzCRbzOPUPb0H6qn1JGzg6RP7GDzx
	 QUzXbqKQydThLD/x6EXrMnyrkszo/7jfp5BcSjBUlnIIfqaJ5svxUlEQ6IjN/fzdoN
	 zeUfXsfiUiL8g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id DYQDlb5QRXzm; Mon, 26 Aug 2024 07:26:22 -0400 (EDT)
Received: from jean.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 623899C5D5F;
	Mon, 26 Aug 2024 07:26:22 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Subject: [meta-cgl][PATCH] pacemaker: fix build host path removal
Date: Mon, 26 Aug 2024 13:26:03 +0200
Message-Id: <20240826112603.844107-1-elinor.montmasson@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Aug 2024 11:26:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/562

Commit [1] added the removal of host tools directory paths from built
scripts. Pacemaker build these scripts with the host path of some
runtime dependencies such as getopt.

However, the sed regex did not remove the trailing '/' after
the host tool dir path. This makes crm_master, crm_standby,
crm_report and crm_failcount scripts call "/getopt" which fails.
Fix sed regex to delete trailing '/' after host tools path.
The script will then be able to call tools such as getopt from PATH.

Also fix indent error.

[1]: https://git.yoctoproject.org/meta-cgl/commit/?id=3D9c4639cd21f0ee11fde=
cb171c3173a0214a23612

Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
---
 meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb b/met=
a-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
index 49d741e..420f477 100644
--- a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
+++ b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
@@ -87,8 +87,8 @@ do_install:append() {
=20
     hostdir=3D$(grep -Rn ${HOSTTOOLS_DIR} ${D}/* | awk -F: '{print $1}' | =
uniq)
     for tmpdir in $hostdir
-   do
-        sed -i "s:${HOSTTOOLS_DIR}::g" $tmpdir
+    do
+        sed -i "s:${HOSTTOOLS_DIR}/::g" $tmpdir
     done
 }
=20
--=20
2.34.1


