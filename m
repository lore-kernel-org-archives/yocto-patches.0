Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24389C369A8
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 13:48:01 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.34583.1744292878933535790
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 06:47:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=GCVoYaAH;
 spf=pass (domain: snapchat.com, ip: 209.85.221.43, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f2f391864so449658f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1744292877; x=1744897677; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dI9ylLYKb8gUV6YfW0No8/VyDjLA+q0BTSD5qAzuCY=;
        b=GCVoYaAHXXl1C+Ta5OvZfr3Ju0rsVnQArqH9dGXjkbujcQGYrWQ6n2qX2R67EZbJa8
         NwprbWnkucjpoU5EnTW83dhnJPSLMSha56NlgaAPn8MAMjGJ3rpqBtAuKUX88ki8kYBX
         zlPHj6tKFHUq1SIdwUfsxtCLYh/rYa6yB52p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292877; x=1744897677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dI9ylLYKb8gUV6YfW0No8/VyDjLA+q0BTSD5qAzuCY=;
        b=LXo7qPgiCukVvsiOqiWAVRMnojVm2bIAahw9qWLCzC3/D+ItRx8YJLv10M+UXgoG4d
         Sy00oM8KdSr7Eunvym1SrO3rcy983FLaozcGStuFV3fpflHLxjFwTRzziG8QXJyeQisx
         S/uKt6/0Q2yiEpu7gATa65/bWg3+qJXO1r3pggfxrlHegFHSJSSHHwIHpbxQyCRgSHOx
         PBfAIhnkCCKL0syKZpBdJnMZxKhAVIjY6pKNjEzEzz3fV2D4SP/2FAF/o+tx6f1QVnZp
         x6POseAuGRlkwzrJi06D8TT9bQJw2ztLcz+WdQBU7M+kPuXvvEiEi+JkrHVMh4ecvVOq
         5DyQ==
X-Gm-Message-State: AOJu0YxAlV1gnWxpYr6x8WZAjLGlPT9a2Rde0DwbyUDf7s9pCiCmN7+p
	mrYQ94P4LhBBQ/x30g6aFwr4VqcAnERNOszXu9KQqlkmk/OqMC5SvCw5AGn/EP27UeC8DKDCPe0
	hey0=
X-Gm-Gg: ASbGncuMLPYU4J0QQLtImdDrJ4DHE44tILiCjiQ5FEShLtryA26WalkM7gBWjH7676f
	CcaLT0eRyFYnt6Shu8/FB3Os+qVEmEqI4do19Rr33U7qiJHU24Vo+Q5G3iiA/ZJ/NO3AReuX9PA
	4KF5osC7wd+VMpy8uRpVjPNgW7h4lE3d6H8tbZi3Qe66cXnAWvHuk1wADNXnQkn0wLTlGa71zE9
	zliMyQWZAF33SpyOB0IlUoicxmdTweNHm/5qg39T7c4QIOf2CclxW/VBQlMvcId0UU3c1fQj0HV
	58tYUan3jBP48O5z9ENVR3YdCeO1NM01nERlJ+38PVwleaJpS4kSq6PkcYvm8DIiIg0I6965etr
	vC4RL1vBfPGoOdmXVB5wNuVh5AIj6og==
X-Google-Smtp-Source: AGHT+IGEDOTHLNtzqko4FC8ky2JMkwr6wbgRGNtGA3V7E6RrgoT65GrLeFYJr2G6IZ6CMzepgkN0fQ==
X-Received: by 2002:a05:6000:220f:b0:391:23de:b19a with SMTP id ffacd0b85a97d-39d8fd5263emr2155066f8f.31.1744292876690;
        Thu, 10 Apr 2025 06:47:56 -0700 (PDT)
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89378daasm4886996f8f.38.2025.04.10.06.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:47:56 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dominik Schnitzer <dominik@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 3/4] xar: update to 5fa4675419
Date: Thu, 10 Apr 2025 15:45:09 +0200
Message-ID: <20250410134510.17001-3-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410134510.17001-1-ecordonnier@snap.com>
References: <20250410134510.17001-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 13:48:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1350

From: Dominik Schnitzer <dominik@snap.com>

Signed-off-by: Dominik Schnitzer <dominik@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-devtools/xar/xar_git.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/xar/xar_git.bb b/recipes-devtools/xar/xar_git.bb
index 575ac36..19930b5 100644
--- a/recipes-devtools/xar/xar_git.bb
+++ b/recipes-devtools/xar/xar_git.bb
@@ -3,7 +3,7 @@ HOMEPAGE = "https://github.com/tpoechtrager/xar"
 LICENSE = "BSD-3-Clause"
 SECTION = "devel"
 
-SRCREV = "2b9a4ab7003f1db8c54da4fea55fcbb424fdecb0"
+SRCREV = "5fa4675419cfec60ac19a9c7f7c2d0e7c831a497"
 SRC_URI = " \
     git://github.com/tpoechtrager/xar.git;branch=master;protocol=https \
     file://0001-fix-compilation-error.patch \
-- 
2.43.0


