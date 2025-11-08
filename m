Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A105CD13CF
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:16:10 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13108.1762632964056865466
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:16:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QuEev8/7;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88043139c35so17903286d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762632963; x=1763237763; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4xJZcnymNhQ1qFXiAAbx6pnbmvIOscuVILFbAxE4gA=;
        b=QuEev8/76mGv7oCYWNKU4o9iInQXYLdtoGbFfiLlKU5+DX9g/rWdXeo2NaM3beK7w/
         i+XWc/oJRjo35SsN9w99cvnf//5mO/lehqNRiluMcPtsHFEBmnrnbiGKZaLhcsrvsmJd
         J1vM7OcH+6GS/eJPwBaFYa1pyvycodjlErbyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632963; x=1763237763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u4xJZcnymNhQ1qFXiAAbx6pnbmvIOscuVILFbAxE4gA=;
        b=Q6DukZMt2Jhb7fa6Myk6KEBATHheshQVNxEGVz4KW/ewFh9nyD3KP52uex8YrDYuU+
         ETTqEm7znrqutG3wjAdiptdYk6V46JeQmn2JRu/KWcwp+J5ma9h6tblLCmoPIjlT0tjQ
         3l+R+xBYxefjGVZGxsIupvul+K/CF1Xl8z3nQyWrsl5oi4BdubqYekEIVuhXRFtJSIuC
         TAjIas6rNIRB8rz5uW1rxAOOxG8dU0IPR4PgNtSEFWcaeQNK9IuyZhdF/sFV9tSdWgNU
         oeiSO626Lv/xIOQC+RyaFvsN5yCqdVrmWMh1UpyJvWuyUmevcS03+yw949h4p3lzk3NR
         A5DQ==
X-Gm-Message-State: AOJu0YwgCzrtSVVHzOv8upBc4GVuLFar6vJBBqJ2kfo39E5VHTqtPlLh
	PXc3bwR1dj1cdBXz2hpPX4cQZ3+4weUgUjioOyBKAKzxsNQItbDnVUZbKQ9QiVkHFcedy/5ujWs
	5h1vW
X-Gm-Gg: ASbGncuTtTEWITfk+decVXwBkctJREwgydWA849pJ11xZXx9t5Wu+QVYxxkqThcqGjl
	vhS+SsAWMGs3wVn8tBH5BjkoE6XHVPK288Vg8RugZ6O6BDnltV2GvSc6Cv9lrWUDlRqa1VHRR6F
	116KOu7mG0rhJXV8ZUn7MEZUSUEuvfbhKeHZt4i7S6n7XQT5jy7fMZo+DPoFxPU0MF4BUwfvV+H
	bdSXMJukn3/wbH7YT+Xhg5YZ0LUTUsqI6jt+04IJijxjNRXT5LpC06blsi5uWkCMwdduvXs/j6p
	yfKqqCPkDiX7ix1YB8qG5SPsEBvdb1EzRZnfsl32lFuxFg8a6IGcZltKp0tszL6mjqwIyokbKqz
	/3DUEAUMdmIBQxaEX4YZdr0+AwV0pbd8npUUxBAqpHe+7BszP8qU1poBJuS7gVwkI7PwY+crc9q
	f9E1LrgqA52sLnEimeQlA6ADp3A+3Hj/G/xQsUiKkrBEQ18+mgApm+qrzhIs3JTrwvNunzwmVOW
	A==
X-Google-Smtp-Source: AGHT+IEdIwBSlAQ1+b4FFZnL6JpyjnWVT8Zuywe+11etVpTMN97LDD/+W897H6s0JNkLqeE1PTZIQA==
X-Received: by 2002:a05:6214:f64:b0:880:499f:47bc with SMTP id 6a1803df08f44-88238690a88mr39894386d6.45.1762632962594;
        Sat, 08 Nov 2025 12:16:02 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm20001896d6.53.2025.11.08.12.16.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:16:02 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 01/11] cargo-c: Fix compilation
Date: Sat,  8 Nov 2025 15:15:43 -0500
Message-ID: <561b6e9bba0c1fd21ac330e6af455eb80ce40624.1762632742.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762632742.git.scott.murray@konsulko.com>
References: <cover.1762632742.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:16:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2436

Fix patchdir for the two RISC-V crate patches since the kirkstone
fetcher works differently and the change to point S into the
cargo cache cannot be backported.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo-c_0.10.14+cargo-0.89.0.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/rust/cargo-c_0.10.14+cargo-0.89.0.bb b/recipes-devtools/rust/cargo-c_0.10.14+cargo-0.89.0.bb
index f5907ac..2171d76 100644
--- a/recipes-devtools/rust/cargo-c_0.10.14+cargo-0.89.0.bb
+++ b/recipes-devtools/rust/cargo-c_0.10.14+cargo-0.89.0.bb
@@ -6,8 +6,8 @@ LIC_FILES_CHKSUM = " \
 "
 
 SRC_URI = "crate://crates.io/cargo-c/${PV} \
-           file://0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../getrandom-0.3.3/ \
-           file://0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../parking_lot_core-0.9.11/ \
+           file://0001-getrandom-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../cargo_home/bitbake/getrandom-0.3.3/ \
+           file://0001-parking-lot-Use-libc-SYS_futex_time64-on-riscv32.patch;patchdir=../cargo_home/bitbake/parking_lot_core-0.9.11/ \
 "
 SRC_URI[cargo-c.sha256sum] = "fe82742019f0e5c1a9f8549b0f41b20f1bc834f5ed0626c47019f15be566b321"
 
-- 
2.51.0


