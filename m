Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3580D2ECF3
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:40:23 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44336.1768855218199890243
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:40:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pXfTs3h9;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c5386f1c9fso716115685a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768855217; x=1769460017; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqYtpc8dgicxM7a0kHrtnQT45FuX8uQ+kyTn8yU7hgw=;
        b=pXfTs3h9v3oByKQF4AUeekJbRx4Or02O8dONVTmSI3yib5v64HnSO9DFGXYxFhxb+q
         JT50UD11tZgp+0FcGIysbBykJlT6zdjuWpHkQpwZvh8X4LLbRaZHb9/PDY4yqVI5rChy
         oEkfjdUA215Wxjk7AFdsGV6fwpq59rjJQ6pPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855217; x=1769460017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oqYtpc8dgicxM7a0kHrtnQT45FuX8uQ+kyTn8yU7hgw=;
        b=I9KQ/6kPAQSK1YnucH05+jyZJUXRUQ3X9t6p0BqVQrS7cwc9Sgzq3FvD2km3Ah2+oJ
         p9yz05N7icxGusKiC3hInzbV1tTm/CxJjpguoYG8Dj3e2NOLtJt7OmlKLiceVejr2jiZ
         SyLHvuH0W+/AcTpFwFtsJwgErwBZQDCOUVcLn5LwHAl4BJQl6/VE5wl574e3MSuz+lDD
         byxyf8R4UiYa0uznVELDARzqTMtyeQ9hY7pO+5xBJuQX8h3TVYJTp0ic4tDsKWsJw1Cp
         b/VrwpBZ9EZ0VxKLEext8NiVFX8fOsXY+MeH+9E0U5hZTXocm8nxC/bJZ9n05wL1Q1Hc
         cIvw==
X-Gm-Message-State: AOJu0YyW2QIoLoe5xYmSs/lwxLvQLcwHBAX9fanE2SNOlhkyEClBtguu
	nO7qiAN6rSo+xILtep+wIZ0mNj2Aq5KrOTDe8shzRSJCmz2ZD5rb5JG90r42esG5XWPNq786pND
	6ROZK
X-Gm-Gg: AY/fxX6+YVqSu/SsMpKyxhbGSpBkn/AKZ180kZdAye5M4m74WaO9kigWeRuNbVGXB4F
	hAUwfgW6woDlMZUW9WQf1zOGmRuH9VsW5OnH8QiBXq82q6HlU16TlQFqbZOY6joEDZ77iYqafHZ
	HtGt6RmXpcHChIpOXwLs0KqejjhIz/Mu268T+4lXfWwkcTHBUmUda6EZc8/S8OhT3+mmh3q8+Wh
	g4ruwNYldvImnqPAHXYlLHUiRhmji8McZQslDWFKHNkICgTUQCyokZCqKq2sAU3+iDMg7m572O1
	07VB+FYOiDYaPgnT/2ipT+28ivJNEqMK85WwwzqD47hVGOnZfEvtJ+TBCf6o72lrhX4W9q8X/V+
	ScjspJcQGETf/bEjafwCpl7wuwI6o5tyVDdFADxaQpm4u0T2FAa6ihjq01PIL1C0ZQiZeHyk4BD
	VGTJWUDt7FVa5WhvbAxjCPeQuAmtgijchoGAMXo4MFqg3yosNuKS5+NOu+8txo8B/uT1HYlR8Cg
	gB95l3tz7ZGaGPcc3cUeuRkwoLK1FZUApMYdoGV1Hf4gOnxKadY
X-Received: by 2002:a05:620a:1991:b0:8c6:a539:55d4 with SMTP id af79cd13be357-8c6a695607cmr1565379485a.48.1768855216913;
        Mon, 19 Jan 2026 12:40:16 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a70f1fe1sm851462085a.0.2026.01.19.12.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:40:16 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][scarthgap][PATCH 1/6] sssd: Upgrade 2.9.2 -> 2.9.5
Date: Mon, 19 Jan 2026 15:39:56 -0500
Message-ID: <e954c09eaa38f5a36b24f8a7be7e4a5b51e8fa4b.1768854779.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854779.git.scott.murray@konsulko.com>
References: <cover.1768854779.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:40:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3025

From: Vijay Anusuri <vanusuri@mvista.com>

Includes security fix CVE-2023-3758

ChangeLog:
https://github.com/SSSD/sssd/releases/tag/2.9.5

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../recipes-security/sssd/{sssd_2.9.2.bb => sssd_2.9.5.bb}      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.9.2.bb => sssd_2.9.5.bb} (98%)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb
similarity index 98%
rename from dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
rename to dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb
index d61471c..cb27675 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb
@@ -26,7 +26,7 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            file://musl_fixup.patch \
            file://0001-sssctl-add-error-analyzer.patch \
            "
-SRC_URI[sha256sum] = "827bc65d64132410e6dd3df003f04829d60387ec30e72b2d4e22d93bb6f762ba"
+SRC_URI[sha256sum] = "bf955cc26b6d215bbb9083eadb613f78d7b727fb023f39987aec37680ae40ae3"
 
 UPSTREAM_CHECK_URI = "https://github.com/SSSD/${BPN}/releases"
 
-- 
2.51.0


