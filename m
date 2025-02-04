Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81353C02196
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 15:24:48 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.118987.1738682678369028411
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Feb 2025 07:24:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Le+Pc1wV;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2975745f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Feb 2025 07:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738682677; x=1739287477; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJJDBg3gVxo/aK+WaqOb/4Nx5GPpVic/6bYWeXYjb7s=;
        b=Le+Pc1wVYVfAw1bQNnJwemxwCuqfnGL3uknkWpiF+wtuOf9XESwoFuzzgthChZknqS
         KbTqeulpdIYvaGCAvZIuat2RLiO2qphIXbLeXoflZEZgz3jSfO4Z/Z3HuBEsgsW6ilvJ
         QuS7LMCAufrnjkL7PZxcBzleqrgHteB/kHA3uNOGz8kqEm5bxfJsa1qOKxZzQRIADJar
         totbc1VMlbyrRSQ3Zaijx1/M9Q8EI40xzitGoMHL42L7AvqpRuH+nEU9cnTx/1pd7isM
         sLIaBys7xCOXnSErC5VOWaMML5+WGqbDGBJmWPSRT/OVEDlgI8w34j7zROvjMOHo+kHj
         WyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738682677; x=1739287477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJJDBg3gVxo/aK+WaqOb/4Nx5GPpVic/6bYWeXYjb7s=;
        b=rQNl4JX/2Fwd+tQGwynXmab4na2f7thaYRDQ4cR21qiBMB54AcZatERGF26dXW6IXh
         dZEEaf8cjN68T6kulJn7qma9fq1uKkrCyp9K3IkN3b1biQn89p8nunvf7DAMWCaQBJh8
         fB21ewAWk/PMyck8OMJyb8NXmeg3PtJXWrfXxxaJX+hyCGcs4JotSKCYtWd8tBnsZeXH
         73vzttLIDSwr5sluU3FfO2viCxC/8aDHcoqWY8AwfM+R9G5ywWYZGJnldjX9+VyvrOBd
         5JQpfCFmhBlVcWqn1IhZYsqdpfQ3WgcMc90uHZZw0CgcMJHTIGbyP7Rnj9BhFiaCzhTf
         ruiA==
X-Gm-Message-State: AOJu0YysL/pysgkBtxggGp61K3cegbii7LaSoMjtszxP0KBNrWn/Gegv
	Ma4SPkWfLl0RDqEBs94/JXAVgfZ+0WfhMQphS6lgdiHaKBch6iMM4xsbZQ==
X-Gm-Gg: ASbGncu6BswS5Ow5GlUhMYSMPPXJYKk00o9VLvKrstqoNygUCyFStZ7iFK0jugGbAiU
	LgfL+Wtrm5eDVjoWnn8gZTEDcoG2m1/xNGDExPnZHPnQ3JY7uFT87vLD5pA+Q88o2+PSCQ5925C
	nO/ixs49yTOXBXDHWw3vor5EAkzp4+lS+qBbm5uci3R06f9WvYn+2b2H62KO4lF8YoeqDB8st75
	rexSgD10KK3tW4wM+WNc2F4waf0zk0swOIOJKvn1CLyzh8dplBacOWmQ+flpwKbME6seS9xuJvs
	H6bVEMszyD2yymuuur5Fv7X721uCoqDJLyXkrZMcEXdqLOJ5
X-Google-Smtp-Source: AGHT+IFNaaczsg862V/XgnDLyalZD6H9Y2DFEJkhU/CkfSb7kqYpxiekh/m9603X1f5ShFT2iJl0zQ==
X-Received: by 2002:a05:6000:1a41:b0:38c:1281:260d with SMTP id ffacd0b85a97d-38c51b5ee9fmr15279879f8f.31.1738682676414;
        Tue, 04 Feb 2025 07:24:36 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-438e23de2d6sm191500075e9.11.2025.02.04.07.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 07:24:35 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][kirkstone][PATCH 3/3] MAINTAINERS.md: fix e-mail address
Date: Tue,  4 Feb 2025 16:24:28 +0100
Message-ID: <20250204152428.3550416-3-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204152428.3550416-1-martin.jansa@gmail.com>
References: <20250204152428.3550416-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Feb 2025 15:24:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1028

yocto@yoctoproject.org doesn't exist and yocto-patches is probably better than
yocto@lists.yoctoproject.org

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 MAINTAINERS.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS.md b/MAINTAINERS.md
index 09a0cef..e049457 100644
--- a/MAINTAINERS.md
+++ b/MAINTAINERS.md
@@ -20,7 +20,7 @@ When sending patches please take a look at the contribution guide available
 here: https://wiki.yoctoproject.org/wiki/Contribution_Guidelines
 
 example:
-git send-email -1 -M --to yocto@yoctoproject.org  --subject-prefix=meta-tensorflow][PATCH
+git send-email -1 -M --to yocto-patches@lists.yoctoproject.org  --subject-prefix=meta-tensorflow][PATCH
 ```
 
 ### 2. Github
-- 
2.48.1


