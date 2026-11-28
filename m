Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9324.1795883255416193585
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:27:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DvYmfDMN;
 spf=pass (domain: konsulko.com, ip: 209.85.128.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so34481225e9.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795883254; x=1796488054; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZNMwuSY5YR00I0Pj/+6LAlIDoCmZHgA3e7P813IzmV4=;
        b=DvYmfDMN6lqgM3HTixH3w/Ee3e27Rm/2UgJWlAYtwbbwyXydTKOrr1DOfdxPNtbT0l
         LFsmD2sMPXD4wSVP7CMScVUT6lpCS7skRj6/WNAGAYK9wMygRBlNZ1PCs0rPcEr1FpcI
         Ec7F2qLXgfRY19WDZBBxHii3iAna6RDoumLTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795883254; x=1796488054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZNMwuSY5YR00I0Pj/+6LAlIDoCmZHgA3e7P813IzmV4=;
        b=fD9mu1kzagjmz0l/eeDmVNCo/MZjpcNP03wYmreB0Kmbh4t4W56RLzDxAl3slNyT5x
         xeP0slBDeiH7pM9nfwzUhH8Y5egV5XKE0q/9p6gNDqvmWATQ9aNVk5GRIUyhakqXl36N
         mCVkME/KpTC7a9/sh+BS5U44HjAEigdPImO1bRj588LcmgxI+A5HrA+uZx6N4fR+Ik8s
         CblsZnK6tDLc8zJc9dUsZft214mUJ2KH6wAN0cveSbwSmLfczU4MoKOwury26EzKhOQp
         KBmEcQg9CfithOr9s23LQtIxQXOWI9omAh0LxdLEwB3xUXwvA2dr3zvoWExAfehFmTJb
         z2WQ==
X-Gm-Message-State: APuU4Z8YBPWgPgwIoojubAg830zFT/dFhFvFDRHBYj6+xLkXhT2tVESU
	8FcLUOVnwNUTPPGoZGxVTRaib18D53cXz+Hx1KD2jqOlcTngPRzE3kpoVlbFQqE+e5GwyPHEEpd
	U15P4Np4=
X-Gm-Gg: AZFdTZeHqpf2thH8lw3wp5QmKjgQod4h9Td6vdrZT0HefuLC/VUz+Z3H/p9cmBex5lM
	7dfEZhJ+SmokCGKRHHlTDH/lQiR7olvxGE8XEu7Nlp2BmYMP0X4aE3Pi4Nkc9dUA5vxm1IVxyFv
	j54jr1ic5PYtpeqj/0mx4RP6bnVadqtZ2S06IiHJHdyiyGryCpQJX7jqVjGU5W07hCwQDo9viUb
	rXCM4jaZetMvi75a18r0SLUXFnkNRNKn+42sdsbAlhvAKbxDAFP2c21jsYwI6OZG7eucs8NUrig
	SCZMAbiWqA/uENqi1s9rS+sswBBAk+DEBm8YyUqY5q2+sI5jiJA4yLQPAP3WHK6VCoolNdzFdeI
	H/k2tNELqJC18jCtTHxmXrdfB0lXm6DOXv4bM/2PkpNXfcvKl9jttbtwXaUYcYFOvq5CxGFiU2o
	DVg+5z014ctDgklo6/XDOePWZqsNKvkqVnInh50jsgwgdgveWYTxM/Vmui48Y/DUSc/nHheYc+F
	xse4TMKG/3Tfh4ErxwRcT8pv5hyQxDTjGFfCpi2mausx2LBmAUAamdm/aMk3cB5/Ks7ibOATGx7
	WT8+EDtnPBX7xFSYMP4pVOoiMTqGe14t7TlyKBTaA1rf21qLVZ0gAhdYtuFU9dBN5aAfiGODAH0
	m4yFjQgf4mkz0uwUSjk/iGXZU7Qm9g3c=
X-Received: by 2002:a05:600c:1d0a:b0:4bb:840c:72f2 with SMTP id 5b1f17b1804b1-4bb889323a1mr554298025e9.25.1795883253507;
        Sat, 28 Nov 2026 08:27:33 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm529202045e9.1.2026.11.28.08.27.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:27:33 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 08/10] aide: Upgrade 0.19.4 -> 0.19.5
Date: Sat, 28 Nov 2026 18:27:11 +0200
Message-ID: <0668aea803db2e77045430f1e3b318168a967778.1795882913.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795882913.git.scott.murray@konsulko.com>
References: <cover.1795882913.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:27:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5567
Content-Type: text/plain; charset="utf-8"

Release notes:
https://github.com/aide/aide/releases/tag/v0.19.5

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/aide/{aide_0.19.4.bb => aide_0.19.5.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-ids/aide/{aide_0.19.4.bb => aide_0.19.5.bb} (96%)

diff --git a/recipes-ids/aide/aide_0.19.4.bb b/recipes-ids/aide/aide_0.19.5.bb
similarity index 96%
rename from recipes-ids/aide/aide_0.19.4.bb
rename to recipes-ids/aide/aide_0.19.5.bb
index 9cdd601..84f210c 100644
--- a/recipes-ids/aide/aide_0.19.4.bb
+++ b/recipes-ids/aide/aide_0.19.5.bb
@@ -10,7 +10,7 @@ SRC_URI = "https://github.com/aide/aide/releases/download/v${PV}/${BPN}-${PV}.ta
            file://aide.conf \
 "
 
-SRC_URI[sha256sum] = "47ab7c696f0745911479a41f90d7ad99d26536e186d66c4aad093bc72d20ff5f"
+SRC_URI[sha256sum] = "6b004557e9493048ceb5fa84fb44b904c16e23bed8850dc21316e7c44247a350"
 
 UPSTREAM_CHECK_URI = "https://github.com/${BPN}/${BPN}/releases"
 
-- 
2.47.3

