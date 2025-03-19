Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3B9C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 12:35:41 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.6740.1742387738230441196
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Mar 2025 05:35:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dyOA/ZdZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3965c995151so4397038f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742387736; x=1742992536; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6a/cHufkX4W8NlMbfQqvGQ523jgoeEjFM/c0BDREdxM=;
        b=dyOA/ZdZq4l3hpo5zs8S8LMHTIhyyasqC0RUjZsF90wW8CPNEJWMyNjtKqv7mOCcwD
         ZSORfjlcK3cLzILublaKSmkBXQiSDeWwnScggrzZoS74BFQtVRLZl6VDh4+1BrIeZ4U3
         TxX/RpW5cPp6DORtFPwse3VI0J5v6kbFIJOMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742387736; x=1742992536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6a/cHufkX4W8NlMbfQqvGQ523jgoeEjFM/c0BDREdxM=;
        b=tSICsrDnB7HDWRVcooOeLEPusPXSpddx7PkKInOogsvT6gvzhyL6yf1+dyKa5p52v6
         M4zSowAPk87jsI5SE8gurpzXnV5y5FgboJCuY1jjJlmZxewxmvBz1jCPLXVAncy1eFDA
         tdogJ5iGR0ZA1rSWZ4b/w2Wd5vcBlN6xSoqZWVrFy1EQfGY9z93H17Tc8/qwF0YcC4N4
         YxZdFfqbq8LrkwDT9q6y0YlNqLS2jEm6xkKQkFfHpFfh6Tym586ShOgkkB0BzYfkTHfm
         nLPsz02hOVu5/wklaSYM4EbY4LvtYA372p7VqmmCPUPXe+mgyjNdcOSgRLtPgaQzlzMB
         AKGw==
X-Gm-Message-State: AOJu0YytqfpK16TOQJRpiHIrRNE6YXHOnIZh42XWnEbb0MEq/ihaTO8x
	rH+22hYNaU7aS4y5Lm65AAc/yk/jZoHnu28cuqZqf0N6uPjQZesprlzHdyqhta3ifZVJGL/B+zW
	s
X-Gm-Gg: ASbGnct2L+gir3UQdcUO2q93xeh0kuTI9d4UXqj1Psz/z4xEUUazaEnD++9ImfLPSIb
	OGJGkq7KrrluJ/tVsYd31cIMNL+mrUH5nH9Xd5N4Kk9tMTXpxwVx5Ej1lLht/vN2pBwBgSlOXc6
	Ir39v3LB9MAUwEaxHgCPV/BQPNglYPPTflj0G7HZoqItdZhJ4NVRIFpgmgCXwwJuLn6Cq/hfqe1
	E8yMKIIQiiKUCGpG1N3HRT3fPhFDM/F8i1Yew0h7DMUB2IA58TqANBZZXssDnxI/H76xNUu0Bw2
	6HxzKB0pG0/0xgnPAvPGBFoWFCyKbyWFAIA2ScabCErCBCS+YBrlTR6DRxw+sgTRuMNifuc2
X-Google-Smtp-Source: AGHT+IF6/BLrxXdvl4/zjka135rBrbXCM68Uj9MAzfvWV0FhF/HPAC/eUyCbx6a3TsW4dJ2o7J+diw==
X-Received: by 2002:a5d:6d86:0:b0:38f:6287:6474 with SMTP id ffacd0b85a97d-399739bc74fmr2644290f8f.15.1742387735982;
        Wed, 19 Mar 2025 05:35:35 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dad:b471:9c34:4577])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c4f9d59dsm20929419f8f.0.2025.03.19.05.35.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:35:35 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [libmatchbox] [PATCH 2/2] README: Document where/how to send patches
Date: Wed, 19 Mar 2025 12:35:24 +0000
Message-ID: <20250319123532.642335-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250319123532.642335-1-richard.purdie@linuxfoundation.org>
References: <20250319123532.642335-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 12:35:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1220

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 README | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/README b/README
index 83ea0f3..0cdaaf3 100644
--- a/README
+++ b/README
@@ -9,3 +9,14 @@ git://git.yoctoproject.org/libmatchbox
 
 Issues can be files at:
 https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Matchbox
+
+Contributing
+============
+To contribute to this layer you should submit the patches for review to the
+mailing list (yocto-patches@lists.yoctoproject.org).
+
+When creating patches, please use something like:
+    git format-patch -M -s --subject-prefix='libmatchbox][PATCH' origin
+
+When sending patches, please use something like:
+    git send-email --to yocto-patches@lists.yoctoproject.org <generated patch>

