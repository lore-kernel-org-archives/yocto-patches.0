Return-Path: <patel.rajkumar@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFD1CD8CAA
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 10:38:23 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.76639.1781001501387752544
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jun 2026 03:38:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=D70QfVv6;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=RPOtmMgx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: patel.rajkumar@oss.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599vDZ01868510
	for <yocto-patches@lists.yoctoproject.org>; Tue, 9 Jun 2026 10:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=n1ZoJwOvLsjLywuLiso2ZuYDbUtZkBfuc6y
	9yxD9V9E=; b=D70QfVv6jwoRnCeJKSNjyURGTK5GY/y+1N/fU46dGklbkfBy7R0
	vG15Hw+R0aVNfFueZpuoHcTjczVuMb/XOax0gZUaSVQibmYNFhkb759oVGR7F2R8
	jZdXlXwZac8MrCwIP2oG0V5NJpgfIYkzJmbhth3jRpMIAdiX7Na3K56dbIG02Klc
	1lGFMJGIOsV4LnAjZp1QhO3mJlIG3G4OzOLi8Ms3h8+uo19E2jfiPP1cBmjpRtrq
	ACOafo/e/Dxan0WeuG4h1hMyemMMInQ6EiX444X/m0OHj74gBfvVtDj6z3Gpo0SU
	uYVPOfsr4WBuKP5VbQqXlvcrzHfZHYpA8Tg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wg9jd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 10:38:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c858e0cbca3so2839030a12.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781001500; x=1781606300; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1ZoJwOvLsjLywuLiso2ZuYDbUtZkBfuc6y9yxD9V9E=;
        b=RPOtmMgxKcedOiWL/8EXL1uvlOioSsWGd60BPTaC9/iSPGSOxCjCOynsuE9i16uPrt
         CW2Zl3hcs9wBWT2igd2vbEp+3a4tHdHtFtF6ro95RSykau7hALWJ3PK0GWoPMtT4qjk8
         NAu9iCDHoAI0a1zENlibN3iYj4nxfvOHIbqidoqn95javhkHX0ddmsBXWOG9Xr8hMBQU
         pp73eqYuliQpuOTf1Fzaoi1+ub5BHJ+R1qf99tjEjQMGitDyaY0Tmyj8A1zyZt+scsVx
         SzoQHXNB6fUxcgghveBo0WURBCXaBoG105Y1iG2u7rSoFvfknXz55Xq/KVIAJQUWy5J8
         +XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781001500; x=1781606300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1ZoJwOvLsjLywuLiso2ZuYDbUtZkBfuc6y9yxD9V9E=;
        b=rfVcLDoS7ePTXBFaH9FfZZWNH82x2dsEHrfPLm0kRUhqJnCKXtencGw74IgAxoAPyn
         heb7blsTJ05xq/U2UFyKJVjE1pXGhn3w+DRXBDK09CHIdAwyiFnjPCn/Q8c1Fs39YQvy
         ZuOmD6Wp7KZoKKtfLhqwVbV+Vuzdg4H4ARyaGsc7avRm3J37SIEbV0wriKfm6R04u9tq
         riXdjMrWH/M6UJaaSTZNI29VT0WYzXAZzklYiYtYfW7GLAFVgTyFmDpl4ejcQ4g3ybdE
         zRCcvd0Br0Wl2J5CC07oYO/S+1KffD3ipzFxvJiR/azsXpSsTGipImM2DhuTKWHNeb75
         tOQQ==
X-Gm-Message-State: AOJu0YzXhTOFei2WaEC7MaLRnQTwQbZWunp0pRDOfoevl8qISI9I5YJz
	4bmz07Uup6fSiaJVMX6cfb+Y9wZ5bE40OqgUFeVs/Sy7+TALa8PwqWtDIIEpijYfRrjuIQYz7oq
	fe96BhcdH1bjFKJqbNTSA0caP2pIw2LGdhswjQXiOcs5da12o5Di4NysnXMKpPLva6qwKzP/uss
	4nnruuXTkZsbnE
X-Gm-Gg: Acq92OHYdREmN1UkA9kZJzfj8NufzbZqO8w+B/U2nx5z9G51tJgbJsD87uUawZKX5jK
	4wvhkbqf98nVGMqzRK2RBj0gwiL7gmPCz0PN1S6G0veu4/HALKmZgmjem0bZV2OgLharO+U9QQ3
	REaqRPZEA3Gh4EO09NR5mdpRaEEZu7lR4Pcf7L89UlEKFYS9Q/rzb6/dJOesXmqidZc5rUBBj7m
	v4AJU78AGWmLK3AyNlochLxQJre4zj5pSSQwtsPJMZuxNLWMSXIwlivHIZW+AlpTlww6cDEjJtI
	ZnfnJmiHHvEUw4tKr1UcrTXPLxiVCjLbvsASR8wt8nkKq9iVzJX9IjTrMmq8Wpne4jCpKg2mPh2
	1twm0R7WY8/8rUdvzzbdm2gLau7/r32oIe3nsjSHGFk/sCGW3ig4i
X-Received: by 2002:a05:6a21:3cc2:b0:38d:fad1:cf2a with SMTP id adf61e73a8af0-3b4ccd65aebmr21521722637.13.1781001499637;
        Tue, 09 Jun 2026 03:38:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:3cc2:b0:38d:fad1:cf2a with SMTP id adf61e73a8af0-3b4ccd65aebmr21521686637.13.1781001498968;
        Tue, 09 Jun 2026 03:38:18 -0700 (PDT)
Received: from hu-rajkpate-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df03387asm19455395a12.4.2026.06.09.03.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:38:18 -0700 (PDT)
From: Rajkumar Patel <patel.rajkumar@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: anuj.mittal@oss.qualcomm.com,
        Rajkumar Patel <patel.rajkumar@oss.qualcomm.com>
Subject: [meta-dpdk][PATCH] xdp-tools: Move out of dynamic-layers and upgrade to v1.6.3
Date: Tue,  9 Jun 2026 16:07:55 +0530
Message-Id: <20260609103755.1955622-1-patel.rajkumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEwMCBTYWx0ZWRfX/tadKCLhQYyJ
 vyyV1mAXMmRWo486A4oakMaGZtOXhzlAKLSe2jpGcHzVUqahX9yt9ExHxKTbrtWH4hDtvPD5Cof
 bAcqT3dysKwE9PduMyK4UbTblKIH6yI5cR8grQ9MauiBUTkb9l/16apTJs0kUdYXhXL/Ra50kJI
 A0ZOwdDaZxvP3g/VhWJxnIjMxAZ08OvwZY+FqJM0TUbNg41HEViIacLqHyGa9ht1ZgUrWz6p6Bs
 hiGefHshdHJSaB/VUH2P9lbt0sRo4rDzkDFk7dVaKhL9LlyKCMYj2xumpiLWIEvVij+1FKDZxvv
 VPYTC/ktRFiAj3feWNHgO4r78NanYFEo5o8O+9XF3WGubeUDuucoM9vihty1/2SKIzDEuBw9PhH
 deuaf8lXmmNVtv5wtIkktEgnSQoBmyPeUDYSLSyVBhfPOsZaWbeO0xfm1MUcahjz5Riy0TLAmK3
 12eaXpU7AobX9LTR5Ww==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a27ed1c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=9ZdZAmFfhINEWCGy:21 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=hX9f41WZAt5pQm368A0A:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: OiCfNkTeS0pP88L6LB9IM38CJ-pJTM4N
X-Proofpoint-ORIG-GUID: OiCfNkTeS0pP88L6LB9IM38CJ-pJTM4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090100
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 10:38:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4185

clang-native is provided by oe-core and is available in any standard
Yocto build without requiring meta-clang. Gating xdp-tools behind
the clang-layer dynamic-layer mechanism therefore serves no purpose.

Move the recipe from dynamic-layers/clang-layer/ to recipes-support/
so it is always available when meta-dpdk is in the build. Remove the
BBFILES_DYNAMIC clang-layer entry from layer.conf accordingly.

Upgrade from v1.2.10 to v1.6.3 and drop two patches that are no
longer needed with the newer version.

Signed-off-by: Rajkumar Patel <patel.rajkumar@oss.qualcomm.com>
---
 conf/layer.conf                               |  5 ---
 ...0001-configure-skip-toolchain-checks.patch | 44 ------------------
 ...-not-detect-libbpf-header-from-sysro.patch | 44 ------------------
 .../0003-Makefile-fix-KeyError-failure.patch  | 31 -------------
 .../0004-Makefile-fix-libxdp.pc-error.patch   | 34 --------------
 .../xdp-tools/xdp-tools_1.2.10.bb             | 36 ---------------
 ...tly-handle-CC-when-validating-requir.patch | 45 +++++++++++++++++++
 ...ile-use-cp-fRd-to-preserve-symlinks-.patch | 36 +++++++++++++++
 recipes-support/xdp-tools/xdp-tools_1.6.3.bb  | 44 ++++++++++++++++++
 9 files changed, 125 insertions(+), 194 deletions(-)
 delete mode 100644 dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0001-configure-skip-toolchain-checks.patch
 delete mode 100644 dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0002-Makefile-It-does-not-detect-libbpf-header-from-sysro.patch
 delete mode 100644 dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0003-Makefile-fix-KeyError-failure.patch
 delete mode 100644 dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools/0004-Makefile-fix-libxdp.pc-error.patch
 delete mode 100644 dynamic-layers/clang-layer/recipes-support/xdp-tools/xdp-tools_1.2.10.bb
 create mode 100644 recipes-support/xdp-tools/files/0001-configure-correctly-handle-CC-when-validating-requir.patch
 create mode 100644 recipes-support/xdp-tools/files/0002-lib-libxdp-Makefile-use-cp-fRd-to-preserve-symlinks-.patch
 create mode 100644 recipes-support/xdp-tools/xdp-tools_1.6.3.bb

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
diff --git a/recipes-support/xdp-tools/files/0001-configure-correctly-handle-CC-when-validating-requir.patch b/recipes-support/xdp-tools/files/0001-configure-correctly-handle-CC-when-validating-requir.patch
new file mode 100644
index 0000000..1102566
--- /dev/null
+++ b/recipes-support/xdp-tools/files/0001-configure-correctly-handle-CC-when-validating-requir.patch
@@ -0,0 +1,45 @@
+From 2a6d219ec2f5413e38ec502421cce8a2c6d7f054 Mon Sep 17 00:00:00 2001
+From: Rajkumar Patel <patel.rajkumar@oss.qualcomm.com>
+Date: Tue, 9 Jun 2026 11:22:13 +0530
+Subject: [PATCH 1/2] configure: correctly handle CC when validating required
+ tools
+
+The tool validation loop checks the availability of required
+binaries using `command -v`. However, when CC is defined with
+additional flags (e.g. "aarch64-linux-gnu-gcc -O2 -pipe"),
+the check fails because `command -v` expects only the binary
+name.
+
+Extract the actual compiler executable from CC by taking the
+first word and include it in the validation list.
+
+This ensures tool detection works correctly in cross-compilation
+environments where CC commonly includes compiler flags.
+
+Additionally, quote variable expansions to avoid issues with
+word splitting and empty values.
+
+Upstream-Status: Pending
+
+Signed-off-by: Rajkumar Patel <patel.rajkumar@oss.qualcomm.com>
+---
+ configure | 6 ++++--
+ 1 file changed, 4 insertions(+), 2 deletions(-)
+
+diff --git a/configure b/configure
+index d57b2ae..a234f80 100755
+--- a/configure
++++ b/configure
+@@ -70,8 +70,10 @@ check_toolchain()
+ 
+     CLANG=$(find_tool clang "$CLANG")
+ 
+-    for TOOL in $PKG_CONFIG $CC $OBJCOPY $CLANG $M4 $READELF; do
+-        if [ ! $(command -v ${TOOL} 2>/dev/null) ]; then
++    CC_TOOL=$(echo "$CC" | awk '{print $1}')
++
++    for TOOL in $PKG_CONFIG "$CC_TOOL" $OBJCOPY $CLANG $M4 $READELF; do
++        if [ ! $(command -v "${TOOL}" 2>/dev/null) ]; then
+             echo "*** ERROR: Cannot find tool ${TOOL}" ;
+             exit 1;
+         fi;
diff --git a/recipes-support/xdp-tools/files/0002-lib-libxdp-Makefile-use-cp-fRd-to-preserve-symlinks-.patch b/recipes-support/xdp-tools/files/0002-lib-libxdp-Makefile-use-cp-fRd-to-preserve-symlinks-.patch
new file mode 100644
index 0000000..bc860ad
--- /dev/null
+++ b/recipes-support/xdp-tools/files/0002-lib-libxdp-Makefile-use-cp-fRd-to-preserve-symlinks-.patch
@@ -0,0 +1,36 @@
+From 064ccdaf0d84bea86f9cd17383581c3844a33151 Mon Sep 17 00:00:00 2001
+From: Rajkumar Patel <patel.rajkumar@oss.qualcomm.com>
+Date: Tue, 9 Jun 2026 11:24:51 +0530
+Subject: [PATCH 2/2] lib/libxdp/Makefile: use cp -fRd to preserve symlinks
+ without metadata
+
+cp -fpR preserves ownership and timestamps from the build host,
+which breaks cross-compilation and packaging QA checks.
+
+The `-p` flag is unnecessary for symlink handling. Replace it
+with `-d` to explicitly preserve symlinks without carrying over
+file metadata.
+
+Switch to cp -fRd to maintain symlink structure while avoiding
+host contamination.
+
+Upstream-Status: Pending
+
+Signed-off-by: Rajkumar Patel <patel.rajkumar@oss.qualcomm.com>
+---
+ lib/libxdp/Makefile | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/lib/libxdp/Makefile b/lib/libxdp/Makefile
+index 7ea7e7e..3c36b70 100644
+--- a/lib/libxdp/Makefile
++++ b/lib/libxdp/Makefile
+@@ -56,7 +56,7 @@ install: all
+ 	$(Q)install -d -m 0755 $(DESTDIR)$(BPF_OBJECT_DIR)
+ 	$(Q)install -m 0644 $(LIB_HEADERS) $(DESTDIR)$(HDRDIR)/
+ 	$(Q)install -m 0644 $(PC_FILE) $(DESTDIR)$(LIBDIR)/pkgconfig/
+-	$(Q)cp -fpR $(SHARED_LIBS) $(STATIC_LIBS) $(DESTDIR)$(LIBDIR)
++	$(Q)cp -fdR $(SHARED_LIBS) $(STATIC_LIBS) $(DESTDIR)$(LIBDIR)
+ 	$(Q)install -m 0644 $(XDP_OBJS) $(DESTDIR)$(BPF_OBJECT_DIR)
+ 	$(if $(MAN_FILES),$(Q)install -m 0755 -d $(DESTDIR)$(MANDIR)/man3)
+ 	$(if $(MAN_FILES),$(Q)install -m 0644 $(MAN_FILES) $(DESTDIR)$(MANDIR)/man3)
diff --git a/recipes-support/xdp-tools/xdp-tools_1.6.3.bb b/recipes-support/xdp-tools/xdp-tools_1.6.3.bb
new file mode 100644
index 0000000..3f3a615
--- /dev/null
+++ b/recipes-support/xdp-tools/xdp-tools_1.6.3.bb
@@ -0,0 +1,44 @@
+SUMMARY = "Utilities and library for managing XDP/eBPF programs"
+
+DESCRIPTION = "xdp-tools provides libxdp and command-line utilities for working \
+with XDP eBPF programs in Linux, including tools for loading programs, packet \
+processing, monitoring, traffic generation, and benchmarking."
+
+HOMEPAGE = "https://github.com/xdp-project/xdp-tools"
+LICENSE = "GPL-2.0-only & GPL-2.0-or-later & LGPL-2.1-only & BSD-2-Clause"
+LIC_FILES_CHKSUM = " \
+    file://LICENSE;md5=9ee53f8d06bbdb4c11b1557ecc4f8cd5 \
+    file://LICENSES/GPL-2.0;md5=994331978b428511800bfbd17eea3001 \
+    file://LICENSES/LGPL-2.1;md5=b370887980db5dd40659b50909238dbd \
+    file://LICENSES/BSD-2-Clause;md5=5d6306d1b08f8df623178dfd81880927 \
+"
+SRC_URI = " \
+    git://github.com/xdp-project/xdp-tools.git;tag=v${PV};nobranch=1;protocol=https \
+    file://0001-configure-correctly-handle-CC-when-validating-requir.patch \
+    file://0002-lib-libxdp-Makefile-use-cp-fRd-to-preserve-symlinks-.patch \
+"
+SRCREV = "8fbad9f0af621a22aa87ff2520b3735915b1f0fd"
+
+DEPENDS += " \
+    libbpf \
+    clang-native \
+    zlib \
+    elfutils \
+    libpcap \
+"
+
+inherit pkgconfig
+
+EXTRA_OEMAKE += " \
+    PREFIX=${prefix} \
+    LIBDIR=${libdir} \
+    PRODUCTION=1 \
+    BPF_CFLAGS='-D__${TARGET_ARCH}__ -I${S}/headers -I${STAGING_INCDIR} -ffile-prefix-map=${S}=${TARGET_DBGSRC_DIR} -ffile-prefix-map=${STAGING_DIR_HOST}=' \
+"
+
+do_install () {
+    oe_runmake DESTDIR=${D} install
+}
+
+FILES:${PN} += "${libdir}/bpf ${libdir}/bpf/*"
+RDEPENDS:${PN} += "bash"

