Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33C9C3ABA3
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:40:41 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web10.4574.1746132039888719325
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VpGVxba6;
 spf=pass (domain: konsulko.com, ip: 209.85.222.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5f720c717so291326785a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132038; x=1746736838; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dil5U9sDMQFJjoKLOLogEkvZRBs/2iPhbEm7jkn2efo=;
        b=VpGVxba6dofO+sYvjQsdhGjoGDc3L7+O7LN3WqwxOHbAy9myUqAKQZg/OwqZupCypH
         6LubWCWlWq56JVQc26MD8f1reEDsoe0kku/X4b4vjBv5wtuI1qSCFEPoGqUZP1aLVbji
         UjQDjVS5n9aYM1T9SBs7K3glJSaBXmNjZMwXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132038; x=1746736838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dil5U9sDMQFJjoKLOLogEkvZRBs/2iPhbEm7jkn2efo=;
        b=l7ja+oF2rC2bXwb08q7IBvrekhGYDYGfdfFNt7vK+APV2TuVAJxWOK4ZG66GTsrzE3
         cEqDQcgCa0Hp12kvz4f6j2zFKesSnSZV7NuxLrup4SSoy2X3T0eeH+I5t4Eh9jqVzFan
         te5aViSuEoFNvnr5acu+/frocQgEe4wOqw7OntRSpVhN/HK60SHKRvxWKXMRdhDEcTED
         rgG8SOuHUqpm9gpv69RfLosOC4T4g7rP3J3GJKgmdMV7RX5a+lB6CTaptpbx5VzYvjMg
         VqRgBMjglU3C1aMFOKC0O4NJan29FsZsNQ91R6EBoe1Sfb3Q/xUSPXRb6sPJqfQKFpyi
         Zd/A==
X-Gm-Message-State: AOJu0YzSCDq98us4m9ovF4MVzCTAbzjY40bsrXcrhxAjdjPjN0yibo+A
	ot2FX/0myqo6IKsPX8wdRXEm30zygV5eWCFjiWi6FgiBADPDfyyyP5eCaG9XbB0rkMdVeDoB55G
	m
X-Gm-Gg: ASbGncvjDnB6Cd7AbskvvhGuB5f8SgcR7sOXT4GRL1Qcv/65FbmQsw6Fi+5duRAaknr
	vzMfP4IW+pJHTDa5mRv4svckKMwh87AwvSJ+zwZ7cCBcCmfMqanWIpsj1P/YwPO/1A1621hb8xa
	JSsrjEb351+adRkKiOqjrpZPyAHsTMUmJWZ+UgSHBMGg+/gDGQ7Sy3T9MXk0z2lxYJe42LhiBPI
	4EY6VwNCVLcN3arzVIZc0k7euTZkQlzXjTsnPpywoCEtQGdPl3QLuq5q0gJdijdaai9iGJLzMEV
	ceMWVAEMEncDUMKm3Hc8NN4Cr3L4yfhpcXC885GL8k83l+Ioez+fFMjimIsprFLuKk9OqN8OVEE
	PGu6BFro2zNOEQ5If
X-Google-Smtp-Source: AGHT+IEK0SMti6TmF8YTf2NAM+ilcyIhiLcUr5154bRoVzPOr9YYjyYjnwW+Cu6f2V1/qErsYeK27g==
X-Received: by 2002:a05:620a:390e:b0:7c5:3b8d:9f2f with SMTP id af79cd13be357-7cace9d3e93mr561009685a.17.1746132038061;
        Thu, 01 May 2025 13:40:38 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:37 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 03/38] rust: remove redundant cargo config file
Date: Thu,  1 May 2025 16:39:39 -0400
Message-ID: <e374683d14bca7e3f8003c4a00a252650eb4f91a.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:40:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1430

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
index b001259..50d9e6c 100644
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


