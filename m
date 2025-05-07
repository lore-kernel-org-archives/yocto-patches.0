Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B1FC3ABC0
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 15:05:21 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web10.833.1746630311615587372
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 08:05:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=T1jzq6it;
 spf=pass (domain: linaro.org, ip: 209.85.167.47, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so8735687e87.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746630310; x=1747235110; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jA6lkt1KRdo02m2XZ5DJWDqRu5h0H88R0xDnJxhqX7E=;
        b=T1jzq6it6CLzgLZf/r3J6n7zjT6IwSKRAkqz9beuxFi5ePs4yrJ6brkq1RJHk/c/yX
         SeR+QmTy1CZ38nCLUJ+tNnHb26DIvqAr5/Grs4j8z3PLlryV2zY7+M1wAp3WhRE/oF/G
         fejFpBGqgyKvZ9LrP4YBAuNbdvet7jO7pQza3AxbhT5PShTHMpFu1LLG6Z3cQJc6xRgN
         F9Qen/u2dYnC6Pgm5qtxlK/7gS4hwncpnfhQl/yMuSM2NmNFxmt8Yzr3lvmhaTZLPEQ6
         PZOeRefIpyezMcqSJrezSboV+NWDh+dK9XTbYTJigFH8p7KKS/AxZD4Tt82NmCE7aUfP
         NpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746630310; x=1747235110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jA6lkt1KRdo02m2XZ5DJWDqRu5h0H88R0xDnJxhqX7E=;
        b=wIdV1w9Dc1+7xxxKwLl7Fb4c8xbgCpNgYl8C1aK65xBEiI1Q8Y/CW+62l92QW5RLEE
         /WQQsVUZLxKRuzkYcBRW5LuNHlwfmp9K6Ym6tEabgsxiEmup0zLo/L/mtwb1RTruhb0M
         XnqU99TeEpvVtI+3wbaVW3VH3QndkTvpGnz2Q5P90/uNSj3ihtVe2jV0BDwFxkQUl2JR
         FrMwDM7WolPBf9DvV3W2FGrRtyYTY+34XS1fTK5fiQs5NLJD7xNM20eAyqIez1Ar9dPr
         NUkpIV6FWEF0jN2c6n0zN3hERmib22+RTZBXVwpsClNZthkJRKr2L4FR5dFadqbrZpkX
         cutg==
X-Gm-Message-State: AOJu0YzVDxjbYXozcCf4RS10MiTuWgqoMTRNomr6vOtmJnRZJEGSft/6
	kdlwPIiYtWLbTj91AmoqbdOrRBEWNFUJBN/Dt9Me5X8l22H3BBsr8Tmajj36PRRJB9DuhYJg2Ho
	jhNU=
X-Gm-Gg: ASbGnctdLslZPSurTP+BxBsWBc4qqRSf9z14gO4ostamRiwE/VK7gju17ZeO406lxZh
	xfpHkkvFkym0g9zF+9B5ntME30hD5kZHOLx9FWorQVig3a6+1L6njYvt07FIrUau7XzHOas1fUf
	NWNzCV2npKJS+Jn7I7F7bMxLnNLwKoBgZG5gU47md9hCmxNjSCrwJ+qPRn33BhdaQUy0K2SxZJh
	Zllv1u24vhWj5Hqk2wGJR2Zn3dy8tArFx3QjfVg7X7Cnqc+3P7DKDndNoAPhJF+gY95GnAAirPP
	FbGHRt15uZznds36H2dduDqU3fIq7etUK58rgjpxjkENZZ6RjCOqD5aSwaj4JoqzG/+GFqqnMH/
	S0LV+CLOYd9sQr8G55A==
X-Google-Smtp-Source: AGHT+IF3JOArFuXgISnD4eEJBkC9ySJYd3y8MqH04D1kO1SnK+5F+kQga9BfIVtKm4VERoHK+lKR1A==
X-Received: by 2002:a05:6512:15a8:b0:545:154:52b0 with SMTP id 2adb3069b0e04-54fb9293caemr1400200e87.22.1746630305998;
        Wed, 07 May 2025 08:05:05 -0700 (PDT)
Received: from localhost.localdomain (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94c8ca7sm2367490e87.99.2025.05.07.08.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 08:05:05 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH] swtpm: whitespace fixes
Date: Wed,  7 May 2025 18:04:51 +0300
Message-ID: <20250507150451.1409046-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 15:05:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1530

New bitbake warns about these.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
index 3e58c33..66a9dc3 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
@@ -15,8 +15,8 @@ S = "${WORKDIR}/git"
 PARALLEL_MAKE = ""
 inherit autotools pkgconfig perlnative
 
-TSS_USER="tss"
-TSS_GROUP="tss"
+TSS_USER = "tss"
+TSS_GROUP = "tss"
 
 PACKAGECONFIG ?= "openssl gnutls"
 PACKAGECONFIG += "${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux', '', d)}"
@@ -42,7 +42,7 @@ USERADD_PARAM:${PN} = "--system -g ${TSS_GROUP} --home-dir / \
 PACKAGE_BEFORE_PN = "${PN}-cuse"
 FILES:${PN}-cuse = "${bindir}/swtpm_cuse"
 
-INSANE_SKIP:${PN}   += "dev-so"
+INSANE_SKIP:${PN} += "dev-so"
 
 RDEPENDS:${PN} = "libtpms"
 
-- 
2.43.0


