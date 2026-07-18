Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05318C4451C
	for <webhook@archiver.kernel.org>; Sat, 18 Jul 2026 04:38:03 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.546.1784349475515694134
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Jul 2026 21:37:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TvzfVOhl;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so4984389a91.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 21:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784349475; x=1784954275; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MaubIf90lb2cTNsVlSgcgxb7xw7j4mFfJsZy5gpnhiA=;
        b=TvzfVOhlDmAkxKgao93Oq/2+ym5gfgpkBjsewgNaWl57aDNcZM1I9LRmxe+q6taKHW
         wF6bTCuy7HWqBcjkS+CeL5XeufUY6+T0Br6cuRZrbL+nLPuBKMZjz2r1RQzW7zHun/RP
         9u8YZwJx7p/vgkCkNB+VLGgDUtXuN42TgkDjUPVyQ67n6HNIq2p3M81rxtJtAfjA2ZkK
         zMSZ6QaGqC8G/zKbhyrOgk+1GBwQXcaBLLsFprYk3xb5GGLcUeavgiRSC0YyBlu4PZJa
         ejiE1b3Jq5ZckiYg9Xo7Fwy8dWtcFwXOwIDQZWxrSDNCeYNR3PCq8ffH0vXDIt7m+OqD
         Np4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784349475; x=1784954275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MaubIf90lb2cTNsVlSgcgxb7xw7j4mFfJsZy5gpnhiA=;
        b=CFrRL2OQ5KPDz3ruwbtEQbixXrkY+1UiJIC43nvqvrHlP0M+AtAbJxzJky0QOix7Xx
         KO3qIL4FrdCceYTgcdrLsRhHMmbjyiJfFlvr5FtyCUe+iUe2uGiLTfo6C4RkhtTDx8zc
         yamktSM4CzVqXfvgO5rW1PuMbKbAyVroez2sQ5khWTt5um7cOV5GTQVC5fKs1mcaMKZH
         qlUh28Ct9iFtVMPwjR19CRZ24G5otYjLNS1GAsRjsYyoMweyiNCRb6HRBFAel+a54H05
         U1yqSmQ+syoswVrTD6fb8zgecUm3JoT48UguDNTUg8tmo8qyiqafKkXa4ok3LudU6r8Q
         rnRA==
X-Gm-Message-State: AOJu0Yw+EtruJJsftJc42MQN6HcfY5XJrIkbkpsee+4fdwqGZ85CyHmb
	YWkrZMEwG+ddDZkVgm7ksIJ1OEoiBQgMUeU/85ntrokQIuGiNVrcs7YUwpmOJ8+JjCc=
X-Gm-Gg: AfdE7cnnJPno0bvcpCym56PPEz84GkneerW7PhieoU/xLCvx/B3kEp7O8gVMYxXIt9n
	GwAjwLpj6223whPf+v/25QHjs2sn9ERIWJK9ynMH0TMasy8ovxJRJMyz6GouLyAvZrJOF0+fmgx
	gTpf4QzDvQVOapnT9Bac4EFKD+xavFJibD6C+UbrdUwmIV5bqOAwgXfqizI6KKKZK7YlxRCjw1G
	d7adG9aHYafgQ/3zBBmKaUhrsK8zCv4hOXOp2NC2MlQksSqf/opE2hcR3xeA28FfICOX0vg/AHe
	gKkxtO9kjMCDYl3w0YW9oglxKcH+KxRvymseIG8hK7c0bfjPTq2TsePnPIFR2hkFEvfYM1LLP8S
	hs0zXt5o+QJooZmLMwItdlg+ugPjtJJNiaurhoTk88WxtmAWc5x5TD/x8vKl8/VltBsDNSgXGtN
	EavQ==
X-Received: by 2002:a05:6a20:d52b:b0:3c3:9698:daff with SMTP id adf61e73a8af0-3c3ada42d88mr5691765637.68.1784349474849;
        Fri, 17 Jul 2026 21:37:54 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f8f067sm1626903a12.10.2026.07.17.21.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 21:37:54 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>,
	Paul Barker <paul@pbarker.dev>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH 2/3] pseudo_client: step around all of pseudo's own fds in closefrom/close_range
Date: Sat, 18 Jul 2026 04:37:49 +0000
Message-ID: <20260718043750.7-3-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718043750.7-1-bbnpreetsingh@gmail.com>
References: <20260716055633.7-1-bbnpreetsingh@gmail.com>
 <20260718043750.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jul 2026 04:38:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4509

OP_CLOSEFROM and OP_CLOSE_RANGE step around five descriptors pseudo
keeps for itself (debug output, the local state directory, passwd,
group, and the server connection), but pseudo can hold three more,
and a sweep will close those:

- pseudo_util_evlog_fd is where pseudo_evlog_dump() writes the
  in-memory event log at the moment the client gives up on the server
  connection for good. It defaults to 2, so stepping around it matches the existing
  treatment of pseudo_util_debug_fd, which also defaults to 2 and is
  already protected. A closed (or worse, silently reused) descriptor
  here would misdirect exactly the diagnostics needed to debug a dead
  server.

- pseudo_pwd_lck_fd is open between lckpwdf() and ulckpwdf(), which is
  precisely the window in which a caller works on the passwd files and
  may sweep descriptors. Once the sweep has closed it, ulckpwdf()'s
  close() can land on an unrelated descriptor that reused the number.

- pseudo_prefix_dir_fd is opened at client init and stays open for
  the life of the process.

pseudo_pwd_lck_fd is -1 while no lock is held, which the existing
pattern already copes with: -1 never raises startfd and never matches
a descriptor the close-by-hand loop visits.

pseudo_util_evlog_fd had no declaration outside pseudo_util.c, so give
it one in pseudo.h next to pseudo_util_debug_fd.

[YOCTO #16339]

AI-Generated: Uses Claude (claude-sonnet-5)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 pseudo.h        |  1 +
 pseudo_client.c | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/pseudo.h b/pseudo.h
index b6c13f2..44ee991 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -29,6 +29,7 @@ extern void pseudo_debug_flags_finalize(void);
 extern unsigned long pseudo_util_debug_flags;
 extern unsigned long pseudo_util_evlog_flags;
 extern int pseudo_util_debug_fd;
+extern int pseudo_util_evlog_fd;
 extern int pseudo_disabled;
 extern int pseudo_allow_fsync;
 extern int pseudo_diag(char *, ...) __attribute__ ((format (printf, 1, 2)));
diff --git a/pseudo_client.c b/pseudo_client.c
index 085a8b3..7f80a3b 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -1968,16 +1968,24 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 		startfd = fd;
 		if (pseudo_util_debug_fd >= startfd)
 			startfd = pseudo_util_debug_fd + 1;
+		if (pseudo_util_evlog_fd >= startfd)
+			startfd = pseudo_util_evlog_fd + 1;
+		if (pseudo_prefix_dir_fd >= startfd)
+			startfd = pseudo_prefix_dir_fd + 1;
 		if (pseudo_localstate_dir_fd >= startfd)
 			startfd = pseudo_localstate_dir_fd + 1;
 		if (pseudo_pwd_fd >= startfd)
 			startfd = pseudo_pwd_fd + 1;
+		if (pseudo_pwd_lck_fd >= startfd)
+			startfd = pseudo_pwd_lck_fd + 1;
 		if (pseudo_grp_fd >= startfd)
 			startfd = pseudo_grp_fd + 1;
 		if (connect_fd >= startfd)
 			startfd = connect_fd + 1;
 		for (i = fd; i < startfd; ++i) {
-			if (i == pseudo_util_debug_fd || i == pseudo_localstate_dir_fd || i == pseudo_pwd_fd ||
+			if (i == pseudo_util_debug_fd || i == pseudo_util_evlog_fd ||
+					i == pseudo_prefix_dir_fd || i == pseudo_localstate_dir_fd ||
+					i == pseudo_pwd_fd || i == pseudo_pwd_lck_fd ||
 					i == pseudo_grp_fd || i == connect_fd)
 				continue;
 			pseudo_client_close(i);
@@ -1994,10 +2002,16 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 		startfd = fd;
 		if (pseudo_util_debug_fd >= startfd)
 			startfd = pseudo_util_debug_fd + 1;
+		if (pseudo_util_evlog_fd >= startfd)
+			startfd = pseudo_util_evlog_fd + 1;
+		if (pseudo_prefix_dir_fd >= startfd)
+			startfd = pseudo_prefix_dir_fd + 1;
 		if (pseudo_localstate_dir_fd >= startfd)
 			startfd = pseudo_localstate_dir_fd + 1;
 		if (pseudo_pwd_fd >= startfd)
 			startfd = pseudo_pwd_fd + 1;
+		if (pseudo_pwd_lck_fd >= startfd)
+			startfd = pseudo_pwd_lck_fd + 1;
 		if (pseudo_grp_fd >= startfd)
 			startfd = pseudo_grp_fd + 1;
 		if (connect_fd >= startfd)
@@ -2006,7 +2020,9 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 		 * with, so close those by hand and skip the ones we need
 		 */
 		for (i = fd; i < startfd && (unsigned int) i <= close_range_maxfd; ++i) {
-			if (i == pseudo_util_debug_fd || i == pseudo_localstate_dir_fd || i == pseudo_pwd_fd ||
+			if (i == pseudo_util_debug_fd || i == pseudo_util_evlog_fd ||
+					i == pseudo_prefix_dir_fd || i == pseudo_localstate_dir_fd ||
+					i == pseudo_pwd_fd || i == pseudo_pwd_lck_fd ||
 					i == pseudo_grp_fd || i == connect_fd)
 				continue;
 			pseudo_client_close(i);
-- 
2.43.0


