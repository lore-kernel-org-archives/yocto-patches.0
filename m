Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B6CAC598
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 10:23:42 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.19262.1758104617727512078
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 03:23:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RtwWwNg9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ec4d6ba12eso1282663f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 03:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758104616; x=1758709416; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MVoWxIkbxJIWzh8y58zdAy73ArsRm09vsCQFrOKwd4=;
        b=RtwWwNg99wkIfY982avGTvdAYGz1lVk1hvVVs/eD9tSQA5NAePkU9wUck45gPBKRSX
         EfCLgSb5hiTzjaFn7D/b9vvzw+QzbfIimPStjfyCcDFmCqjXCyv+1JCuT13UMFYR+zwQ
         rgxmB/CJ7FyABWCHknQK85A4xXxfo6yJT47SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104616; x=1758709416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MVoWxIkbxJIWzh8y58zdAy73ArsRm09vsCQFrOKwd4=;
        b=ZeO3twNIFOc2swAqn4wcBCeL/WZK03gIg1JMCaUSF0CczeNK7Vp0O0mWYK3OqdW7s5
         0S2Aou5ZqXa8lgwv9z01791vml8BqzIxP5WIUX3Kkxfb17V1onr2byrJH//bw4L4S3+s
         zUXeHbGaDjRKQ//JbSJBmOqRn5Bblo1COMfuHhbhYW3ksqYRLYn+EN5smT8fFNI2TIbT
         UObqzMQ6nnZoIEZ50H4xAOdTOn57hapzYfxUTNDOPUOUoHb8QjdqdjlhZVrQexajJe/S
         0WDwUc4UM2duU5BNQ691fkTm0hIY7NeNeMZtEh6SAP4DeaWpXXwYz83AJRnN/dVyVJeB
         GO7g==
X-Gm-Message-State: AOJu0YzJTcREtCFknMfoCYe1I3IZ7W7MlPEiszpofXFGH/CRYIWX00hN
	EATUMP7rYk/5B9ygaAtSbwJG7/NkKO0TCO+ZLWFvfACCnd+L3OtMYCloTTCo4G+QNwyOmKvj/hf
	iMHgJ
X-Gm-Gg: ASbGncuoeQ/LxHHG8AeL8Tq4M+j+qIyTyg37UCSTk7ejqC7hDYHF6qp5NNtqj3YtfSE
	Im3uIqmrc/BJuZdItqZyetDvoMCcAPrupFxvYLqrlgGFiYe8U/wxFQHzm/USBDQZ0jONm94T3WP
	JIT26holBotpHqscrB7B84OwnJUH0b4bs7/wPrZheONa8oE5kwKMZenKiJsA42w8JPZO7A/aFSu
	nsuLH2o7VxAGm1w2qCbz9d2QRSG9/GNPMJAbfwupG/Cgm8qUgTAavUnC0q67FJi/B7LlkQfurpv
	Qd9zEV29+NMQJR+thXHpuAKE8QyjQJlSZmoUiQNTXJUVCMJvk1hK+4sjFrfiILxqMS2UlBnIRA2
	h5yVa3kF5qGfhLvGS8CTA9EynhtUJWfaIGeesplxmrVqnk3nzdV4=
X-Google-Smtp-Source: AGHT+IH2WmMBcHAwDxI49eOQ6F4wEzLEYwsLVve+mZrT1pWC3DNB3WUf48R/jeJeCTCZuUBqYmM7lA==
X-Received: by 2002:a05:6000:430b:b0:3ea:6680:8fa1 with SMTP id ffacd0b85a97d-3ecdf9b88c5mr1597855f8f.12.1758104615429;
        Wed, 17 Sep 2025 03:23:35 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a42a:bde0:2db0:730d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm25442931f8f.31.2025.09.17.03.23.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:23:34 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] janitor/clobberdir: Ensure TRASH_DIR exists
Date: Wed, 17 Sep 2025 11:23:33 +0100
Message-ID: <20250917102333.1876432-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 10:23:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2204

Rather than letting bad things happen, exit with an error message if
TRASH_DIR doesn't exist.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 janitor/clobberdir | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/janitor/clobberdir b/janitor/clobberdir
index 16b019e..a5f69b9 100755
--- a/janitor/clobberdir
+++ b/janitor/clobberdir
@@ -49,6 +49,10 @@ if "TRASH_DIR" not in ourconfig:
 
 trashdir = utils.getconfig("TRASH_DIR", ourconfig)
 
+if not os.path.exists(trashdir):
+    print("Error, TRASH_DIR %s does not exist" % trashdir)
+    sys.exit(1)
+
 for x in [clobberdir]:
     if os.path.exists(x) and os.path.exists(trashdir):
         if (os.stat(trashdir).st_dev == os.stat(x).st_dev):

