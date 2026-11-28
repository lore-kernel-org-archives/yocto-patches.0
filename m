Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9677.1795884902432927648
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:55:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FhPftYoL;
 spf=pass (domain: konsulko.com, ip: 209.85.128.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso91312395e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884901; x=1796489701; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m7qPgtzE6FT2q3pW/fCknkh2eDbw/ORVF8LIKJE4uyo=;
        b=FhPftYoLg/A+sj/PUxloqHb7Z2hvDdsDvEBNpbK2gd29gwWwE6vUesBpuCSaDuVKOs
         l4wFZuoqgLcP2Xb3fxHIE5IxSNsH2ZbjaJX18EOs/o554U4Dchn6sn3N/RaunJJIeGFR
         nYp4qXApDARjfAmIblB+TVgaj39Y1rYHo+8fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884901; x=1796489701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m7qPgtzE6FT2q3pW/fCknkh2eDbw/ORVF8LIKJE4uyo=;
        b=zXf1MYqXqudgpC6QGXv5zMTaggCtgqQEd+AqX1kJSUBmI2ryuy9aBisP+9hilFsjrH
         vCYnRw8hBK/l9GXWPntJwJsUo8CSPY6zmW7ft/2el1cD4r5qFjaBkh7Zgjqmt3oxREbn
         p4RC3Diwky3vKCJEU5Wob7Li+EuZNOPmMoE770WzYSYYYlr6kNNrcJZE3aPXe8stsGXr
         Q7rvG606vzgh4mdqJhoE11D4qW/NeylDEVwwEn5/7CBnd2PMaUJmBBbI4IFL999Ftpgg
         9P8Ao9f8dvBJj0hmCVf+2HV5Er42vfPVEcybw4cXewOAWlU7POLKhmHHgW4zFlSoLwhk
         Rz2w==
X-Gm-Message-State: APuU4Z9ylJNF95aTLyhhIBVj5dNBnAcAekA5vEB+sJAYD8Ohi3EC3sg/
	zIHTHDOy5+kwvKa6RDdivY75W9RtqRQo0vUe1VwMC9+zzvx354mWXPWIvMRNRWjnZosMwwcL5Mw
	5zkbnIqc=
X-Gm-Gg: AZFdTZdm+XrRMz+DECcYt/8DlBobVs/LQFQm/Lm/dGPxhooaR0Wk8cs/81fvvgFzfbE
	i2d1i/PNwOMjrGO1Eh5aLOSWpwu5pYdES3wnOBoZV9rk/26eR5iY/SnO6ZYFLsosifcd3p7SVMW
	m/4w32OHQhZ1IOy1DG7kdPzhRxcLDGNs6dDVqyXOwqLcFJpAR3RlhS8ZhdpF4C7jNSqxlJmjT3g
	k3Ixx7QBHazsn9mW243Du3M7leLF8gAULmp4wUfbBdebndjsp771DO9s7jZVHc+St2hC4Ae+ceo
	9z6sVA9WF8Jlv5tV0oB3bA/4Ff94t/HpLuUqZtZX1PaHJ3RYEeBdKMzJknlxQHdlCM7eonNyZ/J
	BljU7s+Afo7uWNaf15xBjBiEuDYaRhUFbKCIpU5F8ShK3sGeLhvARX3COfrRNBF9Ae2kNQ5QhRT
	14tiJD2UMvyawfFB9xEBfSb5Eg5qOSVbJJWEzJF/XqPDUf4KgmwrVyNAp3HEF8Hgp3xapa6mXul
	8G9hNNzIML//rq5JI/xEMLsIIGv5uxxhCEzCgfOmX6qPiaR25my+Mq7GSPvHhDn/OF+4mj6tv8n
	kNCfF897shRTS8vEd0UuhwlhoKe6VKOYraQQKPAgxQYcx868S5ZQjXBFppSVK2dl4k7EGDMo9Yy
	jFmNKdPizaKrgoV5Y2iltIZv1JR2NbGGTAysLf1Ya5KQbkVmVFF4=
X-Received: by 2002:a05:600c:3ba4:b0:4ba:493b:3401 with SMTP id 5b1f17b1804b1-4bb8880abafmr676859815e9.9.1795884900501;
        Sat, 28 Nov 2026 08:55:00 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:55:00 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 14/14] sssd: Upgrade 2.13.1 -> 2.13.2
Date: Sat, 28 Nov 2026 18:54:32 +0200
Message-ID: <3b3a25cf5d2dc252815b182daa0dbd6c9fb65d91.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5584
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

