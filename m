Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25074FC9EEF
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:35:26 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6909.1772879719952117433
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 02:35:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=J52R6sPV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4807068eacbso84527165e9.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 02:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772879718; x=1773484518; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VHVv1LNScAk6nAZyd/bzP27zLyacwJLbAW1pqGWObvE=;
        b=J52R6sPVlGLOzaPB7STtsLijbqy0WeR3Ldn4GpP5BbnEi0BNfUXaDS3s3Ol+biPNad
         MteLEV1L2Nov1AVfQNmnatqBQ4X+Tl0sRw+83vmn55zMUKvcDCpV7juP7GuOXmo1ffAw
         FTPnajCQU44C1o5C4IIe7nC58LbwRAwt68LkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879718; x=1773484518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHVv1LNScAk6nAZyd/bzP27zLyacwJLbAW1pqGWObvE=;
        b=uZh0Oq/CgdXYOlK8SeGY/K/EeLr78gC/JYyhY0H21hvG4R8qiEW18RKcpVzhNEhP8J
         Z+vkAF8AkmtwN6wLvBhAxkGUSzyWFhxH0+5OB9pbUEXg9/OvtslNyRnvT3noFOhiavI2
         UvQdLBevV0Q4k/VqJ7nxaYL2BVT6bF9YoNsppjVBEVfWoU5KzTWBUMLhdhGOG3LjnUyQ
         LprnB12mP4wt3fO4lnO8u3KQFvKsAQwhZLZMnEye7+kGShQxmUBBVa1bbNfphrv57/cw
         ZmZIab1nb5+lgV9AGxxkoigIjYvI+XQU/8MJwoDPKtw0OAK4LH7WR/tJQTZaDYfRVx1c
         fdsg==
X-Gm-Message-State: AOJu0Yy2x0J7YrAFxv8HfXKSPEzbUi6nCiuQydszdbLX5ZRMGGiUwowU
	h6ecJdD9tc8Nj84A0nGFnbWI4lEJJ6SnvdWJzLDtO0k8uYtzOjHRdCQrXDUCt4DutR3gOKywMNv
	YKeTVB0E=
X-Gm-Gg: ATEYQzwNTbFNIWksWRD2PUUMngK+ejd38beWlyZrJN/w55Fo7enwCs7QG2KavNiqD/E
	jUhFDanHww+I6ZZ8zoB3VxYGaNpesGo87I1+86ynh78xV1qdw/uzQc3L9z3lqlcBCvV4tSmZcjR
	P/vQDvW7jXBGjnEh2eZxE2Cbfd2GwFTJ03Rx5Eh9cn/dADVQIETmJ2ahu6znT/00Isqo8WLE4q1
	8dRjL0nI1PZj1kFWrc+sRDxp2ck16jg36D648x8dHEITNz1D42fAX85SkfXu6JcN6KRpaYHUEFe
	RHzKlr+G0sdw8wLrbyHCwUAzD0yQ9NHZVYPUta3bb6vMx29EZX5tk0Y1ezftbcWHvIXkhF+TA38
	Jt4y3H1AhoeUu7U85pfHA1LyYYaXVzPDSRysHGMvHBaxGt3xtEr1mcWa8x9lrVBu+/m7Q0UMRxx
	EP1WbKonnnigAH9nV3sHSHswkY9p+dkWwdoXbIShTvLL1FyRbcFiI1AC9ymUoIEg==
X-Received: by 2002:a05:600c:3483:b0:483:7783:5382 with SMTP id 5b1f17b1804b1-485269612d7mr82109635e9.27.1772879717786;
        Sat, 07 Mar 2026 02:35:17 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d746:2cdc:e7ea:aa72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb27a20sm377916495e9.9.2026.03.07.02.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:35:17 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: anibal@limonsoftware.com
Subject: [ptest-runner] [PATCH] utils: Ensure output buffers are always line based
Date: Sat,  7 Mar 2026 10:35:16 +0000
Message-ID: <20260307103516.2584088-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 10:35:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3376

When running slow ptests, we can see an issue where the tests are writing output
but it doesn't make it to the process (e.g. ssh connection) running ptest-runner.

The issue is that the standard buffering for non-interactive terminals is 8kb and
some ptests don't output enough data to trigger a write. This can lead to
the controlling connection timing out.

This change forces the output streams to be line buffered in all cases. Most
ptest output would contain newlines so this should work well. stderr can be
unbuffered by default but making it consistent here seems the best approach.

Testing with this change on slow ptest runs (e.g. qemu emulated) showed much
more consistent data with this change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/utils.c b/utils.c
index 6cfa26f..192d3d0 100644
--- a/utils.c
+++ b/utils.c
@@ -434,11 +434,13 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 				set_nonblocking(pipefd_stdout[PIPE_READ]);
 				pfds[0].fd = pipefd_stdout[PIPE_READ];
 				pfds[0].events = POLLIN;
+				setlinebuf(fp);
 				dest_fps[0] = fp;
 
 				set_nonblocking(pipefd_stderr[PIPE_READ]);
 				pfds[1].fd = pipefd_stderr[PIPE_READ];
 				pfds[1].events = POLLIN;
+				setlinebuf(fp_stderr);
 				dest_fps[1] = fp_stderr;
 
 				while (true) {

