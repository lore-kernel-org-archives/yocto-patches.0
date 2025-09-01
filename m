Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E33CA0FFD
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 07:42:58 +0000 (UTC)
Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
 by mx.groups.io with SMTP id smtpd.web11.45752.1756712568897670765
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Sep 2025 00:42:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@rootcommit.com header.s=hostingermail-a header.b=RogPIcCk;
 spf=pass (domain: rootcommit.com, ip: 23.83.218.252, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremailsmtpin|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 401631C3AC2
	for <yocto-patches@lists.yoctoproject.org>; Mon,  1 Sep 2025 07:42:48 +0000 (UTC)
Received: from fr-int-smtpout29.hostinger.io (100-102-100-57.trex-nlb.outbound.svc.cluster.local [100.102.100.57])
	(Authenticated sender: hostingeremailsmtpin)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9443D1C3AC6
	for <yocto-patches@lists.yoctoproject.org>; Mon,  1 Sep 2025 07:42:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1756712567; a=rsa-sha256;
	cv=none;
	b=O6eo7pVfeZLsYON9wlpj9AgVtvTP+c2GP62BZgmdogWf1FSujZ+8MHjnKcoUFD3Qkbd6ms
	+GKFto9GUomAusFNU1TVFNSlAyYoKoKHVCVr6G4ZRyjxAH00Yh27wVwUzJGAJUdWCv9nlp
	hJ4wdc5Ilo21uCzAfi4Dr/wK8lCGlOgOO9IIHHfMXkbcuX6kOYH7qC1JWuSfUywNb5mUQJ
	lEBuKrOGYfZ3y/RNOf6kloqAQIcCvov4k/Auu8epmnJDW+jP9k4DUTQmyZSPiF+HG3EiV4
	MjgFwEXKnwKhQvTgiQYyBEBoWF7+v9yq5wvowyRNd12tgFyeLXuthsFCpg01UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1756712567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Uf8lR8iqOG2HiTIMNASE8NmAa7I+P5C3g55YY2jtJYA=;
	b=NuiP+AP+9iiOPPrS7GMKAvqwRGPgLspqAssHWvmtWdnp+IODRqozRJnDzOtnhxknsMITWo
	lc09KuHrUWcFwyGySpTCCwZ0orezkhuAmaXJiEWNMIeQy185aqxlM8EVvQe6MCjU1zakJ7
	+2EyK6FFoKN3Gu8ADkZZM6umBs3gurtJuROrVHB2B9vQcKN4yvZGUROwkd8hdtpjSv5O3/
	J0W6tj3dFTKHhNE8UI2BbkeOwlm5bGfHCd3JHFB9NP0zaNjCXCZ2mi0lih7qJBJbIuRb+0
	wo0OTAF/mX9IjrTPC7eCRsWRjqEmAQgoYrCoGeo6V0qsUWZkIvH4+PjiVO4r3Q==
ARC-Authentication-Results: i=1;
	rspamd-7b4c58cfff-fqgj4;
	auth=pass smtp.auth=hostingeremailsmtpin
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremailsmtpin|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremailsmtpin|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremailsmtpin
X-Abortive-Chief: 757645e55ea9b9c9_1756712568122_1960068458
X-MC-Loop-Signature: 1756712568121:3319952433
X-MC-Ingress-Time: 1756712568121
Received: from fr-int-smtpout29.hostinger.io ([UNAVAILABLE]. [148.222.54.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.100.57 (trex/7.1.3);
	Mon, 01 Sep 2025 07:42:48 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4448:6b00:689c:a39b:4944:1283])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cFgnx55FNz2yCj;
	Mon,  1 Sep 2025 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1756712565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uf8lR8iqOG2HiTIMNASE8NmAa7I+P5C3g55YY2jtJYA=;
	b=RogPIcCkRaxid/pyhp0y6YIdeNJGQvpnPljE/yuPu7bSl3nq85Q8B7IfjtUuRqIl6xcJcU
	BLQCghOyu6XeLJ37fqXM05DJLS6ve8zv8sFK5joCxGOm8Z5Tn3u4S1dnP7tdL/MlfLEzNe
	l06n/VHm8mHqO99mOPfLaoa6ZC4PAp0aR4jjuEXsjMPP7m0r3eFZFEFXaZVK6Hb5NjLH+C
	ZRasVo1wmAEG4iaG/AyuJNogLe+bKMZRnInIPROdLB1lyc5XfW59tfkEchRi/MOO8eo5dL
	MkYz6HPhxgWyiQ97Mp/ORLKGp9y0TBvaR/ESHwcKqb75OjIA+tNKlt2VKJS8lw==
From: michael.opdenacker@rootcommit.com
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Subject: [meta-security][PATCH 1/2] lynis: homepage update
Message-ID: <20250901074232.11224-1-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Date: Mon,  1 Sep 2025 07:42:45 +0000 (UTC)
X-CM-Envelope: MS4xfBPI9nFNBEkg49AYiB9RhELcAdwveC9Vt8CQeEuuNLgtrsr6st50Wy0dzqOJPQGdXLEHkyqmifeks0WdgDoRoL/yjKNctrEZeBmalvsV9lRZW+FVSeFn xLnDrqqn4B/SxYl5ZshhlPV14WNTT8zp2yTgJNgIXP85h32T4rqyyMSZHHCEmZ3kamaFSVUOOA097Z4bvqSMEJo+vqK6p7f1MMYVNQeOF+NBVHvRZ5tt0yXf KKOnZAsRbg42Gx83AIJ1QomlZVBL5CGhlkUIgZ5z7xYFobX6qDxiLXY44wSJ32dXwb1AMw0UvuGORE2/lRbUCfuh0K8TSkMIFd2N+6uZZsAOKVjWV28+OK60 7aNtemTR
X-CM-Analysis: v=2.4 cv=DJTd4DNb c=1 sm=1 tr=0 ts=68b54e75 a=A2p+tBJTcTTWbKeodpwbAQ==:617 a=xqWC_Br6kY4A:10 a=CWYfyUVCAAAA:8 a=d70CFdQeAAAA:8 a=_cxjYUmhb6Zop4-J7MEA:9 a=ZXulRonScM0A:10 a=1VeIQ1mWMp7PqO1uulY2:22 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Sep 2025 07:42:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2098

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 recipes-compliance/lynis/lynis_3.1.4.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-compliance/lynis/lynis_3.1.4.bb b/recipes-compliance=
/lynis/lynis_3.1.4.bb
index 4059662..3546a9e 100644
--- a/recipes-compliance/lynis/lynis_3.1.4.bb
+++ b/recipes-compliance/lynis/lynis_3.1.4.bb
@@ -2,7 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
=20
 SUMMARY =3D "Lynis is a free and open source security and auditing tool.=
"
-HOMEDIR =3D "https://cisofy.com/"
+HOMEDIR =3D "https://cisofy.com/lynis/"
 LICENSE =3D "GPL-3.0-only"
 LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3edd6782854304fd11da4975ab979=
9c1"
=20

