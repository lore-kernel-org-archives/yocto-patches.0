Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17325D730AD
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 18:37:07 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2217.1775241423887200807
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 11:37:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=rSpPJWMq;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cbb6d5f780so228364785a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775241422; x=1775846222; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njwyAlZ/LQHHKKCqNdpb0gRV6wtLxhps+ypqRcrg1/k=;
        b=rSpPJWMqaHP4Vq4nsTdEaJOVeoQ6urXFTC6KmiLSIZKTlsLByU/UuUYkqWnE4/F8jr
         Td5D7jHRwEhzGNFFqPiGzWGx/33k+2QFRYJvMy2xVQN1cw3iPZTNszUqEw0v2PD1qd6h
         CfCLhry/Yn+j9EWAT3pjivDlS5aCjR42uYtuxVOO9DtnCGf706axcGEptHpdMVByzRV4
         e4osiUGjMNWwCz+cwy+1c6SXbt0S6lUnuh0O+r+KMEFjr0T2bCoOEN4rB052Uxd3ce2L
         iaASqKeMTjV3XDLPTEmCe39ol2u1m7EFWst/9odD83LqKtFkDWLQ/7IlusxxJ/OuOURD
         AEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241422; x=1775846222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=njwyAlZ/LQHHKKCqNdpb0gRV6wtLxhps+ypqRcrg1/k=;
        b=EC1sZEMxBSoxt3lx01q9XwlcuHAdPpx9K6Oy307IW/NQ87N2bcnMMLwcN0kDOL+++t
         R8voGnSZX0rCxFzLLfzzTU+HexCT4+6TbiMiBclVwL80ywbdtoRb5wN+mVwwIbK1BL4V
         KlDF8Ns7BySGVmQJfUmzp4tLZuIVkFlG1Uk0RHuuK1XpY6MdzYmWEB5MUw9NxGemc/3g
         vNZxVepydzqQTbt1VAufBLhutdrSPo03hJsTvkP3SWJYalQ+vUJAe/z8LbuIXv1BsaO7
         q0c5CT+LR4k5Shr6JU7YAPYjkwimg9LJUL+N2GCWCiJFvFAdWye7lVIc5kdxoao3KpQj
         LZtA==
X-Gm-Message-State: AOJu0YwNYa5zW5nRaW/9G8cS1XC/jcIRy5WEQ6MbMmPu5gwIDGvrcR20
	p4CjQq/ASxENbLLzaB/PQBdKkakllF9jJNL7zq6KikjrzWdocrmKseT848wWRnnF
X-Gm-Gg: ATEYQzz7397rwiWOLitiprOvTBGfpnoaNVR0ejX9l4wkqamH/DKhGdyY9SI4Vv5Kx7y
	9kjaJf/W7o2uS4aYa7VWOCqftvMvJK6QYMEDwsU9vckwRCfROEQojy2EtkYcnqE4JnzXVJ826G5
	JMoHJGlml3N+zYfGrHyGJ1/YnhaO0GKfStol0nRCtgFd07iwuhtQDMWA4m2yokKWaIyL7v/a79/
	B71XbGjJkbFLH4AD/5lBC4LLHBpY79a17Co/mk6/7PQ1TR34SIfGOAnk99E3wr7Bo2nvnBD02S0
	MBM/XXg13NwduElw+66jvotHQfuyn/IGjyJTlaKkS+CpsN6g/KXqA7aFtwnvCLFDoSgE2VXMgys
	6gW1jrRV5YFW8WZSu18OL09a79scZl5LArU2QdsB9YdU/LtEnURU2Ut53L2Kbk7S35D6+UsFLV3
	18DVj9GTn9WyVF0JNfnI9tAWsL1frUAzdjo/wRIw9SUBIU232mjXG/swROqJmFF5AvYQ==
X-Received: by 2002:a05:620a:3715:b0:8cd:bff9:67ed with SMTP id af79cd13be357-8d4151e4697mr590567485a.0.1775241422438;
        Fri, 03 Apr 2026 11:37:02 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a874459asm472401785a.39.2026.04.03.11.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:37:01 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [wic][PATCH 5/9] bump version: 0.2.0 -> 0.3.0
Date: Fri,  3 Apr 2026 14:36:40 -0400
Message-ID: <20260403183644.2783267-6-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403183644.2783267-1-twoerner@gmail.com>
References: <20260403183644.2783267-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 18:37:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3631

Now that wic is its own standalone tool, bump the version to make the
change explicit.

NOTE: this commit does not work as-is, but is being provided in order to
      explicitly show a clean transition from oe-core

Reviewed-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Reviewed-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/cli.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wic/cli.py b/src/wic/cli.py
index a3402bffcc63..9de5efbb5aec 100755
--- a/src/wic/cli.py
+++ b/src/wic/cli.py
@@ -14,7 +14,7 @@
 # AUTHORS
 # Tom Zanussi <tom.zanussi (at] linux.intel.com>
 #
-__version__ = "0.2.0"
+__version__ = "0.3.0"
 
 # Python Standard Library modules
 import os
-- 
2.51.0


