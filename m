Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33B6ECE586
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 14:55:54 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web11.55122.1725893744760274597
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 07:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kp/zDkxS;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: twoerner@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-710d5d9aac1so1703285a34.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893743; x=1726498543; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji5EQlPvSQa4KxrEh/weHYXQpnJGnD65gniEaQM5bYs=;
        b=kp/zDkxS/0uKhrCDyCB9E7cenzTQahi9nOJ89l5yUf9AGpeUBup/TGRVjC2hdYMri8
         T07jVcmqB65WCpK8PAxOfuFRC8Ng/SCO0WSFniNZx8WAsoQOU4niYi8L0wXTIaP3ybcC
         YiaaatyshIS/BRfSN1BAKMrf351PD6ctfiYSgSASTjzQQwh3MSppVU1NGCw0B4GBKwTh
         v4XtBW6FfmO/D7gLfPdk5xtuQ9k3d/vd5Er/r97n2jBsmKR29NVY/4v+zVPIxlgwUbpf
         VIBpk8FmD+lmMSZf0wQ/6oUn1C9U3N4gN5pOZH5MgatImzbbQ023bsGDoqJhXRwlPH0Z
         miIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893743; x=1726498543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ji5EQlPvSQa4KxrEh/weHYXQpnJGnD65gniEaQM5bYs=;
        b=U+vnl+9rOzmABVKPWklfwM67Y8ml3rI3tBz2Mg6BBicBeFbsVrtI+d0pa6wybuNtJg
         gj/EAmd86hJT1rceJWJPgxSk/Dc6lGS/EK6E9KRgTDkl03+NXHI1Ea7f3rIt1pAcdK0D
         TTnK+Oi6mqLLei9gjpdu2lu654tdEAA9hbmI8FMWdLcp9kl7IZwNQ4lfIdtT6A/HNt9a
         d14ekKzkC3OZzySLii7x0OGIeo3iyi7JvFFM4k4W7isl32+3KeQGNjcvtm9xwXV//Au6
         k3/rUxT9QmarMnfgcM1fZZ1tJJ5ugouB3HFwn6pp8t2VXGEbT6Gett5+EgUb2MqdJTkO
         cuqQ==
X-Gm-Message-State: AOJu0YzFZY2vZi88mqXcTe3pWWgIrqyMqKu2DbGpaIGi8wGTmU6e7gd9
	2awKy2NHtGYwixBbLe8HW7IPijti/lNCQiuNtipf9cg97+kzxPtb/46nIEuD
X-Google-Smtp-Source: AGHT+IGZNVDFXNGetvdAEhVfFyC8fXjbhfOm7O0SrFim4Zo3RTP8lzeA3yp+HRmtrv8KQcGqGGlIow==
X-Received: by 2002:a05:6830:6310:b0:70c:9c66:af53 with SMTP id 46e09a7af769-710cc25d760mr13457266a34.25.1725893743274;
        Mon, 09 Sep 2024 07:55:43 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e772a2sm21050231cf.27.2024.09.09.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:55:42 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][scarthgap][PATCH 01/10] mesa: enable lima on all rk3328 boards
Date: Mon,  9 Sep 2024 10:55:21 -0400
Message-ID: <20240909145530.25301-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240909145530.25301-1-twoerner@gmail.com>
References: <20240909145530.25301-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 14:55:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/627

From: Quentin Schulz <quentin.schulz@cherry.de>

lima is the open-source implementation for the GPU found on RK3328, it
is therefore not specific to the Rock64 but all boards based on the
RK3328.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa_%.bbappend | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa_%.bbappend
index 58c25e7d61bf..a31d99b5c65b 100644
--- a/recipes-graphics/mesa/mesa_%.bbappend
+++ b/recipes-graphics/mesa/mesa_%.bbappend
@@ -1,4 +1,4 @@
 PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
+PACKAGECONFIG:append:rk3328 = " kmsro lima"
 PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
-PACKAGECONFIG:append:rock64 = " kmsro lima"
 PACKAGECONFIG:append:px30 = " kmsro panfrost"
-- 
2.44.0.478.g7774cfed6261


