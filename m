Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EEACD343F
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:00:24 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4498.1778205619738005290
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nNi/mTVx;
 spf=pass (domain: konsulko.com, ip: 209.85.210.170, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-834f1075805so993990b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205619; x=1778810419; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UushDgpJCHQe0Y2FluKNYZ7ooFItwXqIlxSI7Ww5DF0=;
        b=nNi/mTVxQQERiJxyRlPPVfW5YvArGf0k+hwG7izhiHmVFscERmhVoS0JiPjQdSJ/iO
         emb7MHLfj8BZ6ja/fZAYq46MpTJBX8sMJZ9+QzK+GHjZVoCJaCuDc7w7HGkrp0nASPl3
         lSxqZBW5UVYARG+l7xaeqiVDRETUh38+4aHBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205619; x=1778810419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UushDgpJCHQe0Y2FluKNYZ7ooFItwXqIlxSI7Ww5DF0=;
        b=H7UdBwA/5ev0+uzN8ZpC4WMPxg8okG+fEuEkx++c9pfvW9ISO0Ewl0Ymb7zZcfNhWN
         5NaKczuS6XPX4+7/kBYn5BJaA+5HG8e9BnXrci2vl7JMq4sZ3GINZVu8ViBvygo2Oj9b
         Da0dwbkzTmw3oKRpgNHRb/Q6h1vjFAnmkoaYxjEGpA4lUcnhYHd/esh21eFG1zKkoQ6Q
         5n0GMwFUG4dhvLbb+f/SaULbWXeDx9YZAEQx84JDTEHSL1YNsz0g1RWWw3FN/dgJRDqa
         9RRnARbVXOhgLHTTBCHkcsQaySN2pJwuI0YpEzrTSJd+9Q/znEaNi6URAxprqYQL1MQN
         30tA==
X-Gm-Message-State: AOJu0Ywgv7NNxGa97QoSOqaigPlUT8zEmNqR06Mbe0/slMtBykzC5F+M
	bMEXFspqMj//1GoVILBOe5SHJGzuJd1aWlLKIOZi/bbtCCHad6yT7xTAluwlfCk2tvV3dD7azi3
	XV0Gq
X-Gm-Gg: AeBDievREWN/pJbdOlojfA808cYTIafzsrngKhrSiVZeZhRfXxTnJ6Y/sepMG9eaIbk
	DVVWvy79p32pYicaI+nL02agpBBzNKKgIXJbkerFyDspi0BeJonUpBXtxVjmtV9XaJ6PiRuO7Ww
	DD6RPr2arLFjOJcgo84BeHp4zsPhofDKs4NMmGXfs6ezM3qzhVFmM1EdvtuT+U1OdRIlzZt50ti
	fCWr69B06PvFoUc6iZ5lO6rIA7OPzf8s/yY3pKiOJLZayx8XKduc5+ro3ba1ICV0MRIAFyjCTYX
	ytarB3A9wVSswwlzivSCPiQ78dTSkj4+KeK6pQjhzMAkwMZ+vx8xuwtv1EEfkq7ZVNLmI/uxS8L
	FTs+qgtVQNPxepFpxVe9HyDjeRvqZ3H0zRGQY8vAZ5GfmNhu1PEc+XRRNFXK2yzwW0GlHOm4Nml
	G9zejt2LXdfwe5tq7ML8w1E59Zg5ZvaD6D5Ia+Nm+5MOSdft2DyTuKrrOMIaEw5iA=
X-Received: by 2002:a05:6a00:8014:b0:82c:2555:b9b2 with SMTP id d2e1a72fcca58-83a5b6d0a28mr10546142b3a.10.1778205618950;
        Thu, 07 May 2026 19:00:18 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c1bsm12643585b3a.34.2026.05.07.19.00.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:18 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH 1/4] config.py: add vcontainers-tarball; containers tag
Date: Thu,  7 May 2026 19:00:03 -0700
Message-ID: <6e816aa1b2e35ffd2aa391d2dda727cefbad9e30.1778202070.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202070.git.tim.orling@konsulko.com>
References: <cover.1778202070.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:00:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3935

From: Tim Orling <tim.orling@konsulko.com>

Initial steps towards containers jobs.
We will need vcontainers-tarball (similar to buildtools job).

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/config.py b/config.py
index b5b2b62..630c8d3 100644
--- a/config.py
+++ b/config.py
@@ -34,6 +34,7 @@ buildertorepos = {
     "metrics":  baserepos + ["meta-openembedded"],
     "metrics-gitstats":  baserepos + ["meta-openembedded", "yocto-docs"],
     "meta-webosose":  baserepos + ["meta-clang", "meta-openembedded", "meta-qt6", "meta-webosose", "meta-security"],
+    "vcontainer-tarball": baserepos + ["meta-openembedded", "meta-virtualization"],
     "default": baserepos
 }
 
@@ -159,7 +160,8 @@ builders_others = [
     "oe-selftest-ubuntu", "oe-selftest-centos", "oe-selftest-opensuse",
     "non-gpl3",
     "meta-webosose",
-    "meta-qcom"
+    "meta-qcom",
+    "vcontainer-tarball"
 ] + old_arch_full
 
 subbuilders = list(set(trigger_builders_wait_quick + trigger_builders_wait_full + trigger_builders_wait_perf + builders_others))
@@ -325,4 +327,6 @@ builder_tags = {
 
     "metrics": ["metrics"],
     "metrics-gitstats": ["metrics"],
+
+    "vcontainer-tarball": ["containers"],
 }
-- 
2.43.0


