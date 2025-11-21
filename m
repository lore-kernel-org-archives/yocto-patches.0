Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC83ECFC283
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 14:21:46 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12414.1763734897039198067
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 06:21:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NKMFo4+D;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8a3eac7ca30so128197085a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 06:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763734896; x=1764339696; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEQzOrrOesqp+zPDPM8u1Fsf3NDDS/lbw2rY5cwvhHQ=;
        b=NKMFo4+DygFQI+ddZIWs1BHoV7OPIaHDHBCJUyR4CQnRIVpNFxyv6mGG0kU6NIZCWJ
         joIl4D62FTnm08Q8FIQenE3CXM8LZvIrYJljjiKVEViY/ZSCJr8NXHgMYE2GlJbhGVqY
         kLRL30neekdclGxZWUiToYgAyCR76t4fzRQeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734896; x=1764339696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEQzOrrOesqp+zPDPM8u1Fsf3NDDS/lbw2rY5cwvhHQ=;
        b=k7ClajaIdRMYw02vDfhO8T98DmpJ6JVbzlncfwY/M2HqSOuYsu/7RduMBux+LNMtTz
         qhgFdc8v1d50vk5k9z8SI9yt7YepYs2nn3TBwAH41RciGFlI/2jb3Y9HPl21Gaoos3xj
         /8FpNeAZ/GdJ/4WbI92S/RRcnNnjQoV0YvHsGoLPUlo6a/d2RsNUxb9l4qHfbCot8Scs
         AH4WreKFfFok7fObjlqwJYoZl6YCL50VLf3DpaLbxHyE8ruQb8uLVv7EyTy3D2fH/b8L
         RxxP/f/2fGipUSud6VXoqEdIaX0CR3tqU4/GGZMDpAxfMyBP67GHdtZ7niJ36Yu60izO
         /jhQ==
X-Gm-Message-State: AOJu0YxzOe3WU6A9jgsO4lURPZqn/uIuShLQInEwwhaN6pZfUwZUvbER
	jOgE1VR5soVYCbrTOMSmPLMR2Z+WVAj4l/zE6dzv6BNzlH8qE7V8njcvp+0b5EWf6l5xoKxbUKN
	kj+a8
X-Gm-Gg: ASbGncvMTXBTjbgu2Tx2TR51gAqTrlIM3Wu1iqiMELlwg1BTppUQkl4BTIAgCtKHqMq
	G/JOXxgfFOrMpVLLl84RTzxwzTZJd1L3e8peuriGc2LkJxdCQwdyV/48gA79ne2sLY/pk02YFZ9
	zsxRH0F9PJOfbfHfYxO7QzmLlFQRxFH2cP+25uMI/cWTQvzi6IGdHhodu/minKi8CPdzzSZhjMV
	RB3lTt++nhpR3ihGkz3UCSv4sj9AxkFjzS+8zwW+2p1IaRSnlRF2tPQL++837gsmyrVlIGsp2No
	Ldo7dOJAHDhhEC18cbBUtHLJm90dDA/1M2rYCizQvKFsDFq1V2YJZ8bnSHpxIToDsdKaWIg49xI
	IWfBEjc21dVIuKPeAbctSMrulJG9tpD9zCHRFK87Basn32Fkh7fr3uMBTSiPUwL1Qz4vBsH4PgO
	7ox+H2oozgKNCrDeuqN9QwrOEwSPmqtATBVq+BRSVC6HZqY774V6mOhuVqAw6LBQ0=
X-Google-Smtp-Source: AGHT+IEgkAt8m0R/g/QNsZSkTVrDtAfdNKS/QYxza+xw6I9LCSCO4jABT9gSduQtewFbQR4bnXjT3A==
X-Received: by 2002:a05:620a:28cc:b0:89a:68c5:25e2 with SMTP id af79cd13be357-8b33d1c4f27mr312281585a.8.1763734895443;
        Fri, 21 Nov 2025 06:21:35 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm374815785a.37.2025.11.21.06.21.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:21:35 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 0/6] Assorted updates
Date: Fri, 21 Nov 2025 09:21:14 -0500
Message-ID: <cover.1763734538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 14:21:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2644

This patch series rolls up contributed patches from the past few weeks,
including a couple I missed with last week's push.  They are queued on
the master-next branch if you would like to check them out to test
yourself.  I intend to merge these to master branch at end of day Monday
unless there are objections.

For folks looking for scarthgap updates, I've been a bit delayed, but
am still working up a patch series, hopefully will have it out by Monday.

Scott


Louis Rannou (2):
  openscap: fixes
  oeqa: openscap test

Yi Zhao (4):
  openscap: upgrade 1.4.1 -> 1.4.2
  scap-security-guide: upgrade 0.1.77 -> 0.1.78
  libgssglue: update HOMEPAGE
  libgssglue: add UPSTREAM_CHECK_GITTAGREGEX

 lib/oeqa/runtime/cases/openscap.py            | 48 +++++++++++++++++++
 .../{openscap_1.4.1.bb => openscap_1.4.2.bb}  |  8 ++--
 ....1.77.bb => scap-security-guide_0.1.78.bb} |  2 +-
 recipes-core/images/security-test-image.bb    |  2 +-
 recipes-security/libgssglue/libgssglue_0.9.bb |  4 +-
 5 files changed, 58 insertions(+), 6 deletions(-)
 create mode 100644 lib/oeqa/runtime/cases/openscap.py
 rename recipes-compliance/openscap/{openscap_1.4.1.bb => openscap_1.4.2.bb} (94%)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.77.bb => scap-security-guide_0.1.78.bb} (96%)

-- 
2.51.0


