Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2B7C4450A
	for <webhook@archiver.kernel.org>; Sat, 18 Jul 2026 04:38:02 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.545.1784349474319354607
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Jul 2026 21:37:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=C594DpRT;
 spf=pass (domain: gmail.com, ip: 209.85.214.177, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf41bab353so10885425ad.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 21:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784349474; x=1784954274; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cf2DFrficqlE66poupyya5mgQfMx4Kdcxjo3xsRs0OY=;
        b=C594DpRTT2HbQJC9NYYJKJtXqFJlTJpYrUFIzqhea3reSFYVI1Ko70bRXl/SNvuw7A
         vRzk6ct3rz/ePFRuu/xvz8hH5eq/HOuCgzDq+eApZmSPk3pL629KW8tT+nK5wPl1vwa4
         6icnTjJxrh4dqggeG/rFN0YXi2SY5vftTmKx0mry5cNzHExZfZbiCX+1wEsAxsLKBg0K
         6iPuVqIFkM4SDZDzgmeARcdTedPEux8ynqSk77u0VErJBpJtUq4+x/lBMkJ6pSwSmsv+
         7UcNJf4oTkgX4FnWOxmiPnA5A+SZmCNP/mX8J3PK4lursYpuXkJ3evC2lEGgoFFpxCO0
         eN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784349474; x=1784954274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cf2DFrficqlE66poupyya5mgQfMx4Kdcxjo3xsRs0OY=;
        b=ZiMGVmV+Vu30XleQeWuCP4LN8z844smWGIddSvJ/sqdY/AEGNrvDCB86YikG1mIFTc
         2b2QUIFfjwjKq42JVpeLYznWv54EP4x1s2yMmBpLRmcNLhtWN+++yj1BHduOpvX0Kvyi
         dTmBRPK9nOL9yO6DQrBWXl2/DSzknHPATbwwKEmbQr9IfzfCULWuanmtIUTZd/a9O//y
         MPPOMYk4znyxPRxoW3GjKN9wOiQjzvjNDg1XaXKFKtnLvpTfqT6yxwdtqSp7/uXHHoW/
         eL5k1MMCQCGa8ITBXcvy48lCD/YrW4R4BBaw9DtVJ71i2eR3U4nC4mlx5jBBCJABz1Jd
         4aGg==
X-Gm-Message-State: AOJu0Yz6x4D0do4UDk1aR6xQBh0nqYD3lMpT8+e7T3jiBRhe+NOyOwgV
	SdtbZSm08JOVFh877gGXiA9RtdgFIe61xT3FdE+gYenv7vMV+Fx4k/nmkiLnmrqscpM=
X-Gm-Gg: AfdE7cm3d1tdga03amBVyL0tNXzjOzI712edMc+ckZhgkadCChZzWovoPxUZtfvVj4J
	eU3uRQSMrdv6dj+/KqJcjyZhHU58Ol1sepEN82tqcSCYNWoUEnms8YwvLwI3MMmtCpXhMLvP7UA
	7eGkPL+gNfv45v7q4jwPQu1B1+nizlbO467yK6WqnJmT/nW4Rg514DQchdolcDNR6Y1jN5fomCS
	siub2kTiqdKh5kAiQvmnsq4sGotcQwnqn7bIS5ipyGpMynmpGlJ8AgnrPfloC+p1Zf/GK5WPIbb
	kWAnc44XU6amnZ/PG0oHZHYMeqHZ6+OFio/QsnAfGY7OkL+oQ2J8LgU1GqMG1AVjsapJ8X4iRx0
	QHyqM9WzD3Tz6aO9YgoddeZY9T1BkgCeOPaHfmL7bS1kexCMTRSNQlgEbuCb+jiz1dzrNoFwSgs
	CuW1nznzwYb1Px35+FvQbLJI4=
X-Received: by 2002:a05:6a21:4516:b0:3c3:cf9b:fb8b with SMTP id adf61e73a8af0-3c3cf9bfcd0mr478347637.68.1784349473660;
        Fri, 17 Jul 2026 21:37:53 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f8f067sm1626903a12.10.2026.07.17.21.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 21:37:53 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>,
	Paul Barker <paul@pbarker.dev>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH 1/3] pseudo_client: step fully past pseudo's own fds when computing startfd
Date: Sat, 18 Jul 2026 04:37:48 +0000
Message-ID: <20260718043750.7-2-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718043750.7-1-bbnpreetsingh@gmail.com>
References: <20260716055633.7-1-bbnpreetsingh@gmail.com>
 <20260718043750.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jul 2026 04:38:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4508

OP_CLOSEFROM and OP_CLOSE_RANGE compute startfd, the first descriptor
the caller may hand to the kernel wholesale, by stepping past each
descriptor pseudo needs to keep:

	if (connect_fd > startfd)
		startfd = connect_fd + 1;

A protected descriptor exactly equal to the running startfd fails that
test and ends up protected by nothing: the close-by-hand loop stops
below startfd, the kernel sweep starts at startfd, and the descriptor
is closed even though it is on the protect list.

The default descriptor layout hits this. Client init opens the local
state directory fd and then connects to the server, so the two sit on
consecutive numbers, say 21 and 22: the local state fd raises startfd
to 22, connect_fd == 22 fails the > test, and closefrom(3) or
close_range(3, ~0U, 0) hands 22 straight to the kernel. The server
connection is closed out from under the client.

The client transparently reconnects on the next operation, which is
why this has gone unnoticed, but until that reconnect the stale
descriptor number is free for the process to reuse, and anything
pseudo believes about the connection is attached to the wrong
descriptor.

Use >= so startfd always ends up above every protected descriptor.

Present since the startfd computation was introduced in 21ff2fb
("ports/linux/guts: Add closefrom support for glibc 2.34").

AI-Generated: Uses Claude (claude-sonnet-5)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 pseudo_client.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/pseudo_client.c b/pseudo_client.c
index 1acd948..085a8b3 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -1966,15 +1966,15 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 	case OP_CLOSEFROM:
 		/* no request needed */
 		startfd = fd;
-		if (pseudo_util_debug_fd > startfd)
+		if (pseudo_util_debug_fd >= startfd)
 			startfd = pseudo_util_debug_fd + 1;
-		if (pseudo_localstate_dir_fd > startfd)
+		if (pseudo_localstate_dir_fd >= startfd)
 			startfd = pseudo_localstate_dir_fd + 1;
-		if (pseudo_pwd_fd > startfd)
+		if (pseudo_pwd_fd >= startfd)
 			startfd = pseudo_pwd_fd + 1;
-		if (pseudo_grp_fd > startfd)
+		if (pseudo_grp_fd >= startfd)
 			startfd = pseudo_grp_fd + 1;
-		if (connect_fd > startfd)
+		if (connect_fd >= startfd)
 			startfd = connect_fd + 1;
 		for (i = fd; i < startfd; ++i) {
 			if (i == pseudo_util_debug_fd || i == pseudo_localstate_dir_fd || i == pseudo_pwd_fd ||
@@ -1992,15 +1992,15 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 	case OP_CLOSE_RANGE:
 		/* no request needed */
 		startfd = fd;
-		if (pseudo_util_debug_fd > startfd)
+		if (pseudo_util_debug_fd >= startfd)
 			startfd = pseudo_util_debug_fd + 1;
-		if (pseudo_localstate_dir_fd > startfd)
+		if (pseudo_localstate_dir_fd >= startfd)
 			startfd = pseudo_localstate_dir_fd + 1;
-		if (pseudo_pwd_fd > startfd)
+		if (pseudo_pwd_fd >= startfd)
 			startfd = pseudo_pwd_fd + 1;
-		if (pseudo_grp_fd > startfd)
+		if (pseudo_grp_fd >= startfd)
 			startfd = pseudo_grp_fd + 1;
-		if (connect_fd > startfd)
+		if (connect_fd >= startfd)
 			startfd = connect_fd + 1;
 		/* the fds below startfd are the ones our own are mixed in
 		 * with, so close those by hand and skip the ones we need
-- 
2.43.0


