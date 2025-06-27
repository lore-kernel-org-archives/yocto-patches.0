Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74046C77B7F
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 22:49:02 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web10.3275.1751064541097760824
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 15:49:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bb+avzgZ;
 spf=pass (domain: gmail.com, ip: 209.85.210.41, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-735ae68cc78so1616254a34.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751064540; x=1751669340; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G3uQZxBREleeuA9XgGRZJpO8lthcxXNkjWei1UtmAg=;
        b=bb+avzgZyfKugKU6+wUmRbrTJQNOWkQlJVOwnowIvtIHjXpKmKUexDGwVHE+iQcvp7
         jbl47yCF60cZ7NWhYuAPJEarMTwnWv3qQyOZJ20jWAe9RPU28gJC/kngVEDSSFlkqQ7l
         RTP66hXC15GfBSLkF7aJ8L/1sov4PBjdwgNirpGL5dg1W6mN2e8tpYQ+EWqFCCytV3hb
         crlR/e9KXb2K5rdZdBEx7/85J+PCdjefgRncZPZ5MfPEJCLwEe/EKdU9oE76qDYsUh5H
         OxYm9ljXt9PShqWbfgnAdMHOP/OPreZwjl41YYgpgH4DCWA2xi1qMIww16qy9Qi8mt7e
         a7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751064540; x=1751669340;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9G3uQZxBREleeuA9XgGRZJpO8lthcxXNkjWei1UtmAg=;
        b=B+EfoyCoNK2hVVIlLwkZ9OJDl0OYELNH58l9ZRwl/BLxnAQ7P+QVOsYobkaCzXWY1q
         QPaNuUZxM6nSkAxVQBzzGlSUfOxXxtzGLFy2gD7H4Z2yr26O4WpRzpzx3PHDt4T9Kw5O
         /kGlX3ffRAfjlx9lUwynq4Cit0uO7GdsxaXEvEftHPNBKdAAGUPmQJJwqNDcXEs9C9wn
         cQirSlfNTziAn5hkcJ2YrY69QAQN15fAqShlzXH5liMsEsWmK2MaBGoazEl8RGUSOMz7
         TuLRp6EYmessMw+j4Yl82MTWxxGkMUIYF92B5f3lPkKpTt5UvLANd6J6FcF2ctgYE1rr
         W4FA==
X-Gm-Message-State: AOJu0YxAoH0v0cSkNiNCE1bUXSqnHC5s8Zc1CdhhIvxrtaAuonPJbbWW
	zfY+0NRceJOQz/UakdIpt68Qh6+oHU9kMlDeHu1lGlJYXiJFby6cS8CbmL8LCA==
X-Gm-Gg: ASbGncsOoQgE+BGsDAqf0GBF88t9mvAzFpzqsQHddts0YyzCiW0W2Jo7cA03uUgxzHS
	Oxu0ZBKhKHWGJhEUK0RCCIb/QHgua+zv3g1TWvuQ16BzQS06nUehn13jdG3BCn8oU9O4Vehbtm4
	iPef/pWBEmvwA72kZypWAliyufcCMZyV/W51IuNTGYl/Dz5tpIQ+BMEYUDf/na0qhIAu6cwT+ic
	X/gadIzqW1nvmOlanSghmxwV1MyuhT/nag6VqUhk8uJdroEZlXmHkkST1uPVWNR+2XFmZEcbHPZ
	u79Ii7WZelV7nO23JuWyeW6TH3CFQkpUlp+mE5xfbEsyPOeYH8DfyewHP4w1WEoGk1h0o70OvuY
	Uq9hiF4cvG8/C0GyDOIaRrPYzZo/aCi2L1dRyJTw=
X-Google-Smtp-Source: AGHT+IEgWt3YfOG4PGisCTel1sE6Pn+PFqYhPFd2NCow79PQdZOzl+w+YrBbb5t5pNx45oUivCZt3A==
X-Received: by 2002:a05:6830:6501:b0:734:fcd4:d1f9 with SMTP id 46e09a7af769-73afc655594mr3106853a34.23.1751064540234;
        Fri, 27 Jun 2025 15:49:00 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb02bf67sm540245a34.30.2025.06.27.15.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 15:48:59 -0700 (PDT)
Message-ID: <601934b3-5e3b-44ea-af40-36c4deaeef8a@gmail.com>
Date: Fri, 27 Jun 2025 16:48:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com,
 rybczynska@gmail.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH v2] smack: Use new CVE_STATUS variable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 22:49:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1726

"CVE_CHECK_IGNORE is deprecated in favor of CVE_STATUS"

https://docs.yoctoproject.org/dev/ref-manual/variables.html#term-CVE_STATUS

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

v2: add warning message to commit body
v1: https://lists.yoctoproject.org/g/yocto-patches/topic/111623070

 recipes-mac/smack/smack_1.3.1.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/recipes-mac/smack/smack_1.3.1.bb b/recipes-mac/smack/smack_1.3.1.bb
index 6c52392..7b20e6b 100644
--- a/recipes-mac/smack/smack_1.3.1.bb
+++ b/recipes-mac/smack/smack_1.3.1.bb
@@ -13,10 +13,9 @@ SRC_URI = " \
 
 PV = "1.3.1"
 
-# CVE-2014-0363, CVE-2014-0364, CVE-2016-10027 is valnerble for other product.
-CVE_CHECK_IGNORE += "CVE-2014-0363"
-CVE_CHECK_IGNORE += "CVE-2014-0364"
-CVE_CHECK_IGNORE += "CVE-2016-10027"
+CVE_STATUS[CVE-2014-0363] = "cpe-incorrect: different product"
+CVE_STATUS[CVE-2014-0364] = "cpe-incorrect: different product"
+CVE_STATUS[CVE-2016-10027] = "cpe-incorrect: different product"
 
 inherit autotools update-rc.d pkgconfig ptest
 inherit ${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager','systemd','systemd','', d)}

