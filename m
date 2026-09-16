Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D41C982D3
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:53 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27098.1789597849081034660
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=tprP3JJ5;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910a0cefaso13318585a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597848; x=1790202648; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/XAvRnGECGwdT+fddAEPlgc/pDAOtHMcKoay26GJ1hg=;
        b=tprP3JJ5CsY0iKfFnOhh1qqOeRKNsVVLZZ3416F/Z/cgjkkgbcxUhOd4Qd2iu1r8TS
         ZQpKWRqPJSDgUu6LNGDDcer+QczCHffvnA5s1KhN1k6RNhghFkMvvxGeMlDYazkotHQX
         SaCIsmHFk2c0t0rS7VgUBJTARdtbE3KhRDA9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597848; x=1790202648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/XAvRnGECGwdT+fddAEPlgc/pDAOtHMcKoay26GJ1hg=;
        b=mJuOTYic074SVxLMvX/ck7janvyB2gloqT7xDUQ37rNnWtyoPRuEJlui+9YT5h9fFN
         6UFjV4ZBoklOD4cpUKcEKUN+pzk2yyNcTXbVE0S2+ewR0aTDbwtTXtO1RlTVnQKWB7jc
         Qk7Bw3j8MsbC8t443YSYtCFBJFrEQBDv+UqfUN15SlAKFRwhZKZZgO7HzvvyXiZbFRDa
         mAM2a0INsRpoa0I8YUv9Qdy/x5fnj9qgbZJnX2Hajk/pVst42FnRqwz404rqk6gnuXBh
         mY0PUQZD7A0CwnLiRpe8GbumCwEv/mPk4PY7OJjSWFSVeuFZQM7aDVOt1NYNzyqf0qBB
         Rpag==
X-Gm-Message-State: AFuF++kc+5zbimNZ43NzyjMLy+QwbktVHyBqDZErBzCvZXqz2eSMfUEi
	iQoQYLn0kozIkYiQZp0JjSqsJ3AJipWO3R0swhPSIMnmiKPBD/Xf16CzgAkBL4BJ+2Sa9UNMf3+
	U0T0I
X-Gm-Gg: AYBFou3/Tb/SIWYok81eET/wOarr/9ZQdEtHCUUUoBOrSuHdKeLLp8hS2Mk7nntR7Un
	duiGOI/MnnF+wrHZXQYYyWuvCcVW3w/hUsBpYGzftJPauu4UZZesH0s6vQ4x9ak0QYL6te49b0X
	8OT555yiCol8laly1K/XAsmL4MFw8yEYmkUvz9VLHhKraQJyNRSdYFX8fiiqOUhWfbyvVrLfw6g
	ZKUFQlkCbfIJ342b3vTrFDlq3xbA4nd3SKxQKlasqgfzc2oxleiKHKQgwOaJuR2uR52marHmqSZ
	uM7zUUQV2bLbhPFJwybIi7BQxJoiUR2W97bAj4E1HEklBY4ndSS+d+h0aGQepTjDDc2cf1bj84t
	iIsEigWrxRkO9gwMvuiqEWyxhLe7wBEb6bcrXX3SZjgzy2OLsSGoQZtqVXAxBp6wtFRyZaqVozn
	wBs6kMgwUAvz0ylhBPgHHVmW60DCgmiLp2v9+hJM3X21vCDU+KtRK2mQ1S9TsHTHVpYJnuLllvN
	sVDyGAJcwV6nBYu8H1ZFIb32TeB74RqGCFpgSFKXR9CRmcAB05qg7RfmVMY6IycI938tRiupLI9
	6fqxlvW6p9fq3Yg/cxy4yWgZ8+TzQzyOWyo=
X-Received: by 2002:a05:620a:4728:b0:93a:2bdc:cd57 with SMTP id af79cd13be357-93bb77085edmr748278885a.2.1789597847909;
        Wed, 16 Sep 2026 15:30:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 18/24] ccs-tools: upgrade 1.8.9 -> 1.8.14
Date: Wed, 16 Sep 2026 18:30:12 -0400
Message-ID: <020af94becefcef8d4e3f4ef61f77791aa10bcab.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4894

From: Wang Mingyu <wangmy@fujitsu.com>

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../ccs-tools/{ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb}   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename recipes-mac/ccs-tools/{ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb} (84%)

diff --git a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb b/recipes-mac/ccs-tools/ccs-tools_1.8.14.bb
similarity index 84%
rename from recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
rename to recipes-mac/ccs-tools/ccs-tools_1.8.14.bb
index 3f754e9..aaf17b0 100644
--- a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
+++ b/recipes-mac/ccs-tools/ccs-tools_1.8.14.bb
@@ -7,10 +7,10 @@ LIC_FILES_CHKSUM = "file://COPYING.ccs;md5=751419260aa954499f7abaabaa882bbe"
 
 DEPENDS = "ncurses"
 
-DS = "20210910"
-SRC_URI = "http://osdn.dl.sourceforge.jp/tomoyo/49693/${BPN}-${PV}-${DS}.tar.gz"
+DS = "20250707"
+SRC_URI = "https://sourceforge.net/projects/tomoyo/files/ccs-tools/1.8/${BPN}-${PV}-${DS}.tar.gz"
 
-SRC_URI[sha256sum] = "7900126cf2dd8706c42c2c1ef7a37fd8b50f1505abd7d9c3d653dc390fb4d620"
+SRC_URI[sha256sum] = "b62e344cc357a982310a08760f2a2cebf4cf48b1341ea9bd3990ae55f45bab03"
 
 S = "${UNPACKDIR}/${BPN}"
 
-- 
2.55.0


