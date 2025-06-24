Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93257C77B7C
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 16:27:51 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web10.296.1750782470947370422
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Jun 2025 09:27:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=N6k3ZwQO;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.170, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so6055184a12.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Jun 2025 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1750782470; x=1751387270; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+zm4FJ57QsMmo8UdwMBhji5s7FDUSWvQYWRA6bPnhU=;
        b=N6k3ZwQOrUFP0gqtrd8LVwC+uRiK9c5/7bDPnD0I1BOQ3EZZIuMN9qBFBsvPJp86u5
         UpYDmscXpf2uMOVPi/SpqMRarDQOQtH9SLu10lUlHY0eqL5bEf0+doQbLav9WdN6PeLD
         bfKaN0LPZmFIZ+mOILdNwNhDYBZVUXpLWpHShdmlm5w8ZgUiKJL6Smt6gXtyN7ORnIvo
         b6ZveLQmrA2hFGrR9wx63jGuOhXKCIdvs3zQOTvorB56vmL6yD+liUYHcIg72QvrBqyM
         1zdXqtC2SIWfO0hYYmp+hhD3QGF0YoYjIKPUQW7MX4Obo+UO4es6EGqjES54SqC+xzlF
         V/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750782470; x=1751387270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+zm4FJ57QsMmo8UdwMBhji5s7FDUSWvQYWRA6bPnhU=;
        b=hAXmxxxGn7diRRJoEUAiaFgTnPgYyctT6qL4xdzRHaupruSqkaMGloNGiq1tbKNFkF
         vTVYN5vRmUsCblTI8xePHwYdET7xXvjiQtynCh9OXNMyh94mWQ+z7D6m/11fX9/oiU7t
         mLNgEmxHbJjE9lPnLRO8C6xRGON9ZvPXfpHeq9ts6TVzx6ajGxJ6kAyPcXXLgDtXiIKI
         Mc4m582ojw27O4/y57h8emXNHs/yjlxHcWpTrbqlmi+50rq/tOfwnaLZl73mmziLCB4B
         Um6FULec00CjcjVZ6WMOIuE/JSIZNM/4gNyxnFw4wSi+kml2m0HiwszCsVgz7R492oxj
         TfVw==
X-Gm-Message-State: AOJu0YwPPctG5pgHdojd6egGYSr/VFb30QN4xnr4xYlcRns/qf/Zvx2p
	IXV3ALrItjULrcDrCvyWObe1pLOxoBhJa+cHM8p75zi8/rJ3+7CGTZ8mvCbeJzqEiP/P51DJKHH
	MdSDF
X-Gm-Gg: ASbGncuQYXTvOUB4v3j5rZFvjTT8v2Lq0/mU8vfaj8HrapEznVMa8Sbyg2adSecbQgY
	B3ehhDohyoJUAp+bTADvLs8XfNFiO2L1l9xGMXI5aSWQKbYu80WIer2ALummf3e+SAHlNidnggl
	xDJ2aBKonybi48N3lfFfS+LLHE5YqNNYEYduqeQZKYELD6L4RIfIxvA0JzMcr0dNTTnI9DYB6yX
	TGn4B2Xiqvgl2uf3rxatDhqfkNaS9lz3on/ZdwY9ZtML/TfZH071MoeLABwGoDKw0b3iY3cMlhZ
	N6fHbpyWQNEx5/nWTkfxUacSeCP2n9T7EgSDKDjxzYJYPmrWBmZfAw==
X-Google-Smtp-Source: AGHT+IFF61PfU9PE4oLGcz89OLDkLaD2VbCh8gP6JFMls4ZbeYhLgBc0iGDtcTxXoou7KdAb9e+fZA==
X-Received: by 2002:a05:6a20:244a:b0:21a:de8e:5cbb with SMTP id adf61e73a8af0-22026f15aebmr27786672637.25.1750782469885;
        Tue, 24 Jun 2025 09:27:49 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:73a8:fac0:f9e5:82a1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12583c5sm10755072a12.63.2025.06.24.09.27.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:27:49 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2 1/1] schedulers: update branchdefaults for walnascar
Date: Tue, 24 Jun 2025 09:27:40 -0700
Message-ID: <402aa545c0ac11f4d9fbfdbf785b42ee11c6a04a.1750779852.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750779852.git.steve@sakoman.com>
References: <cover.1750779852.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 24 Jun 2025 16:27:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1685

Signed-off-by: Steve Sakoman <steve@sakoman.com
---
 schedulers.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index 122149c..08a9c20 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -72,10 +72,10 @@ branchdefaults = {
         'branch_bitbake': '2.12',
         'branch_meta-arm': 'walnascar',
         'branch_meta-agl': 'master',
-        'branch_meta-aws': 'master',
+        'branch_meta-aws': 'walnascar',
         'branch_meta-clang': 'walnascar',
         'branch_meta-gplv2': 'master',
-        'branch_meta-intel': 'master',
+        'branch_meta-intel': 'walnascar',
         'branch_meta-mingw': 'walnascar',
         'branch_meta-openembedded': 'walnascar',
         'branch_meta-security': 'walnascar',
-- 
2.43.0


