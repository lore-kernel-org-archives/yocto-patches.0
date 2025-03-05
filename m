Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A7C282D9
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:25:22 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.10288.1741170317688697569
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:25:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hrCl6to7;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390fb1b987fso4626818f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 02:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741170315; x=1741775115; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP+8NIGM/2igLj17bN/qI3XSwCdDETnttDiixUnUFCU=;
        b=hrCl6to7xWPrIo8iY1/bx06QoTs7TYAar2IuA+N5Bz0x8AJrwjqEi9TLFSN+oTEHgs
         KtmA+fTb+5WGswyrSHwr+U2+ZVL+vLmqI0ryZwxZNA8+neLnn0j3wW4RmFlmbY0O/hh/
         ncGObmfuftS2JHE/vhuTBnhmrlP4zRdDVJ8HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170315; x=1741775115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yP+8NIGM/2igLj17bN/qI3XSwCdDETnttDiixUnUFCU=;
        b=dBttqtQPWHpaAgDSV6szNXRDu0wFNiSpizruuLeKa7RRmRchsw5mI5VOvvWmLyxv8/
         WmhSuYQXSUaeeZlowO5yH/kGVu6hXTGhWSwFdsvgrpZKJRt2Mj5k0cJPtTkWxsQ+FnIB
         1JAjtbvSLgSCPFS+kAgBoIWX5QAKuq4Ph9yQ7/IQf7blHHxdhZOyvOkUCs7qon3Isibu
         tsqez6yvx/z2ZFzb73Hsy+mUCOiWygi16/cNGse0nH3XKpjR2ur/Ys4su1WEopsgpipx
         AYuv3h7gZbCcOixRIc9heJNFlxNMX+/4ikrYYdgn1DhZJ/VVLbFkLpzlQzXOHrBPA42f
         6biA==
X-Gm-Message-State: AOJu0YwVevyzqoxPIVLBAGscRI6C7NNj9o+fkbyescMfYV6lefJSFWnh
	xpioEvruzS93x6FuvUYJkXAsMo0tfh2DouD4vFfkUEO4CrzeE0b7F0P2IUGtn/SFJTvLg7K6t6Q
	2
X-Gm-Gg: ASbGncsIz+sqbr2y6XMWkqk7VKdvvN8zUFGsebht8uY+SOqpFB56qtNOaWhDGWuOM7Q
	kehzVnAhTcMzUNxG5SZW+8Ht05LGBwseZ/NW+sAW+p5MgeFXYv05FIpyDTSt/l9IjTMC10PXosa
	Sn7rc8tsQOi1cpGTDRfOcLzmoX8ecsVHrPlPqlAbSgSQqUhInDfXyn9gaev112Cg9k/9YcFAV1q
	GAMyuEaTdquGPv9xU6y+OD2dzvJIHpcnSK/SX49hfabEDh7i2oQxtv/p6nmnug/YgAc8O8koyip
	UApG4MF7eX/4Q/JjAMG3X5GBC5eDI0nCfhb3DRjEbGC/d/2R69jg/22o1EwR5SOzmHhYua+gUw=
	=
X-Google-Smtp-Source: AGHT+IGYQkp5F/Aw1wtxa36XHqRA6Zz6Pvux0Udj8wvBCZ54O02fcB/8L/aJQ3KxWCrkHyYYuPpAhw==
X-Received: by 2002:a05:6000:1886:b0:390:e8bf:55a8 with SMTP id ffacd0b85a97d-3911f7412f1mr1814069f8f.18.1741170315547;
        Wed, 05 Mar 2025 02:25:15 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm12973495e9.31.2025.03.05.02.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:25:14 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>
Subject: [yocto-autobuilder-helper] [PATCH 07/11] scripts/release-parser.py: changed exceptions after tag clean up
Date: Wed,  5 Mar 2025 10:25:02 +0000
Message-ID: <20250305102506.2043524-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
References: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:25:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1151

From: Michael Halstead <mhalstead@linuxfoundation.org>

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 scripts/release-parser.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index e0de351..1e46315 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -32,9 +32,7 @@ def get_git_tags():
     tag_list = []
     branches = sorted(set([tag.name[:9] for tag in tags]))
     # Remove bad tags
-    branches.remove("yocto-1.9")
-    branches.remove("yocto_1.5")
-    branches.remove("yocto-1.4")
+    branches.remove("yocto-1.9") # To deal with milestone 1 before 1.9 was renamed 2.0.
 
     odd_commit_strings = ["rc", "final", "docs"]
     for branch in branches:

