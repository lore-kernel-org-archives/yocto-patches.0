Return-Path: <samuli.piippo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6778D41D74
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 07:13:32 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42865.1765782805052896080
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 14 Dec 2025 23:13:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZQTvMTZt;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: samuli.piippo@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5957c929a5eso4662247e87.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 14 Dec 2025 23:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765782803; x=1766387603; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx3zjrsdjhWJoGGMWsEOEqP0zauAVlzZB6k+SOTHfXM=;
        b=ZQTvMTZtvnFKlS8CkfKfOOIY5+r+B+oeb1iRvlFe68Yug7udAx2VhpKpNfQTq8NnOr
         GAUNsbSfScoMZ7H6Gevs+998CBWpzdGMsiA0LITITAu3bYpOV/cSyzbqA4GVHXNqQxo2
         8fJEw2baN7Emem+j4slG4D353kVD3Uv4HDUeEnoK36lNVzTf4E1ZfjwxMHTkYZOVWyxE
         fqMnxL0pMqEvLYD38oLGw9jCR87ZW+n36qIM+s1mutWSNwzeeKRA1tZmow3+9ztK/R3d
         7fvqOtC+c1ybEJ3ARVCkfh/zY65+tLTC0uJbuO69j0JhEXXMyEhZ38ecoKnCTs35NZCf
         eDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765782803; x=1766387603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fx3zjrsdjhWJoGGMWsEOEqP0zauAVlzZB6k+SOTHfXM=;
        b=tD36Pwsi2nj7OVwqcznovu0OUrt8ukAE0RTjgmVDu7Y+Vg6lVrWjB884GxZEsVqbAe
         Cz/Q35n9fQeIoGk6ejcayiTr1XOTnZ2Jn4pfpKanmzrFSPBLc67uWgme6IkILHs8zO3V
         dbMBigo38Z8e4NjMk5bK7h/AVZov2B10PN45DIp/MeuHekMyxwuW7O7gCrK17KPeWTwF
         mdsUlWOEyDX3zZcssZeK7TTEmcKlScXxjYe+ccn2D8OM+JAxFjtxrFT68ih5JGqEOH18
         dhP5ieB8zUvPEytQ9R4MQKUvYU8hkq0Z1dF73usUkTz3nwGGUww2qa4omZx+/3pjShf5
         d9/Q==
X-Gm-Message-State: AOJu0Yxe68j59q+zLvvneJoDq70gXEcfWRheComuso84MFYIoz18jnoC
	KiOFzBvX/BO8Tgz/+NmouBNQQ7SktqMBm9/+XaFHtfyhe75R8VZmWarwJmkrXw==
X-Gm-Gg: AY/fxX74MtMe7YXcv0SDd7prlZl//uPOU6xjksZnR0OKf9Bafu0rkbYl5QdMvx2Z2g8
	NDnBz6/4+geXS1eAIqJUrtAM909/dPdj4PNc6rhpj35luTNZWZ7KXFcDdWIfRQzMJpDmwPZfbAj
	2/jfEJtd5S3NLd584Sv4SpM0PpZ0ByoJ/ED4IA1jkCAffAI2ci9uaf28ZwG31xVRd7dIO1QGyYQ
	rr/wtlkMTHdgWBK9EqMrLyVWLio47/vEfOYVQFd4eKxbNFDUae2ETs3Sjwy5e5nCbVtKzVFMuED
	A0DTUW7OzjMnfwghbehjp33tWL2umbxPr1LWuXXTLfWB9vaTcpB9JH6MTUdY5mkRei8r3JsCR9k
	YPyLDEVyGz6FzACQTU8Nv4do3dlv/5yL2s7D5h90j83A6KbUEszBftB7LmrsQFg3ysfsI5ZrQb5
	jhUOh8Cu3jsM0N5/kanSPhw8Fjjebi3OfnRof0WOXKo/An0dXenHmUb9boWSMyJzQ=
X-Google-Smtp-Source: AGHT+IFx67L2aCyKDlJ9rvJnUO2/fPCfncrf5seh2EdmCqB0ue1zLacmUKTxfDuJe5HaFdoAxthPSA==
X-Received: by 2002:a05:6512:110b:b0:596:9bfa:91a4 with SMTP id 2adb3069b0e04-598faa189abmr2917941e87.2.1765782802738;
        Sun, 14 Dec 2025 23:13:22 -0800 (PST)
Received: from dcbuildsrv.ci.qt.io (ip-109-75-238-172.customer.as29154.net. [109.75.238.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2f37b0dsm5018233e87.7.2025.12.14.23.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 23:13:22 -0800 (PST)
From: Samuli Piippo <samuli.piippo@gmail.com>
X-Google-Original-From: Samuli Piippo <samuli.piippo@qt.io>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH 2/2] curl: remove GCC-14 build fix
Date: Mon, 15 Dec 2025 07:12:45 +0000
Message-ID: <20251215071245.2864807-2-samuli.piippo@qt.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215071245.2864807-1-samuli.piippo@qt.io>
References: <20251215071245.2864807-1-samuli.piippo@qt.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 07:13:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2785

This fix is no longer required.

Signed-off-by: Samuli Piippo <samuli.piippo@qt.io>
---
 recipes-support/curl/curl_%.bbappend | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/recipes-support/curl/curl_%.bbappend b/recipes-support/curl/curl_%.bbappend
index 41342d4..c33c5a4 100644
--- a/recipes-support/curl/curl_%.bbappend
+++ b/recipes-support/curl/curl_%.bbappend
@@ -1,14 +1,3 @@
 PACKAGECONFIG:remove:class-nativesdk:mingw32 = "openssl"
 PACKAGECONFIG:append:class-nativesdk:mingw32 = " schannel"
 RRECOMMENDS:lib${BPN}:remove:mingw32 = "ca-certificates"
-
-# Configure tests for ioctlsocket FIONBIO fails with GCC-14
-# because gcc can now find warnings when compiling the test
-# and these warnings are treated as errors
-#  conftest.c: In function 'main':
-#   conftest.c:137:41: error: passing argument 3 of 'ioctlsocket' from incompatible pointer type [-Wincompatible-pointer-types]
-#     137 |         if(0 != ioctlsocket(0, FIONBIO, &flags))
-#         |                                         ^~~~~~
-#         |                                         |
-#         |                                         int *
-CFLAGS:append:mingw32 = " -Wno-error=incompatible-pointer-types"
-- 
2.43.0


