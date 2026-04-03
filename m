Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83514E85397
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 18:37:06 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2219.1775241425311318703
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 11:37:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QcNgbDd7;
 spf=pass (domain: gmail.com, ip: 209.85.222.178, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d1b746f522so249005485a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775241424; x=1775846224; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udBvFrM9zqiSWuKj8GsYYdaVTL93eR8UGvYeG61dTus=;
        b=QcNgbDd7IJaTOd7EkWhD8eiCITQPjRAUPW6/2QrXoJwoTLd26d00Y/3ImBBad0x+Pv
         k1HRn4wtzGzZn4EMlqnN7cD/t/E0xkGh2h087D2a9pj2hCkr2H5wRxm5CQCV12/zDbLg
         rNz6CqCfBEqf2LQRivVZK9ECDLUuUQ+B6zUdERoyQrDgClgT54tthyFaTEOTdCXd4y1C
         y2lCT+P1Ikh4N4RiyK6YDhuo3QWI+efOgwT8GA/oLWFk0NwyKHAiR2HWFb198KY9oONp
         QmJrciyE/mWsP64DClainZl0nIbpiU/7YnlvbI41g3OFO9Yds92fO2ifqEl5c/hFXewl
         kaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241424; x=1775846224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udBvFrM9zqiSWuKj8GsYYdaVTL93eR8UGvYeG61dTus=;
        b=SATb8Ro7gHeWHbO7SYPIBNnK++nRkGxNl6vVy+ElEk6lGp++CQFb0ZpLs9TuacLJop
         nMz+6VvUbkAlIv/1hMIuCKsxC+lBOXD+khS0tlYluyQ5iHL6QXnN603sWDNlSE8WlL1t
         b4RTCKvHsdL+OZsyYP9dSuK0WOGp4pnPvWg9vEOC+Vbbtt8KmT9rOV1lEZw9FQyp1n4Q
         626oY4ML+RvlLHughGT1bFbvLTv5L65O6jCjPhdqCZND6LnECgA5w2QinffLMC5L7hW1
         YeJvvbOgFUm6xBbcBsPRM/8Xqcwwqew9BVJFUsOkwvLVhKKsG5ctPU0UQN+L2vuawKl9
         08Kg==
X-Gm-Message-State: AOJu0YwIVJ50uhjveKWb534aOuG62eShy6Eo5Ttmtir++vHbHWUCTely
	QsQcpQ9mt4RYLbEBD+zrWGkNYOLEO+STsRAd6jDUt33EflQpDZtTsVveFj5SMKUN
X-Gm-Gg: ATEYQzwOkxQTBBkrF6uMJoZoMd+FG5dJPfMxdT7j86FTlZ2erUpNjVAJvsj6gEn2LBa
	aLS9pxPl9IWkkjKBKoynmqAcCokhcrGC8iBrDhR5HAKMff0YC3rNEMF8D0Jh2nTMi+x38hBpI+S
	E69UXYaCDnm7D0wE+d/lNlUXPtzLdu0iaI0Nq/ciTZiY+kA+EH7c8J2k2TrxKz8WrIORBhWiH/q
	ef5YR6Hevq5N9h0JIWdN/bwXDxIInaC9eCd/TbE5gyTzceJpu06KYh5lbuPrutzucSY0embC/9X
	GKzOFPTHuY1w2noVRIjYnBf4Wpt+OMVE9PAocJf0ErsFfr14dbdLJdzfDmncfEv+dpO9oekyzNH
	nM9ZyuW/Pj9S+bDr7E+463jHa2cUBIOXkNhPkqWd3Z6DnBGvGVBHbZ+Rz+y1QWhBjv12dwaUOBq
	RKL6bBmxlvojznBVJqspBrs/WCkIZVCW57gKHmu/jbFRiu0YNeNk/hE5gSYPuiOro7jA==
X-Received: by 2002:a05:620a:440a:b0:8c7:13b8:8b55 with SMTP id af79cd13be357-8d41e2413d7mr583867285a.46.1775241423687;
        Fri, 03 Apr 2026 11:37:03 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a874459asm472401785a.39.2026.04.03.11.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:37:02 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [wic][PATCH 6/9] cli.py: remove bitbake coupling
Date: Fri,  3 Apr 2026 14:36:41 -0400
Message-ID: <20260403183644.2783267-7-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403183644.2783267-1-twoerner@gmail.com>
References: <20260403183644.2783267-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 18:37:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3632

The code that is being removed in this commit uses the scriptpath module
to add more paths to sys.path in order to find oe-core-specific and
bitbake-specific modules by using relative paths. In other words, this
code assumes it is located within oe-core or bitbake. By splitting out
wic, it is no longer located where these relative searches have any
chance of working, therefore remove this coupling.

Additionally, the bitbake_path variable does not appear to be used
anywhere, so it is removed as well.

NOTE: this commit does not work as-is, but is being provided in order to
      explicitly show a clean transition from oe-core

Reviewed-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Reviewed-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/cli.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/src/wic/cli.py b/src/wic/cli.py
index 9de5efbb5aec..04b2ad25cac5 100755
--- a/src/wic/cli.py
+++ b/src/wic/cli.py
@@ -28,10 +28,6 @@ from collections import namedtuple
 
 # External modules
 scripts_path = os.path.dirname(os.path.realpath(__file__))
-lib_path = scripts_path + '/lib'
-sys.path.insert(0, lib_path)
-import scriptpath
-scriptpath.add_oe_lib_path()
 
 # Check whether wic is running within eSDK environment
 sdkroot = scripts_path
@@ -48,9 +44,6 @@ if os.environ.get('SDKTARGETSYSROOT'):
         sdkroot = os.path.dirname(sdkroot)
 
 bitbake_exe = shutil.which('bitbake')
-if bitbake_exe:
-    bitbake_path = scriptpath.add_bitbake_lib_path()
-    import bb
 
 from wic import WicError
 from wic.misc import get_bitbake_var, BB_VARS
-- 
2.51.0


