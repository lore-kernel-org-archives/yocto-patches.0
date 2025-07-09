Return-Path: <ppjadhav456@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8E4C83F0F
	for <webhook@archiver.kernel.org>; Wed,  9 Jul 2025 14:37:55 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.17530.1752071870638899136
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Jul 2025 07:37:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MmSuEItU;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: ppjadhav456@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e63d4b05so3107624b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752071870; x=1752676670; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LyVN+dk3hFM1zGrrbSa3yyLIu2BKo40OtHKK25GouI=;
        b=MmSuEItUd0m2LoMsDDxD9sQVEKx+erE71ky2BXAgn+ZK9SzLoF1CwNcwI8CUyichCw
         zQi5YCciL6J+ZNJDhXJMOcgC0GZWKMFr7qpL/27L8PeFsGOIA4sTsUKCspBz7Y0EQbqy
         Rr5eHyt/kKCc1Xt1rwPhqih2aS9csAWT+JHKdpc2bbj3sXPkW07udscpVG6/h/rMCYWk
         Iyc+PTc1YX5/ASmkXQucdY1M8qgR6p00Agpjv5JzIHGKqzWi9lgB6K5DXv657S2t+Ywd
         HNjYcuog3MIKQHxVJEZtSYUi8w4hjqoUsnfVWfdW7LOkqsO51Q0PljOofQkTMJQSZjgX
         AR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071870; x=1752676670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LyVN+dk3hFM1zGrrbSa3yyLIu2BKo40OtHKK25GouI=;
        b=rvtR+uXfz4YNRuI856agxY8lgQd39lMrercGDlL3Z3rmG0niqsvqMi2C6S++jlqFbW
         XvZS01tQs4+s22Z5X0owRr2xE+i020OnBpP2tf15gHjuJN7LGlUP46Y8xnA0cD6KLo4+
         67fdzue7/JJPg9Oav1pxkSKGi3TFVeBD+eXNdcTseSepe9lsFy0QILrjh1CrgjDbzRzr
         nAP0XclgsG+Jij13a3UI5/6A6o7szGnPET11fWjkYjWT4kC79mkj+po4o+VF0Ux/MCNN
         1dZdZ8cgrNFyTK6BOYDCf5VLMw05qF2CjalhxBKsw07HQIdFZAdPBp1nMAi3uxRhy+EP
         zksA==
X-Gm-Message-State: AOJu0Yz9u+8ZhBckekOqt56lmXwv6Bwram8DApafGR5pjTtnT4FjiDcU
	FFGZvVnujOZZ5meSh3Q41NYcDGFYdHfsT+Bk/9tAn9bPcY54WpFnHB02WctQbQ==
X-Gm-Gg: ASbGncv3sBLhrKM46kmNHLVXk9KkfXh0C1veMvRMpeVS3bTMX5ZPmMNPHIcj7ewq7M1
	7vn2gX3IoYw0QDiyyFXckTI1HSlLT4CDBvRmMrOQu9RDJVyCnrJU5tIbhUfFkYhp44gXjih04TM
	mYwZez+ZjfretLQsrGKAwBQOdsdZIHUYUaKeADhmFWk2VdVU+5oz5WQdADLSlktWohYkhcKgBPO
	oZMezjQPFL+pbYOD0CkbLw1JdeAzAmygsVMQl3tM5C0TEkoRla0q7Orp2Nf42DkBvlpREy3++te
	lfW/sFIWnAgb7+NYh9gKFtsHKqEmYVpL7z9JhJGoBzUCyWjH0ohWN46aWO6RkTgTsBdByLmebQ=
	=
X-Google-Smtp-Source: AGHT+IGe/on5vo07+oFa/It4xaxT6J9g6Pm/TLmVC0CIzyhtcbIxAwCLR3lqEOwqhOSwqwyJwN3EXw==
X-Received: by 2002:a05:6a00:a01:b0:748:f1ba:9b0d with SMTP id d2e1a72fcca58-74ea6630201mr4091991b3a.11.1752071869694;
        Wed, 09 Jul 2025 07:37:49 -0700 (PDT)
Received: from L-15936L.kpit.com ([43.231.237.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429b6a3sm13632074b3a.126.2025.07.09.07.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:37:49 -0700 (PDT)
From: Poonam Jadhav <ppjadhav456@gmail.com>
X-Google-Original-From: Poonam Jadhav <poonam.jadhav@kpit.com>
To: yocto-patches@lists.yoctoproject.org,
	ppjadhav456@gmail.com,
	Virendra.Thakur@kpit.com
Subject: [meta-selinux][scarthgap][PATCH 2/2] libselinux-python: Add native support
Date: Wed,  9 Jul 2025 20:07:38 +0530
Message-Id: <20250709143738.308474-2-poonam.jadhav@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709143738.308474-1-poonam.jadhav@kpit.com>
References: <20250709143738.308474-1-poonam.jadhav@kpit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 14:37:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1793

Add native support for libselinux-python
to fix build error for setools-native

ERROR: Nothing RPROVIDES 'libselinux-python-native'
(but virtual:native: meta-selinux/recipes-security/setools/setools_4.5.1.bb
RDEPENDS on or otherwise requires it)

Signed-off-by: Poonam Jadhav <poonam.jadhav@kpit.com>
---
 recipes-security/selinux/libselinux-python_3.7.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/selinux/libselinux-python_3.7.bb b/recipes-security/selinux/libselinux-python_3.7.bb
index 3c5c489..9023769 100644
--- a/recipes-security/selinux/libselinux-python_3.7.bb
+++ b/recipes-security/selinux/libselinux-python_3.7.bb
@@ -55,3 +55,5 @@ do_install() {
     sed -i -e 's,${WORKDIR},,g' \
         ${D}${PYTHON_SITEPACKAGES_DIR}/selinux-${PV}.dist-info/direct_url.json
 }
+
+BBCLASSEXTEND += "native"
-- 
2.34.1


