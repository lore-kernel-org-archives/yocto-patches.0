Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A99C3DA42
	for <webhook@archiver.kernel.org>; Wed, 10 Jul 2024 11:46:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.12401.1720611983008455889
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jul 2024 04:46:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9C68106F
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 04:46:47 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1F7F63F766
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 04:46:21 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper kirkstone 1/2] layer-config: Allow layer add to be disabled on a per target basis
Date: Wed, 10 Jul 2024 12:46:15 +0100
Message-Id: <20240710114616.1486962-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 11:46:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/419

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/layer-config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/layer-config b/scripts/layer-config
index bb1b681e..91d6200d 100755
--- a/scripts/layer-config
+++ b/scripts/layer-config
@@ -55,6 +55,9 @@ for repo in needrepos:
     repo_basename =3D repo.split('/')[0]
     if repo_basename in repos and "no-layer-add" in repos[repo_basename]=
 and repos[repo_basename]["no-layer-add"]:
         continue
+    nolayeradd =3D utils.getconfiglist("NOLAYERADD", ourconfig, args.tar=
get, None)
+    if repo_basename in nolayeradd:
+        continue
     try:
         bitbakecmd(args.abworkdir, "bitbake-layers add-layer %s" % (args=
.abworkdir + "/" + repo))
     except subprocess.CalledProcessError as e:
--=20
2.34.1


