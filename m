Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABCFCA0EFA
	for <webhook@archiver.kernel.org>; Sat, 23 Aug 2025 19:14:55 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web10.3131.1755976374157588846
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 23 Aug 2025 12:12:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@underview.tech header.s=google header.b=JUGdWkmX;
 spf=pass (domain: underview.tech, ip: 209.85.222.182, mailfrom: vince@underview.tech)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e8706df76bso464924885a.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 23 Aug 2025 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=underview.tech; s=google; t=1755976373; x=1756581173; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJvJvesU3+EVRnT5NshwQiqeZ8+Y26frPXmDXW2Xsr4=;
        b=JUGdWkmX2X8f3o20a0Sgqj2Nlt+r68IdToxf0fvD6+NXAD+Bb6v9AP4RmXf87Vj742
         PEHB/HOR7ASrg5ob/Xix6JHGAxYboUgx6pd7Sgqmu98jDPTWEu3D2wxSbAJgniH7iEtB
         eWa829K7OiRC8G7R/zdMcDIzd4re636K7jzKJMtrhQQcJAZi99hSwSDWrgjCaQ1RWyIX
         bIHkcavOWkF6BMjtCeHMqQVriT2tbEw7VHdDNw4Zdqm6wBaHDNfneh6fMLITmFO8ceTn
         xZB9K81f3FhJ3gb+KVnpryFtjhwo1LLC8pbomGBBPph8rAL29szrgraqVOM8QNnXobNy
         v5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755976373; x=1756581173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJvJvesU3+EVRnT5NshwQiqeZ8+Y26frPXmDXW2Xsr4=;
        b=CGcARQaeOz0OPbXf9YZIn4okGA6h7IZilp8Z6REC5KooUsdoWNQmN55TOoYe1t24FD
         YFeSkjEL9RxQGlL2hcQd5/i1nCKqUC7n28qQ9aBnS2yg6Pc96NZNFqgp51pCSl5iCuaU
         7as8CgcK05W/NcnEVv6bEwAEEW0iWkYAoToQ0Tkm1iDmUaEC2f9LLhC+KnfAQBbQ9p+I
         ArGK87nNQY/XMT1M10ezgaysYym2CasiUrclvyVPaBF3AfDhriO3yf5LRC553YYz/Oyz
         UAT/IfRQV4RFwVmQLW6UrT37TaYd1a5+hq4/5gYofy617nswuyTPAPh3ejy8CpyFwvVe
         h0Rg==
X-Gm-Message-State: AOJu0YwRdr23Zq3NbVhE/uLjgs9eCE6Qsx9Q8WlTlaxtanmW8M8FFnq3
	MNfL0nEhTB16x0uW0xCKEFVILWqzds/P2YbhK4giEVgxrBhBuHyLqW1IX5+ZP9B/UaYdo79FJIP
	W2Spt
X-Gm-Gg: ASbGncvHQu1uOAR7FK5w2yInq3mdv1Rn2ZXfmcAFrT9guCdf7YfFtoclwOAfLlpuKik
	tMZgMcw2EkUD/MpJMVjNgCV1sbWAePvd67ia6zFohb/5GuHgUz4TIADLk4HSlNAA8Nan5ToDVHr
	osqzbpgZUX3k8beAYzB6ktcvM0TCg6tt8bvJCFUYrYcRK/UuNYWJtexChm3kZDT0ZVnWDbWn5GE
	XId/9R+iXu9B6P01qPuZVASG+p3jZi8HawqMiTUBMGi4cRwckZ0/Uy+qymvc6y2UK+mzuLWeUvr
	4m/nT+c9+xgPAyxBG7fxsGAWNU7ZoSFSJ26S1jrSTeNvl68beIkfXEKp/Gw5aoWlfb9F3Q0emyp
	9BzqmAiH40bsCOGdY3JWiYQ==
X-Google-Smtp-Source: AGHT+IHCLbK+9n3KtaqN+u7FTUX88ln/MKs0t7jbOk1RNcDSOcC6XRgwdasuDAePVTQ7NESRWi+1FQ==
X-Received: by 2002:a05:620a:1a87:b0:7e8:2128:107a with SMTP id af79cd13be357-7ea1105b03fmr774874085a.64.1755976372796;
        Sat, 23 Aug 2025 12:12:52 -0700 (PDT)
Received: from vince-server.. ([2601:406:4d01:1820::6d26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebed8902fcsm190959885a.20.2025.08.23.12.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 12:12:52 -0700 (PDT)
From: "Vincent Davis Jr" <vince@underview.tech>
To: yocto-patches@lists.yoctoproject.org
Cc: Vincent Davis Jr <vince@underview.tech>
Subject: [meta-selinux][PATCH 1/2] libselinux-python: fix No module named pip
Date: Sat, 23 Aug 2025 15:12:43 -0400
Message-ID: <20250823191244.574665-1-vince@underview.tech>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 23 Aug 2025 19:14:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2079

When running the do install task run
into No modules named pip.

Add python3-pip-native to DEPENDS
so that pip it available.

Signed-off-by: Vincent Davis Jr <vince@underview.tech>
---
 recipes-security/selinux/libselinux-python_3.9.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/selinux/libselinux-python_3.9.bb b/recipes-security/selinux/libselinux-python_3.9.bb
index 8431ca1..a4de036 100644
--- a/recipes-security/selinux/libselinux-python_3.9.bb
+++ b/recipes-security/selinux/libselinux-python_3.9.bb
@@ -19,7 +19,7 @@ SRC_URI += "\
 
 S = "${UNPACKDIR}/${BP}/libselinux"
 
-DEPENDS = "libsepol libpcre2 swig-native python3-setuptools-scm-native"
+DEPENDS = "libsepol libpcre2 swig-native python3-setuptools-scm-native python3-pip-native"
 DEPENDS:append:libc-musl = " fts"
 
 RDEPENDS:${PN} = "libselinux python3-core python3-shell"
-- 
2.43.0


