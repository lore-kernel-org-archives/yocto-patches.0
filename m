Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881D1CD5BD2
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:18 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7307.1779625696425261407
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=OjF+SCNd;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-914bf787977so162762085a.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625695; x=1780230495; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXgKG9kHYaF7F/qtoSM3l0FSDA2aR7vBLkknzTj5q0Q=;
        b=OjF+SCNdPmm50aKotGyafAG/tSnPL6Yebc8jpJqDKyz8pYzxnOU7kXXR60OuEKzGIL
         8socTpn6djoRMd+iGIr9uvO5iFTwhtbkYgytNXYbY2otkeR4HW2FOkVE5lKAKr2xSj5Z
         QLSq4UqVDkF0kirrRokH0hhmBbyXAy7paWaZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625695; x=1780230495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RXgKG9kHYaF7F/qtoSM3l0FSDA2aR7vBLkknzTj5q0Q=;
        b=oY7rBsxYF0b4ME92pIRVZOem5Q3TzyVrljDsIzXe33EkhloGdI1HOzUOLEuP/zdjXh
         wRHv/99EqnQHstrJq54mJrEHx9RtvtrCwAwKgmV4Vmav3cXBaU7UtssHy7zwcHd5rf+Q
         tahTMSoR2h6tqvDge4rV8ZqOwo3YcvjKph0jRheVwRJiaVKF7dldywvyHCmZH1o0AdGz
         brmbK32l9t090SrVr7zOaIXFfKStxIjyr5HKKb2FdAuOvRxJlP58zJI0IU+shx2LxZ9k
         G2FvStbsOywFpmZ/EUCs1DCBSZfR7Cnuzd5FzcYnZ1Hjfevi+asRfaBo2G9NTTTlq5KA
         ZX2Q==
X-Gm-Message-State: AOJu0YxD0n5fY2wv05MKaD1ldy80OJ02cCAme2tVIaOlmOV5BR3TkNhy
	tssT+GdqpgZHhiayXH0mMBLWnbZiX6wZUVFkSVjXQuhkU/v56Iol+WCE+ZPxYZf2KQfIFiuvtKe
	woZ76
X-Gm-Gg: Acq92OFRMeGQP7iGsqO1uA0znyBIyaLJbH7YysG2lOEQz+Dh92wI2OYyeiWfhHokvAD
	BajpYGj/ZaNShMgjWiIAvoniqMjBDSKnI9FceTq9iydNZitQ3KFx63swXGADWc80FBtYjewShOK
	XBeuKsJfznE5326RdTSFOt5SVYEJt8GDXteVe6BRurQ/WjvIa6QMj9u8vvDkyr4I0ayq6vpblah
	yDtcA9AA3ZpG8RAmjynlHrQ77bThmVxJdD0gU+v5Gi+bvGPXKo4IhDAJ67v7nVS2A5X91lJSbHk
	AU+nTeOuktlXRTyfqbtkZYdYEhwhDPRn0vcUxE7qP/EgoBHHHv44APP8HdOVNdZAvkMHcdUD1xC
	QF7v53E0v9fa0KjWVjF9rUO8/OEoICo72Jw9Cb9aWIooW2FsB2dk1LeLxyB2dyUQUM4DV4LYLuW
	Fo1PCdeiJMJeEDkGlWdP6QwV2XMMFaCbqMRWirL79DrY8PUe/xZMLIuhspsqg6QI7fxcyrWUxMX
	EHN2o67/gIaBEMkmbFoiRqcCL4VuKdC4FDZgTIqEkDcxtmG1H06vekowmN3h/US235x1GQQQCg=
X-Received: by 2002:a05:620a:261c:b0:914:cc9d:e25 with SMTP id af79cd13be357-914cc9d275fmr556255585a.7.1779625695376;
        Sun, 24 May 2026 05:28:15 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.14
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:15 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 09/13] tpm2-tools: make efivar optional
Date: Sun, 24 May 2026 08:27:58 -0400
Message-ID: <68d3c150e9834f35d03581695c1afe9fa7f4ecd1.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4029

From: Peter Marko <peter.marko@siemens.com>

Previous commit made this a hard dependency because it's autodetected.
Instead of that, make it configurable so it can be disabled (roughtly
equivalent to behavior before that commit).

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index fec5e1c..e1a0c5d 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -4,7 +4,7 @@ LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://docs/LICENSE;md5=a846608d090aa64494c45fc147cc12e3"
 SECTION = "tpm"
 
-DEPENDS = "tpm2-tss openssl curl efivar"
+DEPENDS = "tpm2-tss openssl curl"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 
@@ -14,4 +14,7 @@ UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
 inherit autotools pkgconfig bash-completion
 
+PACKAGECONGIG ??= "efivar"
+PACKAGECONFIG[efivar] = "--with-efivar,--without-efivar,efivar"
+
 BBCLASSEXTEND = "native nativesdk"
-- 
2.53.0


