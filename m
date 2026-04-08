Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89D41073C8E
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 10:33:33 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.103199.1775644408717753333
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Apr 2026 03:33:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=SVaw6PB7;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488afb0427eso35055545e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 Apr 2026 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775644407; x=1776249207; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xo3DdK8QnsiWJbk0Les6Rx7Co+bfl9H3YA8jYS+p9ik=;
        b=SVaw6PB79qQIv+psUer1g+2aj9l/CADVD/cvfraHGWA5WJ9ljFMqmqpgNkSb02cRkv
         GMEhJohUlJF5b3eul04yhtC/8EKlFJ6r3/y+YjN7zrKr9/dR3SmPPA2PmqnYHAfP/S+n
         hwdpJgErf5JBoyzlMhOj7ZacDxDw+i6kFRl3t1ZtsQHdXErhbFhUnruseYazpwXX3kpF
         Ip/lEDB5axjXnj4FJXG/BhyPj6mxiqkCe/uICnTb85Cno4ZMGkZYOt6ou4dUppghhoxO
         jFWu7aM7sfR7YZkpzuKIe44AoU9wyj5w22b3zfUHhNgVg4F4oa6CBWhDwcYlIiMV6eqV
         2XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775644407; x=1776249207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo3DdK8QnsiWJbk0Les6Rx7Co+bfl9H3YA8jYS+p9ik=;
        b=LbmPyKNlVdULGPJXkMXpUHS9BOXA9JlW239xlrimfg/w9DixC2lpHRFjA1A9+c9jda
         T+JoSSj9WTGuKwqMCv8geVTI00md1jSf03s9em9gyfNmzL+/0+P0r2yh2UiNCmOjTbTV
         7UQgBEUXnuuHaSvd0WrDlHUfbXOwwBCabJC1fX7KqWQMPw38CoMlOjL19issj1z0OGI+
         3pTaX1SWOFNZ28N51WkC/U8thzF3Ipno4GOYbtwiksgiLU2eJ9F+r0Y3x1wBpX33aoK4
         rlqG1Z+0WInv4xZDSSI905mKdzT1VOszpwoOGMEuDlT7LQka4QSpALdAchYGbSjKKsDn
         xLUQ==
X-Gm-Message-State: AOJu0YwUox3yfp3PdULoN5H0vSuMSduf/FfyNysPi/NMWSWP2ES3mDyH
	3Aen0khL8K9atfYmCpvSOeK7qWqGI+m5JTpCb8ZPLuX6YmxWF11YcO6wSHFD4A==
X-Gm-Gg: AeBDietgA33AtUhozwf68s8zgZrzhRfBZEi06M7PCy8akIL6ebyqvK6R/dMsSIWoNBs
	p+yD218yBCzp8eyuYykSjvyOjzIdKITPD/D6IG0Dx/weJB5tsqvQ2byPFGO9SRbf/s1Odv73w0Q
	Ryf22CzZmgQppOFLrYu2bQK4lcXCEGUdR9tfBkNNAK4JDH0WdmOLVp429sTpAKzcSwYD2d7k8Xn
	ZDWahfBxCJ1/QPCurTCu+4WaN4I5Jm6uNdg2EdZiRFOvZvJMBdvGrxp93mnOZmFHjU/kg9IQwMr
	n6/iGZOy1+Xgt1DAj3Uv6auQmE3HUVtvPS0kVhgroRuP1P33QNoBbCp3xCA1rEoqVd9mDPctR/j
	ybSYNZDE8mVehyRN5Ij0G/Z4FymfbJ+2m7veVpn3RgHqT776SAMWSJLQGuQJ8HH4IATz+xVFowf
	yXYzpwc46rGVpZycB62a6OppvBRg==
X-Received: by 2002:a05:600c:1da1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488998f488cmr283589505e9.29.1775644406918;
        Wed, 08 Apr 2026 03:33:26 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a952a03asm299363915e9.0.2026.04.08.03.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:33:26 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-security][PATCH] wic: move to files/wic
Date: Wed,  8 Apr 2026 12:33:23 +0200
Message-ID: <20260408103323.4007109-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Apr 2026 10:33:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3662

From: Martin Jansa <martin.jansa@gmail.com>

To avoid sanity check failure
https://git.openembedded.org/openembedded-core/commit/?id=07e410600c41103098b670f12abe87f64419a624

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 {wic => files/wic}/beaglebone-yocto-verity.wks.in        | 0
 {wic => files/wic}/systemd-bootdisk-dmverity-hash.wks.in | 0
 {wic => files/wic}/systemd-bootdisk-dmverity.wks.in      | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename {wic => files/wic}/beaglebone-yocto-verity.wks.in (100%)
 rename {wic => files/wic}/systemd-bootdisk-dmverity-hash.wks.in (100%)
 rename {wic => files/wic}/systemd-bootdisk-dmverity.wks.in (100%)

diff --git a/wic/beaglebone-yocto-verity.wks.in b/files/wic/beaglebone-yocto-verity.wks.in
similarity index 100%
rename from wic/beaglebone-yocto-verity.wks.in
rename to files/wic/beaglebone-yocto-verity.wks.in
diff --git a/wic/systemd-bootdisk-dmverity-hash.wks.in b/files/wic/systemd-bootdisk-dmverity-hash.wks.in
similarity index 100%
rename from wic/systemd-bootdisk-dmverity-hash.wks.in
rename to files/wic/systemd-bootdisk-dmverity-hash.wks.in
diff --git a/wic/systemd-bootdisk-dmverity.wks.in b/files/wic/systemd-bootdisk-dmverity.wks.in
similarity index 100%
rename from wic/systemd-bootdisk-dmverity.wks.in
rename to files/wic/systemd-bootdisk-dmverity.wks.in

