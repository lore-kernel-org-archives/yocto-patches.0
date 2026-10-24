Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14291.1792880802652296549
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 24 Oct 2026 15:26:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VIMbNTMi;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1612944a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Oct 2026 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792880802; x=1793485602; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ugmmp2iKNsff+YZnydw9rsSH+z3ZQIXtO09HHk8HoSo=;
        b=VIMbNTMilRKneYH5Fs9mcY2QOc+ZEJei31iBb1HM93Ph8IK3Sx+kdvpvUDUFELBEGw
         iG0ENM5SD4t6TY0bK/icgwK7USl+6xgbled1cX/7qAAyDNh/YkbffUmvH1kLjXp+uEDg
         FgPptSEbWcSTFwGPe9VJzrBz9fQbx+RO0p9bC8G6Y+Yd6DOE8ZPSGwbHNO+xP5YxHIgZ
         XDWvPjVKmnYLIIFitMhdZHYoZvBB2RaeoMOM1Pvem9Y/LMfE5kc0sqzTRrF4pFay1p/z
         nF+tGL7Yy1/2Bmoz9Fp4lnz4Aza5w4UpuJ8W/+12nYjPuFTdoSqv+jzA++FdytKlhOLk
         Z3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792880802; x=1793485602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ugmmp2iKNsff+YZnydw9rsSH+z3ZQIXtO09HHk8HoSo=;
        b=aXbYUq0cjMAYXB0U8ua6tZ9M1cJmZJ8PS8T/N7KXEvYcL/Tr7iPKFU9C4W0/L+aBmv
         pIAKEwcTXO7TYFWzeQm04GhCt1cR9ns/1ZHGPinkwQrQ3i+06/At/pYNrqfk5/lWVttc
         nwaxya37Xfd81/tahS8qc87MPFtRsalPuCSKhE/o7GSdB6ZSjK40Rd4iuPIr04PzIgeq
         S2WLgVnffc/qysz1dGQQxMkwuSt6a5CuQjPxOsB71b4n/W+4UJPRdAKh66BPca853P/R
         /VCqlxVp1OLOovsNqCb4WylAaKx+3bnu+MYYE50F5IXfyINQLUA5jPbcuO+zG76Svz0n
         SwmA==
X-Gm-Message-State: AFq9FYIbzz55XVg8CHFyA+OnuW8nKo6C7AjNqLeNycuzmboQIc4aX/qr
	LR3d7g7CUHzv2/88FwQpeBNBdZpfClRzHZ8i0O+u2XHdCzvkZ7uyut4zLKIZcth5
X-Gm-Gg: AYBFou2/nq5S55k9cSVBcEvv4WqnrxYbEOTqgU93GoXwsDBFhnNlZyaYX74IEWy/mrV
	eIvT2yPcpdR2KDZcd9tqCbYPgg6ZHvn5nysi2MxVNk6bGKQECvbbra40274DMdWB/Ojjgrv5kSR
	7e8jksOMoGaQw+yt4iE6qFygyt3DMBgTkB59WMu9wZks57Mppgxq/UG+H1UgqkHl8NBCKjQoO7y
	a9IgTENuHytaV867swlxTDbFyUM2lEe9KFZAKqmBqTHb27fnlvIV8c+zBdxDhXBU9V1oW2uMk2S
	r44MXQUBiRrrWIlE7+0VmfRqwhu/rdS2Z42GIUpeLnuySB/rspn/M5ir/mZEtEKWgoSCaJB8wju
	buL8GIRK3AAjsMEXdD1m+QaVAb4cvNAme5CvlRPk5VY7mB7/D+MYlAEzMPoEUem1DEXLoIhLanN
	GeNe/rmkj/dW8GdCvR1+GB5ihD/xIFOReTadEVYEKk9QOUTeEBk96XUfztN5GaMTm32UkQqjhgE
	3mr5UUTK2vQYlFC9RzMKkxOuHJt1gpWUpXVhDCBfGsRWJWSFqqZAVNwuGKWu1aF684WWS9CD9bX
	NVWPmyua4j8l
X-Received: by 2002:a17:90b:2891:b0:3ab:24b2:9016 with SMTP id 98e67ed59e1d1-3adead488d1mr2790844a91.25.1792880801818;
        Sat, 24 Oct 2026 15:26:41 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe9078asm3725209a91.10.2026.10.24.15.26.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 15:26:39 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/3] requirements.txt: fix djangorestframework and GitPython vulnerabilities
Date: Sat, 24 Oct 2026 15:26:31 -0700
Message-ID: <20261024222633.84011-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Oct 2026 22:26:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5146
Content-Type: text/plain; charset="utf-8"

Upgrade djangorestframework to 3.18.2 and GitPython to 3.2.1 to fix the
advisories reported against 3.18.0 and 3.1.62. Pillow is left at 12.3.0:
the fixed 13.0.0 needs Python 3.11 or later.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/requirements.txt b/requirements.txt
index 4bfcd7f..a0d32c2 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -20,9 +20,9 @@ django-registration==5.2.1
 django-reversion==6.3.0
 django-reversion-compare==0.17.0
 django-simple-captcha==0.7.0
-djangorestframework==3.18.0
+djangorestframework==3.18.2
 gitdb==4.0.12
-GitPython==3.1.62
+GitPython==3.2.1
 kombu==5.6.2
 mysqlclient==2.2.8
 packaging_legacy==23.0.post0
-- 
2.56.0

