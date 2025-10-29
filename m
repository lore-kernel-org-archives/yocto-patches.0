Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F57CCCF9EB
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 14:21:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web01.7108.1761747660736353379
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Oct 2025 07:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AF6C1AC1
	for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 07:20:52 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA1013F66E
	for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 07:20:59 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 1/3] dashboard/bugtriage: rename Old Milestone to Wrong Milestone
Date: Wed, 29 Oct 2025 14:20:56 +0000
Message-ID: <20251029142058.3066156-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 14:21:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2401

Rename to reduce confusion, these are not just old but actively wrong
now.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 1cca4928..a51279ab 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -128,10 +128,10 @@
       </div>
=20
       <div class=3D"section scrollspy" id=3D"oldmilestone-container">
-        <h4>Old Milestone <a class=3D"waves-effect btn-flat" onclick=3D"=
reloadTable('#oldmilestone');"><i class=3D"material-icons">refresh</i></a=
></h4>
+        <h4>Wrong Milestone <a class=3D"waves-effect btn-flat" onclick=3D=
"reloadTable('#oldmilestone');"><i class=3D"material-icons">refresh</i></=
a></h4>
         <p>
           All open bugs that are targetted for a milestone in the past: =
they
-          should be closed or moved to a future milestone.
+          should be closed if fixed, or moved to a future milestone.
         </p>
         <div id=3D"oldmilestone"></div>
       </div>
@@ -155,7 +155,7 @@
         <li><a href=3D"#abint-container">AB-INT</a></li>
         <li><a href=3D"#needinfo-container">Need Info</a></li>
         <li><a href=3D"#inactive-container">Inactive</a></li>
-        <li><a href=3D"#oldmilestone-container">Old Milestone</a></li>
+        <li><a href=3D"#oldmilestone-container">Wrong Milestone</a></li>
         <li><a href=3D"#newcomer-container">Newcomer</a></li>
       </ul>
     </div>
--=20
2.43.0


