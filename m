Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB5EDF150
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 11:06:32 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.69243.1770980790474230213
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Feb 2026 03:06:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fJ7QcGhe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48372efa020so3793715e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770980788; x=1771585588; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr5dkl4h6haPFmepi2LzqvH8tltrV+U0sQ5fKyn+zV0=;
        b=fJ7QcGhe8BmQdMlbZxsE6R56u8lVXcNvoki8hyA8kEZzcS/MaIjRPVjoniort5Ctra
         n2x341zmjhcpsGzq70x/cIQXmA2JnokZqcFb1sDkyd3YPXMlXXC38renYk6DNUhAVDd+
         A13EONWAsJOGYBSym5I8MhUXs0knb6UKs+gPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770980788; x=1771585588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lr5dkl4h6haPFmepi2LzqvH8tltrV+U0sQ5fKyn+zV0=;
        b=Kih8eXMZSjc4tZGKrsFu+LS2ZyxGw0Vc2yBRmlav8qLe0PiJuF9Bacu7AYgF6//kPh
         Pz11P7I2+pcTk1fgJyDfIjNrGXEhjVzDp8PdI4wf354yBd1v/XlzmfC00LeKACxbNqEv
         xBWmsugboP951mZBI+Byusm/lVG0RbZxm7bhnSDASkZp8K9zINUjCIhdYcm+HAmXiylK
         A735F1pxm+7ctHHTcqeXxdjxn0CDR1hyoXAby015vvFssueKvTmo2opLT7TtLO0SrHtq
         SF/h+xIjgVHpp0wkm5vNTdzWU9FmD9cfyXa8E7A5kDfrERck5KObvk0FvXbHjC0RZwJX
         tS3g==
X-Gm-Message-State: AOJu0YyXSfILJkL90RQIbYtiG7mVgWyL8dUF1qcQtIMrbEZO6VPYW9Gg
	sGi1aKPt4sOkKZTz7icLz3K7dqU4RrqnxLGL7laQ0n8p7RL1XmZSePcYo9o5gFAgNsvifIQb/pD
	+qAIhm5A=
X-Gm-Gg: AZuq6aLZ25k+MychtypLDlRZxYO7s+G8+ZEFnYubyV1mzYnLITxyTQi6vOnjGuKIPmQ
	454YVWmWkAfgbgpy3ZH2XgSog4tC6qj/UViOWuzbvnXWu1l2+d7Obss7JFgxkQy5GJnmirKKRQt
	roGEw2luhLTd/R02LCvOf9hBQSbGnSVVj/io08AKaOhnpze6EGmtVyd03ThufEFulznjKXEz9sj
	LWb/7xbRRWchtarSeYr+mYc3YvWbmuq+ppoMr++ISml5egAdU3EYRgULSIEN9T33kXg3opuwGZd
	L0HfhW/QhHPqAtC6/L5L7gPPmLnerG8pIpqkDBdCszAyFUp1nFcZwE1Pfl5EIkcGG+7IrFTzXsu
	AYwbPbwMbwaXMKz0dzxb4KtLqhYzSZG6yGz1pd8ajYLHw29RfLKiFn9ZP2V4tUpxUwCpui9BDeQ
	gGtua7xfnESc0e7SzlCAabwc6AMNY8CouEMvTh/uqLG8Evp1O1hg4=
X-Received: by 2002:a05:600c:19c8:b0:483:6f37:1b61 with SMTP id 5b1f17b1804b1-48373a15faemr22816865e9.4.1770980788346;
        Fri, 13 Feb 2026 03:06:28 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e20e:afdc:37ec:38d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4c4sm445473825e9.10.2026.02.13.03.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:06:27 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 2/2] pseudo_dv: Fix compiler warning
Date: Fri, 13 Feb 2026 11:06:24 +0000
Message-ID: <20260213110624.1659480-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260213110624.1659480-1-richard.purdie@linuxfoundation.org>
References: <20260213110624.1659480-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 11:06:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3233

Fix:

pseudo_db.c: In function ‘pdb_log_traits’:
pseudo_db.c:786:26: warning: ‘calloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
  786 |         e = calloc(sizeof(*e), 1);
      |                          ^
pseudo_db.c:786:26: note: earlier argument should specify number of elements, later size of each element
pseudo_db.c: In function ‘pdb_history_entry’:
pseudo_db.c:1379:27: warning: ‘calloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
 1379 |         l = calloc(sizeof(log_entry), 1);
      |                           ^~~~~~~~~
pseudo_db.c:1379:27: note: earlier argument should specify number of elements, later size of each element

to reduce noise in compile logs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 pseudo_db.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pseudo_db.c b/pseudo_db.c
index 009ea2f..9713e0c 100644
--- a/pseudo_db.c
+++ b/pseudo_db.c
@@ -783,7 +783,7 @@ pdb_log_traits(pseudo_query_t *traits) {
 		pseudo_diag("%s: database error.\n", __func__);
 		return 1;
 	}
-	e = calloc(sizeof(*e), 1);
+	e = calloc(1, sizeof(*e));
 	if (!e) {
 		pseudo_diag("can't allocate space for log entry.");
 		return 1;
@@ -1376,7 +1376,7 @@ pdb_history_entry(log_history h) {
 		dberr(log_db, "statement failed");
 		return 0;
 	}
-	l = calloc(sizeof(log_entry), 1);
+	l = calloc(1, sizeof(log_entry));
 	if (!l) {
 		pseudo_diag("couldn't allocate log entry.\n");
 		return 0;

