Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD67CAC5B8
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 16:29:12 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.400.1758904146344442493
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Sep 2025 09:29:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TAQkrO9S;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so22514485e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758904144; x=1759508944; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q31htkYQKSfkN9vDvPTfGVeDKrLUFxXVPhGE1oLfDkY=;
        b=TAQkrO9Sqt0I/t1pQr0ZB6m8iwnZcv5eZfk1W38wf5TAAx+i1WTMfshbe7B2SRTnLk
         HN353IV1K7QHIaegU3TYPCCHvJGgF9R+PTOBbg9KITHeEW9fsa1X0nPh4P3lgye7bGKD
         5tJ+BPAII7twcmBMxufMcDxfuLTUiT8nu1Xj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904144; x=1759508944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q31htkYQKSfkN9vDvPTfGVeDKrLUFxXVPhGE1oLfDkY=;
        b=LKkdqCUIjY6VNH0Zr/aYQmAgIOg+IuaAVVm6qBz8o7gBlDRAU0E5XlBVXtPwXCC2HS
         ARL2GWn7cLzMdnnqK4pKVyR63tPDNk5B0cIWdXD4p9mb8qFxoR4X3OFwntL42k5nwe+Z
         S0NJzJPX5M29X06CEJ7btnkQ0jRJ2XDv8Or+o0RW6dbhtx2VBgynVSFp9B4URuOLx/Um
         xVdcDyUhLDMTGJeO/YpOfPnPGd7IxbDfwA4zWMWQCuyfNCMU4BKyvmgZaXeY2wzIjBoj
         SRz8CHVzENYbqYZbjlCcVwCYcG16RXZxN3HKKOVjmlE4OFxSmXdbnoRUNIbppRV2TXTh
         D8og==
X-Gm-Message-State: AOJu0YyoMv5olqpu6bSXPLfKvxo0wAa4ZwfduRfpoq7qxfh+kbymZ4q3
	ci0MAi0vBdGb84YYHoIIKpYrzzD2DggLRvufQjlRfWbCDtfdeShFwV+usta9tyZSRONsCTxBH9H
	52Bx3
X-Gm-Gg: ASbGncsgPMVXDf8NCzMLJ6R34BzpliUl9XomKAuNe1tXDSgIC6k7Yd0SXGKSvRHw/3j
	OEKFL5Rwm5HroPYW070fttGxKIObrVDOTs/0vSMfsSzY2Takewv4DouwxiT2fM11+W1HueErtVB
	PilZaUQ+BR20paJPFk5oypIbrRT0RtGrNNvV+eTflJ6UORcLtJGOwLpSrvgrws3AzGYHrllpmGO
	44Abc0JGDSydS7YKnzpPzRsUa7zPGF/J5TzJiRTj+Z3HQ6wb9ySGzZihoHY0GpLGCZXH/3bvfCs
	GTB0/yJTlP/83V9TjEKUMWy4OyI9nTRwcxPoy7QDK3K9h0QI5/+3GbtIS1rLeRjaI5tZG0SzaQo
	hwwOIb6wKd/r1dbun5sB/n5JvE9dN45LNNg428u8eltSSP2JhnLE=
X-Google-Smtp-Source: AGHT+IE9WndHbQjcxoM6PwgxZ8a0sChMssZc1YgdNULLXF4ObwMjd2ou542wu83ykq8Ej7FQmAL7MA==
X-Received: by 2002:a05:600c:1e87:b0:46e:27f7:80ce with SMTP id 5b1f17b1804b1-46e329e51c2mr75756585e9.23.1758904144121;
        Fri, 26 Sep 2025 09:29:04 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8a7a:1fb6:e6df:2fa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e34074983sm78144845e9.10.2025.09.26.09.29.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:29:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] builders.py: Add step to write out build properties in json format
Date: Fri, 26 Sep 2025 17:29:01 +0100
Message-ID: <20250926162901.29045-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 16:29:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2238

Rather than passing all options as command line parameters, write out a
build-properties.json file. Whilst currently unused, we can over time
migrate a lot of options into this file, making the interface with the
helper code easier.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 builders.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builders.py b/builders.py
index 7887945a..bf36c755 100644
--- a/builders.py
+++ b/builders.py
@@ -132,6 +132,8 @@ def create_builder_factory():
         haltOnFailure=True,
         name="Unpack shared repositories"))
 
+    f.addStep(steps.JSONPropertiesDownload(workerdest="build-properties.json"))
+
     f.addStep(steps.SetPropertyFromCommand(
         command=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/getproperties.py %(prop:builddir)s/build"),
         extract_fn=extract_json_props,
@@ -328,6 +330,8 @@ def create_parent_builder_factory(buildername, waitname):
         haltOnFailure=True,
         name="Unpack shared repositories"))
 
+    factory.addStep(steps.JSONPropertiesDownload(workerdest="build-properties.json"))
+
     factory.addStep(steps.SetPropertyFromCommand(
         command=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/getproperties.py %(prop:builddir)s/build"),
         extract_fn=extract_json_props,

