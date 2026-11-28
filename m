Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9704.1795884900185382948
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:55:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Lm8cPqXX;
 spf=pass (domain: konsulko.com, ip: 209.85.128.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so60094535e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884898; x=1796489698; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G6lrH29lKyMfugRyBDCWd0pMr/rgQl1J72EIrCmiP5w=;
        b=Lm8cPqXXTJ+UatChL1VQ6Tl/xDVVKDInObMhe3cxEj28NPNcMdiHUtO9YZTzuLDRM+
         WvnjzwgA2AHuhN4d88xSqXRJU1z+thg/Y3GITMhS2PT/0wQ1Fpep6hwFa5QPfpPdXehL
         /bm0Gx7DjwwEQi/D66hcI/u/R03dK7DxgG5NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884898; x=1796489698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G6lrH29lKyMfugRyBDCWd0pMr/rgQl1J72EIrCmiP5w=;
        b=gEwM7heARsmh+/EwLGZXyqExHIcTh6CqV/0Y7zWsNjXAGGqRx0+sE6LVqdA37mq/j/
         LaX6ws3BXzJo7FhQyiL6znzz3K5MDt/SeVqMukvs7YsQOzZ5yncCm23hmN9RulDKTe4z
         jrtC7XalrhoDSw65AWYLNtcbjlRZyKRXfabuPtuS2+1jRovT7ZdTzeKvtnzvQz2VEWlv
         V+HvrIbHBl/SkWM+0UX6kCuqOsASH9gZGEqfZSz8nWrBtfXFE39VECp6m636nLnRNb7z
         /ipoLz8Twc9KqpiLLQo2uM1iNkhIYDqyFWUtVpGTZn0bKRlvAu8pivhNML29iKz1gBMO
         iEMw==
X-Gm-Message-State: APuU4Z/ekYxBkv82tPCaCjvDefocvb/4KK3QtdCcvFN9pCrf/4j82d1r
	drRwy+GTZg6S9M6phm1qM6oVePeaohnskTaoTnklIUCin35scjIqtjU8EM8uiDq8ggyl1l/2xhU
	SMD9KS1Q=
X-Gm-Gg: AZFdTZfGrkd5qo4LMCW5mKjTwYuDrS2Dm7/H1pz0yMS4Es/LjT+0BxhaWd7/mYq6EIf
	X/NhMaAjTfYRxq9eo0hHQBsjmb7BqwLNlAweoLtN5d1K4ebf6jObnDdyhiqxhHeznyS6niuYEI6
	/wyyYLZr4YByub8DREnbZNG6QC49GjaBX6fdSWVXZhtawdi5gVexAVZ1PTP0uozWTvlPuOT/6Jz
	62ofwa9baCr/kohEd/tnV9cCSdMMbLMjLtT8pYfP9qElvpI37XBPYD8dwFM3kmgk/1LFEgW68dA
	kaoJO0oxRD7tlZANFrzx9uH45PJSd/EYpQvQchS5g3Pyxx9gMb/4m7q7q0gbOKEmkOkZGY1EpXv
	xSQZZGlj5+YjX2SeqiY+tcMJgCYHCU4OBz6MZEYy4f46kELoOWWiwYqKYB5Oh9iEoOYjm3hZl/I
	qDaBkzy7RDiPFB/JJDDxX0SfHfU3ZwRYLchpPuBaLPEhWmSg891w6itlVAvg1p9cONQV1EocO8v
	vnb9w7wxh9l/giefMqpj/vXo2mNetLYKEjBlsyds/GJ/yTucne4Dmci4WtOY3J0Y3Kl8V4xfnQc
	NYi9Q8BvwEnuHx5sgkrL4Y8V+97HNBAjAgbmLANIutEHsEBkDGNJCElK3NTE/2GCL3EDfCG8fs7
	V84w+uUZhQpvHILzbCF5f/7VLRLGHgA==
X-Received: by 2002:a05:600c:4f84:b0:4bb:8701:a2df with SMTP id 5b1f17b1804b1-4bb88809950mr574385545e9.17.1795884898357;
        Sat, 28 Nov 2026 08:54:58 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:58 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 12/14] tpm2-tss: Upgrade 4.1.3 -> 4.1.6
Date: Sat, 28 Nov 2026 18:54:30 +0200
Message-ID: <3d8f168f56a5f3b7653c6c2b99478a04ab1f1181.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5582
Content-Type: text/plain; charset="utf-8"

Release notes:
https://github.com/tpm2-software/tpm2-tss/releases/tag/4.1.4
https://github.com/tpm2-software/tpm2-tss/releases/tag/4.1.5
https://github.com/tpm2-software/tpm2-tss/releases/tag/4.1.6

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../tpm2-tss/{tpm2-tss_4.1.3.bb => tpm2-tss_4.1.6.bb}           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-tpm/recipes-tpm2/tpm2-tss/{tpm2-tss_4.1.3.bb => tpm2-tss_4.1.6.bb} (97%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.6.bb
similarity index 97%
rename from meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
rename to meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.6.bb
index 30e984e..8374993 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.6.bb
@@ -11,7 +11,7 @@ SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN
            file://fixup_hosttools.patch \
            "
 
-SRC_URI[sha256sum] = "37f1580200ab78305d1fc872d89241aaee0c93cbe85bc559bf332737a60d3be8"
+SRC_URI[sha256sum] = "014b147c8f9659f18c195c3ca7ad164323e8f72a51a337b1a42dbf4e95b1896b"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-- 
2.47.3

