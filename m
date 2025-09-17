Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B111CAC598
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 20:43:15 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web10.34519.1758141791052038173
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 13:43:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UWvcsB+3;
 spf=pass (domain: konsulko.com, ip: 209.85.160.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b7a8c428c3so2354881cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1758141789; x=1758746589; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJeLCiaB69fesYzKV0qDENaMLTaCLIaex/1U2GMVkYc=;
        b=UWvcsB+3KsvPOeKvNpdvJDu6qFA54/KpvDnOvjLLfELAzCcD8PMi5qFKGSHl3hGfH3
         UR1u9Rw5ovsMqJCRjJFwhiH2K4lpb/FbG0Qr6R36ieXubdvBPKCLoEe/cSlGwCT4H/Ht
         o1PyWhQxlYDqWoB2buULWgRi50NV+yFXBVrCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141789; x=1758746589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJeLCiaB69fesYzKV0qDENaMLTaCLIaex/1U2GMVkYc=;
        b=SujuiJO+DfRaqrA5ZyP2YrATcT0TGxFnzNuKyJUIP8x16KAF4oCn9ceyi4hq9JRxMv
         6e3DvfBhqwkCf/rr3moIy6KoV5Q8wryz01W/30OFv043btHgANlyJ9W0834vL1DQZLNq
         qTuaNBWWS8t8sqhXy4WrdzfI4NIZgxAexJaelSmO896dmDR1sorhKKGoamc5FaJaW1dF
         BLMAuHwoalPVgTcu7t+AWQvPnK7RxhcrrMd7SPBLCye3HglOfSFG0K8wGPOJfc8bu/eR
         dJp7yITYEKElwajRYWJR34jZGinhYT0hzLx3y8I0xR9CPnYUsAtttOZiqlBn/zp0pzmW
         D3og==
X-Gm-Message-State: AOJu0YyCmwYCiET1NFk52qUKk9pmQ5xggLN4wCzt9HmK/eyjGdPbjv8A
	tLB8AqZ1ngJhuGDBIW1ptXD4AfjEMEs9Dl+FS8vPdbNLzKVWKcZipc5Nr8huveqBhbvnJQ2DHzV
	6FJUm
X-Gm-Gg: ASbGncuA3UFYASzYg6am8Pm8zWaz8yE2Yv4B8NXFgs5dl2H+1JJ9iohDn/Qim0cOd/h
	T0aw7CZoKyVMBy5LLD9owYTs6rBKsJ1L8OQrNW8U5RO2SybGrLlNZGjixcsm+QLxISqH6/xkLmV
	iLs9Xqqu/+o7MSEoDE0XfqMZFcjD8SghMdD/EaVF3i28ondvKhvmdvu7LjbbVz7brqyoVk/QNSL
	bB7DdTKhJKj2a07Yh/AlWFWBdiS1QHWQYVqRBbaOjAK3A7DCGdvZIA11b2gqySHvyV/4L5sfXfg
	UjhNxoxzCug/6ZySp4rukvYPozm6vf7sb3a6EY/Y/iHxMBPwNE6DN0SGEn2mTkfL4we24Ha3t/k
	sJs5DUmgSMSrkPuXeDvYxph04FLL2uYYBD+kb1MAw9UXyHfliW7kLQtkJQqevIb05BmCkLPxh6g
	==
X-Google-Smtp-Source: AGHT+IHXjZ5Qm7BTCfnxUthTrTFInMqcrlJIBCCYiMMn6q/1wnuijUCAyO+KzvnlenoDbIJwi8CL9Q==
X-Received: by 2002:a05:622a:4c19:b0:4b4:8e38:8f96 with SMTP id d75a77b69052e-4ba6d054ceemr39533871cf.83.1758141788710;
        Wed, 17 Sep 2025 13:43:08 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836260ccccasm42991385a.10.2025.09.17.13.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:43:07 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 3/5] tpm2-tss-engine: remove libgcrypt dependency
Date: Wed, 17 Sep 2025 16:42:50 -0400
Message-ID: <dafceb4ba498bb879af041d431655a9134876177.1758138771.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758138771.git.scott.murray@konsulko.com>
References: <cover.1758138771.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 20:43:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2210

From: Patrick Wicki <patrick.wicki@siemens.com>

There is no hint of libgcrypt in the upstream code and distro packages
like Debian and Fedora do not have this dependency either.

Signed-off-by: Patrick Wicki <patrick.wicki@siemens.com>
---
 meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
index af9dec8..6bc44ef 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss-engine/tpm2-tss-engine_1.2.0.bb
@@ -6,7 +6,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=7b3ab643b9ce041de515d1ed092a36d4"
 
 SECTION = "security/tpm"
 
-DEPENDS = "autoconf-archive-native bash-completion libtss2 libgcrypt openssl"
+DEPENDS = "autoconf-archive-native bash-completion libtss2 openssl"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
            file://0001-Configure-Allow-disabling-of-digest-sign-operations.patch \
-- 
2.50.1


