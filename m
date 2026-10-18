Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF658CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 02:12:36 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8118.1792289550973987902
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 19:12:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YBycWgPc;
 spf=pass (domain: gmail.com, ip: 209.85.215.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso771788a12.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 19:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289550; x=1792894350; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HB6JeoHTbV8+JVOBDAaeMZuaXW/MOcV2IhpL4QuoP6M=;
        b=YBycWgPcIk9KjEVhUU0jtOq1W+HgWa3DZp77T6+oVGN7P77vUJOHAuiQbNOucbAwNc
         1tGA829ELqA8ND3z6wuSNEQTh6P9gxM1Qwu+8E5hLbFXBWMqVaodmMxxHb3vcWpvZCd1
         Nu66hTopsgN32ox5nQ1SfY4vitJx1eIAnKdOUCfv0tEV5w5DXtR2o3htMYCM5q6T77ut
         GorQdzpDyclSeE9psO9Y5ggZiGT7SgOKg/5mfrBhDGQhp8pZ80Cr+Kh73X1IzuSIn2/S
         kQ2RJQH6yYNddzTRsbgJatVl7qHOQv7wArmBTfS119JJ2qy7g/ylt/5D+bwZEO6//TrC
         NWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289550; x=1792894350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HB6JeoHTbV8+JVOBDAaeMZuaXW/MOcV2IhpL4QuoP6M=;
        b=UybWMA2kiJJNzxiMuGVErkHhKvbcpIXobHoq7spo6lxhOBWVE45D/bU3e0s/omdLLD
         zpbZXB1kJrxoAqzc0zVxnuL0XEe069+8GO0U8PopwGyMMeLodhxbwPPLgMTNObfmatPL
         KCckLFXSHFY3xgQbys1yegFAteskePWVX/30TqLD6MTI1in0Q6NhZWDqoGv0jc2OZkZH
         NpkqhbsWmqKkWRqUix9OTPYN18yT7jQMVJQmgGj2WPBlMLUbBBB9F5ZTP8WvKOENltdd
         uMcpA91Mv7jXFMHbYkCqrDwz6+pj6E2vgxVbSWbImeftnVd1k85U0SoYqtHGeBsq/P/u
         7eLA==
X-Gm-Message-State: AFq9FYKHAhNTioAgcKNa3tjApxrdLw6YCGcbSJCIqCiqRYtrprzkVWTS
	EZWXsZ337rxTFOQwEzESgUPZwOEI4auUHlJrVsV94XAVWGOJeMXUVQ7sApcB0Q==
X-Gm-Gg: AYBFou0GRH57PVgyPZT9Tw1L5bBUFvXicthUoj4Wn0EnjbpCGvDYMmxN0XqreEnKhZv
	Atkqmszptrp77lHMIgiP3Gxuc2JwdGq/oy6uyAhD9tsbZzt0MZQiFia5x4Ry8sR4ScVzWGppb4P
	d9RcKgH0B9wPJvsszgGIAxZcu6haQ4qs0RVnoRVLM5cmjxMllupN/joUPFD6AvtqfRNcVRVJhZc
	jNRVcq8nngO0v4g54SxdLr77PPhgOuBGqQ3cMdxktYhfeoiiUmW1tink+44pH4ZtpqFsedLwBmY
	98JKiUEwuJfEIf57BYL0SrHlORgsQ+OEZ3P9o2Ppe8XOM23KQ9vwcYjABh3gqj4WPV1ZqFwGGhQ
	GwbkKblUxe2YmyOg/SFv6xQKZhytPNI0LpqkdDnNbvKkV4msyBLv+LqHDpHw6Z42qdh1+wAcEzV
	Bs1AG7WpKhw57bUWuJhAwARDJe0yjJOK/UMFB6pbJ639gAFWBGevoDZK+japdDN8hnmxSAezTtP
	TOV6Al8Y/JZZYB67FVPnJVaTSC417I=
X-Received: by 2002:a17:90b:3b8e:b0:3a8:c0cd:57fb with SMTP id 98e67ed59e1d1-3acef14fb13mr3560199a91.42.1792289549961;
        Sat, 17 Oct 2026 19:12:29 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05fb680sm6162707a91.2.2026.10.17.19.12.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 19:12:29 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [error-report-web][PULL] Upgrade to Bootstrap 3.4.1 and jQuery 3.7.1
Date: Sat, 17 Oct 2026 19:12:28 -0700
Message-ID: <20261018021228.79350-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 02:12:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5069

Known XSS issues in both; same versions as layerindex-web.
Applies on top of "Don't render submitted data as HTML".

[YOCTO #16459]

The following changes since commit 324be3410d0db37917191b1b2d3ea630a9af5d82:

  Remove bleach and store submitted data as sent. (2026-10-17 18:18:00 -0700)

are available in the Git repository at:

  https://github.com/moto-timo/error-report-web.git timo/bootstrap-3

for you to fetch changes up to 27383e197888b1ef3f1022c97bef3a2c54bc04f8:

  Remove unused font-awesome.min.css. (2026-10-17 18:18:57 -0700)

----------------------------------------------------------------
Tim Orling (3):
      Upgrade Bootstrap from 2.3.2 to 3.4.1.
      Upgrade jQuery from 1.10.2 to 3.7.1.
      Remove unused font-awesome.min.css.

 Post/static/LICENSE.bootstrap                      |   21 +
 Post/static/LICENSE.jquery                         |   20 +
 Post/static/css/bootstrap-responsive.css           | 1109 ---
 Post/static/css/bootstrap-responsive.min.css       |    9 -
 Post/static/css/bootstrap-theme.min.css            |    6 +
 Post/static/css/bootstrap.css                      | 6167 ------------
 Post/static/css/bootstrap.min.css                  |   13 +-
 Post/static/css/custom.css                         |   54 +-
 Post/static/css/font-awesome.min.css               |   33 -
 Post/static/fonts/glyphicons-halflings-regular.eot |  Bin 0 -> 20127 bytes
 Post/static/fonts/glyphicons-halflings-regular.svg |  288 +
 Post/static/fonts/glyphicons-halflings-regular.ttf |  Bin 0 -> 45404 bytes
 .../static/fonts/glyphicons-halflings-regular.woff |  Bin 0 -> 23424 bytes
 .../fonts/glyphicons-halflings-regular.woff2       |  Bin 0 -> 18028 bytes
 Post/static/img/glyphicons-halflings.png           |  Bin 12799 -> 0 bytes
 Post/static/js/bootstrap-3.4.1.min.js              |    6 +
 Post/static/js/bootstrap.js                        | 2280 -----
 Post/static/js/bootstrap.min.js                    |    6 -
 Post/static/js/jquery-3.7.1.min.js                 |    2 +
 Post/static/js/jquery.js                           | 9789 --------------------
 Post/static/js/main.js                             |   12 +-
 templates/base.html                                |   83 +-
 templates/error-details.html                       |   18 +-
 templates/home.html                                |   99 +-
 templates/latest-errors.html                       |  118 +-
 25 files changed, 546 insertions(+), 19587 deletions(-)
 create mode 100644 Post/static/LICENSE.bootstrap
 create mode 100644 Post/static/LICENSE.jquery
 delete mode 100644 Post/static/css/bootstrap-responsive.css
 delete mode 100644 Post/static/css/bootstrap-responsive.min.css
 create mode 100644 Post/static/css/bootstrap-theme.min.css
 delete mode 100644 Post/static/css/bootstrap.css
 delete mode 100644 Post/static/css/font-awesome.min.css
 create mode 100644 Post/static/fonts/glyphicons-halflings-regular.eot
 create mode 100644 Post/static/fonts/glyphicons-halflings-regular.svg
 create mode 100644 Post/static/fonts/glyphicons-halflings-regular.ttf
 create mode 100644 Post/static/fonts/glyphicons-halflings-regular.woff
 create mode 100644 Post/static/fonts/glyphicons-halflings-regular.woff2
 delete mode 100644 Post/static/img/glyphicons-halflings.png
 create mode 100644 Post/static/js/bootstrap-3.4.1.min.js
 delete mode 100644 Post/static/js/bootstrap.js
 delete mode 100644 Post/static/js/bootstrap.min.js
 create mode 100644 Post/static/js/jquery-3.7.1.min.js
 delete mode 100644 Post/static/js/jquery.js

