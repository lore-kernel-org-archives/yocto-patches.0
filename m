Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9380C41513
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 15:40:55 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.web10.24110.1715010055447028757
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 May 2024 08:40:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=P4bC8Pe6;
 spf=pass (domain: limonsoftware.com, ip: 209.85.167.170, mailfrom: anibal@limonsoftware.com)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c71c7e2d40so164775b6e.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 May 2024 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1715010054; x=1715614854; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2hyCD8wt6wyHnfT+8OHQheu2DgVDKWmvxByXq6khrw=;
        b=P4bC8Pe68Ms2AIk6s1UTUoXjUF6ZpKHPxhyOienJgFjACbBeIw7Vx/1opqewi8Qngo
         QiFZti4+WkqmEMB78Tvanl3EFT3y3cCZJXVgpsY795JtV5peAZgVJploC5/DJJd3vluF
         U7oH2YRaQMxznUQCV5ME8POuhaCM/jw88cW7O0l2kvI6iJRwGmSmrTSOuiKfs1jv5PTV
         YX86Aga7DV9ZrplsZ49sdIdG8K8vfdQSnJXUGolsLE854+h228cQNX2WK1dYzLUyNCn+
         ahfIz1/m3AtOQqaIGhSKujBRTyDf8XktV9TC/kyU71Jv5vJXNGoFe27jsDuDASplNI0Q
         o9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010054; x=1715614854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2hyCD8wt6wyHnfT+8OHQheu2DgVDKWmvxByXq6khrw=;
        b=OZP2sCOunKHZ26fEJBK1tU3gcjQm98Y+VaQ+B3QrvWQWlED0xBQcougje/2Q5g8HbW
         ATog1aRQLyKGTygLu/grW+U19yj5XSpzyllQBpitCuXwPzTriPv1wCs1xiIkMvhesAx9
         kzURlxKwowPRo8B8Tno/nqKs5+wukZVnEKfzYdFeu0C2L++n84Wj8CSuCLfTreMn1Krl
         5SW6ynmnrzVovJ4PQnZ9LXEje2zoNN5QWEPIaPbnKOxPm65iMuT24NLJA5PzrJaZdzIi
         y/wXg+WAWQsmr3pA9QSxltYb8jd6aNd2LLPMDVyj35oXrJbvKek1WXQNNoRCt9FEUDDL
         iDUg==
X-Gm-Message-State: AOJu0YxizQPCZ+WNfsPmM9oy8vt4UDwDLN096uhOe4eWlL0eaX+mk/3S
	ymf/QDWrCEzWmbmbW53zfopoGH361zxoZbgnEmlQxdDYdAT/rI/v8e1Fstgs5YaYkYgdJqYn+X/
	YQhY=
X-Google-Smtp-Source: AGHT+IFateF7hbzSmfQW/1FTxgmKavTSAHqYCTlMeK6cVxKBTxZpUNCJxEpouBg0suRJJ7uo8XwDIA==
X-Received: by 2002:a54:4387:0:b0:3c9:6dc9:a532 with SMTP id u7-20020a544387000000b003c96dc9a532mr3509679oiv.10.1715010054569;
        Mon, 06 May 2024 08:40:54 -0700 (PDT)
Received: from blackbox.admin.ts.net ([189.172.68.96])
        by smtp.gmail.com with ESMTPSA id bf26-20020a056808191a00b003c9689769c7sm605780oib.8.2024.05.06.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:40:54 -0700 (PDT)
From: Anibal Limon <anibal@limonsoftware.com>
To: yocto-patches@lists.yoctoproject.org
Cc: randy.macleod@windriver.com,
	changqing.li@windriver.com,
	Anibal Limon <anibal@limonsoftware.com>
Subject: [ptest-runner 2/2] utils.c: run_ptests improve error handling on ptests iteration
Date: Mon,  6 May 2024 09:40:42 -0600
Message-ID: <20240506154042.3395390-2-anibal@limonsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506154042.3395390-1-anibal@limonsoftware.com>
References: <20240506154042.3395390-1-anibal@limonsoftware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 May 2024 15:40:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/85

If error on setup a new ptest use goto to clean properly and stop
the loop.

Signed-off-by: Anibal Limon <anibal@limonsoftware.com>
---
 utils.c | 51 ++++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/utils.c b/utils.c
index 3a35313..6cf7705 100644
--- a/utils.c
+++ b/utils.c
@@ -350,7 +350,6 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 
 	struct ptest_list *p;
 
-
 	if (opts.xml_filename) {
 		xh = xml_create(ptest_list_length(head), opts.xml_filename);
 		if (!xh)
@@ -362,43 +361,37 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 
 		fprintf(fp, "START: %s\n", progname);
 		PTEST_LIST_ITERATE_START(head, p)
+			char ptest_dir[PATH_MAX] = {'\0'};
 			int pipefd_stdout[2] = {-1, -1};
 			int pipefd_stderr[2] = {-1, -1};
 			int pty[2] = {-1, -1};
 
+			strcpy(ptest_dir, p->run_ptest);
+			dirname(ptest_dir);
+
 			if (pipe2(pipefd_stdout, 0) == -1) {
+				fprintf(fp, "ERROR: pipe2() failed with: %s.\n", strerror(errno));
 				rc = -1;
-				break;
+				goto ptest_list_fail1;
 			}
+
 			if (pipe2(pipefd_stderr, 0) == -1) {
-				close(pipefd_stdout[PIPE_READ]);
-				close(pipefd_stdout[PIPE_WRITE]);
+				fprintf(fp, "ERROR: pipe2() failed with: %s.\n", strerror(errno));
 				rc = -1;
-				break;
+				goto ptest_list_fail2;
 			}
 
 			if (openpty(&pty[0], &pty[1], NULL, NULL, NULL) < 0) {
 				fprintf(fp, "ERROR: openpty() failed with: %s.\n", strerror(errno));
-				close(pipefd_stderr[PIPE_READ]);
-				close(pipefd_stderr[PIPE_WRITE]);
-				close(pipefd_stdout[PIPE_READ]);
-				close(pipefd_stdout[PIPE_WRITE]);
 				rc = -1;
-				break;
-			}
-
-			char *ptest_dir = strdup(p->run_ptest);
-			if (ptest_dir == NULL) {
-				rc = -1;
-				break;
+				goto ptest_list_fail3;
 			}
-			dirname(ptest_dir);
 
 			pid_t child = fork();
 			if (child == -1) {
 				fprintf(fp, "ERROR: Fork %s\n", strerror(errno));
 				rc = -1;
-				break;
+				goto ptest_list_fail4;
 			} else if (child == 0) {
 				/* Close read ends of the pipe */
 				do_close(&pipefd_stdout[PIPE_READ]);
@@ -424,7 +417,6 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 				} else {
 					run_child(p->run_ptest, pipefd_stdout[PIPE_WRITE], pipefd_stderr[PIPE_WRITE]);
 				}
-
 			} else {
 				bool timedout = false;
 				char stime[GET_STIME_BUF_SIZE];
@@ -551,22 +543,31 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 				fprintf(fp, "END: %s\n", ptest_dir);
 				fprintf(fp, "%s\n", get_stime(stime, GET_STIME_BUF_SIZE, end_time));
 			}
-			free(ptest_dir);
-			do_close(&pipefd_stdout[PIPE_READ]);
-			do_close(&pipefd_stdout[PIPE_WRITE]);
+
+ptest_list_fail4:
+			do_close(&pty[0]);
+			do_close(&pty[1]);
+
+ptest_list_fail3:
 			do_close(&pipefd_stderr[PIPE_READ]);
 			do_close(&pipefd_stderr[PIPE_WRITE]);
+ptest_list_fail2:
+			do_close(&pipefd_stdout[PIPE_READ]);
+			do_close(&pipefd_stdout[PIPE_WRITE]);
 
+ptest_list_fail1:
 			fflush(fp);
 			fflush(fp_stderr);
 
+			if (rc == -1) {
+				fprintf(fp_stderr, "run_ptests fails: %s", strerror(errno));
+				break;
+			}
+
 		PTEST_LIST_ITERATE_END
 		fprintf(fp, "STOP: %s\n", progname);
 	} while (0);
 
-	if (rc == -1)
-		fprintf(fp_stderr, "run_ptests fails: %s", strerror(errno));
-
 	if (opts.xml_filename)
 		xml_finish(xh);
 
-- 
2.43.0


