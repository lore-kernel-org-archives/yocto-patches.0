Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B506CFD31D
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:43 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5048.1763941539947814128
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qBknxrCh;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2f2c5ec36so443229185a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941539; x=1764546339; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9xN6GhqmZJCTl49Zo9HUWYj0K0hFYUm5Bb/GEUF+Bo=;
        b=qBknxrChXWkNGGFc24p4ZtXRH7xiYGneDKQbtNSxhRf384AuRfhpBUH53hp+D1+ycO
         hdAADgwBtZ8K3Ba4H7DNnGSe6kd77EoVF6N0GEsvYFzwON8qFchyWVtLl5ISF4OPP17C
         r3pABm1xOnNhd+LQ5zTUEu0KFuHewQRXyWvWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941539; x=1764546339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j9xN6GhqmZJCTl49Zo9HUWYj0K0hFYUm5Bb/GEUF+Bo=;
        b=nTwF0H0MMUTn/hXCamo8Oc6MrE/90A/W1HvBa9IuuvVSKNrNFkKKVrfyCA+Vjol0M6
         QUMV1lwlsvRuBs2sj2FFkQc2GXyKUgzH7Vc7qxXtLdmmTntPPhLlmvYUF+OsmKKKGAVj
         8W4laQFfLct0tU2yG89wu9DCmA6BB3hmcw571JBe2hVPeLrcLwdQbjBY8JuiX3HRL21X
         PyfIyU+vO3t8zMi+RFGyQ5zwTiTWd36OpJNbp8gEBvI6fiU8w+xGbc2/DljPv5jXFMub
         NfKi4lX/SkQtqUQ7sXZBL6NdagQUP33oQgOxe7daFlJrWhMXY6wrt9jiVDP2MTMmmZCL
         v83g==
X-Gm-Message-State: AOJu0YwG0Fi0JFaqb+d8uQ9RTOkOT3B8q5AxUIME4+YGkrza0n/D8Jyu
	FqBkqsZI2b21CnjsQRD3qY6Kovhb7xeqDPG3+wMBzdw5HL7MgbY6bJ+9wOXdp3qj0saWPMcW8lE
	pblnL
X-Gm-Gg: ASbGncuf8UxJTYRsY6CE+lXiN/JlMUMNgD7TBY4G7qKDCHbIgi42BqdBjkrkSpgebhB
	3IEeX1WREretECgOWNSzdwD9TgP7eC5byYsAIYoCvX2aq1AeogaWMwrQIMCQgwcbSjoVUCJ2jsT
	71UfwuDXR+02TJCf2t7HlA9GmhW7ZGS5i7JSzwfDw7A72UFL1JX+HTI5ehIRsjfXWHy5z5tRvIl
	JaLpjwplTDRyDT9uFqnxPMVzQNIhtbz4ASkRrnpZTj91CXVtd2sOEfZw1wuMkjs48/GN5go3nEi
	MPFZzC649S9VfFobXziiwr8B4+iiH6ZV0WjixBVjvF6zyC7I7LKlgKasjgbD1TT4+Cv3pTLU08y
	oIVZavC6X0tj3PYKTpB4WbRzL9BGU6C6JvkQ+HF7BM+HHPeNe6zvu5FKkqcrr0KtIFLk9uYtPiD
	dkKtMTdmydwXH88GLjIpkfbuX9t0ACnKiPAsVuv4a37glU8Nx3l2unKEr5t4zSx8k=
X-Google-Smtp-Source: AGHT+IG63fs/HRubS5PfjvKnfjE5+k3bcr9zziL0ZvosyQGfx2dpRdBNjFLps4NzTfsJTPidmY9jXQ==
X-Received: by 2002:a05:620a:46a0:b0:8b2:e1da:7532 with SMTP id af79cd13be357-8b33d2682d9mr1256197185a.34.1763941538402;
        Sun, 23 Nov 2025 15:45:38 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:37 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 21/32] fail2ban: update to 1.1.0+
Date: Sun, 23 Nov 2025 18:45:01 -0500
Message-ID: <d0809fa36e80743f5a7a476eb91dbbc9906c34f9.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2679

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Current 1.0.2 version does not work with scarthgap or later releases,
as the asynchat module has been removed (as scheduled) from python's
stdlib as of v3.12.

fail2ban 1.1.0 also does not work out-of-the-box, as the distutils
module which the pyinotify and systemd backends depend has also been
removed.

So update the recipe to point at commit ac62658c10f4, which fixes
those two backends to no longer depend on distutils.

Upstream's out-of-the-box ban action now uses the 'nft'
command. People can still override and customize that in
jail.conf/jail.local, but to make the recipe useful without
customizing things back to use iptables, change the dependency
iptables->nftables.

Since 1.1.0, fail2ban has been python3-only, so the recipe becomes
somewhat simpler since the whole do_compile preparation step can be
removed.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
(update PV)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...fail2ban_1.0.2.bb => python3-fail2ban_git.bb} | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)
 rename dynamic-layers/meta-python/recipes-security/fail2ban/{python3-fail2ban_1.0.2.bb => python3-fail2ban_git.bb} (89%)

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0.2.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
similarity index 89%
rename from dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0.2.bb
rename to dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index bf5f87d..444574a 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_1.0.2.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -11,12 +11,14 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=ecabc31e90311da843753ba772885d9f"
 
 DEPENDS = "python3-native"
 
-SRCREV = "e1d3006b0330e9777705a7baafe3989d442ed120"
+SRCREV = "ac62658c10f492911f8a0037a0bcf97c8521cd78"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
            file://initd \
            file://run-ptest \
            "
 
+PV = "1.1.0+git${SRCPV}"
+
 UPSTREAM_CHECK_GITTAGREGEX = "(?P<pver>\d+(\.\d+)+)"
 
 inherit update-rc.d ptest setuptools3_legacy
@@ -26,16 +28,6 @@ SYSTEMD_SERVICE:${PN} = "fail2ban.service"
 
 S = "${WORKDIR}/git"
 
-do_compile () {
-    cd ${S}
-
-    #remove symlink to python3
-    # otherwise 2to3 is run against it
-    rm -f bin/fail2ban-python
-
-    ./fail2ban-2to3
-}
-
 do_install:append () {
     rm  -f ${D}/${bindir}/fail2ban-python
     install -d ${D}/${sysconfdir}/fail2ban
@@ -66,7 +58,7 @@ INITSCRIPT_PARAMS = "defaults 25"
 
 INSANE_SKIP:${PN}:append = "already-stripped"
 
-RDEPENDS:${PN} = "${VIRTUAL-RUNTIME_base-utils-syslog} iptables python3-core python3-pyinotify"
+RDEPENDS:${PN} = "${VIRTUAL-RUNTIME_base-utils-syslog} nftables python3-core python3-pyinotify"
 RDEPENDS:${PN} += "python3-sqlite3"
 RDEPENDS:${PN} += " python3-logging python3-fcntl python3-json"
 RDEPENDS:${PN}-ptest = "python3-core python3-io python3-modules python3-fail2ban"
-- 
2.47.3


