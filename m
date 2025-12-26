Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A221E82CDE
	for <webhook@archiver.kernel.org>; Fri, 26 Dec 2025 04:18:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.148195.1766722731870543547
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Dec 2025 20:18:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=ZhvIgYEP;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=fanxcsxb;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BPNrNje3886559
	for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Dec 2025 04:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=MV2ld1CjYmtEbIOGIeD0EOOidTkcQQCf9s+
	kz9Dk0co=; b=ZhvIgYEPuHJb4BoIJpa85gsSt3R4kOVDnIKNgRSobEG3usiWcIu
	z5LT1/aiDoDnz9QmBH4RLzWH5pK5Mo1reKwaPm8eFx2Vy5pHroU6PTkWmmMpisDS
	VWVcdRDk5cmaCw/+BK6vJjaeGLSfsccUrmNnOMGjLGeSiNL/Tb96Uc7AiEOt3Egr
	BCQxTUodm3Ar3NEfkM+acOQRaklbjRGeX1RxRmasvuAbgRZ2RrKfYrLZqYMkjOsA
	kLFukhmSkax/8OS5r0YKfc1AZv32WSXXMc9F+YG49fuDZiuCzHve3NERO2SmJTRr
	uEpCQyCPfO42JEJTxIPrLmR0WlEdM/1FIFg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b8p492mbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Dec 2025 04:18:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f2381ea85so149670265ad.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Dec 2025 20:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766722729; x=1767327529; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MV2ld1CjYmtEbIOGIeD0EOOidTkcQQCf9s+kz9Dk0co=;
        b=fanxcsxbKC9ml7gQ1I3d44Pjjui52KhZWhs2tTxoV0O+/7a0vc68Qtye+SGcCUn0PE
         uE7jvd45/RLA4tYyg9jOHGP9nC721H4mhmkc6jh2ahMMcDUkSssZujmS2I9GRx6qktX0
         WKgyTKsKvt3ae1jjuRQT81zPbXLKw9SF0zl+1E/1GpufkKgdydXaSYJwGJt+zPAQPZL1
         b8wufflli/2m3UyU8lrdXEc1xhege/yG3p8NDD72HwitXOjQ5+B+GMMDs+b3SgIA4Av/
         jCyrUxpI2Qb6kpmGUN5Q2c5plHuJsap1kBiMBf1SgE9Usm1udufMSwthkLcdqpSOIybG
         1+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766722729; x=1767327529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MV2ld1CjYmtEbIOGIeD0EOOidTkcQQCf9s+kz9Dk0co=;
        b=E6pSqg2O0XGbpZm9/SpuDhgstJkfuhTrfdkerX9wVd1gi9NxH1QO9aL3/1RxPzl2pc
         g1BtfBM4f5jnog2YQzUgmXQ8U1RYL/CioPBA2oY3nUu0QCNuCIoqGOWCjsgCapwv0oDi
         pMxTcEB9VyzOO4D7zLLXPHHDAtFLAGAxC4iv8l89Ecns8X0NohmX+KTUoPWBvIZB8+zc
         7wMhr1ZPB15+drcW0bIaS7M81GkXQNsc4XhWz3BFO0e69yZNYc+p5awPQCG8uE1LwpkO
         uQKfrTT3YQyVFo/4pPnc8L3LgVNgWpoedkDOfs299gcTQcFhSozurGwE8L2cVaCHIULF
         2Dpw==
X-Gm-Message-State: AOJu0YxcT/b8TDwOoVx/a+Ww8VJ7P1S1RSeC7GHIHWF8itvpbrl0Gq0H
	pTJVfkaIEgFgal1+iXG6Ns6BtgQOXYZrhtcUIpK9qqtfExfuvfrpHLA7xzTnpbEgRTjB1vPDI4P
	FTt0RvGI5KIgXmFp5wxiBDTGepVppekpPRgiC87Z1Js35qhRN1/JjBdTJn6o10mQnrN5zGWOExV
	nshErZeAeqnvB2
X-Gm-Gg: AY/fxX51W6ULB7fu8qWLd1NfLj3OO1k0MNqR7kSmIJVSMi2JTIL4K0fciw6+DBDlbtx
	3tj/+HcFqkRSiHbBU4lh8DOdiWXzusNIkBS03fVwD5L5PmCAmado+zqxF1MVS6h74WtY2qeHUiR
	TKtIRE7fbXkCyqxRrZdjGloP7+Ql6Dapx+YevC1ajhGj1nqdGH88SjhmnrwCbYeCNf88S+D3/k6
	1tuOQYjpcBTYh9CW7PVPip6uH136Sx0s7/RpWnbWNz4FAwP3y+/HmjR9IdydPVYhEWl1hF4opIJ
	IjppcZq7TasGfDLzPJ8lgCMndKHmg447t7jQ0SGYq5+HytFeZs1fdLuPI0uLehyLrzq+w8Pigei
	Detl+CCmpxfcEW1GR4Qbrs7n1CP4yuxmJtsvfTJqj
X-Received: by 2002:a05:6a21:6da8:b0:340:e2dc:95ae with SMTP id adf61e73a8af0-376aa4fc23bmr21787372637.42.1766722729459;
        Thu, 25 Dec 2025 20:18:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFntY8UWfuIOxrE7t7AGfu2QgkTH8FCTlkU7dwtLZgwfv3f1ZNLgAZZjNzPTgySRPgSAx0wfA==
X-Received: by 2002:a05:6a21:6da8:b0:340:e2dc:95ae with SMTP id adf61e73a8af0-376aa4fc23bmr21787352637.42.1766722728713;
        Thu, 25 Dec 2025 20:18:48 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a17fb2sm17646907a12.12.2025.12.25.20.18.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 20:18:48 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH] dpdk: upgrade 23.11.1 -> 23.11.5
Date: Fri, 26 Dec 2025 09:48:44 +0530
Message-ID: <20251226041844.3916813-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wMKN2tu42xXPrvzew7fqgdGMtk54K01O
X-Authority-Analysis: v=2.4 cv=esbSD4pX c=1 sm=1 tr=0 ts=694e0caa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=t7CeM3EgAAAA:8 a=dNTILLUlUOI2p3W5fKwA:9 a=1OuFwYUASf3TG4hYMiVC:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI2MDAzOCBTYWx0ZWRfX8rm/kthFYV+/
 RavFORICPODcJdI1dNMjJFXzJTaSOLAMdQEYbMs1vAURMfbvo87o3eFZgyIOgLcfPCMzIrZJk5v
 u801MUtdn/qYsRTh4XXTKkKZB5tox7eV1qJDUQQGsNICdlJMhOFbcxELyhbCr8elBgx3OOjZSNi
 x4ntS83t+E08OZCr/fZwfGqfPsf/Etepl2gREu8iFL6TSKN7XF0/If2xivAvPbrS48YceaLJQRV
 deTnI9V7bnYmiilxoOUWagy4OiJHVwOIL+Kvb5qKIfccKuKqNAW7xTPFqkLX40AnmmiY5o3tMyY
 Y9GUT2FaMwN6F7tyfg9CuuZBaqnzsjf2Ov1wZShGv6s4Z0EQOPJk5vVBnaGRla7FjX9c6fKkGcS
 Mr+SyEMbk+YyGRIhQfdw3hzp+jRXMEuKZ1FM52hXKBOO84CAyoDMh80YypzO3bFWNGAKlW4HHJp
 QSktKQG2faWpYjCR3qQ==
X-Proofpoint-GUID: wMKN2tu42xXPrvzew7fqgdGMtk54K01O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-26_01,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512260038
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Dec 2025 04:18:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2875

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Upgrade to latest version for 23.11 LTS. Drop the patches that have
already been merged.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 recipes-extended/dpdk/dpdk.inc                |  2 +-
 ...1-net-gve-base-fix-build-with-Fedora.patch | 95 -------------------
 ...0001-net-ionic-fix-build-with-Fedora.patch | 65 -------------
 .../dpdk/{dpdk_23.11.1.bb => dpdk_23.11.5.bb} |  4 +-
 4 files changed, 2 insertions(+), 164 deletions(-)
 delete mode 100644 recipes-extended/dpdk/dpdk/0001-net-gve-base-fix-build-with-Fedora.patch
 delete mode 100644 recipes-extended/dpdk/dpdk/0001-net-ionic-fix-build-with-Fedora.patch
 rename recipes-extended/dpdk/{dpdk_23.11.1.bb => dpdk_23.11.5.bb} (90%)

diff --git a/recipes-extended/dpdk/dpdk.inc b/recipes-extended/dpdk/dpdk.inc
index 41618e0..f88ad98 100644
--- a/recipes-extended/dpdk/dpdk.inc
+++ b/recipes-extended/dpdk/dpdk.inc
@@ -6,7 +6,7 @@ LIC_FILES_CHKSUM = "file://license/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4
                     file://license/lgpl-2.1.txt;md5=4b54a1fd55a448865a0b32d41598759d \
                     file://license/bsd-3-clause.txt;md5=0f00d99239d922ffd13cabef83b33444"
 
-SRC_URI = "git://dpdk.org/git/dpdk${STABLE};protocol=https;branch=${BRANCH} \
+SRC_URI = "git://dpdk.org/git/dpdk${STABLE};protocol=https;branch=${BRANCH};tag=v${PV} \
 "
 
 CVE_PRODUCT = "data_plane_development_kit"
diff --git a/recipes-extended/dpdk/dpdk/0001-net-gve-base-fix-build-with-Fedora.patch b/recipes-extended/dpdk/dpdk/0001-net-gve-base-fix-build-with-Fedora.patch
deleted file mode 100644
index 05efc3f..0000000
--- a/recipes-extended/dpdk/dpdk/0001-net-gve-base-fix-build-with-Fedora.patch
+++ /dev/null
@@ -1,95 +0,0 @@
-From f0d9e787747dda0715654da9f0501f54fe105868 Mon Sep 17 00:00:00 2001
-From: Joshua Washington <joshwash@google.com>
-Date: Thu, 17 Oct 2024 16:42:33 -0700
-Subject: net/gve/base: fix build with Fedora Rawhide
-
-Currently, a number of integer types are typedef'd to their corresponding
-userspace or RTE values. This can be problematic if these types are
-already defined somewhere else, as it would cause type collisions.
-This patch changes the typedefs to #define macros which are only defined
-if the types are not defined already.
-
-Note: this was reported by OBS CI on 2024/10/17, when compiling DPDK
-in Fedora Rawhide.
-
-Fixes: c9ba2caf6302 ("net/gve/base: add OS-specific implementation")
-Fixes: abf1242fbb84 ("net/gve: add struct members and typedefs for DQO")
-Cc: stable@dpdk.org
-
-Upstream-Status: Backport [https://git.dpdk.org/dpdk/commit/?id=f0d9e787747dda0715654da9f0501f54fe105868]
-
-Reported-by: David Marchand <david.marchand@redhat.com>
-Signed-off-by: Joshua Washington <joshwash@google.com>
-Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
----
- drivers/net/gve/base/gve_osdep.h | 48 ++++++++++++++++++++++++++++++----------
- 1 file changed, 36 insertions(+), 12 deletions(-)
-
-(limited to 'drivers/net/gve/base/gve_osdep.h')
-
-diff --git a/drivers/net/gve/base/gve_osdep.h b/drivers/net/gve/base/gve_osdep.h
-index c0ee0d567c..64181cebd6 100644
---- a/drivers/net/gve/base/gve_osdep.h
-+++ b/drivers/net/gve/base/gve_osdep.h
-@@ -29,22 +29,46 @@
- #include <sys/utsname.h>
- #endif
- 
--typedef uint8_t u8;
--typedef uint16_t u16;
--typedef uint32_t u32;
--typedef uint64_t u64;
-+#ifndef u8
-+#define u8 uint8_t
-+#endif
-+#ifndef u16
-+#define u16 uint16_t
-+#endif
-+#ifndef u32
-+#define u32 uint32_t
-+#endif
-+#ifndef u64
-+#define u64 uint64_t
-+#endif
- 
--typedef rte_be16_t __sum16;
-+#ifndef __sum16
-+#define __sum16 rte_be16_t
-+#endif
- 
--typedef rte_be16_t __be16;
--typedef rte_be32_t __be32;
--typedef rte_be64_t __be64;
-+#ifndef __be16
-+#define __be16 rte_be16_t
-+#endif
-+#ifndef __be32
-+#define __be32 rte_be32_t
-+#endif
-+#ifndef __be64
-+#define __be64 rte_be64_t
-+#endif
- 
--typedef rte_le16_t __le16;
--typedef rte_le32_t __le32;
--typedef rte_le64_t __le64;
-+#ifndef __le16
-+#define __le16 rte_le16_t
-+#endif
-+#ifndef __le32
-+#define __le32 rte_le32_t
-+#endif
-+#ifndef __le64
-+#define __le64 rte_le64_t
-+#endif
- 
--typedef rte_iova_t dma_addr_t;
-+#ifndef dma_addr_t
-+#define dma_addr_t rte_iova_t
-+#endif
- 
- #define ETH_MIN_MTU	RTE_ETHER_MIN_MTU
- #define ETH_ALEN	RTE_ETHER_ADDR_LEN
--- 
-cgit v1.2.3
-
diff --git a/recipes-extended/dpdk/dpdk/0001-net-ionic-fix-build-with-Fedora.patch b/recipes-extended/dpdk/dpdk/0001-net-ionic-fix-build-with-Fedora.patch
deleted file mode 100644
index ce9a762..0000000
--- a/recipes-extended/dpdk/dpdk/0001-net-ionic-fix-build-with-Fedora.patch
+++ /dev/null
@@ -1,65 +0,0 @@
-From 45d48356e552d661885e1c29613891c11cd8ff4a Mon Sep 17 00:00:00 2001
-From: Timothy Redaelli <tredaelli@redhat.com>
-Date: Thu, 24 Oct 2024 11:30:06 +0200
-Subject: net/ionic: fix build with Fedora Rawhide
-
-Currently, a number of integer types are typedef'd to their corresponding
-userspace or RTE values. This can be problematic if these types are
-already defined somewhere else, as it would cause type collisions.
-This patch changes the typedefs to #define macros which are only defined
-if the types are not defined already.
-
-Fixes: 5ef518098ec6 ("net/ionic: register and initialize adapter")
-
-Upstream-Status: Backport [https://git.dpdk.org/dpdk-stable/patch/?id=45d48356e552d661885e1c29613891c11cd8ff4a]
-
-Signed-off-by: Timothy Redaelli <tredaelli@redhat.com>
-Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
----
- drivers/net/ionic/ionic_osdep.h | 30 ++++++++++++++++++++++--------
- 1 file changed, 22 insertions(+), 8 deletions(-)
-
-diff --git a/drivers/net/ionic/ionic_osdep.h b/drivers/net/ionic/ionic_osdep.h
-index 68f767b920..97188dfd59 100644
---- a/drivers/net/ionic/ionic_osdep.h
-+++ b/drivers/net/ionic/ionic_osdep.h
-@@ -30,14 +30,28 @@
- 
- #define __iomem
- 
--typedef uint8_t	 u8;
--typedef uint16_t u16;
--typedef uint32_t u32;
--typedef uint64_t u64;
--
--typedef uint16_t __le16;
--typedef uint32_t __le32;
--typedef uint64_t __le64;
-+#ifndef u8
-+#define u8 uint8_t
-+#endif
-+#ifndef u16
-+#define u16 uint16_t
-+#endif
-+#ifndef u32
-+#define u32 uint32_t
-+#endif
-+#ifndef u64
-+#define u64 uint64_t
-+#endif
-+
-+#ifndef __le16
-+#define __le16 rte_le16_t
-+#endif
-+#ifndef __le32
-+#define __le32 rte_le32_t
-+#endif
-+#ifndef __le64
-+#define __le64 rte_le64_t
-+#endif
- 
- #define ioread8(reg)		rte_read8(reg)
- #define ioread32(reg)		rte_read32(rte_le_to_cpu_32(reg))
--- 
-cgit v1.2.3
-
diff --git a/recipes-extended/dpdk/dpdk_23.11.1.bb b/recipes-extended/dpdk/dpdk_23.11.5.bb
similarity index 90%
rename from recipes-extended/dpdk/dpdk_23.11.1.bb
rename to recipes-extended/dpdk/dpdk_23.11.5.bb
index b5aab21..0123c65 100644
--- a/recipes-extended/dpdk/dpdk_23.11.1.bb
+++ b/recipes-extended/dpdk/dpdk_23.11.5.bb
@@ -1,13 +1,11 @@
 include dpdk.inc
 
 SRC_URI += " file://0001-config-meson-get-cpu_instruction_set-from-meson-opti.patch \
-             file://0001-net-ionic-fix-build-with-Fedora.patch \
-             file://0001-net-gve-base-fix-build-with-Fedora.patch \
              file://0001-Add-new-tracepoint-function-for-type-time_t.patch"
 
 STABLE = "-stable"
 BRANCH = "23.11"
-SRCREV = "a6ec5765cf83d3d58cbd6d4ed5b92b4a06f8a808"
+SRCREV = "62f583c49bf67dd4d6733ece14e55fe6839e66d1"
 
 def get_cpu_instruction_set(bb, d):
     import re
-- 
2.52.0


