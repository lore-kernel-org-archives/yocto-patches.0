Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F230DE909C7
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 15:48:37 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15057.1771343315215601964
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Feb 2026 07:48:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=coDVHQJ6;
 spf=pass (domain: smile.fr, ip: 209.85.221.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4359a16a400so4195234f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 07:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1771343313; x=1771948113; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejcv1O8RYprPiIDVE6G7yS3UTFtS2uCpqI8tdFyRtgs=;
        b=coDVHQJ6fkcEQIBk4mg2JOaoMbVkzS6oTCLd+IUW9lc74BSzJJGb75i0FJ7AwY50rz
         Xu/0swAbF+HYF2TL2F47pieg4cZANSb/gezwmivoryqG0FPt3mL0YrQECRAF4wrWjtQd
         kJsE0sGAS4KFnpmTM2KYjlqBBF9VxgQqeoaMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771343313; x=1771948113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejcv1O8RYprPiIDVE6G7yS3UTFtS2uCpqI8tdFyRtgs=;
        b=sKzzdXdIaN6iOrOJdx2BpGFki1EFxKXTmzQEklb3Gd9D1Zq4VvETl6bsn6ahNUY6Fy
         Rm4V5okDo+XM+CnAfl1XTHC49jJ+Jy95yZnfdm7dGN09ri3mYp52w46ILRN3rxZTp5P2
         CVuWbZKvA09bU6SSXotdqhEIBp3yOPFR9NW46KN6qKzJMl6g5sGNx828DjU4BweYOLs8
         1uie3JwEcwYM4teAkNtFWYYhJBDFv/6nRI1+W/WzZ3z1SOQeEvYQqzDvZjEAeam+aXSs
         4dLK3CWRpcMwTospdC/M0V00SpOjG/dCKP5kYfH944n3nlGWg5Ld/bS22ixC5i93+MHP
         /GtQ==
X-Gm-Message-State: AOJu0YzMFmXRd1xee57yQWgpNXDEpQ+Q6U0gVEXxvMuHp8T5efBsZIRl
	wEnPSzaJYTCYt7D5o6DtFRBWdV91z+Xuca2pd4UAaLSndrtannmBqPJ7s4ruxX6bk43KJI0fyPi
	gjLdB
X-Gm-Gg: AZuq6aKqDgj++qTELAhxX73eCr+6zEVqdZzucVUnClP+nV40TKfW8PDdrVXLLjJnXsm
	SgyAo1JuH3y18UMTSDIoReYsvvDsXHFSakH3qkj2D+eqa5JiUmR7qw3FR3DlGjrmib1S+NR0WVZ
	94zzaMp8ms2rAue0optLMKp8vpUrHE8ebW1V/5mN/U+VUqBw/9yNJorNg67FtzRX1ASD3LLHtBm
	yTNdJJuClR0CyoPFbLCgqvvrKrAk3LA/ka0rnQo6RZ+nLzp9Mc4xxGa7CJ/JAAUBxGRwJQPxBcj
	CTW/ejDLjoTsfUC6bFNIT3eo3epnaT3gXUtZmsnOfJ9WxONlwEsfp+wjEITI5i8bO3lhKvmF049
	sQiyHa65wa7CN9sXj+r/f3XVZNgbB3VTHlYgpGBjy9HorDPsU7EljDR+LOd/Yp2dWS0qv0a5CYL
	I0a0iEWzD6W+/HPqaRd1Q7a5eA4CCzSREy+xSl+9bRwvhoqSaQA8e1zRFEqMQFKKHsFBwquRmBr
	+QP84k2fZQyUskzk/x3fR/SXwXB/aWK2Q==
X-Received: by 2002:a5d:5d88:0:b0:436:d9b:cd02 with SMTP id ffacd0b85a97d-43797851769mr21371625f8f.0.1771343313323;
        Tue, 17 Feb 2026 07:48:33 -0800 (PST)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc8b1sm36432618f8f.23.2026.02.17.07.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 07:48:33 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [pseudo] [PATCH] ports/linux: define __NR_openat2 if missing
Date: Tue, 17 Feb 2026 16:48:14 +0100
Message-ID: <20260217154814.483670-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 15:48:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3248

From: Yoann Congal <yoann.congal@smile.fr>

On kernel <5.6, __NR_openat2 is not defined. To support build on these
older kernel, define __NR_openat2 at the value it has on every kernel
since 5.6: 437 [0].

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fddb5d430ad9fa91b49b1d34d0202ffe2fa0e179

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 ports/linux/portdefs.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
index a8b2be6..32b95ba 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -54,7 +54,15 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);
 #endif
 #endif
 
-/* Debian 11 and Opensuse 15.5 need this */
+/* Ubuntu 20.04, Debian 11 and Opensuse 15.5 need this */
 #ifndef SYS_openat2
+
+/* On kernel <5.6, __NR_openat2 is not defined. Import the definition from 
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
+ */
+#ifndef __NR_openat2
+#define __NR_openat2 437
+#endif
+
 #define SYS_openat2 __NR_openat2
 #endif

