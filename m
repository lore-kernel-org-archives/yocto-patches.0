Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04802CCD1A4
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:45 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web11.1671.1760649756731635805
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ahHfnDkV;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-79599d65f75so15836386d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649755; x=1761254555; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhNNaoYV8MwPr/5+HXNLB/pTl5tHhfVNHE/XSMYdB0Q=;
        b=ahHfnDkVx0mA8gp0+j/wzTroYNlAezwCdZV53VbIPXWYP+HxWI4KcK4zXPNIZg+hQE
         nuejUT2pJXqD24sjiz2ntFY61HE2dcPcoirSHi+Zhza8e7yYHftuR8KtvM9TNxd4RiQk
         lq7UvHfMPuZcWy6y4qChE+u5SUHCpoTq3N/M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649755; x=1761254555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhNNaoYV8MwPr/5+HXNLB/pTl5tHhfVNHE/XSMYdB0Q=;
        b=h120g2r9uKHUNLDvjrnpsh+jspNpV4GRtsSA4RJaTJ1ovuqyv4lD5InagKShBXAEFI
         0tbuD2BLrJghEweFPsABa8ua/sCcgcKaiPAV3ktYSGtI5LQgFMxGjVyQNcfLt1DdaTsn
         XAAA2g3vT1W38Wf158QorwmgEM0PxD6pvKqL23SQhNgJV+QIOM/JXSyLBsrOojWkpg+h
         NGKkBYZEUWGKPD48niMF76O/LP5YZd4AaJt/BbL2vfOOhhgkYvX+aPP4pKHzZf8+ObNe
         rLZthHCzesjnH0fn3eea50haXbqRTCiOm6iWPOhdMxdJf5tDl2PMmRNyR4j8iZit/ZZR
         uf9A==
X-Gm-Message-State: AOJu0Yx1+jHki/JdkYlvPs0VvxKt3S6p//gJLzW+ZCVPkMvMwJTVi39O
	UqewfExvx7jnQVbML/kfsFRfwXJv6YFP4SzVZcpsLtHtGMMfeS/UBCi29q2PQpLyGzKlx3ZC+EL
	ciFsw
X-Gm-Gg: ASbGncsPDx58MNjQbHFSTWPB55mTqjtvihVRJOE6MF2DvKK+/7E++Mg07xMrAmr4ZuA
	tnrXdRikAXVhzB4ICWzkJKHyNGrkmgggvkZqvKZMIyNbyAs2wohsbEE/CjkHvXPYO2VEvyxHanf
	eeAEAwRvYsOqGtnPPLRuD6YKU7DF8pnIDRZ1VWdasAy011DFCIH65tzHInm08vn2n2o49dH3Ip1
	1d8ai0T74DN1Ww/Cd7amhOs5f6pDJbc3QOor55/gtvF1RWbebckZoHvZ1kwp0jwoHTMmAKoykBW
	OcaJVmAAUfsXmYYTrIJAyvxCCGQdHrJaKZezbOoO3+egPHZqkIQP+obA9HswNBtyM66p5KWMRRe
	FpluWXgZDjPWVVp59OE4oLMODCXj/8nQbasDUOaRWYAelP/w4xTe3CH644DoFXXPLmYVumvvNdj
	fQteAfU6FBiyTwRS4YxwkI818wcIqWlPEmlpvGbrnvY0HuzyVPddHtx3GE+p6h914=
X-Google-Smtp-Source: AGHT+IGEj0lI0b4GyUUyBkQwxis8HlYqNyH2/dbHmgWoBDSXTvU5QF10FlH7uokVnZvxWl5qnX4pRg==
X-Received: by 2002:a05:6214:124f:b0:804:9cab:926d with SMTP id 6a1803df08f44-87c206339b3mr20849736d6.37.1760649755298;
        Thu, 16 Oct 2025 14:22:35 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:34 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 04/15] chipsec: disable until 6.16 support is fixed
Date: Thu, 16 Oct 2025 17:22:03 -0400
Message-ID: <d183c4cc6483a56f622a7d1ae7b61bf299dac255.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2329

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

The 1.13.16 version does not work on the kernel 6.16 for now [1].

Disable when waiting for the fix.

[1] https://github.com/chipsec/chipsec/issues/2563

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 recipes-core/packagegroup/packagegroup-core-security.bb | 4 ++--
 recipes-security/chipsec/chipsec_1.13.16.bb             | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/recipes-core/packagegroup/packagegroup-core-security.bb
index bda78ce..3f5b0a5 100644
--- a/recipes-core/packagegroup/packagegroup-core-security.bb
+++ b/recipes-core/packagegroup/packagegroup-core-security.bb
@@ -46,8 +46,8 @@ RDEPENDS:packagegroup-security-utils = "\
     "
 
 have_krill =  "${@bb.utils.contains("DISTRO_FEATURES", "pam", "krill", "",d)}"
-RDEPENDS:packagegroup-security-utils:append:x86 = " chipsec ${have_krill}"
-RDEPENDS:packagegroup-security-utils:append:x86-64 = " firejail chipsec ${have_krill}"
+RDEPENDS:packagegroup-security-utils:append:x86 = " ${have_krill}"
+RDEPENDS:packagegroup-security-utils:append:x86-64 = " firejail ${have_krill}"
 RDEPENDS:packagegroup-security-utils:append:aarch64 = " firejail ${have_krill}"
 RDEPENDS:packagegroup-security-utils:remove:libc-musl = "krill firejail"
 
diff --git a/recipes-security/chipsec/chipsec_1.13.16.bb b/recipes-security/chipsec/chipsec_1.13.16.bb
index 5d65e89..9698d8f 100644
--- a/recipes-security/chipsec/chipsec_1.13.16.bb
+++ b/recipes-security/chipsec/chipsec_1.13.16.bb
@@ -34,3 +34,5 @@ FILES:${PN} += "${exec_prefix}"
 
 RDEPENDS:${PN} = "python3 python3-modules"
 INSANE_SKIP:${PN} = "already-stripped"
+
+SKIP_RECIPE[chipsec] ?= "Waiting for upstream support of the kernel 6.16"
-- 
2.51.0


