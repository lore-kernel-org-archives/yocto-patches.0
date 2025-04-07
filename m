Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FFEC369A4
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:30:44 +0000 (UTC)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
 by mx.groups.io with SMTP id smtpd.web10.60112.1744061440249674109
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iYIhy1kK;
 spf=pass (domain: konsulko.com, ip: 209.85.166.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d57143ee39so39252195ab.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061439; x=1744666239; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRX/gcacX6N/aEDHN5vBB3ca/N8H3oftTETvkt28YBI=;
        b=iYIhy1kK66jSU5tSiPMlbkiwzezDlRmfvC0gcfbGCYyfVLCd/ax8NBwXvo7F70/r5i
         mHauoJZogsbgMR+4kaDUHKA6XzCEFln/k8N1oZSjGCYpXLllscU7EXRFggMQNYelPq4d
         6CagDPZgVD0hidVpTAlTvZDGkeyh9jX7OV+g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061439; x=1744666239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRX/gcacX6N/aEDHN5vBB3ca/N8H3oftTETvkt28YBI=;
        b=gpxLvVCxq1vPp2/kkKoNhNAG0eEjCiAQPY+wIeMaGtJgGfV28lzze/wg/2+m7InohW
         HXvmjD5Gek6rsHKE3yWN0K7EwYyKdLQRbsVQGHsMU7UhkhgQA3ugUcwkrdqgOSJJXDeR
         x/+rx8i/g7IBakC3G4Xl+7JlVh+sjM2RXT/fc5tSPwc7TH14/BHfo1NgFd1VYryCdQIb
         UvuErRcfdIsny4rfTYcFV/HSRAn8c6X1YX3wVBJxhla3+ecQsTb7R2SUaUeKP5SNqm4t
         fQjatblgiRAM+VgPJbsDb13wiPlY/n0hnBmC8BOzUKyiqtC+/5Znezc6xNuGgMFdQSOj
         c7Mg==
X-Gm-Message-State: AOJu0Yy347Nm1TUR1xCwRtY6A4CdgXkzAXwiWuiUX4p9UxBstsFumWpQ
	LJ0p70fHocD/vQ4vGI8to+S10H4ibjSM2oCXWLoVNREOPFsRJKHuBXzcGuJ/fNkbz+jgVqfqMtP
	64Fw=
X-Gm-Gg: ASbGncutxqG1O+q/FR08AhfwuZp5TX6jQuiTaoYfAXNVGaNKFTFowpoykKzCxICA/jy
	WzvWIje+36DhmS8SFhnc1FWV3Z4A9fgCJcmi38k0m1veN6U08rozsaQ4gardNt/CGqEvVD/Mrni
	cMIgVZT52c1EGbIX0OWGJdEA0OvrZZPsiLOH7/8f/vveuI7Au1d8HLbQfdmj0VVoH1hqHVB/9kF
	7ik8PDEcTKLkqlyqaPAt4p7r/Gh6tzoxfFlrCgyZF6KmG6QSJqVJWL6RVHjUF8wjir233Id+6/j
	HCa6J7Xl87F3avKm3p4muGu4m/s7H/Zv0xoqt8A0Wel4pfF41tMbP2byReMvG4x8eTiAHD+cFOA
	BryVMTfTISh6g3GjNtJCTGZrHEFcKbIY=
X-Google-Smtp-Source: AGHT+IG5YgUbP2EKBWTGht9mZRucsAjjADlRJslNAaQ+3aW+SALswAm8DFFvoie3i1cqLMseqKZ8cg==
X-Received: by 2002:a05:6e02:3103:b0:3d4:3d63:e076 with SMTP id e9e14a558f8ab-3d6e3f65373mr180638185ab.18.1744061439254;
        Mon, 07 Apr 2025 14:30:39 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:38 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 02/29] rust: remove redundant cargo config file
Date: Mon,  7 Apr 2025 17:29:51 -0400
Message-ID: <5131ad23cbe3a70e403234bee726ba8f18709dec.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:30:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1302

From: Harish Sadineni <Harish.Sadineni@windriver.com>

YOCTO [#15061]
The rust target and linker are getting setting from the sdk environment and
so the config file is not needed. The redundant config file geneartion is removed.

Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit d5f78816d2ad0f3e43ce883eef199d1683cfcbb4)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-cross-canadian.inc | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/recipes-devtools/rust/rust-cross-canadian.inc b/recipes-devtools/rust/rust-cross-canadian.inc
index e233861..4478a7e 100644
--- a/recipes-devtools/rust/rust-cross-canadian.inc
+++ b/recipes-devtools/rust/rust-cross-canadian.inc
@@ -64,20 +64,6 @@ do_install () {
 
     chown -R root.root ${D}
 
-    CARGO_ENV_SETUP_SH="${ENV_SETUP_DIR}/cargo.sh"
-    cat <<- EOF > "${CARGO_ENV_SETUP_SH}"
-	export CARGO_HOME="\$OECORE_TARGET_SYSROOT/home/cargo"
-	mkdir -p "\$CARGO_HOME"
-        # Init the default target once, it might be otherwise user modified.
-	if [ ! -f "\$CARGO_HOME/config" ]; then
-		touch "\$CARGO_HOME/config"
-		echo "[build]" >> "\$CARGO_HOME/config"
-		echo 'target = "'${RUST_TARGET_SYS}'"' >> "\$CARGO_HOME/config"
-		echo '# TARGET_SYS' >> "\$CARGO_HOME/config"
-		echo '[target.'${RUST_TARGET_SYS}']' >> "\$CARGO_HOME/config"
-		echo 'linker = "target-rust-ccld"' >> "\$CARGO_HOME/config"
-    fi
-	EOF
 }
 
 FILES:${PN} += "${base_prefix}/environment-setup.d"
-- 
2.49.0


