Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA48CD6E57
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:17:59 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12696.1780355874855200281
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:17:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Uat0VKVX;
 spf=pass (domain: konsulko.com, ip: 209.85.216.42, mailfrom: tim.orling@konsulko.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so2988043a91.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355874; x=1780960674; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnR095G6NdPkBQZdSQXzwnTFuulFObkn4wcVB/nkNq8=;
        b=Uat0VKVXLyNUd8+5FZ5cW3nb7DLL6lFFA022EpwU1MwpOfj9Mdoi8Jz9Stbj7mGA8t
         0ueh1+d/FnrWEyGAmbgIIC5k3dU6FaXXbNQlAg4gSrPIdUe1emtG9dv0eSQmyNGphJCB
         /X02IZz07wT3BT4gt9JPkXhbv2E1/bBpWhlVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355874; x=1780960674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EnR095G6NdPkBQZdSQXzwnTFuulFObkn4wcVB/nkNq8=;
        b=ZzWzQ6yGeeTzazCDSfuCMUIPX4YjXeSCj54AKTXgehVRenEEUTiYn3/sfPdjAN/hqa
         92D7sHDiJ59Au42VlgIW+gWggvHxwF1ftM6j+vf0VVhQIaEUtOBB0KHU8J+xowfj2eul
         2pSTB51lK5pzeDDdHCC2HSe/SF8ONmKzJysD1PdmdcbQjOyJIvgeOyVc+HmR/c984Yzj
         UyeVlyNBau6MpktOpmn4GC7kkAg8lJkBm/ekfXAkpp8yLcFMbFMEtopjLvXKvXPuYXOB
         ZsiUFUeS8JxGaIBCXhpYa7h4s1Kg6qD9haReTAB1DT7IR1aA5ymov4A1p9hqSgkrg/98
         CXCg==
X-Gm-Message-State: AOJu0YyNMielo9Plt5nNM+LTB2QM9d0y1xM2GJq5+STw3ziZ79bJUzvO
	w9cG4I4XyA0ch86OmMS/JBsdcUx3dkzdYz4KJuLJHEyjUNwMINSujOobJzHXe3zkfoiC7VrSuun
	z1JVh
X-Gm-Gg: Acq92OFUgM+K8Gon8pB1UjwOVkfM3pYkJ32w+Cs+wgPPPMyFN2LjRS8pYmzbE7lMB9u
	Riv0Wbm5c193EJiS+eNPpXzNVNsdqPZ16aruTMmFz7r+IRbgzcNOP4krcjs0pCePEzxMkSK/Kl/
	3GhOFp9eLiqYNd0s4mE/GyOztd7/4dqUkzFLswtyfUl3Ocg/s0P5PK1drc7L2cb00BD8HOe+k6i
	CzJwUMNKlNY5aodDtfj42ADlHtzXNPLQTKCAW+iQMetEn41tj6BAfk644f0wZ9XYbrCL08YP3oA
	NcHU86gFAkf+MWuoXzMyGOpoJdrCk2WN7dQjgTJle0Ef67fDuyguObEHUh36V+NBpTJ6fdEsetx
	W1WJ0YQlbawdUvBXnVffpcfjsagd0y9t3W/Lte/mRde0NyTVA1xgKXKmcx72P9dDnJKlj7aA7ac
	m3Pkw8iUxjcFkp78twkRHzWPJJHJd0ETS2YgoY9uDNgbHeKcpNl8UawcF9XlfOfVWTJE+3HcG+J
	Q==
X-Received: by 2002:a17:90b:2686:b0:369:e217:d110 with SMTP id 98e67ed59e1d1-36c684a9270mr12730794a91.27.1780355874306;
        Mon, 01 Jun 2026 16:17:54 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd97521ebsm683563a91.9.2026.06.01.16.17.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:17:53 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v2 4/4] schedulers,builders: add push_containers property
Date: Mon,  1 Jun 2026 16:17:29 -0700
Message-ID: <d56d939f7c17488ad09889c92cd21298defc4f0d.1780354388.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354388.git.tim.orling@konsulko.com>
References: <cover.1780354388.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:17:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4096

From: Tim Orling <tim.orling@konsulko.com>

Add a Boolean property to gate whether we push built containers.

Both schedulers and builders need to be aware of the property: the
scheduler propagates it on triggered builds, and the builder needs
to consume it so per-step push behaviour is controlled by the same
flag.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 builders.py   | 2 ++
 schedulers.py | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/builders.py b/builders.py
index 40873a7..55f0769 100644
--- a/builders.py
+++ b/builders.py
@@ -47,6 +47,7 @@ def ensure_props_set(props):
         "is_release": props.getProperty("is_release", False),
         "buildappsrcrev": props.getProperty("buildappsrcrev", ""),
         "deploy_artefacts": props.getProperty("deploy_artefacts", False),
+        "push_containers": props.getProperty("push_containers", False),
         "publish_destination": props.getProperty("publish_destination", "")
     }
 
@@ -380,6 +381,7 @@ def create_parent_builder_factory(buildername, waitname):
             "build_type": util.Property("build_type"),
             "buildappsrcrev": "",
             "deploy_artefacts": util.Property("deploy_artefacts"),
+            "push_containers": util.Property("push_containers"),
             "publish_destination": util.Property("publish_destination"),
             "yocto_number": util.Property("yocto_number"),
             "milestone_number": util.Property("milestone_number"),
diff --git a/schedulers.py b/schedulers.py
index 67fdd39..62d94d7 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -484,6 +484,11 @@ def props_for_builder(builder):
         label="Do we want to deploy artefacts?",
         default=False
     ))
+    props.append(util.BooleanParameter(
+        name="push_containers",
+        label="Do we want to push built containers?",
+        default=False
+    ))
     props = props + repos_for_builder(builder)
     worker_list = config.builder_to_workers.get(builder, config.builder_to_workers['default'])
     props.append(util.ChoiceStringParameter(name="worker",
@@ -595,6 +600,10 @@ def parent_scheduler(target):
         util.BooleanParameter(
             name="deploy_artefacts",
             label="Do we want to save build output? ",
+            default=False),
+        util.BooleanParameter(
+            name="push_containers",
+            label="Do we want to push built containers? ",
             default=False)
     ]+repos_for_builder(target))
 
-- 
2.43.0


