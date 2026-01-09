Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFFED1D48A
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 21:49:52 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21108.1767995382543835529
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 09 Jan 2026 13:49:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=GuWyQtun;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47a8195e515so33985805e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 13:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1767995381; x=1768600181; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DS3Azr4K6uzjn73nivvQI5U02+Y4nOonvXc3114C89g=;
        b=GuWyQtunQitcpN562Em/rfmu2wiGucWoE+IHn3KX7WSqV71Hya/Hk6LVCFSyMJKAPh
         /LknCGvkAtHw6ipWsaUqk5F5qmQAOG3Gs7tLqCKbXRvI/AG4KC5W0ilYdOeViHYVDHen
         EIzSU+OBxbDCvBsw/e6enhCwj8QHwMx1ySupg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767995381; x=1768600181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DS3Azr4K6uzjn73nivvQI5U02+Y4nOonvXc3114C89g=;
        b=EIQ1NuCe1eZlf/s26K3D77V/eklig5Gc7NoxKrJt35YZtU6SO2mrkTY8qdpMzaJ8Jc
         xdNY3XHMrp1uD3EIOuZAT9tX58KPdLNa/OhVrAXU8BcUmf5B8f/9EJXaya+o4pyonFj+
         O7mk2zaLJypXti3IxRnPIbNlljEaX8c1IWliIXyMaMDfd1ZTuxIQxoGYIiIist9xOUhB
         Y/9sknbyI75uwK12DlFHaux7HcO56Q0gSug6/cVUx7Y96RSdF3DOQ+IZ7kkHEWq2bwHB
         pNQ6HrK6B2tMb3ZnnXk7ea0Q0C6sqGP2xtemILhsAGpb8N1NI+/krsJfUFvAyR1kW/+u
         ZIhw==
X-Gm-Message-State: AOJu0Yx+eaBI2NyUVghB/yvJ6lQRRsU//qdNHI8vv/IFKb1lNYtHuUZG
	RAOeGDEFLrj7O2qVF34QXEGamboAPyeBoim/L/ySfojA/qnKkfJhI6Ms6QgYPxXvWLfwC3dug8Q
	YpW61
X-Gm-Gg: AY/fxX7bE+ESXzcT+gRjPRTVLDqWtnfAxfIzZY48R95/ZHaP5l2iOqL9nOPp3syWpIe
	mBHwVbTg+yssKnaq8nwBWa3v3pLbCHJYqgVwUh/loEUKbfqEzCPoPuIkSJAWFTjkkyPFv0/rqRs
	c3v6OA05jsEnxTCW0RR0Fy2x1jdlL2oPsDSjrx/XPnIgqZQQcnNYtQDO1iZmW89S67XhJZ1C/0n
	OyYmXWYaX7oTULl3jRj/9E6plpNZcQL+Il9YxpMDfpB7EhL84/anHXlt0cq559Oo2SNJuaPYb0W
	L9bFuyUe2xf+6Gw0IA7dqyletqcw5PyqXPMK4hV2Zb91+G3I6VGy/HqXoqltmAch5fo1FNcsldX
	KwCjZj/VK8jGrbCq9aK5VZj1gYjod7AIXxDvxNoath82R4IC6kkCFP+4JTFxpEx9S9WMfV1oYlv
	zVUC8yiLNtBp8TP28Ax8nXEYI7Ou+aXVpTmyhB/4KQhtlQbe3/p7bhUy4wkcmoujyq0y1/2Y7he
	C0nDJbNZOStbwrRHT03h+f2+Hw=
X-Google-Smtp-Source: AGHT+IHVomKJqYhlrCnG0Uv4K5GDT+1EuwvNv6rHaL1iylfAPcU8+uZxZ+hLvGOLa7OSJ10OksXSuw==
X-Received: by 2002:a05:600c:3e8e:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-47d84b1820amr117091965e9.13.1767995380802;
        Fri, 09 Jan 2026 13:49:40 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00e75da6c4f7444a1e.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:e75d:a6c4:f744:4a1e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717d9e7sm69014735e9.8.2026.01.09.13.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:49:40 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH 2/2] schedulers: Remove dead code
Date: Fri,  9 Jan 2026 22:49:23 +0100
Message-ID: <20260109214923.435527-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109214923.435527-1-yoann.congal@smile.fr>
References: <20260109214923.435527-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 21:49:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2929

From: Yoann Congal <yoann.congal@smile.fr>

The removed line does not look like it does anything.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index 85e0be4..0fa6d2d 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -407,7 +407,6 @@ def parent_default_props(buildername, branchname=None):
             props[branchkey] = branchdefaults[branchname][branchkey]
         else:
             props[branchkey] = config.repos[repo][1]
-        config.repos[repo][1]
         props["commit_{}".format(repo)] = "HEAD"
     return props
 

