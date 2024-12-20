Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DEAE7718B
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:06:02 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.152241.1734703559936889471
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:06:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=olfTXADY;
 spf=pass (domain: linaro.org, ip: 209.85.208.182, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3003943288bso19712091fa.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703558; x=1735308358; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XKCeN4f49FG1MJ4g10q3s4AVAS/00gBgEBK5eX+zkI=;
        b=olfTXADYe4141IG599cFiNaZdIArz9Xef/uSQG/Kiev4w9U6NRBtGFrROLovYtGBzl
         5ZN5ItXbxfyFaqz8Ng+wh/d/0ZaGknZDe99qXOs9Nu7rUQFY7nshLhZWTzs7K8xMxKU6
         xN7OhNVimdaz5g9VRX8M6hJ6Hh/3VlO/MOGukyKWVh+IhvtPMQyzTgtWE7qvYDuTYbtA
         nQkkIoC7ClCN5n6X6Ku59rSVaPex0jYatY4QukjhiOobtUvRv2nM2GsbtCth3yHYPbk1
         RI7U1k49fp4oUKBWcVj00CI8M1RaVdjqIb7FmdqnTkY0+yKDJrRfwyw4lybegVU9Y0QJ
         Vidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703558; x=1735308358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XKCeN4f49FG1MJ4g10q3s4AVAS/00gBgEBK5eX+zkI=;
        b=rx/+Pss7DObewWx+Uw6+YdhZUGEq0PVl53nLD537hRJqztTx4lCf5RKya3ymRBBytm
         Z5/zW72p9jwgGyBuQcdy/+Ner5Xo/aBRr9U3e81IrHtZUKVTgSmKWPdJxMQpIwNrBU8V
         hx+c9+8wngI12hQvODaPSsVmHNRbFrvX9S6D8BMlwPwt5eCnlIAkcFDHJ7gAfRWQFpH8
         zX6DODxmFi4jiGjFkixKxybg+vyHjpEZgz0MwzdoyUPN9lHPS+5rf/2XF8PXuUhkAXn7
         VZ7Q09acVGWv9zpMTsx736puQqVa3cuHLD4X5un4EEGW16w/+aXEOsmulsoNdkNmjLr/
         Ji6Q==
X-Gm-Message-State: AOJu0Yxto9lLJj94+EtNiuc5JY1ro7cJrdsU0P0aRHhXYbFeSN7QPcix
	VxcQfD9+S/bzf/KcG4BHvSBVOwgG9n69WTsOs8pyW1KgAVUeRYBfwUaxLH7FUkQPSxGtnrliyEw
	7jUE=
X-Gm-Gg: ASbGncvPJgTejpxYUAieV3YaIzkJN0Kc1nED6ItLkzWy4cjm0M2pPS0b0I4Or7HiMTc
	1+jSOnV4f4PuxzzSj3STB6fCeDoM+tHktoW7qlEheO2HdkYjYLI2fhuwT63Cko6n6rDD4Y3kdoq
	lHBA3jLruZYeJezqO9A8zzmd0rqmUx/s/FN5xj7TtajImU/B7Zhutfl5C0pDp8gEHir0eUtZeQO
	R7wQZfMbv+w7OZtz+kF6/AT7VpaoxKHWNuvN0sm1FaVyr75hlV0zD44syPK9gZ1TevXGnEwabNV
	B+pLKfUo3cvP3EEEkcipJmUg9w==
X-Google-Smtp-Source: AGHT+IFOhbXf2yGX+izDozvOZnd1Wxw8nTW/1dQHJBB/66NvryiHihxUwRElDie1k1bzq64c8Gw+iQ==
X-Received: by 2002:a2e:a682:0:b0:304:67d4:6e2c with SMTP id 38308e7fff4ca-3046857a7b3mr8132331fa.24.1734703558068;
        Fri, 20 Dec 2024 06:05:58 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:57 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 15/18] linux-yocto: enable ecryptfs
Date: Fri, 20 Dec 2024 16:04:38 +0200
Message-ID: <20241220140441.271395-16-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:06:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/954

Build ecryptfs as module. Needed by userspace counterparts in
ecryptfs-utils which are currently failing to start correctly
and thus downgrading systemd boot status from RUNNING to DEGRADED.
Fix is to build and install the kernel module.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 recipes-kernel/linux/linux-yocto_security.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-kernel/linux/linux-yocto_security.inc b/recipes-kernel/linux/linux-yocto_security.inc
index b79af80..3a2ff96 100644
--- a/recipes-kernel/linux/linux-yocto_security.inc
+++ b/recipes-kernel/linux/linux-yocto_security.inc
@@ -3,4 +3,5 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "apparmor", " features/apparmor/apparmor.scc", "" ,d)}"
 KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "smack", " features/smack/smack.scc", "" ,d)}"
 KERNEL_FEATURES:append = " ${@bb.utils.contains("IMAGE_CLASSES", "dm-verity-img", " features/device-mapper/dm-verity.scc", "" ,d)}"
+KERNEL_FEATURES:append = " features/ecryptfs/ecryptfs.scc"
 SRC_URI += " ${@bb.utils.contains("DISTRO_FEATURES", "lkrg", "file://lkrg.scc", "" ,d)}"
-- 
2.43.0


