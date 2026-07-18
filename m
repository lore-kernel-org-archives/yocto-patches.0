Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E289C44521
	for <webhook@archiver.kernel.org>; Sat, 18 Jul 2026 04:38:03 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.547.1784349476872439149
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Jul 2026 21:37:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sCX4vl2C;
 spf=pass (domain: gmail.com, ip: 209.85.215.177, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so6657358a12.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 21:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784349476; x=1784954276; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SauqQ3uW1MleZ6xhT08ZIXJ4hNN3Kv8upgc6WuUeYD4=;
        b=sCX4vl2Cn0hSA2pOt1QUP9mmROgT+BDzFd7ywI9jdDppdcIW3eh3wHVe06t2B5Jt7j
         Xb59UEqb4e0kmp0QdlIZMMMtrJBCWE3gpPEE4X97z/IoX2PUlIe+T48lavuW3ZdeVb/6
         bq7zXY+kfp2gGwLYjaVtkNPeMP5183wdoE6L5Q4qkjan7P8nyKJlAAoQJ2UquGd6mJ17
         7g13fyH+ZHKXNqddqMUJnQSqWNj3Le9EXvu0TKBmIlL6D32GUnEaHKiFfZKQrHZOn+8Y
         L6ysbzCBE2c8ABg1zmJb2TV6eqOLcVEmgZt/P+4gAGYKP9LDTjgr1CyBZavHOcMZDPS8
         To8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784349476; x=1784954276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SauqQ3uW1MleZ6xhT08ZIXJ4hNN3Kv8upgc6WuUeYD4=;
        b=GN3Exh8IOBveg5EikPWoxitMzlZJNRVO1nREkPmkwxV0QaqcM4CWQ6X/OT/SRSDwHt
         GGIGsvKujYgWkBHR/d3X9ckA+Erd3o1DIUlY1WlwKYfKkH4BjSX2WKTOp/3RIBUapoBR
         r6WpwHRDfp20Coy5+NALQ0c0xqnd2u/Glqo6MjgndK8aUnQFr7f6vFiqBUjtM5mRORzg
         KeXwKgh+ACheeij3YpMNAG+NarUHQidwl1NZk6P0W1RszUkiCj29nrTtLf4atqkmMO9K
         3XItQgDOZcqF6kANf7/khm/9xYBCSO4ej2uWXJ00sLBklSVuxF+WVXF96M0c9cdYR4wW
         bQew==
X-Gm-Message-State: AOJu0Ywcg1Oj53IXO93v+asqztTFSEhVBElOoHiTjRSRoYsv31G73GRM
	ipltiqYtjlxR86vWfhQogxtKN3XgK+1aupXCqyisNmr/xlSO2LXZACLxZqpJl8y5Jz8=
X-Gm-Gg: AfdE7cmJpaXGs2qdry27/lAOZeEJfcgFaSpsQiJTCVBhpxSkos8c6+9/SUZz4BRWAyU
	w1NSCzhrE+UureYLMcV6C/RS50hEy6p6LwrP/FosuuA5mCvSMm2Wwp5XsqWtSa9o+c0mr0P/IlF
	AZlYmV4yszqZbGM3S6t8YKFqoWwW1noUh4iTpSI4qUUpwZN4R07Vf3xM4aAWqBl2Y5UqJu1pwKJ
	+5DP5k5nY18H+IYCOJqfjhweJrOtKsqBE+ciVCHH09BLTDFw9FtOpM+imvnb/AbvVan1/w5ttmb
	f9ZfW1x+bpra6hK6AVtSab3qm8F0mplCiki/2XGXbgsGxpVSFRYXzhyWcNhUDWHeW2w1Exm5CnC
	6L5Krt8QNwEuWLiOFipVrY58x4nJdCfoY33+4Y4SC0m5gsveLsRRddd4h09Z3NRpmjYhLXSNWmU
	+GxA==
X-Received: by 2002:a05:6a20:c70b:b0:3bf:7c02:c46f with SMTP id adf61e73a8af0-3c3ad5ffb90mr5887121637.14.1784349476099;
        Fri, 17 Jul 2026 21:37:56 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f8f067sm1626903a12.10.2026.07.17.21.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 21:37:55 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>,
	Paul Barker <paul@pbarker.dev>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH 3/3] pseudo_client: remove the unused pseudo_prefix_dir_fd
Date: Sat, 18 Jul 2026 04:37:50 +0000
Message-ID: <20260718043750.7-4-bbnpreetsingh@gmail.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4510

pseudo has kept an O_RDONLY descriptor on PSEUDO_PREFIX since its
first commit (33d9386, 2010), where client_connect() fchdir()'d
through it so the server socket could be reached by a path short
enough for sun_path. 551bf567 ("Add new environment values to allow
easy override of default locations") moved that job to
pseudo_localstate_dir_fd. Nothing has read pseudo_prefix_dir_fd back
since then.

Two side effects of opening it go away. Client init created a missing
PSEUDO_PREFIX with mkdir_p(); the default PSEUDO_LOCALSTATEDIR lives
under the prefix and its own setup runs the same mkdir_p(), so the
directory is still created there, while a custom PSEUDO_LOCALSTATEDIR
never needed the prefix directory at client init. An unset or
unopenable PSEUDO_PREFIX was a diagnostic and exit(1), and still is,
from the local state setup directly below.

The sweeps in OP_CLOSEFROM and OP_CLOSE_RANGE no longer need to step
around the descriptor, so the entries the previous commit added for
it go away again.

Discussed in
https://lore.kernel.org/yocto-patches/20260716055633.7-1-bbnpreetsingh@gmail.com/

AI-Generated: Uses Claude (claude-sonnet-5)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 doc/program_flow |  1 -
 pseudo_client.c  | 66 +++++-------------------------------------------
 pseudo_client.h  |  1 -
 3 files changed, 6 insertions(+), 62 deletions(-)

diff --git a/doc/program_flow b/doc/program_flow
index 3a399a7..e987e4a 100644
--- a/doc/program_flow
+++ b/doc/program_flow
@@ -15,7 +15,6 @@ libpseudo execution flow:
 			setup pseudo_logfile
 		pseudo_client.c: pseudo_init_client()
 			setup PSEUDO_DISABLED
-			setup pseudo_prefix_dir_fd
 			setup pseudo_localstate_dir_fd
 			setup PSEUDO_NOSYMLINKEXP
 			setup PSEUDO_UIDS
diff --git a/pseudo_client.c b/pseudo_client.c
index 7f80a3b..46b6a3b 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -46,7 +46,6 @@ static char *base_path(int dirfd, const char *path, int leave_last);
 
 static int connect_fd = -1;
 static int server_pid = 0;
-int pseudo_prefix_dir_fd = -1;
 int pseudo_localstate_dir_fd = -1;
 int pseudo_pwd_fd = -1;
 int pseudo_pwd_lck_fd = -1;
@@ -532,7 +531,6 @@ pseudo_init_client(void) {
 	if (!pseudo_inited) {
 		/* Ensure that all of the values are reset */
 		server_pid = 0;
-		pseudo_prefix_dir_fd = -1;
 		pseudo_localstate_dir_fd = -1;
 		pseudo_pwd_fd = -1;
 		pseudo_pwd_lck_fd = -1;
@@ -555,29 +553,6 @@ pseudo_init_client(void) {
 		pseudo_umask = umask(022);
 		umask(pseudo_umask);
 
-		pseudo_path = pseudo_prefix_path(NULL);
-		if (pseudo_prefix_dir_fd == -1) {
-			if (pseudo_path) {
-				pseudo_prefix_dir_fd = open(pseudo_path, O_RDONLY);
-				/* directory is missing? */
-				if (pseudo_prefix_dir_fd == -1 && errno == ENOENT) {
-					pseudo_debug(PDBGF_CLIENT, "prefix directory '%s' doesn't exist, trying to create\n", pseudo_path);
-					mkdir_p(pseudo_path);
-					pseudo_prefix_dir_fd = open(pseudo_path, O_RDONLY);
-				}
-				pseudo_prefix_dir_fd = pseudo_fd(pseudo_prefix_dir_fd, MOVE_FD);
-			} else {
-				pseudo_diag("No prefix available to to find server.\n");
-				exit(1);
-			}
-			if (pseudo_prefix_dir_fd == -1) {
-				pseudo_diag("Can't open prefix path '%s' for server: %s\n",
-					pseudo_path,
-					strerror(errno));
-				exit(1);
-			}
-		}
-		free(pseudo_path);
 		pseudo_path = pseudo_localstatedir_path(NULL);
 		if (pseudo_localstate_dir_fd == -1) {
 			if (pseudo_path) {
@@ -1439,29 +1414,6 @@ pseudo_client_shutdown(int wait_on_socket) {
 	char *pseudo_path;
 
 	pseudo_debug(PDBGF_INVOKE, "attempting to shut down server.\n");
-	pseudo_path = pseudo_prefix_path(NULL);
-	if (pseudo_prefix_dir_fd == -1) {
-		if (pseudo_path) {
-			pseudo_prefix_dir_fd = open(pseudo_path, O_RDONLY);
-			/* directory is missing? */
-			if (pseudo_prefix_dir_fd == -1 && errno == ENOENT) {
-				pseudo_debug(PDBGF_CLIENT, "prefix directory doesn't exist, trying to create\n");
-				mkdir_p(pseudo_path);
-				pseudo_prefix_dir_fd = open(pseudo_path, O_RDONLY);
-			}
-			pseudo_prefix_dir_fd = pseudo_fd(pseudo_prefix_dir_fd, COPY_FD);
-			free(pseudo_path);
-		} else {
-			pseudo_diag("No prefix available to to find server.\n");
-			exit(1);
-		}
-		if (pseudo_prefix_dir_fd == -1) {
-			pseudo_diag("Can't open prefix path (%s) for server. (%s)\n",
-				pseudo_prefix_path(NULL),
-				strerror(errno));
-			exit(1);
-		}
-	}
 	pseudo_path = pseudo_localstatedir_path(NULL);
 	mkdir_p(pseudo_path);
 	if (pseudo_localstate_dir_fd == -1) {
@@ -1970,8 +1922,6 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 			startfd = pseudo_util_debug_fd + 1;
 		if (pseudo_util_evlog_fd >= startfd)
 			startfd = pseudo_util_evlog_fd + 1;
-		if (pseudo_prefix_dir_fd >= startfd)
-			startfd = pseudo_prefix_dir_fd + 1;
 		if (pseudo_localstate_dir_fd >= startfd)
 			startfd = pseudo_localstate_dir_fd + 1;
 		if (pseudo_pwd_fd >= startfd)
@@ -1984,9 +1934,9 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 			startfd = connect_fd + 1;
 		for (i = fd; i < startfd; ++i) {
 			if (i == pseudo_util_debug_fd || i == pseudo_util_evlog_fd ||
-					i == pseudo_prefix_dir_fd || i == pseudo_localstate_dir_fd ||
-					i == pseudo_pwd_fd || i == pseudo_pwd_lck_fd ||
-					i == pseudo_grp_fd || i == connect_fd)
+					i == pseudo_localstate_dir_fd || i == pseudo_pwd_fd ||
+					i == pseudo_pwd_lck_fd || i == pseudo_grp_fd ||
+					i == connect_fd)
 				continue;
 			pseudo_client_close(i);
 			close(i);
@@ -2004,8 +1954,6 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 			startfd = pseudo_util_debug_fd + 1;
 		if (pseudo_util_evlog_fd >= startfd)
 			startfd = pseudo_util_evlog_fd + 1;
-		if (pseudo_prefix_dir_fd >= startfd)
-			startfd = pseudo_prefix_dir_fd + 1;
 		if (pseudo_localstate_dir_fd >= startfd)
 			startfd = pseudo_localstate_dir_fd + 1;
 		if (pseudo_pwd_fd >= startfd)
@@ -2021,9 +1969,9 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 		 */
 		for (i = fd; i < startfd && (unsigned int) i <= close_range_maxfd; ++i) {
 			if (i == pseudo_util_debug_fd || i == pseudo_util_evlog_fd ||
-					i == pseudo_prefix_dir_fd || i == pseudo_localstate_dir_fd ||
-					i == pseudo_pwd_fd || i == pseudo_pwd_lck_fd ||
-					i == pseudo_grp_fd || i == connect_fd)
+					i == pseudo_localstate_dir_fd || i == pseudo_pwd_fd ||
+					i == pseudo_pwd_lck_fd || i == pseudo_grp_fd ||
+					i == connect_fd)
 				continue;
 			pseudo_client_close(i);
 			close(i);
@@ -2045,8 +1993,6 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 				}
 			} else if (fd == pseudo_util_debug_fd) {
 				pseudo_util_debug_fd = pseudo_fd(fd, COPY_FD);
-			} else if (fd == pseudo_prefix_dir_fd) {
-				pseudo_prefix_dir_fd = pseudo_fd(fd, COPY_FD);
 			} else if (fd == pseudo_localstate_dir_fd) {
 				pseudo_localstate_dir_fd = pseudo_fd(fd, COPY_FD);
 			} else if (fd == pseudo_pwd_fd) {
diff --git a/pseudo_client.h b/pseudo_client.h
index a013f88..206f630 100644
--- a/pseudo_client.h
+++ b/pseudo_client.h
@@ -39,7 +39,6 @@ extern gid_t pseudo_egid;
 extern gid_t pseudo_sgid;
 extern gid_t pseudo_rgid;
 extern gid_t pseudo_fgid;
-extern int pseudo_prefix_dir_fd;
 extern int pseudo_localstate_dir_fd;
 extern FILE *pseudo_pwd_open(void);
 extern FILE *pseudo_grp_open(void);
-- 
2.43.0


