Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493BBCA0FF2
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 05:20:42 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.13852.1756358436459149587
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 Aug 2025 22:20:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=JiOjdMf7;
 spf=pass (domain: mvista.com, ip: 209.85.210.181, mailfrom: vanusuri@mvista.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7720c7cc05fso436771b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 27 Aug 2025 22:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1756358435; x=1756963235; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRCReKWdVXkuqCa82gyMt02E6hgxRuzjBQVSuhlnuTk=;
        b=JiOjdMf7E0IQZP6+WoNnbFbnoQD46yYI8Xef+wCVZdBefPOAZIvgKrCvpr2QJtiDlE
         UJmA2jXftKk+eEuY8fv8k/mgXeFueLpMIJdnTuufrin704hakH1UgD1038EnoEQ6MLwM
         1zjJuBoruwyYbsa97iYDyC7doWHBBGVjzxins=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756358435; x=1756963235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRCReKWdVXkuqCa82gyMt02E6hgxRuzjBQVSuhlnuTk=;
        b=Jb7myB8j/8nCcOcDSWLE1uS2rFNqjh2ngBfWS6PnTTUnqEjquVqLhpME8KpHaQ6f03
         brI7+txffXFl0Czlwn6y2n0NxRMX5UTLePMuyreIyjpYeXOisLKBhxh48uyMIAzBPAFB
         E6Mfm6abiYfFGjFPQl2ueZaECgZEUXxltyANMIiYCfF6yx07Boau+KLTwHb4f4afEBl4
         +JW/SGNUJCVP55fpAzh+y2qukip+w/8Wkl0rv3GtlZyyXH9QHbknTfeSUxZBWDpJpCWy
         y3IhYkRozzehz2DiomXEASmVCZOeRblrKue1WEJ6cUNR3DYgwABv6/IwgJsXb9e0B27S
         O4FQ==
X-Gm-Message-State: AOJu0Yxjw+XLs49OBdr5s8LUfL35PBcbzbYhiSpnXfzhKZ97DH/cVSj7
	eWp/hpwDncTF+YjatU8i3vSFCl+V5WJY8zlVrI02EvveUGkZq3dH3pORR1iSB2OHum3a5JHy34C
	9y7NhMsI=
X-Gm-Gg: ASbGncv4wOl++KMi51PzDXe/EHIPyLUwhG6rb0x+ckqSLY4piCBwX0KoJ5XSsP8ThFZ
	1Z6w4VcIH40x9QCfNerPOnehfmK0SDJ9sGYxzWbXMvzB+ND4Y1CJtqHEiDhYRXZl6KqYzGcNJQT
	ImPiXLuWrLI8GVq13Tyru+iFO91JmQnEFybpF7fqkRq9PQyPXe5XXp2b2i6tuaz436IfbXu8UhX
	tIJlXM7LkuIgLIG2bOuAMDmywMmUduamNrHJH71SNUiWagWAJmWIAzjw1J1tkbXbQqu/8QejfO2
	Z9aOxUQFc9hfJBBgjL3KDMCA7lUlTf3ApzxtJcT2HxoGdw5/azICSvlq44lKeC6dqrVuOtZqMhb
	O494X9AiGYpYEU6C7Wx1qzkOrspDS1fMM4fJTFem9kLfq
X-Google-Smtp-Source: AGHT+IGmOdHDEKoWhWLP2KumresBW/KCvzBq7gaImcMj1563gRkMxWW+PDtgsnVZ3FlHgDYcyH7BAw==
X-Received: by 2002:a05:6a00:2e21:b0:771:e8fd:a817 with SMTP id d2e1a72fcca58-771e8fdabcamr17136073b3a.14.1756358435136;
        Wed, 27 Aug 2025 22:20:35 -0700 (PDT)
Received: from MVIN00020.mvista.com ([49.207.215.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e9fc74d6sm9226827b3a.77.2025.08.27.22.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 22:20:34 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [yocto-patches][meta-cgl][PATCH] layer.conf: Add whinlatter
Date: Thu, 28 Aug 2025 10:50:27 +0530
Message-Id: <20250828052027.16787-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Aug 2025 05:20:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2085

From: Vijay Anusuri <vanusuri@mvista.com>

LAYERSERIES_COMPAT: add whinlatter

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 meta-cgl-common/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-cgl-common/conf/layer.conf b/meta-cgl-common/conf/layer.conf
index 2912dd9..c240d04 100644
--- a/meta-cgl-common/conf/layer.conf
+++ b/meta-cgl-common/conf/layer.conf
@@ -11,6 +11,6 @@ BBFILE_PRIORITY_cgl-common = "7"
 
 LAYERDEPENDS_cgl-common = "core openembedded-layer networking-layer perl-layer filesystems-layer security selinux yocto"
 
-LAYERSERIES_COMPAT_cgl-common = "honister kirkstone langdale mickledore nanbield scarthgap styhead"
+LAYERSERIES_COMPAT_cgl-common = "honister kirkstone langdale mickledore nanbield scarthgap styhead whinlatter"
 
 require conf/distro/include/cgl_common_security_flags.inc
-- 
2.25.1


