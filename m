Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8323C88E5A
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:15:30 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48493.1789157726368568893
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:15:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=j1s8qD8v;
 spf=pass (domain: konsulko.com, ip: 209.85.219.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90e7c71f86eso10394656d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157725; x=1789762525; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xjw98cBXr4Spwat0QK5ITNPpY9uDEqLDqNz99HZnnNY=;
        b=j1s8qD8vHSBnkWdT8bOpi0SqAV38Nn/BrhY56H8AQPTRcDIm7lFo0ZkrxajncL7C1m
         uOrrIguOnNE8+SiKgONst0VPCgVyPPwFdUBJ0zkCA7iRZdfuVbtq0NmYpMfuZKGemSqY
         +3oB6KoTcAijoIJav+Ch9w64yV0WwOO/oJdTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157725; x=1789762525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xjw98cBXr4Spwat0QK5ITNPpY9uDEqLDqNz99HZnnNY=;
        b=qi/Mlb2vdNPsZnWCRsjeO3q+I6zX3o0qhaPBuwA07j1pCjBJf0ef/qkQPtBvwM3jMl
         U54XBTx3qGHnrLK+6tkjgyqYU805HIiVdAYo79wrRr8MmkvLVo9usqkTWxX+md1CG80S
         91IsQqrTOUKkuE7mz+jdQ/DqNxrN8GmW6w/oJ/Za9xEpPXaoeZgQyTJp7RrguLHmZyXn
         i6DKcQ7DRInH63YnciSNAUAw6fXkDtePtR/KWJcevXTC4WETWn1BUiJdVNBoY8Lkr84z
         jXm1/e3oUviaGjHyvP49l/sNQ90RU76V2XXMQhU8jWFlI0S3mf5jCIdW3H9HNcAlcDkB
         NbUw==
X-Gm-Message-State: AFuF++lgJBl/RrIJwMVazJ4J5YN6A4IPQiXUDeu+HZra8J2iM+dGHgc7
	c60JqZEoY6M4oc19kD4c0HIrtUfvRYVueg8RxcAARYh67zpfQ0/DW8B6NBOfMwjlVOO9wV7YEBO
	/mIG1
X-Gm-Gg: AYBFou0AjHV4igck5Jyt7H9Hp+vWe6Qx3akssfWB//kMUu6/uSygrWqll5376F4hDwC
	4l4F7yWK/v97F9ySrElQMSR53ojBnfEtbRRJj457t8SqIT6demNEcOvHlzsBTLKfkzXtOLw/V7K
	RBvFYphoT7fcT2r9Bc6qch6u84SMyHKGmohX/7iAUt6/JKuUnceIMtyw6LH5w2YZU/e+v9kR48D
	hL2U66oeRGRMjHTnaHI3HaS+CBnq32P6eJBABDc1a/0PKmKxy30sxVOQcr1fOJB22bzgJCgTW99
	bg/QasCqwvy/lek+7k3QF0hjANle7K0u8i3f2WcIjVJ9jeb2RH8iyHiymARK6LrkV+jWDrpLzMs
	+vHILtaHSd9Kw4qC7Aor22Bgul+3QKMZGRnciQxmBVL7bJZyd1GNHgixzzVj+r5ea/jPFqTIXye
	hzVarON1LPATaFFDyYd3TCceXGH9ubE6wiNy3SLGnnDdSf7MkMfIQv/8b929rld/hYV/6bXsnEP
	do5fK2LG+3W0EKuCKsS45tjr8IanZmGcdTVW6ZmabkCfKGdeatN0h2uPwhNq475mdlz4V5t3vbu
	1jWInNIwka3nHdM+j9/EB1JnMnMRObN6wRQ=
X-Received: by 2002:a05:6214:4a05:b0:910:3988:b3b with SMTP id 6a1803df08f44-9121210a899mr86344676d6.36.1789157725065;
        Fri, 11 Sep 2026 13:15:25 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b699bsm28930706d6.37.2026.09.11.13.15.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:15:24 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 04/11] classes-recipe: fix trailing whitespace
Date: Fri, 11 Sep 2026 16:15:08 -0400
Message-ID: <c198ddae86cd5876bb5b46692512046b8283c988.1789155804.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789155804.git.scott.murray@konsulko.com>
References: <cover.1789155804.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:15:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4808

From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>

Fix trailing whitespace in classes-recipe bbclass files to resolve
bitbake parsing warnings.

Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 3aa7dfc7d409194639b52cc3fb7d3f5dcc85b3b6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/ptest-cargo.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes-recipe/ptest-cargo.bbclass b/classes-recipe/ptest-cargo.bbclass
index 2e008b3..62444e9 100644
--- a/classes-recipe/ptest-cargo.bbclass
+++ b/classes-recipe/ptest-cargo.bbclass
@@ -107,7 +107,7 @@ python do_install_ptest_cargo() {
             f.write("#!/bin/sh\n")
         else:
             f.write(f"\necho \"\"\n")
-            f.write(f"echo \"## starting to run rust tests ##\"\n")               
+            f.write(f"echo \"## starting to run rust tests ##\"\n")
         f.write("if [ -z \"$rc\" ]; then rc=0; fi\n")
         for test_path in test_paths:
             script = textwrap.dedent(f"""\
@@ -120,7 +120,7 @@ python do_install_ptest_cargo() {
                 fi
             """)
             f.write(script)
-        
+
         f.write("exit $rc\n")
 
     if not script_exists:
-- 
2.55.0


