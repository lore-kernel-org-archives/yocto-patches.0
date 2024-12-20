Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74E7C3DA4A
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:32 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web11.152224.1734703526740599679
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=LVZJt5jW;
 spf=pass (domain: linaro.org, ip: 209.85.208.178, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3003943288bso19706171fa.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703525; x=1735308325; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHLbIgjf+i4NnSWqWypW7KO1uBlccylQx2AxtmGOC8k=;
        b=LVZJt5jWiCBbQnG8QNjZjt9oRHWJeZdbBG75YqGTreIm2TdwJTvSoVjTV6+WsR2+zz
         waq1TBDqOTtAPjd7nz/dC1dtP/mNYhr9BGzyxOPELw24RrCKqJ94sgnUZQbyaqBCFU+U
         ZmsqK7UKlzpBtOPAC7K+Scmq9BKkbfgKXZEjaelZsOEoNI5rZs2I3jCuOM7MIv7X6Rj7
         DdwWKQNc/TE328ddZldz7eZGx3H05YFT0L7okxpWHjoWw9uBvg8UZYnxPAVYFhBBtCO8
         ONlxcrPfEXKW1zpC9khpSdtxep4aXtzo+v52sEEMH931z4EI49fd0Td1iHmAhug3uH1w
         slig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703525; x=1735308325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHLbIgjf+i4NnSWqWypW7KO1uBlccylQx2AxtmGOC8k=;
        b=w0+S87oTmzBlyIqaGYt9BxCrR6wcYtbTmxt90V+iSQwVSJmeDGu8+8OH5i1POSZMTZ
         /itKDpx3BRX8MFxIc+4ZxrhqMD2rUBG91hRGXat3yaujJzPP0mgBnEKUIdUTkL9PUW8a
         9b1A4KC6BIQYvC8UpXloHP3S7XX+kYy4hbaPtvHG3uUEnGf3o9GT9i9p1ckrIz8+4+Fs
         xJ9/mczfCCV0xvT4GDFNZzfVo3FCGa8aRHjYzxeCeIrPIGWz/rCc/n1iHzhVLgXRUwWL
         oNjo3j/cE1LV9rUBCUpC1viiS9YzQ1xcHzIosr4zI3xg0toEXsZb8HaK18jfLQa4AJPs
         Qp1w==
X-Gm-Message-State: AOJu0Yw2yaEzazNMBOsXYOKtrn8pclEaC3ZamCqzarVUqLDiIWBeZ2zY
	KIy378/fLMjZG3inR0o2oBLqGaXWy8UNTQOoT9ZSQAf7obimOFAKAj1pXqJykwmrnkHHlawxGni
	kxUc=
X-Gm-Gg: ASbGnctxzYyBvPhM2SiAu5/fivfX1VHDuo4cGRrnl24aDVEm6KnOwgaAt9bt/by5SrA
	K/2VfNy9PBzG6dWKhHoWMJCwVmSW+AoXEMYZfWu2KUNpIPmikceV8OPSjZrVqZZAAadfPkTmSf7
	2bRImNJK4lmkJlkeWpFtjZzvhVKNCBsxEPIOcBWjAB2Fm4tWismVvM5vlp0S45Nw6j5tReuOCsc
	AAwje88QstRg0mT+nU0YR6kHcQRL5apFA6JotIE03mlIdoA+mrw0fIR/EJ9sL2+PkZm+W1acshO
	7zERR+/6letq4bnWO8JiE14T1g==
X-Google-Smtp-Source: AGHT+IHe5Ee8DBU5WqUvvu1Li0Yawdh0Fvnms1e/9RhhO1Ehy03/KT00vJQHp31qn6qMNm4d9+nxpw==
X-Received: by 2002:a05:651c:506:b0:302:1b18:2c09 with SMTP id 38308e7fff4ca-304685f763amr10181521fa.27.1734703524829;
        Fri, 20 Dec 2024 06:05:24 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:23 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 07/18] libtpm: rename to libtpms
Date: Fri, 20 Dec 2024 16:04:30 +0200
Message-ID: <20241220140441.271395-8-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/946

Upstream and other distros like Debian use package name
libtpms so use this name for recipe too to match CVEs etc.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-tpm/conf/distro/include/maintainers-meta-tpm.inc           | 2 +-
 .../recipes-core/packagegroup/packagegroup-security-vtpm.bb     | 2 +-
 .../recipes-tpm/libtpm/{libtpm_0.10.0.bb => libtpms_0.10.0.bb}  | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename meta-tpm/recipes-tpm/libtpm/{libtpm_0.10.0.bb => libtpms_0.10.0.bb} (100%)

diff --git a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
index e7b216d..77f843d 100644
--- a/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
+++ b/meta-tpm/conf/distro/include/maintainers-meta-tpm.inc
@@ -22,7 +22,7 @@
 RECIPE_MAINTAINER:pn-aircrack-ng = "Armin Kuster <akuster808@gmail.com>"
 RECIPE_MAINTAINER:pn-pcr-extend = "Armin Kuster <akuster808@gmail.com>"
 RECIPE_MAINTAINER:pn-tpm-quote-tools = "Armin Kuster <akuster808@gmail.com>"
-RECIPE_MAINTAINER:pn-libtpm = "Armin Kuster <akuster808@gmail.com>"
+RECIPE_MAINTAINER:pn-libtpms = "Armin Kuster <akuster808@gmail.com>"
 RECIPE_MAINTAINER:pn-trousers = "Armin Kuster <akuster808@gmail.com>"
 RECIPE_MAINTAINER:pn-swtpm = "Armin Kuster <akuster808@gmail.com>"
 RECIPE_MAINTAINER:pn-openssl-tpm-engine = "Armin Kuster <akuster808@gmail.com>"
diff --git a/meta-tpm/recipes-core/packagegroup/packagegroup-security-vtpm.bb b/meta-tpm/recipes-core/packagegroup/packagegroup-security-vtpm.bb
index 3a8f2fa..3c67630 100644
--- a/meta-tpm/recipes-core/packagegroup/packagegroup-security-vtpm.bb
+++ b/meta-tpm/recipes-core/packagegroup/packagegroup-security-vtpm.bb
@@ -9,6 +9,6 @@ PACKAGES = "packagegroup-security-vtpm"
 
 SUMMARY:packagegroup-security-vtpm = "Security Software vTPM support"
 RDEPENDS:packagegroup-security-vtpm = " \
-    libtpm \
+    libtpms \
     swtpm \
     "		
diff --git a/meta-tpm/recipes-tpm/libtpm/libtpm_0.10.0.bb b/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
similarity index 100%
rename from meta-tpm/recipes-tpm/libtpm/libtpm_0.10.0.bb
rename to meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
-- 
2.43.0


