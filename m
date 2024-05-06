Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9352C10F16
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 15:40:55 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web10.24109.1715010054075232299
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 May 2024 08:40:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=uT6AAT27;
 spf=pass (domain: limonsoftware.com, ip: 209.85.167.174, mailfrom: anibal@limonsoftware.com)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c974a0647bso312237b6e.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 May 2024 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1715010053; x=1715614853; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8migmLtux8XKgcTKdJ0OOmYF0ouWScgSCUN3oqGi2Q=;
        b=uT6AAT27yie7H7itlALjeH7TszLu11Y7hI3s/A9oavQoUbPy1QBC/3flk2BaD7iYtc
         C6w8COgj6dNpK23PBlCXDv7M2Zx+nTGd0ipI8QbviG+DfkVtSjq39YM93tgACUTD8Jy/
         yXxU5rp7ErKXkRBd01ed77oKByHr1gIZsxZybISj8/QAIK0C4FCTPOtwhfC6dOJZfHNO
         Ltq9Ar7DN9Zotdm1q8RLRCvLxeiHapIViBXIbY2IPV2uwPkPqQSllQiPAaM9dduwQyRx
         ROjgM/HrxhxGCgx2YXskRuUXooobSfb08Us/uXJOVjuj8z0LnMwfryBjXya3m1wEJTxL
         cgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010053; x=1715614853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8migmLtux8XKgcTKdJ0OOmYF0ouWScgSCUN3oqGi2Q=;
        b=TsmBhSeB05RbJo1MH4qBkua1i6yajdEkRR4IAnH+rc20L6sDk+pw5KHp/nUzlExfsO
         KFTe11uoa07MMqz+d00WRZ0cElme/u+dtO8uvCKoH1cl+B1FQc8Y6IzJfdhVCBKQbQMo
         kdrbdm4IcaReokcVjVK4eLukDXhTvnqa9IN1uvcWeU0mqB8NsisJLLC6ua8vuX7RPAIp
         ggjDAsMQwfJp7W24AR0Y4B8u8WevgaFUqDIBZmbAqR5DiRLLshaJgOduVTm4qG+CMjBu
         s7GdCrXhZdipaADVpk2njUmmi90aWXMqQKDXhkEPw3HTCPD9icxhnyzoq/PNNvkq2oQj
         vR2A==
X-Gm-Message-State: AOJu0YxGpxcGlgWbJlbAMO5BtsA1aIH5V2CRvOcslmZ/DjA60jtJVTU0
	OJpuxcwCTbsVO/6dpS1ot9AjKZltYAvF9mOq+hU41izXGqfLBx2BGwQNyLbSaqBNV7Rdv+qn+Gv
	vqf8=
X-Google-Smtp-Source: AGHT+IF0Tc3esZT+OkSf9N4nC73dpqOUHsUG1KSyUhvUF40Pctq6P80EEc4uT67Zs7QMNHTf5Nu9mA==
X-Received: by 2002:a54:400b:0:b0:3c9:68c4:d69 with SMTP id x11-20020a54400b000000b003c968c40d69mr5115380oie.34.1715010052862;
        Mon, 06 May 2024 08:40:52 -0700 (PDT)
Received: from blackbox.admin.ts.net ([189.172.68.96])
        by smtp.gmail.com with ESMTPSA id bf26-20020a056808191a00b003c9689769c7sm605780oib.8.2024.05.06.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:40:52 -0700 (PDT)
From: Anibal Limon <anibal@limonsoftware.com>
To: yocto-patches@lists.yoctoproject.org
Cc: randy.macleod@windriver.com,
	changqing.li@windriver.com,
	Anibal Limon <anibal@limonsoftware.com>
Subject: [ptest-runner 1/2] utils.c: run-ptests improve pseudo-terminal handling
Date: Mon,  6 May 2024 09:40:41 -0600
Message-ID: <20240506154042.3395390-1-anibal@limonsoftware.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 May 2024 15:40:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/84

Setup master and slave pty before run ptest, on child attach to the
slave pty and set it as controlling tty and stdin.

See rev 59381a643e1fcce9b6920cb59af9402dd5eb0dfb .

Co-authored-by: Changqing Li <changqing.li@windriver.com>
Signed-off-by: Anibal Limon <anibal@limonsoftware.com>
---
 utils.c | 90 ++++++++++++---------------------------------------------
 1 file changed, 19 insertions(+), 71 deletions(-)

diff --git a/utils.c b/utils.c
index 46918f4..3a35313 100644
--- a/utils.c
+++ b/utils.c
@@ -341,53 +341,6 @@ run_child(char *run_ptest, int fd_stdout, int fd_stderr)
 	/* exit(1); not needed? */
 }
 
-/* Returns an integer file descriptor.
- * If it returns < 0, an error has occurred.
- * Otherwise, it has returned the slave pty file descriptor.
- * fp should be writable, likely stdout/err.
- */
-static int
-setup_slave_pty(FILE *fp) {
-	int pty_master = -1;
-	int pty_slave = -1;
-	char pty_name[256];
-	struct group *gptr;
-	gid_t gid;
-	int slave = -1;
-
-	if (openpty(&pty_master, &pty_slave, pty_name, NULL, NULL) < 0) {
-		fprintf(fp, "ERROR: openpty() failed with: %s.\n", strerror(errno));
-		return -1;
-	}
-
-	if ((gptr = getgrnam(pty_name)) != 0) {
-		gid = gptr->gr_gid;
-	} else {
-		/* If the tty group does not exist, don't change the
-		 * group on the slave pty, only the owner
-		 */
-		gid = (gid_t)-1;
-	}
-
-	/* chown/chmod the corresponding pty, if possible.
-	 * This will only work if the process has root permissions.
-	 */
-	if (chown(pty_name, getuid(), gid) != 0) {
-		fprintf(fp, "ERROR; chown() failed with: %s.\n", strerror(errno));
-	}
-
-	/* Makes the slave read/writeable for the user. */
-	if (chmod(pty_name, S_IRUSR|S_IWUSR) != 0) {
-		fprintf(fp, "ERROR: chmod() failed with: %s.\n", strerror(errno));
-	}
-
-	if ((slave = open(pty_name, O_RDWR)) == -1) {
-		fprintf(fp, "ERROR: open() failed with: %s.\n", strerror(errno));
-	}
-	return (slave);
-}
-
-
 int
 run_ptests(struct ptest_list *head, const struct ptest_options opts,
 		const char *progname, FILE *fp, FILE *fp_stderr)
@@ -406,16 +359,12 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 
 	do
 	{
-		if (isatty(0) && ioctl(0, TIOCNOTTY) == -1) {
-			fprintf(fp, "ERROR: Unable to detach from controlling tty, %s\n", strerror(errno));
-		}
-
 
 		fprintf(fp, "START: %s\n", progname);
 		PTEST_LIST_ITERATE_START(head, p)
 			int pipefd_stdout[2] = {-1, -1};
 			int pipefd_stderr[2] = {-1, -1};
-			int pgid = -1;
+			int pty[2] = {-1, -1};
 
 			if (pipe2(pipefd_stdout, 0) == -1) {
 				rc = -1;
@@ -428,6 +377,16 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 				break;
 			}
 
+			if (openpty(&pty[0], &pty[1], NULL, NULL, NULL) < 0) {
+				fprintf(fp, "ERROR: openpty() failed with: %s.\n", strerror(errno));
+				close(pipefd_stderr[PIPE_READ]);
+				close(pipefd_stderr[PIPE_WRITE]);
+				close(pipefd_stdout[PIPE_READ]);
+				close(pipefd_stdout[PIPE_WRITE]);
+				rc = -1;
+				break;
+			}
+
 			char *ptest_dir = strdup(p->run_ptest);
 			if (ptest_dir == NULL) {
 				rc = -1;
@@ -435,38 +394,31 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 			}
 			dirname(ptest_dir);
 
-			if ((pgid = getpgid(0)) == -1) {
-				fprintf(fp, "ERROR: getpgid() failed, %s\n", strerror(errno));
-			}
-
 			pid_t child = fork();
 			if (child == -1) {
 				fprintf(fp, "ERROR: Fork %s\n", strerror(errno));
 				rc = -1;
 				break;
 			} else if (child == 0) {
-				int slave;
-
-				close(0);
 				/* Close read ends of the pipe */
 				do_close(&pipefd_stdout[PIPE_READ]);
 				do_close(&pipefd_stderr[PIPE_READ]);
 
-				if ((slave = setup_slave_pty(fp)) < 0) {
-					fprintf(fp, "ERROR: could not setup pty (%d).", slave);
-				}
-				if (setpgid(0,pgid) == -1) {
-					fprintf(fp, "ERROR: setpgid() failed, %s\n", strerror(errno));
-				}
+				/* Close master pty and set slave pty as stdin */
+				do_close(&pty[0]);
 
 				if (setsid() ==  -1) {
 					fprintf(fp, "ERROR: setsid() failed, %s\n", strerror(errno));
 				}
-
-				if (ioctl(0, TIOCSCTTY, NULL) == -1) {
+				if (ioctl(pty[1], TIOCSCTTY, NULL) == -1) {
 					fprintf(fp, "ERROR: Unable to attach to controlling tty, %s\n", strerror(errno));
 				}
 
+				if (dup2(pty[1], STDIN_FILENO) < 0) {
+					fprintf(fp, "ERROR: Unable to dup slave pty to stdin, %s\n", strerror(errno));
+				}
+				do_close(&pty[1]);
+
 				if (chdir(ptest_dir) == -1) {
 					fprintf(fp, "ERROR: Unable to chdir(%s), %s\n", ptest_dir, strerror(errno));
 				} else {
@@ -481,10 +433,6 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 				do_close(&pipefd_stdout[PIPE_WRITE]);
 				do_close(&pipefd_stderr[PIPE_WRITE]);
 
-				if (setpgid(child, pgid) == -1) {
-					fprintf(fp, "ERROR: setpgid() failed, %s\n", strerror(errno));
-				}
-
 				time_t start_time= time(NULL);
 				fprintf(fp, "%s\n", get_stime(stime, GET_STIME_BUF_SIZE, start_time));
 				fprintf(fp, "BEGIN: %s\n", ptest_dir);
-- 
2.43.0


