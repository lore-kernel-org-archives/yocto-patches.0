Return-Path: <samuli.piippo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A287C677C4
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 10:09:47 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.web11.4186.1749636583815404809
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Jun 2025 03:09:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PLlLublt;
 spf=pass (domain: gmail.com, ip: 209.85.208.176, mailfrom: samuli.piippo@gmail.com)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-310447fe59aso63259081fa.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Jun 2025 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749636581; x=1750241381; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDmm8RHSWdreR9XAshCrZFFWTXJPJOOmSFwkBV4XWwI=;
        b=PLlLubltbkSZRh4yuCmvJ0U08XhAtiF+WGQ44VFqj8Zzf4dv+9g6rfoJeHr3D/+DPW
         FzLl562XXDnPjVdJ00+WieD4IUA3tveBKslhVUfqz6byoFnXvF1GwRq0MoMSs2RJVj8T
         B1i8LNoTD5kOyHjcCb5ZO5dyKH/Ef1iCS6Kd/MuKU3ezocuyPdd6eiE6TuaM9pc+10rT
         vhPvGHGKO4hUF8WqzMUvjU4v7/x1GECqslh0lRXQl7K3Rs7tGzl4ZD0EcrY7qEUqABM/
         rqEVmiGkBM398ynOrAXn7fz9viIty+B4oD0JpzhYp8mkZSJbgrFLdB9jOgx6e3O5Bkxy
         MiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749636581; x=1750241381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDmm8RHSWdreR9XAshCrZFFWTXJPJOOmSFwkBV4XWwI=;
        b=Ii1NiZG/NMdhNgIplKYLNBVGESXTJxSpCIbSrlX1rL7gFxdIOlexzpcfbSUT7cdtNe
         6PPiHSXvc/CA7Sk2OjSqfumaTXVcrBFhjStuxj/8CJSC3gQN7ly871eW40umNMY+muUU
         ZOw8azRKEa3nh1nENQ+yR2ZByGZmvWPmQxsaDoXeuTdV+/X2SVi4AxAbvAh4HHDjG6Nd
         sRjhPtiCsOm/CuK2oR0wKkdMuchWwFL/nON3+oTAs2uC3CAMbw3op1J9/2OK9Z6ZqK0w
         m9d4YVeW5DbjB86l2H+ON2MaI0/YHrAt5RtxHp76529X47e9UlgM1NvqWE+9Xd45WUEZ
         FnSg==
X-Gm-Message-State: AOJu0YxzzzHz8tKa9ZlATe1NW2XJh5X6fxmETETcs+05wbvaFg8xgcq7
	Mf33cOS12J3VMC4CI7aVyf1DaLLkkozNtfYOKwvPs/5vh9klik3fqxjJwN+TiQ==
X-Gm-Gg: ASbGnctH9LNIuLM9i3RLeUnXAzPvbmfIihM7TjcHeB9ejbpgwL/4QY2S6c4Fy70eVmI
	NeJLwj8RAPY6j4vXyUr79VtPFLjgAZKl1r7yuw+VpCZiWRG+jNPLICttZ+3L8dwUcmDFIoso9qF
	cYPo6thrPhddNywP+K1kJ7bV7qVKtcPSWd4CH0xcYM5MY0Hp3moXVZXcaRrbnA04isK4+LLLPiT
	9yJO3Uck5Ilzw6PM4QVrWUdG/yhr0G4+OmfL/50w5uXPVzmkuodl4J9v0UJf5nVuGeFaSgEeppc
	GZWyIBr0XUKSAeP+izx8gMwnTXEr3ad0Vf1ol6FgIkUmOfk7N4z8oIhFOlrNOnNV4NtQYIo=
X-Google-Smtp-Source: AGHT+IGmwiUIQxFNPzR6UMTeMT4YgRCYUOOb0S9KFWQ39OZGOmczzAJlcSipD38CRAo/l+r1OGY4Xg==
X-Received: by 2002:a05:651c:4104:20b0:32a:8101:bbd4 with SMTP id 38308e7fff4ca-32b21ba0b29mr3896191fa.14.1749636581110;
        Wed, 11 Jun 2025 03:09:41 -0700 (PDT)
Received: from dcbuildsrv.ci.qt.io ([192.89.120.62])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ae1b34761sm17392741fa.26.2025.06.11.03.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:09:40 -0700 (PDT)
From: Samuli Piippo <samuli.piippo@gmail.com>
X-Google-Original-From: Samuli Piippo <samuli.piippo@qt.io>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH 2/2] openssl: enable build without perl
Date: Wed, 11 Jun 2025 10:09:19 +0000
Message-ID: <20250611100919.1067444-2-samuli.piippo@qt.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611100919.1067444-1-samuli.piippo@qt.io>
References: <20250611100919.1067444-1-samuli.piippo@qt.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Jun 2025 10:09:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1631

Remove runtime dependency to perl, it's the only dependency
preventing openssl from building with mingw.

Signed-off-by: Samuli Piippo <samuli.piippo@qt.io>
---
 recipes-connectivity/openssl/openssl_%.bbappend | 2 ++
 recipes-support/curl/curl_%.bbappend            | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)
 create mode 100644 recipes-connectivity/openssl/openssl_%.bbappend

diff --git a/recipes-connectivity/openssl/openssl_%.bbappend b/recipes-connectivity/openssl/openssl_%.bbappend
new file mode 100644
index 0000000..32bd379
--- /dev/null
+++ b/recipes-connectivity/openssl/openssl_%.bbappend
@@ -0,0 +1,2 @@
+RDEPENDS:${PN}-misc:remove:mingw32 = "perl"
+
diff --git a/recipes-support/curl/curl_%.bbappend b/recipes-support/curl/curl_%.bbappend
index 10c234d..5577a29 100644
--- a/recipes-support/curl/curl_%.bbappend
+++ b/recipes-support/curl/curl_%.bbappend
@@ -1,7 +1,3 @@
-PACKAGECONFIG:remove:class-nativesdk:mingw32 = "openssl"
-EXTRA_OECONF:append:class-nativesdk:mingw32 = " --without-ssl"
-RRECOMMENDS:lib${BPN}:remove:mingw32 = "ca-certificates"
-
 # Configure tests for ioctlsocket FIONBIO fails with GCC-14
 # because gcc can now find warnings when compiling the test
 # and these warnings are treated as errors
-- 
2.43.0


