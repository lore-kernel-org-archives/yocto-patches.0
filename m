Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA60EC7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 20:27:10 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web10.5229.1750710423649631261
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Jun 2025 13:27:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Coz0LAyc;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e64b430daso45470587b3.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Jun 2025 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750710423; x=1751315223; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nxpddIeK+WPYP2HzaFRz2SRRZGGAQKdy2atZbaqZQI=;
        b=Coz0LAycToSlh6wJMgbajc0hOVb6Pzl0HCbzTRmfz/FDhMToDUQidQGjJeE2Q597lV
         Hn6LCC5yRsZmhf8NhI/0nsD4WfMPKBn80lXa7QF2BBWjuXbDknXu2dMaMz5wu8Pqzemq
         ORuH16OKdhjsbn1yB2GaRx7OClkIQDQk2lLOHFgvuzypgz1eQC6eSj2vr/3MtROipwFf
         XmaEHrSlmgokZgT9BMOhk3PotHnIrrABdr9Jbsk+3g9cWT6RcArzfuFp69lP3oQXr9hE
         eeJjwfl49B/Af9DDEHvfZHEVUBjsXw+Wo8N5TtLtH6Q0uVfnt+n/X3NU54ep2ne+Nf5L
         6trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750710423; x=1751315223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nxpddIeK+WPYP2HzaFRz2SRRZGGAQKdy2atZbaqZQI=;
        b=k5qz8u/pe/X56ne5+m26bnNXLjN/fBgT7G/nq4gnjDjE4LG2PGjL6F429Sy62u+Wp5
         ENI8WcsBmPN3EjzBtyw5nKpoUd42gnc3KYI0y3a/hp46Fiow+AMYu+TVOwZCH3uYSp2V
         Q7bhZwmaXe9ed5P0+fRnWlhP6ruAZ/pIU7cZqVQyUJA7zbvJwT51K2ZrKNxbVimF24hF
         mEuHy7FOMfkvLbxv/GgjofOc5vkUL/lA/tdDs3xp3f0ZtmK/cNGIXCg68mgqe5tcQ8dZ
         8yn5f6rzipR4pmYfjJPopxp6vGwXklvBkUX4LUJOdr8gfyIGr3hmECe0vVzMJFPyJ2AL
         NWxg==
X-Gm-Message-State: AOJu0YyaHA6UNtgvM3gLWrpUIgBW9eeyJAQT8cXF6odqCtf7mO19gxQA
	XIUyFGNNQAwkZeQBwyjd+DnVjzzLE4MB6ghLcrl7resNM6/wVjdZP5pfEdELEhBu
X-Gm-Gg: ASbGncu1m34wVuEgDlxEZ+D/cnyX2uXFmgvM1PZGGUu48vc4LQM8MRycn9Nl90Qa95X
	/dAt+tpM7gh+Dvh06a4Qrt1xm0BVyPA1my1LH/uuQ0vt45iCzgvtonQgXs53VZTyeS35X6qzd4m
	4qto0Owr8RKcb3ro5HnyvjGeqFTZ0cdfiIYzeAQxTsf+31lZ0Ftd/sP0mbw5sfDm6r3KjVVvwZ0
	Aqj7yakwThzJAVe7zj8s/R5xgF68gKBsmIn1YoHI7HtAjlb6+eKvPi6LmNvaEH0DKzhttl7JoTW
	JZF+JUhKCa7AHb2YWtbcBuNlmFums7U9TqHveWS87x9dtoEYBh2c+FqecRmFu/OTlPuaGRPAUIj
	L/t0Sy00gKLA=
X-Google-Smtp-Source: AGHT+IG8EwJ39F+dO5597sLbKDR6R/EDc8lHoEwFvHSUrK16ORO0WBkiOO7xhh0XGfZ6XYxVpE7wSg==
X-Received: by 2002:a05:690c:67c7:b0:70e:1ef7:6eff with SMTP id 00721157ae682-712c6312706mr208168537b3.3.1750710422668;
        Mon, 23 Jun 2025 13:27:02 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:e6c8:e7b0:d1b0:fa65])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712d93f990csm11142037b3.50.2025.06.23.13.27.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 13:27:02 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/1] Remove self as Maintainer
Date: Mon, 23 Jun 2025 16:16:46 -0400
Message-ID: <20250623202701.12590-2-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623202701.12590-1-akuster808@gmail.com>
References: <20250623202701.12590-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Jun 2025 20:27:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1679

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 README.md                | 2 +-
 meta-hardening/README.md | 2 +-
 meta-integrity/README.md | 2 +-
 meta-parsec/README.md    | 1 -
 meta-tpm/README.md       | 2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/README.md b/README.md
index 76403f0..a8b9f33 100644
--- a/README.md
+++ b/README.md
@@ -88,7 +88,7 @@ Now you can just do 'git send-email origin/master' to send all local patches.
 
 For pull requests, please use create-pull-request and send-pull-request. 
 
-Maintainers:    Armin Kuster <akuster808@gmail.com>
+Maintainers:    Open
 
 
 License
diff --git a/meta-hardening/README.md b/meta-hardening/README.md
index cc39ca4..a62782c 100644
--- a/meta-hardening/README.md
+++ b/meta-hardening/README.md
@@ -76,7 +76,7 @@ $ git config format.subjectPrefix meta-hardening][PATCH
 
 Now you can just do 'git send-email origin/master' to send all local patches.
 
-Maintainers:  Armin Kuster <akuster808@gmail.com>
+Maintainers:  Open
 
 License
 =======
diff --git a/meta-integrity/README.md b/meta-integrity/README.md
index 79635a0..293ea56 100644
--- a/meta-integrity/README.md
+++ b/meta-integrity/README.md
@@ -45,7 +45,7 @@ yocto-patches@yoctoproject.org mailing list. When submitting patches that way,
 make sure to copy the maintainer and add a "[meta-integrity]"
 prefix to the subject of the mails.
 
-Maintainer: Armin Kuster <akuster808@gmail.com>
+Maintainer: Open
 
 
 Table of Contents
diff --git a/meta-parsec/README.md b/meta-parsec/README.md
index 785c932..9dea718 100644
--- a/meta-parsec/README.md
+++ b/meta-parsec/README.md
@@ -257,7 +257,6 @@ $ git config format.subjectPrefix meta-parsec][PATCH
 Now you can just do 'git send-email origin/master' to send all local patches.
 
 Maintainers:    Anton Antonov <Anton.Antonov@arm.com>
-                Armin Kuster <akuster808@gmail.com>
 
 
 License
diff --git a/meta-tpm/README.md b/meta-tpm/README.md
index 983c753..1d34f05 100644
--- a/meta-tpm/README.md
+++ b/meta-tpm/README.md
@@ -69,7 +69,7 @@ $ git config format.subjectPrefix meta-security][PATCH
 
 Now you can just do 'git send-email origin/master' to send all local patches.
 
-Maintainers:    Armin Kuster <akuster808@gmail.com>
+Maintainers:    
 
 
 License
-- 
2.43.0


