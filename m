Return-Path: <mohd.anwar@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516A9FF512E
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 16:51:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.86305.1775580701438162254
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Apr 2026 09:51:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=aEri7vtc;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=HSYsRtHF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: mohd.anwar@oss.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CPjcB2009319
	for <yocto-patches@lists.yoctoproject.org>; Tue, 7 Apr 2026 16:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ruFb65AT6DAEhsK8liKSdRpxm0amgARFo8s
	4r7Uycio=; b=aEri7vtcCn9962gfuFruyu6+OvrwiRHQFknkXIFfb0EP2mk5qS0
	u/hMiClZLJEk6EAXTUoBOwjwPzWKwt3E9sM/uPTQYPC/a4HdP552/2S9TD/37+My
	BwHpGByZlQrVn6edtjtqLN6uzILCS1bIRuvYat3vA2q8YgyGygGfivoInVw+sWdV
	baHOBTRqJ/4tz1iC1NUef5UAnGUIDsQJVdIlrMrYRspWeshJq/h9RCF3plxbDLR5
	gFEclOauAwebH6totkFu9FeqjIqpfNdIzYGz99xhChj0kX71dMCGmiL+pPQ7OEtg
	4cw35kaNZRQ+e0AkCbZP5uadQvGq9uzPTVw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrruq33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 16:51:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35d98c6ab60so50531a91.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775580699; x=1776185499; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruFb65AT6DAEhsK8liKSdRpxm0amgARFo8s4r7Uycio=;
        b=HSYsRtHFUAMiMKDYO0zbCwiTFE/63xT6V3rQbqfjPor/URswr7UfxjKuutb7UnhZpm
         lXCx5aH2dNFjcRbi3mY2IcyRAkz5AEFU+fz4cWJWkFEXl7xIQK6l9Kb8sNBmKTRdu780
         S/+ZLoTQbO4enfWoXQEmL52kd4RMAf6cVnUKJ2U6aTtZdir9lPR2Y7LMen4RdtX6+Xci
         2gJuYLJXzyd14slCChjGHIVFpf0dq6Kzsi4C0QDT37gd51kwaePawYWBG69Y+YdA80uC
         ILPswlp7ZNgRmSWh5K7VnA3RGywKjfaYbaRFoVC+0P20adWh2kreePViJslLKqnsB0A3
         VhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580699; x=1776185499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruFb65AT6DAEhsK8liKSdRpxm0amgARFo8s4r7Uycio=;
        b=Yfg0WeqJcRF/QlB8goYeHcnIOeu8GEcljOJXmQjIcJ4uxD2/53gAHjWM5nUHs/jUT5
         X8ZwbRViW/7Pl2toaGD5t+5XvpfigvN9upe5f4xknFCaTBTk7DIMTup6YuUR07XQU2on
         nqTLVRFEldrnJENlxoCO/ZITFZI8CgtMdrySGZKhA3QbI/SjCOvGzh7n7fLUpYTOjVeq
         vN8MCrSIYZed+6bJzecMVRmPZrVUhe+O3/X82HVtjOovDHFpZ+ipgiID4DnzGzh1PmNa
         D9JAITur4wzewtlW47xR3JKyuhsJwd/HQ0+bFtypQ9Fy0lb3KWrGYcoKWK7LAXeW5bHQ
         VRZA==
X-Gm-Message-State: AOJu0YwDiQ/zrIBY6V5tUXeFNL8ELfA7fkHniphftzDcaXyYRYhdkhlF
	v2/kSdPgctooJkLNNP5KovEM/HetzFwHPLD2Zu2/AzuSI+dpg8RatgQW9L+c5MTUMzPTWP0tBjf
	JEnQ9230mPiQ/voi6CdYUk9nW8DoLhA6A7sOuyUtv/YC7XUgKjLxNPd+AC5CxJLOhHyvSDE5jHI
	yZHYSYeLnIBVTg
X-Gm-Gg: AeBDiet2PEyb91WmRYoDcxAWHs+wNMlAyw8AMF1rxFyomUtCcNLc6lYDthc20lZNqJ/
	RXEgOGpmF5Ix4Rwa8N8fJkX3BAM0EeAMxr993gxdYUPG1PWvsT0YF7jDz0pg8ueu3Zlb2RASvhW
	9mF8kcy/Ys7KY/eXNE0lBrvb8ZpNSW+ZNooshnNnhIQe07vKtIiYQySQfySc/VwzkoIW7Xk+/dW
	0mGU4SWOUSOalfWBJyNXn1msJN6Ae9gtKWY99IOAz/xlgPeLzH7FiAMVbRdy0CKl2ssOPU7Xhnh
	yeaUvVvYiB5aWDAckH/Vdso62wIcpC1y3QjPjpCS/pIJg0Q/vLbAVuB471YZGJVJmfko7K0Tzof
	ImDPa8a1Wz5vym9vu5nBditpfpgZrGR12fiHCVYef4zvbAwlv3TQ=
X-Received: by 2002:a17:90b:3911:b0:35d:844a:d73a with SMTP id 98e67ed59e1d1-35dd689eda1mr18567616a91.16.1775580699036;
        Tue, 07 Apr 2026 09:51:39 -0700 (PDT)
X-Received: by 2002:a17:90b:3911:b0:35d:844a:d73a with SMTP id 98e67ed59e1d1-35dd689eda1mr18567587a91.16.1775580698560;
        Tue, 07 Apr 2026 09:51:38 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65812f4sm16387836a12.25.2026.04.07.09.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:51:38 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org, anuj.mittal@oss.qualcomm.com
Subject: [meta-dpdk][PATCH] dpdk: set platform to generic for cross-compilation
Date: Tue,  7 Apr 2026 22:21:35 +0530
Message-Id: <20260407165135.3581258-1-mohd.anwar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE1MiBTYWx0ZWRfXyNY4DK38vXv0
 F5BCWFXSOXkJrS8APuMYEzU8x62ZWFuGwu4BtxUrd1VB7HpMB7a1U0h//t5xU6KlJHSsB25YdQ/
 nloRm3yx0h2dJrjB2co6UfVd9U7UfkVSbUz9xmYiEdfM4DmymjvTiB01Rbhg0C8yNkhpmfn5bj3
 UkqcHzbdrcEC+qVYkr6hH9EpyawNZxQsdwpMqYzdEM5tyxO6XtGpfCsgJTvM9hiSb1qPaGSlC12
 +QYiUtPhfiIYMchxptgRD+rKmCyUiB3IYxvSnXIy/xERdVoZWC6fPngkD2bGzP1KOy5B0XfpJby
 KPbLP7jtm+iRDtm5Enc7gzOPpJpD2Gwp0bBWh3Iu40Y8++KDf5HPJs1c/R89bD8+vYMfAPkxQ2B
 qlsvEb54p7EvNiPG6q3f55/VY0GRgdQ1oOMij8ts007+9cbSsiV2xtpkefAxcktAzWyBsk3DD95
 U6dIsb5gaiF39dRjsSg==
X-Proofpoint-GUID: V4ox-GFOXMxrAigQSfEmnsp28n68h4bB
X-Proofpoint-ORIG-GUID: V4ox-GFOXMxrAigQSfEmnsp28n68h4bB
X-Authority-Analysis: v=2.4 cv=LquiDHdc c=1 sm=1 tr=0 ts=69d5361c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VYLz_M7VvY7jhimh6TUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070152
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 16:51:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3654

Meson resolves the platform property from the build host during
cross-compilation. Generate a meson cross-file that sets platform
to 'generic' and pass it to meson for class-target builds.

Suggested-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 recipes-extended/dpdk/dpdk_25.11.0.bb | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/recipes-extended/dpdk/dpdk_25.11.0.bb b/recipes-extended/dpdk/dpdk_25.11.0.bb
index 58fc441..b56d77e 100644
--- a/recipes-extended/dpdk/dpdk_25.11.0.bb
+++ b/recipes-extended/dpdk/dpdk_25.11.0.bb
@@ -16,6 +16,7 @@ def get_cpu_instruction_set(bb, d):
         return "core2"
 
 EXTRA_OEMESON = " -Dexamples=all -Dcpu_instruction_set=${@get_cpu_instruction_set(bb, d)} "
+EXTRA_OEMESON:append:class-target = " --cross-file ${WORKDIR}/dpdk.cross"
 
 COMPATIBLE_MACHINE = "null"
 COMPATIBLE_HOST:libc-musl:class-target = "null"
@@ -33,6 +34,15 @@ inherit meson pkgconfig
 
 INSTALL_PATH = "${prefix}/share/dpdk"
 
+RTE_PLATFORM ?= "generic"
+
+do_write_config:append() {
+    cat >${WORKDIR}/dpdk.cross <<EOF
+[properties]
+platform = '${RTE_PLATFORM}'
+EOF
+}
+
 do_install:append(){
     # remove  source files
     rm -rf ${D}/${INSTALL_PATH}/examples/*
-- 
2.34.1


