Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D29CCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 17:45:33 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1993.1762278327847627737
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Nov 2025 09:45:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IwsGNY+a;
 spf=pass (domain: gmail.com, ip: 209.85.128.180, mailfrom: twoerner@gmail.com)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7866c61a9bbso27149097b3.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 09:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762278326; x=1762883126; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XMq5lCjV+9skIj8cbvHW8iUcVbXGQ7BYFC5iPofvjbM=;
        b=IwsGNY+aUPeq/nQquyP4p1dAp9HgMtLDYJo2TpR06CxZB2QZl59LRwg6Tic3P6hW4q
         hKPZGnMr5i4FJrjPK/YD2rFcZiX+XEiD3WqUj1S315671OC/qZiwyUmm2JhHEPP0uSmo
         4ECwgrXyMYl40Mg7K0bF0pIFj2TUnsqaYtQ4Y2lCebRJeHUwX2jMYVFSNG3s+zPLvBR0
         4oET8jonSl4ooYPguRsuLeUNFAUtFBEjS8QwccvHs0GC3wZeKy4dZSd+nc9R0zAIL8Xs
         NNZ00I8uQdmnquBSfc11RL/BuG70symZAc3gpZ067Z9KSoEi/MfVoZtSBeX1MwQYIC0I
         YXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278326; x=1762883126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMq5lCjV+9skIj8cbvHW8iUcVbXGQ7BYFC5iPofvjbM=;
        b=TepkznKoXvsVDEF8zDG3x9CGWa5GQhm2FCxoG2oryB6dwL6eE4SORR5q6P84dPiHOl
         Y6Ytx+sdShb+TOwaDc6RTucQoUPdwWQXZKtNtUNG6YIcJCh5w0e9nMzfs+u3g5Zj1t7l
         lzjzRSvwv5+ScK0MxNUv55x8PazglqnZj2lGKniC3sS0NLmEMhdTda8yD9X3sfszWR9s
         z9l9mYQKiMF5fuC4G+ciycUv8il4dGWCRzWrdaWrftNUSOIqCmJ9KDd64Z8uuVIYCKib
         0eaupNgDbWsg37msEL7WObH0i7mJlAMSEAWBY8VW1tYQrhuuLYC+SoHaFUiHuIBwmqGk
         crzA==
X-Gm-Message-State: AOJu0YyFELQeSBS11DCRdmlO6wU9NFnNPt6pzTnk8QegHTCmBXkoSTnl
	nDYssOXxBFSbuCt8JxDsewYpiRKvQ3o43mTKu3klThRWVDDYTc8ajgkVN8g0AQ==
X-Gm-Gg: ASbGnctgDQ5VgW1cT6sFKT2MoChQPObcESUvArNCjGuTrLh6X9z0wSaygD87SdT8EjE
	cEScD/7VTfQCeiyFHN2BOs+09sSE51ctw3SUfiOHZk9FggJTp+tnBa0lrSbIMWU/xFFj6GgzDXg
	/NEHJ2alPGAAvdsZsA38eQzXLoCL921bVsPWs5l2C8uwwe5n/DsmghBLGLxYxUhtg6LEqAF3FNO
	+dx/2wS2Sbe857mDWf2DXfzswjz+kabhe3jtArPgUziZAIagkS5Wn6PDD/gIUfhHyMvR1IfeaIb
	mu5gdLlk+z+3hCax1RQ9vKeA/NbPvlQdfyNuwD7pLHht93YAexatCmpos8ZD6emlCVbMEPHWiQc
	2Gw52rraVXHjy3maezKjsr8rj+7RGT65k4xyloev+qRZl39EA//r355r41zuo2tTVWcPPKqB74M
	P/JpeZNPzeCVHEwKQhZozgFAYmUg0=
X-Google-Smtp-Source: AGHT+IFwYrakRcAIX45+BQ7gwE3pNlqdSDFvfin/Pvvl9nNWXlhPpicVprss/IaEid4F67MoNC8lfA==
X-Received: by 2002:a05:690c:5c16:b0:786:6f81:eb1b with SMTP id 00721157ae682-786a40ef252mr3922107b3.6.1762278326371;
        Tue, 04 Nov 2025 09:45:26 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691fd9482sm11564527b3.36.2025.11.04.09.45.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:45:25 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] fix sed invocation
Date: Tue,  4 Nov 2025 12:45:16 -0500
Message-ID: <20251104174516.31259-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 17:45:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2418

"sed -ie" is different than "sed -i -e". Although both run the script on
the intended file in-place, the first one creates a backup. These two
were accidentally merged into one option which can sometimes work, but
not in this case.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
index 323b63b01f40..82dec84a8d5c 100644
--- a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
@@ -5,5 +5,5 @@ PACKAGE_ARCH:rk-rauc-demo = "${MACHINE_ARCH}"
 FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
 
 do_install:prepend:rk-rauc-demo() {
-	sed -ie 's!@MACHINE@!${MACHINE}!g' ${UNPACKDIR}/system.conf
+	sed -i -e 's!@MACHINE@!${MACHINE}!g' ${UNPACKDIR}/system.conf
 }
-- 
2.51.0.193.g4975ec3473b4


