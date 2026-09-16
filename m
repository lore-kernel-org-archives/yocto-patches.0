Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9765C982D5
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:50 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26467.1789595921181404469
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Mo/72cz3;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9120eda2195so1379226d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595920; x=1790200720; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/B0iyqx+N5P/VXltPELdkdgAOW5C911wOHHEcXmBo6Q=;
        b=Mo/72cz3kAMahaBdhkzq/h+KL5p4E7PnDscvFKspxjEi2gsOYXFHQxZOtmwxkZkdba
         vQf48Bz1mKPoR+CZUQinmdVELxH1sj5Py+K3Ohtv5GOlHs3poMIFgP4gThQ7Gi5le+c5
         bSxkXwtV7Cb5yD0SY04Hhg+uvKTDfBRSahonw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595920; x=1790200720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/B0iyqx+N5P/VXltPELdkdgAOW5C911wOHHEcXmBo6Q=;
        b=e7EWUSe6kmITS1f9Y96qpjUmm7zYunw/vvXaKruweNAccmQVky5hAKzXoqqQ6nGNtb
         dWOLNZkABkZ0ByuPbNIU4Hjlsu6xdBBGIGH9MW7Du/V1pkwLwKw+40z099SAUPI4wR1x
         gmZWFVDJCgscEpkjJGFynmpEGCizCyZ8cnGm0pL5OMqZEt/ZLJuPNaDrvJa1UThah6ab
         L1WKCbY9qG43MTtKt0/etY4wfr5lYPXCJnZPdC2s1plpbA36OPXTJAsMpvi7ZiYIDwDj
         CYDqe1+Q6/FszY6H7WvYab1GO3m72tLVQhwBuMvpahUyZrcbYVj/Sxc0Nyj2dnBCZ5Bj
         18kg==
X-Gm-Message-State: AFuF++n03NnQ8C55H8aXIGGDjXCmvuRdAtl/3LbcZZhPcYohYSnAmKsD
	jCNHnwhQNSTruHTWNx2thcmj1DSGy4aMy5ek4ub48vdHunucwIyQpUpjhETAzUfEPtPOBXXmdI+
	U8uZ0
X-Gm-Gg: AYBFou3Jv9YyP620Rk8zsSCbDrwjKgQCT68IrerbczA+dYr47j8CY3NY0x/PGK72UCW
	KtKabWLTN87PCU5iNg64lOmU7CdAC0VivKGJpIPHZ7ibzhymkuJRRUj8jEmIcSi47mX/K1R6FdX
	WxhjfPBF9FC2AJ314984nDwhYP/Hng/vmkSl8lzwMH2ZxdJaw7yriVw9XfOja08hcZ7yhRx0aKN
	MTolGPF1CkwIukAI5WaFMz6MlEyvb18dZPEEAUzqc3X0q9FSOoRhnGLg1O5h1Zai7hAQw7BPKr6
	1nwZp0nElG5UjFFyd6PFy57tMUJT16Mx0e7LRx2hVeD1IXneWXY3nmIImD+pgpjOeA2Z+cPT8Xh
	9hDly1yEfQ2fyxw+Q6YH71J452nTul2iw2Qyu91AuTvja62irF/TDLnt7iw4C+TZgXHm4e8sqG+
	jZ1J260+6UTqWb/bjHZ8+Kln8Rofdg1frz4eGIvyBMzwirIpTBfyquXoZpiGQHybY2STD5DNZ8F
	eCeyJlgaViR04nSkRuGndmDl1hmlQlOwPIwITJoyfOhZ7ylPXTKN+kTK58ffLcve9D95cMs+Pfu
	JIJqreURLDPHG02p+bscFi9IEaBLFKFlWxk=
X-Received: by 2002:a05:620a:8009:b0:939:319f:d6e3 with SMTP id af79cd13be357-93bc624036emr211241685a.5.1789595919928;
        Wed, 16 Sep 2026 14:58:39 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:39 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 03/19] scap-security-guide: upgrade 0.1.80 -> 0.1.81
Date: Wed, 16 Sep 2026 17:58:03 -0400
Message-ID: <3109ea781f4be547eab99b6208641730db241a7d.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4859

Release notes:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.82

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...cap-security-guide_0.1.80.bb => scap-security-guide_0.1.81.bb} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.80.bb => scap-security-guide_0.1.81.bb} (100%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.81.bb
similarity index 100%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.81.bb
-- 
2.55.0


