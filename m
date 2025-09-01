Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788C4CA0FF0
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 07:43:08 +0000 (UTC)
Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
 by mx.groups.io with SMTP id smtpd.web10.45946.1756712581885362286
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Sep 2025 00:43:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@rootcommit.com header.s=hostingermail-a header.b=nSBkSdJk;
 spf=pass (domain: rootcommit.com, ip: 23.83.218.252, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremailsmtpin|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F09DC9030FE
	for <yocto-patches@lists.yoctoproject.org>; Mon,  1 Sep 2025 07:43:00 +0000 (UTC)
Received: from fr-int-smtpout29.hostinger.io (100-102-70-134.trex-nlb.outbound.svc.cluster.local [100.102.70.134])
	(Authenticated sender: hostingeremailsmtpin)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4C357903A22
	for <yocto-patches@lists.yoctoproject.org>; Mon,  1 Sep 2025 07:43:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1756712580; a=rsa-sha256;
	cv=none;
	b=RCDgUl9ZRA/TNNijF1H4mzpcD2K9ofqvJSwuAkncGP0Ejm04pkBv7o8YTYABYMi9igSkXy
	i1eKJCeSsPpmUlIcLDAmH0U6//BZAXqvQZfHUvWWhBw4IhD+QiBlrB4DfnrWs7rQF1+8V3
	dKa/uil9/PjSd/HJANPZhK98047qGTmd+12JdYvhrgG9b8/8ueZWClMc4uxAcZmsvq3UQb
	chZAb27UVyJzvDZEAahkRWCywpxtphdmXYO1nC6LShYEGt/3Sm9OVL6RPek+YKQ92UymLv
	RvOcplC3jymNyaRlKiiKiDh2Mh0exQjfJqkXOD9JrfTOctssJKULr0fFqZOFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1756712580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IZ0Bl8ux7h4bH0PTcMlt7N9Zs/IvMSrSHFZb6147L9Y=;
	b=5eBzpKfXURbCtIdm906W1uC4hEQCG3mCBbQsbs4e3jTOTPRpVznXzg3fIVAEGNjsT6PIbJ
	OyuAV0PJYa02/rhj9DKxkYLlXKSKhgXJWX0+39bTwgCEuf1cfqzIEiwGzNipGKEfIHonOZ
	ux2E0ok3KiNezHTf3HsqPJvCK+iMs43b0eRVt03aZaeKS04VbiQQr74fgUPXxgUdgPxvtM
	VKOLOaSgKydquHuzQeXXbrK+bqF9i5tHtuCH66bmVt+nRi6N9xTFHoC7Dp1YxAiSY0TG4a
	8QPuLviYgqBU1nd0vKNvi/Ma2kcJoyP5CqraiQJGiO8JYTjVJ/cuoPyeEk8Nrg==
ARC-Authentication-Results: i=1;
	rspamd-7b4c58cfff-4bvr6;
	auth=pass smtp.auth=hostingeremailsmtpin
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremailsmtpin|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremailsmtpin|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremailsmtpin
X-Hysterical-Squirrel: 436b00e072d07a16_1756712580833_1757736644
X-MC-Loop-Signature: 1756712580833:2286260079
X-MC-Ingress-Time: 1756712580832
Received: from fr-int-smtpout29.hostinger.io ([UNAVAILABLE]. [148.222.54.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.70.134 (trex/7.1.3);
	Mon, 01 Sep 2025 07:43:00 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4448:6b00:689c:a39b:4944:1283])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cFgpB3pVlz2yDF;
	Mon,  1 Sep 2025 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1756712578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZ0Bl8ux7h4bH0PTcMlt7N9Zs/IvMSrSHFZb6147L9Y=;
	b=nSBkSdJkgFWTOG5tG4hazBj5r1N6CYz4tUYAw7lPXYIc7Gen/vpFrgyN4ACEIZgIIgpvid
	TaQUtxLfRfEcewXzR7cjtBhnZDhfRhHc1XEuv2rI7gGoBsEAp2/phXn2Wl9ea5D/opW/5M
	tg15c86N+QQVRIwCVZ94V9Qyx7tNMTaP73bqToC2siVRpl+wNkSMwPYdUiI0ab/7iDspBt
	BAK3GnWu7XC79U2f5h/CfZ21LJseAYlIcoyOJHsRHHcoJBeNZHxQQ/p2kIkSuUqhm9BAEI
	HoJm4tplEwM+w/4Cc62jyZS0l6A8cODzjzDIhO0DDL1saJb31h0in7wn0V1QQA==
From: michael.opdenacker@rootcommit.com
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Subject: [meta-security][PATCH 2/2] lynis: update to 3.1.5
Message-ID: <20250901074232.11224-2-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901074232.11224-1-michael.opdenacker@rootcommit.com>
References: <20250901074232.11224-1-michael.opdenacker@rootcommit.com>
MIME-Version: 1.0
Date: Mon,  1 Sep 2025 07:42:58 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=DJTd4DNb c=1 sm=1 tr=0 ts=68b54e82 a=A2p+tBJTcTTWbKeodpwbAQ==:617 a=xqWC_Br6kY4A:10 a=CWYfyUVCAAAA:8 a=d70CFdQeAAAA:8 a=eQUqB77JZhXb5SoyF3cA:9 a=1VeIQ1mWMp7PqO1uulY2:22 a=NcxpMcIZDGm-g932nG_k:22
X-CM-Envelope: MS4xfI8M0+Rnk6a/cTKKmGXQbMnZJ1bK858+myKpjLzDsJRx8es+uGHDZS8Stx/fCO6YJQmOEW3sxlgDaDLXI4qSVbTrMYQhEZHjiaT+BNz5SDWYvqizpSKf QXxPtU8sgaW6+BEFgPLE5ZqIrUttcSxQxMAL2ER0WtxeB+hckWedLnJ0iRzuqssp5aVwL8QRjdtcMvSNgPOD0vw9gYWbw1rh46GDw6Jr3iXdvqiwXLit3Abp sZ3RLETnEWvJCacHoXlAHOy3HRP+VJHSYQx+0oMR0s/SR/MY4TsH4G8M+FjXz6YJXAGMWJJvHi2ypROkP1dKuSVgizYVdwnMkg/UPMXOax6RgVGPezblas+x avzF2meA
X-AuthUser: michael.opdenacker@rootcommit.com
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Sep 2025 07:43:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2099

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Tested on master (whinlatter) with beaglebone-yocto

New in version 3.1.5 (2025-07-29):
https://cisofy.com/changelog/lynis/#315

Added:
- Support for OpenWrt
- Bitdefender detection on Linux
- Detection of openSUSE Tumbleweed-Slowroll

Changed:
- Corrected detection of service manager SMF
- Extended GetHostID function to allow HostID and HostID2 creation on Ope=
nWrt
- Check modules also under /usr/lib/modules.d

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 recipes-compliance/lynis/{lynis_3.1.4.bb =3D> lynis_3.1.5.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/lynis/{lynis_3.1.4.bb =3D> lynis_3.1.5.bb} (93=
%)

diff --git a/recipes-compliance/lynis/lynis_3.1.4.bb b/recipes-compliance=
/lynis/lynis_3.1.5.bb
similarity index 93%
rename from recipes-compliance/lynis/lynis_3.1.4.bb
rename to recipes-compliance/lynis/lynis_3.1.5.bb
index 3546a9e..3d1e8b7 100644
--- a/recipes-compliance/lynis/lynis_3.1.4.bb
+++ b/recipes-compliance/lynis/lynis_3.1.5.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3edd6782854304=
fd11da4975ab9799c1"
=20
 SRC_URI =3D "https://downloads.cisofy.com/lynis/${BPN}-${PV}.tar.gz"
=20
-SRC_URI[sha256sum] =3D "c4dbcddd429624d5b2319cd3b19728e18a7885b70b8eb0a9=
fdd3ca5f0ae28eb6"
+SRC_URI[sha256sum] =3D "8d2c6652ba60116a82514522b666ca77293f4bfc69f1e581=
028769f7ebb52ba4"
=20
 #UPSTREAM_CHECK =3D "https://downloads.cisofy.com/lynis"
=20

