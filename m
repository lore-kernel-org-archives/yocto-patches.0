Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B6F94CB3
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 21:24:22 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51374.1776806654832002744
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Apr 2026 14:24:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gOXixYaS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-441209fb77eso752885f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776806652; x=1777411452; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDHB56F8cXiyWZe/UmOoCDthSH/h2NkzLoZzv15IYtI=;
        b=gOXixYaS3enELQ5msAFX7f8RMKGHIB4ozduROIeUa7/OsLWA329yfXT4+SNtXYAcj5
         6q0lP+m0TLCisNDFgPpPYee0OIYrLTvm/3Lv5+xC16kDf7BcnXbTvacVSjH/2txCyIPO
         hbMLvE4bhoq99Apncw9PKFL+hVIDZdFG2VfKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776806652; x=1777411452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDHB56F8cXiyWZe/UmOoCDthSH/h2NkzLoZzv15IYtI=;
        b=FavD6q+yXpWHgQqh0QNYifm0v8VBmiO6E00u8mss4H9Ycdm9i90mymfQk3WWHanr/N
         1UjJPNc9U1jkWf98DY8ZVSlMFDindRco7DIRvDpb1kMAFycYDSnRDJ6Tif74TEneecyW
         JR0dXnH6yhSDX5ESI54rh+ueO4BdE73B1+SJ5iaoCoDplR/KehWc9oVkxqYNa8rvHcrn
         VD3HbU4OM3/+2OZlz/F4sj7gDRDpnEPNUcGAvnSbA6T41uIf6Nm9Sc0dHfDwNipRJ0j4
         ASCWlxHyfVFaj4tXYZrzlvcAfZXBwRtcq68Jl2NKzOMvL0oDzYBh03cMk7l/0eLOrmOF
         Kk0A==
X-Gm-Message-State: AOJu0YyEhlGVqDN9GwsUyH+knsTpyWah3MEqQnGmsVYkaqeet2OSyf2l
	kGhHn/DGRtu/ejBeuR0kbuSnugQi+7BZBidnIWmaRzQmJx6s3msYCHCkDdEaX55P/xw1iAP4QzX
	K2XeIFYs=
X-Gm-Gg: AeBDiesX/WTTZaRTRy7vwdGXzUITItuupUpi7cyBAhh98kclqi1QU9vooXDV0/v1pxC
	MCdaHiL+a00cVpuJ8r0COTwsUJi/q1nGae+7DkKd8CSsb9w7gT0dfeF844xw90X/J67dfUa+COp
	4z8VaTXjqWz1n8Mosb8P+nj3iAnGALdI8j9qz7hkoVwtT1BC+H4sp+hDhGBZU+Id/nZAABrrOIc
	oBfuZ1fyqaTs52l6g6Bnakzi4Yqi4afpeiZdogQ4Y1T4AhMTUuEbEqZfjLjbaw5Y1j/WKqo+FJI
	+BmNii1eeLotO8r38jABLjugKSQUMBy5mcaKT0CW4Wa4dWXlYrn71g7la+CiYwwAw+ocaqqIwuc
	FDgHmN1dWawARx8oyeD8AKGrRi+KpPY1tyr/VppBAzUvg9K3h0DEJyplp4Z8YUEJqEymQWJsQx3
	R/sMtYMobwETModaBIK34mevvsfDEYg7Z4UEFUoDclYrQQnLkV91VrvfdnQ4/BHw==
X-Received: by 2002:a5d:6e66:0:b0:43d:7cc0:dac2 with SMTP id ffacd0b85a97d-43fe409de50mr21142163f8f.30.1776806652252;
        Tue, 21 Apr 2026 14:24:12 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a94:2069:4c49:3b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a071sm4990285f8f.21.2026.04.21.14.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 14:24:11 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH] ports/linux: Add missing __open_2 wrapper
Date: Tue, 21 Apr 2026 22:24:10 +0100
Message-ID: <20260421212410.3716914-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 21:24:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3755

Somehow we've missed the wrapper for __open_2 for far too long (over a decade!).
It can be called from useradd in shadow, so add the missing wrapper. We already
have the similar __openat_2 wrapper.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ports/linux/guts/__open_2.c | 15 +++++++++++++++
 ports/linux/wrapfuncs.in    |  1 +
 2 files changed, 16 insertions(+)
 create mode 100644 ports/linux/guts/__open_2.c

diff --git a/ports/linux/guts/__open_2.c b/ports/linux/guts/__open_2.c
new file mode 100644
index 0000000..7e54c8f
--- /dev/null
+++ b/ports/linux/guts/__open_2.c
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) 2026 Richard Purdie
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * static int
+ * wrap___open_2(const char *path, int flags) {
+ *	int rc = -1;
+ */
+
+	rc = wrap_open(path, flags, 0);
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
index 234a13c..0e275d5 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -1,4 +1,5 @@
 int open(const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
+int __open_2(const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 char *get_current_dir_name(void);
 int __xstat(int ver, const char *path, struct stat *buf);
 int __lxstat(int ver, const char *path, struct stat *buf); /* flags=AT_SYMLINK_NOFOLLOW */

