Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FC4CD3427
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:00:33 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4500.1778205627272899308
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YKCvf2ya;
 spf=pass (domain: konsulko.com, ip: 209.85.214.173, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b458ca2296so9671435ad.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205626; x=1778810426; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yT0PcVCrRs0Z8wTNqQnZ5BjlXQBMVePVGfQwa8KgeBQ=;
        b=YKCvf2yaWUNPI4Wg/fg71bXJrt6Rls27SAMvoTYbhAAW+X/8e0+V8frrLp3CYg+dR6
         dyFGcbVH8KCY5ltoRk6uJ3J89UoySozFWxTVpX05HdsZVD9IQ1tq1U/16bNtyofuPEFz
         jR60ybVGQw3QSbF2DUl/1FHJXe13h9xICV7oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205626; x=1778810426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yT0PcVCrRs0Z8wTNqQnZ5BjlXQBMVePVGfQwa8KgeBQ=;
        b=ELiENNyhxNVKxik8UfzMNu7b493JABlzl5fM+Fp7kpMuERuYZLD0uVOB6r2vSXJXrs
         K3iWj15X6a2jT5jgLu37Mc+38VOALuzTCMktNE+pV8skxG99mLbiHXnS4QLJyqhcXjTC
         kt6VNVqQ68RU0S8GD9tXS3YUYjCkA0JmxNP0Cg8eDPE+6UUtomQd/XZj0cOzy1gYJaI9
         DrDqDc1DgYQKoatR1T/5fGIf4bj2XM28Q5ucAmzdFUK2/PebDWNo/Rep/SRaOQC/rZmv
         1sTcdP83j4+p8oJJVzdJVTLy4iG3ppiZu9JE9eIF+TsNdY2ye+MUPfOp9fc4ieWE9rxK
         bSVw==
X-Gm-Message-State: AOJu0YwpicC2IVivAh35QLNd6nL35AnhZVpOAObcOLxk+erbkp6HhDon
	xin++kGCrfViaez05YZ2qRtu5ZqLSh3GAVQCQ13fcjb8BKV133dySp2rbBoGx1A4RQPoFntVH3W
	HA29N
X-Gm-Gg: Acq92OEUYPRtpAt7XfYd+cgEHSYFxN0QRE4skIBVebJwR05xaQN/CLPlI2/Oa8jmML/
	OhhUwTVJs+39rM4EGvOJ2YlwIvT3M0emqbNsw/O+7r1DoSAzZsc04/OPc5mFhJW4P/JQ6cth14s
	nzmDfOj/l12JYlkOZFVNuWQBR6Hxggy8kS5b7WXp5Msbd80EZ7zIX/ixnF+G2UfE52xESbJWvL1
	uPdQb9qn++6+2/XVCN08lcUtJr7hidFjnlV7xtzGm6QVQNwDc8c1bPBiGc5z6ef8PU34yL0c58h
	WUKjUpdIsAI8arITT/prWXfvX2SicV6yx3aqZ9AIKkVCYSXxAM2VsAEz69LaVWdNv/XjdJQ4nbg
	TYdr9HbGaHP+MRnoQl/tpoz5JKbH6w52ufSzgSykyOfLVfs7OvDLSmo/0ZlbeueMwMtK9TL/1xK
	Ns/qHPK7YrFgJyWujkJph/aSGjY9AGj56XVo4im7AZgcKLXDh1UDn6GY/JbKHM5Ev4HMhwcYyO+
	A==
X-Received: by 2002:a17:903:28c:b0:2b2:45b7:306e with SMTP id d9443c01a7336-2baf0cf2c98mr7059545ad.3.1778205625199;
        Thu, 07 May 2026 19:00:25 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ebesm1681935ad.43.2026.05.07.19.00.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:24 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH 4/4] schedulers,builders: add push_containers property
Date: Thu,  7 May 2026 19:00:06 -0700
Message-ID: <9ed602f7dfbc72d96966167a1114dd23aa8b3ca6.1778202070.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202070.git.tim.orling@konsulko.com>
References: <cover.1778202070.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:00:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3938

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
index 721adc5..6bbf134 100644
--- a/builders.py
+++ b/builders.py
@@ -47,6 +47,7 @@ def ensure_props_set(props):
         "is_release": props.getProperty("is_release", False),
         "buildappsrcrev": props.getProperty("buildappsrcrev", ""),
         "deploy_artefacts": props.getProperty("deploy_artefacts", False),
+        "push_containers": props.getProperty("push_containers", False),
         "publish_destination": props.getProperty("publish_destination", "")
     }
 
@@ -379,6 +380,7 @@ def create_parent_builder_factory(buildername, waitname):
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


