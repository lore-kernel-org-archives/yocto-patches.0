Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C1ECD8CB2
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 13:29:36 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20317.1781098174964630149
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 06:29:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=RqeHHHWX;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so6919893a12.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781098173; x=1781702973; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQbGzixfqpBogC3q+8osfTnyqLhwWCEPxyXXO4H9/+k=;
        b=RqeHHHWXChA9xN9HWzqm3zjbP5XvxvbxjenDN+ltKr9kqWgVKYLn7v+XobvOkideOA
         +o5LowMGmaNCNrRlV6l43OiADMil9b/kvrzWDkTCyqSO+c5RQ/0NIdz9Rf0p6iEV2WOk
         /jGnC6/7FyKAIXUilXW/5D4d+1G92ZMlgPGarvFHsuv/5fjVAYmH0xo/1iOCCx9PqpH0
         twr2l97EdVWf1DGZd85BKsuGKGAeXKy30HtjTWD9m0iJmrguVDTi3as4ymOz4Lgl1Hd7
         +IGNObEnmdpEdtVvyFrFzQgBFQT38T5Doj9R9FIeIgn4k8vTuK1qzec1apzbpihLIh33
         NYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098173; x=1781702973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQbGzixfqpBogC3q+8osfTnyqLhwWCEPxyXXO4H9/+k=;
        b=c+5SscgRlrRexwVJFdesLbVbXv4yQoJw7DGGY1dGcW1rgrI4H1Z2ybn+iFobBoLVA+
         GWF0+MN5Yo6ef3Ilb5YTrhNnAzY0X0YZPbw1NsebRbHUbU3v+6D9Ybc39nhlHsvh/a87
         oUTFpJhMX7qGi+kDE2qkwCU2tgbksTuu/CHlG7XLgGbtdh81opmK7xT+mZp2OPl71vnC
         fYuK6G3bY/9UaE9NvdrX7eglmhNAxfzOUzuP73dUHv+04kt13hkxFXcteEmbCth0jiuX
         J2DBkw6JEE745mGw0E563iU8DcsAHHO9HSmWpPJFSn2vfSpF1xQwBP2Lx8a+4w28QTol
         vghQ==
X-Gm-Message-State: AOJu0YwiCOMoO4XRu4QlrGQeNBYI8AAW2oDDRvTedXJ492Y33aHPLjBI
	J2P7xn6hRo/0rT6E2iYcL9VP5J+vNfyh93HLx3TDV27V6GnBpRRXZfbnUkQ0J8C0
X-Gm-Gg: Acq92OGc6s+zVbtyWfRIguzGLpIWnKo9Ez3FnYghxwXFWYcWSDm2bp6hQAr7iCO/5OA
	AgO1oUvn3G+Blfo1yofkw7pGVPTGcnsoM0QqUSeeW2+prUkdMoG7ysD6+BKhie77OO08n1QRDkk
	nkpe/ksYH2uDGS/wDMekgO7cM5p4KZAT2BJKcmag+uVmdndfvxxrP9Ts7oNhVkbNHH4rp9ynGIp
	h3cYwXq6zMUicOu5vrhpwbut9IR4C7bfYxJCNVUueDOLcBUGi8Q9kn/jQ1laCk+BZhTbdAPoeLC
	0cpNnFJKPTQds1EcTMcALEQ1tHrOja1qNLLVSlInY+cDloIMZGYvOXnAMGvtIgQmmfMKfWnePAs
	uFiGAA37CmKz1u+2BN84xiqL2e1knnZ5L/kKF4UIGbO4FB2mhRqyKRxTskbOEI64IbxFQZPtbb9
	L2iOarNDNqeeiJW/9dcOeLi0Zd2kCNoRHaNrC4yxM=
X-Received: by 2002:a17:907:d093:b0:bdb:4cf3:7035 with SMTP id a640c23a62f3a-bf36fd9e51dmr1265840566b.4.1781098172945;
        Wed, 10 Jun 2026 06:29:32 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfb0416d0fbsm76037066b.14.2026.06.10.06.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:29:31 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH] pseudo_util: Add default log severity values
Date: Wed, 10 Jun 2026 16:28:30 +0300
Message-ID: <20260610132830.84003-1-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 13:29:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4200

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Default values are "show everything". If the user wants to see
only certain categories, they should explicitely set
PSEUDO_SEVERITY env var or use -k option.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 pseudo.h      | 2 ++
 pseudo_util.c | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/pseudo.h b/pseudo.h
index 92ae71e..66aa70e 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -130,6 +130,8 @@ extern char *pseudo_version;
 #define PSEUDO_PIDFILE "pseudo.pid"
 #define PSEUDO_SOCKET "pseudo.socket"
 
+#define PSEUDO_SEVERITY_DEFAULT "info,warn,error"
+
 /* some systems might not have *at().  We like to define operations in
  * terms of each other, and for instance, open(...) is the same as
  * openat(AT_FDCWD, ...).  If no AT_FDCWD is provided, any value that can't
diff --git a/pseudo_util.c b/pseudo_util.c
index 893a25b..4c05394 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -250,10 +250,11 @@ pseudo_init_util(void) {
 	}
 	free(env);
 	env = pseudo_get_value("PSEUDO_SEVERITY");
-	if (env) {
-		pseudo_severity_set(env);
-		pseudo_severity_flags_finalize();
+	if (!env) {
+		env = strdup(PSEUDO_SEVERITY_DEFAULT);
 	}
+	pseudo_severity_set(env);
+	pseudo_severity_flags_finalize();
 	free(env);
 }
 

