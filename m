Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2410.1794860559208557522
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 12:22:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=VjoCkcVm;
 spf=pass (domain: snapchat.com, ip: 209.85.128.41, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so24484395e9.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 12:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1794860557; x=1795465357; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HncfDU/Ly4sgUUys6YDueMl5X/w+4ldHaAGUQwfOMGQ=;
        b=VjoCkcVmOT9Y/yg1cwCbvWop478GI0fAKxKNknf+hWT+839M8heEACd+5JiDemWXMv
         LiHLOmSP0CSL/bTpIWWBhEC4ud9LtErxLvwXaOT/Tj722I1Rwy27Tu4qSy4g0bmoo7jh
         IAEgndfaOzVDhPwWqhUPJljIXUt5YWo7atXYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794860557; x=1795465357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HncfDU/Ly4sgUUys6YDueMl5X/w+4ldHaAGUQwfOMGQ=;
        b=kf5n3ovB9F/q+GlhV8FXcH8dc7+dinNPcFgxm46Ne36jbtBXpoLC5MLVzoweGP253c
         a1/Vb+6amGWwopBpEmN/ATeT3adRNYdix3u0Ip6z6KyQmv/h9PJwZ7eHOugJX5pvBB2Q
         TGmqNnXWPj2LlFdTlG9/PFjF8vzdAf5cDMbBnM3JwehRM/bQehb207pUJ2+imoKKxJ95
         ywKkID7SDWkFRv9+oPVnsDtGNBZ+rsAEHGUR6ck6dxJPZaf5zCdbugzhjbUjQqMTTKAh
         dTyBM9QyJFRrFl9mcVynlYRc7+di2hUhhKiEIukbhDgbh0u3QOPW/LcvgctSXfqs90rF
         ev8w==
X-Gm-Message-State: APuU4Z8OLJOJKHeaUBNX4BkxmM10QgZjEqOPd1HLMtoMemkELLoeHMKq
	ubyJwgDVqgRE80cmHl/ETjWQTLCp2vCMikwJXSZB4m8TnjES10t/n+z+sa/7JQfk4Obyjq5vRPS
	+Vtrs4zE=
X-Gm-Gg: AYBFou0uciF//rjsaqjgDpqVEdlBzG5GnsGeP98tj/iYMpnqaMKRxO/C+VnBE1CnkjZ
	WXaoLM9Ynlf+x7aQcgSsq5bUQZECy15g90NE782NnUMT5JZwLVdzJim4NAGDAqbAA1yQAAOOEsB
	4si6nZtw+2N7izVq8tzfMwoRDjbpS1TDnld5+elfN5BiClj+QJAyTSJ9CHUwAg+yCpGhxN7NSG9
	2TOTtuiXTtFYnmhI87NA0osq+/47BUWugYt1PBiuMpyJ7DU5urR6sKIoF+ka30akFv76R27iVEU
	7irhaaZ/WIvl39Xv2Of8XzdLXYUMmGXAroh9U1jn/TNvTOZYV4jGdTwHnlnQr3+VrSqYBaBaaay
	oFHUMNIQbpTr6xgRLHuKaSc+wbN9pAe/z0A3UScmyjPuzQi2pQY74ILJhQY5YlJQhy27G4MPRgo
	DIq+f6feMbZn/9XIhUIy//BmJpKtbY80M9RsXuQ++Mi20sa6MkFyrqgSl86c0+Lc9xciM0yp9BI
	hzbVveiYEVS01C3xTuL3cDd/WiRBmFWZmPLV3XerIzgbkNkJq6IMmRsCeQRe/Qc/qVYdFrHGcAf
	sNzcCY2jJZZYkM09kKpll1lmYRM3G/SvVFUUFf4hvkYgofDc9eIBi9qmR9y1zuC4wsjmkwtragi
	7Bz5ZdEsLdI0tpsRzYQPMaaTl6MP3mnslN5snXt8jTyjHEyInG76Xgh9HbqpFPUfEVhwY6ZbTvZ
	I=
X-Received: by 2002:a05:600c:3114:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4bb55a5d457mr260348225e9.8.1794860557467;
        Mon, 16 Nov 2026 12:22:37 -0800 (PST)
Return-Path: <ecordonnier@snapchat.com>
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430918sm10724165e9.13.2026.11.16.12.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:22:37 -0800 (PST)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 4/5] curl: pass -F for the Apple frameworks on Darwin nativesdk
Date: Mon, 16 Nov 2026 21:22:22 +0100
Message-ID: <20261116202223.654-4-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116202223.654-1-ecordonnier@snap.com>
References: <20261116202223.654-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 20:22:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5423
Content-Type: text/plain; charset="utf-8"

From: Etienne Cordonnier <ecordonnier@snap.com>

lib/macos.c uses the SystemConfiguration and CoreFoundation frameworks, which
are in the SDK runtime tree but need -F.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-support/curl/curl_%.bbappend | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 recipes-support/curl/curl_%.bbappend

diff --git a/recipes-support/curl/curl_%.bbappend b/recipes-support/curl/curl_%.bbappend
new file mode 100644
index 0000000..3e5ad39
--- /dev/null
+++ b/recipes-support/curl/curl_%.bbappend
@@ -0,0 +1,5 @@
+# curl (lib/macos.c) uses the SystemConfiguration/CoreFoundation frameworks.
+# They are in the SDK runtime tree but need -F, which nothing adds by default.
+OSXSDK:class-nativesdk:darwin21 = "${STAGING_DIR_TARGET}${SDKPATHNATIVE}/runtime"
+CPPFLAGS:append:class-nativesdk:darwin21 = " -F${OSXSDK}/System/Library/Frameworks"
+LDFLAGS:append:class-nativesdk:darwin21 = " -F${OSXSDK}/System/Library/Frameworks"
-- 
2.43.0

