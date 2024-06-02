Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA25FC25B74
	for <webhook@archiver.kernel.org>; Sun,  2 Jun 2024 11:48:39 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.57128.1717328908186332257
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 02 Jun 2024 04:48:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Jnh1LYCP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421208c97a2so30699285e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 02 Jun 2024 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717328906; x=1717933706; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XgVQZYvCkkSYjKfMlpC9ZEaE/yO00G0L+l5D+r5QO4c=;
        b=Jnh1LYCPBUVZgTJiNbjsf7tmdCHn99TeMpMimtR5S1ooAyKLdFPiEwlVIYFvD/GSl9
         r0B8JNm/IfCYdWLXXo6vksAT1DFjH/tQibVGEEM7sKQ/ASU0Qe1CuRMymB+MOt66gWn0
         kopgkAxAAcZtQOtzKozMgKIX5ZcBImo+5PL7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717328906; x=1717933706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgVQZYvCkkSYjKfMlpC9ZEaE/yO00G0L+l5D+r5QO4c=;
        b=KtEGcemt6ZskoATcGZJmbrccQpsx9TMHZtjRNNWfsoR6di+OT03b/+NZJcptuenKJO
         hgQoYFFkRZFCMCrOqEgAjMfdjDId1+guMXVyrG0ich9HcU3HRrKInsLKF4XORf5GvyRc
         aqOoyrrLVOfJARl3XesUKKGvQelgEXlypeK38R7XfgkyTVy3mgaZJ3lcYI4B8kkhysWg
         1LldKMMukQxU1LsM0Zm3sjtOFoo2jF76JGt3nJPY+WQ84b0QMglyn80eno1/HRfSgjsq
         OdPvIL8JF5EkfLyHULqtaOpensGQkWAYnDcLVkXvQvsL2Zb4lsoDwoDm1/9BRCY3CoB2
         ZKQA==
X-Gm-Message-State: AOJu0YyXMeHlWUD+LCMKmLrSta4bUNZvmCZ4f8uooXdPsnj6MbiNS/wO
	1vD1ljMqULjoTSoIWB1DXf8UfBl1LHVtTeiHSqG5ZclAcb1WP6aeF7orDP8viFv3DFKg4Vj3iwa
	t
X-Google-Smtp-Source: AGHT+IE9EkUQiBPSqNaTOtc7OAxMeIb7i7Kh/wBBbDKZ+xEl8VRgpaGMFdyGz3KS1kbbRgoJFkGZqA==
X-Received: by 2002:a05:600c:1f93:b0:420:104e:27ec with SMTP id 5b1f17b1804b1-4212e050641mr48433265e9.15.1717328905968;
        Sun, 02 Jun 2024 04:48:25 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:28a0:3627:3ef3:faf6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42133e66ce0sm57394935e9.23.2024.06.02.04.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 04:48:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH] libtool: Move append to generic filename
Date: Sun,  2 Jun 2024 12:48:24 +0100
Message-Id: <20240602114824.3396732-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 02 Jun 2024 11:48:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/274

The append is a single line mingw specific change which can be generic,
not version specific.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ...ivesdk-libtool_2.4.7.bbappend => nativesdk-libtool_%.bbappend} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-devtools/libtool/{nativesdk-libtool_2.4.7.bbappend => nativesdk-libtool_%.bbappend} (100%)

diff --git a/recipes-devtools/libtool/nativesdk-libtool_2.4.7.bbappend b/recipes-devtools/libtool/nativesdk-libtool_%.bbappend
similarity index 100%
rename from recipes-devtools/libtool/nativesdk-libtool_2.4.7.bbappend
rename to recipes-devtools/libtool/nativesdk-libtool_%.bbappend

