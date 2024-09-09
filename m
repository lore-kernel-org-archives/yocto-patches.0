Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125BFECE57A
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 13:02:04 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.52284.1725886918145833380
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 06:01:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=jYDuyOrk;
 spf=pass (domain: mvista.com, ip: 209.85.215.179, mailfrom: vanusuri@mvista.com)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d50e865b7aso3038901a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1725886917; x=1726491717; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NmK6Pf++rZtAyZBXc6UgW5BfD5wxg7hxPa2YaFeZow4=;
        b=jYDuyOrkm34sXxhAoPt/JgTzrDiC2W9j+/1on+yHESNG98jwaG0SW1R6yEJYmrx1cP
         65HL04hFHE1ZGtaQts8RveoN9nmby7AhQbKUdvg/Fn4JyGfYLiwkykK5jUMxBcU9hYpY
         bh29HJ23UuEOw/LuoC5dj99fsGrGEcIPZKuIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886917; x=1726491717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmK6Pf++rZtAyZBXc6UgW5BfD5wxg7hxPa2YaFeZow4=;
        b=MRUSklIxVOQ9oxSuz24qP03fuM9lt6WjIBGFmCsQe58SPSEj9OwuDKM5+a5tAOiuCx
         CrIXGJOk/fJJUECaukpJZvLOdi+jKFhROqQKB0m1TJLkcJOJwQZor+122vlpf28ObBGb
         uRTqHDz4MOfPye4PusHq6TceGQLxNmjvlnQm/GYup8zt1ESadwwL2dQBq9caQTByrZWX
         1uFL1xbHvcuqXBceqsox8UYWD0MiY+R+ThqdQepMjZpxtQtCHKD+PEMgy+c/qq6bVR/3
         /DhPYRooz3WrmHUFNTmBopaL3S+Ud93JXemrSGolGY2g7KWq7muR6s16HM20azgvI8K9
         u2Cw==
X-Gm-Message-State: AOJu0YyVQSyNhJfbju3Fe2GqKltARbgYZqxO6qmYZ1cPpWvzqZLXEQnN
	lnffnn6Wkw8a5/GFS5x5HEUWitVGaizeVXrtNvIyBBUoCPeaOYbjgEl079KDqoSVMU1h73CNw2E
	1pyE=
X-Google-Smtp-Source: AGHT+IH6tFNa+xM+/hGbcQ58n28tqs8w2J4Aj6MO1vKtRh8PHOgabcf+PltdJMIa+S5d7O9OarbvQA==
X-Received: by 2002:a05:6a21:4610:b0:1cf:32d1:46d with SMTP id adf61e73a8af0-1cf32d10d46mr9679179637.32.1725886916771;
        Mon, 09 Sep 2024 06:01:56 -0700 (PDT)
Received: from MVIN00020.mvista.com ([2401:4900:882d:7454:9674:8169:5358:32b5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58bd21csm3479554b3a.74.2024.09.09.06.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:01:56 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [meta-security][kirkstone][PATCH] tpm2-tss: upgrade 3.2.2 -> 3.2.3
Date: Mon,  9 Sep 2024 18:31:47 +0530
Message-Id: <20240909130147.6821-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 13:02:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/625

From: Vijay Anusuri <vanusuri@mvista.com>

Changelog:
https://github.com/tpm2-software/tpm2-tss/releases/tag/3.2.3

Includes Security fix:
CVE-2024-29040

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 .../tpm2-tss/{tpm2-tss_3.2.2.bb => tpm2-tss_3.2.3.bb}           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-tpm/recipes-tpm2/tpm2-tss/{tpm2-tss_3.2.2.bb => tpm2-tss_3.2.3.bb} (96%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_3.2.2.bb b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_3.2.3.bb
similarity index 96%
rename from meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_3.2.2.bb
rename to meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_3.2.3.bb
index 4d2c911..8bfc7db 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_3.2.2.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_3.2.3.bb
@@ -10,7 +10,7 @@ SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN
            file://fixup_hosttools.patch \
            "
 
-SRC_URI[sha256sum] = "ba9e52117f254f357ff502e7d60fce652b3bfb26327d236bbf5ab634235e40f1"
+SRC_URI[sha256sum] = "6279a9a1983ea6ffe41925067b7f0de3a6ed95020a30e7c97d80fa2754259534"
 
 inherit autotools pkgconfig systemd useradd
 
-- 
2.25.1


