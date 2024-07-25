Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF80C3DA49
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:25 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.32017.1721898144382414139
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=zgjtQz1x;
 spf=pass (domain: linaro.org, ip: 209.85.167.49, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f01993090so795624e87.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898142; x=1722502942; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88jb28MCxaRhKAwLTwqTSQ3Rf2/thPPgPMnWav/kKuo=;
        b=zgjtQz1xF4eEBsV+5UhJW0rrv4UNcVMaDYjWO92INdUH2jO1aifdU8unuBwFf+jKWN
         ZVZqfvQja6P+XO1eu/QTH9l2nvsaM8rf4Y9V/zMxG98/w02ToL9gt2bPkvnkm7iiofUc
         VGXFCweDbDl76Dmk0Eq3E9ABRCNqfVXTOlVPkNQdsXWCJrBPd2DnduBzGZ5mYzVj+ZBt
         usD0k0/7kWyhjiYCprFjHZEN5Tvsn7cbdgjJSeJZqkmoru39NM657rPMgMnjJmersydl
         peftJWoP3eExxesZadhHHLH9W5zebTm8FTjcnDTCe2UDumknRJhqtzD6TiPgPp/zZtUP
         K0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898142; x=1722502942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88jb28MCxaRhKAwLTwqTSQ3Rf2/thPPgPMnWav/kKuo=;
        b=K+rBxBgQnAmUva43BSqdfHL/h0mvUPRFSOQW7qebcbKllHjmVm1wS/LLhCAgHoBdZK
         djfHHlVBI8fXrXF1++X+WdZgYgIufQiZKZoL4txS9BxNpqqmcSrPvov7Cw3fDuIdrSA+
         c37t9lVzA70ZZms7jWh767w9AVGTfR53xJHxo3+xVp7iXkSvoMrAjR1bzgBeeolv+06X
         zg/71D02aDVUh0IcxuBLP4neWd6U8JhbzzTsK+Zf5yWLv4wzl04Dc5KkC+Y4dMHp2F2+
         s3XCHnhCHTTQWvOHq/Dz6IGcRYr6VNJu3gNhd2I1D6wy2dYMgKj3lgJ/Q3sjE5zr6K17
         40eg==
X-Gm-Message-State: AOJu0Yxju5dHlvL1wFQF2cAMcTC4TkYDIPHm5XIQe6V9WeCZdiPSQIpB
	HggOEoLhL+IDwaQEzwRI4f4bByVnEiQLmyR/T6ul6Rv0vj9eejLF1TKQ6d2/8Ov0XLPKVMDUfAO
	Y
X-Google-Smtp-Source: AGHT+IHS9oTeEyee8SNbah6CunPTN+1xqEJbsEI2hKd3tbvoE9u3yuXI4yINcf+qViuualyGbwU1HQ==
X-Received: by 2002:ac2:51cc:0:b0:52e:9d60:7b4c with SMTP id 2adb3069b0e04-52fd60a1de9mr1009496e87.61.1721898142483;
        Thu, 25 Jul 2024 02:02:22 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:21 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 15/17] ima-policy-appraise-all: set S
Date: Thu, 25 Jul 2024 12:01:29 +0300
Message-ID: <20240725090131.75860-15-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/472

Build with latest poky requires it

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb b/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb
index 88b3698..121e9ff 100644
--- a/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb
+++ b/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb
@@ -4,6 +4,8 @@ LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384
 
 SRC_URI = " file://ima_policy_appraise_all"
 
+S = "${WORKDIR}/${BP}"
+
 inherit features_check
 REQUIRED_DISTRO_FEATURES = "ima"
 
-- 
2.34.1


