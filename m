Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7F7C28B21
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:25:22 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.10286.1741170316489077409
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:25:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZNbMUBA3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bd45e4d91so2450035e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 02:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741170314; x=1741775114; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXtQZxXFpqNHk4m/FOCme6CHg2JDCRHPwM3tj14QCqc=;
        b=ZNbMUBA36F1d4Z5qkYEkYnvniEGxbO+IMjCFRNsaKh8zAmJ/hPkgV7vab+g6kgDEis
         Lv53Lc0wVGVZqwjMD0RWeqJBDFG4n2IGO4a8bs51i/o4/hC4QCojV5MWe7xxnEOODyZQ
         9TIKhYT+C93F6lfz25zThOZu98L0LXCE2iIxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170314; x=1741775114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXtQZxXFpqNHk4m/FOCme6CHg2JDCRHPwM3tj14QCqc=;
        b=MVrW5ev89z6fCbvKtwyFf+3yaZeUT2D3+vdrEjeinYvbe/Yu+J2lexmO49NSppk4wb
         EmPbZDy7F+3UbWIutmDh0OX8cBK/N3rKqPCJDxeiPaF875+xyRJgp2UueNxrP/7TlizI
         7Z7ITHxU18VFI3hnfULaIknFKkeApWl5kXMakIEi+EM3uNsz6zuy8Vzu4sj51d537fp7
         bBUGIa9Cb7vlOTO3iKNo5cgTSBd1cr2zGKPMUoDEDn+cfaBdevElhwpGXegvnt6YTBG1
         4ZGYIQvl4iH+MPtiEuk6qvzG1uqdBLtFLCFM56nUCdAp/5PZAGlzUXSgnwrPSG2iqEQY
         XgvA==
X-Gm-Message-State: AOJu0Ywa6/tOyVhl9gEjbOPkrI9ICIUhmt3Vzyz/oGJxJT0h+eHH/Zud
	ubquEHr39taHFaYU/Ln0kOCoH3AehAE+Fhrtu9nxguvMH99B2BOfwQ2UcuGe0fDOTVjAvMLjlBm
	c
X-Gm-Gg: ASbGnctqtwmpO4jtouO5O45D9cuispt1gmun9KKUuGf1wj9m1eEEv0QaD6LIYFi7rpE
	S2zIA8txEg4dAub2TRGrZWMVYJczEtMmAWoM/edIg/mhsfwNCkplpMiIr9V0OkLMyBO2cJc0qZc
	GSK4cyjNNbx7Zs2R4VV42/HyS7ny1xUNCOcxA83LcypuqP83Uk28ZSLOvblVq2pVNMXshSOPGxy
	+V0n1DuoUl6pGkPm3gZPK/VAK2ZUbhHwqbgcCM4P5ITSQeXa3N7HML9XjrFYKay3K8oKBexvb9p
	/HGG6GvRu1SmeIxP4LQHHqxeawvfgEtDRSgEn+9uqL69bE16EfPfj9UCDUi1KZFE/YAgk2k8Uw=
	=
X-Google-Smtp-Source: AGHT+IFT8W4laFTBUpSvvl2uCuqPa1q13yS3tyKWvPtagSZPHvM4ybOQoTy49vLfpyhk848GLnfXPQ==
X-Received: by 2002:a05:600c:2058:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-43bcae04e31mr58586135e9.3.1741170312913;
        Wed, 05 Mar 2025 02:25:12 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm12973495e9.31.2025.03.05.02.25.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:25:12 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 05/11] list-yp-compatible-layers: Update to current release branches
Date: Wed,  5 Mar 2025 10:25:00 +0000
Message-ID: <20250305102506.2043524-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
References: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:25:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1150

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/list-yp-compatible-layers.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/list-yp-compatible-layers.py b/scripts/list-yp-compatible-layers.py
index 9d5fc48..0171075 100755
--- a/scripts/list-yp-compatible-layers.py
+++ b/scripts/list-yp-compatible-layers.py
@@ -39,7 +39,7 @@ def main():
 
     parser.add_argument("-b", "--branches",
             help = "Branches to find a matching build for in Auto Builder builds query",
-            action="store", dest="query_branches", default="dunfell,kirkstone,mickledore,nanbield,master")
+            action="store", dest="query_branches", default="kirkstone,scarthgap,styhead,master")
     parser.add_argument("-j", "--jobs",
             help = "Jobs ('Builders') to query on the Auto Builder that perform the actual compatibility checks",
             action="store", dest="query_jobs", default="check-layer,check-layer-nightly")

