Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9276.1795883250384531953
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:27:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=r+xlKEZS;
 spf=pass (domain: konsulko.com, ip: 209.85.128.52, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bba60271d7so33924645e9.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795883249; x=1796488049; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4wrptToHUiH326jKHsRNQ9gi0HlC5Ou1sG92M128iew=;
        b=r+xlKEZSMoEU+rlMGM/KVIJdhOVCuFk+U96PMdAky5bncPVXLUrCOuMJ89YvfA+an/
         Kx0pKUT8DiZ2R0PZNkRIXXJ5obIBJRyiZURx/afW4LzPqeB5RJm0ci275JC+Cp9Mp4uG
         q3Yg/eltNe8wN7ZUGVa8aLnPbeDVwTFWIRSeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795883249; x=1796488049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4wrptToHUiH326jKHsRNQ9gi0HlC5Ou1sG92M128iew=;
        b=cfDGHD+K12zAk4qqVoypNB8FAsdjwqS+FmjQ4jGyYsxdbXnwzGVfepkyTnEOz8n7U5
         bmmLrdn1NysgCpv7ZCDu4xCBZCKmz0m1oNkOdJ5jGIryWxdSL4WcbaqMHArO9HamiYFj
         NIx67pD9+p/j5gWgChTlU5ps++DHfP1m24tre9U8DNvNV4SS5PVZiXswIXFwk9MdEC5+
         c/Sdkv+6jJjVpDBtrGMjrx70V3jwEJChPF9Q4n0Xf6peUn5J4MaPBZ/LGP4KbJqLaAIi
         5yvSAuAVPYM1fL8g+uAYqUFM0Fsmu96CCnIRY+65+8GUOwM9pB2sPh+UHgajJ2eT5jEX
         hT8A==
X-Gm-Message-State: APuU4Z8OY1U5viCnVMITF1rZj/f8eRQo9etAYO2VgQjbWj8ApnbaurEM
	tjK8sMD4O6Yc/jSCCDa0as+i7GVOjEcadIvgonZB4v+krl9cfI9B/w7DNx2Zl27NX6BtCTQbuZe
	oYH8+D5g=
X-Gm-Gg: AZFdTZc2Igm7OCf5R4oqDC1+xlpFcZVm/uQ093tk1BVRsZoT+/4VictY/x5qYuiQ6fp
	309TNBfW1w/6tjY0edZK4T/VR0eisLqbr6ud391JKnWPuTbHl2isJ76vxU701j6Ddzsnb3aKXcz
	yoSL+7mtPqyGEuxQ0EXgycaKizPwhUU+2adMa4f5yDHsyZhMqapma5ni7JML5B/n5T5utSitRSq
	vCiGq0fS0uma/EjDdTFC63qoTSUsetPmQAJtaHN+HH3Ub4N5WPZKk4Dz62lF3IwLMP6QI8XWwI3
	wEiE2nkXZ9k2lwpc+K0iRS+XE3X+RsWBsVlDuGn0iHFqtI0B6Wyn5TRxq0vnGGdrNJlSknMh9Vm
	2l4QoTMQkrdv5WEZ0DoXHyvli71kWUNyffMqjBj/iNBDUMgA9x1UQdhKDeYWnzSXd0W+qROFoTa
	x1qkM82kcJMZJM4Z2/YvFGz0pFV0lK7eKL9ApZqa6lIxNfSXCKYuhhpz2gUj5eFl1hPZ9mrXO6f
	aeJGwJqAduB19umQPZlC8zmabjtTTDYwMfWLjmMJmJUzeoqwqAI9cjUNwZC/67FvG6hzq2Hnrvb
	MVNXqEVIMje2RvjmkScdix/RVQ/e87jkMffSR1KljuZDSkz3HMz3UBakxo/ke73a/X99AoJ+AOI
	l6i8DkpTs7p8QYEszqMRaX4CzgLPa2g==
X-Received: by 2002:a05:600c:4753:b0:4a1:cfa7:e968 with SMTP id 5b1f17b1804b1-4bb8880c73emr584921255e9.21.1795883248602;
        Sat, 28 Nov 2026 08:27:28 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm529202045e9.1.2026.11.28.08.27.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:27:28 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 03/10] systemd: do not enable efi for tpm2
Date: Sat, 28 Nov 2026 18:27:06 +0200
Message-ID: <0e22062bdc29f5ce6a255802eb3c9d0738a60391.1795882913.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795882913.git.scott.murray@konsulko.com>
References: <cover.1795882913.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:27:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5562
Content-Type: text/plain; charset="utf-8"

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Do not implicitly enable systemd EFI support when tpm2 is enabled in
DISTRO_FEATURES, as this builds and enables bootctl and
systemd-boot-update.service on machines that do not boot through UEFI.

Rely on the existing EFI configuration mechanism in OE-Core which
already enable systemd EFI support when efi is present in
DISTRO_FEATURES.

Fixes: 6eb3098e5788 ("systemd: enable TPM support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-core/systemd/systemd_%.bbappend | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
index 867c111..0568ab5 100644
--- a/meta-tpm/recipes-core/systemd/systemd_%.bbappend
+++ b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
@@ -2,7 +2,7 @@ PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'tpm2',
 
 # for encrypted filesystems
 PACKAGECONFIG:append = " \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'cryptsetup cryptsetup-plugins efi openssl repart', '', d)} \
+    ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'cryptsetup cryptsetup-plugins openssl repart', '', d)} \
 "
 
 # ukify.py and systemd-measure don't work in cross compile environment without
-- 
2.47.3

