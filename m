Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4395.1794623202383404898
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 18:26:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=zh9D8Xv0;
 spf=pass (domain: gmail.com, ip: 209.85.216.52, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b179528d56so739711a91.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 18:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794623202; x=1795228002; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zGvNl5tSh2qTNQJIYWxKjMdQtk8C5q6+Y8u1bfIvQfs=;
        b=zh9D8Xv01VhriKD0ynbSRnOAs5zIpaoz9oJUB44/aYCa+YuCnGC0XJo9ooYl0mCjKG
         Kdnx7yVCNUHjZcCozuUMxju6SdDjL/DqGMBl33qATfKq6nlYGytMgv36niOhRa/tPyii
         UNQZr/RvFEIVB/WytOWXvLCyst7lBO7Lo7SiV3vxo7dvFfwt9DyO4UvLczGZGUnpvu9A
         3FEKVE25gDQBYLwSs741lUAivv+NKCR2aofQY6WmE3IFi6GCBdAM/jv9u2Q3NwWVH1ww
         V+2QQmlCr6hSV5PnWqtS8G6hoMYkV6o4S/xK9gConL/r9ONBW1LyEpqYWytIKcYMTrdP
         1mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794623202; x=1795228002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGvNl5tSh2qTNQJIYWxKjMdQtk8C5q6+Y8u1bfIvQfs=;
        b=BMJ9WEZSczlCEnz2GgYlL/iaIIjILl7dbbAE9+pigQ925DhhilGs6OkfV9zA7B3krM
         nSWQtMzZQJPznre6RgXJ7lQqlVf6Lj2bADTrvbDMH+7XTRHo6Wbg/ZdsFg7VbnNQUZto
         yS7MXIU818WMe8wIQsk7KpGcyo+HTxuNgHXPt2MD/IhFV+zRz1717+7CIdVwT1xE3BZk
         LI4KWEHtFxWDNTclCXJT4chjYz+FFuvnaLZzNIwLgxIXhjHGUpFUOwTvy4Lm9sfw+c4p
         eM2LXIcuZbUl4QwJfeP0pl/aRPXe3kbpQ+VmpnS+guk2g4BUfiQui3xcipNDLit7Bnxl
         6VGw==
X-Gm-Message-State: APuU4Z+s+kg4CT0zjmdsAwvzxW8d/TYzWi4WaQMPFPj5TzO0xHSxmj1m
	JGWoamx3On2XtCrUxwIavJUQ/kmUZuGcWJGDy9AZey704MSHfvWeV1lymommGjwZ
X-Gm-Gg: AYBFou0gajCWykFOtW5v//Mn8v8QhceJc2pG7eQ6z+lX+wIOd50mr8/NQpi8kSqkRz+
	AOzlKgfMOrIdxW3k/Les7d/u6pMbRFGQZILJWGilZULIFwsl7iFWa8CEl3ggviJrx1yH1L+SWIl
	g3OW1HUv+aS/94ZYpTOCDC8y06cVP/vinH1dBNjJeQLGHhI8z9TdUggMnLiZ/g0Z408zL0eoG88
	LSthbRtakm9xZNmjkVeh1n7MDZF1B+dxjngwYl+XmsPHOv4VE2jZgG2aRQ01W0We5UXI3kA5Ltk
	yzYlbIWdUEnpDSkVSL8Whd1VaSFuJYBJjJsgopQzEjBOBlP3sB1UL7DQ1wNY+mVshTWfZD4i/EC
	y8V6rHJRDzIH3A8nHl7cGjUx7to+Ai4FeWAmgnrUwYzNu4lNtfu2TngOwhpNIh9w4vuGfxywi/L
	ZZVbHfNI/EprPzzx9BsGvEaxjP/Y/q09m+s9CCuCx19BaAj07F9qFRH1Csjqfh2WOdHEiQ78DNM
	Y/o7d7pcwO10P422owDp3aFqDwqs0M/R+1A4xGqqQv3o8R6GelydRw+tHovOUK561yEajo09PLy
	zvqR9vCvz8KlIhy6ERHtrdblaBbNHmg3YGHDW+Vb+wwcudY+TsBVgf9IHTzMPw==
X-Received: by 2002:a17:90a:c106:b0:3ad:a270:a623 with SMTP id 98e67ed59e1d1-3b1b07e9526mr3847097a91.4.1794623201496;
        Fri, 13 Nov 2026 18:26:41 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec622b6sm7433636a91.11.2026.11.13.18.26.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 18:26:40 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/3] Report problems with the first parse of a layer
Date: Fri, 13 Nov 2026 18:26:34 -0800
Message-ID: <20261114022637.60789-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 02:26:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5356
Content-Type: text/plain; charset="utf-8"

These fix three bugs in how update.py reports the first parse of each
layer's conf/layer.conf.

1: Bug 12130: the values from the first parse (BBFILE_COLLECTIONS,
   LAYERVERSION, LAYERDEPENDS, LAYERRECOMMENDS) were printed, so they
   showed on the console and in every layer's update log. update_layer.py
   now writes them to a file that update.py names.
2: Bug 13490: errors that stop a layer being parsed (fetch failed,
   subdirectory or conf/layer.conf missing, no BBFILE_COLLECTIONS,
   LAYERDEPENDS not satisfied) only went to the overall update log. They
   are now also recorded in the layer's own update history.
3: Bug 13489: the page of a layer that was never indexed said indexing
   would happen within a few hours even when its update had failed. It
   now shows a warning with a link to the failed update's log.

On a test instance loaded with a copy of the layers.openembedded.org
database, the last nightly update could not add 22 layers on master
because their LAYERDEPENDS are not satisfied (e.g. meta-homeassistant,
meta-kodi, meta-luneos), with nothing on their pages; 5 of them have
never been indexed. The test suite passes in the Docker image at each
patch (79 passed, 1 skipped at the end).

Tim Orling (3):
  update: don't print the initial layer.conf values
  update: record errors in a layer's first parse against the layer
  templates: warn on the layer page when the first parse failed

 layerindex/update.py             | 61 +++++++++++++++++++++++---------
 layerindex/update_layer.py       | 12 ++++---
 templates/layerindex/detail.html |  8 +++++
 tests/test_first_parse_status.py | 49 +++++++++++++++++++++++++
 tests/test_update.py             | 34 ++++++++++++++++++
 5 files changed, 143 insertions(+), 21 deletions(-)
 create mode 100644 tests/test_first_parse_status.py


base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
-- 
2.56.0

