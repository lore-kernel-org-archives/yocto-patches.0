Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E57DC55182
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 14:01:38 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43725.1785765697131555415
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 03 Aug 2026 07:01:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KmQMrPa+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954df200ddso14023175e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 03 Aug 2026 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785765695; x=1786370495; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yi5lVt1bkghxnVROq6WFEYCBnleGfgc58kudKrrw/TY=;
        b=KmQMrPa+EWondY1r1Sq+6kY8s7KFoQvfPftFekg2jFndmYgelaprfZlUYgsfg4bix8
         ob0EmtuEmtvlWZERyqg1HW5ZfhTKD/sXms29yuhdvzg2CzrH4QscNrZkYYb8a9jwlPql
         2HnngfFKj28tD376Ugibk/fEaX3auJ4rTRj5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785765695; x=1786370495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Yi5lVt1bkghxnVROq6WFEYCBnleGfgc58kudKrrw/TY=;
        b=FB2deq2WP65jvd777iPSaP0Jvslj5Sbpgh15WuliPpqtOLOvF2WoL3a/JlvdwcTK6s
         0tMPiGBS0Ps7n4gUU35Bijgr+Hr/0c8Zyfx+GMBw3udbGX6xL17tc0s+O/vOXatgvTrM
         g+69VTCbyM6En4A8cETvgoINo6UyQSydkTZSyXgi9oPHTmItyHoEUwlW1UpAk32l2sIZ
         UA6DMtLGrm2ewy94w9XtO5XIT/sQ93Yr3Sj0a1ZhOPuUZH1yiduFMnviymGaEhCBjpWU
         dsb6fEIUsV6ZvQ8/AMYgKIXxaLna5DowW8ua8/1lY35ZuQccY/NS2CDhBGXbyZutaqUn
         +eNQ==
X-Gm-Message-State: AOJu0YztZwXRsLoiTcFudZC0laeAyJEU11k3VXXm1q9stJ43Kdyvrgzz
	ZjyV7pIa27n4ialB/ewNpDGP3kTLERNjBRfrisRFBh6BAwGtcsIUNJmgDXQkY+HOqBnN+LR5ah8
	mdeYGZVg=
X-Gm-Gg: AR+sD10bI026XQRXmlyWLC2wltzLE9Wyk1eQzx1E1P3+wEkhRzzfYAS5fQZRGP6zFd2
	fusS97SRXyQC6WqoNrF5mAJHGy6G7vR3U+SzQA/3Wufv1x2R5DAcgxIweiL0mPioDmPZ1yPYyXP
	VZVuvy9m9ubFRvk6D9pXCH00sIo5KNFYz0WEENVQ8Xepk1m/r5NfBy5AFR5xYJXRmaUQaF83Ooi
	Xfos5U9sG5CaLw991dlblOR1B02Ud0z1hBmueAntmh1VWEmIBYdHqmCfHQ/YQFhhg1D6fF6wXCn
	NXn9saYtMQODUlorYl3b3Evy9Xo6deHZq/bznd+atiECtVxMMFJIOB4azm4YmW/8mhYZ8URfna2
	P3XPXZNMQ3dPL6mIlv3PNP7amFNXZKISWcrBxEThCno0BmCCsSBa/lDP99uHx+88r75aXO4YBTt
	mMnYz9ZGJZbzlxoCCZevPntu2yP0x+p5E6iiEJW9H83if+08+ZLsCnq7TGfnJzC9J2eESQSwdTW
	U9bxoYEv4AEItYrsw==
X-Received: by 2002:a05:600d:8443:20b0:493:e974:41ac with SMTP id 5b1f17b1804b1-4980c6562c5mr180880355e9.16.1785765695098;
        Mon, 03 Aug 2026 07:01:35 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6b5c:9c24:b513:8797])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980869106csm298697595e9.9.2026.08.03.07.01.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:01:33 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] shared-repo-unpack: Drop confusing unused variable
Date: Mon,  3 Aug 2026 15:01:31 +0100
Message-ID: <20260803140131.1542251-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 03 Aug 2026 14:01:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4617

This must be a leftover from previous code and is confusing since
we always use bitbake-setup. Remove it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/shared-repo-unpack | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/shared-repo-unpack b/scripts/shared-repo-unpack
index 797dec6..d1089cc 100755
--- a/scripts/shared-repo-unpack
+++ b/scripts/shared-repo-unpack
@@ -54,8 +54,6 @@ with open(layerjson) as f:
 
 utils.filterrepojson(repos, args.target)
 
-bitbake_setup = False
-
 targetsubdir = args.abworkdir + "/repos"
 needrepos_baseddirs = [r.split('/')[0] for r in needrepos]
 for repo in sorted(repos.keys()):

