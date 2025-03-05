Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01268C282DC
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:25:22 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.10379.1741170312701040953
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:25:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VLgFpt1n;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bc0b8520cso20514865e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 02:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741170311; x=1741775111; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjuQiBOcYY/2s/3COnZxJeGYjZY7UXg+EptVr7tX1/8=;
        b=VLgFpt1nuTtPACbElivs949U6ZcPV6Vb9qn/TpCRi475RLvqUEKGOskYfQmg65u7E1
         Rt3QsfrQg4cVQbhcWe389HvDQxTKGTXfNkELdc94WCNcy8bppjCA2L2Uy2Ev/S3TIPRp
         G48zQXKzygHcnB0vL+oKEkWVJMHB7dgDfiWJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170311; x=1741775111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjuQiBOcYY/2s/3COnZxJeGYjZY7UXg+EptVr7tX1/8=;
        b=kGHOMbspRP9qPSjMxs6hHtrLFapYoYP//Xr+9Sx0DQOg+rVeyPP40PSfdRxqUZhJnM
         +ZNsDZWD0VMkaKl1UeTjPRVbCyX9V1LvTB8icq+wgKrFL3ZqpFWpCJ9UG/ko69lATX+m
         MQqLlAY6TYG8s7LznYBlbaQQg5gnR8ji9j1+CKu+VWzuoIx4jqHqxsMeE3cq6SpeDyYb
         2OyeosBT71q8RWVcpthUE/t4fjC99CKD18Sl/KppszLJhQGgStMroN9+83QvW3iwJ3oW
         88ZFxU7cGUVetD3Z7hppqi3DnBvzs9Bwu+v242cMSbVOaGgBBvCacIGtnnkdA5aeAE3m
         Oodg==
X-Gm-Message-State: AOJu0Yy4E2t/SJ+4K65H59fg6TGPdVuQeP4mpGP0qBorS7IuFhewn/E5
	QIT5soGIWMvqkegJF1tyy0IsOZCD1P2ARo9W+KvuSNUlE1wVtqtZwcznDLiup2uHHtYyG4uxflZ
	D
X-Gm-Gg: ASbGncu9BckYAuXSurYfVfB0QgMb+V5GzR2x39SF9TlYXti3AbYEi3Reqxuj01chiQM
	3YFOHO/cU4kcKp4kAPgkPiMwgM1pByIUepsS2KLJgKNYHQk958SGOxh2V2y4aYE2Y9lobzXGlKe
	G7qwFl6poHrKk73StwB7SVxgW2xI8LJfIKDU55uwjc6Jy/JhrSIi+nTZ3LzbIO8tTdT7DSnSRa/
	23Z49Y0e0Eci/NdwjjvQQ4JfG+qJdCiRUNVqS8KU4U/8MpD1WencVlBDmCwVBR8vS27m83uH1Ng
	FEGDl9lHXjIVBfyFaHdRMROZKXDZlw01EueAwKEPtFjhGJkk3bVyZHT0nM9YUNgCIOjumIeTKg=
	=
X-Google-Smtp-Source: AGHT+IEeOXwVRmzEBI+uJCknZfnyjybHo3Rxvlv6UF8p0HOrawT6qa+EtwCllckhMXkO8w/XW/EgRw==
X-Received: by 2002:a05:600c:198f:b0:43b:c309:da40 with SMTP id 5b1f17b1804b1-43bd294de7dmr17204205e9.4.1741170310639;
        Wed, 05 Mar 2025 02:25:10 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm12973495e9.31.2025.03.05.02.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:25:09 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>
Subject: [yocto-autobuilder-helper] [PATCH 03/11] scripts/run-dashboard-index: Generate parsed-layers.json from the dashboard script
Date: Wed,  5 Mar 2025 10:24:58 +0000
Message-ID: <20250305102506.2043524-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
References: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:25:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1147

From: Michael Halstead <mhalstead@linuxfoundation.org>

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 scripts/run-dashboard-index | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/run-dashboard-index b/scripts/run-dashboard-index
index c1f0c78..7309158 100755
--- a/scripts/run-dashboard-index
+++ b/scripts/run-dashboard-index
@@ -9,7 +9,9 @@ scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 
 cd $builddir
 $scriptdir/release-parser.py 
+$scriptdir/layer-parser.py
 
 rsync -irlp --checksum --ignore-times releases.json docs@docs.yoctoproject.org:dashboard/
+rsync -irlp --checksum --ignore-times parsed-layers.json docs@docs.yoctoproject.org:dashboard/
 rsync -irlp --checksum --ignore-times $scriptdir/dashboard/index.html docs@docs.yoctoproject.org:dashboard/
 

