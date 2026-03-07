Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1307BFC9EDF
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 09:09:25 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5962.1772874557377082673
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 01:09:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EhrENJA5;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48532925a4bso141715e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 01:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772874556; x=1773479356; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JL0brlN/6Te1yuocc3KHXuzqh7jdUZ2eKVFySNUSqMI=;
        b=EhrENJA55MSeY59twBSkCUM9PtQcLU9I8HpXDf5Kjs8YfLNVR3jA0LAMBLTnso15Rw
         6oP1fpQr01xd5RA51JN/6Phn+f0ik3s0l/ZVtqzM0Y9bbVK2q5G8yT30YSB5hEzavTLL
         UJDI72LYHaGXYEnoQSJ+PPG1e/d5/DPAeo3+MdFmmxcwZHhoc76/cFp4svsZWnp72jWc
         fThkhQbnZOhV85H7Bm1XGjdHf7gqRzuRrxpXEXUnNz5MNlplNCwR24LDnXT1LaRa1YY5
         kD7VfUvt3rIaNhNMWlfOW636QBuTkjTw82tAGYTbtQkpQmyLyGLFiOiW9L0+k/M7JYf3
         md3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772874556; x=1773479356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JL0brlN/6Te1yuocc3KHXuzqh7jdUZ2eKVFySNUSqMI=;
        b=mOH7/a8TrCdTTzuiRFMbD1ycdZcrpbgjEUyjrYdvmVH7S2L+oaneemV9VYZoGNwEJ4
         0xk3vlOElBC2QmEDZgFnikd6A6C7M7blidaKYLHptc8jxkj7iWM6G4L10KWfeEUkYOPy
         1/tG7lapfC+H3geuSEBXi3jlkP0OIxbyFlRpPzswyWKw2RQwbkzhglWV1whztPQfMcAv
         gTYBcnQvznmETGEOEPLGhYYmAxZ3uzv+JgaC4QBKlHktAcGA+5HrOwGpKks1DthcO4N6
         uMAbLkDtJNYcHegGGL1Y0F4cEai2DcUDfwyuMwDZy0YCOq9yTffX11DOs9yQkhUtCpS2
         y0Pw==
X-Gm-Message-State: AOJu0YywEPbPenMj3zDDPmyS3HTK/aqfdPuVZV3ffObMzd0GhGov2Xaz
	yPzl2grWx3Pc5eYxlqXMhdQzgA/KrkxOOZpxr7fQ3ZJ20V+fty/wCMmsVfAQrzOF
X-Gm-Gg: ATEYQzzrqneI83F2pPTVdiG5JyCo3Yyk8WNyzm34OfYSWgzT3rxkYVFZxfn/CVD/vHc
	wdEjSMXcZNrVA8pjirCuDvxSL1SIXiWLYylkpf8aCRtutO9pLnRcugVNfRhVELZx5RNvlyxPy7u
	YW3CqEgxYZOwVyGrE+j1W4aJsqmorOA5sENmINPhq/DmglIPLyCiJp1Q6nzyHLlz1iP6/0VGDbn
	x+HTZitbtp78vYFoeAct2SErIIBKgyCeRSQNLAmBPqzLyQp+9gI2VhBiRHPrQ8dXd0i7cJHoG9a
	e6KLJForaMMA5lsWodsCI3B04TiIoyva+dG4w4g0MPiyi7LTRLMiRXKikO6qHt8ZnZuAf0WNDkU
	Dc2TnZLrEFzsm8WPF+Xmm7zRVytKWfc81d/QtnTpWmDLVRutYiQa8DMod3Gy4sGshPgjIuFsfIB
	8ICG/zkPegn6Vo17mfSxQ9Gf/0E/zBNI/7ddDJ
X-Received: by 2002:a05:600c:a00a:b0:485:2fc5:39e with SMTP id 5b1f17b1804b1-4852fc50624mr15290805e9.27.1772874555251;
        Sat, 07 Mar 2026 01:09:15 -0800 (PST)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad97be5sm10488954f8f.11.2026.03.07.01.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 01:09:14 -0800 (PST)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [pseudo][PATCH] openat2: use const struct open_how
Date: Sat,  7 Mar 2026 10:09:06 +0100
Message-ID: <20260307090906.5609-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 09:09:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3363

From: Martin Jansa <martin.jansa@gmail.com>

To match
https://sourceware.org/cgit/glibc/commit/?id=0f0a5cd338998f4b603f52f3ce2163df0db7b814

Otherwise it fails to build with glibc-2.43:

In file included from pseudo_wrappers.c:300:
pseudo_wrapfuncs.c: At top level:
pseudo_wrapfuncs.c:11537:1: error: conflicting types for ‘openat2’; have ‘int(int,  const char *, struct open_how *, size_t)’ {aka ‘int(int,  const char *, struct open_how *, long unsigned int)’}
11537 | openat2(int dirfd, const char *path, struct open_how *how, size_t size) {
      | ^~~~~~~
In file included from /usr/include/bits/fcntl-linux.h:492,
                 from /usr/include/bits/fcntl.h:61,
                 from /usr/include/fcntl.h:35,
                 from pseudo_wrappers.c:23:
/usr/include/bits/fcntl-linux-fortify.h:36:1: note: previous definition of ‘openat2’ with type ‘int(int,  const char *, const struct open_how *, long unsigned int)’
   36 | openat2 (int __dfd, const char *__filename, const struct open_how *__how,
      | ^~~~~~~
make: *** [Makefile:162: pseudo_wrappers.o] Error 1

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 ports/linux/openat2/guts/openat2.c | 2 +-
 ports/linux/openat2/wrapfuncs.in   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/guts/openat2.c
index da01b31..366fb95 100644
--- a/ports/linux/openat2/guts/openat2.c
+++ b/ports/linux/openat2/guts/openat2.c
@@ -4,7 +4,7 @@
  *
  * SPDX-License-Identifier: LGPL-2.1-only
  *
- * int openat2(int dirfd, const char *path, struct open_how *how, size_t size)
+ * int openat2(int dirfd, const char *path, const struct open_how *how, size_t size)
  *	int rc = -1;
  */
 
diff --git a/ports/linux/openat2/wrapfuncs.in b/ports/linux/openat2/wrapfuncs.in
index 96ae8a7..2f1e716 100644
--- a/ports/linux/openat2/wrapfuncs.in
+++ b/ports/linux/openat2/wrapfuncs.in
@@ -1 +1 @@
-int openat2(int dirfd, const char *path, struct open_how *how, size_t size);
+int openat2(int dirfd, const char *path, const struct open_how *how, size_t size);

