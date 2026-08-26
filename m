Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62382C61DC7
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:58:53 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22431.1787777931099831138
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LNO1tm6e;
 spf=pass (domain: konsulko.com, ip: 209.85.160.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52eaeddc837so4957971cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777930; x=1788382730; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xdlFyYrGKG5jHyZuV87d9EKl7RH3zmWbK3/ikF3Iy8A=;
        b=LNO1tm6ezRM2656oPte2UE4dDdoxAxMmJBuLKPtdgd1/LAN1ErtIjDXTrKiYLgVpp9
         U35Ti4pZRN+0n6Ty+2LOU3BSDFg3nsy1jifwSs5iZIpWNXuMBzqzmQNXBNjY0F8OmDpu
         GOtdBkpKqBDpNXFS0dp7VRJs8uiWFyL+8HJB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777930; x=1788382730;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xdlFyYrGKG5jHyZuV87d9EKl7RH3zmWbK3/ikF3Iy8A=;
        b=Shl44Cb3C8godBQhdWgLRXRY4xvyHiJ6cj4IuTcUVzVGDJXUHi8IGY4gsNxqZN1a3g
         N82NMS9lU6P6DIVi/HjOQOD7nbB00Z5H4a03UAaH7ZEJBwHmnT0cYftpi+pDV3m7LyW2
         SUvzjUNrufICnqD98epPKdX4G2r2uVoD9jDYM3K25P78fNe6yfBplmlazwsqEQN7iaWj
         8KF0Bwm3atJbyJNK/NnuhDn6fgHxyQe3b3FQol6s5ITjp8xBfI47Gw24P3dhLjRasUcj
         nI+tVOSdTlV0eVHJfJEf+nbdhW4WEh2tUifybp7E5HzIL08KmN59LzrmuB24slM7h63c
         eFZg==
X-Gm-Message-State: AFuF++l9PJfI8FqxwYmoFpB6jDOgybqZQNCt/FDJEaLO6AD+lAIkQScX
	mKchkdslKRw5wenJCH2y1CfDN47iZizulRUA4MS0e5y+kYQ+tquDvbDIAye92p7FJlU9ESvkglE
	d4OaL
X-Gm-Gg: AR+sD10XC+LCVw7txvRtQv1sBIy458cpFKIqNRdfKe1UyoJiupTLvi/aJ3kiMP2U0oZ
	27VewK+e/5nW0Six+MXaLGAg5hdZfpzkZVcBFkDDsAh2nGuaeuNPckZ5OkxeWVbH5AO9Dva9kya
	L2/8ZSku9KFXKpCfLtPdho1DEyz7hhwg/Hxf3F7zAo41o1bylZpcqYCnV3YkR19MWuoWTXDcO+l
	xTRFbCoXMG3k0IvS94UUgBdzpN1GHl1L2uMRfBMoQIplV5AuNeLo9AQiTTzWO1NMrjoL7qzMaP3
	J+vAPNiR/Olzk4fXeXdrYjX4WLvNTZJ62J4i+pLR1MT09ov8gCF7m/U6t0bDYfwrQqHp1ELy5mS
	+TGlY+Bh6jeoXMBl8dSCwzmDKbQ32QLf0UiZyJoziF2JfvFuJ4A6ErWKaNU60aroWBQ3UTkpZGx
	uGQrR2ArdSSjvbbGNb1as2swW4//P199rN9K65Ui4RQZ4aTdRiJCiioEziVlGnofzV+RUs2aYsu
	abYUv5DSs/HNBRJpT/tYOh9dX5MW7tsl7jK89w3NJwMGXQd1p/IDudkKumYzpnUCFwI0CQt2nr0
	GJVkP4L0Hu91F9JwtmMu/I7J/UZaNL1b6QkT
X-Received: by 2002:a05:622a:50e:b0:51c:b900:513f with SMTP id d75a77b69052e-52e4226d3f4mr90549291cf.10.1787777929973;
        Wed, 26 Aug 2026 13:58:49 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 07/15] wic: document the meta-intel dependency in the dm-verity hash example
Date: Wed, 26 Aug 2026 16:57:41 -0400
Message-ID: <d2c9a6194f8083b52a636b4d9ca9a3b7429f2ee3.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:58:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4699

From: Gaël PORTAY <gael.portay+rtone@gmail.com>

The dependency might not be obvious to everyone, so leave a hint as in
commit 2fbeebc18c ("dm-verity: document the meta-intel dependency in the
systemd example").

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 files/wic/systemd-bootdisk-dmverity-hash.wks.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/files/wic/systemd-bootdisk-dmverity-hash.wks.in b/files/wic/systemd-bootdisk-dmverity-hash.wks.in
index e400593..67abaa6 100644
--- a/files/wic/systemd-bootdisk-dmverity-hash.wks.in
+++ b/files/wic/systemd-bootdisk-dmverity-hash.wks.in
@@ -6,6 +6,7 @@
 # Based on OE-core's systemd-bootdisk.wks and meta-security's beaglebone-yocto-verity.wks.in file
 #
 # This .wks only works with the dm-verity-img class and separate hash data. (DM_VERITY_SEPARATE_HASH)
+# Also note that the use of microcode.cpio introduces a meta-intel layer dependency.
 
 part /boot --source bootimg-efi --sourceparams="loader=systemd-boot,initrd=microcode.cpio" --ondisk sda --label msdos --active --align 1024 --use-uuid
 
-- 
2.55.0


