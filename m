Return-Path: <ppjadhav456@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A1C83F09
	for <webhook@archiver.kernel.org>; Wed,  9 Jul 2025 14:37:55 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.17394.1752071866428987732
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Jul 2025 07:37:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PiRdoNJz;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: ppjadhav456@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so6719b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752071866; x=1752676666; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/6R/o6WJKelO+Gcmhk1an1F/pM6P200Sbv3H7xeB4Q=;
        b=PiRdoNJzBIw3EBYfZ8+2G5oaWHwhuB8ATxiJtli7/CgagJvwORxece9H9nbbIBgK0l
         lcoGpXqg4KqZJ5PSu9tl+rYyEfndU7BH57tpk2hlcfXAsaaYanHSfMpQuPo4EnYVXE8m
         u4lbMaa/S0Wx5zfjqDMgRmCWUxo1QdXRj1SK13d120tmMhjoIb2xwtzaWABOybmxhf1i
         wRCcZpdA7o0Acmf4x3QaYWfuaNc0Hpi8wHYqSeu1z13Zl9+RLigFK2h7bDNp9YpvstKh
         IiU+rNiNpTOjzBaVzx5VHHHvmWrA/vwKFKypgN4kZThjd4nBUBFxkJgJvG17CtK25Zcc
         BTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071866; x=1752676666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/6R/o6WJKelO+Gcmhk1an1F/pM6P200Sbv3H7xeB4Q=;
        b=NUl61yiOsiS+dtPDUMAGfFcV8dO20E4fENUY6Bfdw6//cQbrc5MlodplSKi3gFGmq1
         cFO6PPBMgXpT9wq2jxOLx/nNJpNVFWericeOpwIZYyRQPgJL8xQ2B5FcQJepgD2Gi6NG
         gciJxbvMjaH1SXSjI/tOqmU8DtrBBSMvS0OXJaqOQ0cuyHgqhGMwPKeTdlsY8rZFpoYd
         mDWwCCcxqxgx1uqVvKEwFhCv04hJu+dLd34J5x25B8BFzLdm6uPhmm7MC9tJ/CIlE9Di
         edNIh5YxJX+54Nezg/K2bnDjhaiggG9Wx6he5guVOkXtFcbLUEYutRGA2UA2WJm5Eunf
         +Q4Q==
X-Gm-Message-State: AOJu0YwRUxs9BgYBsj+DWo3hZxCWG21N/keGVvUmJC6WGR+0kfl2l/fi
	qNzUfMwbaQH5DJHyJc2doIDP9/S4XM0e+sgk+KHdakaNBke9N5biE6MubRgmAQ==
X-Gm-Gg: ASbGncsw9LXZY08EaZDcCV8s9DKwK7e0CCDbByCOzMTx5VcIAoCCsIy7hBth8AWxilo
	EE/X+lFW7XyxlDpqGj7gS8woIR7LkgGGv13w3aaBZZIKiz+CUGIT3LqXg/W1LH5opOaCk8Z3PQd
	8qw85wFb+QE6z+VUmI9EgA23pqRhQlnyWVtBxN2cNSNZO+lYxVmLTfrn5gu8k3dMnYZ4PFk7GdU
	KjuLCKiZ+th0ycw37eriMifg9KgYC/dtp9vwmhzrTemWWg5CeoeQGHxvEXGL0pShERlbZrV0Qb/
	Pwz6GHXYIQhk73jGMxEsW7DLZMz45zTerAgHjkiKEPnoKseOVftNUdYHB/N247iz+M02fp11Nw=
	=
X-Google-Smtp-Source: AGHT+IGZ850oUO4+57yKLlw63YVE4rBZH5yZJpReUas44ML62OFM3ptxtqUUJufWi+rLgpDXHdwBmg==
X-Received: by 2002:a05:6a00:9181:b0:742:ccf9:317a with SMTP id d2e1a72fcca58-74d264aa994mr9294247b3a.12.1752071865517;
        Wed, 09 Jul 2025 07:37:45 -0700 (PDT)
Received: from L-15936L.kpit.com ([43.231.237.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429b6a3sm13632074b3a.126.2025.07.09.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:37:45 -0700 (PDT)
From: Poonam Jadhav <ppjadhav456@gmail.com>
X-Google-Original-From: Poonam Jadhav <poonam.jadhav@kpit.com>
To: yocto-patches@lists.yoctoproject.org,
	ppjadhav456@gmail.com,
	Virendra.Thakur@kpit.com
Subject: [meta-selinux][scarthgap][PATCH 1/2] setools: Add native support
Date: Wed,  9 Jul 2025 20:07:37 +0530
Message-Id: <20250709143738.308474-1-poonam.jadhav@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 14:37:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1792

Enable using setools native for analyzing
the built SELinux policy during the build.

Signed-off-by: Poonam Jadhav <poonam.jadhav@kpit.com>
---
 recipes-security/setools/setools_4.5.1.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/setools/setools_4.5.1.bb b/recipes-security/setools/setools_4.5.1.bb
index 45063cd..94a0f94 100644
--- a/recipes-security/setools/setools_4.5.1.bb
+++ b/recipes-security/setools/setools_4.5.1.bb
@@ -36,3 +36,5 @@ do_install:append() {
     rm -rf ${D}${libdir}/${PYTHON_DIR}/site-packages/setools/__pycache__
     rm -rf ${D}${libdir}/${PYTHON_DIR}/site-packages/setools/*/__pycache__
 }
+
+BBCLASSEXTEND += "native"
-- 
2.34.1


