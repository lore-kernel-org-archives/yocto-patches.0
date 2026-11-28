Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9702.1795884899467667036
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nQlWBiPz;
 spf=pass (domain: konsulko.com, ip: 209.85.128.52, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so95591375e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884898; x=1796489698; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tIRv0M/1H60RyWvEvndiD0zWuu+7We0vutfL9W644A0=;
        b=nQlWBiPzdF4fbIET5gNwk/tNCQHIH9elFwSqCQTUaXlrF8xS1QDHtWOYDPEc6qcJnT
         /WFqpO8ycXlmMJGCFkhFxHEc+Y5gJGeBzT+IXUgtR7swrumh4N1mADZUZwQCsTs8TRe0
         GRFXlwviXqjRgLCI8a52f3pRpvUOTVB/2NRRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884898; x=1796489698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tIRv0M/1H60RyWvEvndiD0zWuu+7We0vutfL9W644A0=;
        b=Pcpahg1ej/8BvujplFWYtQxcZ0anTk5ZSv0iN+nWhMO+IuyIfOh3pwS80C/DbSDfQ1
         RN5iDwOBbEHHc5jhWg8VHr8wlpWG7G2xwygKHBI/YGBDECb1lJdoT4Mfaj9i3AJfNY4N
         9BduFVZfkO3674r8ghYFdh9greBBRn9uPDMQDcSDqoQgAeySGLJC1QnE+YLwBhvDAwiT
         VvVKrGnzMdoDgs458CPM4ur0rhdRL0mR+PXWMN3sGoqKaZc0c3zwg7r9s4oydMTFY9t3
         kkoQOiVJ4ZvM7k6RKKsBocVyqu6YwJyQ5saGo0N3NU0SFcMrVBEF82Ozl8SfTvi0yJ6X
         IitA==
X-Gm-Message-State: APuU4Z9GwP1tME3EMIbMs0JPYsY9zNhGmzcZiCNfM/4YdNomdKS+vadI
	iDwVK47amLpTLhss6sWU8GZTE6Xg7raAEQGo9fH1IF0supm37wtdKwFLnh2bGC7sGgKSvDEs8qW
	T4c72Qt0=
X-Gm-Gg: AZFdTZeNdSnGXaj2h00Whovbi9J0y1LzWB42C9sxHD40BySHuqFbIH6c3GWhpgnyG2Z
	/RSZFkc4Gv2rGNubt1lqXdLV+4KSAPKM7+vuKfXZ+JVHHwYOh+qf1uf8sr0JVJqY8z0QRb+LO46
	SvZza5f66BWCTZZ86pvhznS3wW5UuYbXl7cKGH3ybU+IzlhmYU3XC9t1tS3N6M+SdwFHsyYrKRZ
	ZlOmjL1xF8ONlj/YyNr4ytSjKBrhfBqSf7g8ODSA4OvmoWW66GgYLeXBfYQhE6S6+wWIxtmvnKN
	rcmaG25bsGE/stCiU2F69t9YSv0stf9Cx71g/1MQB1QoNbZcP95X0xTe/32t9LmwMamcapWnOTE
	uBz0T2qNgPCEawzZAgwFsVRCluJSD+37eXl5KlZHZYDS4rbb8gMoSyAeKl1TVEHCk5YicFtiSGo
	/8yjo0pmIYPMCOSyoYfKH8LGguyOiaBbu50Mlkm34nmgJyji/j3thLmc2XE/cYIb0tyOFB2RdHM
	ay77vG5HmRy67rpOmMxh1j491VeTiiVogtfflkL4VWCB19hZhypEKnVFBGXFhk0q1zS/lPROOz1
	bSjio26e31bUgVtgYWf3xh+1NqiGjM/o2HwwwK7OFnmLDSQuQitUKrc9oeUbNhbAlo/vpmHrhRa
	nDqM4hsQQ/y6oG99IOrhisQc4GOZ1Vw==
X-Received: by 2002:a05:600c:674b:b0:4bb:6847:791f with SMTP id 5b1f17b1804b1-4bb8880f267mr534886705e9.7.1795884897654;
        Sat, 28 Nov 2026 08:54:57 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:56 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 11/14] python3-suricata-update: Upgrade 1.3.6 -> 1.3.8
Date: Sat, 28 Nov 2026 18:54:29 +0200
Message-ID: <82d749098eef6c8f0f64af725b216f08482269a5.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5581
Content-Type: text/plain; charset="utf-8"

Release notes:
https://github.com/OISF/suricata-update/blob/master/CHANGELOG.md#137---2025-10-31
https://github.com/OISF/suricata-update/blob/master/CHANGELOG.md#138---2026-06-30

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...uricata-update_1.3.6.bb => python3-suricata-update_1.3.8.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-ids/suricata/{python3-suricata-update_1.3.6.bb => python3-suricata-update_1.3.8.bb} (90%)

diff --git a/recipes-ids/suricata/python3-suricata-update_1.3.6.bb b/recipes-ids/suricata/python3-suricata-update_1.3.8.bb
similarity index 90%
rename from recipes-ids/suricata/python3-suricata-update_1.3.6.bb
rename to recipes-ids/suricata/python3-suricata-update_1.3.8.bb
index cdf2faa..0b2f9fe 100644
--- a/recipes-ids/suricata/python3-suricata-update_1.3.6.bb
+++ b/recipes-ids/suricata/python3-suricata-update_1.3.8.bb
@@ -5,7 +5,7 @@ LICENSE = "GPL-2.0-only"
 
 LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548"
 
-SRCREV = "f76a61bdee69961537585a1036c4294da28495a5"
+SRCREV = "c2687bbfc1d3bb08c569313e7bd6b178d0adafbd"
 SRC_URI = "git://github.com/OISF/suricata-update;protocol=https;branch=master"
 
 inherit python3native python3targetconfig setuptools3
-- 
2.47.3

