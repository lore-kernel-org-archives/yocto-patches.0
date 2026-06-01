Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A893CD6E55
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:17:59 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12693.1780355870539389935
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:17:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kxU+C6ZE;
 spf=pass (domain: konsulko.com, ip: 209.85.214.172, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso17946115ad.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355870; x=1780960670; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugriiT63DLL6ZutBEkJw+ZarPJRIX4l1luQHHsxRfx4=;
        b=kxU+C6ZE7QKNkLnc7SBwCHi5FNCBzSdAnrrBK3IQkakapQa3PEVO7RxfesXDQZHkTu
         hgjJw0AKmBCMk5pVF4F0m21S7scB8/7r55QAFcrZxFGufIOHdIjsp/HCdgEGGaVo8I1B
         BWXDo+t7lkFlMX1JrmwMMUNfebJ1ecAjiEC24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355870; x=1780960670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ugriiT63DLL6ZutBEkJw+ZarPJRIX4l1luQHHsxRfx4=;
        b=m0K8VSMmDOaDLaxvVkyeh+p1iC4Q3zwBOlNzMCqnU4jVtoPb5A9jqo0bf08iSahkcX
         u1I/ioUJS7f9Zz/wPcsSEx/8CqcjH/iNxxzUqo+hE/jcjJbCu2gvyJYP9UsTXUu0XeE/
         0RSF09D+hgoxtYuMW8cBgUhBezhqRlPz8ukhnWx9N1Sut9sEOYkVXKybLxshAvkEmW11
         8ahI+fDSqvftEeBRjux0vWhLwOHlkoRUtwj3axy7xksPbpatzmo8SwHnGJhLXtWOsMsS
         CXjHDYmeWVwjlugkhOXGhWyfHLbwUqE0hpzKymOdXPBplbC9EWIx8bin5FnVePSii//t
         M2Ug==
X-Gm-Message-State: AOJu0YyofIeu0hCqyzEFk3mGF3MRXpH8zVoxRMdB8F9CfFc9vMmxeiVN
	uFRtdVVn8xzYpSFpFFlDr/WIAqRJhNejpnsSQqj4SAdcqQvSWkPO3OMXm/ctMfcVZL6doo5bD+n
	S1e9Z
X-Gm-Gg: Acq92OHTuMvPIFR/qmpBJrygokYdCDHmyOCmTfN9fEi9+9id8ZmJ3td0Ix6LmAkSXJK
	hWpMuTmhRHOH5zBVkeZM3GgYU+VtTsqouDTy2LZL557HISOAzZCGd/je/z3LDqUY0olJ+AkUaz4
	UyZXVLdRHT4fzxvrvVeV/REFhBcOwsvUSCDOQNInLs9srPhB3KK5BqFqcSM7LOvPTowPttwwseA
	9viUeqlJ7W+YZhXY3urv8bs2EhX/bZvKjvQNlCI/IQUtOUIkj13Lp1EqzBruG6O+q4ozlawDCFZ
	667mmGdm7Kh+KoyevtkzN2j5qfUXhucKY2g23hpOEtD/NKdG4u2bQ1UbDETeca8GN8Wr52JU9CM
	7JfgVTB9zT2AVSWZl8B0a1cuXlkQueFQDAds/N2mSq+F57+bg+ixh3kGER7aWVkJL6PMR1kVEne
	3nlw+m/h+V5uc0ZOWh8uVvcfXU86HCKDN8itE5mY96LGHEcpex5RK95hAnkgsPNTutg3t2m5yxh
	0i8UVwrcP/z
X-Received: by 2002:a17:903:1c6:b0:2ba:4ad9:70f6 with SMTP id d9443c01a7336-2bf36875e60mr153776095ad.31.1780355869830;
        Mon, 01 Jun 2026 16:17:49 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm111360735ad.63.2026.06.01.16.17.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:17:49 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v2 2/4] config.py: add vcontainer-tests
Date: Mon,  1 Jun 2026 16:17:27 -0700
Message-ID: <4590548d61b5a7397fbe39f8d10ec874b46af09c.1780354388.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354388.git.tim.orling@konsulko.com>
References: <cover.1780354388.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:17:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4094

From: Tim Orling <tim.orling@konsulko.com>

Register vcontainer-tests builder that runs the meta-virtualization
pytest suites against the SDK produced by vcontainer-tarball, so the
test coverage is exercised by the autobuilder without rebuilding
vcontainer-tarball for every run.

The vcontainer-test job needs the same repo set as vcontainer-tarball
(baserepos plus meta-openembedded and meta-virtualization) so the
layer checkout on the worker matches what the SDK was built against,
and are tagged 'containers' for filtering alongside the other
container-related jobs.

AI-Generated: Claude Cowork Opus 4.7
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 630c8d3..7c2353e 100644
--- a/config.py
+++ b/config.py
@@ -35,6 +35,7 @@ buildertorepos = {
     "metrics-gitstats":  baserepos + ["meta-openembedded", "yocto-docs"],
     "meta-webosose":  baserepos + ["meta-clang", "meta-openembedded", "meta-qt6", "meta-webosose", "meta-security"],
     "vcontainer-tarball": baserepos + ["meta-openembedded", "meta-virtualization"],
+    "vcontainer-tests": baserepos + ["meta-openembedded", "meta-virtualization"],
     "default": baserepos
 }
 
@@ -161,7 +162,8 @@ builders_others = [
     "non-gpl3",
     "meta-webosose",
     "meta-qcom",
-    "vcontainer-tarball"
+    "vcontainer-tarball",
+    "vcontainer-tests",
 ] + old_arch_full
 
 subbuilders = list(set(trigger_builders_wait_quick + trigger_builders_wait_full + trigger_builders_wait_perf + builders_others))
@@ -329,4 +331,5 @@ builder_tags = {
     "metrics-gitstats": ["metrics"],
 
     "vcontainer-tarball": ["containers"],
+    "vcontainer-tests": ["containers"],
 }
-- 
2.43.0


