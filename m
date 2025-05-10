Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20542C3ABC3
	for <webhook@archiver.kernel.org>; Sat, 10 May 2025 15:50:49 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.13225.1746892242278326429
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 10 May 2025 08:50:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XHNM3bBx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441c99459e9so19830075e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 10 May 2025 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746892240; x=1747497040; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFXzzPPWb4oCRc3diw4V8LAqtXamh/qwX0dZtGe6qys=;
        b=XHNM3bBx4wcaRJ7RSWjKWRiYOrkdX50I4tUhMxxrR9i5s+Vtao5iIuiVlqkY5hv0Jd
         g3gJ5dqkOwf9+Dn2CDiTxxYveS+k2H6nrhLWFAj9Cy8TpPY8STQcG8EayTEdNLuXt8g1
         cvw6aXoyH+xr1ocPBYSpqQyM8tqyUtCbSlhas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746892240; x=1747497040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFXzzPPWb4oCRc3diw4V8LAqtXamh/qwX0dZtGe6qys=;
        b=C98UwVa4C/8+ckWahFHZTIGa7k8SvgOBXJztTIGCr1bOUyOVZu7rYzcEOh5Ng1kjM2
         lDQvC8HCy3HhM0vqNo9EcPxpooaPBrSn6V85yRAciSbBYB5XbU4XpCqdkSmYPAfJtiHY
         4Q4lldP0rTDxbstDAtsV5ky9RPSs5Grb/EYzUGdBbHu1eL01evcYx83NhApKwNVn+T2K
         /4S5F/kFTzihwqqoR90Nc1aRp90EblefaP+ZXFmyygf49A+j9nJpSwHtLKOBQhnjwoES
         DkGxxo/oaLu9M1L52Zxqo4Oth+CRwvtSciZx1X7got0TJXbMDG0YBHapnE8nv6qaBEFI
         V0gg==
X-Gm-Message-State: AOJu0YxgbEkHhCD2KcjyfJYhtx8hitjhE3RaPpz/Dvw/e51L2cqxmrT7
	zmi0r6aDWtD18otI5dutOupFVuNTjQoLDfK5ojGnyCJyqbrjKSLol/aZSwKocYq3/zWHJsgcIkX
	S
X-Gm-Gg: ASbGncs5JYxeQ80zeoCeUDzqHJCVh+HWHmokUKGaiGFDkl9mWXFB21UwPfK5+SvvSKq
	R5ip8ARSgNQLFBq/Hmst49IfP3F/Y2ZqYzbCUOpn99w7V5lCTOpsjnrtb3GwMxNwFBUSqp9ToOK
	UdMA6p38oF4S7EDigN+V4jhnTrfigpjlkBa7FhQquiX92q3M7a6ogY5srt2sp8ZkGSqZB72vOMF
	GZgJd+ZBi1y2YYBgyHMxQMdwRR/L1sJ4TBq3CyxZJVr+HyclJ+TsgHkfc5mJBl1mUhKem4zWtiX
	DWh6d7WpXzhU0gv3BJx6pT41xu1mdy1nDnxL50P2rAJazRHoACz8UyRU7enboSmsbvU+V7TTlyY
	51C4=
X-Google-Smtp-Source: AGHT+IE8OE6cYIvtW7sWvxmZsYWP36p1bVnhDSErSdRjTB1MqSPKWZTiKmuVFsIbWBx/a51ANtRS5g==
X-Received: by 2002:a05:600c:6814:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-442d6ddec51mr52779275e9.28.1746892239923;
        Sat, 10 May 2025 08:50:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a9b:4e3e:ebc0:91d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57dde0esm6850010f8f.18.2025.05.10.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 08:50:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH] pseudo_client: Add support for PSEUDO_INCLUDE_PATHS
Date: Sat, 10 May 2025 16:50:38 +0100
Message-ID: <20250510155038.871646-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 10 May 2025 15:50:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1541

We've often wondered if things would be better with a path include
list instead of an exclusion list. Add support for this so we can
test that theory

If set the include path takes precedence over the ignore path list.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 pseudo_client.c | 22 ++++++++++++++++++++++
 pseudo_util.c   |  1 +
 2 files changed, 23 insertions(+)

diff --git a/pseudo_client.c b/pseudo_client.c
index 9fd68b5..8a07341 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -1566,6 +1566,28 @@ int pseudo_client_ignore_path_chroot(const char *path, int ignore_chroot) {
 	if (ignore_chroot && pseudo_chroot && strncmp(path, pseudo_chroot, pseudo_chroot_len) == 0)
 		return 0;
 
+	env = pseudo_get_value("PSEUDO_INCLUDE_PATHS");
+	if (env) {
+		char *p = env;
+		if (*path == '\0') {
+			free(env);
+			return 0;
+		}
+		while (p) {
+			char *next = strchr(p, ',');
+			if (next)
+				*next++ = '\0';
+			if (*p && !strncmp(path, p, strlen(p))) {
+				free(env);
+				return 0;
+			}
+			p = next;
+		}
+		pseudo_debug(PDBGF_PATH | PDBGF_VERBOSE, "ignoring path: '%s'\n", path);
+		free(env);
+		return 1;
+        }
+
 	env = pseudo_get_value("PSEUDO_IGNORE_PATHS");
 	if (!env)
 		return 0;
diff --git a/pseudo_util.c b/pseudo_util.c
index aa989cb..a94a4da 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -43,6 +43,7 @@ static struct pseudo_variables pseudo_env[] = {
 	{ "PSEUDO_BINDIR", 13, NULL },
 	{ "PSEUDO_LIBDIR", 13, NULL },
 	{ "PSEUDO_LOCALSTATEDIR", 20, NULL },
+	{ "PSEUDO_INCLUDE_PATHS", 20, NULL },
 	{ "PSEUDO_IGNORE_PATHS", 19, NULL },
 	{ "PSEUDO_PASSWD", 13, NULL },
 	{ "PSEUDO_CHROOT", 13, NULL },

