Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEA1C83F0D
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 07:24:52 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.13205.1751959483686792410
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Jul 2025 00:24:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Z8RKho4x;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-454ac069223so24691755e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751959482; x=1752564282; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TckxSVXZZH4IqOnPAtzh9zG3VJqYZrObnkplitCK/4=;
        b=Z8RKho4xLdpdK8nPOdqlsKofhslKXI9rb+a1SYo73Ex7wrcn0r28C0o5AO3kG9cMn4
         fcYnNANIGUMNTsuGfcM6MstDlC92qzDnBT7PWq7PFZ4DKTmnoCqI+tvCrNNBm5SN9gsV
         qB11xPguzhys9Sn4E3ZJ8u40zT83QOuMh8kfTl96ER8wpzNwagVFu61uOBVUDvAuQ3zK
         rxd+OlVtkD6Mcx4GdNG+IacZO3LZ6xDk48nu2ZWamaCe5tWYWDQdaNd9MNiwMnBn/bwm
         r58gRMGQuyg/ENv6NixlqJbLstJueDgGfOBlHKdcPoyZVuqXEGkSmWo7uGojHq1IMG+s
         Szqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751959482; x=1752564282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TckxSVXZZH4IqOnPAtzh9zG3VJqYZrObnkplitCK/4=;
        b=MPG/pHiRQNet7zZT9FsOHgyOG7TX/7BgYO6hKJkxXjNfNBTGslmpTDvYKOX9rBdE22
         CTSKB4sPqUGrvUhpS86edGnCrLRy/Z4KaOkc1QYvQRz2Q5oeVgkQvUZ4EN/b5U4K0dWU
         3Oq1m/3Vqf9zciYLqYHSwQEIqQJNb3kqt84JBhd673sumKywKLoVzAWRRickaWBes9Zt
         Jo6eKmqSH9M8uZEMZoPW+SOWz9D6wSI20GSuvn7QaOxi/2F8z2DtulsUDT6z+93slWNC
         A9q+vtP8FQazoCWL+jUK2eD8tUsOQ3gvmwOH4W0XZ75OptI2W03QJQJcLnvtCqLHIbe+
         dFTQ==
X-Gm-Message-State: AOJu0Yy27j36veek0+cEDw3hHuPVmv9Faw7pKhEoXx90cp6FaHJ+AUwo
	062A+VSC8QHZd3PCFVfPtGric6fQtWrMBLppamGxhHHIBhqx9dJM/43g/7Ahsg==
X-Gm-Gg: ASbGncsHq/LuB5KXaWxCU0waxnMwtpnEDS+sQwaoPQfJJPFdx3c6N8yK+IMBDi3hN6N
	cQlDyfiuTRDblwXhyVrp8jbfklqBDN6QTsCyKjC/0ObwDwVliXQUXGiDlgSu78grg7Plahtvbzv
	G6guyoPd4ieBCCL+WyQXaCYF9ebmrGZYxblUkNE8FxOdtJKDgxKKnqfweh3d5yEjrfW0GZDR9t1
	9VbHBuqYy0g4M2JQmK5B3xf3SW1aX1fDRn+PZIs5bHCBL5AyPuS3dCUg6pPMfM3kDfy6Dso34en
	UO6PC5neuIkBnXfDuc/PQY48Ej2Pw4wrHg/3I0hgTpv+zrLKCO+rJC/VplEG0qdY
X-Google-Smtp-Source: AGHT+IHDuWt0Gmv39LbxgpzK5vNznJuKaVxLtFsbUxvPuvCGK9W2YKYr4sHtBfnSqZoi1ed9PjEioA==
X-Received: by 2002:a05:6000:270f:b0:3a4:f7ae:77c9 with SMTP id ffacd0b85a97d-3b5de0f2d83mr903400f8f.5.1751959481890;
        Tue, 08 Jul 2025 00:24:41 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b471b966cbsm11983980f8f.49.2025.07.08.00.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 00:24:41 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin2.jansa@lgepartner.com>
Subject: [meta-tensorflow][PATCH 3/3] layer.conf: Update to release name series to whinlatter
Date: Tue,  8 Jul 2025 09:24:36 +0200
Message-ID: <20250708072436.24522-3-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708072436.24522-1-martin.jansa@gmail.com>
References: <20250708072436.24522-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 07:24:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1783

From: Martin Jansa <martin2.jansa@lgepartner.com>

Changed in:
https://git.openembedded.org/openembedded-core/commit/?id=75eb26e71dba4096d5632b7f6b13db4f13aa6d7f
due to incompatible changes.

Signed-off-by: Martin Jansa <martin2.jansa@lgepartner.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index e0fbc64..8ea32c4 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -11,7 +11,7 @@ BBFILE_PRIORITY_meta-tensorflow = "10"
 
 LAYERVERSION_meta-tensorflow = "1"
 
-LAYERSERIES_COMPAT_meta-tensorflow = "walnascar"
+LAYERSERIES_COMPAT_meta-tensorflow = "whinlatter"
 
 LAYERDEPENDS_meta-tensorflow = " \
     core \

