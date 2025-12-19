Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7948DD74960
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 07:01:37 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11971.1766127695753494392
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 23:01:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Za6ZP9j0;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a2fe9e200so11717086d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 23:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766127694; x=1766732494; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S72SaqBHcGHVbB+5yjTnOH+8r3DyAblBcsi/HqOjlyI=;
        b=Za6ZP9j0x5nrL0ODXoaT4xVvl0yUSYVIfDohtJYPJnuaz2i5SckpbRhJP2mL6CLNg2
         UfQZjzC/RqoQkyvI2ioGsBxjhQnX2pxyhEGAFy4BtuOp+qWoK/JBxoiKquRQeUYOxU3M
         F9dI1/ZpIlLsu+2Y5L+gb/1rSWn3uMJ9lRc9P95ceW+eVoI24jVmUqo2tBX4zrnWNRW0
         w5IQfFBMT3aAY7o8V5HG2ZTGO/hAaRhSouFuHb2ma096OeBw8Tem1vFX42027AQITus5
         CaDy35MWzDc/A/Jhvucdf7fByhE84LGH4AxU2/k7iK0CX7pn4M9FurgdOQhOFSolmU/Z
         lLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766127694; x=1766732494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S72SaqBHcGHVbB+5yjTnOH+8r3DyAblBcsi/HqOjlyI=;
        b=OrU4v5qM2ySFypNVTluj0jgmMjfDM+w0VLn1l93Xn2+A3cnEKE+d2cKF5N7uATw+Rn
         3Rl+osSUdRgEUAovPSNWN3mZU538D0Yh297HjnsiG3cEWUDlgfxHyhw9kD98cxAa3fkm
         73pbiQOA1t3OtdhFjH4hUJqhpmpA34bJo6W5V0LFc8QT5sywJQSGMSSBL6+Xhl4VnUGr
         5E32Kap/m65CSQHHGwzku0wjSfpo17oFK7DffeAsVza/ozMIul9pjG3qP6TK3zF7dy/7
         SVkiIA7ttd412BQ74nhJe9pmojjicPgtoH8b8HiBEP63qSCV3GFx/T4Dzjt+2v720/2Z
         T2hw==
X-Gm-Message-State: AOJu0YyQVb4Y7ubVMh54tMyaOju/FWCwvwFCKiURol8wGdT8sYHXhizN
	xTzhGmCgVXexnWHApn0JbDVZZxZ305Psb7oClXbpf+lOTIkygOQV6A8LIJBpzg==
X-Gm-Gg: AY/fxX6vxbXb+hDyWFQ7fIN/lwipycBL3mHmsaDLnv28aVngzTbVF/wcIHBJ6RgISEM
	9zo6LHY4FBwIkcNqb5CNBrhaWohds8BIw9IhtNnEJRXxr5FAasCAz6JbedEtm8TLzjO/B+m9sBX
	zRo0NN2diN37kn1w6QuhF8MqI+Gx9dRhlimj58Spg9fJnXL43RsJZ+HDUCbXo6Msr5JKwDTRLkC
	IDVB+hVWogQqkqvGh+bEzstnZKGF+TFzIz6OBip5LrTUOKZunGn9FQcQBBxRiyAiznqkrSrgYUC
	pZlMJwcgPnzbPgjdzfFyI87IEdkOOO7Ib8ZIupWDyDU9t95/IZqUyaC6Lm/lPTqGmookSrMImkY
	fXF+dyIoqotgi0Nm5knVwa53rK4XKTyrMkwOXqwawLSsYUSxFKOR6tG2sn4SIBPPtsIGt1Ed3Jw
	0Q/BFwyf1utVXK5W9mEMrVUGGEmdfOVj3sukDZlQ==
X-Google-Smtp-Source: AGHT+IF0SBmUqly3jyB2GHIC4Hz2kyxzB5/UzkhHd2vxpFaVbDdOep1fdlDneprXCWvJ40JsnMcZeQ==
X-Received: by 2002:ad4:4f0e:0:b0:882:489e:a79d with SMTP id 6a1803df08f44-88d81d44bc4mr24749676d6.22.1766127693916;
        Thu, 18 Dec 2025 23:01:33 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7d5f4sm13570166d6.40.2025.12.18.23.01.33
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 23:01:33 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 2/5] provide kernel *.inc
Date: Fri, 19 Dec 2025 02:00:11 -0500
Message-ID: <20251219070014.39432-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b4
In-Reply-To: <20251219070014.39432-1-twoerner@gmail.com>
References: <20251219070014.39432-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 07:01:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2824

Consolidate the two bbappends for linux-yocto and linux-yocto-dev and
provide the "guts" of the rockchip additions in an *inc file which could
be used by other linux kernel recipes outside this layer when a rockchip
machine is used.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-%.bbappend                          | 1 +
 .../linux/{linux-yocto_%.bbappend => linux-rockchip.inc}       | 0
 recipes-kernel/linux/linux-yocto-dev.bbappend                  | 3 ---
 3 files changed, 1 insertion(+), 3 deletions(-)
 create mode 100644 recipes-kernel/linux/linux-%.bbappend
 rename recipes-kernel/linux/{linux-yocto_%.bbappend => linux-rockchip.inc} (100%)
 delete mode 100644 recipes-kernel/linux/linux-yocto-dev.bbappend

diff --git a/recipes-kernel/linux/linux-%.bbappend b/recipes-kernel/linux/linux-%.bbappend
new file mode 100644
index 000000000000..34bf335d0b10
--- /dev/null
+++ b/recipes-kernel/linux/linux-%.bbappend
@@ -0,0 +1 @@
+require linux-rockchip.inc
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-rockchip.inc
similarity index 100%
rename from recipes-kernel/linux/linux-yocto_%.bbappend
rename to recipes-kernel/linux/linux-rockchip.inc
diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
deleted file mode 100644
index 81d2b6d693c4..000000000000
--- a/recipes-kernel/linux/linux-yocto-dev.bbappend
+++ /dev/null
@@ -1,3 +0,0 @@
-FILESEXTRAPATHS:prepend := "${THISDIR}/linux-rockchip:"
-
-SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
-- 
2.50.0.173.g8b6f19ccfc3a


