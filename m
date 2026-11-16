Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6169.1794870781730693785
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:13:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Yfa8exIl;
 spf=pass (domain: konsulko.com, ip: 209.85.221.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eab93a9862so996567e0c.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870780; x=1795475580; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xDSxc3r7DvyWSRJhlIGpOFsTeE/IQqUxr2HJQz9ezW8=;
        b=Yfa8exIlWD39JxaflxjNNXr0ld0+R5T+H1eRVlUAKmyRQ5J+qDTN2KQkktfkoPSMHJ
         eNMTsF13k50wsf7frm5TWgaI68tG0c2JcnJa6Xcwklfld8S4zwsKEtYr9WAVbWqwA9R+
         ufawxzuxskdBKMhIk0YYj4/+gcVfO9Gxt288k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870780; x=1795475580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xDSxc3r7DvyWSRJhlIGpOFsTeE/IQqUxr2HJQz9ezW8=;
        b=Zy77+oF4pn4OPuvUipClu0IpRmpHSHjyiY2EgbG3H7Y4sdy1GkpoNrrz28gcoK1Hdi
         37a+WJNzbmxxNXiY8XEzlkmico8mW2TzlLRzIiFLkc2pB9V64eH9bbBASYJIy1mpuP5T
         cOOrB/9I9A6bjbM7TJHByZGGa2kjRr1SqfV7mRP6XLpL9r+VG/Z5UMKRSrIl8M1bemRw
         uLTqE+iLn6e+GscCl80E/nqKDsiG8Wm7uWqqzwr54kfb0+WZNgwaYDVhLrkceMA2anxY
         56riAVyjh09hkFsRrplyWHMvmLjIzBRaC5yydv0bhvwMGVGEVtRsGHM9N9qBlBM5JV97
         +LLw==
X-Gm-Message-State: APuU4Z9Ds1AYUzq7wF+g+mpc6kb9B8L74LAB86oJ2S8XplbQSAr2Kf5x
	rAApPL92SkgSjz1NM8J22D1lYaLPzCPWh8dR4gHL80VjRtTVgrm1O4ga7dZ3iOyDohAKyqWQkBz
	WZKPt+9M=
X-Gm-Gg: AYBFou0dPFtOukR76dlwNMftKC9/z67MWtvtraQxqQ57Hs+385HFwmNvKhwGxvpMJx9
	tPluMTcBfJbNMNjVX9IIwKFERcrnAOtugylpwmPY+jzlYbg4UaGxtX+B8jPot9Fa6Ljf7mrXR/d
	0TlRme72028iG/4YRqBzDngdq2fOJPxTSD6TGsQJIaFWYv56BYBcQSmmNVfSo35zoHzwnsHE+JE
	so82tLkXGL9qk70TT4H+baoW+XZSSXfabRlzfrBtEOCOgqkFN+KYaN6lRuA6Ugo0MZJOSw2doTN
	TP5L0b5CCyQqrjBc7m0gqf6K5XJUw6hbmHZc0nyMN9atVSmipIEAaK/2f0j6WVlco+jb2D+bSdN
	2yC2BblW4T9ofI0K+HCWFSSCBCmCQ9FrdErqlqxvZCOpNufTIUCoEPpygpAUUJ4CP77QqP1gPtd
	QjvHbvgYEnN7W174waFqSGWmep7K8gw1Jn25lqOLrIj7YaJEVKz0wN77iPmcHQsHLU19vAwbvNd
	cVBvsaWswijcxnWdpaaVbyKUuQF4eNKqA654QFNfwqOJkBH29UnrgfKdmhv0WQUMLyhX9+BPn3J
	06qP7kGP0GItvTX7TYz7B4Fo0WQ2tT9xjgY8muiSjKCKKhSGoBO9C6iD0Z+B3bsiGvxSjAhw6RV
	e4DGZgAM26ipKLgA1OR4KKLrgrodOLJAXMvoWIEaxJAEwS4MRR2q5b9EPzLjIrGOn0J3E6o/1UT
	lMjphEV8yNVZw=
X-Received: by 2002:a05:6123:49:b0:5e5:29f7:489 with SMTP id 71dfb90a1353d-5ee34afcfa8mr3683454e0c.22.1794870780429;
        Mon, 16 Nov 2026 15:13:00 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.13.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:13:00 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 10/19] classes/cargo_c: use CARGO_C_BUILD_FLAGS for cargo-c flags
Date: Mon, 16 Nov 2026 18:12:31 -0500
Message-ID: <e4402ede814e4be05e0b0bf0275edc74f3b3b6c1.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5448
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
2.56.0

