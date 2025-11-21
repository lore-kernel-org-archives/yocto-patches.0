Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB815CFC279
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 14:21:46 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12419.1763734902387864212
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 06:21:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GgIJKjUz;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b29ff9d18cso202768185a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 06:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763734901; x=1764339701; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tvj9SdEPTVAHjiY5kMNb4gprxmv9eMJMsqrlwMTp63g=;
        b=GgIJKjUzjUq04X5h86RjX2DDFllUBzXERhIzhLZ0cNsaawMXny+iM0WtUaicPXAhzH
         S7Z+clS9+xaJ1lZOtMvIXxL6eseYZbB3poWBVhHyTq1STxjvEuod5b8Y7fVQCaBdo9L6
         P2IDc09hI8qenOeOLO0TDKBm+QelZ7J9pKVgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734901; x=1764339701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tvj9SdEPTVAHjiY5kMNb4gprxmv9eMJMsqrlwMTp63g=;
        b=vF8xFh5ahE9SXYRd/+/BlwH821P07q/mxJuJ7gfKdeqwSIfwhZNtQfF/8gB1aD/QEa
         UKYUh8HskZLs2yO8yDchVD7q7yKXL6uvTuRIKX2St9FRg9X8GgcEfRbgzjrPlQp904Qo
         npHHxqw7ioez51A6zNMgmwDkW2Cjx0jz5UKlzUFAAVv2xTAYg2KRhN/BR0glH1XV9Ygg
         aC2/M83TAZQSq2omA0njUZwp+vKYnXL0vTtXpVaoTBKrQ4sc26DKcx9z96LUtV7gYvQ+
         lpswbWPNdoFhkwaRsdEj/02xKHY++C3NHmEPPEUVttVfRfwF5wQMEzyfg8Tk6DABpC1O
         jepQ==
X-Gm-Message-State: AOJu0Yx/iVYmk3mXmaDdGMT0wm7nxaGlLSZ6eG1nbi5qbmABtUVYBnA+
	kK30V2N1y3vbdaS7oyPv3phryNtFBvqrT80G3jdSX2WKCRvUNu1eEL+fM2yl26nAM+LSVbHr7UQ
	HWQ86
X-Gm-Gg: ASbGnctJqVNYL6Ca9eDhCpsyn7OUjHCR/RvL/DS/32KTVRVoOIctLvOpIKHE7RpRYmP
	0yao+H8XK8aJ9Hnbz1msETnDF+M9VaUBqiDoZYdIa7tBZP3AUmSvFlas/HobtcK8yDh3qKgIZqI
	Cmm8ldxZI3jm2FPH5H72o78p/UhA3ESDuNGIs7Jo0jUrKR3VhQ9+LTd7o5O/Ba6e/v6ulSXjdW1
	QV2o6BzWmL/ebDz3R2OAYCDBpoV9ElLoQ/XESCvaazKFCkOsNR5DpvwBiJZP1uxKI92BSvlRv9X
	oNUozPG/zdd299gIcgtOpnqMecQBqxLbNI7YA/qwJQgJ70YkFZwjGta+ZR6mb6PsYg2MPWM4wNe
	Tj4Gp+SvO6wfir1jDgiU8+SXVDFj2Z7nYrsKb6SbHcQnCrZVRHuZrYsXwG17yL3hOioGk22Wlba
	fX30X+Khj5fUcTyh4BJV7Yw4kM6cc+rTXt4K0cPNxd3LGdjHbJNRwpjttGF2hseIA=
X-Google-Smtp-Source: AGHT+IE2016yM1CFKFGl6Bp/aWGSVcE+4NIUlQ//QRH9q7r0kXmTX5lRHpu3R8b9VeRNt17Pj48pfg==
X-Received: by 2002:a05:620a:8e84:b0:8b2:ed93:c96a with SMTP id af79cd13be357-8b33d269bdemr178966385a.50.1763734900950;
        Fri, 21 Nov 2025 06:21:40 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm374815785a.37.2025.11.21.06.21.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:21:40 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 6/6] libgssglue: add UPSTREAM_CHECK_GITTAGREGEX
Date: Fri, 21 Nov 2025 09:21:20 -0500
Message-ID: <a54650c743b7534f60fc6ee1df9b57a8f0150a4d.1763734538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763734538.git.scott.murray@konsulko.com>
References: <cover.1763734538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 14:21:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2650

From: Yi Zhao <yi.zhao@eng.windriver.com>

Add UPSTREAM_CHECK_GITTAGREGEX to check the correct latest stable
verison.

Before the patch:
$ devtool latest-version libgssglue
INFO: Current version: 0.9
INFO: Latest version: 011
INFO: Latest version's commit: af30789052a8cc5f86b5b0c8fd4758c7ba1505ff

After the patch:
$ devtool latest-version libgssglue
INFO: Current version: 0.9
INFO: Latest version: 0.9
INFO: Latest version's commit: ada76bdaec665f70505f0b3aefe871b873e7c4b6

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/libgssglue/libgssglue_0.9.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/libgssglue/libgssglue_0.9.bb b/recipes-security/libgssglue/libgssglue_0.9.bb
index 3bc37cd..0952ed1 100644
--- a/recipes-security/libgssglue/libgssglue_0.9.bb
+++ b/recipes-security/libgssglue/libgssglue_0.9.bb
@@ -26,6 +26,8 @@ SRC_URI = "git://gitlab.com/gsasl/libgssglue.git;protocol=https;branch=master \
           "
 SRCREV = "ada76bdaec665f70505f0b3aefe871b873e7c4b6"
 
+UPSTREAM_CHECK_GITTAGREGEX = "libgssglue-(?P<pver>\d+(\.\d+)+)"
+
 inherit autotools-brokensep ptest
 
 do_configure:prepend() {
-- 
2.51.0


