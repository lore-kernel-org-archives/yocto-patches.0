Return-Path: <ppjadhav456@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B94C83F03
	for <webhook@archiver.kernel.org>; Wed,  9 Jul 2025 14:38:45 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.17415.1752071917403866575
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Jul 2025 07:38:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kv71w56B;
 spf=pass (domain: gmail.com, ip: 209.85.210.178, mailfrom: ppjadhav456@gmail.com)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b56b1d301so3196835b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752071917; x=1752676717; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PCFdFxavWtovJZx7CCCjPDo4RbmkxA8i66lpdx8Z5bo=;
        b=kv71w56B0wLJv3Pzn6Rfku5lw+KQCx+jamlSPoQ+4pfJAXoI6wBu/iPRYlzM7NWBJi
         HFzILjYhk5YkdeZ/G64Km62FSYa4UcBygmU5VWn8rMUxwD0tziBdf5wP3EhcDm+YcKQt
         V5VwEPKhtUl6UqCWRqFNAqsls0kRHPLkpNxhJYhZFUxMYxdNikKl6D2rvE2MUHvSWhP9
         uHvFpsFeFXXMPfmfUuO7A8SNSLJVi9hmTJ3DxeY6EcUxP9kDV0nmS2BfX0IU9pnulxpN
         THPwuzdGvqJJcfCkMa6SScFLG7wbONBp8Gu9fzEOXjcLG8BH2/DZKza9Pv+49eEMoD6s
         /0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071917; x=1752676717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCFdFxavWtovJZx7CCCjPDo4RbmkxA8i66lpdx8Z5bo=;
        b=rrYb2obr+ktC/+RbssDlM25nY7G/sDpkfqH3SC68kj8ykQNFdyi4KZs//D3V3Pzdfy
         MgJwxqw0T7yrVRtNklEOVhsKsClZIL29Wz8a2JFvGPxYqxx60iM+nEO1lYsSM7lOuVKb
         wb06Bu0/+kzhCEOPOPzUaqJrIUle9Wbn+Ut3g1fFEhMmfZcOFNMXdrYDGjErisnbCvVg
         ihANDwGplSLYl2dX6PLQ27J8pLjyNISpJ+85qSiOmdw3NdNYLADyRINjbMBzqLrrWFTr
         Z7KcWv6nuLWefQbm7KNLxjx1E1QX745oDNr8sTohL1LfX7eaW76esV/xZxuGAyVM383m
         WO1g==
X-Gm-Message-State: AOJu0YxzBOp5QR+7TqG6sLLCZz0qGYjQ3rxJr81IsMCZ3x27NvCaoEqs
	H4ehN3C+wi8CRVghrLzPjY3DWEsiBa4Blab87+BRZMrb+4jOm7xYPPw/QuIKLw==
X-Gm-Gg: ASbGncsOeZK9OuLhIfSuS1Iqos/eULa2N9OfcP/eFvk73oJ8Q00o2Tx/zboeJSR5RdU
	o5ZiCgS1Ldg2zyRMvzbHEP81VYvw4KfOvhBvkfSORSkvqM/jZWVpgVXsDr0pKWnzNdJalodddL+
	ywNpzr/dIzC+qT/KlJYhE8qBOgY43omnZveScZjZHCFdsWywl79s71SD9z+nKqew1+qJNFiTGqb
	3cMvXb5TP05QyoMusRCKDyxZjyR4JYwXYzSP/AWMottLjlbx23GusODRKKOMLEmcpk58Gpsttjp
	Z9md4+s1TzGbK1hE2S6qPDVG0h4ur0X52Q+MOK6gL/1sS0E8ZfV1dwvMWbnghb5gzR65fQyPXA=
	=
X-Google-Smtp-Source: AGHT+IHYvcbXo34FE0YNtbWKfHvj5vxcikwjE5RVWHMd/Kanfe3sd7Qo4yDx/tY+RD7D8ZtmkkmLoQ==
X-Received: by 2002:a05:6a20:3950:b0:1ee:a914:1d67 with SMTP id adf61e73a8af0-22cd5420bbfmr5583085637.2.1752071916462;
        Wed, 09 Jul 2025 07:38:36 -0700 (PDT)
Received: from L-15936L.kpit.com ([43.231.237.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a1ca0sm15341199b3a.138.2025.07.09.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:38:36 -0700 (PDT)
From: Poonam Jadhav <ppjadhav456@gmail.com>
X-Google-Original-From: Poonam Jadhav <poonam.jadhav@kpit.com>
To: yocto-patches@lists.yoctoproject.org,
	ppjadhav456@gmail.com
Subject: [meta-selinux][master][PATCH 1/2] setools: Add native support
Date: Wed,  9 Jul 2025 20:08:28 +0530
Message-Id: <20250709143829.308552-1-poonam.jadhav@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 14:38:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1794

Enable using setools native for analyzing
the built SELinux policy during the build.

Signed-off-by: Poonam Jadhav <poonam.jadhav@kpit.com>
---
 recipes-security/setools/setools_4.5.1.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/setools/setools_4.5.1.bb b/recipes-security/setools/setools_4.5.1.bb
index c9d0bb3..aaaace5 100644
--- a/recipes-security/setools/setools_4.5.1.bb
+++ b/recipes-security/setools/setools_4.5.1.bb
@@ -29,3 +29,5 @@ do_install:append() {
     rm -rf ${D}${libdir}/${PYTHON_DIR}/site-packages/setools/__pycache__
     rm -rf ${D}${libdir}/${PYTHON_DIR}/site-packages/setools/*/__pycache__
 }
+
+BBCLASSEXTEND += "native"
-- 
2.34.1


