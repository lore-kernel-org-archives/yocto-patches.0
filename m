Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45043.1793199827943505394
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 08:03:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=JqQAEIZe;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 95F21C4FED2
	for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 15:04:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7FF5B60769
	for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 15:03:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBE3A103290BC;
	Wed, 28 Oct 2026 16:03:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793199819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=cPFyYjzYOaLOIHWcZO/jVLNfZNkAluNobZkI52PsEuE=;
	b=JqQAEIZedn3L3uZInzVJau6cTvrCgkffbbLrcs8k4hbPft9PSDv3qxSUY9RilIHYOTbxDo
	Ewx7D8CHspfoeDSU+fMeUcRTIPG6AL25iekxxHLDJyR3MP4t7xLhGMvO+b5DmJaZg8qrfx
	IxzkPvGH51/NNdL7JXuBn+1XANZNd5onQEOFeTX/pEJmOqNTurVstqjGv+GWNXYV0YlVDT
	n6w640X56pZjMGumLHxpi/msmKJwU6We6ccTpv8YiI7AYjfJXGEfXQ9WZ7e2DywogopWAg
	fnGGW1M69udfiTI7Agar16auZzOzeLXyX17jVIHp6E/w1CN7L+Y7E8LPnHcXEQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 28 Oct 2026 16:03:30 +0100
Subject: [yocto-autobuilder-helper][PATCH] scripts/run-docs-build: checkout
 release diagram from master
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-docs-checkout-releases-svg-v1-1-0b53b84704bc@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBAF0KuQWTsJFCXEqxAWpf1AlVDSaYmGc
 HerLt/mHSQIDkL34qCA3Ynza0Z1KcjMep3AzmaTKlVTlapl642wmWGePkUOWKAFwrJPfFNNO16
 tblRdUQ62gNG9fnnX/y1peMDE79i9vYmedYp+SG6xCDxj2RB6Os8PRwvBCJgAAAA=
X-Change-ID: 20261028-docs-checkout-releases-svg-5268f4da6231
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=OLIt0m2op/1FtYmpE8bPGOsQJ/HamhYCZ7jooTTQW1E=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBq4g7EOsjOmEI+i/S3bcMQ3Gzyw4czRmEmnLCL/
 XJFYzwAA5eJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCauIOxAAKCRDRgEFAKaOo
 NiY0D/0biVTc2Kmu0AtidCPiZz/Qr20NtuVTwR+PP+c8hrUuMUxGF97VZPvICumabetHe9dJjYI
 v08S5Ko7bxmAo4FLEiV6RjQ5njCG2OpWYHqudwI2vFPoI4Iv29wi+6ScLMwtH35ZEQariLWNBTr
 pTXaO+ur3C6jnME9ZKIksH+dAhfBDm/dc+szc6NKas7KmjuiplViZxOyIKX0tj7PZevjz3qSlSA
 GIO3dRxxTV3Rhq8juFGOOVlOQ3dKvtSt7ORN94202ZkR3d39KVKbF9wP16ojD4hMNfmrEEJNlw6
 ZlRR4URrjWMnHAnCTCVL8II/BRzlAFOsWZIP7ba0YrnOO/a39OzgBoW686rqNCSHlwfcug5qXPk
 Bjo/YSYFmQfNLixRw/ce2aTVuDwiFeKm09SZ1NAhA7msvZqiiDUQOd+W9WcIFlOGsokxEG/0Hkd
 zwI6GaM7jdpm4GbQMafP9dRdl8gha9VjyZnGtAIb6QBleOsnK/LxFYVhyrrLOI8PHA4Xwrve6AC
 wZcgMruy/5s+Um861NqGZ7MY9Gd2kHwx6fG/oDC0nJCFmL8AnHi9AUps7BDsKlGjVH+gJEGuk09
 Ib2cTUN38ku1r6Vv3h2L6A9xjd7d8kGU+/AsIo0zGX0/1JqfbaQ6bug6+P2h6k1ZBLRjJVWIoxx
 WSCajo5VqVpNGNA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 15:03:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5174

The release diagram should be a current representation of the active
releases of the Yocto Project. Instead of manually backporting this
diagram on old branches of the documentation, we can checkout the
diagram directly from master instead. That way, the diagram will only
need to be updated on master every new release.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 5f5fa05..438a1fd 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -219,7 +219,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
         git apply -3 "${scriptdir}/docs-build-patches/${branch}/"000*
     fi
 
-    git checkout origin/master sphinx-static/switchers.js.in set_versions.py _templates/footer.html
+    git checkout origin/master sphinx-static/switchers.js.in set_versions.py _templates/footer.html ref-manual/svg/releases.svg
     if [ -e poky.yaml ]; then
         cp poky.yaml poky.yaml.in
     fi

---
base-commit: 25c09c41fdec35f00a8d225f25e69052fdb2596e
change-id: 20261028-docs-checkout-releases-svg-5268f4da6231

