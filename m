Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEA7CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 14:47:47 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.131253.1781534865006295245
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jun 2026 07:47:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=J5/jb7Ta;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b613a17bso31257725e9.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781534863; x=1782139663; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4UmA0D8ROE0hDS/VNZLAIV/eZEXQzJpEqvclvxv7/aQ=;
        b=J5/jb7TaguB+zC0E67EcPOcwEBO0fLoE7Opp4mZz9bE480HGRD52jczxxe24WiPTpM
         b85CcJMLP2lofSeD09sFlfA7R0R4lDHFQgAhccgLv/G9YvbAmJQXPns0k0IZikRX341N
         xNB7X1jinOIERI1ms7gd6hKaoEQuY+AJ3TuffWyYS6enpQoCjbPjEEwkachZerK79qcJ
         3w94dk/d1MnKFK06oxk8e+BJmp+vVUjmMpD+Z1WvMvx90fVKfDiS3nP3c4+IKeOSJOy3
         mSpGlwDrgazJDC1XxVaCTtWXSBIVtTPRFdevWOFrqZFosnkzYWR7Cy2qsv6BEVt3lcap
         M4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781534863; x=1782139663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UmA0D8ROE0hDS/VNZLAIV/eZEXQzJpEqvclvxv7/aQ=;
        b=CCKfCYVAJHy8hdhMxj9/zgYVif7pIXEr+vnZf8gtg78oDqGNaQEmku7pZUJcrDXvLE
         pwN3jW3wVgAbfovVQlYeZu9p1UVV0J7X1ALwuE+LLBVoSdmkm9LTx96d6ItQyhdLMiP+
         cVbkVOvKCZXZA5R5i+6TNb0jfQrbwMlO/8A1W942a1TT+ebFBTu1HoxSG+UEkQ9ONJf4
         ZeoKNdRwGNeGzqRh0oqoKiVy3v5C8Fp+rF+ArjUuttYrucNtTeEiS2Bwip7eXRdpVrvb
         ZwpvH7BoGwcsVz12/esfuGAHTi2NZM+mpy42FZ2+xBhb2gqvFHrrtdknmPNvDfEtwadh
         W1Kg==
X-Gm-Message-State: AOJu0YyQALzYe1zBdALJy5A7AhaY55UcYL4QUjj63gMiwsgy8KW/0/+T
	3x1wAoNpPMzU592zqBBUjuc+LUNkMJ2Gl0qlp8yCKbb9XJQ2Nn1+G0LeCtUiPMey
X-Gm-Gg: Acq92OGfBzDr/pqm4fSx55qt5FBi51/aZ40ai1916npKN1PwCBT+fkHVbIAkNOoi5d1
	kvreRzzqY93P8wRxmygjPxXtfkWsBOEy5FijEvTAXyolNuh7R10gqaXGuPfVH2eOn6HJNNu9kzw
	xu7huN4xkiqnMwJDvAHjjPYe1JFL9fpnC6i2NkPwRdINmGgCXYiYonkqA/EA2gEP6iDYdzsiQ8n
	3d7eJmJcT5WKxkWlKbMr1YNE7hBLu+2xqHvChTasP13EqhyccsGagnB8ItJOeafYtMZ2t2CMwwR
	FJk8Fs37lqc+LfuwMKy+Qi3SxjLcmX+jvm6xpRsUr+Hjbll+PZFXBiP5QBx5+t/YtgCw+aIlN1U
	l3tHGWX/z7gMaD1pWC9fXA83uMqlu6dO6aZi2mCcR51UGRSMj46pcR7uZOyRWbuWxmAL8Zd1C4l
	gUj3iyJ7t0rCoUbaGIt+Qhv7U8dhZhqT1EPNdVMu1Zq4QYIlezr0qfzwUSa3E=
X-Received: by 2002:a05:600c:e54a:10b0:490:be8e:c890 with SMTP id 5b1f17b1804b1-490ec4de5bamr125694665e9.13.1781534862802;
        Mon, 15 Jun 2026 07:47:42 -0700 (PDT)
Received: from alex-lx-laptop.lab.linutronix.de ([2a02:2455:86ac:8b00:8de8:97f1:4c58:d8a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922032ae56sm252451455e9.7.2026.06.15.07.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:47:42 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [yocto-autobuilder-helper][PATCH] config.json: correctly timestamp AUH state (replace %M with %m).
Date: Mon, 15 Jun 2026 16:47:35 +0200
Message-ID: <20260615144735.222667-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 14:47:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4228

From: Alexander Kanavin <alex@linutronix.de>

%M is minutes, %m is month.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 57b53f0..f4ead18 100644
--- a/config.json
+++ b/config.json
@@ -1595,7 +1595,7 @@
                     "../auto-upgrade-helper/upgrade-helper.py -e all --incremental",
                     "mkdir -p ${WEBPUBLISH_DIR}/pub/auh/",
                     "cp -rf ./upgrade-helper/* ${WEBPUBLISH_DIR}/pub/auh/",
-                    "cp ${WEBPUBLISH_DIR}/pub/auh/auh-state.json ${WEBPUBLISH_DIR}/pub/auh/auh-state.json.`date +%Y%M%d%H%M`"
+                    "cp ${WEBPUBLISH_DIR}/pub/auh/auh-state.json ${WEBPUBLISH_DIR}/pub/auh/auh-state.json.`date +%Y%m%d%H%M`"
                 ]
             }
         },
-- 
2.53.0


