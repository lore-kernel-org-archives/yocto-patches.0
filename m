Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FDBC55182
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:35 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4597.1785497614067923196
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LGvggwtR;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e55b62640so42194985a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497613; x=1786102413; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JNYum/QGr74QSsjqlYe1sdVhak1co1XNjhJjFubTKZE=;
        b=LGvggwtRaoCMpeOrkyKhsjc1M4UbMPe/+hNbg1ZEP66wZnlxVbo+brbFyM/V1l+kiS
         oA95F6dIDayFWI5ZkbOBYwUJi39FBrD5NbpFqBR6XtZO5/04G7IDytvSkHlMBrICwB6Z
         d3TiXXW3GdaFfo8BrPToL0GExN5n1BCZENFcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497613; x=1786102413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JNYum/QGr74QSsjqlYe1sdVhak1co1XNjhJjFubTKZE=;
        b=ow4eZzg7pZdd0pGGbBIzdRTKDMUB1HSd0h/CgyR9HnOSXWfkM3twhKpofH3pdsWEcd
         AlL4SQIeC9QwuAwU55RxBIDN3OEyMX9BMrJe9bB0Smr2uEzu7VTkS1Ir/mJU6Zc4Vprf
         MEgpNiGuDbPalsFGHZXEqdSeUePa6nWVcTIHeUoWqlsbTyOWajbiuY5EX4jxS/IKHcoN
         +KIhoaOfqaR+YLfwMF5/v0VZqQAxWJuIffQhNOq5/07dLF6gZLOsNRF0jYMVszla160z
         PllrJaoK/ESRQGr10IYtZXiOTrT5F1AVGM/aUiwcQ8ImbsKvL5pLhUQW4yeLrv/qBoUm
         GY2w==
X-Gm-Message-State: AOJu0Ywzvwh39ccH2JqxBp77FvD1tYQcvtcb8nj1NmQv6r6eNMJoFOQr
	IV/upkCRz09IfnQHbNR6FO0kWVEixsXFiG7gp4PwQs46oMAYQtLZOU2RSQ6KQoohR5med2QZbbA
	A/5xS
X-Gm-Gg: AR+sD10OFEnQw5gaT4a1S//zIKcf8GcbqBqFZK/j4/xFSSBqr2BSxktoUG2i5kpcxlx
	v9zEGG5Qrw+G74Z+RHXaD14k8jiL8cSvn9MRgS5oqsZgDPXjJFuun2bepaHnk5QgD9sE4Mq9hCE
	HO2pmH+SYircNwBXYirbVTRy983b6z6l6j3NB21aJvUKR0icLL6HpLvpqhH4WGnYfk+U0Iy+J2V
	lRUVbbebIqvUXcD3j69AHOnh8qB+EC++WoU5omJaBvQu0kpEr5lqq57lHxXztBfuMKK1ufgferZ
	Rq1JRqGRGd5PGMDdRGDBL2NCGIPgqKyh11EFQGNAEc2MOZO6czDY1Zyfo/JBgJDV0gWL6auJ/1t
	WF5x3wCmnSqQYZkvU0lybU+VU/K6sn8lbyFyDQQdh907lsOT5XUR+kqyNxFdNadA2bdkwvUFPWj
	UG794BAgA7wr4fR46uiaou5BOjdKOZU3MNNYCLHDPzX/XrFUKK9yAn3qNYj+5D69TVzjtbJ3SLO
	IjVra6K9citHn273oBgiMVxk2rfATs1Yzifsk4uRG4Xmwvd8cS/4VlkKoXml1RxRaCekzJBjAwN
	cOMlWIq/JygqsGuK09CeS0I2jd2xcK6COein
X-Received: by 2002:a05:620a:406:b0:92e:9c65:da7b with SMTP id af79cd13be357-9349ad23267mr115842585a.45.1785497612696;
        Fri, 31 Jul 2026 04:33:32 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:32 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 20/35] librsvg: consolidate PACKAGECONFIG
Date: Fri, 31 Jul 2026 07:32:50 -0400
Message-ID: <0443b92f472efe41259f4e820e549c0e4934abe5.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4596

From: Ross Burton <ross.burton@arm.com>

Explictly appending PACKAGECONFIG makes it harder to directly control
PACKAGECONFIG, merge the assignments to keep it simple.

This does not change the behaviour of native builds as G-I is disabled
in native.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 8c240544896f32bf55499cfcd2e4471c505ed669)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg_2.61.3.bb | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-gnome/librsvg/librsvg_2.61.3.bb b/recipes-gnome/librsvg/librsvg_2.61.3.bb
index 1dbfab3..e9a14c6 100644
--- a/recipes-gnome/librsvg/librsvg_2.61.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.61.3.bb
@@ -56,8 +56,9 @@ LDFLAGS += " -L${B}/rsvg"
 # needed on ubuntu 20.04/debian 11 to avoid 'undefined reference to `dlsym'' errors
 BUILD_LDFLAGS += " -ldl"
 
-PACKAGECONFIG ??= "gdkpixbuf ${@bb.utils.contains('PTEST_ENABLED', '1', 'apitest', '', d)}"
-PACKAGECONFIG:append:class-target = " ${@bb.utils.contains('GI_DATA_ENABLED', 'True', 'vala', '', d)}"
+PACKAGECONFIG ??= "gdkpixbuf \
+                   ${@bb.utils.contains('PTEST_ENABLED', '1', 'apitest', '', d)} \
+                   ${@bb.utils.contains('GI_DATA_ENABLED', 'True', 'vala', '', d)}"
 # The gdk-pixbuf loader
 PACKAGECONFIG[gdkpixbuf] = "-Dpixbuf-loader=enabled,-Dpixbuf-loader=disabled,gdk-pixbuf-native"
 PACKAGECONFIG[vala] = "-Dvala=enabled,-Dvala=disabled"
-- 
2.55.0


