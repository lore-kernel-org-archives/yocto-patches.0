Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB2AC53200
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 14:42:33 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12998.1785336150153930491
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jul 2026 07:42:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZrZVsWXv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso7410695e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785336148; x=1785940948; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9IQn2yRAd4AWsfT3uOfNsxY4nvJwLR/zP1mIZLrVlXY=;
        b=ZrZVsWXvc67mxy6Fdu8bImQvrIMKjxIWO1tKYgWFKpviSeulW7uDIHkoq+Fof27LqF
         rDqn4RD9jJ7B4yECmpETYESE7dFiu6hn2d46hYMCNNzI7lWMmlPYz79Jp3TKQTwxwuFk
         3yAUTd1kqojeo+5U/g6fIZgPEyzivZl0AcQ7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336148; x=1785940948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9IQn2yRAd4AWsfT3uOfNsxY4nvJwLR/zP1mIZLrVlXY=;
        b=E82jj+Smaa+qGTAuOE+lxIP0KUdF7JTh5WW0AKZQKUWfkrjWcwU+K4yBnLUVECJIyh
         9hoRKtV+H6/Oik4a364fEBuZeixoOzjuetP//gzKtTe/m4alOceKXS2ddVNYVrrco+oT
         Q76Kh3gzQv8rvfJvFImeHC8NPftplaea7hTjLB6joSLN4LQivEBxHgv3k4iUv25E1+sK
         Y6rQs44NQhgT9EQu/36fitYMYFbGLcJWsGgfmbsc98EJ4s+GSrB0ZBpbGCJx9NDAV+yx
         tUfA/+jS3mgvuQUGQdQFCt76RavQllo7gnLxrbRqA5+6X1/mzI+k7tZfVUp2f2r1D4tf
         JhLg==
X-Gm-Message-State: AOJu0YwHzK/jl7rEhXK9H2gPmxvCmc7/0wMbrP0K9rzb64JI98fJsu7h
	G37FVMvxeAmMdKBoKm/gTH5X24jUky4gdVpjkp4vdwJEXwZBtHfGcfmMQEMAwBKWHZBfrQWPrLn
	zUPOOTW0=
X-Gm-Gg: AR+sD131GwJ0U1dl/jcqia6nFtDOH//Z0fDezidnlxPUPwtowlIXUTQa6QL+os0khol
	pXxIPuqYNLpElnCqWEoe+f841pdzad4eXPJPmIMN8FTO4A+UBQq25Xwk74BjFo/BIBlNGTEpvWq
	mDiGA/flts4fmvrxfaXYyg5i6FY7lxjVx8ALzGbXJiZpM+ZnF3KyWOHO5pDKF8NdE9drqN94925
	ppULXyvqyaJTe9hOYR377Czn+6LvppDndwkdELPdlwA7cb77OAlnDPuO/33L3zlEzJdv1+QlEau
	6lbm0ym1LPPrIRSzR0VJK+mPR5r0ZMHjM37I1D97zDQn6ZZipMWGVzgPWEBCb2URYHCG2jHAeul
	8l7TJpck1juKxqudyZUFJE5/8blDYlVzqRcrGKKJFGqZ3DzsneezsBfeGAZzpBJhzB8RS8Gr78Y
	0YXFojokOFPSnWh/2ue6ap8jGAtXNlk8zdpN2cu3Czu6ukavB5WLbuipF4eZoIct8v60k0I8dN3
	Og2emKaGL9Mrdp9hg==
X-Received: by 2002:a05:600c:350e:b0:495:64c7:804f with SMTP id 5b1f17b1804b1-496c6575c6bmr82476575e9.23.1785336148300;
        Wed, 29 Jul 2026 07:42:28 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3647:86f2:68ea:efc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3a32sm8602233f8f.2.2026.07.29.07.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:42:27 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 1/2] ports/linux/guts: Add __open64_2 wrapper
Date: Wed, 29 Jul 2026 15:42:25 +0100
Message-ID: <20260729144226.2680004-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 14:42:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4565

The wrapper for open64 when using fortified source was missing, add
it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ports/linux/guts/__open64_2.c | 15 +++++++++++++++
 ports/linux/wrapfuncs.in      |  1 +
 2 files changed, 16 insertions(+)
 create mode 100644 ports/linux/guts/__open64_2.c

diff --git a/ports/linux/guts/__open64_2.c b/ports/linux/guts/__open64_2.c
new file mode 100644
index 0000000..edbeb1a
--- /dev/null
+++ b/ports/linux/guts/__open64_2.c
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) 2026 Richard Purdie
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * static int
+ * wrap___open64_2(const char *path, int flags) {
+ *     int rc = -1;
+ */
+
+       rc = wrap_open64(path, flags, 0);
+
+/*     return rc;
+ * }
+ */
diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
index 0e275d5..3cea20a 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -1,5 +1,6 @@
 int open(const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int __open_2(const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
+int __open64_2(const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 char *get_current_dir_name(void);
 int __xstat(int ver, const char *path, struct stat *buf);
 int __lxstat(int ver, const char *path, struct stat *buf); /* flags=AT_SYMLINK_NOFOLLOW */

