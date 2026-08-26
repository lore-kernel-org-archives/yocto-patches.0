Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9202BC61DD2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:58:53 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22427.1787777927143719938
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=H2HWcfy5;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8f186025973so15746016d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777926; x=1788382726; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZjUklekn3p4wfNF11Ta3lX2pRZer0AqIYF2dRtozSbA=;
        b=H2HWcfy5HLnGg5teyISLZgtqJEaANuYQrjFmyDK+Yob3b+Fubje9MdCXhhgqXW58qe
         on8VSHu2b8VxAsFbsHiIWymFUF0ISohPYdLYkkNhKWch0qDb212XG5SEHh6pAfGw+hiM
         odCOvLMsLM/ScoNrARSEAPm5wmdjR9o3FIzSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777926; x=1788382726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZjUklekn3p4wfNF11Ta3lX2pRZer0AqIYF2dRtozSbA=;
        b=RE30/Kj7ifkpX4raZgDcBnSJh8FxfNlRFU4xGpaawzMZVH9W8nlnzSJCuiV+uBzOvu
         5PHxAgWwznVSlF9NBB9/SRobxB3f93f19dvX7UlodOsLORr0nNko7M1aOTo+G5f9RXZY
         ODPRNtEHXvO0xgJ96N8whJb6wVFfAB26z7cKI9UZZRg+HtJNHmrq6aUl67XHmGNeYr2M
         brF/XmI1h0i5nPpnmmcASpFI1qLGFm+V93qdjM2s8j9y7IjuegCpfPid3njp89xzCO2g
         C5N20RJLnM/Af+7sv2JsXMWYTCuHxd3b6RcX7QflXzs4yvFCyD4P4DIwp+SXYjqe+wVH
         vUOg==
X-Gm-Message-State: AFuF++nyvtgI1uEgTgRV2nLQ1Gq0syRsj4plkQHKRAR0xNwtBDAh++TX
	9t+doRFoHf1Gr0UMA/zEhs0Ajnb2Z4kFgKWMdq3YO/3WueDx3MuvUCbpFO0BVvGWuPg6HD+ldji
	uSc6t
X-Gm-Gg: AR+sD13mnpiEmkn+y2aFcR0ARdEs3FEaMuWDGY5lzokuWhKVQAm+3xpM0rpbOY5+tL6
	yHU+0zkntbuDHko3JD4McAmlOQEXwMn8u1/vm9JTy6U4F4ernDx5t5qRq5SLZ9BKzoVKHVZc8fb
	z79tMcuJqEoEux1U560uQvf1uYeeHxHBA8o+hmEqPf5DGN02MCJ58/3BqYJNNI06JdTZVW7B6i/
	dGZ7Wkwwumm8MBawl04TBRITDxFngw7XbI2Ospkd8e7T+ry3eM1eCmIJH9AF0/NoRU2AbxeHyck
	QqJ/fhKDN05fRf5oa1hqA15X4Twk44o6xENUvVVW8pvIk15XZM52wRMpWf77weaPcCf14AgRkAg
	tVCdYT3i/DFkmfCdWF20R3Z7HxIcReF35AZh2f6zI1029g/MPoqJQ4h+aq3m32Js87IGc4huNHI
	SJksjgkBa28MmUOVWnQ2IhlokcvbypwoG440890F9qEISZ0nY/3sWA8TX3B7SW88DGBC9E/HpR0
	f+D1R4m2lA9RZ6/Z2TkkTa4pvs+LGs+qCxEm0JoUQHRpUoJxFXBqKAOTAAETH4X6ON/F0pqA9T4
	74xy8VmG2OKj0jOFgnimDPul1w==
X-Received: by 2002:a05:6214:5783:b0:90c:c0c6:4584 with SMTP id 6a1803df08f44-90cc7884dd5mr126713196d6.1.1787777925856;
        Wed, 26 Aug 2026 13:58:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:45 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 03/15] samhain: fix server startup failure on systemd-based systems
Date: Wed, 26 Aug 2026 16:57:37 -0400
Message-ID: <1c04ed220b78436856149d96f1a378a7360b9563.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:58:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4695

From: Bin Cao <bin.cao.cn@windriver.com>

Fix two issues preventing samhain-server (yule) from starting:

1. The compiled-in PID file path /var/run/samhain.pid fails because
   /var/run is a symlink to /run on systemd-based systems, and
   samhain's security check rejects symlinks for PID directories.
   Add SetLockfilePath = /run/yule.pid to yulerc.template, following
   the same approach used in 0004-Set-the-PID-Lock-path-for-samhain.pid
   for the standalone/client configuration.

2. The init scripts unconditionally source /etc/default/rcS which does
   not exist on systemd-based systems, producing a confusing error
   message. Source it conditionally instead.

Signed-off-by: Bin Cao <bin.cao.cn@windriver.com>
(adapted against prior 4.5.3 upgrade)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...-set-SetLockfilePath-to-run-yule.pid.patch | 41 +++++++++++++++++++
 recipes-ids/samhain/files/samhain-client.init |  3 +-
 recipes-ids/samhain/files/samhain-server.init |  3 +-
 recipes-ids/samhain/samhain.inc               |  1 +
 4 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch

diff --git a/recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch b/recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch
new file mode 100644
index 0000000..889fd9b
--- /dev/null
+++ b/recipes-ids/samhain/files/0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch
@@ -0,0 +1,41 @@
+From 7070832b4652f3cdaa2e37325fc6f9456859cb5d Mon Sep 17 00:00:00 2001
+From: Bin Cao <bin.cao.cn@windriver.com>
+Date: Mon, 25 May 2026 14:55:37 +0800
+Subject: [PATCH] yulerc: set SetLockfilePath to /run/yule.pid
+
+On systemd-based systems, /var/run is a symlink to /run. Samhain's
+security-hardened code uses lstat() to verify the PID file directory
+is a real directory and rejects symlinks. This causes yule (the samhain
+server) to fail to start with "Path of PID directory refers to a
+non-directory object".
+
+Set SetLockfilePath explicitly to /run/yule.pid to bypass the
+compiled-in default of /var/run/samhain.pid.
+
+This is the same approach used in 0004-Set-the-PID-Lock-path-for-
+samhain.pid.patch for the standalone/client configuration.
+
+Upstream-Status: Inappropriate [OE-specific configuration]
+Signed-off-by: Bin Cao <bin.cao.cn@windriver.com>
+---
+ yulerc.template | 4 ++++
+ 1 file changed, 4 insertions(+)
+
+diff --git a/yulerc.template b/yulerc.template
+index 512bc0d..24b437c 100644
+--- a/yulerc.template
++++ b/yulerc.template
+@@ -173,6 +173,10 @@ Daemon=yes
+ # SetLoopTime = 60
+ SetLoopTime = 600
+ 
++## Path to the PID file
++#
++SetLockfilePath = /run/yule.pid
++
+ ## Normally, client messages are regarded as data within a
+ ## server message of fixed severity. The following two
+ ## options cause the server to use the original severity/class
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/files/samhain-client.init b/recipes-ids/samhain/files/samhain-client.init
index d5fabed..c714f8c 100644
--- a/recipes-ids/samhain/files/samhain-client.init
+++ b/recipes-ids/samhain/files/samhain-client.init
@@ -13,7 +13,8 @@ DAEMON=/usr/sbin/samhain
 RETVAL=0
 PIDFILE=/var/run/samhain.pid
 
-. /etc/default/rcS
+# Source rcS only if it exists (not present on systemd-based systems)
+[ -f /etc/default/rcS ] && . /etc/default/rcS
 
 . /etc/default/samhain-client
 
diff --git a/recipes-ids/samhain/files/samhain-server.init b/recipes-ids/samhain/files/samhain-server.init
index c456e51..49a28de 100644
--- a/recipes-ids/samhain/files/samhain-server.init
+++ b/recipes-ids/samhain/files/samhain-server.init
@@ -13,7 +13,8 @@ DAEMON=/usr/sbin/yule
 RETVAL=0
 PIDFILE=/var/run/yule.pid
 
-. /etc/default/rcS
+# Source rcS only if it exists (not present on systemd-based systems)
+[ -f /etc/default/rcS ] && . /etc/default/rcS
 
 . /etc/default/samhain-server
 
diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index 95413cb..85359cd 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -20,6 +20,7 @@ SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://0009-fix-build-with-new-version-attr.patch \
            file://0010-Fix-initializer-element-is-not-constant.patch \
            file://0001-Format-test-output-to-match-Automake-standards.patch \
+           file://0013-yulerc-set-SetLockfilePath-to-run-yule.pid.patch \
            "
 
 SRC_URI[sha256sum] = "e7837adfde3d59a23c59e1bf3ebacdf71bce018619194cfad938cd30cbb9d15b"
-- 
2.55.0


