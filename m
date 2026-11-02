Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4435.1793659684322836104
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Nov 2026 14:48:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=l2qm2+E1;
 spf=pass (domain: konsulko.com, ip: 209.85.128.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a208d93758so37623615e9.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 14:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1793659682; x=1794264482; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UhlLcIIHQ3hel9uGoQjXyEnmZP7DfsHyedgrcni+k6M=;
        b=l2qm2+E1EWlyhp2fa+8x26n051wjWA7hBSZG8VjtKoI6bcw8yukBPOIpMCM4XRaq9L
         VOc6lLa/Re95i9Qe9mxxAXcK0xaJ3/4+SV5UnKwVkMcBp/od/DujokRIR39IAh7v4c8G
         C/WFBsDIGL6cXFf+FhFsCRzF1IA4b2rOCEZAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659682; x=1794264482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UhlLcIIHQ3hel9uGoQjXyEnmZP7DfsHyedgrcni+k6M=;
        b=mMUxBtYvsObfHDEoxJcriaMbLreOa1UFJ41oLNTGxd1+kBBV4uv/bDgDxKR0Bbw/0a
         IEi3BEtYg6moBlxIKfISxLFlaSlPMi7FRr96LOUXbl9pWo8SjJFXH5+SYJRtH0ZEnp09
         paS81V4RY4EvnVsA2XbDewW28tE3vy83Lh+DI7e/53dJ1VzAbRQc56L24NxTLT/ve4gv
         pBtIHsPntY/0zhnXYt8CF+B0GEwSkgfJqmzgVo8FsZAHvnGzH3HPJclQFKDn73PCuFq2
         QOZKvVmggtlD/UnoSC2pNcvukyEIC6LFHwbt75z89zumQJIEznpsERSAWwH1Jv/6o3/p
         O+4A==
X-Gm-Message-State: AFq9FYLZKwmM5SmGSe16I/b6al3ztLU741ULMtUTKt6l64+exlKRHkrx
	LwU/Gv6A9xaf85tjPv6Sk72QMnSJIJ6eGiMDVD6pCmMiBPbgGD43s8jOsul+BJ6O0fTg75HqlyX
	PsS6+
X-Gm-Gg: AYBFou1u+62O7osCdA0QxvQZmk1M/N4jBHEWsSaegNggBM96uz+e23PhNKGExFafoRq
	sdRWmzo/7ln3Edu8wluTcmHvomgqXsaOZERC6Ost9KGRh5MrjqbYnmyqAu/6AiJFvs/kxo+pcWr
	SJNJW7hPNG47Yrs96FeOu3RHYGbS0DCP9Rc+azaSPzV2jlgI5V5CF+y1BTyDK1WRcAzREUNgM4e
	3oB8hn7w5GzpyxPKqbdt+y0+QSoCjJal8IPM/Oi8V9fhxL5JbigW4eFaISiaRTVp/nHYkBW1K4d
	laNKVIRj7659qKB+pT4xhTC8BAiQwGPyVis8l4txcrtVe+/HxFCol1mr+iN/tKoZ4w0xSlItO7X
	HzVIspdvaVOfFMO85WQTZ3u5JCBkuH2egKJI2aheS8Bf6GVbi2pQMbIuhWKyFRJN9LRhJPXAM1q
	jYRYkOh/L0C55MyXpNm0a61Sy/5u743ny3zV81E0Q47x2urN5MT66dUmQp8yVeB+Bc0FMhw13ZE
	AukwWa7QaPC0/6kXL2umtwcu1zKVy4cM23pnPhKuvRR34Ol47Ev3C6E28GPO1iStQEYO/Uq3n+Q
	IIL2ljnC3m2esKFIay2wiGHAU2A8fuL/LA3H3fYxjeuwaD80Mks2WVBzQvVlN6Q8q/CsNpENNJ9
	UHvf85trVYh1EvTCry5eWnXpZwkSE3bU=
X-Received: by 2002:a05:600c:c088:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4acda922e24mr177024095e9.1.1793659681985;
        Mon, 02 Nov 2026 14:48:01 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba7168sm23770828f8f.55.2026.11.02.14.47.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:48:00 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 0/4] Assorted updates 11/02
Date: Tue,  3 Nov 2026 00:47:44 +0200
Message-ID: <cover.1793659376.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 22:48:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5208
Content-Type: text/plain; charset="utf-8"

This got a bit hung up a bit getting through CI, there are a couple
of recently submitted fixes, as well as a couple of build fixes
from myself.  I have pushed them to master-next if you want to try
them locally, and plan to merge to master by end of day tomorrow
(11/03, EST) if there are no objections.

Scott


Changes:

Leonard Anderweit (1):
  tpm2-tss: update to 4.2.0

Scott Murray (3):
  ding-libs: update to 0.7.0
  swtpm: Add missing useradd inherit
  python3-tpm2-pytss: Upgrade 2.3.0 -> 3.0.0

 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb    |  2 +-
 ...0001-Handle-CC-values-with-arguments.patch | 51 +++++++++++++++++++
 ...s_2.3.0.bb => python3-tpm2-pytss_3.0.0.bb} |  5 +-
 .../tpm2-tss/tpm2-tss/fixup_hosttools.patch   | 13 ++---
 .../{tpm2-tss_4.1.3.bb => tpm2-tss_4.2.0.bb}  |  4 +-
 recipes-security/ding-libs/ding-libs_0.7.0.bb | 11 ++++
 recipes-security/libdhash/ding-libs_0.6.1.bb  | 12 -----
 7 files changed, 74 insertions(+), 24 deletions(-)
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss/0001-Handle-CC-values-with-arguments.patch
 rename meta-tpm/recipes-tpm2/tpm2-pytss/{python3-tpm2-pytss_2.3.0.bb => python3-tpm2-pytss_3.0.0.bb} (80%)
 rename meta-tpm/recipes-tpm2/tpm2-tss/{tpm2-tss_4.1.3.bb => tpm2-tss_4.2.0.bb} (94%)
 create mode 100644 recipes-security/ding-libs/ding-libs_0.7.0.bb
 delete mode 100644 recipes-security/libdhash/ding-libs_0.6.1.bb

-- 
2.47.3

