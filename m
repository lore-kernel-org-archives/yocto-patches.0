Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1737C369AA
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:31:04 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web11.59611.1744061458593312889
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 14:30:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ib7Q/R+b;
 spf=pass (domain: konsulko.com, ip: 209.85.166.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85e46f5c50fso56483039f.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744061457; x=1744666257; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNBEMNeIOEHU4jshhgf8X3yhEn5noXWS3PDGwHeDH6I=;
        b=ib7Q/R+bY6mX9Wu73CKt+TMO3KsDTrzEXacF7jE30Ob2Y33mvgXI0CiXGTsyh8TILY
         t6bcZkmsROPcBiT4eytu2bbIypGiYdPM3FFpuxVBBDXIXMH1HwiRprYJgk+3i0QZHi7c
         9kVEPKttYURSRU0310eAr1e6ijVOmMEytvZKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744061457; x=1744666257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNBEMNeIOEHU4jshhgf8X3yhEn5noXWS3PDGwHeDH6I=;
        b=KCvX4q89IHb5P2Kr38bsyeSDwRFYwBmmrNgdZhmbFdILQsCH+dxoe+YjZVNh3DbnYb
         IM2zja/14dvgxpNC1wVQvvU/g2vTU6GQdQ9vuumqGS4eqlbF1xBSHBbixVh1IDzF/Ok2
         kaM3k3TSV5QGVkhmLphJomfdPqoQDzcPNLoZb1k1PXkXhg/4A2+MlWxmcqA/SpgMGJQp
         C5xWhZVVEk3Rs/CsqKGLNJ4u1Y54oET2BPiGNLU7TqpU94TZ7dvXS8Qs+G3YOeFbMcuE
         b4FK7RevC/B4LL9ygZCGsJnKdNvvOhIc6NQ5d+kqEqWwblW2wdIbNxejgxGBP+qyaTvZ
         Lbew==
X-Gm-Message-State: AOJu0YxMTuzMwDgaxQxWtY7pBSjGjSPbfGyr0JrBNJ/gIVGqo4QMFHap
	rMB0GNdJKZPOalVPL7rcIYLvRWggpFwkx9mXjA4AZzS8O6hj85bcS9BypPnoK+JZwkzwdTJQ7aC
	dchQ=
X-Gm-Gg: ASbGnctE3VWAaNmhsRACPdJ9k2tOuJry2kqfsdVX1oKQijpQDMwDs3mzXID7Hkbkvp3
	6hAhPvQ9WiLPYfp5t9fPvkOjjSFvgrpHYRoJcy7C3fBDfNITjpOvxFlf5QV6aeM+AuANapbGwKg
	e7gPKhVfCvvLykaDBzBdCgOHGcYRtT7LJuODVUBD/Hwfop8Y2s2G+r0XMEJumhtmAZ7I81cGcTO
	p0XTgvkhnkA0HtOe7uuW9B8I6N2AuZ/aCP0zGO6sIdPDgGTa2E8dpgPQnYW1H9eqqaG+7L3OOmU
	LO9YCBm/zramXadtuSL8KSk3yhHznQwKIRTZ8xzmJMJZt+crdzhUK39IQhIWbsc0ZrIS/lAqbgY
	otsRhjv4SDiBxfV597gJF
X-Google-Smtp-Source: AGHT+IHKrBf9zHU6TY+kLURQO55aJTr8E+xkch3BZ7YGN/E/LNCtjYBah99SCT9cdqRGfPFjski31A==
X-Received: by 2002:a05:6602:4009:b0:85e:8c26:170b with SMTP id ca18e2360f4ac-8611c2a9338mr1390938039f.2.1744061457606;
        Mon, 07 Apr 2025 14:30:57 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44ba91dsm132936173.79.2025.04.07.14.30.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:30:56 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 19/29] rust: Fix bloat issue in recent rust updates
Date: Mon,  7 Apr 2025 17:30:08 -0400
Message-ID: <722e8957e69dacaa98a628e4cbc23f5eaf73b17b.1744061149.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744061149.git.scott.murray@konsulko.com>
References: <cover.1744061149.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 21:31:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1319

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
index 838544e..40fc237 100644
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


