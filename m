Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1E4C282D9
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:25:12 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.10283.1741170311420954549
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:25:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FP1vGYFH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so35289025e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 02:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741170309; x=1741775109; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXQR2QojCghs1EbqJCyKfPrK2pMDq5KgZYCZGqT7+94=;
        b=FP1vGYFHq1/EVywsraByDia9CywutHaknt8yFK/C49jh0jviPeSUz5+ot3CCEOrpbH
         tkBvFwdows1dmfiPe2suUfMp3njgWIYUb2UsE6aVhEwAIKLZnjLnFqHaqeoWmGkK5K9b
         PLer6VhFplDtP9rnUd130pjQk+k+MDLFgB/oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170309; x=1741775109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXQR2QojCghs1EbqJCyKfPrK2pMDq5KgZYCZGqT7+94=;
        b=m77YfZ71Uofo9w40X0SVm7FtwmSN7WxdkPyDHHFerEmuxjJnYBrIrnqlokZhOQMtK/
         VbfmIgYDWK05dtUWt2zWhWHlkSGu2Nk8nBPlaJ5BnGeL21aAtLV3QYifeKRm+ftFTp/g
         r96yG8d0c8qGbZjp72cbR/Lz5aKzMEhNVz/U9wMsHk2n8LfQCQzY7L54BuRHuxyRd5Ae
         A+Uaaxt516Gg5HEux2QAVsg8F+Ku8IrcQXuLYGu1ubj5qEXV5ZSCiqvwLIeOVCl8eyzw
         /9R5pG38FUJ2p1v5BY8yJ5TGFZEMlLR43xMo51cUBj75ZU6AyZB4H6Q/1Pb7tez/XzuY
         NaPg==
X-Gm-Message-State: AOJu0Yzzxs4+A5mKuL18SbxfaIpU25HCClN4XFOPxKF3yuYYRto6YBm/
	CTlqCrvGB79jjNPE99atriZMcksDC2VZV7TBVmSzdSipSR6yCDwVOL0oevUUETBSTFpICbbKDGl
	I
X-Gm-Gg: ASbGnctYCPe6qthDCZMhjtS8FitGblLYHSIWOb5JTigWGD3J6SAWYHrUai5X4A/yAlp
	XzuPbX7bbru5hnwYCsOlhQtSHxiUt70ObjNb6OZAaVmdl0GanjpLiSQHT12pbCbNzMDSNyqHSkI
	VphSHyZN7x7Yq8w9y/vVOa8D1tROfLBXxzAU+eTEW+z18sTYy03hA2wbAirQ1m9hXHNscMzVQ8K
	NqNPQRtC8wJL5s87yRKR+FblAze87tYrvtrgtJXnt3K+VY+Fwt7YNsZITxaPaGRlNc0+HkrNmPC
	wLd9O43/s9n110dsryCpzI5zw92atCnPRBZMFgX5kh7r03Id0w2PcQCi61mMdpKL2jbXAiUPYQ=
	=
X-Google-Smtp-Source: AGHT+IGau6wJnIhjhWHhLCHMrjs7KTXg0MpT5IQnxInzGR6mymuOCv27TEHLVnv73ovfl0pb5a6jgQ==
X-Received: by 2002:a05:600c:154a:b0:43b:c97f:2679 with SMTP id 5b1f17b1804b1-43bd2991de7mr18979265e9.17.1741170309416;
        Wed, 05 Mar 2025 02:25:09 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm12973495e9.31.2025.03.05.02.25.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:25:08 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 02/11] scripts/run-dashboard-index: Generate releases.json from the dashboard script
Date: Wed,  5 Mar 2025 10:24:57 +0000
Message-ID: <20250305102506.2043524-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
References: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:25:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1146

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/run-dashboard-index | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/run-dashboard-index b/scripts/run-dashboard-index
index 6644ee7..c1f0c78 100755
--- a/scripts/run-dashboard-index
+++ b/scripts/run-dashboard-index
@@ -7,5 +7,9 @@
 builddir=$(realpath "$1")
 scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 
+cd $builddir
+$scriptdir/release-parser.py 
+
+rsync -irlp --checksum --ignore-times releases.json docs@docs.yoctoproject.org:dashboard/
 rsync -irlp --checksum --ignore-times $scriptdir/dashboard/index.html docs@docs.yoctoproject.org:dashboard/
 

