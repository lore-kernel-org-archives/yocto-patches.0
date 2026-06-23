Return-Path: <patel.rajkumar@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4126FCD4F26
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 09:43:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17084.1782207791152205453
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 02:43:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Vmia2LJ0;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=OOv4jnYN;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: patel.rajkumar@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cYx83646579
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 09:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=53Y0OiAAKK5CeaCr25Y5aCRJLzr6nIm/bJK
	H5LUprf0=; b=Vmia2LJ0dNRMK0lPPupMkMXd9AbQHYKO7uHM09m1rBF1u2uziju
	jEsGI7PGuaablVeHYYrxkPcPl/5jKCy70oKQutjPBiWb63vjmdE4Q3Qx4eG2K53E
	UvBrIotgcA8kKwpUl55SxObafA5pgbYdPCYeYJCdYhyEr+VgPunFa8liyJsCn4vx
	9vH7cHgnpX/ReIijvyiPNDPImTPqoJyWeOkkwZdCwlVffRFNph7pEhTayMWwBDW9
	yRrfYTKeMbHG8LNA/OAWEkDJBqyobRu203YlyFLxnpSE2ATLN0izamTAubjFyIRY
	evqkigd9NR7fM66hf1QKw7ghNjbd6eStT9A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmut2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 09:43:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88e0f04e51so3353389a12.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782207789; x=1782812589; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=53Y0OiAAKK5CeaCr25Y5aCRJLzr6nIm/bJKH5LUprf0=;
        b=OOv4jnYNkQeDWHJw3Ww+FdCsxsXYvVL51f4JOKyyK6neiVq6E9XOP48y7kVza5Cuzx
         HRx968W+5t4x6QfeZAVVYs2RmSRvc3D11AhJBZHbFCRDlsBQssN71QwtliiuFzuWiP5Q
         TsoEaSa4i2V+WwCSaP+Pv+VieshH1y0zfLeVDlIVzHSke9xp+crlr3xAAG6w9E6mc+iY
         IGTN1Xa4DE8BQ1S5PUc9KfsFrCepbTmiVNvGjkReypJgPoICwk27bwbV9544DqmyKbKI
         LxmKwpGrFoXwcsrCfMZ/VFDg0PVFoYkLViSUg6zI6LRi+3AwLA9Gfa2D7lyAlmdFLtsH
         n1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207789; x=1782812589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53Y0OiAAKK5CeaCr25Y5aCRJLzr6nIm/bJKH5LUprf0=;
        b=KqGFru1Fe9+aP0DM2rVJwX7CmNYOE2eF/U3AT47mh9j5S4E3GblVRamX8eJv+gIJE4
         vDtSDi9TxbAYvXaPYp9hKmyjaAjavFhplMCv87BSC3nXI2ZDWazuI45WBS7pe+IZMUq7
         Kn6XO3F4Gz7MKmsutM8AtKh27R9FlIGzboW6VgTjaYru50cridmYcd0AA24BgeMn/X/y
         DyE+esquFpZRzSa8kkyJGdCmMzMLcDp4/evqzu0wQI/lKbaGBQVEAau9DiH19S0Gmws2
         8TjBfKRuKSQPUgTFgiyhmUubjwN+gt0MFr5SVR5WBppW0Z/KCaF/SEZkaIU7n4qeZ4kB
         Bygg==
X-Gm-Message-State: AOJu0YyYPYWf5Tdw6r66OrQzSn4bUBKUX+DV/9uxZI6WT7b1GTZHdzEj
	llenOaQV418/m9lTFhFFqcW3R9qJXhxKPT/RDYTUXZZ4a1cN3PmIQ+h6A/zxmxvRVxZvyf4qU6T
	iIC83oSrYONKyXkuYQ6fUP9ajp7CfGt8YnN5d4MhI4rjeqWS8jTRdiFSis/ENaeG2PpDXdhBtRn
	VJn9qEfprB9Q==
X-Gm-Gg: AfdE7cmbTiBCSW0Tk+LZ9JZ13hAGXgi4KkWEc1yVDo7gxT/WFBoFvFmWh+LfP+MBVgA
	E4QrxyGZwct2aL0kvQw9ktv6ldMmyPx3VCmR5f+5P42WJR4LBX71y3PsKbjtlWDiuf+tYwZCHEH
	hrGCQ7140LwscX1IrXIplU6WN5CDO5fdnNFXlkIe3BPPK2ZhhD/auj2WfdVSCy0iJWzUeuvKdl/
	lA+fLhkvBMcYMlm+KgIBD5MUteWE2G8ZYnhbLlycu38Vy7dGiYUC5a06qVOCeuXJ71N8e4Q7qaa
	nsopOp2CmsfCK5O+oEBLnxL0bZ/YqsY3+mhoVwBey1b4bFgiCZQL+cGTBbUjiwUWJLbUKXoAakt
	yUZ97yfXzFa96fYGdEmVDcfSvaNjspPPxRzMu7jVHvNC8lw==
X-Received: by 2002:a05:6a00:3e23:b0:845:3d82:10fc with SMTP id d2e1a72fcca58-8455051aba1mr19153281b3a.0.1782207788539;
        Tue, 23 Jun 2026 02:43:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e23:b0:845:3d82:10fc with SMTP id d2e1a72fcca58-8455051aba1mr19153230b3a.0.1782207787720;
        Tue, 23 Jun 2026 02:43:07 -0700 (PDT)
Received: from hu-rajkpate-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ebd123sm9530678b3a.47.2026.06.23.02.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 02:43:07 -0700 (PDT)
From: Rajkumar Patel <patel.rajkumar@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: anuj.mittal@oss.qualcomm.com,
        Rajkumar Patel <patel.rajkumar@oss.qualcomm.com>
Subject: [meta-dpdk][PATCH] xdp-tools: Remove recipe
Date: Tue, 23 Jun 2026 15:12:51 +0530
Message-Id: <20260623094251.1397656-1-patel.rajkumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3OCBTYWx0ZWRfX2AxpB0/YMcbx
 1nXu9bRu2GbacnEhHMfaxXdNVCPjqCqr2DrQoezz+mokPPi1vuKSRrw9KGDaQEKa6LflsREi2ei
 wpiq6pvP2wJix8/lhXSzJbBEuNJ0s6M=
X-Proofpoint-GUID: KYzefEQNUPOxoihD2o7Q8NenJJcgUMih
X-Proofpoint-ORIG-GUID: KYzefEQNUPOxoihD2o7Q8NenJJcgUMih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3OCBTYWx0ZWRfX0wwa7sCAH2vO
 yZNSASL5ngbNv8RoLzAI4MyfE1yweECC5xPAW6Uc+i/7jIiwVPDFny6X5oNEx7DFjJ1CEM8ud80
 Kj02CWPvryGKTMj0PcTgQ7ypu107yDthdXjppBW/9smx0ObCvR214ogVEzEMnJySdEsnz4y26sI
 ZuBNl8dsljz3FxbM3VvOwXczWdPXvmLE/dkH4opXCbmRqzJOxMTU6yxjDXH9vM2+7mzIfkLD2LB
 2H+OMNHz2ZFWimAtlV3F4gFpnOpuyk8JFCrOmHvBR2Nbrs/U6uNbKhu55LYa0tpa08g/JI/C3cv
 +DCSfWtUqHxX3JnlqrtHuouJu8yySVfFpnqccKZuCrOckE+gMlZL7talZe7Z01XJVXZ5ZGDYFXS
 YTLZhwsFreTLo/xv65QBCo5zpe2pMUTyLKUZAqLUUa10OGFZ2CxBHv9w+zc9vnpgUwCA2I8MjBK
 WwsnMyPoEZKBJlM39xA==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a3a552d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=sattWYq3WWoUqiLc9UoA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230078
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 09:43:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4274

xdp-tools is a generic recipe with no DPDK-specific changes and has
been merged into meta-oe [1]. Remove it from this layer to avoid
duplication and potential conflicts.

Also remove the BBFILES_DYNAMIC entry in layer.conf that registered
the clang-layer dynamic layer solely for this recipe.

[1] https://github.com/openembedded/meta-openembedded/tree/master/
    meta-oe/recipes-support/xdp-tools

Signed-off-by: Rajkumar Patel <patel.rajkumar@oss.qualcomm.com>
---
 conf/layer.conf                               |  5 ---
 ...0001-configure-skip-toolchain-checks.patch | 44 -------------------
 ...-not-detect-libbpf-header-from-sysro.patch | 44 -------------------
 .../0003-Makefile-fix-KeyError-failure.patch  | 31 -------------
 .../0004-Makefile-fix-libxdp.pc-error.patch   | 34 --------------
 .../xdp-tools/xdp-tools_1.2.10.bb             | 36 ---------------
 6 files changed, 194 deletions(-)
 delete mode 100644 dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0001-configure-skip-toolchain-checks.patch
 delete mode 100644 dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0002-Makefile-It-does-not-detect-libbpf-header-from-sysro.patch
 delete mode 100644 dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0003-Makefile-fix-KeyError-failure.patch
 delete mode 100644 dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0004-Makefile-fix-libxdp.pc-error.patch
 delete mode 100644 dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools_1.2.10.bb

diff --git a/conf/layer.conf b/conf/layer.conf
index b53a1af..776012d 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -15,8 +15,3 @@ LAYERDEPENDS_dpdk = "core"
 # cause compatibility issues with other layers
 LAYERVERSION_dpdk = "1"
 LAYERSERIES_COMPAT_dpdk = "whinlatter wrynose"
-
-BBFILES_DYNAMIC += " \
-    clang-layer:${LAYERDIR}/dynamic-layers/clang-layer/*/*/*.bb \
-    clang-layer:${LAYERDIR}/dynamic-layers/clang-layer/*/*/*.bbappend \
-"
diff --git a/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0001-configure-skip-toolchain-checks.patch b/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0001-configure-skip-toolchain-checks.patch
deleted file mode 100644
index 0c89152..0000000
--- a/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0001-configure-skip-toolchain-checks.patch
+++ /dev/null
@@ -1,44 +0,0 @@
-From 9c9dce2e5f04de65b7b00321f96fff6071546ea1 Mon Sep 17 00:00:00 2001
-From: Naveen Saini <naveen.kumar.saini@intel.com>
-Date: Mon, 17 Oct 2022 15:44:16 +0800
-Subject: [PATCH] configure: skip toolchain checks
-
-Current logic fetch full command line along with the tool. i.e
-gcc -m64 -march=skylake -mtune=generic ...
-
-Which throws ERROR: Cannot find tool -m64
-
-So need to re-write for loop, so it can work in cross-compilation
-environment too.
-
-Upstream-Status: Inappropriate
-
-Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
-
----
- configure | 12 ++++++------
- 1 file changed, 6 insertions(+), 6 deletions(-)
-
-diff --git a/configure b/configure
-index b4e824f..10618fc 100755
---- a/configure
-+++ b/configure
-@@ -69,12 +69,12 @@ check_toolchain()
-     CLANG=$(find_tool clang "$CLANG")
-     LLC=$(find_tool llc "$LLC")
- 
--    for TOOL in $PKG_CONFIG $CC $LD $OBJCOPY $CLANG $LLC $M4; do
--        if [ ! $(command -v ${TOOL} 2>/dev/null) ]; then
--            echo "*** ERROR: Cannot find tool ${TOOL}" ;
--            exit 1;
--        fi;
--    done
-+    #for TOOL in $PKG_CONFIG $CC $LD $OBJCOPY $CLANG $LLC $M4; do
-+    #    if [ ! $(command -v ${TOOL} 2>/dev/null) ]; then
-+    #        echo "*** ERROR: Cannot find tool ${TOOL}" ;
-+    #        exit 1;
-+    #    fi;
-+    #done
- 
-     clang_version=$($CLANG --version | grep -Po '(?<=clang version )[[:digit:]]+')
-     if [ "$?" -ne "0" ]; then
diff --git a/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0002-Makefile-It-does-not-detect-libbpf-header-from-sysro.patch b/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0002-Makefile-It-does-not-detect-libbpf-header-from-sysro.patch
deleted file mode 100644
index 2e66783..0000000
--- a/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0002-Makefile-It-does-not-detect-libbpf-header-from-sysro.patch
+++ /dev/null
@@ -1,44 +0,0 @@
-From 2840cf0b89497f545fae2eed7ece3f3c5fc558e3 Mon Sep 17 00:00:00 2001
-From: Naveen Saini <naveen.kumar.saini@intel.com>
-Date: Mon, 17 Oct 2022 15:50:34 +0800
-Subject: [PATCH 2/4] Makefile: It does not detect libbpf header from sysroot
-
-So adding sysroot headers path.
-
-Upstream-Status: OE-Specific
-
-Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
----
- lib/common.mk       | 2 +-
- lib/libxdp/Makefile | 2 +-
- 2 files changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/lib/common.mk b/lib/common.mk
-index 56c0406..ab0bad8 100644
---- a/lib/common.mk
-+++ b/lib/common.mk
-@@ -55,7 +55,7 @@ LIBXDP_SOURCES := $(wildcard $(LIBXDP_DIR)/*.[ch] $(LIBXDP_DIR)/*.in)
- KERN_USER_H ?= $(wildcard common_kern_user.h)
- 
- CFLAGS += -I$(HEADER_DIR) -I$(LIB_DIR)/util $(ARCH_INCLUDES)
--BPF_CFLAGS += -I$(HEADER_DIR) $(ARCH_INCLUDES)
-+BPF_CFLAGS += -I$(HEADER_DIR) $(ARCH_INCLUDES) -I${STAGING_INCDIR}/
- 
- BPF_HEADERS := $(wildcard $(HEADER_DIR)/bpf/*.h) $(wildcard $(HEADER_DIR)/xdp/*.h)
- 
-diff --git a/lib/libxdp/Makefile b/lib/libxdp/Makefile
-index 358b751..8f459d8 100644
---- a/lib/libxdp/Makefile
-+++ b/lib/libxdp/Makefile
-@@ -30,7 +30,7 @@ PC_FILE := $(OBJDIR)/libxdp.pc
- TEMPLATED_SOURCES := xdp-dispatcher.c
- 
- CFLAGS += -I$(HEADER_DIR)
--BPF_CFLAGS += -I$(HEADER_DIR)
-+BPF_CFLAGS += -I$(HEADER_DIR) -I${STAGING_INCDIR}/
- 
- 
- ifndef BUILD_STATIC_ONLY
--- 
-2.25.1
-
diff --git a/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0003-Makefile-fix-KeyError-failure.patch b/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0003-Makefile-fix-KeyError-failure.patch
deleted file mode 100644
index 41c57f6..0000000
--- a/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0003-Makefile-fix-KeyError-failure.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From 157546fbc4f18751c52b3c8788879c05cf253331 Mon Sep 17 00:00:00 2001
-From: Naveen Saini <naveen.kumar.saini@intel.com>
-Date: Mon, 17 Oct 2022 16:02:46 +0800
-Subject: [PATCH 3/4] Makefile: fix KeyError failure
-
-Error:
-Exception: KeyError: 'getpwuid(): uid not found: 11857215'
-
-Upstream-Status: Inappropriate
-
-Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
----
- lib/libxdp/Makefile | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/lib/libxdp/Makefile b/lib/libxdp/Makefile
-index 8f459d8..9a340a3 100644
---- a/lib/libxdp/Makefile
-+++ b/lib/libxdp/Makefile
-@@ -55,7 +55,7 @@ install: all
- 	$(Q)install -d -m 0755 $(DESTDIR)$(BPF_OBJECT_DIR)
- 	$(Q)install -m 0644 $(LIB_HEADERS) $(DESTDIR)$(HDRDIR)/
- 	$(Q)install -m 0644 $(PC_FILE) $(DESTDIR)$(LIBDIR)/pkgconfig/
--	$(Q)cp -fpR $(SHARED_LIBS) $(STATIC_LIBS) $(DESTDIR)$(LIBDIR)
-+	$(Q)cp -fpR --no-preserve=ownership $(SHARED_LIBS) $(STATIC_LIBS) $(DESTDIR)$(LIBDIR)
- 	$(Q)install -m 0755 $(XDP_OBJS) $(DESTDIR)$(BPF_OBJECT_DIR)
- 	$(if $(MAN_FILES),$(Q)install -m 0755 -d $(DESTDIR)$(MANDIR)/man3)
- 	$(if $(MAN_FILES),$(Q)install -m 0644 $(MAN_FILES) $(DESTDIR)$(MANDIR)/man3)
--- 
-2.25.1
-
diff --git a/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0004-Makefile-fix-libxdp.pc-error.patch b/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0004-Makefile-fix-libxdp.pc-error.patch
deleted file mode 100644
index b1e15e5..0000000
--- a/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0004-Makefile-fix-libxdp.pc-error.patch
+++ /dev/null
@@ -1,34 +0,0 @@
-From 46b3ff797135574aa0ee42f633a281d44f48da95 Mon Sep 17 00:00:00 2001
-From: Naveen Saini <naveen.kumar.saini@intel.com>
-Date: Mon, 17 Oct 2022 16:05:15 +0800
-Subject: [PATCH 4/4] Makefile: fix libxdp.pc error
-
-Error:
-do_populate_sysroot: QA Issue: libxdp.pc failed sanity test (tmpdir) in
-path ... xdp-tools/1.2.8-r0/sysroot-destdir/usr/lib/pkgconfig [pkgconfig]
-
-Upstream-Status: Inappropriate
-
-Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
----
- lib/libxdp/Makefile | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/lib/libxdp/Makefile b/lib/libxdp/Makefile
-index 9a340a3..bc39177 100644
---- a/lib/libxdp/Makefile
-+++ b/lib/libxdp/Makefile
-@@ -76,8 +76,8 @@ $(OBJDIR)/libxdp.so.$(LIBXDP_VERSION): $(SHARED_OBJS)
- 		      $^ $(LDFLAGS) $(LDLIBS) -o $@
- 
- $(OBJDIR)/libxdp.pc:
--	$(Q)sed -e "s|@PREFIX@|$(PREFIX)|" \
--			-e "s|@LIBDIR@|$(LIBDIR)|" \
-+	$(Q)sed -e "s|@PREFIX@|$(prefix)|" \
-+			-e "s|@LIBDIR@|$(libdir)|" \
- 			-e "s|@VERSION@|$(TOOLS_VERSION)|" \
- 			< libxdp.pc.template > $@
- 
--- 
-2.25.1
-
diff --git a/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools_1.2.10.bb b/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools_1.2.10.bb
deleted file mode 100644
index 4a06124..0000000
--- a/dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools_1.2.10.bb
+++ /dev/null
@@ -1,36 +0,0 @@
-SUMMARY = "Utilities and example programs for use with XDP"
-HOMEPAGE = "https://github.com/xdp-project/xdp-tools"
-LICENSE = "GPL-2.0-or-later & LGPL-2.1-or-later & BSD-2-Clause"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=9ee53f8d06bbdb4c11b1557ecc4f8cd5 \
-                    file://LICENSES/GPL-2.0;md5=994331978b428511800bfbd17eea3001 \
-                    file://LICENSES/LGPL-2.1;md5=b370887980db5dd40659b50909238dbd \
-                    file://LICENSES/BSD-2-Clause;md5=5d6306d1b08f8df623178dfd81880927"
-
-DEPENDS += " libbpf clang-native zlib elfutils libpcap"
-
-SRC_URI = "git://github.com/xdp-project/xdp-tools.git;branch=v1.2;protocol=https \
-            file://0001-configure-skip-toolchain-checks.patch \
-            file://0002-Makefile-It-does-not-detect-libbpf-header-from-sysro.patch \
-            file://0003-Makefile-fix-KeyError-failure.patch \
-            file://0004-Makefile-fix-libxdp.pc-error.patch \
-          "
-
-SRCREV = "57a139f9bf6ef644f9c1deb4f7df4bb4c76d6179"
-
-
-inherit pkgconfig
-
-EXTRA_OEMAKE += "PREFIX=${D}${prefix} LIBDIR=${D}${libdir} BUILD_STATIC_ONLY=1 PRODUCTION=1"
-
-CFLAGS += "-fPIC"
-
-export STAGING_INCDIR
-
-do_install () {
-    oe_runmake install
-
-    # Remove object files *.o
-    rm -rf ${D}/${libdir}/bpf
-}
-
-RDEPENDS:${PN} += "bash"

