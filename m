Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CEEC35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 19:57:29 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.3953.1742414245988110841
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Mar 2025 12:57:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IqXTC9/q;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf680d351so7246055e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742414244; x=1743019044; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOn3Wp9j4Xu3dm2ou/KK7rETWzCvrNsVuMnSBOV3Ae8=;
        b=IqXTC9/q3rgPwWq4FsP4uGjJ9Ru1XrkDAQd70W4+Z0Uv/BkdB7n83eXo06szo4hV3b
         mq5pvRz6R32v6c0noFJFl4VJFbvzHSIRbvwpR3ibqkDek1PCjc7wAaXsuyRS2uez5I20
         hGhrRvfa+Gp/OvChrn1ZlLa/MlsusrMy2wpVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742414244; x=1743019044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOn3Wp9j4Xu3dm2ou/KK7rETWzCvrNsVuMnSBOV3Ae8=;
        b=xM/8ONmdqnfVEfBsSHBRtIlO8m3zKs8/CjaQVgV4RF9kPUN9clUmn0Rb4tzYK3ZU+Z
         rvBTfKIrIIBPMLRaOgJqWVlmeDA96J7ygF+FOXrWzortnqeQjI16ZvADSwcBN1Lp2X3I
         uYOj+xAlp8S2OWT+G6V7+wBueonM8kS9ogaWp00/jRJ3kk6vsLSvuNlla2b6x5bByJIz
         6RAP8ZAFUqmQGpZapMWJUuqI5YTleCmJpflbPE5Y8W/hsPEh3S9Up2RRWwKuHQ5nfK2i
         WD+XjDzxcdBYB2+yzbNotlLHeuOUvGETm1mdEwWx7w+YwjLb1Io3chYi+YJRyPCd8KKt
         5kMg==
X-Gm-Message-State: AOJu0YzvJ950xOxncvGw/0gueAhcjKu/BAw4D2s5+sR/W9/3jZZPooDY
	z24TvhvB0WPdw4C90GxjaEALZSG5zdQtLWwkf9n6p8xDPL525vMZUf4nQzk+1cD7xiWa2BcT/TI
	/
X-Gm-Gg: ASbGncud5nbt4WfaQ8Y174vb8LTzR2AXHd1vY6FDuVCbbVDrNdPW0YKqsHMZbx0nFlq
	yJHebSvsz28tyLWBABuvvqh/cUgJ7Kp2WOTNuE1Jy8rDWpGGBjgQEkdkaCfZ7MB2Rm4DLpAaE5y
	8adRbeKinD2XJNE4Kch3lSAhVssPgPRALMvFVP97YR55Ccc9yz2uzU8lZRI1c0t4r530DmHBYC1
	tE2V81jxVNac37wDo9Nq9kUFUqoKcrHYw7HsKgGD6BEPjUHC+0wi13BMUx+1Qj7nbCkczZzIliv
	mn9PG0oJZ2TOpQ3FX7a1LbumQtPuS0fymrOIzfai2mB3UC9Lzvj/ftTwcyJmAUfiU56CelQi
X-Google-Smtp-Source: AGHT+IFiFAR+GmXeu59cfSsWrm7ePIxBtGchSWgs8btHQcqkk7LIYr2WUwmQFVIlu8Q0zrLIEStTOg==
X-Received: by 2002:a5d:64ce:0:b0:38d:dc03:a3d6 with SMTP id ffacd0b85a97d-399795567f7mr788090f8f.4.1742414243379;
        Wed, 19 Mar 2025 12:57:23 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dad:b471:9c34:4577])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f84f9bsm27550785e9.33.2025.03.19.12.57.20
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:57:21 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Use buildtools on Ubuntu 20.04
Date: Wed, 19 Mar 2025 19:57:19 +0000
Message-ID: <20250319195719.860431-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 19:57:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1226

g++ on Ubuntu 20.04 is now too old so switch to using buildtools there.
This also lets us switch to a minimum of python 3.9.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index 00d61fd..b8083c4 100644
--- a/config.json
+++ b/config.json
@@ -1988,6 +1988,7 @@
         "opensuse154*" : "${BUILDTOOLS_URL}",
         "opensuse155*" : "${BUILDTOOLS_URL}",
         "opensuse156*" : "${BUILDTOOLS_URL}",
+        "ubuntu2004*"  : "${BUILDTOOLS_URL}",
         "perf-alma8*"  : "${BUILDTOOLS_URL}",
         "perf-ubuntu1804-ty-*" : "${BUILDTOOLS_URL}"
     }

