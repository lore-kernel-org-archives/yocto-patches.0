Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1748C43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 13:13:42 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44825.1782911621353107219
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 06:13:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AVlUbanw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-472055b0efaso413194f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782911619; x=1783516419; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkUWwxUNRvxsnC+n183QLGxO6VkJqiffdg6soptPVHM=;
        b=AVlUbanwdG+QpiteIQLhVQhtmDZnRN0pKnyauGlYGPWJGBZR+aUAPymM/92XBTNkIs
         t4tNPbv2uxwXy30Xy8rG7KUrtKGxZ+baBdHbPcohkZ0I+jyhkX6Iwdxik4ZBAh59fRAE
         KAhp/S3m7WR2OtVG4QtmWZ/3l4EqnaCE5Kftk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911619; x=1783516419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CkUWwxUNRvxsnC+n183QLGxO6VkJqiffdg6soptPVHM=;
        b=orQ/lpTGDOPdjH6cQHrPx8ft93oxnULDVIEyHHlj1ByjV4qowjb9AZZJYIA+p9sN/+
         E+CZk3KFGQf/Vs/zNi3JCzrXhihGHZ0cbzU5Dd33UajKCEcdD4ABWkTfF92PdGlzTfcu
         QsAs0HfxtwvETf5LUSvqRfSjLjYyzUjm6JUlMZgRYysraOME27eTOYUS+7uWsuKxflBM
         pXxedHCxx2a2sHVgO428P0bl5eap7xZl3qVlLLa6JMKeayldpO2NFxrehfOd/YDRbRHJ
         JIaT7Q0F1dwGt3OZzxBuZVIH7XXxeXZga6839QxswaIrbso5TW32VLlTwJ+Ko7FtzCZ5
         l2tw==
X-Gm-Message-State: AOJu0YwGINE1R+Fk9FU2xGdpXjGoVcfo8IW0UPUhkEfGL6IPAXq8HJft
	xRhifoLI3XByC73BjunufQL8QpQN+dx5kGeX8LxI8FK9Eo2ToBf0XYKW9of2jGTJQNZtVvuHtG/
	mYbxQ
X-Gm-Gg: AfdE7cn1++hWkj0+YC4Gx7BEz9CzswMe9AMqsqhFEqnTe8JFUgw09cqpNM+jM7LEsv1
	FY3R1aAQUteRphHLAqhkYlbc3Vkh1mxHX+Mu4H1Ynobn44g9ldVuhO/9SKfNEEHOapGMlbdbrMb
	szo2Bk4SwRH9NnP8y8++/L9bCVHw+A3wsCu2ouqunC1Viu6psqX0SBc1VpHBf0l6Qiaq95Sf5mQ
	iP9p0aYmViw6QSLCBtJ5zswGxA73viLndMi8dui+H2rLd5L8q5OehiDIOmk2FQuKsVzcAuqOr/4
	jj2/5JFB6p4HeS/4442gRbnfj++hsTjnCBDPnqySM5BR0h3ES1ebK/WPDfL6QOgzJoIYJPtIRez
	bHJJ9al45HiFjY+6MFbIyQEckInbv3rFsG0V+8Zye6Sdrw5775xj1/QmhHwmf82JhZD+QIUrHCX
	PHN6CiEbqYUiLENd1tk1swYJp2dbR76Y2Fxzzp2hE6Vw==
X-Received: by 2002:a05:6000:1847:b0:475:e3fe:8ac3 with SMTP id ffacd0b85a97d-477574b037dmr2864476f8f.8.1782911619574;
        Wed, 01 Jul 2026 06:13:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6b3f:20f2:ee05:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567884770sm17568280f8f.33.2026.07.01.06.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:13:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 2/7] pseudo_util: Avoid accidental free calls for without_libpseudo()
Date: Wed,  1 Jul 2026 14:13:31 +0100
Message-ID: <20260701131336.3578279-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
References: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 13:13:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4344

We need to return list after the strdup otherwise the caller doesn't
know whether to free the return value or not.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 pseudo_util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index 2b0cc04..9cafad6 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -336,13 +336,13 @@ without_libpseudo(char *list) {
 	if (list[0] == '=' || list[0] == PSEUDO_LINKPATH_SEPARATOR[0])
 		skip_start = 1;
 
-	if ((*real_regexec)(&libpseudo_regex, list, 1, pmatch, 0)) {
-		return list;
-	}
 	list = strdup(list);
 	if (!list) {
 		pseudo_diag("Couldn't allocate memory to remove libpseudo from environment.\n");
 	}
+	if ((*real_regexec)(&libpseudo_regex, list, 1, pmatch, 0)) {
+		return list;
+	}
 	while (list && !(*real_regexec)(&libpseudo_regex, list, 1, pmatch, 0)) {
 		char *start = list + pmatch[0].rm_so;
 		char *end = list + pmatch[0].rm_eo;

