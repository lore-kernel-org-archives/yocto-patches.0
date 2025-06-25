Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADED6C7EE2A
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 20:10:52 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.web11.25835.1750882250836389003
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 13:10:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JOlD6ESp;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d425fc4e5fso30150785a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1750882249; x=1751487049; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Yu9pj+MtCxzja40PWHUdCcFgxSM9C7XMK/cG1kn6T4=;
        b=JOlD6ESp7xc2oAVjn5kwAMbTpNaj4yPJm6GOLeSXc+O7sBXPIF6eKhtJXdiksBMww8
         IDbKXWEB3IFjyyEI5I8PqmDOznR4Ss8RZ5SW+EesPqQoRFKDqsoTaryMOoEqtRJtPZn4
         1WpgDfsKfUNqCOvD2+KxVce8ytjxbolBkHxQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750882249; x=1751487049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Yu9pj+MtCxzja40PWHUdCcFgxSM9C7XMK/cG1kn6T4=;
        b=ZOi+qDavUMU5x9SDW9JCRQ17ynvrl9ckRVVN2o/CTdEPMKcdqdUVb0crMeFo5eEf3n
         hCTmD4e72u9hx7S0WfjrElnl23kzsbSb7yixhELyRzsyKcVsxPilMjblUAnB0QWvhWEN
         TEtOMuota2KX/M0Y+iTWEocywZALcQFrtdGqYzWbCMqaaoLmqkzLWi/4UaI1GnHB80o5
         IEX53ulMghnK+glSJVIl6f130QWmTmluXJYqO9c2iPTweHh/PJsdst1PCB41Cr6P1Ffb
         qUpgIXj7NkVMf55fH8WO+8QyzMn8a/0+90HQDmK6ElP3Qn9d2y6QmQzO4s3L+vj1yP9y
         nYCQ==
X-Gm-Message-State: AOJu0Yxl96O4Bch4xOZ5Bs1PLZ+h7WuTlAg0NsO0DpIb+dJo+eR70qVW
	8gAvSqe9Iipq8QOnMddGNGwNE9hFRPaOZRfB9KqfZrXXX3uarKAeJtc6HuOgelra4hUGDNsaZCj
	biXGJ
X-Gm-Gg: ASbGncv9tAo6FZ/wG5JgzAVNp0BeMuCaAJTvKn5prG7iwEuVk+suCUQo78KA7XEnOwQ
	SccL23QfSH214SnER/RyPbLSwYCTz20MEbw2oUuXZBXG8nZ+uZg8rlJFP5/BZmKjLv6l2bUcy1G
	QIMoFr+TZKUDD413R2nEbB0BmjDiqyY/o+CCM39cpSXwtNKWWc+DI8YOI8b8kHkfKC18DH0kyso
	KmrV+i+nhGb+Jg0Jibz91l5jBxxyY2hCXct6cMNpoCbZpGNcyOc+U4KUhH80dtaY2oRwGSWP0Kb
	WcEeynjxk38iRuVkZuvkmQtfaJ3GO65RU94+nPUK36Usxk4W4PcokhOo8qofa/BPmzmYWZ+RMND
	do/evybxaOQH/7eswXWn02LmRosaJm7hvubmhXQ==
X-Google-Smtp-Source: AGHT+IFncVlmGG7UFDK4xsbEy5U82y84xcdsgG1q+0L/0HifkBt3vTH2LLrw6AFEwBkJE+8r0snklA==
X-Received: by 2002:a05:620a:6087:b0:7d3:8cc5:8a45 with SMTP id af79cd13be357-7d429753d16mr611717085a.53.1750882249265;
        Wed, 25 Jun 2025 13:10:49 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093e0578sm72299646d6.10.2025.06.25.13.10.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:10:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH 1/2] Set compatible layers to whinlatter
Date: Wed, 25 Jun 2025 16:10:33 -0400
Message-ID: <c30a97d9cbacb24861d42f8bca6509dada2a9adf.1750882005.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750882005.git.scott.murray@konsulko.com>
References: <cover.1750882005.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 20:10:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1693

whinlatter is the next release, set it as compatible layer since
it is not backwards compatible.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index b0dc48b..6ec4380 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,7 +17,7 @@ BBFILE_PRIORITY_selinux = "5"
 # cause compatibility issues with other layers
 LAYERVERSION_selinux = "1"
 
-LAYERSERIES_COMPAT_selinux = "walnascar styhead"
+LAYERSERIES_COMPAT_selinux = "whinlatter"
 
 LAYERDEPENDS_selinux = " \
     core \
-- 
2.49.0


