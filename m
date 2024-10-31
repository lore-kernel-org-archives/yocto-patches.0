Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDFBD767D6
	for <webhook@archiver.kernel.org>; Thu, 31 Oct 2024 14:15:18 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.13520.1730384115911410660
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 31 Oct 2024 07:15:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HpPLVYKi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314c452180so13210765e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 31 Oct 2024 07:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730384114; x=1730988914; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ty2ogSwUTSkUe2Kezo80CjN9yFuRab+33lFNtqXzEbM=;
        b=HpPLVYKi1a3OQqZ4e+vwZWySkgKZ6GjvRGiZUChXQNpC/wAdCmxOKPk/XBRxXvSk14
         yhiDAV0MS3etfATepyIkt2qwApjmlmZDrkNiWITmx/yuiT7D/KWz9iWwN7X80JrBkCAd
         +/rK8V1bkeQL4xxgy7aOhqnebVlxRRyt5UrJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730384114; x=1730988914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ty2ogSwUTSkUe2Kezo80CjN9yFuRab+33lFNtqXzEbM=;
        b=e2yr5BP4JF3v51bwbRykeU8m3Er4u9g/XMWwwZUBX9nwumYIdrrhj0UCgBsrHq0Dp6
         vZFxWvtBUNpERofTDJUVkgswhgqvkVootEEW4Equty1zbH4qapfMMSn/yHbJRAkZ4mT3
         hrNUYB2MHpBDF21KuHqGfCCzUZ3DZYBhqSdcJL1mtOIB3qDJERs578SixxFFuqtmypBZ
         OD032HRcKsAfQsv+RV54E7Znios/ColoYwEy2fUQlcwpC0TbVHgKBcNPPJojocIpVslM
         9eCeV8dQudlQ9+xRL8k51N+Hv/Qv5F/NUwr0U/RClfXf+xyAJj2MQ2TlIq6QJCVnLKUt
         Pi1Q==
X-Gm-Message-State: AOJu0YwK7uzbvBu+sGPhFAqTBuy0MPVRYF/Bv7KIYDgDCc2PhMJvcUDG
	OD93T3CYqOh8NulSql+RLnzQw9QuzvpRYQM5t83Os+NVN8a9w2j7QxG7LpTBSRmo982JJ6KfTk6
	S+tQ=
X-Google-Smtp-Source: AGHT+IHB9i3eQ2ehoxWa5I0ZlFpivxTSnLa/B47D+ACfj/gcfUYOG0phsN3oc6dg1CUGduWO5q3Tjg==
X-Received: by 2002:a05:600c:198d:b0:431:55af:a220 with SMTP id 5b1f17b1804b1-4327dac12d0mr22621905e9.12.1730384113762;
        Thu, 31 Oct 2024 07:15:13 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3ee1:1135:b938:d59c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9180f2sm57248485e9.19.2024.10.31.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 07:15:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: docs@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 1/2] scripts/run-docs-build: Add latexmk to tex install
Date: Thu, 31 Oct 2024 14:15:11 +0000
Message-ID: <20241031141512.544354-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 31 Oct 2024 14:15:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/779

Tweak the tex install command to include latexmk which is needed
by the docs build process.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 4ba759c..bf1d261 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -57,7 +57,7 @@ if [ -e /srv/autobuilder/valkyrie.yocto.io/ ]; then
         zcat < install-tl-unx.tar.gz | tar xf -
         cd install-tl-*/
         ./install-tl --scheme=small --texdir=${textooldir} --no-interaction
-        PATH=$PATH:${textooldir}/bin/x86_64-linux tlmgr install titlesec varwidth tabulary needspace upquote framed capt-of wrapfig fncychap gnu-freefont ctex
+        PATH=$PATH:${textooldir}/bin/x86_64-linux tlmgr install titlesec varwidth tabulary needspace upquote framed capt-of wrapfig fncychap gnu-freefont ctex latexmk
         popd
     fi
     PATH=$PATH:${textooldir}/bin/x86_64-linux

