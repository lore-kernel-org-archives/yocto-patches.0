Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91152CC6B33
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 08:42:27 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11265.1775119344298295079
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 01:42:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bPlKO3sY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486507134e4so7489305e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 01:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775119342; x=1775724142; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bbhgoek6mdd/Xe0Jb4zhpXD80S/Vavnv5K+3Qm0RLfE=;
        b=bPlKO3sY7ScGW68/qA1g8yaE1x4kFTZ45JvK0U3pV4FLJY/iiI/sQ0eYyx+vTMeAkL
         VRFkmimsBTWkbu6hSWtFc8hmvS8Au84unYxIXRD2YjCSXaGI1IV+NgEN4W0kkzEvq9Lh
         xhV4Gxiyt/mh+DFP90+wEQlhEduxPXFlLiUQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775119342; x=1775724142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbhgoek6mdd/Xe0Jb4zhpXD80S/Vavnv5K+3Qm0RLfE=;
        b=jnzXsgpsQoJiyAxXNeezibwULNAR7TWxmDyqEn7YJpSKeWuXsoa3BUNEwVbfQMKS+K
         f2202AZjLh2NWpk/7LbjjZpR+Dl1OGHwgb+ccfcSDrQsCgQgLvkbZbHGooCsILOGPyke
         SoWsETj3CU9im5SFdBxlXQ1JdNUt063f/6ZBm7YfdxB2ONGkCTJXpsnIwKp0IwVq4ol8
         BJLWGX9PfqJg09SsKLnHv/BHFCGDkGV7y+hYZ0CxWgM11wUznD+qP0KsFj6grD/gapxv
         qfgP13eSiVA9UmZVkiSZlfbMf/sxPyTCNu1W3zuwCD98pRnfYVPapPlhMoOSwwxB4bns
         AkCg==
X-Gm-Message-State: AOJu0YxlXQTTATL6shFyxemuyEokSxyWXZq+O7lD4yjPqOOjzCrhTTrN
	JlCljv/ZLgqvKqudXgUTw2gUXDJ7aQSb/qI1vup+uGVxnKsjcbBZQy8qO6joKjQPR6APC3h8GE4
	ZDTtz
X-Gm-Gg: ATEYQzwSOYkkmRH1OwccJrTZW+dg3o7nE7SM967y/zRCOFzv3K4vXpY8QZbQ6vD3wHx
	ula5BKFIvVzsx8ZLw0iRQ/j9QCeJawAtrBqAgyJqBiczvz7PEXA2yJQVCy2L8uu/sFlo9NGFKD+
	RUE1uFZvRqNu/3jRZTROtfD5NlXluBcYHoRyiMSLcB/zlbK9TtH1lGjAvMVm8st7acw0BJs1MMR
	uCIZ/6jE4mrskcoh9CnNS1fozE22jZzmsi+7codZf3Zoe6V4JmkcJoZ6vgivZsBSYvbifXfcxpa
	yWIRbsg3HdcqVQtYbsgwmN8Yo2SXpJdb6dP7nm7qaggLkuCuIFmDw4RfurI2xDybUI08CfZa7en
	lMOC0x5zdopMJLQqdR8TmZQqPgzyGT5xlxdMZxn5nNoew7ta8k1RQ7k9w4LaDVWRzXpmN0PmTM3
	pRvKPgGSabwSZHQ13cbfCqX+GAddw10EeuAErC6RgJ0lYdQRK0FJQj
X-Received: by 2002:a05:600c:858e:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-488835ccc9dmr96172985e9.27.1775119342062;
        Thu, 02 Apr 2026 01:42:22 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a695:b092:8c54:d70f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8dca46sm71180685e9.30.2026.04.02.01.42.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:42:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Use DISTRO=poky for oe-selftest in bringup
Date: Thu,  2 Apr 2026 09:42:19 +0100
Message-ID: <20260402084219.3339173-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 08:42:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3612

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index 0902e86..51eb546 100644
--- a/config.json
+++ b/config.json
@@ -238,6 +238,7 @@
                 "PACKAGE_CLASSES" : "package_rpm",
                 "extravars" : [
                     "MACHINE = 'qemux86-64'",
+                    "DISTRO = 'poky'",
                     "RPM_GPG_SIGN_CHUNK = '1'"
                 ],
                 "EXTRACMDS" : ["oe-selftest -a --skip-tests distrodata.Distrodata.test_checkpkg -T yocto-mirrors -T machine -T toolchain-user -T toolchain-system -j 15"],

