Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13E7CD4851
	for <webhook@archiver.kernel.org>; Fri, 15 May 2026 05:38:15 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28837.1778823493637924459
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 May 2026 22:38:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Jwqr/uYD;
 spf=pass (domain: gmail.com, ip: 209.85.216.51, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso6343431a91.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 14 May 2026 22:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778823493; x=1779428293; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5k8aB5hjihHq+pEmnmwooFg7HVtSOtussEkv1OqYHGU=;
        b=Jwqr/uYDM/FJuoTi3wOBFAoVe1w0t9us1Ra+Lo4lWHY8vxFYxs6I3Tr+VMBmEV5NV1
         osACmlxlx7QULS3NYKVSvk1qQWHHl/pkB27qjC9hH8O0BHHZ7aHvOQ74LwNOEmba1iF5
         ZS1vNelx8z1pl71fBkyyOXfivjlH3dzuLyrUO7IpDsl45VYaZlJVlR37vjcgYErHwvuv
         swuzwt2QADX5/h7yQWDUihee4unqZNQJfrUT04gUTLCrJuTDHjQJDVwUUqcp4IJO5LO8
         O/en/IQ3jJCt71PNRZV+d0KhBYwh07Z6krQKvoS1QZsL55zZaq8JcZ1uq1gF7cU+kUdD
         VH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778823493; x=1779428293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k8aB5hjihHq+pEmnmwooFg7HVtSOtussEkv1OqYHGU=;
        b=QQPn51SdySALx1fNZRbt5PnkXC3JmjLE9FWfblUngrodePbgsqbYzpucNgCNVGOfvi
         JH0cp5hovhgkmKGukej2RDY2EBg/ukA97cJHHsGg0WLK6FD/JSVHLNLSPRqHwFQnvaql
         LMve6H+BbV4nsBsb2BLsXV+CNQX9pPWVPN2odAAXHlPFCD+wf1mhxW0YS3zVwz/S+Fac
         LkLn+xBzlMvBtay2yxH6arMU1pVVjQcwgdz8XceAEJ1QfzoO2YohX0dm8BTbmAN5hZ6I
         qFsZEH1mg2S4Jq8WH3tTOA6NzV+zRRxgBju/AseXLotYbaTpvO74VhOcLEKgpKys9LFO
         XDdg==
X-Gm-Message-State: AOJu0YyduqX1S8CJ3KXkFoZEbNmaWJmTr/EjRpvJvzsg8aoy1flVIBH8
	Gf9xFXW/JpIKSor1mTZA2kybZyKnWyfd3QczcBtxl1q6kF/iU51YHPHMOpQehYhs
X-Gm-Gg: Acq92OHYi/+8xJIEfPiwUeQh1RvDlwXLEbV6CjF6jfrJZtcUUQFJNypiQ/wj5qohqpz
	IGra7yiFyPTSHrgZEQqCxnfCu631ypQYPkZO3eG25jbgYg6wKAU0Qr9qZMfTfcO7V1zpg4DDNdC
	lkr9G8KuCvCwjCFTlS8VgbYDvaeQzJhq+jEU5/3oVhrWvE3OWau/S3hJUcD3JsNJ0UJeAs2bO7Z
	04LmQaTMQbCtjTsNBF+h1gSK0fNy7KJJL/qiH+OdYsL2QxDRUfKGmnakhsdbvZ1FYY9VCJlkuN1
	Q41KQnkY3gqaOlTL7lrWdpsEauM7rx5HDaSrC0ccCNbkbMpvZFGHifqhAMFo1yrQmCKkoHvsyaS
	bdB2FR5Oe+c5fLJ6FwwnstsUq5u3AbPTT0wZtgjLnvijWuUoeuj7WS0fsloZOI0Yc4i7Lg5dfHq
	ITQ6AcmX8X7ZB3vGJSrvEtqdZtncAqBbOnicXd
X-Received: by 2002:a17:902:b181:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2bd7e862606mr20561545ad.1.1778823492803;
        Thu, 14 May 2026 22:38:12 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.134.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fd279sm45082945ad.62.2026.05.14.22.38.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:38:12 -0700 (PDT)
From: Jackson James <jackson.james9803@gmail.com>
X-Google-Original-From: Jackson James <jacksonj2@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH] cargo: set CVE_PRODUCT
Date: Fri, 15 May 2026 11:07:56 +0530
Message-Id: <20260515053756.493090-1-jacksonj2@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 May 2026 05:38:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3992

This removes mediawiki:cargo CVEs from CVE metrics.
* CVE-2026-39837, CVE-2026-39839, CVE-2026-39840, CVE-2026-39841

Reference: [https://git.openembedded.org/openembedded-core/commit/?id=a5cb71e7df95925a5c342c341e699e244b1b84f6]

Signed-off-by: Jackson James <jacksonj2@kpit.com>
---
 meta/recipes-devtools/rust/cargo_1.75.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta/recipes-devtools/rust/cargo_1.75.0.bb b/meta/recipes-devtools/rust/cargo_1.75.0.bb
index a6d3f1754b..573430ef4e 100644
--- a/meta/recipes-devtools/rust/cargo_1.75.0.bb
+++ b/meta/recipes-devtools/rust/cargo_1.75.0.bb
@@ -17,6 +17,8 @@ require rust-snapshot.inc
 S = "${RUSTSRC}/src/tools/cargo"
 CARGO_VENDORING_DIRECTORY = "${RUSTSRC}/vendor"
 
+CVE_PRODUCT = "rust-lang:cargo"
+
 inherit cargo pkgconfig
 
 DEBUG_PREFIX_MAP += "-fdebug-prefix-map=${RUSTSRC}/vendor=${TARGET_DBGSRC_DIR}"
-- 
2.34.1


