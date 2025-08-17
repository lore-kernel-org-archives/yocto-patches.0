Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17272CA0EDC
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 21:08:23 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web11.60906.1755464895058193604
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 14:08:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FHPXS8c+;
 spf=pass (domain: konsulko.com, ip: 209.85.160.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109bcceb9so43291581cf.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755464894; x=1756069694; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJOI/cuiX62UH61oYe3T1KaZsu34snUNWqf+ckIKaSA=;
        b=FHPXS8c+OeNmhACqReGQ1Ia9U7ECZ1418mr6QWXeRtGjGq9bqpqK7EsJCOCjeA5zsg
         toGYulTQjqbL1uOaLc+2974B1XdvKPESqrJHml8FkgU0QwYMcFmc2veu1GG7JCmy6I4W
         Z0eksAMjCn/b0j6FAigZbzBxCnH4tn0rr+Hhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755464894; x=1756069694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJOI/cuiX62UH61oYe3T1KaZsu34snUNWqf+ckIKaSA=;
        b=kW3YZsgh4haTxLqb/KjOE4nSuSfeh/c7MoFndtgz/beu0gQLYnNeeTKVpeNODpUSYR
         w4EGS4ARnLN6Eihdh714l1sZgQA75OktUZzQsOCrkAolc3ESmjYTpahY7NOLaicnbZyB
         CEEExkLGNlAEx/6cUCqBomrE2QnGNy9NqPh5g+5P6MS8iNhdKekuMgs0V4LJyyM1ezQC
         Sj9WzurAN71lpab7yHNa2RPh5GhBS+CeqDhEx9OhnN5/mKVIx366ZB+FxX5NWn9WfSx8
         4heglBrqkfa2gk5Jp1KGQAfSK7SSg+K2gSPO2RPBklyW+/b0U+y5GUslfs6ezfziC3rf
         4wAA==
X-Gm-Message-State: AOJu0Yw8fFSTl3vFPS+ht96rRy11aAwyDlaI6pXovnaAar3Kg0i1eyaL
	yiB4H+5kUGAAZO3zyFqsAt2ON1eD+hjLNipyH64nQyq1WCGP007xPAZsZ81v3JJlCRPSMX9bx13
	XoV8T
X-Gm-Gg: ASbGncuu81Y764REU7CHmwL4Uleq82PKB5ccX5mLSLBcVmN9uuxMW6n10vD8yIThYXu
	68CYJjsqw0XOlDC2PUVC3UKvsSgP6YPmnEuSIkqiWBOULE1uEInG8uSvLGPU0GVH2fDjUeVSaya
	ggPmYLAvRix7LU0JAOEgJHGb9bnCk7jNXgNJ4t4zeNSGJr3JW+8bcjURlRRCVVYA9UHFN5GBYGF
	BCYCsl4/qToOIKH5iPEqUT+n+WBeFq+NHB+Fdsnq03vomsLnWsDa9+Qf+sZhMe9zFqpm7XhFEOQ
	GrxJMbF/JQOWmQVGB1bDq54kxwpkV6rXilZ4G0T69JHTmEH0XLfRK5jF2LPz8Uc5YTIhQDk3kzl
	Dzqe8dyEvDbJe0ZbUfy3/ibh3veMIx95OiuBuyVN8/7YJRyvfsVjQm9pmdqc1ieXdQ/5OrMq/c+
	QzmDboCutg
X-Google-Smtp-Source: AGHT+IEzt14DFzA2xwnJ+Gna3A/BuHUiIMhkUH+l6Uy6KAJfSwH2A0GW5LvBg41ZeQCApswTYpzLFQ==
X-Received: by 2002:a05:622a:5e1b:b0:4b1:2457:5aa2 with SMTP id d75a77b69052e-4b124575d14mr60731491cf.59.1755464893819;
        Sun, 17 Aug 2025 14:08:13 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb0f4sm42215661cf.38.2025.08.17.14.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 14:08:13 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][walnascar][PATCH 4/7] gitlab-ci.yml: fix file redirection for qemux86 build logs
Date: Sun, 17 Aug 2025 17:07:56 -0400
Message-ID: <9947033c9268678ea716752d5893a4f8e49b3ca3.1755464538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755464538.git.scott.murray@konsulko.com>
References: <cover.1755464538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 21:08:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2027

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 628b0e6..80b2dfd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -59,7 +59,7 @@ qemux86:
   extends: .base
   script:
   - kas shell kas/$CI_JOB_NAME.yml  -c "bitbake -k security-build-image integrity-image-minimal" 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_security_image.txt
-  - kas build --target harden-image-minimal kas/$CI_JOB_NAME-harden.yml 2>&1 | tee CI_PROJECT_DIR/log/qemux86_harden_image.txt
+  - kas build --target harden-image-minimal kas/$CI_JOB_NAME-harden.yml 2>&1 | tee $CI_PROJECT_DIR/log/qemux86_harden_image.txt
 
 qemux86-musl:
   extends: .musl
-- 
2.39.5


