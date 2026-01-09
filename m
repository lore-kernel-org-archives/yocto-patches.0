Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F554D26D9B
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 21:49:52 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21297.1767995382310590729
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 09 Jan 2026 13:49:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Jn4WA8+t;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so36067745e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 13:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1767995380; x=1768600180; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ERR6NzNQS7Eg6p4aQUfL2EwKvldglJy3l0NyasSwJTc=;
        b=Jn4WA8+tkam2I4IwW4s8linUtGQW+8JFal4bxmROaDU/Czp5bSfSB/dldIDN06WgtX
         srjDSbh89VMypMdpAKdnX7+3YtqaNd7UbE0Yaek5ubSJ1QfnRVPajrXJ70Ip6KmMUNcQ
         bW7iLNy6i1/M56+wFXUO/J7Et2RQizrCWMqrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767995380; x=1768600180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERR6NzNQS7Eg6p4aQUfL2EwKvldglJy3l0NyasSwJTc=;
        b=wC7mCq8r2CD6frrtTa9qdh8Bjufd6D7681TZtKD6+8/OCv5EC78u3xvHkGC0KtT7fJ
         33C/p3/ay/FmyryQe8E2rnFUmR4uA+q94LaPVBezcegZp3gtGHCnUX8PByyYN90HjQd6
         sl1DRqi2HpHQxqm6y0FX2O63gQBNYHC/ikVwqotTjSe3Z8rHKB7Mfk9L7hHQrFaU3BAn
         XJ80Pcj+uLFVL3gkKL/LzpbXWN0bC/xN257Sa4ve3Ww4jfNfcYAQO8nzZ7PHm4w1EV6Q
         g1Aq3b8Lff7b1u4Wlb3tcAw9v09+Y4bBh1RRJ4+pQ+cI838LFfJ4H6WsmJ4pkbFrpXmo
         Jv2A==
X-Gm-Message-State: AOJu0YycNqg2MRzVU+66VSuO+p+tBONEh4CKoeJob08ZqOHwW29qQ+s/
	5Zu3g9i6mraNkDkj/bG8QmIeQnbEB2JzcDt2qfhvWip3TU5eZ/yqbXZnva1AVcXWC32pKxhnvoX
	ATamO
X-Gm-Gg: AY/fxX4qgCHYmKvzuDbZ98lRY/NetjWQte4dJ60tC8980DpaE25uHXucwcQL2i5WMDP
	TdvmAVlghop/vDBF5z93PUonn/BwLhjvxjU+b0CibrWRcyfzhwd1EhJS4AqAXpGrljb/3dVVODc
	7YSmFJAa0FEeHLrRHrkT+PDRZaY3K9HpMk9ZAsNXA4yQmyJvdeB0Ry9cCDTvHAy92dxaukGIwKo
	h1Q+xly8OWVmCWvd5qJcCGSMKFvR1JCT/D8lzFF++LdENPIL01OC3PhrTn/gcWlbNzkbrXqM6bK
	fQ6i9G3ptuaSBSFoj1IGekAn/eQLq8yj+tAzRrTwXaMnDXerFjLgQSj3f+tgdfDKVUGYAUJZ4Wc
	9YFHgwZGqOtJ7tIpnkoaZZ4P2W4AEU5LNxKLo6wG0q+y1XBcsgWiZlsCUOh6dXp2kpcVKqBrr50
	qZM5QWei/IZLcgv/aLfjbQNLyMyETD6RX9MBXXfbviLpXZ65Qgq/WUPa+zmHTCiF9D/j0SO6LXo
	HHak5GxDU4hudBC
X-Google-Smtp-Source: AGHT+IHB7si0bVmi6FmIqlDgk4oS/GXcRzlat1t6VO0n5+ESuGXj/dCVUYigU1YYM4Ee3kTCTqteSQ==
X-Received: by 2002:a05:600c:5391:b0:479:3a89:121d with SMTP id 5b1f17b1804b1-47d84b614b8mr126084825e9.36.1767995380355;
        Fri, 09 Jan 2026 13:49:40 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00e75da6c4f7444a1e.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:e75d:a6c4:f744:4a1e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717d9e7sm69014735e9.8.2026.01.09.13.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:49:39 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH 1/2] schedulers: Add whinlatter-next/-nut builds to the branch selector
Date: Fri,  9 Jan 2026 22:49:22 +0100
Message-ID: <20260109214923.435527-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 21:49:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2928

From: Yoann Congal <yoann.congal@smile.fr>

Those two build setups will be frequently used for stable maintenance
work. A shortcut is appreciated.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index f552467..85e0be4 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -82,6 +82,26 @@ branchdefaults = {
         'branch_yocto-docs': 'whinlatter',
         'branch_oecore': 'whinlatter',
     },
+    'whinlatter-next': {
+        'reason': 'Stable maintenance - whinlatter-next',
+        'branch': 'whinlatter',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.16-next',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/whinlatter-next',
+        'branch_meta-yocto': 'contrib/whinlatter-next',
+    },
+    'whinlatter-nut': {
+        'reason': 'Stable maintenance - whinlatter-nut',
+        'branch': 'whinlatter',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.16-nut',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/whinlatter-nut',
+        'branch_meta-yocto': 'contrib/whinlatter-nut',
+    },
     'walnascar': {
         'branch': 'walnascar',
         'branch_poky': 'walnascar',
@@ -497,7 +517,7 @@ def parent_scheduler(target):
             name="branchselector",
             default="master",
             label="Release Shortcut Selector",
-            choices=["master", "master-next", "mathieu-next", "antonin-next", "mut", "whinlatter", "walnascar", "styhead", "scarthgap", "nanbield", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
+            choices=["master", "master-next", "mathieu-next", "antonin-next", "mut", "whinlatter", "whinlatter-next", "whinlatter-nut", "walnascar", "styhead", "scarthgap", "nanbield", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
             selectors=branchdefaults),
         util.BooleanParameter(
             name="swat_monitor",

