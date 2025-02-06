Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF322C02199
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 14:29:35 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.42293.1738852168946617216
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Feb 2025 06:29:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kwFvfs/h;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de34b72ce8so699800a12.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Feb 2025 06:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738852167; x=1739456967; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JzJeTx2vCQOlXbQ7DNmV/CjiHBKxWMTiOKM8ek0cXmA=;
        b=kwFvfs/hpFHvzDg9JVWMWZopvLuTUPeYR3QLvwKfBkgGhxTRVLgslAj1Yylm4fAkO/
         vMmrmiccWtoen9Sy9di0vd2mZvlkTG3pM25NGICH6LPAYS9o0Rnbo+jCW3vVZo+G2kLu
         os9Sn4FCgnbCGf7ipVDx08ZthVvfJAFG3Mqlw9llczv03wKPw+NRXPq46AFXeZkU9ZBv
         uX1kmZvchWI+Hi4JXtA0klaUbbpOxOOvi7IoQviNuuVxBhrKH5hGEn3s8eEziQLQkjhF
         /I5mOIrxt/FlVXgZg5SAXZhnAe47lSBCkmQUz2jjMInRxSi0RgdpSbxovwni6vJMZKO1
         P77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852167; x=1739456967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzJeTx2vCQOlXbQ7DNmV/CjiHBKxWMTiOKM8ek0cXmA=;
        b=Ze3rnLjT77IMFXERFtluxutfpHvAnf+Zoz0pYbsOb77iyf/bXen7CZsaZYhDbFuCq/
         KzfJsNuPcsBaJAa9TU9pHBzT2dhiCJ+MVWwajHyerBSheFhhDCVLdL3IxAcpqudK8Xvd
         5glnOmoxRalktmfDYOMzbCwVnJ2HMCN7ngaxbLLQCYJWcxs+B0YRk7E3oJjFZUqT65ZD
         pxONinLaHP/qpsDeI/jalZKcVTaXNAE8UKueM0cF+XwW0JUgj8kGxB1MhdZ9ydItEzP7
         MnLbnZi0KzI/IElUUlznVh452GGG8AIJtoNQcVscDn+nBzTkBW2b9cHiIp9NUWbwqTRq
         PZAQ==
X-Gm-Message-State: AOJu0YyR0UkF/KxZcrBIVIWg9VW+l0VVmb8x4iRV3YJcUpTu4SV7xDYl
	bDeC5tMYj7s8sdYSCsIrZU/8oE1hSWSJOrSVAekZeiF6vSdUXGgaAF669w==
X-Gm-Gg: ASbGncu0IbnwcnLNpworSA1c0Gs5xtnrI4sr1bV+/EdsoNWtmK/iQqKdroRrhb5MTeI
	xilFWjci8ScB42/g+VldPVxKSW2tGq/so8tw0aDMIK0phglI8y1vXX3RkS+RAsthRcEH56e2zsp
	Llu19xy9q4vz3A9XCNApoW/WGgB0EUp/dvc1LloRALMRJJtlZzDmJLH7HzyDZ2EXkDZr5od509Y
	3+RQwQjgcy5MfkklrkbGgtUISoHTQ/q3MU7N+U0pAhleEjFRsOGUK8W4ngaHr/72GpmM9l/QpOE
	4a7sRfAq0ankq8AC0w==
X-Google-Smtp-Source: AGHT+IHw9gFB5Rc7YGwAPkViLfGiZPdemTr9108DUnREw0xbeIAEjDViikWI0n3Z6g9sNIveJoTAHw==
X-Received: by 2002:a17:907:3f1e:b0:ab7:7c58:7bda with SMTP id a640c23a62f3a-ab77c588104mr182878866b.2.1738852166811;
        Thu, 06 Feb 2025 06:29:26 -0800 (PST)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7732e7120sm107509066b.91.2025.02.06.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 06:29:25 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][mickledore][PATCH 1/3] layer.conf: add langdale and nanbield to LAYERSERIES_COMPAT as well
Date: Thu,  6 Feb 2025 15:29:18 +0100
Message-ID: <20250206142920.17790-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Feb 2025 14:29:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1042

* useful when bisecting where something got broken between kirkstone
  and scarthgap LTS releases

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index ccb6343..ad3b677 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -11,7 +11,7 @@ BBFILE_PRIORITY_meta-tensorflow = "10"
 
 LAYERVERSION_meta-tensorflow = "1"
 
-LAYERSERIES_COMPAT_meta-tensorflow = "kirkstone mickledore"
+LAYERSERIES_COMPAT_meta-tensorflow = "kirkstone langdale mickledore nanbield"
 
 LAYERDEPENDS_meta-tensorflow = " \
     core \
-- 
2.48.1


