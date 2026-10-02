Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5743ECA5FE0
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 10:28:04 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8140.1790936874252043207
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 02 Oct 2026 03:27:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OqAHh/9y;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.141, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a11603310fso3529845e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 02 Oct 2026 03:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790936872; x=1791541672; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JKH9RNS7f5sNL9Mifr59F+F4gxGt5pF6yNWhrGTEqFw=;
        b=OqAHh/9yYuaeeey0n1ZCaCx7y2ceFeSIfcnucwcWqxjdmLxg2vID1l672PATsOE2C2
         SfUM78hweviFINGj0VoVcvSIMNCOCILmTQLZArwPyehNiGCU9ErAaA7sLcqNZGYKHj4H
         jMvGxUGpB9a7RI7m0Fn3QtYuJrbaaxOvDnAGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936872; x=1791541672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JKH9RNS7f5sNL9Mifr59F+F4gxGt5pF6yNWhrGTEqFw=;
        b=tYDLEJ/MuukVHSymacKduHHQZ+TFxSJ3IMiPwRg7VcjCWfWs4vNweUeIhRmN8oHBjX
         ju3hdFvZoNpOYa0Jp62XmpJCOKEiyC2C/AICJ0/ayKHPQ4I+e52uUqv1HjVCsOnKbbw/
         0yvx3/rlMYBjapQWyTvsyCAxiyqUipjR20o0A1hMxDJYaaandFDLgs277M0F+DYzK/p6
         /uG7iMrPj20Z2E89YeW6r7wxCd68hsS4MzeFl9BgAv2KX6NWvcNsm82K7eUiUT28qdk9
         2g0I46HON6QJmuAc+R4RIVxs1BiUydT+c4x1OiK1ekTJf9BupZxA1rkVeh2hQS7/EBIT
         1S4w==
X-Gm-Message-State: AFuF++lzrPZ0KWKCpousyr8KiV/AgJSsYQFPp//fO0c9SM6LTcmfo5Ep
	ywPHSN9DwTviAY/v1zrpoJgxkrD40oMpRNb4apNUrg2BqG+YKSG7ETMw+DaTPYTxD4iIsee99EV
	8DDDqc20=
X-Gm-Gg: AYBFou1WsQNO6GVlqX/pMW72A5cdl8fMn2brbUBGaBY7Sw0X1WqC3HoGjWJiZRsT/hL
	0lEIBv9cfaoVUf2AubBBFvPB77IXlCA+rdMI5G3AH06LRUQPoK1vqKSIvtVIjaFL7uI8H6R1zOT
	lDarzK2CSCRMkZE9rp6vbmkfjDfRLf/m0cM9CWyXQWCYyVufB5mkUAVhkJHy+GWD9K2If4fZH+f
	df7LcAaWskLMjsaSrmkEFzDzxOmSVffme8wgJ4ddagJ5Z9frv+bLkYKhlMM4QcndEm5Tj8LQvHm
	zELvTs+9aZ4koBV3qhoeZwA121HHUwylH+GQmahRIm2hua4P6geLMh4UUGqCir8oAemPnC8sWjX
	VbjFEdPN9MTw6zS5/MMls9W+JiVqeM99mVi+qixlw3N6hnGV+ndDjTHuilGsqu3KgvtmVuaM4bJ
	0pwPvNv6Jsh8jC+TpkbXlwGwO6Sls9gUEfLaHlufCAEEPyIK9B2LotgRbPMnzHL/F+362oGcsGf
	G86hTdk2Llw/SZWlSxGSj4tZkc=
X-Received: by 2002:a05:600c:c10c:b0:49f:dde2:3906 with SMTP id 5b1f17b1804b1-4a027579533mr30224625e9.15.1790936872275;
        Fri, 02 Oct 2026 03:27:52 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:755a:bfe8:d050:d1c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c84a9sm61716795e9.10.2026.10.02.03.27.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:27:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scrpts/release-parser.py: Ensure current dev milestones make it to release.json
Date: Fri,  2 Oct 2026 11:27:50 +0100
Message-ID: <20261002102750.3382896-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 02 Oct 2026 10:28:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4977

This needs updating after we standardised tags accross all the repos.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/release-parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index c147d1d..e4ed5ff 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -170,7 +170,7 @@ tags.append(
         "latest_release_date": "",
         "release_codename": CURRENT_ACTIVE_DEV_CODENAME,
         "latest_tag": "",
-        "releases" : list(e.name for e in filter(lambda e: e.name.startswith(CURRENT_ACTIVE_DEV_VERSION), repo.tags)),
+        "releases" : list(e.name for e in filter(lambda e: e.name.startswith("yocto-" + CURRENT_ACTIVE_DEV_VERSION), repo.tags)),
         "status": "Active Development",
         "download": "",
         "maintainer": CURRENT_ACTIVE_DEV_MAINTAINER_NAME,

