Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB2CD98C7
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 11:47:36 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18636.1781092053259859233
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 04:47:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=n2E/yoZF;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68c5eecdd56so9984723a12.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781092051; x=1781696851; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk/E5viPgvkB9BF3ZT9EyDeixBzCKR/rUIoaut4QPtY=;
        b=n2E/yoZFglPAauPQ45FW1Nb7H59nNhfr/8ydQU4YgWFnq9uq6Dd24nD6VAetgul/HX
         sU7MRZizoqU7x1PE0HoDxupB6sLnQwOg1NitZX90UKFKa8VgDm3Cs0qp7l92biQE09g4
         c9yFvTFrSCkyx80ysTxNnipHY8r4P96wPo2hAtWWl3mafPavF62/mY+oDFXXYgt0KO7D
         uxMnnhuDpQ1CU+w8nYF6EVlBnNEPq3ek3pdB8WqY5V+ww+EtT7yUdu0J+HFy9HkixNyk
         0GiileDUHnMcMsCdo2LAVYTeF+m2NW4kMNI/FQFGETinjJRjFFDWZLp//29DXobhrqR0
         FhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092051; x=1781696851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qk/E5viPgvkB9BF3ZT9EyDeixBzCKR/rUIoaut4QPtY=;
        b=WZjg2dERGWIeHnaCrBN6SdWujdyTljekecOMIz1JvO2Sy5UjVTx3UpZ3zbJQ0fs7iT
         l1rXborJcP95jGuxWsP+NQqD905cPpkN3T6qcpxAVTf6btCB2B9yELinqCPOBbV41d7q
         wDmSihif+j5TJXqzbsqBKIdZwb6ywb6gnW8RMsfA6DBia6XpbhM1wCd5hadaNv0Z+e2w
         ttvam1NKRxRmYzm2J7iQNdofpIr4tKSF5bnrZa0taJnhsWXHPdb+BJUAC2ojLa/6THGM
         T6TOTJtIRE3la49VdO5VoWegJ9wT8cfvcGusVPWQWrbGtyWZmLKZyVc/RDx4GagN2PHF
         wM5A==
X-Gm-Message-State: AOJu0Yw+oNywLWlnHR8IgIAWJEDzZJcp6cjhNf57qu8JBUTmh8ENjVQU
	n8rEXfn9LC/A7MfNcerpWm+cvEjafZkYC/0QQ8BqDeI9t7d5ebRWAwU3VO+PkgtX
X-Gm-Gg: Acq92OHujx4URLYnlIC9c/z4O9VqDp93gKgmsO+XOsdkQ16qS2JDO6GHiGqeiV2JP/Z
	XxCQzRv+TOLA6N5Ft3kHAdQxBrwNd93btbT1TEe/ao1O6lPvK5b38oL6ZegVIWh4yYD1vfjpq0J
	5rI540O122qT3d2Tr9yshONpcqy9aHILuLWc5r5/QvZzFRoUj2jtpBTvzx5LnWyPlcyRYsYnQoa
	Z6m827/czhuuNUXBQdNCDz4Oy6H/s/unlmMuC7hSgCUBEYoMTamCSiqOd8vZe151acn7LnYozba
	LuQcXC7HQUlS6nQXiOKJPrY198wNBQIi1JiM3usRG9o24AWkoSWH2VlHrxZEn3p10EGa39iufQO
	ugpefO6ESVpk3rOhHkspxYQ0/T5tVIPYSF6JFuN2OWZFoQf3qOZodnerXS2Nrl3ZhbZJfRTC2UQ
	vcNQWQ/mNu6WC2wgDUc7UAzjN7jdXo
X-Received: by 2002:a05:6402:2789:b0:68a:f749:609c with SMTP id 4fb4d7f45d1cf-68fa52505f2mr11730451a12.21.1781092051359;
        Wed, 10 Jun 2026 04:47:31 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912faea64dsm5997164a12.19.2026.06.10.04.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:47:30 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH 8/8] pseudo: Change pseudo_diag() name to pseudo_log()
Date: Wed, 10 Jun 2026 14:46:10 +0300
Message-ID: <20260610114610.60776-8-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610114610.60776-1-frezidok1@gmail.com>
References: <20260610114610.60776-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 11:47:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4199

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 pseudo.h      | 14 +++++++-------
 pseudo_util.c |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/pseudo.h b/pseudo.h
index d214ba2..92ae71e 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -34,7 +34,7 @@ extern unsigned long pseudo_util_severity_flags;
 extern int pseudo_util_debug_fd;
 extern int pseudo_disabled;
 extern int pseudo_allow_fsync;
-extern int pseudo_diag(char *, ...) __attribute__ ((format (printf, 1, 2)));
+extern int pseudo_log(char *, ...) __attribute__ ((format (printf, 1, 2)));
 extern int pseudo_evlog_internal(char *, ...) __attribute__ ((format (printf, 1, 2)));
 #define pseudo_evlog(x, ...) do { \
 	if (pseudo_util_evlog_flags & (x)) { pseudo_evlog_internal(__VA_ARGS__); } \
@@ -42,27 +42,27 @@ extern int pseudo_evlog_internal(char *, ...) __attribute__ ((format (printf, 1,
 extern void pseudo_evlog_dump(void);
 #ifndef NDEBUG
 #define pseudo_critical(fmt, ...) do { \
-	pseudo_diag("CRITICAL: " fmt, ##__VA_ARGS__); \
+	pseudo_log("CRITICAL: " fmt, ##__VA_ARGS__); \
 	abort(); \
 } while (0)
 #define pseudo_error(fmt, ...) do { \
-	pseudo_diag("ERROR: " fmt, ##__VA_ARGS__); \
+	pseudo_log("ERROR: " fmt, ##__VA_ARGS__); \
 } while (0)
 #define pseudo_warning(fmt, ...) do { \
 	if (pseudo_util_severity_flags & SEVERITYF_WARN) { \
-		pseudo_diag("WARNING: " fmt, ##__VA_ARGS__); \
+		pseudo_log("WARNING: " fmt, ##__VA_ARGS__); \
 	} \
 } while (0)
 #define pseudo_info(fmt, ...) do { \
 	if (pseudo_util_severity_flags & SEVERITYF_INFO) { \
-		pseudo_diag("INFO: " fmt, ##__VA_ARGS__); \
+		pseudo_log("INFO: " fmt, ##__VA_ARGS__); \
 	} \
 } while (0)
 #define pseudo_debug(x, ...) do { \
 	if ((x) & PDBGF_VERBOSE) { \
-		if ((pseudo_util_debug_flags & PDBGF_VERBOSE) && (pseudo_util_debug_flags & ((x) & ~PDBGF_VERBOSE))) { pseudo_diag(__VA_ARGS__); } \
+		if ((pseudo_util_debug_flags & PDBGF_VERBOSE) && (pseudo_util_debug_flags & ((x) & ~PDBGF_VERBOSE))) { pseudo_log(__VA_ARGS__); } \
 	} else { \
-		if ((pseudo_util_debug_flags & (x)) || ((x) == 0)) { pseudo_diag(__VA_ARGS__); } \
+		if ((pseudo_util_debug_flags & (x)) || ((x) == 0)) { pseudo_log(__VA_ARGS__); } \
 	} \
 } while (0) 
 #define pseudo_debug_call(x, fn, ...) do { \
diff --git a/pseudo_util.c b/pseudo_util.c
index dbd979e..893a25b 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -528,7 +528,7 @@ pseudo_debug_clear(char *s) {
 }
 
 int
-pseudo_diag(char *fmt, ...) {
+pseudo_log(char *fmt, ...) {
 	va_list ap;
 	char debuff[8192];
 	int len;

