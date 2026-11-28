Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9696.1795884891594923063
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=He+Ipz5K;
 spf=pass (domain: konsulko.com, ip: 209.85.128.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so70535825e9.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884890; x=1796489690; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+r4D9PUJaEptBKaMQwrnMrw7fjFUJy4IttkdADvMVUA=;
        b=He+Ipz5K7PCbrmugYjVMPnjbAptZU6qUVPHdIH8Wgg/GfoSGzpJPzNqlkdS3oB2+Ol
         zJ82+0p1NmkldsM4bPZCNMxASmqeCxu48u24H/obxWmGgxJhJiRHsM2YsoeN/QqdqS5e
         WI0ssI9rjZS72RLGR5WdyAEh1UEa0o3jnF9GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884890; x=1796489690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+r4D9PUJaEptBKaMQwrnMrw7fjFUJy4IttkdADvMVUA=;
        b=GLd+rs9P9S6EppldldsIwwEjinl/dFB97nwzayUnXIZdTL/dS+PK5F1Tn7Yv316Nvm
         lk8zz6r3UNFx/Jh4GEndyIycaRwGPJaAzYB+oNngcc68FQkHJxPqKlA4wd1LPua/UW3L
         R5CKHW/h3P56/dvtziCaYFTEZx2DtcPMtmpCUmE85iPLlup9SwxX+8apoDYOaPbJCozE
         xcplDKuWrHHdfdomNBMZ2GkSfEllilTyVXscHciwHV+8T4qtP/7IC3HSrVOXn6WcbToD
         jUHMfivKkaQAmF3y/WurAImQpSzRbJKNDvSa4+NnzkeIj3vRUZf0/1xTSqZ0N4iwRnQK
         V27A==
X-Gm-Message-State: APuU4Z+8aTHSw/MIcxB3x20VpUBht2iUYQk+mOV+M9IOLzFT7m6OwMKP
	+xJNXV9jYtfa/JWjsDJIFwUU3hA4PW4zsdWKcnyccsoYf/8jL73LEzrFTCT5/BP9xH5YmmQiG5w
	GNREoVTc=
X-Gm-Gg: AZFdTZc5mIa7ns9mvuSvNvcq2sG7wRHL/wWdPJg7hQXRO1PomrhZVZHzOg3+392Tb14
	BEwbwozY+U3I9yOeTIc3hj8Z/+J+P9ZkUZgK+2l4EaY8Jb3NakJbrgc2QjCv4m568jFKRUaUH8p
	/kTtqwAw7njoc/bwdmK5r42XcbwjpPPGfjZT3ZZ7slAWOkm8AUyrw1dkBNCM8BaZY11roBthAwu
	KffV7eN/YOchyxG7Bni9DBMUssB/iiQLMOqCGDoya4ZPgq/GFzAWhj3wkiPz8fp54+97wjxPiyw
	F8HPkuw3Aa5V+Xz2BEpFHhsXSxKKcaq5Z+MtneJiBx4KIV5V7c0J9rSwxJlrxdWwdj0k1w+ykzM
	8q2+5cdI7aeCjRSK0s0gfo89k7gUqXoJIqjUU9+uSBng6B20VHmb5MVGQWhgTNNmWkzaJ/umTUu
	RcAdLTzzy/gYL1b8jQRNWDBfjtOtzY2Kiic32qRzlytaMFNBHOkSpStKiE43/+e3qimn6FJQKa0
	YASIWekC2guA3wkj61hOix0A024rqSMqPlcKImWYQdn1fmbtBQDqml6JD0beRHGAjxEkcDWudW+
	Y/WRyQDoDMbBVmpyBYDHoyKsxVAJgW/jpgmZxuEmLwLsL0auWgp8aj/hoDgKaQX42R7dosZkF2O
	+h/f4L8WSa8D3181QPtjNYPEyJ3Kxgw==
X-Received: by 2002:a05:600c:674f:b0:4bb:7e4e:de69 with SMTP id 5b1f17b1804b1-4bb88814c37mr545956595e9.20.1795884889853;
        Sat, 28 Nov 2026 08:54:49 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:49 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 04/14] dm-verity-image-initramfs: Fix IMAGE_PREPROCESS_COMMAND
Date: Sat, 28 Nov 2026 18:54:22 +0200
Message-ID: <0e87fd67da62b0e06501f56bf9a9ed22dab36458.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5574
Content-Type: text/plain; charset="utf-8"

Remove semi-colon as it is incorrect in IMAGE_PREPROCESS_COMMAND.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-core/images/dm-verity-image-initramfs.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/dm-verity-image-initramfs.bb b/recipes-core/images/dm-verity-image-initramfs.bb
index 7ed83dc..294c234 100644
--- a/recipes-core/images/dm-verity-image-initramfs.bb
+++ b/recipes-core/images/dm-verity-image-initramfs.bb
@@ -40,4 +40,4 @@ deploy_verity_hash() {
         ${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.${DM_VERITY_IMAGE_TYPE}.verity.env \
         ${IMAGE_ROOTFS}${datadir}/misc/dm-verity.env
 }
-IMAGE_PREPROCESS_COMMAND += "deploy_verity_hash;"
+IMAGE_PREPROCESS_COMMAND += "deploy_verity_hash "
-- 
2.47.3

