Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F2AD277C4
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 22:50:56 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.319.1767999046047029755
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 09 Jan 2026 14:50:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=dEjxxmRG;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so33154395e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 14:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1767999044; x=1768603844; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pMu4blm+abKzADr1NI/Lr3lKdkiGfHEZJnxTbQXeN5Q=;
        b=dEjxxmRGxa28zt01YJcfMAECz99VZyXRcol5d2+kqjSNN25a1m+PjAG2zx7EyShwu9
         1eouN42boepcXr1SuTiSsHz2oQMYuy2WgcBa120/emJ+VXdmuo+8X9+QZNIoLSzgU1WB
         AJEzoZYbApfDXWahYZe0GlIWRmdOgVg+t1ef8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767999044; x=1768603844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMu4blm+abKzADr1NI/Lr3lKdkiGfHEZJnxTbQXeN5Q=;
        b=wSTnkW7fAdl4agHWHu3s8U2qTPvy9XbzSKUkuD+OuFZBttWFtViesnYq5s1m8/c74b
         QAzzn1EA3v/LwljHXecwHI28Hab1NFZrY+zbv/TlDZgqV/EbNzfLtiSdnslnQh7WRoCi
         iTtaETvJprlHadjP6PNECH1qCKB6L49feitFnXfYqcMeiwx9MkKFYP72shmZG9ygKWcV
         qhR/GcK7I7RHktBSO0vCsG9qH7OGh04qHi4RZnNCQZaCc3VtNLbklyUP0f0jFkJpAJ4e
         TSW7QyTepxquakpLjMaolt69DQXdquu+rhd08m3p2yYWEuErnM95lG2lyYug4QDSBMUN
         laDg==
X-Gm-Message-State: AOJu0Yw9K4wQhDfpZIuxmut2HTYKrl2dxr76CHJfOzROyVPu4vBnOmsb
	xOEhvmBcuR2zNFppKMxpUNb04ANgtG78cgwOMMUyUQDWuzoMgpoBluD5JPheUs4DNEgzEhj2qgX
	ox5F1
X-Gm-Gg: AY/fxX69Oujx0Lv95v0aBmfp1tAX2JpNRRJkEYUJZuiqMIc/5bENm3co2rAbwHUR0kZ
	8k6ko+eAzby2r3WhpJE13VBHRu12Zd5ujlJ3qBrk+1ZR9xIbojOjo3GI63d7X28wtmlIS0GiHxC
	Ld6z32sLx0XW3v9U1yeTb3u6xkjixVL9xqMmBFsKYEI9URbTC8UsZUuuI/5wUUVfnoaKO1Ez2hC
	Iljz/AZIKPVfDUx86EvbX59BaY/Yo1ueJobnHDWU2J8EUu27KIKNJzkX8zDoOsIYkO7mV2Fdp80
	keFGA60tdTyZ3LdJHxpqScSvuWZJ+K24hB1zlPGe+uLFOW1MAlLL3A7PHsGRzJ17DhkVtEBlbCV
	jdESqakmvutdzwrZ1pAYQUuZh54imTqyTfS7mOkDWO0CNPyusNlB6HwOEgTfK4UY7EPMJfoF3/g
	7X7pCtuiZNiNMeDpy12erexeTm8KscWNpYDkZeRk1bBSJgvGRrc/sYwQthYHBYVqnGKqIQrQF20
	ykEzLcEKtaFRbVj
X-Google-Smtp-Source: AGHT+IEbh9SWJzeci4QpuIO2nWRP+WYRVLVoxQkzKZcfW9cxNrv+9mG2kieUvfs/XafgvO7+BllWWQ==
X-Received: by 2002:a05:600c:3110:b0:47d:3ffa:980e with SMTP id 5b1f17b1804b1-47d84b4101dmr113714095e9.28.1767999044133;
        Fri, 09 Jan 2026 14:50:44 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00e75da6c4f7444a1e.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:e75d:a6c4:f744:4a1e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f418538sm228362095e9.5.2026.01.09.14.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 14:50:43 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC yocto-autobuilder2][PATCH] builders: Merge build request priority support from upstream buildbot
Date: Fri,  9 Jan 2026 23:50:07 +0100
Message-ID: <20260109225006.439787-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 22:50:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2930

From: Yoann Congal <yoann.congal@smile.fr>

We use a custom prioritisation function to assigning build requests to
workers.

Buildbot gained the feature of specifying the priority of a
build in v3.9.0[0] (our custom function predates that so ignore the
field entirely).

Merge the priority support added to the buildbot default sort function
into our custom function (see [0]).

The resulting order should be:
* First priority (higher priority goes first, defaults to 0)
* Then, time (oldest build goes first with bonuses for certain builds)
* Then, builder name (last resort)

With this patch, the priority field of the buildbot UI when starting a
build can be used to specify a less important build that can goes after
normal builds (e.g. set priority to -1 for hunting an AB-INT issue).

[0]: https://github.com/buildbot/buildbot/commit/bf1cd1321067fd92408fe6fc18d00d2edb5f2770

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
RFC:
* I could not test any of this...
* I don't know if that is a real problem to solve. How often the AB
  cluster has pending requests that can't be satisfied for the lack of
  available workers?
---
 builders.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builders.py b/builders.py
index b7379ec..3d55e15 100644
--- a/builders.py
+++ b/builders.py
@@ -244,6 +244,12 @@ def prioritizeBuilders(master, builders):
 
     @defer.inlineCallbacks
     def transform(bldr):
+        # Sort primarily highest priority of build requests
+        priority = yield bldr.get_highest_priority()
+        if priority is None:
+            # for builders that do not have pending buildrequest, we just use large number
+            priority = -math.inf
+        # Break ties using the time of oldest build request (with bonus)
         time = yield bldr.getOldestRequestTime()
         #log.msg("Considering %s" % bldr.name)
         if time is None:
@@ -254,7 +260,7 @@ def prioritizeBuilders(master, builders):
                 time = time - builder_bonuses[bldr.name]
                 #log.msg("Adding %s so %s" % (str(builder_bonuses[bldr.name]), str(time)))
 
-        return (time, bldr)
+        return (-priority, time, bldr)
 
     transformed = yield defer.gatherResults(
         [transform(bldr) for bldr in builders])
@@ -262,13 +268,13 @@ def prioritizeBuilders(master, builders):
     # sort the transformed list synchronously, comparing None to the end of
     # the list
     def transformedKey(a):
-        (date, builder) = a
-        return (date, builder.name)
+        (priority, date, builder) = a
+        return (priority, date, builder.name)
 
     transformed.sort(key=transformedKey)
 
     # and reverse the transform
-    rv = [xf[1] for xf in transformed]
+    rv = [xf[2] for xf in transformed]
     #log.msg("Using %s" % str(rv))
     return rv
 

