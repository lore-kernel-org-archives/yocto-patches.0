Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138ADE77188
	for <webhook@archiver.kernel.org>; Tue, 31 Dec 2024 03:12:36 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web11.76823.1735614752540141803
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 30 Dec 2024 19:12:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g1iSOfK5;
 spf=pass (domain: gmail.com, ip: 209.85.219.171, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e53a5ff2233so10492002276.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 30 Dec 2024 19:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735614751; x=1736219551; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDGzzK2AeN5Yjk7xvPwY0UstRTI5zsRbce1iXz63l5U=;
        b=g1iSOfK57OTVZWhTatK0yBUIgyNDZodwq132SpQ6kW5FwKrH4ABqxPqVABaYyDt932
         z5c/Sp1v/HAgKjKIdSJ5vA+ZdDAyWPXZ+62Grvq099LE7JXIF7D9o/UjwlKwW6TTduOP
         FZU08drQS0FwZpg1CnARqDe+qMXeU51+H0UWd3es4o+j4Uh5GKurz2GWLT9ISTvl6zUA
         wM6z4HeMB9zvta67gTl+l+RhoYCOoNJZYgJnonr7bboxJ+i5sQ0KKG5cZV8ler/bREp5
         BjU/jjAsb4A/J36It6FQb0a0ZN17pRU1ICHpRleKo198wgrhcDyenXTDsRMCechLlZw4
         eV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735614751; x=1736219551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDGzzK2AeN5Yjk7xvPwY0UstRTI5zsRbce1iXz63l5U=;
        b=jZK1bXtQS6GYtQPMQnTxzARvTS9/+EDvcwkb/lOcI/VnJF23ojyj071t2cNzBfDYx/
         Uvmyr4Gm7ES33hVWLeqxT1Zvv8/vQbW4qHYcnTgR4tQe5tA7N3/sm9s8Cj5Tr0OJuLVp
         2Rty6zYrnEwU3kO/EfYGtyrMjSEnmfGNjydma4j1CDAXE0jeEkF4U/333Sk+oizr9GJP
         Y6WcSNSKAqK2b+xH8u5bgrkJ2MELqTxTi5BdbhKlnXK0gbrlWV/G0IIfsA3J6rBbN9u8
         PLeVpocuCcNM4V7qoPmNLarGchp5oWdBj7TKwl192Qgzzuv2v8gUQTgf6FFy4ShQ6XG3
         zzIQ==
X-Gm-Message-State: AOJu0YyDJ+L3o0rmMbx1sfHwE87Z+k02maCBZ8G/vyBKDpV9JIdor1do
	eaz6Mjeg/XIgzJ68eo0gHDjDZG3MQ8lMSaHpq2IaX0LuDtZaMPZgkKgl6gOA
X-Gm-Gg: ASbGncumFg/H0yHFMv2rlm9bBIkEIycnLE8HwPVGB4Yllfq9Vf8mpEGeWOghQeKt2gY
	ioNZtU22fctTzmgnkdLqtlpmfbyykwXckFJ/gN83EQ4dXwKHYSsprlfArhzHJ5oN3xAKWsXlQy3
	lmikNIMs/YiqQPMSmpaavN8uheBRHMLQgNgtvCeVeT2fITVT30Q74xp/0Kh7IyY/Srt3isR7bL4
	m6Z3Y594271pFcUhv94rEq1Nz0HR1zrNMYSGlKxLoLbbd1MQdS/1QNIwN58TkTrV5Nl
X-Google-Smtp-Source: AGHT+IHLxiHCz4PiL3oSZ8iAOkIZW0Gp6p0NDvzNaagfrmhqTOqP7eYv4cbi37Fh0VRfxwh4vpSRnA==
X-Received: by 2002:a05:6902:11cf:b0:e46:e18:9e83 with SMTP id 3f1490d57ef6-e538c34f3ccmr26060273276.39.1735614751564;
        Mon, 30 Dec 2024 19:12:31 -0800 (PST)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:c83e:ad2:5c14:ece])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cbeb0b4sm6270546276.6.2024.12.30.19.12.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 19:12:31 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/2] parsec-service: fix build error
Date: Mon, 30 Dec 2024 22:12:29 -0500
Message-ID: <20241231031229.2640925-2-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241231031229.2640925-1-akuster808@gmail.com>
References: <20241231031229.2640925-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 31 Dec 2024 03:12:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/961

Fixes:
| error: unnecessary qualification
|    --> src/front/domain_socket.rs:247:30
|     |
| 247 |             let ucred_size = mem::size_of::<ucred>();
|     |                              ^^^^^^^^^^^^^^^^^^^^^

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 ...Fix-unnecessary-qualifications-error.patch | 50 +++++++++++++++++++
 .../parsec-service/parsec-service_1.4.1.bb    |  2 +
 2 files changed, 52 insertions(+)
 create mode 100644 meta-parsec/recipes-parsec/parsec-service/files/0002-Fix-unnecessary-qualifications-error.patch

diff --git a/meta-parsec/recipes-parsec/parsec-service/files/0002-Fix-unnecessary-qualifications-error.patch b/meta-parsec/recipes-parsec/parsec-service/files/0002-Fix-unnecessary-qualifications-error.patch
new file mode 100644
index 0000000..cef6bd8
--- /dev/null
+++ b/meta-parsec/recipes-parsec/parsec-service/files/0002-Fix-unnecessary-qualifications-error.patch
@@ -0,0 +1,50 @@
+From 86d4d2ca2f1e873a29f9f4d4bba99fedee19a144 Mon Sep 17 00:00:00 2001
+From: Gowtham Suresh Kumar <gowtham.sureshkumar@arm.com>
+Date: Thu, 29 Aug 2024 17:10:06 +0100
+Subject: [PATCH 2/4] Fix unnecessary qualifications error
+
+Signed-off-by: Gowtham Suresh Kumar <gowtham.sureshkumar@arm.com>
+
+Upstream-Status: Backport
+Signed-off-by: Armin Kuster <akuster808@gmail.com>
+
+---
+ src/front/domain_socket.rs | 9 +++++----
+ 1 file changed, 5 insertions(+), 4 deletions(-)
+
+diff --git a/src/front/domain_socket.rs b/src/front/domain_socket.rs
+index 9fb8a0c..a0effa5 100644
+--- a/src/front/domain_socket.rs
++++ b/src/front/domain_socket.rs
+@@ -239,15 +239,16 @@ pub mod peer_credentials {
+     pub mod impl_linux {
+         use super::UCred;
+         use libc::{c_void, getsockopt, socklen_t, ucred, SOL_SOCKET, SO_PEERCRED};
++        use std::io;
++        use std::mem::size_of;
+         use std::os::unix::io::AsRawFd;
+         use std::os::unix::net::UnixStream;
+-        use std::{io, mem};
+ 
+         pub fn peer_cred(socket: &UnixStream) -> io::Result<UCred> {
+-            let ucred_size = mem::size_of::<ucred>();
++            let ucred_size = size_of::<ucred>();
+ 
+             // Trivial sanity checks.
+-            assert!(mem::size_of::<u32>() <= mem::size_of::<usize>());
++            assert!(size_of::<u32>() <= size_of::<usize>());
+             assert!(ucred_size <= u32::MAX as usize);
+ 
+             let mut ucred_size = ucred_size as socklen_t;
+@@ -266,7 +267,7 @@ pub mod peer_credentials {
+                     &mut ucred_size,
+                 );
+ 
+-                if ret == 0 && ucred_size as usize == mem::size_of::<ucred>() {
++                if ret == 0 && ucred_size as usize == size_of::<ucred>() {
+                     Ok(UCred {
+                         uid: ucred.uid,
+                         gid: ucred.gid,
+-- 
+2.43.0
+
diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
index 3aa0b0a..1d7c6e8 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
@@ -11,6 +11,7 @@ SRC_URI += "crate://crates.io/parsec-service/${PV} \
             file://parsec_init \
             file://systemd.patch \
             file://parsec-tmpfiles.conf \
+            file://0002-Fix-unnecessary-qualifications-error.patch \
 "
 SRC_URI[parsec-service-1.4.1.sha256sum] = "06ad906fb13d6844ad676d4203a1096ae4efc87fe1abcea0481c507df56d8c98"
 
@@ -47,6 +48,7 @@ INITSCRIPT_NAME = "parsec"
 # The file should also be included into SRC_URI then
 PARSEC_CONFIG ?= "${S}/config.toml"
 
+
 do_install () {
     # Binaries
     install -d -m 700 -o parsec -g parsec "${D}${libexecdir}/parsec"
-- 
2.43.0


