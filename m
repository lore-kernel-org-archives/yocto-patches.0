Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1944EB362A
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 17:45:26 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.166697.1772473519893360708
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Mar 2026 09:45:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=tHJWJmTl;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so54728095e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Mar 2026 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772473518; x=1773078318; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVS1J+eEIcgjq5uLqCjjkkBwg3dwbS76HxVuEF8pHsw=;
        b=tHJWJmTl+2prNRZ1J+WJnR9eFU8nuqYehzzcor0OhHdqH5IX59d2ct+nY6BBkMKFen
         zBPLCDjjZpt5Kzu6ce6BpGiEF3c/gJug2wu8FwzyMPIe7GjUo1ScCqEEMlqSXe+Q0Ipb
         +SAajPCC+jVlVdbsnomZcFub9uv3hBQvSWVtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772473518; x=1773078318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVS1J+eEIcgjq5uLqCjjkkBwg3dwbS76HxVuEF8pHsw=;
        b=MyA8xU7MXuHH1MBAtroTYV5mX+84pr1mT85OYvntdqapuSjYo/JP3LwJBvqr4psvJq
         xDKobIHYTHpzax1Ar1kER6ROSGppgDV7TAN79U2w7+Lsa2vDhQpGfFLgFm5pANEK0EDC
         F6sJhqThneQ00xa7KbxW9lO0plOnkPCsm0lOqWo0bb+SYGrbG9s8IrhUgltEotndmuFt
         HQD6v6cp1zdbCtJNnMzNf7JgL4q9Hlz+WA4kym+Rj39XB2atH7JbsqkuNkYVR8eWFEXx
         HvzEp2G4fPlD/b561MTyPT6coLVGJsxsPOhqttDKqLCvyI5IVTPmpnXhll71xxQ2VJGf
         fgHg==
X-Gm-Message-State: AOJu0Yx3BW920svugoRv9+B4a7tXMkeFn+SPonGKWrzFPB/aGs0jSimf
	O/BN9eQzvJgCJ0hg7Ow/nhliwP6+sQrKLnwopSGS/bhYEH1pOMT4CkwCVkNiQY/IsJl2+UYqNgw
	TwRyP
X-Gm-Gg: ATEYQzwK9TEO7RJXNNZOiYHyRMNIGR9G6sqVnpq74B7cD4LikXyquSdHsLMor96WmcV
	bainWCAipKwLDLS7fUySjehIOzcvCD3FoM5B+j3hMsQ2QPdOLjlQzZe6kWbpH4fwStEmy3UHqf3
	iEStwrvu7pOV7pY1SiOTNenOUbp3j/TubbDc92cipIB5MxuRmbMZIPzMSNhnSY9ZHTFloVa0+n/
	ufUJdIdnUyHeC+3BSf4n2qCoVDrLnrW/2zUKuHbtI+IT8saJXcVG4F5Ziw0UgwYUeu+lOnpZOgN
	Mn5OU0Zd+g0PxRwF7XJbbfTNXAHbiS6eqs5JGKr3ZrCQV9cQJPGbnr4EATxd6DzkbVLLWgAh/x1
	nFi0zG+t7gV/t8dD1j19Om77wKeRQc6r/mCpVOMOmjJB2WYxt9DYEWZrbL+Z7t6/KuRela2LD1T
	QjY0mXlg+R9fHZGIv6NNEp8iXHYpCLvhtAoPywu6hnsLo/3pwHYctFFZhqVvGyEvc3wMHDKmZp9
	4j65DWejeQMq/YIQLJkHbeTcgLGC5jYb9MZEOU=
X-Received: by 2002:a05:600c:1d06:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-483c9bb1e14mr225119285e9.11.1772473518110;
        Mon, 02 Mar 2026 09:45:18 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-750d-091c-368b-8fe8-5e44-2549.rev.sfr.net. [2a02:8440:750d:91c:368b:8fe8:5e44:2549])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c35910f1sm251707875e9.2.2026.03.02.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:45:17 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: anibal@limonsoftware.com,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [ptest-runner][PATCH 2/2] utils.c: print a message when a timeout occurs
Date: Mon,  2 Mar 2026 18:45:00 +0100
Message-ID: <20260302174500.357368-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302174500.357368-1-yoann.congal@smile.fr>
References: <20260302174500.357368-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Mar 2026 17:45:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3314

From: Yoann Congal <yoann.congal@smile.fr>

This will make a timeout occuring more clear in the logs.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/utils.c b/utils.c
index 6cf7705..6cfa26f 100644
--- a/utils.c
+++ b/utils.c
@@ -498,6 +498,7 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 				}
 
 				if (timedout) {
+					fprintf(fp, "Timeout! System state:\n");
 					collect_system_state(fp);
 				} else {
 					/*

