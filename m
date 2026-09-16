Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3DEC982D8
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:42 +0000 (UTC)
Received: from mail-qk2-f26.google.com (mail-qk2-f26.google.com [74.125.230.218])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27085.1789597832162794179
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=buDxMwv5;
 spf=pass (domain: konsulko.com, ip: 74.125.230.218, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f26.google.com with SMTP id af79cd13be357-93a0299c787so13616985a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597831; x=1790202631; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZjUklekn3p4wfNF11Ta3lX2pRZer0AqIYF2dRtozSbA=;
        b=buDxMwv5zL5ewc+gMu653WNaNozb5S808XGxpv/a2i9pAqCbbaxs00xEtY1oELW9Bx
         J8oifPSBY94szEoY5Ki5TAfONpUO77qkSGn2TKZv9ZW60cgoZsPQj9RTjkK0gXf8+xie
         VZacxHcZVzGwWLK2durj0SJ1Qxgm4yd7UWNR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597831; x=1790202631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZjUklekn3p4wfNF11Ta3lX2pRZer0AqIYF2dRtozSbA=;
        b=oXJYBbBQiFgEZA1ucueoxL7m093pmdKpn8AERzlp6Y1K8h4u9cGtHAswK0JcQZ5dwx
         vasEl1NRbeNzI7xG2eEJHIAJFVb5LXCLkl8lex6PSUbDUsGWCYnLQUzQP7clcp8BIdGM
         1cmL9FxLVv3JfKFGyB4bknHZDk/yhKKYqlbvgHQqqLcXZO5EuCU8KQWRn4DfVQ94a7bG
         FYihwGgJSz+ZIvRGM6v6ljr+JyqMD6y6L1iXXwwlzEBC6ni/+ejfBpGLYIRBOF88eOma
         EVunA9fr9aaX2qhZw2CO738p4bgjEPzoe1AJCdseaWoYQsyXaRcxZd2BRA8IYXZ/CuVR
         7Dbg==
X-Gm-Message-State: AFuF++l36X8R6lZoYGUBruQXrCKbUKg1ZM2vOWSlsNC6TgkFEKBbdax7
	CcrobhSIEUphYds4itZHc0xtRiILgiWiU6mDtep9TdSO6PttilW+siksbIf5enopVOwT9v+tJyj
	+m+08
X-Gm-Gg: AYBFou3Pjj0yB3ZWkwqQEnHN86yBPO6BN7BcwqWi4oQxLLq5QFdlBFgG9bS8kXrFqPC
	mIMTVCs0H5hxv7BgGnhYEOw2sVHRY38sK9G7v8TIyoJdyXsWuU/rOzCY7DCYthDkgr/b3CRbVGl
	CcEwaAeOuXpJTmHIlCaA0rFesEVB1C0St178aObpt5tZL/AlYmvkaLoV+ZeIgXu51orUfcRpA80
	8Wyx91DcGmxjJ6zsHzBuivMMO27aj4GHfUzZzxah5x0SxUbetEtopVd2emoipvRw63Nnco90vdo
	WgZ9HlmL8vV3EGqbt0o/7lFrqSXmDeKEEECARjHRiHEz0jTTJtpnlQaWIj4FgvVIS5WkHHFfHXt
	Yybjc3ctjv10Hl5NF6D+LFf6zAv+ExWCUUU0e6awp+f2B/+egdg9RU6aItBdq4uv7eVRk8ji7DP
	qrbRkDzrrueyCahK3IDUcWP2ApWn5t6CluWAzuqTZYBBxzQa9PzVWB0BvYDuZ8n1z2wFJVhewcO
	42uq5uAWV0DmgFzI90Uspl24/3ejXMhpIVUYWR7WwXHH/g7Zl2P8Lss4yMjHta5RRFUbcxpf+TQ
	LiLAFPig8VVvKl1z6xz2uAY45VotaQwfaLE=
X-Received: by 2002:a05:620a:8007:b0:939:733d:cbe0 with SMTP id af79cd13be357-93bb7667ff4mr733086885a.3.1789597830818;
        Wed, 16 Sep 2026 15:30:30 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:30 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 01/24] samhain: fix server startup failure on systemd-based systems
Date: Wed, 16 Sep 2026 18:29:55 -0400
Message-ID: <c5829507cfe397015d633742131ef4be5af9485e.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4877

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


