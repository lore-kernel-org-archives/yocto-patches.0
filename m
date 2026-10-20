Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9890.1792508738756318131
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Oct 2026 08:05:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Gmu2DD0q;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1fa22006cso3813885e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792508737; x=1793113537; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NDO6zIwOQSguiV3BTsdtDwledkz4JeznmBoa6gMTpC0=;
        b=Gmu2DD0qK44oaPro795BSIRUTWAZJGWpFx2ZRebhWbv47Y9RsySZmXd5JEEoVPYu9i
         Kq0We7GfgEbin7AK9bz2+zoP7tDqmKKKiJOiZP8c9BSLmuimr1j0ywCuVCB3mCWjzm5i
         +PWBZbQdFWVAPT5wcsoPNtnxQVZs7GFZ5UzzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508737; x=1793113537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NDO6zIwOQSguiV3BTsdtDwledkz4JeznmBoa6gMTpC0=;
        b=TmtNXC/R2rZssEHMBovAVpQkvjPX4XyxDlRQeahzY0F+0hRMr7OUMnl4ry92Gxg7s+
         GvC6bTyVzgW5WwEeIsSAJlkgl2AEKQSYmCLumH+IRFL9UyCaAX5/ZhzOpNeHd6Cu07CI
         3mFeZMVIoJjyT8EtP10BFAbF9XjNdHH1m4YM20IC6fd/TMMUlQNKQMLNQPjepgrDyuC+
         /kXXUINBTLgjgmKST/h0OWJWymv2zpbrZcp+pROcNMHdZdsAufp6vazNB4YEoukAlvYB
         n2ZAFmdkSy8AnOfosl+9vtJX4dY14xYdGe1mPv0vxFAbvSAPQADhqGQ8vBP4kowMQcTf
         qV9w==
X-Gm-Message-State: AFq9FYKuDcdWA9ZQghGkBQPkdeyWT2TFBEWFYBJx2JlXIY5UmkOImuay
	qQZ1K1t/tB1JwXJNVrE3+WELpdzCBM43p6jNUpvhtNy7Hyk1t3xLQkw7aaYhyh1lE8zUxtgI/BH
	3PLArU5c=
X-Gm-Gg: AYBFou1/MIv3xUvf6OE7MUD6fe2+y8FHeXTMxy6w7Z1yaAvh/Ao4hVCfCAWch7Ex216
	3h0OyJYj4724XquK1EB65E1GYqyI9fDFjl+jaCUoEvIRDEg1Sg9y057ne7VYjEMo/Iiexvef4Uf
	c5oR51IPhGgutJgcVy7qxDAtBITuRWvDNkJkvzEZhTsHms2/YtghvPGltFUh8i5qL6Lkp++TEcu
	IR8JpOqpE95n4lWsBV2JXbuyAX81MoVT+xj9teMEs67XkvMQQEMmW1H/WdFXaSRi9G4TgRNv2eM
	2eF9L8moVkLgVyQknmQKumu860rCzGaI7aJ+xED6VrrlNeL5RIcTYikq3yydehiV+UKtmUT9OFX
	RnyTo1GV8Eif25Eb2Te/g6NJtxzTxi/4GftxY9yBiTx/Tj12qJ2PRxSEkEVYnQIvPis0dWJDG06
	vbqdpyCcL+rZOentBRNVQ3OjcQNh+s4FUKVbB1QqwLPKUIr/Xqhar/Qi0PnQVbgNUfnlwCqAu1n
	kLaAHgbYXLSVWXqYQdP6bQrE7w=
X-Received: by 2002:a05:600c:19cb:b0:49f:c199:e1e2 with SMTP id 5b1f17b1804b1-4a1d7612042mr229604585e9.28.1792508735828;
        Tue, 20 Oct 2026 08:05:35 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:afe4:94a7:60b4:8f6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8214cbsm6567635f8f.43.2026.10.20.08.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:05:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH] ports/linux: Add missing header
Date: Tue, 20 Oct 2026 16:05:33 +0100
Message-ID: <20261020150533.1838141-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 15:05:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5111
Content-Type: text/plain; charset="utf-8"

The opentree* calls that were recently added need linux/mount.h on older verisons
of Linux, e.g. on Ubuntu 22.04.

Add the missing header.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ports/linux/portdefs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
index 6cece4e..ca96d06 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -34,6 +34,7 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);
 #include <sys/syscall.h>
 #include <sys/prctl.h>
 #include <linux/seccomp.h>
+#include <linux/mount.h>
 
 /* close_range()'s flags, and unshare(), are only declared by glibc under
  * _GNU_SOURCE, which pseudo does not build with. <linux/close_range.h> is
