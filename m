Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BDBCA0EE8
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 11:21:42 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.20238.1758108101458323503
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 04:21:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XtrlvsOi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so44801985e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758108099; x=1758712899; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U3R2Ftr60i70xA8+yOsoBqb2/mpOvKb3iqO+7L7kidM=;
        b=XtrlvsOi/8YVKDO6CWDt4Q4vxjV3/uvOOs7KJVTS5h80poeheZj3ACaSsOOX6x/55g
         i+7B5oBNqQDgXF0CfEAH9t6Zp+Ujse3VByF3sVIGeFvLChQJ6phbAI/3h58Izpi4cxLB
         5DrrRSLFK7l8EiR0KqQfKpWYQp8rjXdStGZDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758108099; x=1758712899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3R2Ftr60i70xA8+yOsoBqb2/mpOvKb3iqO+7L7kidM=;
        b=wKg9jvCdSsuK5n/XILNF9pgrX92MO4/VRcnWGWLdG3wVjVmK9i4L6ZcqL/n5wZgFAd
         AkOvInkLaVCRB5jtpwX+OKbd8G+HtgKkzCz2ywh0H2v1gDhFUT2dUSw5rGIufFmlIBgG
         vRTbQDxRhSp+ULqM17cfi/GcDX8QDntYpu6q3Bqs0r1g4pjnLM1zW4Sx5MRVgevg03DI
         +mT7pdqNxADrvRYcqTEvCWFjMsJz6DbfzMtov6g0Do+o1M5htVYhbhI4S6jM+kRDZV9q
         T0mgY8mcIcW+lm3HZpHmUzOFoaJhJpPAdcNHarAgnpWtapMOY7QFYOWCnxIKHBzUDxNW
         MCIg==
X-Gm-Message-State: AOJu0Yzcl+GIB2ZloyXPYeSYZ6umr1+gy2nXUt1MxYmFc0XSKZxpBi/m
	/Vuatlmu4rkG8/GIEyw9JLiezHeam6qqWYaQN5i918KZfXcMknsRMYHnAlcAHd7mRXMcYl+cKAc
	9LSAD
X-Gm-Gg: ASbGncsIwkcaKY69zblTNSL1zS6c/3ioRUifZKhhr24uDq871zD9/kauuSN98+eWoiX
	ayTItlI0Iuvt4ZLxrbVipgTO+xXURw4ZkIn8sh/RLhxwggxsyLvhDcyUsJMYQtIVOVIpgH6Lo5H
	KDXE6SflpaQouptM8Lx1RE/Il5Qwk/K40zcM9k+FIHlSQKZxQQ5MJckdRIOp3pTfY5MEmmj4rs3
	1Mh+J9/RCwtBFqq16z8mJ7i/S1E73HgRcAJpfrmPOiM4fCgDaKVEj4w8h8c907MQp9JUuR7jFj5
	qLsl/1MIhqZe4N4hQnNrzdyWxW06pPI3NMuXNfcKqsNWO5JHyAad9A2j/nvjCsFj0sWVh5/yfrc
	9h1kD+3mrQLkfgVFABmGj7lMB4ERQVmbvgUyNDsTBh0WiaP5SYds=
X-Google-Smtp-Source: AGHT+IFY4kg29n9zT1xB4qg3NxkD4UDhef87g/Zw4whauWGSpbbRvkoIrkMwDPeXxGj9V8if9ED5zA==
X-Received: by 2002:a05:600c:1f13:b0:456:1560:7c5f with SMTP id 5b1f17b1804b1-46202a0e7bemr16521515e9.14.1758108099070;
        Wed, 17 Sep 2025 04:21:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a42a:bde0:2db0:730d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613930bdd8sm33314165e9.19.2025.09.17.04.21.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 04:21:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] builders: Remove confusing newlines from log messages
Date: Wed, 17 Sep 2025 12:21:37 +0100
Message-ID: <20250917112137.1884344-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 11:21:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2205

The log messages contained newlines which made the logs hard to read. Tweak the
code to avoid this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 builders.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builders.py b/builders.py
index e4763d53..d26b7e9d 100644
--- a/builders.py
+++ b/builders.py
@@ -79,12 +79,13 @@ def canStartBuild(builder, wfb, request):
         threshold = threshold * 1024 *1024 * 1024
 
         cmd = yield shell("findmnt -T %s --df -n --bytes | awk '{print $5}'" % mountpoint, wfb.worker, builder)
-        if int(cmd.stdout) < threshold:
-            log.msg("Detected {0} GB of space available on {1}, less than threshold of {2} GB. Can't start build".format(cmd.stdout, name, threshold))
+        space = int(cmd.stdout.strip())
+        if space < threshold:
+            log.msg("Detected {0} GB of space available on {1}, less than threshold of {2} GB. Can't start build".format(space, name, threshold))
             wfb.worker.quarantine_timeout = 10 * 60
             wfb.worker.putInQuarantine()
             return False
-        log.msg("Detected {0} GB of space available for {1}, more than threshold of {2} GB".format(cmd.stdout, name, threshold))
+        log.msg("Detected {0} GB of space available for {1}, more than threshold of {2} GB".format(space, name, threshold))
 
     log.msg("OK to build")
     if wfb.worker.isPaused():

