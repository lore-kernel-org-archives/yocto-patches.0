Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9E9ECD6E7
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 19:55:59 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28225.1770839755698619084
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Feb 2026 11:55:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TQNJQJz7;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso3500055b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 11:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770839754; x=1771444554; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNUxCa6agjApiCbIcLn82ht+gQrxWhACHscn1SDu34I=;
        b=TQNJQJz7gwDoH4KHIntnZirpmARm/WX2ZYAxfb7NDg61zaOHDMKRU1zR3S7nMyCphl
         ZOrA7zEgDw5BTnxC3at4oyOdN6S625CI779fc7IAn4QI8cDqF9lNDdj5DbQKnH7gHJV7
         p0FVFuUcby2li53plzaKuMYqUsHDcigEjinl7hHLEVvCDHYKs81pH7kFAdH//9hWl0sU
         YUoyd7WTpS+FPmQZeQ0rrDNtkknslm60FHwc9rkBq7cPEkrGjTq0uH3c+u0R/fcjTiDW
         us1zob2rks+eH8vhHtdKchgZR2y6FCieQ5T3YL/8UeNzjkKpa3JrAbB03cWemuDA9ctr
         qBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770839754; x=1771444554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tNUxCa6agjApiCbIcLn82ht+gQrxWhACHscn1SDu34I=;
        b=aoSNqNhDoXnwtR36EIqfAwJldMiGTsIWGwCA/UPax7TPQaSrgDtYZBTvxrJgRT/rv8
         yiys9uzEfnW/p5ZjOTVk3K5hd2l6gy7/DoF+hoIdTjOY3oRhbhhhdTD9mUiWHXipsuR/
         XwUTjnWciWVbWLJEzLwz7tWlDGUazyP/FUtgupFPGahupiMUcqq9EDTgowT7uUEzwg4V
         zLBxLDJIIj5RtXOVqhUi6hcn/MFSD81FLIm3ZQ0Vh6BgzqDtVIgVcrrpCj4p2/h6wtbK
         GnF5Eber5ZPYehykcnn1BD4Ypa5rJwBKup87qurQ6akx0z+2SjgN4WpUwbVQ3ufLwAvg
         QJuQ==
X-Gm-Message-State: AOJu0YyY6UzNgL75GTWhihrl5CwjA4BQ648fBb70kvXeSnfPcVBm0M23
	Ue9Wwq7gUEyc0jwbzMNzMWN99f57Ao6uMZyJzmckoaxnD8sDfW6C4wapApileA==
X-Gm-Gg: AZuq6aKJnPYPm5gJWnxC8Xu/egiqz/pr2LQJjbU8PKzeqLt9timEojFV7Pmk5Ects6a
	YjBI49o9GwaO4zbyrQUz6oT3ijoZNjJa9GAMtdL+2NyF5m4GYwNJ+i1C5LuCIFeNXfvG/fMtnpX
	PDY08hrTcdyQuTWfg6ZYxJ/oTHl/dR/3GH3c5ntyX+TLPsmk8QR3uJvS6MlSxW3X85qvaHgq6xN
	ljDL86ts6hh5GcPjLIK9osO/Zy/SnahlDd6efrEa5vChuOS+h5SoFMUbsKnTkPe++ynjVkyl1By
	MfnT8vo0YQ5bsTRQUkmkkk2hbNiNh+IBGklWsWFwu8pZONsXXNJXbPEOuLuz8Q4DaJ5NpALbnKU
	iCcS+QeZ2+OI1Bfb36oPcLUknjlQ91BpK+Ga0zVRjQets50WUElFD8uajJKmOhDnOUv/6cPce3G
	kpo8cffEBhc9BlnMd7Qu3Tiev6zgOTIeyPPVOwpAyNvt7IC/4yJEe9U4VaCvjtRwfh//wcwpcgq
	fUIm2NT5gzpBnA19DjUAuWJDgsge6Oh9Q==
X-Received: by 2002:a05:6a00:1da1:b0:81f:4884:4fed with SMTP id d2e1a72fcca58-824b03db50emr249740b3a.7.1770839754531;
        Wed, 11 Feb 2026 11:55:54 -0800 (PST)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e7d621esm2810293b3a.32.2026.02.11.11.55.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Feb 2026 11:55:53 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 4/4] BranchComparison: use mime type text/x-rst rST
Date: Wed, 11 Feb 2026 11:55:36 -0800
Message-ID: <20260211195536.10278-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260211195536.10278-1-tim.orling@konsulko.com>
References: <20260211195536.10278-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 19:55:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3217

https://docutils.sourceforge.io/FAQ.html#what-s-the-official-mime-type-for-restructuredtext-data

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/urls.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/layerindex/urls.py b/layerindex/urls.py
index 7555907..51a832d 100644
--- a/layerindex/urls.py
+++ b/layerindex/urls.py
@@ -197,7 +197,7 @@ urlpatterns = [
         name='branch_comparison_plain'),
     re_path(r'^branch_comparison_rst/$',
         BranchCompareView.as_view(
-            content_type='text/plain; charset=utf-8',
+            content_type='text/x-rst; charset=utf-8',
             template_name='layerindex/branchcompare_rst.txt'),
         name='branch_comparison_rst'),
     re_path(r'^branch_comparison_csv/$',
-- 
2.50.1 (Apple Git-155)


