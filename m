Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3618FCDE000
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 13:33:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11394.1782394393764249967
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jun 2026 06:33:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=lPV9shiq;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=aLPKiS8c;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P9jw821371493
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 13:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IVezbkkd4aCbjVTHdiKGf/w3jx97EdDb3nl
	Q6KHQVsA=; b=lPV9shiq9cOI/Eq6tW+a3+gYXXgqDv47RH1mSXr+MgjFnTA9UTw
	mW5LlgZmN1qWdOaBMalMQD3kz0FceqJbgDngdCw7DCg0xSsajbWyKUeltzP5Lmbo
	vIzIdiEIRQuG7hBtIm6VdlHBXF/WKuq/Mkee+u/ixpKaYya3F+LDzuUrp1+CA5us
	FJDWNvcilTFsCGR/ldaYiGYPX/gakf5c6snUk+K/1UdxrZE7pz3ErbWv0QgwAc0a
	F6VPOPGnNM0f8goTzR0vz3bNLtr4w0K1nwHMJEuOl1ylc7hnZRWVwtfmYmqgKfDY
	idB0Wx+oV1nmKrUMmQyfSmtJBPL+rANEwyQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ymv1dg8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 13:33:12 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-967973f71fcso390868241.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 06:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782394392; x=1782999192; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVezbkkd4aCbjVTHdiKGf/w3jx97EdDb3nlQ6KHQVsA=;
        b=aLPKiS8c2sNZ0dftIvgpmaXB5Nw6dQxydlfoy3rBoPbMcptvWTyNcbGn+Y++DyNvnE
         FL17TRsxBiIGX/JsMrl6qiKyopoWa71xUYnuY6Y87PYrsJvwQSBkxyGOe6ZDGgM+RWzQ
         HDnRlDeWDTkfhbd/JdXNX64fGo/aPxq3dp4HIPjAUJjUqg7OP97kNfMqEaOpcON/GB3B
         6z4ZIjOiQdjP8iTW3fIRmW56Zh8ZZHLGg0OJ0oeEvaZxWYamEzEas4RGj3/M4Wc9Osbb
         vbfoZa8ezFtq38D5RAv/T2YmRiH+Zp3JldYtIdC1HUa5wy/6mbCs01B0xFuYvP44lwLE
         7f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394392; x=1782999192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVezbkkd4aCbjVTHdiKGf/w3jx97EdDb3nlQ6KHQVsA=;
        b=Pm0f/9Wk23zWNtloiBH2OGlH0ofk5zt/13Z2ZHHKSOnrQH4fqaloJsPXayd/TDWGQf
         B7/+udnzfZ5TUAqbz6jXAnkLBLmSHEig/JZAAJA419Jn7MpDgoZt2NR9s0T6NuDO+3ck
         RnxGHVe8ZKilhVmFaTMeBeehVHCp164R+qnxgh8UjvAhGFOpaSqlkfmiNObCiqz1KOhZ
         VhL0fI60Mm33SHeNtErQ7rZL7bFC6hEnBVEAWRu+Vld5s/doi4Ro0rEC7cp1EsZJs5N8
         a4IRWn/zqJIBHvB9ylX//2S0PCNNmeULgBSKeatpyFkat7FHH5+PeWEhJbWN8aseE4UR
         wrFA==
X-Gm-Message-State: AOJu0YygyM3zBOJSaljxkjXYUra9w0PCgQi8MULYWe/H/1Df0XxR6O2K
	Rovyiqj3pIxsg1M12G9o/MOJ6aVS7ezt5ZUie3VDVwEefx2MKokjmSTEgx9mKlKsbFIv9QXfSlV
	Mb33PcC8WuM0twQrNbNdTRL8kfHAcO8qBI4SBWPHP+VAK4HF1zF7DnLf+UbX4AhVNNsG/IVjZ/R
	n2bJi4shaBJA==
X-Gm-Gg: AfdE7ckL3w/fIf/cidzB6PEA8c/PPMSpTT2OraLNU2EeDnhueExtH488+o7oV31cna2
	49ECKZNR9esR82LX8nhlNV9bN+yH4UwM6gV1gGYGA4ZldY0fxAbTF6Zx/ZqcaJiO7GM3U4cYaKJ
	eMrBscW7utkspTpyuKT6WDX6xhv+1ao+PwHs9QCf1rgjs2CgFqT9Jw1HkKFERZR2NSy66kyONbn
	9a3MUupXXpXoc+mtKYtL6HDIVRW/qY+nkE36fKbEUuND0AXNwmH2RDs0IMHRTuDTSxft2nG+0Zp
	wXxWeLQhbbCUrRIpBgur91NnyGPJhRWBaGdEbpqF4YYqCC16fCyHbWEEXTcvWdsqD2Zhfox5U5i
	OxZf3G/QyTIRWPR9GwOxnkTtXWQ==
X-Received: by 2002:a05:6102:80a5:b0:634:92df:4dc3 with SMTP id ada2fe7eead31-73435b8a421mr1013919137.16.1782394391868;
        Thu, 25 Jun 2026 06:33:11 -0700 (PDT)
X-Received: by 2002:a05:6102:80a5:b0:634:92df:4dc3 with SMTP id ada2fe7eead31-73435b8a421mr1013871137.16.1782394391393;
        Thu, 25 Jun 2026 06:33:11 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee0189esm16654089f8f.9.2026.06.25.06.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:33:10 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH] drop LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE and use just DEFAULT_PREFERENCE
Date: Thu, 25 Jun 2026 14:32:43 +0100
Message-ID: <20260625133243.1429423-1-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DqBmPm/+ c=1 sm=1 tr=0 ts=6a3d2e18 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Q4-j1AaZAAAA:8 a=EUspDBNiAAAA:8 a=G1oKHJAYstgRPzgkFcMA:9
 a=TD8TdBvy0hsOASGTdmB-:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDExNiBTYWx0ZWRfXxE7K2AtdfH3n
 YW5CwZ2Hu7PQAZcFrtKfFoHieaUOZgePUbAhWDzndWfr4SH+6BDA8QehmycxfE5dKpShUUt2+Pe
 FRxRadd216VH+aRFUOHK7iyHKzyYHV4=
X-Proofpoint-ORIG-GUID: T0isgIqG79_e-V5B2CGecDvbugfAv57b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDExNiBTYWx0ZWRfX47wtWGovfQFb
 kPujjSuDMH5jkmKDOb4CzG1HmpmJXP8wofjm1MmJTfb+UkmVbemdoXBeiDK0Cs6WuyqvtUkRzzH
 xgvrsQj1yfKyfNdC+zrwZmbEYigyTskeG2ptWKek0bvvYhP896NVtapE0GVTymj1qingtfrAldc
 B1DmH4fnSGfxYy+oYYR0Hbsgkkz+BoL9ksRjP+RwU8THguSWVFjHN7bst0U0hA6OqCJof7035IX
 BXr2M7jQJJhGUj4Vw+DRE6ATKZ5YzdWjkyqDfBrDn8gCTBjzYiwJcHCvEFiSP//zIcWsZQwhlR/
 YO/No6SXngGekJxWSAktWEZcWodx7Pf1gHEGXizi6LlVYDqBocBa/2x8sGbHHBOaOpmOOQ53Z41
 Y/2cmviq5VWT1pCGi2nrg+wOa1J3MOiLTGohKYo3JNu7NFnru1h8k/lIQQ++kA0/U7gDThOGSb7
 6t2OshCizU9sOIJ16QQ==
X-Proofpoint-GUID: T0isgIqG79_e-V5B2CGecDvbugfAv57b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250116
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 13:33:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4303

This change reverts 7d003ac, 2145371 and 6b8dd8b. The idea with the variable
LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE was to make it simpler to choose
the version using only one variable, but it ends up being a new variable,
so nobody knows it.

We can do the same using only the DEFAULT_PREFERENCE that already exists
and whose use is known.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 README.md                                                | 8 ++++----
 conf/layer.conf                                          | 3 ---
 recipes-kernel/linux-firmware/linux-firmware_20260519.bb | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/README.md b/README.md
index deeca33..ef6f019 100644
--- a/README.md
+++ b/README.md
@@ -10,12 +10,12 @@ linux-firmware recipe from the master branch of openembedded-core.
 
 In order to make this layer Yocto Project Compatible, the layer should not provide
 new versions of packages by default. Because of this, the recipe provided in this
-layer will not be used unless the LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
-variable is modified. The default value is:
+layer will not be used unless that is explicitly stated. To use the provided
+linux-firmware recipe, the following can be done:
 
 ```
-# DEFAULT_PREFERENCE for linux-firmware provided by the layer
-LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE ?= "-1"
+# please use 'DEFAULT_PREFERENCE:your_override = ""' to keep Yocto Project Compatible
+echo 'DEFAULT_PREFERENCE = ""' >> recipes-kernel/linux-firmware/linux-firmware_%.bbappend
 ```
 
 Dependencies
diff --git a/conf/layer.conf b/conf/layer.conf
index 59b9e0c..5e1f7f2 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,6 +17,3 @@ LAYERDEPENDS_lts-linux-firmware-mixin = " \
 
 # https://git.openembedded.org/openembedded-core/commit/?id=2b75c7ba5e3aa6fc57d7b4afe59e2277b4d87de1
 firmwaredir = "${nonarch_base_libdir}/firmware"
-
-# DEFAULT_PREFERENCE for linux-firmware provided by the layer
-LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE ?= "-1"
diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb b/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
index 50df8e9..f2cd873 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
@@ -3694,4 +3694,4 @@ INSANE_SKIP:${PN} = "already-stripped"
 SYSROOT_DIRS_IGNORE += "${firmwaredir}"
 
 # Don't prefer it by default
-DEFAULT_PREFERENCE = "${LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE}"
+DEFAULT_PREFERENCE = "-1"
-- 
2.54.0


