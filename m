Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83194F588C9
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 05:41:45 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11325.1776750103700275031
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 22:41:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=btt5xmVq;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: rybczynska@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso10810535e9.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 22:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776750101; x=1777354901; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLxC8IQ0qWSgJbbwWRqvYXNgNCNqHRjososv6JjlK0E=;
        b=btt5xmVqnJs1QhMmcvgPgAdiYksVR/Qw0ZltkhxTQBx8cPl2TEVB8F7/iDfj7zDeS2
         hDiaBwhkvm9d7y1mUqG9pl5XgJKNZx80iAR9K5PfVqQSPXQFBzn0z8529tL5yzsysJQr
         +sfwFkFs7QTWK+JVLqLlfHK+8dlB3VhOYWl7Mu92et4ZaCuDMSdFs9dCeW9abPHqztdP
         GZkhgAIZv05VylJykOD0nGnIOSC+ETgc+jGyHX2TO4ziMDv/aoYzZFzevjTotsVsIDs8
         2hht7/UTJmGyV37wU2BZyAtr2Yzwex02fpwLLHGPwERpH/GkSLYZiTu/NXyj07MhCHXz
         czwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776750101; x=1777354901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLxC8IQ0qWSgJbbwWRqvYXNgNCNqHRjososv6JjlK0E=;
        b=iPJzCICS090L0iZR9MT0qBso04qiRo+EhlLP2BC5+EoQXbdnMfJKgCOFftGTZ18EIs
         +xlHpc6VShwisxcrcdG6zZsA9TIa39BVzy0ENw8dT+NnBJcySzGFp3vODBA6dDV2dnv/
         rsLLujcGuxvqNdiwNZTtkjRnZUfcNSw7GROQpk2XH1lw2JUHielI5eq73y/2vUpg8Jrf
         BugDgJ/VZb5kRAgBmxTkMoUFy8WgNA6+M4nlEuVF/Ore8LtZmzQgktGvXNAYnTDreGmk
         93AaYjMMaTPjFKaniOjk6HMzeaUpg/icKJqb2gJE4oTOTgcBD3myqM9HdU3qrmiQcYhS
         K8iA==
X-Gm-Message-State: AOJu0Yz0yskZvXgiawQnkpsBvzWDW2LtfXckvbalQybXJ2d+5K6hEot6
	ZGhrYNxvukOmGB2QdBjpqv/byiTEmlD5iXAXyMsX0Y7ZLnFHiXCk94TIC79JPshj
X-Gm-Gg: AeBDietyfjDQ3BDfQpDqVgTqPDRbcI+9oGWflxounKHYvyzX/8PFx99CVKKmhTgm4Xr
	U9DT7lOo6P2xTloknSJxry3CHcK07Jossr7SgGAuKleT7pPseXsVjRNaGa4jJ0QY3s9JoTvCSSz
	sNujDAtqmdnT8PgtbtUK/dD9tioBwLubQBHJ1Mq6LCUUAq/iCgnMyvKBe7IFjj0q60RAuZGClQ1
	wjPnqU8l0xrP1RoeGgAheU1Bi2AZfQyD/FCRWOQk8lw4tBLhCpSlsObYMnwsDUu7TOQnIe/IVCt
	wQYjYvSDkhSncGkc9Hh3VlrbUqSsD64goQVARPq6fLSOj0jKvpAoOra/KVdW9M+hIzae817+lMk
	7dsZxNWUwaHKhxEGyy0c9DXkNuiS4JAgFQ/FdSH3JGFeXVttN/q1Y3zUgOt1X2oLqW9dENh4bH2
	cWdLF5vLj/XF8vAY+NfCyb8LMWwSs3E0MHqWHfm4+9Q3hYzRnc2GFaReDXSxXEi/pQWBgXCGIbV
	Iq42uHq8pEyo5I6GCIUoE1NoTqG2tPMZxfLyWun/BjclGuC
X-Received: by 2002:a05:600c:41d6:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-488fb745294mr150498915e9.1.1776750101112;
        Mon, 20 Apr 2026 22:41:41 -0700 (PDT)
Received: from localhost.localdomain (88-174-158-187.subs.proxad.net. [88.174.158.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc5e3f4sm156925985e9.2.2026.04.20.22.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 22:41:40 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
X-Google-Original-From: Marta Rybczynska <marta.rybczynska@ygreky.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH] README: update CI links
Date: Tue, 21 Apr 2026 07:41:33 +0200
Message-ID: <20260421054133.16448-1-marta.rybczynska@ygreky.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 05:41:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3746

Update CI links for meta-security

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 README.md | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/README.md b/README.md
index dae5aad..c92d3f2 100644
--- a/README.md
+++ b/README.md
@@ -1,7 +1,5 @@
-Master-next: 
-[![pipeline status](https://gitlab.com/akuster/meta-security/badges/master-next/pipeline.svg)](https://gitlab.com/akuster/meta-security/-/commits/master-next)
-
-Master: [![pipeline status](https://gitlab.com/akuster/meta-security/badges/master/pipeline.svg)](https://gitlab.com/akuster/meta-security/-/commits/master)
+Master-next: [pipeline status](https://gitlab.com/ygreky/meta-security/-/pipelines)
+Master: [pipeline status](https://gitlab.com/ygreky/meta-security/-/pipelines)
 
 Meta-security
 =============
-- 
2.47.3


