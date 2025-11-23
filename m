Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3CECFD31F
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:53 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5052.1763941546958997884
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iTMsDXLD;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2ec756de0so400762785a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941546; x=1764546346; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9pW4jtxJNty2Ksuhn66YclmAHPGEgviBCO9QG9b68M=;
        b=iTMsDXLD49UBO4OjWQSH1oAf0mVuwtIuKrRAXz01DllRW76XwdsPJ0n8fAPfuNa7LO
         g1NxLWCxojXwVt7lZyN+eAAK5tHkorBUZ2Ctidz+Zl5Unw1SjgmjfQfzVMurvEjuham8
         0VLMdHEh7+RRrx9D3MwfJQqfabfL+Qk6n/mRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941546; x=1764546346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z9pW4jtxJNty2Ksuhn66YclmAHPGEgviBCO9QG9b68M=;
        b=hxNaeGRHEqh1puCSc3dLYJo+9QxH2iSn3PK+WcrY9P+xQ2o0Ayrdc8kKTsbP7M2+rH
         XSh3Fwo4KHDJLRs5Le3L9zWR1V0rXlI5n2aqxd55ZqvUw+TzwScuE20i502AaTrmFJol
         yI8CDZKhkrPYv1bEOAMRcDlKWT6O2ewwtMn1E0LKypTjZKWd46YFWmGOsY1hdPliUHW+
         CVwYSaIaq8VFgD+O8Uux4yovhfgVG9hsCytpYhc1OlzdcZWi1jjXyPyWDbBDRp51Xntr
         w5PX9sjUvOD/pVs9Lk7JxCqUJQtq3nmbH90hstq0Mkd5bJmSsKbCedzIamWZzVYeTSIf
         7MBw==
X-Gm-Message-State: AOJu0YzDWZaWYZP3QhFcPbt3mAWTstcD46nmJe+4MJyUtCJC8hFlrOuk
	i7BJzwZQBtSdRE7zz7jvqQstR1SblX/ipKkhJwBVkM1u2QvCKuyNpLfDIB5MAPme0JE4ML2p91m
	GusR5
X-Gm-Gg: ASbGncu7+4kEOTygg2EdDXxMKM81itp9EynrgHwhxM+3MYaS7WHmTCrA/SsrTEsyA9j
	xqLsWOyAMU2mZjygoIkyE6pZZKg8J7MOK2ZQ9sg/0aNCT7I/blGDXLYrKTcWalswRKaQf0wkOGJ
	zlY5b3lDoiZWhJxfzA33YcNYnFYBZN89sjAyuqSAg6ipN52vx2xkCSAYkocud4/hkbhjVdJCW47
	JiK/5ra46FBbqShuTajANTn62InJnESo+KvkOblZ7rgt5yq+9An4/1d8Lwyyk9//Wq2sF1z4Sse
	YtyiWrvdLbVG1xqlKLP8wqDt020u2Opekz/X4AFRLuNcrLsYMtFR5F+TNVO92UL0Mxp+4oBDG3q
	dAwNGPwnWeBQgQ8cIlsrBp0zldIXFuh6EG5j1PFKs2aAnXWhPEaA+BbKAOypnDU5S6KqKjKfiKJ
	zNNOqKj9Hu9spIc2HzVISel9On72czKyZsPwll2JuFdGDIzwCe1K8ktSoMylsD+9w=
X-Google-Smtp-Source: AGHT+IH8TIVLFwmM9I8adtafwHkM0h0twqh8a/F/DB5IJwA43PaSdbMJUGEHr+ct/AeI8toFd0e6PQ==
X-Received: by 2002:a05:620a:7106:b0:8b2:dfb3:dc2a with SMTP id af79cd13be357-8b33d4a2131mr1220466185a.75.1763941545560;
        Sun, 23 Nov 2025 15:45:45 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:45 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 27/32] suricata: resolve TMPDIR QA issues in do_configure
Date: Sun, 23 Nov 2025 18:45:07 -0500
Message-ID: <4eac7ea05daeb2281d251f556a6a800e9a937932.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2685

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

ERROR: suricata-7.0.0-r0 do_package_qa: QA Issue: File /usr/bin/suricata
in package suricata contains reference to TMPDIR [buildpaths]

ERROR: suricata-7.0.0-r0 do_package_qa: QA Issue: File
/usr/src/debug/suricata/7.0.0/src/build-info.h in package suricata-src
contains reference to TMPDIR [buildpaths]

Address references when src/build-info.h is being written

This is similar to Debian's approach:
https://sources.debian.org/patches/suricata/1:7.0.10-1~bpo12%2B1/reproducible.patch/

Restore the "already-stripped" check and CFLAGS info

Original resolution in commit c0e3fecc3bea ("suricata: fix QA warnings")

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
(cherry picked from commit 277bf8f9160540d582fec58f0f2139b4e4aebef0)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/suricata_7.0.0.bb | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index 58ed688..e2e94e2 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -85,9 +85,25 @@ do_configure:prepend () {
     # use host for RUST_SURICATA_LIB_XC_DIR
     sed -i -e 's,\${host_alias},${RUST_HOST_SYS},' ${S}/configure.ac
     sed -i -e 's,libsuricata_rust.a,libsuricata.a,' ${S}/configure.ac
+    # Address build configuration written to src/build-info.h
+    sed -i -e 's,\(| sed -e '\''s/^/"/'\''\)\( |\),\1 -e '\''s#${WORKDIR}#\\.#g'\''\2,' ${S}/configure.ac
     oe_runconf
 }
 
+CFLAGS += "-Wno-error=incompatible-pointer-types"
+
+# Commit 7a2b9acef2 cargo: pass PACKAGECONFIG_CONFARGS to cargo build
+# breaks building this recipe. Providing a copy of the original function
+# Armin 2025/04/01
+#
+oe_cargo_build () {
+    export RUSTFLAGS="${RUSTFLAGS}"
+    bbnote "Using rust targets from ${RUST_TARGET_PATH}"
+    bbnote "cargo = $(which ${CARGO})"
+    bbnote "${CARGO} build ${CARGO_BUILD_FLAGS}$@"
+    "${CARGO}" build ${CARGO_BUILD_FLAGS}"$@"
+}
+
 do_compile () {
     # we do this to bypass the make provided by this pkg 
     # patches Makefile to skip the subdir
-- 
2.47.3


