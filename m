Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2474ED4A605
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 06:47:54 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.870.1768546073204506341
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 22:47:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Yk0vgW1o;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so1359195f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768546071; x=1769150871; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKW2SjA3y8+Z8ZCWklH9slLTwqBC2V5k70dSsuAIu04=;
        b=Yk0vgW1oAevZw8ks8GLUyQaXy5a6YJfM3vm1WO6Go0ZQo2J+2/lZeN60BgwgHYOa7/
         f1IANmGFNX/2rLDosxIxxdzlbkvn+6GN83iGmHh2DGdAvg5t+JoTebNG56ub9ZsuhFvt
         nCE5RlLuErfprsRULxwgJqFwanItcKMfrJvM93oP4/LKRjVy8MKXnVYYeE/vhRiqbqNn
         Z8+b3dx8Y0/9e3rjccLJqMYPV2Sl/mbUA9vUnDt127knScXj1dv4/Z1D286fJCy3IJEJ
         MnbMPmFjLb06uVJZsQ0tyPPLAPc6avWjwtZ7DHZMAiF7WDusfcITITjHWq6nSJJjosOj
         wYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768546071; x=1769150871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZKW2SjA3y8+Z8ZCWklH9slLTwqBC2V5k70dSsuAIu04=;
        b=gj9yPNRuqqOQjnRyPel5Pcpjp4gbNX61RcKFPT8MbuNS3PYOVHF+qPLAZOGZ2PtCgL
         WVZfkjfUYSvWsH/kdmCTlh+7fZNZqGvvFoaO6h+XajTeq8gwP/lPW+vJWceOgtiC7Tq/
         4ZKAyuWiIJwDNDESnHRfcSJAifivGWjM4U3zQ631/FISXk4t6fSda2as/aieb78tZGNc
         T38gH+6Q7+/820q6xCLP9ztSsmocWip180yQj3lOi41TVHm09glreguSMRKYuXCqy1jo
         pvqZaoUOET3lVPnnjU6PJMtnpZ6WYvdGbRwUthWleDqISY1EPbPYylby6BSSlW/0xB99
         Umtw==
X-Gm-Message-State: AOJu0Ywl1aSl5H0GPQhviLlCGX0OGnBUXh+faYusrRg1TCwr+nMvbKE+
	DOZFvcuU4hu+7X9julrMqzxHtFO5FzJI45LOPmHBAYyAtlNYJTt5S2NlD3QRmrWZ
X-Gm-Gg: AY/fxX5+cR0YE1GWP6vW3EOJHL8zAxLhh4H4GnUYMQW/bdN3EuXweXAyKDxaaONGWLP
	kgiBjftjzbt39E4kc0qn0To7HJocdFB47N+9hu0JPHtONcRTJAEeoCr5loqD/1gePuUgcl5UOwe
	Z1KQYdhKWjIlIYYhozo1REslJsEQ8ADk/E+t61PGPAqlPj/p6imxJU9seXDxmzbfyRLE9XT8VQp
	C5ctpiIA363dzMZxKwiyBa9N8xcRKDppw5/RN958OwZQZNRqSIUhkphKfQI6KdMxRfEYhHHQZ1P
	D4zbYKa1qVjemTQE1dBwf6VCG50g0u8mwD8Yp09JNHPr8L+gAETgbK/A+TGEEAmptCKTlqC3y8E
	K2E7zIsdd9vTtM0R+aWntIbOdm7jUGvlxy1QKGixaPzL+YawGyKUQe4aNTfhzuSIGW52RDccACf
	bWw72xWV4LWkA07t9j0dynBKYMx4vIWD7iXfSodZzlFEZIOSg=
X-Received: by 2002:a05:6000:1acd:b0:431:656:c73a with SMTP id ffacd0b85a97d-4356a07745fmr2036091f8f.31.1768546071538;
        Thu, 15 Jan 2026 22:47:51 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996d02dsm3271413f8f.23.2026.01.15.22.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 22:47:51 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [auh][PATCH 2/2] modules/steps.py: set commit_msg earlier
Date: Fri, 16 Jan 2026 07:47:45 +0100
Message-ID: <20260116064746.3584094-2-alex@linutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116064746.3584094-1-alex@linutronix.de>
References: <20260116064746.3584094-1-alex@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 16 Jan 2026 06:47:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2998

This also ensures that an attempt to commit nothing
if getting the environment failed
will not fail on a missing commit message.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 modules/steps.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules/steps.py b/modules/steps.py
index f7dd5c5..a6ec341 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -32,6 +32,7 @@ from buildhistory import BuildHistory
 
 def load_env(devtool, bb, git, opts, group):
     group['workdir'] = os.path.join(group['base_dir'], group['name'])
+    group['commit_msg'] = _make_commit_msg(group)
     os.mkdir(group['workdir'])
     for pkg_ctx in group['pkgs']:
         pkg_ctx['env'] = bb.env(pkg_ctx['PN'])
@@ -100,7 +101,6 @@ def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx):
 
 
 def devtool_upgrade(devtool, bb, git, opts, group):
-    group['commit_msg'] = _make_commit_msg(group)
     for p in group['pkgs']:
         _devtool_upgrade(devtool, bb, git, opts, p)
 
-- 
2.47.3


