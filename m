Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BD6E7717D
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 15:49:03 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web11.18725.1734104935576543445
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 07:48:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=P9BLZYVT;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d91653e9d7so18307436d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 07:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734104933; x=1734709733; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27V1RplMfmkCFxPRLi3EM7yZ14jQMKsIy6PP6iO8fs0=;
        b=P9BLZYVTiM3JtS9NPbN4k7OwqJCLfhNnJKPmIxkpdY6Orq6yuuGpC3l70q9A2bN5hZ
         HNk4azm4hKwc5Q7X6BiaApZBbHVaib3VB6znEUq8VVU76uq7iQoMx1qARyRRi2xZuiLI
         o+4rqACsjLakFfqoBOqWt3oDBHuWv00DYIntihmW2oVFeK3zREQh3cCE0QrO7Zykud1e
         wD55BLbtACgwvI+d7IlLb07uO1jjqnzu4Tx1HY7REJVAaW/Ub7BM9r4QjW3d4WNkvW+5
         9MwHdzshAqmJ96RIU8KCxV79qHxjKy/hCj3Hwk7Uo1ZxdWFPdts0Iu7CklEl3hRhV2eB
         9zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734104933; x=1734709733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27V1RplMfmkCFxPRLi3EM7yZ14jQMKsIy6PP6iO8fs0=;
        b=Ssc0TMgatbPmZgWYkaoC9mhKYiiPnSczH3JbwqGa9fY1GAHEpL5O9K0h/xe3te1VeS
         G502ACR1Rq89YhZ6QmtN+aer0l9zGXq0qLK+VHRiMpWwqExnziJSnYA2wFDG5tdtGGeo
         JLYI9dOqxmtKp+AhArRVjEey++UifHQ98H+Ovgq83Ys3hYT9glylQkuLucC2S5K2tGwj
         HMQjRwKLViSSpORJn/dAxUwHedHKtSI79eFbs8S+fO3HSAiRr2xTa4Kl/OVpqYKi7wbX
         8zegr4v3zQARKlahAZ60ZfHjEid7XYMny12MZcuytLrg4hem+z/DpuCXnwNf8IB7EK4v
         8YJA==
X-Gm-Message-State: AOJu0YwuEhFH3+2zmzm00xlVTX/NLqlsTnDl1m8Ya8mF450rkJHS7eky
	4TyAuCks57JOUU34M8fG3QpySu5nriXkgdZ7QWk0ESBnXZUzkipR8NMHUg==
X-Gm-Gg: ASbGncu9iqUv3692rY/YAsyLCJ0Dl1WYrCiDNsHzAIBE+MD/+NLMukGzXs7WnV3Hz1Z
	GCrSH7QweEYOOkAM5K2wwxHNvJ2qzaWSYJHXeRsvpO4IfeKv6jZTckQT/bd0CDMbxRxtJnV9mCs
	UHZGS7bnvu1LRbV62PzSueMbuSxqpPFbJpTIn9fCqnUPkQohhJ8MOo+rX3tSNFGI1r+s3dt1Fjf
	LzcxuebwEL8swOZ/F7Yq543sjoGb6rQanb8wnAc/cmJI+jxPZvETZvTs0LyIQBLUhv/ePtpWYgu
	+Y5btBoFR0vmll7QepUK3NQ/
X-Google-Smtp-Source: AGHT+IHHQglMY5VSciYDkmhivc5j6ROWczqfnZh/9IlGqyjB+QGhFI0rXvCoilCY573/ymOz+jPEjA==
X-Received: by 2002:a05:6214:d83:b0:6d8:ab7e:e54f with SMTP id 6a1803df08f44-6dc9683dd36mr45227976d6.34.1734104933638;
        Fri, 13 Dec 2024 07:48:53 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6b2291sm92221816d6.58.2024.12.13.07.48.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:48:52 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2 4/4] rk3308: add provider for trusted firmware-a
Date: Fri, 13 Dec 2024 10:48:43 -0500
Message-ID: <20241213154843.27592-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20241213154843.27592-1-twoerner@gmail.com>
References: <20241213154843.27592-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 15:49:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/902

A PREFERRED_PROVIDER entry was missed for rk3308 builds:

	NOTE: Multiple providers are available for trusted-firmware-a (rk3308-rkbin, rockchip-rkbin-tf-a)
	Consider defining a PREFERRED_PROVIDER entry to match trusted-firmware-a

This allows the RKBIN_RK3308_LATEST knob to work in all cases again.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes from v1
- added
---
 conf/machine/include/rk3308.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
index 1ecf085cd5de..d30901f15b4f 100644
--- a/conf/machine/include/rk3308.inc
+++ b/conf/machine/include/rk3308.inc
@@ -19,6 +19,7 @@ KERNEL_IMAGETYPE ?= "fitImage"
 UBOOT_SUFFIX ?= "itb"
 UBOOT_ENTRYPOINT ?= "0x06000000"
 
+PREFERRED_PROVIDER_trusted-firmware-a = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin-tf-a', 'rk3308-rkbin', d)}"
 PREFERRED_PROVIDER_rockchip-rkbin-ddr = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin-ddr', 'rk3308-rkbin', d)}"
 PREFERRED_PROVIDER_rockchip-rkbin-tf-a = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin-tf-a', 'rk3308-rkbin', d)}"
 PREFERRED_PROVIDER_rockchip-rkbin-optee-os = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin-optee-os', 'rk3308-rkbin', d)}"
-- 
2.44.0.478.g7774cfed6261


