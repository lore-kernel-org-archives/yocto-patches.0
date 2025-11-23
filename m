Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5DBCFD31F
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:33 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4861.1763941526498794928
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rS80408R;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2dcdde65bso560147585a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941525; x=1764546325; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oP/IbHT1Vbov/eJXHfyl89gHoOeQRpKgsVfU0RULpJI=;
        b=rS80408Rs2NV/3W/sLbihglxrGBS9KayW6RWqUXnxIHhBqK7iWqGvlG8xZIM1sK6HQ
         7pkIsaw0m43u1j6qFv5Zm+44f6Y10wr4BLDLBto11r7OCWmJAPt8V2jpWg640hKO/PZa
         1vplaLk5218GZWhcWX5aK3dZA0sQAkqBVQXtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941525; x=1764546325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oP/IbHT1Vbov/eJXHfyl89gHoOeQRpKgsVfU0RULpJI=;
        b=fgvNzhKKlihWmgHYFdatU50lbgyaXNDIiEZPlR6VruhiBxWCX7KBQfgD64xkgjg84R
         n0Xz7L5wIKEv7kdVTzPZyeGzFcG1+2HcIhdx7LSWGunkN2NV2YDbtT8zAaMHIim4Xr2a
         Q2aBohgwxRfQz2sqJ9SNzEpCz+I6gGG5LT9aaKlmCrFACQsLLoab+6nOdEj+mAGjP0KL
         gEu5bxXy/O3JdH6SGmLtVkQH5+ES0XyQaCvjXh5ztvLOTxNIOpuNSgf0HUUt0HhquOGi
         BBLCYjWNIbuuK/gwf0ZNxsQt8+ywJzcCvvXgK4jUn0mu7Qo0BQ2EpQiMMi5jpUJQ3DH3
         JPGw==
X-Gm-Message-State: AOJu0YxD9+ZoX5kSeO7Wx4KZnGHnKjYdxkYRo42yDmgPoVoPgxkS1okZ
	EGWUACJcbv1/jCZs7rzaBbzeikxWMj9zm3h6wLlWgmgXYLwaqsBbWpRYRRelmeJX0047nKPIwU4
	n6rj4
X-Gm-Gg: ASbGnctVWCGh9KYYbeoeUGGYSp7mhRS2u44Lhdwye7ifaZ9K4pSL5Nah5Zhl6wF5Rgn
	puXeKdWydi6OkJ2Lu+ozzMSrhpG2T5PrDtl1bBLkcEssxTFuFdWYHAknXDe2tClWJ5ulqroPRDD
	kX0pPXevZZngaPJ4xgqOhR/GLnwfWlxQXrvBkfLhVGmM0lRVNnjBDyA56vMbiU4QPhFkm7XA2hC
	Ew/godomYRzhd14QVhaP+Jw4IJdfK6cYSviBdpQFFsQ8u2ho0mCi5vTUa5ZnmHgPfmsgbBKOq+d
	Bi2j9pZmajzLWeN+QBVP3ejviSdQxsavQB0RyPssD9eY1wVC8vQfTdkcM98XkEMq5gaUOkWUv1E
	ysug/MjNmCgsNAJacYCRfhY1ZjB1w8JH7SrwVmCMicitykArQAgpipXxG1CZEhmT7P6OURN6G9X
	UGYp4m0afpTHQOG1VpuEtg2s5BhxfFyP5gZ94RJ7QFX9+H6iQh/pGaDUwYyaNPIIs=
X-Google-Smtp-Source: AGHT+IHp6XQp3wsLLc7VLxQypYjr8eGUG/vJkRZJqhfKTALD6rVbMjJlIlz7F9bU40AZ3KH9ivlWEA==
X-Received: by 2002:a05:620a:28d2:b0:8b2:e1b5:a142 with SMTP id af79cd13be357-8b33d23a9bfmr1206027685a.19.1763941525084;
        Sun, 23 Nov 2025 15:45:25 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:24 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 09/32] libgssglue: switch to use git source
Date: Sun, 23 Nov 2025 18:44:49 -0500
Message-ID: <9025527f4ccd407e01de577cb84b1c2ae2ddd0a4.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2667

From: Chen Qi <Qi.Chen@windriver.com>

The 0.8 orig.tar.gz is not in debian mirror any more. In fact, we
really should avoid using orig.tar.gz like this because distros
like debian will just delete those that they don't maintain any more.

Switch to use git source.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
(cherry picked from commit baaafdf08b7ffb8703618684d571c4766ea3e28e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/libgssglue/libgssglue_0.8.bb | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-security/libgssglue/libgssglue_0.8.bb b/recipes-security/libgssglue/libgssglue_0.8.bb
index 9d01964..e534615 100644
--- a/recipes-security/libgssglue/libgssglue_0.8.bb
+++ b/recipes-security/libgssglue/libgssglue_0.8.bb
@@ -21,11 +21,12 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=56871e72a5c475289c0d5e4ba3f2ee3a \
                     file://src/oid_ops.c;beginline=378;endline=398;md5=72457a5cdc0354cb5c25c8b150326364\
 "
 
-SRC_URI = "${DEBIAN_MIRROR}/main/libg/${BPN}/${BPN}_${PV}.orig.tar.gz \
+SRC_URI = "git://gitlab.com/gsasl/libgssglue.git;protocol=https;branch=master \
            file://libgssglue-canon-name.patch  \
 "
+SRCREV = "c8b4b2936b854a7d4f7ef12e30d6f519b30dec87"
 
-SRC_URI[sha256sum] = "a2bb183e946f6e30562a2a856950a2916c9b6d42c34d67a8400e4efc28917746"
+S = "${WORKDIR}/git"
 
 inherit autotools-brokensep
 
-- 
2.47.3


