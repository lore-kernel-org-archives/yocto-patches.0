Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43046C282EC
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 11:13:20 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.6348.1741691593398498183
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Mar 2025 04:13:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BQPtwefv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913fdd0120so1587575f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 04:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741691591; x=1742296391; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iRoPHlncoPFu/uXiO6PNFvg3igCIPs0xPBm3L1x2l2M=;
        b=BQPtwefvZyXTa2+2rpD619ULgSKvNvDJ/W8RjAXrSzvqDPTP/dpdnwQuygTf5RgEpV
         LKKwVCKuKyqpYWwfRWBjlMiqtT7GhReZ5RKh6uCNUeN4naCWff2m4ErSyteh7ud9WRYy
         xq4s+mTKhFN5Aci8cw9AIaP1af0r0DAs5l3Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741691591; x=1742296391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRoPHlncoPFu/uXiO6PNFvg3igCIPs0xPBm3L1x2l2M=;
        b=K8DXMpsuW81Rt1VwrzoA0UwAb8/3mA2t7CHw/RhrXhY4Ja5A8NULlsc94PD1BAgOC+
         VWrqM/piNT6YaU2yFqaiJDPGYrfNJ3LKLik9WsGFW7s1Yy9BhThCOwyElWYTPg51CgSe
         P0vHBV7EnqSK0U6npMz3dqMEGP9Y7y8lQAraiJqgerNttnqSRh2G9YUDv2gl7YJjnOo5
         YilZuHyna5itEzK6tP6TsCIYIxLPVtyfDJG0qDjz/7vf85T0KPbNhThkaprKTEbWcqSV
         wnjKyDReI7tpfyO8JwGIXw+Mev1pCb9v2dfTBkRxCIkyacaR/zXcaQzoGcYlZjawkfqW
         An5w==
X-Gm-Message-State: AOJu0YzFW+IZEXVruYgcWiR9ctbmV0W5OSLILa99OeKw2SrVgCdcrbnA
	BMOS/8/+KnXhTX4pE2loRP8vsbsMIyKjk6aGWDHuICfbmo5HRSZLJe4VP1g652UYZncSbbPhvNx
	V
X-Gm-Gg: ASbGnculmQt7yeI3r8RVFAwM75dE9XlKucqT2d8uk+y5WY41Nb6S4kUnAbqg4tzlCDT
	92VCe6x4KIAZYoLvQJlQmgbn5P5W0zclntzVnBO91bhPJT5GluWoPhx6aS8u+ecGeRN9SZujLEw
	iaSAiYHOz0MlfQqUyh3KS8NAbWoU4BmbAQwKI0Qq37HJwffgLUjgwsoaQrYKAwtOxcuYqwO+VTp
	nqKJaNXSLHUafOVP+sBy7dkuSGUj9l8Vp+9oLXmnFSPYDdbPIS3nByO02JUoSl8H5ZK7wHrA7KH
	s6aTdSQD+PHhF7OVpLlN40YFRnvF7XGMqXdxgEqnYL6cPY9ERXOZReqm9NsMUyhfNZ4EFVBDMpZ
	wi2dcCOk=
X-Google-Smtp-Source: AGHT+IE6A6L+oZgwhOkn17DoOJqFQq8oG8dgzLgbHVl6Ju9Bg5fWC8D2uARUAvz+TdjdsybdtcrTVQ==
X-Received: by 2002:a05:6000:18a3:b0:391:2e19:9ab with SMTP id ffacd0b85a97d-39132da8e5dmr13063836f8f.47.1741691590943;
        Tue, 11 Mar 2025 04:13:10 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:98ce:619b:b74:b8c9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031e3sm17550560f8f.82.2025.03.11.04.13.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:13:10 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] master.cfg: Increase default number of builds shown on the worker page
Date: Tue, 11 Mar 2025 11:13:09 +0000
Message-ID: <20250311111309.2985268-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Mar 2025 11:13:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1181

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 master.cfg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/master.cfg b/master.cfg
index b1d4fd9f..8ede1228 100644
--- a/master.cfg
+++ b/master.cfg
@@ -103,6 +103,8 @@ c['buildbotURL'] = "https://autobuilder.yoctoproject.org/main/"
 #c['www']['plugins']['profiler'] = True
 
 # Clean up the default build display format to be neater
+# Also show a more appropriate number of builds on the worker page
 c['www']['ui_default_config'] = {
     'Links.build_link_template': "%(prop:branch) %(build_number)"
+    'Workers.buildFetchLimit': 200,
 }

