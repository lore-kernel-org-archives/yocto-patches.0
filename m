Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67434C3DA6D
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 18:17:54 +0000 (UTC)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
 by mx.groups.io with SMTP id smtpd.web11.28097.1747765069394434025
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 May 2025 11:17:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dpw9BDER;
 spf=pass (domain: gmail.com, ip: 209.85.166.180, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d8020ba858so58656735ab.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747765068; x=1748369868; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC5bOz6YZ1gKKoQpXOYMvw31MkG6GHcEOf17CQFlXgw=;
        b=dpw9BDER1cech3ry9DfpARKI2RlB02SnptuaLJ3rr0xEiZ4xOJDohhvfNIrIjVQOYc
         MSFCbLNCKz76SDB+I6EAqOUfBvTeQmkIY32YFiz+Ozm91tfHxebA8hx4r34Uk3ldyh9h
         rX8M9pxzbFdhY1GX77tBWzf98meRK0e945H3Yj5EHNI/8bIW7ihGXK9FC37ikVS/ae5/
         Yyh5EwSlfyvcya0COyIGxny6AobUCrbI40//7Fmfrnw8V/oocR2c/HICeMF1jj+m8OoA
         BO1Fl5r58K2N6HIE+6duACRvvHqkrRReeIEPO6jS1tLXmED+kJeJ3Z6SW4x23K9/W/cq
         l22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747765068; x=1748369868;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gC5bOz6YZ1gKKoQpXOYMvw31MkG6GHcEOf17CQFlXgw=;
        b=UihUe9fmKm1crXURoPQLCH5zgTE0BlwBk62ZUX43nnsdl2SFoIQKPZ194c3tA/DyUA
         hfxYp0sUFZEClev45FZpkXpBF9icdAkvoisEEHoFpUnfEDp6BQjTxn0ya/9SzzYhW6+n
         MQ4OhCkT7tOUzHjy4HmXfXuEUGhwWd8mjmKUegJTQsgwYbLq/LmFTf+2SD7lBjBZse++
         yCDfQ+Hn5+o1HJzbv1mSn5SsHRrj9xsxp4i9otfc55sqA6UVuRpNrAPHFDGH6zy3Vj7+
         b2oBXQjPDzkZo0uX8waTG1GiRL+6i/sPxrBuyWOihp0wdWEG6Z2CF0m0gSMY/SGOcv3r
         qmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVczWJRvTdOiqGW/YH23gwr+0N5y2asOprJ2si0ypt/aaWjUiErC4bjlR5YAa4tgkQJ5HT7vLaoiAnoKkPF@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwRSr0rKXDu51rutfSqqofaI/5rFcSsFgY/IOGSOh6XJYbN52NV
	PBvTC/ZRrKUw+u1f4xPWumxK5QmtDyaMdKXnU5ab5NZP8fuQyhQ7BMVP
X-Gm-Gg: ASbGncsUMlJhS0k26ZYfsT1bHnjxxeRVHPV2trOT87XkNddo149uepx/TPTCDmRGkN2
	5Y+h9+VdNy+jMhsCB3dg5xhl/J2QsE7+eHQi3yP4e5O92JiE/XKicwgw/h8I8wn1vbD4CGDqaP8
	/eINg0lR58FRlBfVGXPcBZm6MhRszUFBsD66AHk13INv0Ijpv4WKoftRSt9ZP9i00qJ9h5R4Q6j
	SRBVrzSxqCjtJ3Wbrk44aPaIsG1pDeonWHWmdHVIRLL8djGKnE29b1uLuO8QkPbOXGZAB4lHqTr
	FdwyTpp/p7okI3Udcy6aQbN1I0Ko7LhKzhuh0wUgmUIswhzPHlBQ645T6bFhBJF5MlednFyI2Vf
	uJGkQeyTJnoRhASOxEtCVAspkqTWN
X-Google-Smtp-Source: AGHT+IFT/Apq9UhBmngXdgUkmxW6oxTx7Uyg7rcf6qb6O5+qWVMoDKUXg6Er5l0BuJfZKjLXiE20nw==
X-Received: by 2002:a05:6e02:1f87:b0:3d1:a75e:65f6 with SMTP id e9e14a558f8ab-3db84324635mr237158245ab.18.1747765068563;
        Tue, 20 May 2025 11:17:48 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc48c464sm2430391173.93.2025.05.20.11.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 11:17:48 -0700 (PDT)
Message-ID: <692d6d73-dd31-487a-88cf-104e90323e33@gmail.com>
Date: Tue, 20 May 2025 12:17:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: akuster808@gmail.com, yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata-update: add package to pull files
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 18:17:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1569

suricata has "--disable-suricata-update"

Original add: caaeb67863a6 ("suricata-update: add package to pull rules")
Suricata dropped: 7a1691c03726 ("suricata: Drop 4.1.x its EOL")
Not readded: 818a8646a689 ("suricata: rust is in core")

*Changes*
1.2.1 -> 1.3.4
Drop period and trailing space in SUMMARY value
Use HTTPS protocol for SRC_URI
Update LICENSE "GPLv2" -> "GPL-2.0-only"
Add "python3-shell" RDEPENDS to resolve:
  ModuleNotFoundError: No module named 'shlex'

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

 .../suricata/python3-suricata-update_1.3.4.bb   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 recipes-ids/suricata/python3-suricata-update_1.3.4.bb

diff --git a/recipes-ids/suricata/python3-suricata-update_1.3.4.bb b/recipes-ids/suricata/python3-suricata-update_1.3.4.bb
new file mode 100644
index 0000000..0b55ad5
--- /dev/null
+++ b/recipes-ids/suricata/python3-suricata-update_1.3.4.bb
@@ -0,0 +1,17 @@
+SUMMARY = "The tool for updating your Suricata rules"
+HOMEPAGE = "http://suricata-ids.org/"
+SECTION = "security Monitor/Admin"
+LICENSE = "GPL-2.0-only"
+
+LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548"
+
+SRCREV = "65bd3d72855a4cbe8bdbd9f2586f5409b3efb6f6"
+SRC_URI = "git://github.com/OISF/suricata-update;protocol=https;branch=master"
+
+S = "${WORKDIR}/git"
+
+inherit python3native python3targetconfig setuptools3
+
+RDEPENDS:${PN} = "python3-pyyaml python3-logging python3-compression python3-shell"
+
+BBCLASSEXTEND = "native nativesdk"

