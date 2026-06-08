Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C91CD8C9D
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 11:54:06 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52614.1780919641544502991
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Jun 2026 04:54:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Qipjfkgd;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: frezidok1@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bec429c2bb1so603915866b.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 08 Jun 2026 04:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780919640; x=1781524440; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJlBIopl9gAStLzRdZSUC8ajSQ20jbebJykhvQbA9oI=;
        b=Qipjfkgdz7kY5sHk6Wiu+PxNyToadT1Zh4jKI73myJE2l7PLsdIeTh8Hhmy6FOviY9
         RQoI+Ehk1q56Blz37EMI/OINL7Y8Fyf5QEqcOND8gKO9H284Jrs+yl8mDg9/VvtjV+OX
         HFy6QtIHNwdesT8mjPd+p8++RnQR+5TpIJxNFiro+yB2aKKWM30sdySZBDvaTPb9IJaL
         0Q+l2mrc0VC6cQgMgF7HYZeBmshM0nePGnqr+5NjrQJ9hsisqi3HJ5qybGVdjb7os42P
         qXEVLRkAZQQFhKniG9jka67ARQhCq58wLnjMUl175AISHaLUhGSIlnYcUaxxvNZbNBxG
         uF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780919640; x=1781524440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJlBIopl9gAStLzRdZSUC8ajSQ20jbebJykhvQbA9oI=;
        b=qwZ94+YSxbFBnZ3HypJlMSZnDMYXIplMQTC3mhCn63azEmaZvSnELSJgFy9Om80vjk
         pwI2Bn1y0S5syCh5CdepdrQ+FxVemQz0VYHBbQ4yUE2y6ear9erzk8IQToTgdv+DO5kK
         nUsGKY3GWgdyb46r5znCS5WTf3Cz5MzjpgYq1H7vOB9/j6mp+J3eRxeGwk1z24XoFh9l
         nGsQE2VGUlq65nyxX6VHvP3BIxMJjy1HzsZIBq4vfc/A9L2fnZTFFPZgOVhB98YOaLMq
         juQ0z8vfwp6lL8i7/Q7CtgmX4BCv0imDlSy7ueuPN86Z5US/a6S0Yt5AxZdmoj+P9hEt
         kGWg==
X-Gm-Message-State: AOJu0Yx1pq5kRlKVk6cJL5ZSBRq7Kh2tR1RpFRl3Fqu0TyN9Jbh+Pobj
	3RTUDiXdMevTaW22AB3eTxF0L2JZXOWopBOGmUH1YdaPAq2A2vPXZ+CdtGjmOSyR
X-Gm-Gg: Acq92OFmo3ZanQccMRLO/AMaseC8ed6XB4HEWWPYD7qcWgEfRCYEhWsPfajM3fdLEnM
	Hu/2/92OwEhq1BxlG2TQKRpFnM5SAtZt9RNHJryKf6+3P4EYky9Qwcp02MeidbMGbRbi86IVlkF
	Nh8y5wa2RA6JHuL86O7Ne8s4JTqwQP8gckpJdfdc+7vLzsELE/D3RCxny0RpRIkm1MMyDu4Tguy
	ABJX8Z4IgOGV5M/NZUL6ZCcQM8dJF3cvdBlu/dmIJ+W232hvA+eRKMTjqiVvk2IGSB2v/dHUdvb
	7uoP/QVs5ZM12tYoF1sftLGwnF+nst4L6mHKPAIqwQAd01EewTNRYBKlTABnXgrs8QlOzN2LRNM
	wlBxjcRmdp+j2Pc1trfuvNBZMefbKwbTD+0rXJOnzkb15xJFo6g+xXYDzxmO69jEibEGJ7f7sgc
	qDKGCVcDzaXlmhh0Glixc39BTy8mmr
X-Received: by 2002:a17:907:a315:b0:bec:894d:dd56 with SMTP id a640c23a62f3a-bf373ceef12mr739007066b.49.1780919639515;
        Mon, 08 Jun 2026 04:53:59 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05176fd07sm870420466b.1.2026.06.08.04.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:53:58 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH] pseudo: Add new logging macros
Date: Mon,  8 Jun 2026 14:53:35 +0300
Message-ID: <20260608115335.4004994-1-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Jun 2026 11:54:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4177

From: Dmitry Sakhonchik <frezidok1@gmail.com>

They are designed to replace various direct pseudo_diag()
call across the program and add new "smart" logging functionality.
CRITICAL and ERROR messages are shown no matter what,
INFO and WARNING only if the corresponding flag is set.

The patch is based on: [pseudo,v2] pseudo_util: Add log severity flags
and implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 enums/sev.in |  2 +-
 pseudo.h     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/enums/sev.in b/enums/sev.in
index 24c2c6e..44dffde 100644
--- a/enums/sev.in
+++ b/enums/sev.in
@@ -1,4 +1,4 @@
-sev: SEVERITY
+sev: SEVERITY; FLAGS
 debug
 info
 warn
diff --git a/pseudo.h b/pseudo.h
index e48d38a..d214ba2 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -41,6 +41,23 @@ extern int pseudo_evlog_internal(char *, ...) __attribute__ ((format (printf, 1,
 } while (0) 
 extern void pseudo_evlog_dump(void);
 #ifndef NDEBUG
+#define pseudo_critical(fmt, ...) do { \
+	pseudo_diag("CRITICAL: " fmt, ##__VA_ARGS__); \
+	abort(); \
+} while (0)
+#define pseudo_error(fmt, ...) do { \
+	pseudo_diag("ERROR: " fmt, ##__VA_ARGS__); \
+} while (0)
+#define pseudo_warning(fmt, ...) do { \
+	if (pseudo_util_severity_flags & SEVERITYF_WARN) { \
+		pseudo_diag("WARNING: " fmt, ##__VA_ARGS__); \
+	} \
+} while (0)
+#define pseudo_info(fmt, ...) do { \
+	if (pseudo_util_severity_flags & SEVERITYF_INFO) { \
+		pseudo_diag("INFO: " fmt, ##__VA_ARGS__); \
+	} \
+} while (0)
 #define pseudo_debug(x, ...) do { \
 	if ((x) & PDBGF_VERBOSE) { \
 		if ((pseudo_util_debug_flags & PDBGF_VERBOSE) && (pseudo_util_debug_flags & ((x) & ~PDBGF_VERBOSE))) { pseudo_diag(__VA_ARGS__); } \

