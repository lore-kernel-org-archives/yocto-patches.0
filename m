Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085BBC83F09
	for <webhook@archiver.kernel.org>; Wed,  9 Jul 2025 10:52:04 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.12640.1752058321366863781
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Jul 2025 03:52:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Tlfpucag;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d54214adso38672825e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 03:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752058319; x=1752663119; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4sBD8LxoGBBgwov9ggClYPfKpZc0ytw1ePsJ9DR95Vs=;
        b=TlfpucagCFKA3omNhx95DlwDom2TpxfFY8ncUy5M+UII2TRVsg+Ha6b0CaC2tE6oer
         ot8xDgPKUUNGZ9YHhJsXtxv5El8sF+77k9ETq82UUqEOCzTaisND+8EENYStHcYuEq+V
         WanlgB5aEm2GXWwZGKBG+ENFBoUxjZ35qBMzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752058319; x=1752663119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sBD8LxoGBBgwov9ggClYPfKpZc0ytw1ePsJ9DR95Vs=;
        b=CLwdJiO6YmPIJWuBQg2SSGwmEjLKYsXjmlsjKmW3W/bZJju1nEnRfuOidM25Z2OYlw
         0/AcAIXMZBCg8O9RTySntCPO7Gc5UOfLAN1UOWbaT52bExNYt3mBhv7/g5e4uzPqO8xE
         fY6T/0ErmuSQCi8LD08sw51Kyz6QTbgu3hxNvrItHwradk/k75uCN6j7QoKlUPSEG7sh
         91ZxthJ7A+Em8DEuFHjW4JAk1xye1DDMqpaWL1u/m3lwJ3Ke3oPca/OCZweth4OINlJw
         FBktMgEYL1d1tFU7+VvTaAbpfLjrMtYBMoLAQCP6uMo/f7sU1w1oJpG/VMjSE00OGO+5
         /05w==
X-Gm-Message-State: AOJu0YyD4R3lbLGAdm6KBRKob2ECrOXYCro1KVRNU77pPyvD4GKqbMxu
	n352n+pgMKjEujaiaOoapcVJ440EcI3HmwWGMtZhrVLdV6NRt7DhHgi7+niNf6AYMQNA/GebGIc
	PmkYH
X-Gm-Gg: ASbGncvPLY7L/uSIuflhpQ1uv07C5u2Jrc/vtOi6FbUlq2sryHQNyNpAR9Apb8Tdim+
	47Rtj+waYfbTSQ0TdvO6TRSzxlahO+y2PNHHgeWZPReQFSiljkK/7PZeNtqwUlUv25+oitqTczW
	yahClsYKbAaR4MiOzBy1j5IYccO0UxGiEBaRRxHNazbXq0avMJqaxyE2nUlYjmsHsatigHi5AUk
	dXAg6AZC1oAzHLFIWaK9raCTnw+LTIUOswWK+yhKesU7dBtx2wl0MJ4mizoxO3gHzIAeDbGmrNw
	cWPvhG0mjfLQLt1msAZdXg2qb8nBtk1WPabxiSMtJYQiVsetvwdphakLj+nI9Naujz1zlqwDWha
	9TbYlGd2qJl13UQ==
X-Google-Smtp-Source: AGHT+IFGc6J1aQNwKXoHt33Rasc4fDaINHSRFdFtOviD9lYyeG/c9H7+xY/s8ct3AU4ZG/phmsBXsQ==
X-Received: by 2002:a05:6000:40c6:b0:3a5:5270:a52c with SMTP id ffacd0b85a97d-3b5e4472ec0mr1644825f8f.0.1752058318558;
        Wed, 09 Jul 2025 03:51:58 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8726:2b2e:9de:f840])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b472446fddsm15663009f8f.66.2025.07.09.03.51.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 03:51:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] schedulers: Ensure xxx/master-next matches master
Date: Wed,  9 Jul 2025 11:51:56 +0100
Message-ID: <20250709105156.839074-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 10:52:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1790

riscv builds weren't being triggered for some master-next builds. Tweak
the logic to us "in" instead of "startswith" to avoid this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 schedulers.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index 08a9c20c..875f44a0 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -434,7 +434,7 @@ def builderNamesFromConfigQuick(props):
 
     builders = config.trigger_builders_wait_quick
     for b in config.trigger_builders_wait_quick_releases:
-        if yp_branch and yp_branch.startswith(b):
+        if yp_branch and yp_branch in b:
             log.msg("builderNames: Filtering branch %s due to entry %s" % (str(yp_branch), str(b)))
             builders = config.trigger_builders_wait_quick_releases[b]
 
@@ -447,7 +447,7 @@ def builderNamesFromConfigFull(props):
 
     builders = config.trigger_builders_wait_full
     for b in config.trigger_builders_wait_full_releases:
-        if yp_branch and yp_branch.startswith(b):
+        if yp_branch and yp_branch in b:
             log.msg("builderNames: Filtering branch %s due to entry %s" % (str(yp_branch), str(b)))
             builders = config.trigger_builders_wait_full_releases[b]
 

