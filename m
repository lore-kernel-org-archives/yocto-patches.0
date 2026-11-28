Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9692.1795884889298697259
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=OWbr29j6;
 spf=pass (domain: konsulko.com, ip: 209.85.221.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4a5024b3c28so5701958f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884887; x=1796489687; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5whIJ3QliBZiO6HXJQ5eQn7rd/EL29EXJ0sethQIiOQ=;
        b=OWbr29j6yv1xj8eEm1ACe0n/ncH7bXRgp4zjW4qrcVgk+nUwHvuNIKczqxrw+HqLCI
         /pygyod5fyO/X9RsxK/aXymDjiY5rTQqwEoaKo4HRYRAS/aHkw0in91TO2dr3kCS/lFw
         L/KDPNgkCxo7dw5nppsHtyNkl+jj1AuIMPOfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884887; x=1796489687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5whIJ3QliBZiO6HXJQ5eQn7rd/EL29EXJ0sethQIiOQ=;
        b=ZcTKKQ/PKCGUg/RglfVgPOOebieupPQhTSqQezfHwb3Z2zSIACyhqdT8PFw5xDBFqb
         7yagLMRfqe0MP9uYS91HLpNBojGJGb2p2GXqgO3K2KV+xGw6wEeTMgzz3VyfuLG6ekZT
         +qb5Xw2piMGNJp6503L7ozOdE4erbWZljD+JWSv+FEkXdWdH2oMAdTtibO05KXwaWFXZ
         xFnqKYtUdZIF+u32/KAcJvWrVHFLPHkHpzB7Tp1hvJ1OZpTJZbrSa/JyEYh74krKi1fl
         yrQJMPOwouRgENEA9ZByaN9n9StYj+ZBQD+lRmFBECZFT0gNVJfWe2gV6IEovPDYs7hs
         /ySQ==
X-Gm-Message-State: APuU4Z8MwFMwKP4cFB0MuM3dwmTZTKQJ0gMhG/1lf/62gwEPBQOcY0p4
	kbUT3WSyJ4q2SsBQEx5SE/oadkFM5ie5k0IJBu5h0Me5U4dACWiAympN3GzT2J04QY0tGAyjT/d
	n8VX5MPo=
X-Gm-Gg: AZFdTZcVU/zKofSB1h2WICCEQZMRBHXTM5HKwKx0sWEToUG9wXt+BT9qCwC9qfHfdmf
	hOGb9bMZ9ZjDLdKNVlpualzv4AhvDKve0msaFA9VO5SyyCh14pmr+tZwUYIy68X4vbPFbqOgcAZ
	2Czn9f3AioSW2k1IFGlkB9U8hQRHyajGgOKc81HaOlJ4g4Gf49LuMiR2Hssh9ueJaH8iY1FRvoi
	TOBhZuXZpqI0H9XfKbsv8QoMsZQ02F2fu3aGPh7heuNm71fHDb/6qEhb6apv8KIS2LtX/u/2cIy
	mBfr2QOPm5kF3lv7oWgHQWK2jtNoZQgnp3pFJzFYdsaNSEorl6A/gPdbO8e/bqr6qpUm5ix5bXz
	XJoPjaCIENktLyfiriWLy7/3k3kzUQnZyVgyT47VsmZn1bFRhPstw59uqhcJe24SbDjEo73ArmB
	/G/jnyNlu5B8E4Ju2mtVfJiHrs+/n8Nt7uKu6wJU1VFAfNkyZpVTKIIcJgv26F2eWS0yQwd12GA
	mdszSwvhZ1vmyk5IIMeK2/YYwqry22YE9UWXlq7cg3ima5sx8DTIdJZ/p9gcKYkikPcSp6srP6C
	x2+4kW4xvd88NanqCn+iWRmZjL6Kk5Dptdrk8o1ipbrtPw44w7lgWtOs/w959W9ovpMUy7BZ1Dq
	6udDAFu6ZMSs41w1Lis90HsdEvVNg3Q==
X-Received: by 2002:a05:600c:e553:b0:4bb:9457:3c93 with SMTP id 5b1f17b1804b1-4bb94573c9amr364639885e9.2.1795884887243;
        Sat, 28 Nov 2026 08:54:47 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:46 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 01/14] glome: update branch name
Date: Sat, 28 Nov 2026 18:54:19 +0200
Message-ID: <dfc418f2708e48fb42a8f60c02fd7d03092e09c7.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:54:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5571
Content-Type: text/plain; charset="utf-8"

Upstream have renamed their 'master' branch to 'main'.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/glome/glome_git.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/glome/glome_git.bb b/recipes-security/glome/glome_git.bb
index 68f2132..c919fd9 100644
--- a/recipes-security/glome/glome_git.bb
+++ b/recipes-security/glome/glome_git.bb
@@ -10,7 +10,7 @@ inherit meson pkgconfig
 
 DEPENDS += "openssl"
 
-SRC_URI = "git://github.com/google/glome.git;branch=master;protocol=https"
+SRC_URI = "git://github.com/google/glome.git;branch=main;protocol=https"
 SRCREV = "48d28f82bd51ae4bccc84fbbee93c375b026596b"
 
 FILES:${PN} += "${libdir}/security"
-- 
2.47.3

