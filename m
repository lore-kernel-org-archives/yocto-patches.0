Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5902FC3ABB9
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:02 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web10.4593.1746132056455835938
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=H8ommBmT;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8ec399427so14166256d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132055; x=1746736855; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LY49FMx6miwcjmLVQuEU/srG6sPdp1LChhhrd6zD/oE=;
        b=H8ommBmTEy/QooRbt3Mh2WVC2HZ/ebgr5RCoQQpBY+eKFIzn8YnrS4xo8cFQqwcKPi
         WqsJukkpPEKHoKrStzZTOTu6rhATQr4G1C8vT9StevYrRkOk5NEF2wLQidGAcfMZFE1E
         pcBgcuwxdsbsTkqOy8I3j4RnGKt5mmGEc0bco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132055; x=1746736855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LY49FMx6miwcjmLVQuEU/srG6sPdp1LChhhrd6zD/oE=;
        b=brRBj/LfWtF41wE4Q2ZZl7/NWyRNMctvdc6lkGbZC4AOwEzy+ke63mjN2vbnD1nv+Z
         8XyWA2HFhFM9W6vZU646b++MAhZpHu8L+YgrTpXRR4djpHjG1jD7oixNqUyFxbhQJvNc
         HaIip5Af/xNgdagAo9lrhIGtw1ncHugEEr7BISWN7tz0YyhzFNld8RmV04i2FvTCJXMw
         xoeddsctbeWiejValTnVmTD2bPwP+J+an6DXOOChoInjhrrPxXTMmMtTUgx4vrb7Q8zV
         XdKC3MD5fd8dtJGPM1apHSKcO6+iZmvpUGavTTJWoovgeCbuU5ZF4xvYiXEiWTEJWTUo
         D1mA==
X-Gm-Message-State: AOJu0YzCokPR0CyHHXgmhyUZxYNT78a2H4ZesSzk0BmL/udpyB0LDvWN
	fB/RHODixQfc3yoCgGKM3FcztTjSGQGdVQzoZ8mK7OaybdlEmTznuB3XyQqO5YGW9CzD6b2ByrS
	i
X-Gm-Gg: ASbGncu/zB9FNNckeeCcJ2JxDlS4Ki6E88s9l+um7WeuyVIBvjgqhGZO5s+VGvnusU1
	uh0yX69oQGYko8HBat7nabXA+eRaynuc1Tuq7ZAsyYAq3fFyCAR/PyeKVwQW3g+oNJzPA9YMSE7
	fMknrkUMyeYwBfMBthWz1v8ZKU+zhsq3U65W+BI5Xldksy/KTJZDuoGNLu89VRs4kmxTPnyiYX/
	3Cfyz0QEpOhXLKDP4KtLySTv4rdjdGmENMJjzYZPQu1CGCdQArtdehAo4qgnfTVEon7yI/25oAi
	xsE6Pyx2BxPKugWM089f/fE9q1W25/VB5a3pa/mt/zCDMBdEMz5zmYweFFqOtRY9WUWntTbeMSH
	s4FC9RroTV2gxVW/G
X-Google-Smtp-Source: AGHT+IG9dYd37EiURZMGzMaplIJSWrZyLE5naZWIiWhtHwX9kLRJfOfsDocxG6M1R6huWAYYros6Tw==
X-Received: by 2002:a05:6214:c2e:b0:6f5:436:9e46 with SMTP id 6a1803df08f44-6f515279a5bmr10984116d6.15.1746132055292;
        Thu, 01 May 2025 13:40:55 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:54 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 21/38] rust: Fix bloat issue in recent rust updates
Date: Thu,  1 May 2025 16:39:57 -0400
Message-ID: <b52b0f6a976207f6a2b9b008399e1f52cbe16be5.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1448

From: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>

Remove the "src/gcc" directory from the Rust source code to reduce the
filesystem build space.

In Rust 1.83 (and 1.84), a full GCC-14 tree was included, which caused
the tar.xz archive to increase by 128 MB and the unpacked sources to
grow by 1.3 GB. This was an upstream error that has been resolved in
Rust 1.85.

After updating to Rust 1.85 we can revert this removal of "src/gcc"

Signed-off-by: Deepesh Varatharajan <Deepesh.Varatharajan@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 26a345adc8e050657bfa0b51ea92a3d89e698d9a)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-source.inc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index dea744f..ec94949 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -13,6 +13,17 @@ SRC_URI[rust.sha256sum] = "7b11d4242dab0921a7d54758ad3fe805153c979c144625fecde11
 
 RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
+#After updating to Rust 1.85 we can revert this removal of "src/gcc"
+remove_gcc_directory() {
+    # Ensure the gcc directory exists
+    gcc_dir="${S}/src/gcc"
+    if [ -d "$gcc_dir" ]; then
+        rm -rf "$gcc_dir"
+    fi
+}
+# Add postfunc to the do_unpack task
+do_unpack[postfuncs] += "remove_gcc_directory"
+
 UPSTREAM_CHECK_URI = "https://forge.rust-lang.org/infra/other-installation-methods.html"
 UPSTREAM_CHECK_REGEX = "rustc-(?P<pver>\d+(\.\d+)+)-src"
 
-- 
2.49.0


