Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1771.1794714435495973116
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 19:47:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=vEivvibY;
 spf=pass (domain: gmail.com, ip: 209.85.214.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9d7791b00so26101945ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 19:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794714435; x=1795319235; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e/XKLkkv+fqps/DjE41QlVgX0BUThzofZ6IAJ7Fh970=;
        b=vEivvibYvpdQGCMx64cNOvvmj+ZEmcUbEmhcTTc3fmROS65PSbQ1F7pLGjtwpJ1YGx
         ji0+TAmYga+hbzALTYEgecju+j/SrhqX+/VDPNP4fi2cm2Tz83M88nMAfAXvEA/pYKks
         SfrKHESuOcFJpoU1aZebYsrVShZBo1aUR5bVdbCFgyTQuONcNfiByUDpvcH7c9/EdAcc
         s+fPY77eOfl1iKllqUx6fMVb3UeI6CYAS7UOgnhZ06s9UAZ8UohGWAwtzs4j2V9pZx1q
         LxbplpqdLHE/qZCE2wnXwBBNuDf1hR4QmFc93y7YdJ/obTaUCW8hkDj52liVBZFuQKBT
         bu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794714435; x=1795319235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e/XKLkkv+fqps/DjE41QlVgX0BUThzofZ6IAJ7Fh970=;
        b=PFURO29/7m8wQ0ObsdPKA4IhLMCjz1JFMIdTf1WF0PAk9+Lt/LezqINWwluSaw518e
         17DjZDDI+uvOPDNyuMZ2Mai16wYc6G2/G8DiRfxLmVWNfax8mbeXZGb31TvpurQ7yBJf
         t8w2cbFKRn1AU4ZMeiNWzfbKS1CgZ5JD/6g7IZVo51eGps8kG9gXHJKgsWjx3VTudFKL
         LnTl7Ayt0X+zJ/VihDYtFicEfqxVXn35SOIu3BuD5m8y6aBFUt1GypVQS2ShGJjRYtZq
         Hg88Zz2aVQ/tro212N8cizuXmm05ZoJttffLtgsY9UWCwxSAVbseaUlhe3jBxYJ3rh8m
         ylKw==
X-Gm-Message-State: APuU4Z87EyXpVXDs8YIqiflhMrXDIVK1WiKIwyNBaxzREOLmdAdQzUsG
	bzehkXbksZg/x2vqE5YT8sN9nWouJv93MXSiHd1Pqs0pYkw7aNE0KryIhwSMKA==
X-Gm-Gg: AYBFou0PB8TtRyfGkxBFqYiORV5W4fThL1Ti2QY2vQMRh5gztXTrHbmBzgtX9DKGIX6
	kKH0j6+qfUJBy5OpuYor0hRwXchwD+7BEN8X31wT1Jv/WnzApFsfW+a/Kh/4MilqEK/LFHt/vCT
	jFwJIjtsbp+ztY5qK/lU1babQT7auknZF1WtByuZw0crmZHqNsuvVO76qAvYMKN8Y/bclDNPJid
	qEt1rTRP3sz8fONsQz/bN8nnybuWB58+IYF37UuF1PEjey3ZD+eHMigmzwuzkrgfTdH60VCPA1A
	ycG/UAJkJAEl3cDsltIOyYbrer/w7gHwgOyJLJAU8POUVIoQFBJMVKzFB8yQLSxEjc3AoW/zR8A
	OUbXhbZc9MaABSSqu5EWvr2SQJ75jRwRrb4EK4G0G1KY+CxfOno8jyS4tmiuzLsVS9e06iZNUid
	gy7l8I7WaepCoPzz/YRNIDnXjs3kCbIZyXKHyToH4b4syyd0mzXkuzEImHMmifJy+c+Mz8e455j
	TuRZieX39R6L2hiBuWjxROyKahRTlmKFS8RRLo4ebCgfptf37La/AwIPfVysM9uz/AxfksT609D
	Y+9y/79EhM/k/1WVcNA1WhHXkqV1h+oZkBM1tD7ul/vWNJs6CsVGUNh2I59kfwbKnz5mYnxIoFl
	Mx3NUEIA=
X-Received: by 2002:a17:90b:3985:b0:3ab:c80:936f with SMTP id 98e67ed59e1d1-3b1b09f37e5mr6704509a91.16.1794714434489;
        Sat, 14 Nov 2026 19:47:14 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1baaafdadsm8332319a91.13.2026.11.14.19.47.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 19:47:13 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] rrs: sum the up-to-date and not-updated counts over all layer branches
Date: Sat, 14 Nov 2026 19:46:54 -0800
Message-ID: <20261115034653.77988-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 03:47:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5391
Content-Type: text/plain; charset="utf-8"

_get_milestone_statistics() assigned the "up-to-date" and "not updated"
counts of each layer branch with "= +" instead of adding them, so a plan
with more than one layer branch showed only the last one's, against a
total summed over all of them (e.g. "1% up-to-date (22)" for
meta-openembedded 6.2 instead of 73%).

Tested on a test instance's meta-openembedded 6.2 page.

[YOCTO #16514]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 rrs/views.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rrs/views.py b/rrs/views.py
index 0374f5a..b2520ce 100644
--- a/rrs/views.py
+++ b/rrs/views.py
@@ -300,8 +300,8 @@ def _get_milestone_statistics(milestone, maintainer_name=None):
                 Raw.get_reup_statistics(milestone.release.plan, milestone.end_date, recipe_upstream_history)
             milestone_statistics['all'] += \
                 t_updated + t_not_updated + t_cant + t_unknown
-            milestone_statistics['up_to_date'] = +t_updated
-            milestone_statistics['not_updated'] = +t_not_updated
+            milestone_statistics['up_to_date'] += t_updated
+            milestone_statistics['not_updated'] += t_not_updated
             milestone_statistics['cant_be_updated'] += t_cant
             milestone_statistics['unknown'] += t_unknown
 
-- 
2.56.1

