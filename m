Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32335CAC598
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 11:38:25 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.17175.1758022704121684497
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Sep 2025 04:38:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OBuho9Fc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso39378735e9.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Sep 2025 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758022702; x=1758627502; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+eJT8onKZdozPug5E3bVuy1uzFN91gb2Lo7PzarnAuI=;
        b=OBuho9FcPtYjPnYhsPj0dLyT8UxvJ8eE2ZHQJNZOcPGQjTP7DIy5HPf+3PkaoOZF1w
         2LL/nNDZPZPXsR0SM1xOtK0BEAn42LLUm858rCRHt2Mz6FVWNKRFooAnVk2xGyUQxGQz
         NeK2qaDp257NJF29h0inBUx+yEaXlm54Jg+AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758022702; x=1758627502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eJT8onKZdozPug5E3bVuy1uzFN91gb2Lo7PzarnAuI=;
        b=IpLq8E2txCqKmRPiY9kljigRcfJXIcUcdZKKBAyW79jQhao8knPKQ/5JO4GKo1UoSr
         H28leRJPnHWJVrJNM9lM24aRGs5ppYpHO6CNyUmSTRlMD7O6+RRyu17R6dZPBgLkiUgc
         JEm4mSsscT8A7mrBHA83GmMjblTi3/dX1/u+DbiKofUkmMKXHlgkFLIeV2jCkzULwEAJ
         4WZr6IUEsZ6r32MJYJQEwpCyR980MYvoN66jg7CcoblhURPspm22Zvuf93aIm7joON61
         SILt9v0V4T58WFdYbp6Iywk1cpLuhBM7+0wIxAwtVN6x+BtQ2cfv3liiRZANK64wSuKb
         qa4Q==
X-Gm-Message-State: AOJu0YwHFsBsAm9mT07GwJyh3aB9iLDrPj2bn7I/tUGzzRTGy97VGSMv
	tzR1/XZTk15zhVJGORAoa/hVDk9UE2rDTpxPrRi2Dml7CN4iMsIK3QUbquaXqNnGXqZCLvB+BlQ
	KIPed
X-Gm-Gg: ASbGncvBGIst4POQZmpqpAabdU1i2qcO3q/E2OnKC+6KJI8uWiyF5C+xzcVeBLcKeAR
	+9bpN8evZ7SIqGkKKXooYtoPSAJ+QqXkV1cbBsspMxcA9OrMGP8C5OifLVUk8pNHpmLCIFNTiWD
	PwBcJndLPONLrxmLPoxBWZcDmXvf6nBaXsl0zYv+xtZWPOjnSJAudJ+a+x8EK+MBw5beD1iBA5p
	qMyVDTAtGe1hFUmJDjzhIxRshZWFK9S0l50AqUBUFCwGeyLWKmwMNh4kkthlwPB6luEmcQyhwKl
	kOql8O2wBjXmIOYQa5sZcMx0WLY+lgaF/HMWq+/T171L2BPbGuDN6KkqKredkMKwb88VCg7KLl0
	3ptOmxLtdPe2yT8BwSwxwWOa1ngCyZZYJVToJtHG+yn52rqVJ0IkjRJwxXz/B
X-Google-Smtp-Source: AGHT+IGfx4ZxBcpe8NEHfmCSghDIybXsOJLLGltYWB+MjP+7Em2/UinU8eXZ8u0F015qXg/84GuJng==
X-Received: by 2002:a05:600c:198f:b0:45d:db2a:ce37 with SMTP id 5b1f17b1804b1-45f24df556fmr131174545e9.0.1758022701806;
        Tue, 16 Sep 2025 04:38:21 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1187:545d:1fb:9346])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2978ad91sm139962835e9.6.2025.09.16.04.38.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:38:21 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] master.cfg: Update imp -> importlib
Date: Tue, 16 Sep 2025 12:38:20 +0100
Message-ID: <20250916113820.1786469-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Sep 2025 11:38:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2201

imp was deprecated in python 3.4, update to importlib.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 master.cfg | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/master.cfg b/master.cfg
index ba4aed70..63119caf 100644
--- a/master.cfg
+++ b/master.cfg
@@ -2,7 +2,7 @@
 # ex: set filetype=python:
 
 import os
-import imp
+import importlib
 import pkg_resources
 
 from buildbot.plugins import *
@@ -47,12 +47,12 @@ for entry in pkg_resources.iter_entry_points('buildbot.www'):
 # configuration without having to restart buildbot.
 # Note: code modules (in lib/, steps/ and reporters/) are not reloaded with a
 # buildbot sighup
-imp.reload(config)
-imp.reload(builders)
-imp.reload(schedulers)
-imp.reload(workers)
-imp.reload(services)
-imp.reload(www)
+importlib.reload(config)
+importlib.reload(builders)
+importlib.reload(schedulers)
+importlib.reload(workers)
+importlib.reload(services)
+importlib.reload(www)
 
 c = BuildmasterConfig = {}
 

