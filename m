Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D19C7EE2A
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 15:09:28 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web10.16152.1751036967125429921
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 08:09:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UVRJuLQP;
 spf=pass (domain: konsulko.com, ip: 209.85.219.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6facacf521eso21983986d6.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751036966; x=1751641766; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Yu9pj+MtCxzja40PWHUdCcFgxSM9C7XMK/cG1kn6T4=;
        b=UVRJuLQPQXJGBdw2YpHspomzLH7Y9sWdzMJmpQtk/7TnATqVM9PG+h36BimMjxrjOh
         jj7unXTJk93rf9FaUnSdR8zhdtmonhwLlMiyRTECd3kCAWi9Bk2B/QWhs7VfkcvuPAbC
         +hudEU1ar0AjF64R5T7YZXS58OWLqVPr8K2Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036966; x=1751641766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Yu9pj+MtCxzja40PWHUdCcFgxSM9C7XMK/cG1kn6T4=;
        b=koKGrHWpt+TzigX4XYtCZ5FKNI3hRpnf2xxnC9BkoBYntQbbjuzAbrEeX6t40v/zSU
         2eoHRp11m91+9vFd29OYlqbbebtDdXM7XgMec1DAJRHQ+YixH6N3MrmoFpF4HPaNPSDE
         qtpiUI6NBA5jz+KWmB4/2sQbFSKJiYapQ5oGTwBmduRGC3YoNTCvFR3gieuGQoyG6unv
         JKPULnwtEDGiqz7WmkhWERkIfx1la2mZ+kqp2dXgdxCKBLjJ+WwSs9BoiKRsYB3au4Lj
         mS4ErYRtTEt6kOX1G4ULCmadkb7qOhkYvLCOJphs0H4BleqrStakgMHTzbLBk/FT6Hhi
         YiMA==
X-Gm-Message-State: AOJu0YwGvBNBNPmlsoyLmCBRPjUKMVVX5u6v9sx8DNWcfW+ROEGL7H7p
	zg/2o1GPC71UfiLLdlXCddUEGVSaYA89XPZDF0VFtW2ubrK/SIqhVvmJDya93ARuLxONfa0jMI/
	xQw8y
X-Gm-Gg: ASbGnctGOx8OWlcBPQ7ZJ3vtSt/c4X0UPJmXeyliHtiMMsP7KuD/EiPGbTYgau8Hb/y
	2hOQo9LLGaH5sdRv5AAuZutbszPmnEnI8/6oL6XS5fVQfOGKa3ODCx+wK9pmyyZWJOYe/yvlPxp
	ZyYt1uhIntherc8CjmWEe1YLyhEop97tGr3c8GRFW2E1+xd8ZHFm1SDSJpM5tRYOnPf83sSNcL6
	mvbKNqL5dGC09gnxCpDQfxSE6tgquawPAxz0KYADWTgLZNdT9r85NbnoTFBBARzHvcxxl2vhV4W
	degLx87ilHipNWw2syo0qOdLw2aa3WmSZPOohM7M4lXZ3f2k7J+mRJkDG/PyaEd3RkLteRoG2TP
	LPLI6+oboztuBbdXwkbDUDaffSpxcNsvRoNr5CQ==
X-Google-Smtp-Source: AGHT+IH9DEOFTu8LB/wXiSgAEVAQiewJup36xkVvrQkgvGY4Gcf5Vu1PrZe47BcX5fkIdiqFLC1C5A==
X-Received: by 2002:a05:6214:2e86:b0:700:bad0:1c48 with SMTP id 6a1803df08f44-700bad02330mr31855516d6.20.1751036965722;
        Fri, 27 Jun 2025 08:09:25 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718e76esm22003636d6.12.2025.06.27.08.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:25 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>
Subject: [meta-selinux][PATCH v2 1/2] Set compatible layers to whinlatter
Date: Fri, 27 Jun 2025 11:09:14 -0400
Message-ID: <5b172fccbfec3ae12326f438ce39e186657f5e6f.1751036759.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751036759.git.scott.murray@konsulko.com>
References: <cover.1751036759.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 15:09:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1721

whinlatter is the next release, set it as compatible layer since
it is not backwards compatible.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index b0dc48b..6ec4380 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,7 +17,7 @@ BBFILE_PRIORITY_selinux = "5"
 # cause compatibility issues with other layers
 LAYERVERSION_selinux = "1"
 
-LAYERSERIES_COMPAT_selinux = "walnascar styhead"
+LAYERSERIES_COMPAT_selinux = "whinlatter"
 
 LAYERDEPENDS_selinux = " \
     core \
-- 
2.49.0


