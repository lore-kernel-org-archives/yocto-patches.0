Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC37CCF2D3
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 11:19:32 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32128.1792408764454574263
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 04:19:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=OIYqlt/E;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1dec056ddso10680515e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 04:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792408763; x=1793013563; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GfUh64d7pVC0NXmE5xUp4fS8BjbWFZ4ADTgJ9wxCl8Q=;
        b=OIYqlt/EUzM4L3TZhOQh/1tCADd8YbnqACcJrY7qWlB3LXrm1PEKfjjCXxfwncZP7+
         OTZuYi9G6DnIsbpBCpUtFGt+68Z8VsHyxWfdN6KLbubsvWK81P4oeIE4BcL8DNfhMCzK
         J2FQU654lfYNRstoWw/4jVObw5j9po9NrH/i6DjGpV1N0FhZ8uoh4Kn/CxxMJtkRC11q
         foZmu9+bg6vZ9pDz050QQvaUdC1/tM/L3LsoIFUzRVbqijBa4s66BaIDpvNIfFikMbit
         cYze1opRC4niztAl6ws+IaL7sjI7Y5in8rHOBfza0fSAvug93CxJRQZzjO2d1F/u1P25
         9uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408763; x=1793013563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GfUh64d7pVC0NXmE5xUp4fS8BjbWFZ4ADTgJ9wxCl8Q=;
        b=Y/nUGI3FFQ0qGVWDO+l5Bz57j+nsIHeBHffwC201CKVSe3BQkppQeNiNBj286H+t6D
         /YioWDOptbI8VrAiKao4YyQ3UVoMDcp+YELooQWWK9QZs24Iyqj1Uywo/9aUsG3744jz
         sNub0v8b7TgvenFbdFhI7opCCrZCogds1juk7uYFO+kMFbdCH8h58AFE8giIvG/eUgqi
         Uyv4a3w0KY8g7P8iu3ia2CHgN7N5Qo2g5GBqP1uy4ajX366tKBlYsEv80W6y//t3DHee
         D+hVrJN3mugPa+ej6qyjnisk/Lc7pJz0ekiTYw6gDGOUg1CM15DgePyu+PCgnW4o/ZV+
         pcgw==
X-Gm-Message-State: AFq9FYJAEcL38T2zNKVRjJRo/CnHZ1oa2cB1jTCqmHsxNcApjRkeTX6b
	QGLtzNUs1yoXXDyc4HMISFhbwimGbJTu6FzTW5pyVu4Wcf/tRXC4NxJd
X-Gm-Gg: AYBFou0Sv2P16ft9OCgc3H0D7ggaeAhXSgz7DB6D+bPzhS82BWce3ZJZ/F8OptU6ska
	E5szURjGjcyqxluhjpujgmDhR+rGhdT/+DF/ls1xLhz+GUvwm1JLBZDnVJQR4SwQliKu+cU+6II
	IDQGm0HSKq0jQe/l3YT8DeUZ1PpX6WxWfu/4y3XnMjfOEUIJhAle/ydUIthSoN8NxLRn2JOsllV
	t40Ny94MQeEfUc0xBIkCbR0b4ECt1yikkhSf20Bn84edZpJdEpU/ri0nmCB2pHBDepZ0eyvJAbi
	iFaSdUi4TFVOhZEYv5A349kxQifqBIUspLNmdsDbBPx49ZYr3nweCmgmT8Ax6URm13YSGQg3t9d
	5KQGbwS/7CR0qnt6i93LVLxxP3mYZi+Ejr4EULJtCjzAs0qL5gSecN6Hk1eWnOa0YlhgIbpgwN6
	gm6pRgAVIaJuVf/kO6rgxrvJDx9JIy+Zw8k+UJpRwwiT15Tv1wkoglyJRuyPLUpwKgb5Txgc+83
	T4jO7MYc6bFTkGJ
X-Received: by 2002:a05:600c:3e05:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a1d763625emr151444445e9.29.1792408762343;
        Mon, 19 Oct 2026 04:19:22 -0700 (PDT)
Received: from ERL0724PF3HPJ22.. ([2a01:599:a23:f6bd:6dd:608f:ba62:dd8f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dda881f0sm161088075e9.15.2026.10.19.04.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:19:21 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: yi.zhao@windriver.com
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-selinux][master][PATCH] package-labeling: Add postinst command for labeling
Date: Mon, 19 Oct 2026 13:19:11 +0200
Message-ID: <20261019111911.812811-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807133732.424852-1-yannik.tannhaeuser@gmail.com>
References: <20260807133732.424852-1-yannik.tannhaeuser@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 11:19:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5094

Hi Yi Zhao,
 
please let me know if you have any suggestions for improving the commit.
 
Thanks,
Yannik

