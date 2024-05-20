Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F407EC25B77
	for <webhook@archiver.kernel.org>; Mon, 20 May 2024 20:22:29 +0000 (UTC)
Received: from 6.mo560.mail-out.ovh.net (6.mo560.mail-out.ovh.net [87.98.165.38])
 by mx.groups.io with SMTP id smtpd.web11.1831.1716233668256862315
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 May 2024 12:34:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=softfail (domain: syslinbit.com, ip: 87.98.165.38, mailfrom: louis.rannou@syslinbit.com)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.17.93])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4VjnnZ2CRKz1SZB
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 May 2024 19:34:26 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-k5qp7 (unknown [10.110.96.65])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 53E561FD63;
	Mon, 20 May 2024 19:34:24 +0000 (UTC)
Received: from syslinbit.com ([37.59.142.105])
	by ghost-submission-6684bf9d7b-k5qp7 with ESMTPSA
	id ufScBMClS2bvugEAMlNl3Q
	(envelope-from <louis.rannou@syslinbit.com>); Mon, 20 May 2024 19:34:24 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-105G0063296609b-71f4-4ca7-9ed5-39697a099079,
                    312DEBCDD6835C2DE8119E6087C00FA4E6D5ADAE) smtp.auth=louis.rannou@syslinbit.com
X-OVh-ClientIp: 45.81.62.9
From: "Louis Rannou" <louis.rannou@syslinbit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Louis Rannou <louis.rannou@non.se.com>,
	Louis Rannou <louis.rannou@syslinbit.com>
Subject: [meta-security][PATCH] dm-verity: set staging correctly in case basename has changed
Date: Mon, 20 May 2024 21:33:47 +0200
Message-ID: <20240520193347.2271954-1-louis.rannou@syslinbit.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-Ovh-Tracer-Id: 11944109163836530141
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdeitddguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepnfhouhhishcutfgrnhhnohhuuceolhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmqeenucggtffrrghtthgvrhhnpedttefhjeffveduteeutdegieeluefgtdelffduleevudeigeetudfgtdetffefgeenucffohhmrghinhepfihkshdrihhnnecukfhppeduvdejrddtrddtrddupdeghedrkedurdeivddrledpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheplhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdfovfetjfhoshhtpehmohehiedtpdhmohguvgepshhmthhpohhuth
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 May 2024 20:22:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/163

From: Louis Rannou <louis.rannou@non.se.com>

Fix the verity class when the IMAGE_BASENAME has changed. Prefer DM_VERIT=
Y_IMAGE
for staging env and wic fragment so it matchs what is used in the
dm-verity-image-initramfs and the base wks systemd-bootdisk-dmverity.wks.=
in.

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
Signed-off-by: Louis Rannou <louis.rannou@syslinbit.com>
---
 classes/dm-verity-img.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclas=
s
index 7f79548..1a34b4e 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -60,8 +60,8 @@ DEPENDS +=3D "bc-native"
 # convert it to some better format. Let's drop the first line (doesn't c=
ontain
 # any useful info) and feed the rest to a script.
 process_verity() {
-    local ENV=3D"${STAGING_VERITY_DIR}/${IMAGE_BASENAME}.$TYPE.verity.en=
v"
-    local WKS_INC=3D"${STAGING_VERITY_DIR}/${IMAGE_BASENAME}.$TYPE.wks.i=
n"
+    local ENV=3D"${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.$TYPE.verity.e=
nv"
+    local WKS_INC=3D"${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.$TYPE.wks.=
in"
     rm -f $ENV
=20
     # Each line contains a key and a value string delimited by ':'. Read=
 the
--=20
2.45.1


