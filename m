Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3058.1795645892015046829
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=g/XHs0rk;
 spf=pass (domain: konsulko.com, ip: 209.85.160.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5363c8de563so65925541cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645891; x=1796250691; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RMzhxmkEukiKwaaQPt95Jy7SBOcD/UIiyfBVQoAFiZ4=;
        b=g/XHs0rk9eWOHgI3NSTmLupDlKL6hWkzvXbb0KJPImx/2evZFl7dOy/+MLoGeogBFa
         M2Wla5dhdZq1QFX+pzMJzrhk4WnkAaxmdtEzduM519JOyneili1PPyZd1lE1jdqzsT6l
         7/HWqN2rlREtO1XP8zoj/xiHpIrlka64TVszs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645891; x=1796250691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RMzhxmkEukiKwaaQPt95Jy7SBOcD/UIiyfBVQoAFiZ4=;
        b=vGaZqb9AxAwBXjFc7Mmf5dCEao2PYVsYx8tTB7WuGU90K6MuSq/GXsGDWGmz6ijF2J
         nSLBfB/8KCEp2baKqSmN98MuIPY7RPzKbZMaVsWCkHC+EOmhQ2F2O7FSHqW6Aj6McL4l
         PMwzWiVgbgOWyE7/F+dgTNhdZW5WmF92qQVXDP9y5FmYfh1TzD0t6ZWruJydOne434Ti
         IRkGPD2h44D9xavLgtJfEHa3ZYqInZdk7ruePKLuwK7zAme1cwc+L2wUU/C1Gj0jBDkY
         rwIIf2U3LGFWabhCZY/SLy4L6XQlreBMMglacUdWWEN/vRhaga23ygPdP1PjLiAMdeF6
         pK0w==
X-Gm-Message-State: APuU4Z+jPuZoolO56vAr4lCB59s0wKY82Fw54XtInjG7gJHvu07esbeJ
	+WHoqcr+FR18xoDJbhWns8rVxC3mAznsxoGYPlzJ6iIhnAxc0cTZWxZa32++UetMGCIiaw/kJ+X
	DcLcp
X-Gm-Gg: AZFdTZfA2D2aE7iDV4BtiQI9hvhi7X5ZQ4XexTQl0QXj58JajMQUIevSmVZx4il0e8X
	fB2oY/4X8fZsBP/D/DOVTAgN1rskoT/JpCS61kJiCCEJk4hQIKrif91YKPQqV71Gpku+7ZcMXZf
	56iK9cpr1upfCAb0EubY/Sq3RUL2ijtM8km6ITnQ7tV2G2RjFpCuV2tFcLeE6mg4lR9LDq/nTFP
	fIL3qW2OCdOxHfmfFxZIQaxgIgTD+wUjjg/XVNv8JH9dRdeQ5YPZtti5Q2I2N3MUOvujKGEIiUI
	WGPif0UHg/bYd4ozcJHYGxUnW+eJrDmd9X55pl7pQ8NOZa68A9N/mEsVPsMSiiRrYhcVVLDhpFP
	zvCXcHc7m0VJI1G3kdrofRYq8E+NXYvruzN3ak43pQtZnysoRJeUewvzCVApLDdoM9W1fiaYEjs
	TOycnJaW2ibYEpuE8zHBzE7mRN7mhD0leabdQZWlu+AN1SMEWAo/sbTa8A7XY3/L7V0XpQ3jlW8
	Lzk96oQ04x+bf9klL7BbS9Yf24q5RDq69W+bPbK0IKqnZBkFEvWvKK2PKI5jm/vUvYqnDVl6rdO
	Ol4LXPiK9KpHzp72pm4rRdJ8VaTjFvFevacE92r90eXZ5OoZ//wmM4AN4/4Ew6CQxOO66P0/nlm
	5Kx92UuhFJVBeQurkICVRrHjDnm91fjRssGV2M4oqutYj+xUIvswDRYjEw05RH4dmmg==
X-Received: by 2002:a05:622a:613:b0:55d:3254:6253 with SMTP id d75a77b69052e-55d76a518bamr346001541cf.42.1795645890726;
        Wed, 25 Nov 2026 14:31:30 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:30 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 10/19] classes/cargo_c: use CARGO_C_BUILD_FLAGS for cargo-c flags
Date: Wed, 25 Nov 2026 17:31:01 -0500
Message-ID: <e7aa792b22b930cf06cb7edab0acef502383714f.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5528
Content-Type: text/plain; charset="utf-8"

From: Ross Burton <ross.burton@arm.com>

My previous attempt at cleaning up this recipe[1] moved cargo-c specific
flags to CARGO_BUILD_FLAGS, which meant that they were passed to cargo
if that was also called directly (e.g. via ptest-cargo.bbclass).

Avoid this by using a new varibale CARGO_C_BUILD_FLAGS for cargo-c flags.

[1] oe-core 90792837769 ("classes/cargo-c: pass flags via CARGO_BUILD_FLAGS")

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 7f5647a1b494e5b596b6699afe5e2550381df2ec)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo_c.bbclass | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/classes-recipe/cargo_c.bbclass b/classes-recipe/cargo_c.bbclass
index cd486b2..ee6efaf 100644
--- a/classes-recipe/cargo_c.bbclass
+++ b/classes-recipe/cargo_c.bbclass
@@ -16,7 +16,7 @@ BASEDEPENDS:append = " cargo-c-native"
 
 B = "${WORKDIR}/build"
 
-CARGO_BUILD_FLAGS += "\
+CARGO_C_BUILD_FLAGS = "\
     --destdir ${D} \
     --prefix ${prefix} \
     --libdir ${libdir} \
@@ -28,13 +28,13 @@ cargo_c_do_compile() {
     oe_cargo_fix_env
     export RUSTFLAGS="${RUSTFLAGS}"
     bbnote "Using rust targets from ${RUST_TARGET_PATH}"
-    cargo-cbuild cbuild ${CARGO_BUILD_FLAGS}
+    cargo-cbuild cbuild ${CARGO_BUILD_FLAGS} ${CARGO_C_BUILD_FLAGS}
 }
 
 cargo_c_do_install() {
     oe_cargo_fix_env
     export RUSTFLAGS="${RUSTFLAGS}"
-    cargo-cinstall cinstall ${CARGO_BUILD_FLAGS}
+    cargo-cinstall cinstall ${CARGO_BUILD_FLAGS} ${CARGO_C_BUILD_FLAGS}
 }
 
 EXPORT_FUNCTIONS do_compile do_install
-- 
2.56.1

