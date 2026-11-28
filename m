Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9325.1795883256187510805
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:27:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rdcEabBj;
 spf=pass (domain: konsulko.com, ip: 209.85.221.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so5646312f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795883254; x=1796488054; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m7qPgtzE6FT2q3pW/fCknkh2eDbw/ORVF8LIKJE4uyo=;
        b=rdcEabBjT42mFkdu3AIk70+BQ/obs6eMdPZszJsa3jrBuT/dQKkldqSHXFliWdjYRq
         KtRm4Wl5mmg0EFftj/GfPXS7vVxjk8PwSMvi0ATWdXlPfk31uvTcI7WTtBNmWI+wXKIg
         xw3DDaFGqk0hqkdK0Zt7aaG4TGMmQpmgnh7WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795883254; x=1796488054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m7qPgtzE6FT2q3pW/fCknkh2eDbw/ORVF8LIKJE4uyo=;
        b=nE8nS5oKEPLbhcyw9AGVIzvf5Xboso3eAnx52WmaH/RJyLbTdAL3kzXtZ4ZAMvkBAv
         ZKahF3EhbRtQqtwLp9N1peGlx0WsqUPWD1OYLSe58C+S8IAtTp7AHeBMPcfc3CxYIJch
         6ZSlKleaYDvNUsdubk8xXQsZ6TaYJusNtmCdTyNCTLrYNDyjglh5sECTmxmcrGXd/AeJ
         zPsqUmvJiaXi7wMll88D0/Lv+B8Z0Yj3klI2w90h7+UE9urG/lXqbtuzVffBgVbFNABJ
         X4Qcg5ehRPpCKS59NiEVu+uu6y+FogqqA5Z+Qt0Z67xjWf/scIEwNxtKgfscfpJuNKsv
         +zJw==
X-Gm-Message-State: APuU4Z9QCtp+PGV+dYoY4VoAV+lDN71DpSY3Pdp+UtqBzNkWyt6w9Xp7
	Pks2AnzQg0sK29UjUFZGg63Fk7xc/wc8Rg7mRMsfYClRvzkyxRF6kcpfDHKXLdFsRZ2eGRefHIb
	6wVV6e/s=
X-Gm-Gg: AZFdTZe88Bt5imM8Y0PwBv/mVdXDW9MsgoOojrrPe5kcMLx98Dk7OfU+UqsRN1o+D9A
	INSYqvC9ST6uHD3sM0HAMerQW5rgDf3HQmJbt5Cpj52n2Aemo2+vUgmKRCFuFWWFTsdCAq0Kjn4
	xMy9OQChs7xJlXqsf55nlhD43oFMcwt/DqvoNgLANxJGJWVtLhCd9F10xAAxs0jx8WxB8gpkp+N
	UYwzt2Tg9cyM+UaaQbZ9erNdWLP4MaS7GHnnqVpqQHTGFW8ouTWNcBvauR8BElup9ufbR7YklAb
	w8RUwRPFxz1hnYuPNLb6844ikZX8wSI/ndergT28IZEhOrIY9zOJRphXAs46GMNNRwFz1ERSFzk
	69z7/12Dqhb5wKsEow6of7zUIc9QqGmb/9+f+Jl37f/SNPqJPfrcTEDW/QP5jed4oY8ZcCMt2bE
	dI3Ygc7zJkJVo+Ub2j2NEk684/XNoBRXNf8bfCeFimbVVH0WadRGuroeNvSemaci6DQf7iqX4CB
	JWZs1GR+a6LuoAEPAAjBO5UQhPhPrhChUUodKlQXOKuhEeHSnQKWWJTVG/PGDd0cIL+Oz4wASyd
	QjLdmED4klRXb0OdqpLLsNUjBSxwV+ODIFPP3RVlOoZX3PFu0oLqriCTXMmDsB/V97MtIPPosjk
	/QVYUbz/LlTXzaE8ITFr2N88srkp81w==
X-Received: by 2002:a05:600c:64c6:b0:4bb:6a75:d04f with SMTP id 5b1f17b1804b1-4bb88807d96mr538639885e9.8.1795883254265;
        Sat, 28 Nov 2026 08:27:34 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm529202045e9.1.2026.11.28.08.27.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:27:33 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 09/10] sssd: Upgrade 2.13.1 -> 2.13.2
Date: Sat, 28 Nov 2026 18:27:12 +0200
Message-ID: <8d57c9cb2ccd5743796d8fa869f51c264731d957.1795882913.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795882913.git.scott.murray@konsulko.com>
References: <cover.1795882913.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:27:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5568
Content-Type: text/plain; charset="utf-8"

Release notes:
https://sssd.io/release-notes/sssd-2.13.2.html

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../recipes-security/sssd/{sssd_2.13.1.bb => sssd_2.13.2.bb}    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.13.1.bb => sssd_2.13.2.bb} (98%)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.13.1.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.13.2.bb
similarity index 98%
rename from dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.13.1.bb
rename to dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.13.2.bb
index 1e71300..303a121 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.13.1.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.13.2.bb
@@ -24,7 +24,7 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            file://fix-ldblibdir.patch \
            file://musl_fixup.patch \
            "
-SRC_URI[sha256sum] = "05ea79e89f0be399983925b8874ac196d6dc5fd4416f83609557b9fc8ef798b5"
+SRC_URI[sha256sum] = "449d2e69dfc7fbbadaf971514561482abdcabd08014ea942323a28862de9f328"
 
 inherit autotools pkgconfig gettext python3native features_check systemd useradd github-releases
 
-- 
2.47.3

