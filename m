Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D960F428F4
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 20:19:53 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4575.1776284388099921470
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Apr 2026 13:19:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=tTWCI2gm;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a08fa355a1so99470656d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776284387; x=1776889187; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xr4UGeEuEPMgzFsI5rjN/XaisWeHYkYQrc7ln7vsvyg=;
        b=tTWCI2gmPF91WRbuwDksRhfr2ctgcduofAYavzoUetfOnCoZNTV1OTb0o/pVesePRw
         xb8Wr3WjQhTKOMydZxlxmuByL/chGLGWAHRKsycB7yQk9TKKs9b1ftTR+03F07AUmxKu
         JUQ21F3KSasd03mq25Z53ciPRvNAMZUkF58sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284387; x=1776889187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xr4UGeEuEPMgzFsI5rjN/XaisWeHYkYQrc7ln7vsvyg=;
        b=sZcDFpCQuYXSsIZZZWDRqLBAuXucjHX90atgW0z5wJreL2Fba4TQuyepdwVOctiL5o
         k+fI97SbM1tlZP2qD30TNump4LGoapF5AefwX0oDIuHXtDxbkr9gHZGLKjesGN3Zv9S4
         gktOlxOdOPtUvMfJR0+tp33jRlYNEzW/FKTK9tBNUSp+ZHRiZ4kkhf0upwii/Q52vjUk
         7Crw7rNkisicAl9YBFNlkQMg2y9bBcJ8prs70Uvm6n79OHcCMdr5/sYS5kDkTaxJxjrs
         2mS4+Ic7D/AGDBaHw/02F8GGROGzJ1bMxIF0UH09fhxLQuFXkhdu9JLQYPHIQETYwMnq
         q/nw==
X-Gm-Message-State: AOJu0YyNv3G9hmVEAxZho1DpApAQqFpnwZmQPoqEshUa8wAnrI8rNiaK
	P5HSilmi3Am5DL4JMtR1C0lpEhkfKGgIsDJk4bMzlxMRnaift3AJ+ThSzgqHIBDpdBWAZ1oxb5V
	sjHrV
X-Gm-Gg: AeBDieuw5qenDuKfTBfXr+IjRrVehHddB6Udx27kBgcsP0wS695S3yJsvvHUaSsfQ7T
	d5/eZzDk0qalfT541SM9KzOls7lWgvbeSrK+GCQiqdYdrN0Ten4fPVdVQSLhwfuXLmwdJrWK3Lu
	cUkMaIJBp4I6P0XUlorgL6ymyOCqS/nn0CmqwPI9dlVxegBVSQjM76YNDz8q3wJ9R134HloE+u7
	9tVAEK8kgrGi7zDymvRvwecePb6X+If+tu7CoPYjFvvn43uwOWrIvul/DAwMFP4s/FFVbiQsAuF
	ZHgzGl/FeveJUzozK35vOVxUl1h8gyI4b7ogulsWnAiweZc4AhiiiEUG74HwLjsYTG5mQPwNRgD
	QrXVdna4cagsW9eSkFmeyYjTtamk5oZ0ljcKI6nNaq6g9ZQRUUxlUZoTKxRSamCX9MeIP5s40u9
	EYIxS3w+flSdLOGoTlGg5FRr+UQHyY0mYl9Ln0eB/FRi+9XV3bPauvpbHHvrksyJpuBKc0SlxKy
	PPLHotaRBcbawM+S9NX2S3q4DanlEUlk3TT1et4dB29kw/7TjX4uN73sNV6k1vn
X-Received: by 2002:a05:6214:3f88:b0:89c:d419:778e with SMTP id 6a1803df08f44-8ac86319cb0mr372189026d6.54.1776284386624;
        Wed, 15 Apr 2026 13:19:46 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb80f6sm18569376d6.46.2026.04.15.13.19.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:19:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 3/7] openscap: upgrade 1.4.2 -> 1.4.3
Date: Wed, 15 Apr 2026 16:19:23 -0400
Message-ID: <1ed57b9ee1b7fdc2a4dab815f4aac5ec010b934d.1776283733.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776283733.git.scott.murray@konsulko.com>
References: <cover.1776283733.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 20:19:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3711

From: Yi Zhao <yi.zhao@eng.windriver.com>

ChangeLog:
https://github.com/OpenSCAP/openscap/releases/tag/1.4.3

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../openscap/{openscap_1.4.2.bb => openscap_1.4.3.bb}           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/openscap/{openscap_1.4.2.bb => openscap_1.4.3.bb} (98%)

diff --git a/recipes-compliance/openscap/openscap_1.4.2.bb b/recipes-compliance/openscap/openscap_1.4.3.bb
similarity index 98%
rename from recipes-compliance/openscap/openscap_1.4.2.bb
rename to recipes-compliance/openscap/openscap_1.4.3.bb
index 7b3786e..e1cb295 100644
--- a/recipes-compliance/openscap/openscap_1.4.2.bb
+++ b/recipes-compliance/openscap/openscap_1.4.3.bb
@@ -13,7 +13,7 @@ SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
            file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
           "
 
-SRCREV = "e9b2a41f5796f5ead3d1e2d9df1fb06818a569ac"
+SRCREV = "24986066961363e24fcff83294995b3cfe4058ba"
 
 COMPATIBLE_HOST:libc-musl = "null"
 
-- 
2.53.0


