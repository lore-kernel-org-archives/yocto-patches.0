Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EAECAC59F
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 20:43:25 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web11.34469.1758141795262815066
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 13:43:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qFcmvuj5;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b7b3202dceso2591561cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1758141793; x=1758746593; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++mq9rd63s+l6GaTu7iSEMAyPCja/YyeyZ+MyRmdTnI=;
        b=qFcmvuj56sF0Ed70SeRrASAWREqLqc0/QejxxNMB/+I7og8Im9WKvWeSMAEFXDiRw3
         /Q+RmIvZhpUXV+4rJQeDUfTd//NnSbffZ0u5Oc2mn2G7xW9E4cdpyJSx+VMjDRZBBoGI
         XnySvZgGyQhnovRgA1rBUPYafKCJ3/dDFknTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141793; x=1758746593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++mq9rd63s+l6GaTu7iSEMAyPCja/YyeyZ+MyRmdTnI=;
        b=MB2SzppgX7rVSId5gDwGA67xmjTjYBpo4zfiomqRsEaCbW7RQ52tpOWZiRxZwD6tzG
         vbon+hrUY5v6RzcKbwFfK8VyrexhXyhQoxstd3vvdgAgx5xcBmNupY5Wtnm/MOapCWzg
         zwESz8KDTI8BP/zPVigsJz7/Py3ga1xYzaPgxVSRhJdS4/zbHPJcaSUch7XaFTOCrugp
         Woi+gCG/M1csoT1pBDgIKa2UKJxWNL+Wey4A+lO73J6NoQo7YVHVdHSeELHjktAFO+7Q
         hrzFI1PQsa24AE2sVSabQ6+XNKj03Y1d2L0qFfQ3aFQQzJpgrbJkZ8icNDuAfhY5gjEl
         mMKQ==
X-Gm-Message-State: AOJu0YxgN11oRRRv2ayljzjoqOaXnefP0/KIHQ6jxFjyaKyvUKNxmIjp
	vCRCVIvtCH2f+sv0QV4MzGG7gJ4KE55JH635m/r6uRK9KKGDkBnYc3o/jaK2psKPb6oIGC0Oz4e
	Ditt8
X-Gm-Gg: ASbGnctNlzIcas6aM1JQWKTeEV/BYVMJN5niDWzy38FutH6jWo0tzP9q66jsDwrtXVC
	Y+dgKHrJDpgT8GvmFCbWDlqXCoLOHkpD3oq9ocMlz+pFtRfPf+K+kZMgI8dM5R0MI5Twoss4Q/c
	XM/2IlHvuKamp9+gNjmafhGNv7zhFFJxZCItkYIW8dIBuyNd20ceBjaGN225iSequgCKuojBFri
	Sil8CRbEINazaEZXLd1A715oIWlwQlfPYWuENEduXBi4hU5WWM5n4xLhkaF2jrXNtpaei1aeoej
	U+waXd0GPPmkd40tKCxZdapQSTgm34H2qTfUNdDa/Rjyy5HPtft9f2nu9nrkekdV5/s/iG6bYDz
	2zCjybw2M58RKby6WQIpa2uthwoAnq4l34TPPArvZpKuyW4wS0K4sy9E09IM1ciVecJ0cB4XvGE
	Lw3mBng3NtGUzFKbor
X-Google-Smtp-Source: AGHT+IHjAZ68ZVE9b2IduLzDzTGCh9XKAks6dwhCBmrP7GWS6ylBOtjKxSgOONM6c9R2bzFgr+wo4w==
X-Received: by 2002:ac8:5acf:0:b0:4b5:146b:4f23 with SMTP id d75a77b69052e-4ba6cc7b534mr39021111cf.72.1758141792780;
        Wed, 17 Sep 2025 13:43:12 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836260ccccasm42991385a.10.2025.09.17.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:43:09 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 4/5] lynis: homepage update
Date: Wed, 17 Sep 2025 16:42:51 -0400
Message-ID: <a7fbaf9d0f909bfef9f7e3cb0ca4d3d56fb9cb8e.1758138771.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758138771.git.scott.murray@konsulko.com>
References: <cover.1758138771.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 20:43:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2211

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 recipes-compliance/lynis/lynis_3.1.4.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-compliance/lynis/lynis_3.1.4.bb b/recipes-compliance/lynis/lynis_3.1.4.bb
index 4059662..3546a9e 100644
--- a/recipes-compliance/lynis/lynis_3.1.4.bb
+++ b/recipes-compliance/lynis/lynis_3.1.4.bb
@@ -2,7 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SUMMARY = "Lynis is a free and open source security and auditing tool."
-HOMEDIR = "https://cisofy.com/"
+HOMEDIR = "https://cisofy.com/lynis/"
 LICENSE = "GPL-3.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
-- 
2.50.1


