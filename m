Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B58107BCF4
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 10:41:14 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11199.1773830469422983902
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 03:41:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AL5QY/uU;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so69319065e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773830467; x=1774435267; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ll+YNqmo/e3sbVvB1H9Y8oboiE5hI6ekj5MX5TH6ly0=;
        b=AL5QY/uUWjTIb2qgZSJsocKm0qYaYqyk+2prnHfSVI+j68+9GS7bho/8fKmyJsAVfM
         zcgkdRUBF/GwHa1c01eTKWd8VOUc1E+NVmTr4qc7ncZPn+Sjv0nCgzlK/HARLa3M7JcT
         SRDsx7ykwpyJytk8c2vMgZH2GmxlLspyiwWIQ4C1eZuzwYIarOZRAKDda3ImVgKq4bBc
         5pEUsnanmnTZ0nM/gZZRqpXaWa3FyPAdbZbNZuwBG+88cXeP/V3r7NXfK0LWe3bB1/BN
         4VO/x3KOgeBh0Ya6B+Z3lk+bA/xP5YPl1iHnXjqia04W56fOR+x0/0hmD2jAmZAlsmM+
         wtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773830467; x=1774435267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll+YNqmo/e3sbVvB1H9Y8oboiE5hI6ekj5MX5TH6ly0=;
        b=OAfDaaybMCWouJP+WaWw+G+AhxDVI6U8wEMnCokHqLrWSARnPv5Ncc0L3od28EyNzB
         cda69VJ+UukIe2ED60s8EVf/ILkF6sDsNgH49DgLnXlWjc0wPcw7IEtjpiTNk/kLq5dM
         pOE/cceEZg5JEBAAne/4Gu1AIL5rNyxBThw7TbAkcBPGyBamwxFEezOfkKJbScljf6M5
         0fdsLN9rlFnQHv+yzBDzDqrIONxiD7sauma0mS+4DW/Tvg25oiWFwPJHijWNTX3PVcMF
         +UQx1iJKVmhIBzeefH/6ujCWqD0eikM+3VctYu1X27WVcI0wxItDi7U0YLEv1qQeY6Gi
         8+/A==
X-Gm-Message-State: AOJu0YzklA99QRi0odec8ZS6cnKiiTwL0SnhxhKHHvCVPBGSWqjGB1Dq
	imfk0+ObfZcXUZoMJNFI9Soo3BClaQUn4ZQszgwZK3Erwm1NuMIzbpjy8EPRIA==
X-Gm-Gg: ATEYQzyHMuoPLtn9XoyBe6Bokdds2ABm9IfU8y6zeDmxVcjnqtz984By+xKKtZvTWz8
	V2vdmGtY5TRgofD7bZhqisI2AEQBIpKEScIsrKCXQ+RnZ5rFrdNYxb04/TT4G8pod3crvM6GvLy
	Fd9pFL50y9NqCKzmBcBSXA1dq1B+tlvsF3xXTZR6NSWR7sE8A+A8YWwiUuVa19QSCIHyr2JLkWn
	9v9zHwlmD1266JFAAmBGZoEsItkKx0ojVVhrcnbbJk+Tv7LPPb9gYcf9HjF/NBHWVQDEeagr4IQ
	UdFsLWmrSc28qQsbF8MZ7FkOM4CNbPTWwFYkOQ+bMcYvUN0hHyer3S4RqXy/lBNPyqYPni+1uFk
	8lnOFBAyRTuWd6Y48Gs40KXnCR8sT+puW6do22oLH/vTbNps/cWQyDpbm807PAgcCdjB3bivOg0
	k77FfV4tYU4MZH2CYy2Ko8WnvVk1Fmwj+ZdfHBTRhGrR+4BqoU
X-Received: by 2002:a05:600c:4f0c:b0:485:358b:e80c with SMTP id 5b1f17b1804b1-486f4208becmr54920705e9.0.1773830467204;
        Wed, 18 Mar 2026 03:41:07 -0700 (PDT)
Received: from toster.lan ([185.228.162.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4214ab8sm55846615e9.6.2026.03.18.03.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 03:41:06 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [PATCH] layers: update for wrynose release series
Date: Wed, 18 Mar 2026 10:40:46 +0000
Message-ID: <20260318104045.1162686-2-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 10:41:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3510

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 6ec4380..74702af 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,7 +17,7 @@ BBFILE_PRIORITY_selinux = "5"
 # cause compatibility issues with other layers
 LAYERVERSION_selinux = "1"
 
-LAYERSERIES_COMPAT_selinux = "whinlatter"
+LAYERSERIES_COMPAT_selinux = "whinlatter wrynose"
 
 LAYERDEPENDS_selinux = " \
     core \
-- 
2.53.0


