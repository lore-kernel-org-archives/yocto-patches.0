Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA319C4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 19:36:22 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.24984.1714505776961375901
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Apr 2024 12:36:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TDvuPb5U;
 spf=pass (domain: konsulko.com, ip: 209.85.210.181, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso5448947b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Apr 2024 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1714505775; x=1715110575; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJuy8Jd0ddaVcnGjWDtDZ4AVYe6eXI7IZGsiNx/aNwc=;
        b=TDvuPb5URV0h7wzZu10YTlH1zjXYK3BnJASpx/1+Ry2lUCCBBYZVw7TNQJtUdIJ/g+
         i/Nr1R59ozZdb7acGLiIhRPIEDena4Qw70i6afhlc3DlnDFHP8ZIqUWaweFANHSfExNc
         MypnsS8Q2AYslKCEbsxQDp9lDCx+leywbiD6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714505775; x=1715110575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJuy8Jd0ddaVcnGjWDtDZ4AVYe6eXI7IZGsiNx/aNwc=;
        b=oEdpX13hVAFBivNM//xNIuO6LIq71ofmz+0diJXXO4e4bu/5S4eyqiEPJxLXZaKCdC
         /3T9SbClXz9wTz8O9Zaa1Jpq18lNvDceAUlQ7XQAG7AZ/SrHzKtel1EnSRu7cEJI/H4R
         0FZR+u0bRUdJNqfVt7mnP9CUc3tsKJTQaQcTDNxKwZsFZJkOuzENfYWkk6TNPoL4xgC0
         8xkTUtfeVdPh60U47KXwi49lS9AJiJ5H4LJ75JdY1aso1McpeoT52m70CgBl6qc8nQ7A
         9GBJJJMSjtPnzSgUIWUCm+/Kl/F9hOnaEOMI3m4EIVa6A6wKMJeL/oGepOGduxaqj3v6
         fF5A==
X-Gm-Message-State: AOJu0YwY16TcmtUEX0+28gRg7ybtN6J1kGa1qHycrzzJE4JYFwklfnuH
	BWBAjH0ew4rH55CMvK0X4xxQYXVcs60ZsJ5RqvXbbkd3XLk88sC8ZcQkyMxl/UxJwr+Pqf5jmCs
	dQn0=
X-Google-Smtp-Source: AGHT+IGzXxvp+2Lwm/1UnxKoOPM7srrp4sfobe/cg7u2o2wLO+GE0yItcJh8QpIWu50pVsui7CItvg==
X-Received: by 2002:a05:6a20:5a11:b0:1a7:a4d2:4516 with SMTP id jz17-20020a056a205a1100b001a7a4d24516mr716391pzb.40.1714505775460;
        Tue, 30 Apr 2024 12:36:15 -0700 (PDT)
Received: from localhost ([2601:1c0:ca00:bd60:e8c5:20ec:b8be:259c])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001ebd799bd1csm4327006pls.13.2024.04.30.12.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 12:36:14 -0700 (PDT)
From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [meta-security][PATCH] swtpm: upgrade 0.8.1 -> 0.8.2
Date: Tue, 30 Apr 2024 12:35:51 -0700
Message-ID: <20240430193550.3378839-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Apr 2024 19:36:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/73

version 0.8.2:
  - swtpm:
    - cuse: Lock file_ops_lock before reading tpm_running
  - build-sys:
    - Add support for --disable-tests to disable tests

https://github.com/stefanberger/swtpm/compare/v0.8.1...v0.8.2

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 meta-tpm/recipes-tpm/swtpm/{swtpm_0.8.1.bb => swtpm_0.8.2.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-tpm/recipes-tpm/swtpm/{swtpm_0.8.1.bb => swtpm_0.8.2.bb} (97%)

diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.8.1.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.8.2.bb
similarity index 97%
rename from meta-tpm/recipes-tpm/swtpm/swtpm_0.8.1.bb
rename to meta-tpm/recipes-tpm/swtpm/swtpm_0.8.2.bb
index 7a538da..b987f59 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.8.1.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.8.2.bb
@@ -6,7 +6,7 @@ SECTION = "apps"
 # expect-native, socat-native, coreutils-native and net-tools-native are reportedly only required for the tests
 DEPENDS = "libtasn1 coreutils-native expect-native socat-native glib-2.0 net-tools-native libtpm json-glib"
 
-SRCREV = "d2849a9f5ced70438d67036693438344b47b4161"
+SRCREV = "507d14219dde88eb3eb2d10d15872d4044aa9d3e"
 SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.8;protocol=https"
 PE = "1"
 
-- 
2.43.2


