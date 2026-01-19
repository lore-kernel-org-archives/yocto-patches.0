Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6008EFC619D
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:28:43 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44329.1768854521380188930
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:28:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nwhelOnA;
 spf=pass (domain: konsulko.com, ip: 209.85.160.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5018ec2ae21so40487841cf.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768854520; x=1769459320; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbm/s9a0TuF3OSTJ6hovUZIJmzQ3SjBPJVAQyNRxaTo=;
        b=nwhelOnAg0dFKEeZrrXFjtkFFeOMl62E6g+zVuofn5cZrnjLtq7wjeY1uM/TwmuunS
         wwP8wSEHDZo+skdSO/K1NZh9Y/uZrbEDo92WLr/AiBFjViFpZDquh+Kf/b9q7zncWj39
         jf/LpBUDwm89CnBpdmrsdqOnh2iGcMmcb0j+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854520; x=1769459320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gbm/s9a0TuF3OSTJ6hovUZIJmzQ3SjBPJVAQyNRxaTo=;
        b=PIGBAPpcgA0CLHNq+OP/yPbLbl7CCp9YzSNzh8a2bRzPe6jSHiK+qDGuHQmfjpA/pK
         UfEek9/u9eIYYznqV0Vgsj81UfOofYTQjJI8mp/26LCErv//axjx7DuUcpD55kJxdUl4
         MZiBFKrvE6DmZTSPPdX0t15odQ19HGCvAZtYuXfPgJjRMgFQU5KCOHRgJZQXuQElTIPb
         euEi5pPRgSkqwi3qEspxkqU+lPsAmCRJsimd0ziwsMPfLLpKs2lFs/wr8YuY/cqHrhcx
         9UaZODH41BLdjDXGJSwmNuKoaLzeLt7fvJLAJPvFz0ccChqLnJ2V8vtnaixBVDcoZoxf
         Qztw==
X-Gm-Message-State: AOJu0Yx8UmbEJk5bVYXDCKk+z5RRZcDlqNERT6emlgKq3JpyETyjaEY9
	UvvlKVXIu3w4RasEiMWsxMY1huspzvK1DvqE/ZlBGVEM/189Bx/s1jzofPxpimFz0vp+xpVEkIh
	s/JzP
X-Gm-Gg: AY/fxX5ag4/HcjXsEV/db+qqmYeODhxOD63iaE3IJK5Tm7uQlhr8N1BzLD79o4wcFkC
	QrH1V3xdShNc6zfjt6yrwGsb12w85fcWihTMGguoAMIOmGqRFDHa/s6n01cWzL5PLD8+ylQdSqI
	x+34noVFuCTecAY9aSAQ4fTte3woelEOkreaKifjhhFBkSmMuBB/KYuqSqVvXY+h8HsQfOL+BE9
	pVefA325S0wKSX6Rgn0Ic61aiseUqKwB2UssgFnS03d0IqqjwPQzPmovmztbVNcQwI11/cqNqIr
	++Z4hWCMNXZIu5/bkbmGwxXK6EazpseLrj65SYKpEdCHO/1OAsE0wk/eoWpTUelOwuldlUt5S4E
	pZiobYN2UF8ZrqH3efd5h4cxQuWi4S76u6/9nTo187ChK06hmM7C63z/vV9EtoEm+BPb2rPQ/cD
	RL2IUtAnAfZj22uKbIfAMBfC19rKV8wn+AePippxD3OI7Vjc28w7kdvVHSEc3H91f8tRGS/Pd35
	OGfnqBdYDkzy6fl3Dex53h2k7+g0v/QnwZds3m7ePtxvUtGOtuA
X-Received: by 2002:a05:622a:19a1:b0:502:9ad4:efda with SMTP id d75a77b69052e-502a16e9e03mr181022391cf.55.1768854520115;
        Mon, 19 Jan 2026 12:28:40 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f21c9asm82661411cf.34.2026.01.19.12.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:28:39 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-lts-security][PATCH 1/3] lynis: upgrade to 3.1.6
Date: Mon, 19 Jan 2026 15:28:21 -0500
Message-ID: <80e20b6b7a1ce5ed3186a4d69870912b501817f3.1768854292.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854292.git.scott.murray@konsulko.com>
References: <cover.1768854292.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:28:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3015

Release notes:
https://github.com/CISOfy/lynis/releases/tag/3.1.6

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-compliance/lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb} (96%)

diff --git a/recipes-compliance/lynis/lynis_3.1.5.bb b/recipes-compliance/lynis/lynis_3.1.6.bb
similarity index 96%
rename from recipes-compliance/lynis/lynis_3.1.5.bb
rename to recipes-compliance/lynis/lynis_3.1.6.bb
index 51414c0..722072f 100644
--- a/recipes-compliance/lynis/lynis_3.1.5.bb
+++ b/recipes-compliance/lynis/lynis_3.1.6.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
 SRC_URI = "git://github.com/CISOfy/lynis.git;branch=master;protocol=https"
 
-SRCREV = "380b414e09bbca70be59a1b7ddccfaed4c30e1aa"
+SRCREV = "06153321ea50d53a27446084e646d9f43fe46e0e"
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-- 
2.51.0


