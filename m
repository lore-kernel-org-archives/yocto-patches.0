Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A4D5E146
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 12:43:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21699.1765889025460464998
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Dec 2025 04:43:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=GhqeNRiA;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=QUq831JC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG85CdD2869694
	for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 12:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=APgrHgJVGI46d4Tu/73NJYzX5dyY1Qfw2P8
	PHZ1tllg=; b=GhqeNRiAi4/ga6etl97NNhHacqZyjwwDxgq2645t3BZ+igS+1ik
	njzH5zYPM8d5dSqQSkbbcM6QC8AAdE9TAPQEacfEqe7Amu9/QoAzkrWvNcqFCJZy
	EGl3wgFypIKkZ7yNN5+aiKLHSG0uLO3A/v97CQOfj6m/VDnZsgHRrRAR9251dN2a
	0GClpqRijofP1i8fugz5KAr/VDQFCuKJHvj8KhwWZWLIihOfS+q+fSVDbpp827JT
	3rHBmCk0ev9uILMBZ4ue5NO529D0B+lwESM42lrJgpPKa30W5mqGgw1hViovW/vy
	Wh+PrmjNy0kHPwBfVRSgQF1KpupLDwDqK7A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b33kw93x9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 12:43:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0dabc192eso46468875ad.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 04:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765889023; x=1766493823; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=APgrHgJVGI46d4Tu/73NJYzX5dyY1Qfw2P8PHZ1tllg=;
        b=QUq831JC1Bdv2W6qmyDqhQbXnpzuyTHSmORd9T3QvDEjKfWVRADkbeqnrmTrgJSAQc
         Iqbelh9Rp7y1WEEvI4Y45fcXRe27gPDtkCUPRIobVg2FY1NaBLhvWKEbZ5lHjxmjF0hq
         71t33WFtr/Uyf7TiXJpBrIXTkkRZxfz6qpmvCtIu3FfmmTJ4GnGYH8pa4N5r6LlLjQ9s
         MXYLWDS/lBKRMCGIziOGo12ldtdMsXC9FLcfWk/wntflvmmteZqZsgFAHy8uZak/U3dh
         3sDFRTUavvpzsyQB8quM4yF2QHrdfszlo88EYTlQB4IBl9sAcr5LQZ34i7dKUbrYJFq6
         UWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765889023; x=1766493823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APgrHgJVGI46d4Tu/73NJYzX5dyY1Qfw2P8PHZ1tllg=;
        b=Xtjg6PDZnO9Da0nprcPKC9ppbhh8nLW3BYonyINqsmBh8tZItWk8VfDrPH9n6x7RNk
         nLzvkrABtGMZBlJT53FcVIdWdecQb/o0+4nqSNlnbvXL1H1658OvpZrDb8r9i1/PtH3J
         5yAfuRnW+Y7ZM6f7xpPPTYMb1CBmUqDx3p9hKrY2g/8Dy0hIUCNBexFmJ9Qh/1Akxyrn
         tRPQn/olVDaiYRWWt9RWFsXEyVGpBHO5fTCSuPf8VYoHCp/wr+8+qvhZ4D63kYA//Mss
         xqdtiSejzjUT8qhTzauhB9KTQ4tjCy5sxNhDiEIbljdlYhN0qpPQcZsM3yTP3N75mOa1
         U0Gw==
X-Gm-Message-State: AOJu0YxxJSHKKQ3aQQ5frY1SL3XTL/J2zTAiQ7JtDVMWivc0YAYOTFOo
	QR7s4x0PM8JulQP7ix/QfSSiTcfCkk30DpanH7u37LRh5QnkV6QMA1N8ft8weE5ymVzwi4jAMi3
	jzQe2zQMeNInaKX8vsn1sb6Usa4+DTuT1KO38gp/61m133+uuD9/kDQTSfw1RmRjr/ehKz9uuP6
	gbSYzVA7NOyJgg
X-Gm-Gg: AY/fxX5/u4wWsEs1TwUrxWAXSVE7G9TFWW10qkYpD9b/HSA4e4ITo5RPbaOaq0016b7
	SVxIjwjHQIZXucUHom09u1Vg4hSDfzt2KmxfMPsT9CxG4ODhXDUq0dJCyvE8LMszpaBtRUPGUyI
	QlAzlIvA6+cCN8AMlkoY/mjwJW/yCVNoHp0WKb3QqzcpMOYcuTTSlgMjJAfruakYlZpUnRyFRpS
	0ESrqo/fLsLJkbbR7bTqaAzNHEIIW8lo1wBqtjdYcQWTxtYayz5NK8qWr0mTU73xDCD/H452fQM
	zD0Av84aYl3myIFukSCt/8E0kuycSUQv6YUPprz7rafnglpas5kHRH7dLp8VgBn7t4iFGMAjE0R
	bXLXA0HbKz8+mpah8e2Hb0weq5hO7/yLOtP5i4br2
X-Received: by 2002:a17:902:d506:b0:2a1:3cd9:a739 with SMTP id d9443c01a7336-2a13cd9a830mr17129565ad.43.1765889023297;
        Tue, 16 Dec 2025 04:43:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkygfybsVrsPnwEZQi/8M1bZMZPGe7Aq1oW1t3YQQFS8Zh6m4qDmjx4TflVJ8pqikTL11KuA==
X-Received: by 2002:a17:902:d506:b0:2a1:3cd9:a739 with SMTP id d9443c01a7336-2a13cd9a830mr17129295ad.43.1765889022666;
        Tue, 16 Dec 2025 04:43:42 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a12b82c587sm31179495ad.69.2025.12.16.04.43.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:43:42 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v2] config.py: add meta-qcom to layers to be built
Date: Tue, 16 Dec 2025 18:13:36 +0530
Message-ID: <20251216124336.2902015-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TLpIilla c=1 sm=1 tr=0 ts=69415400 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_SgBnD-hmtMEeoryxtYA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: QrPF_NgOyoPs1SQIShRodAE_4NT-rGHK
X-Proofpoint-ORIG-GUID: QrPF_NgOyoPs1SQIShRodAE_4NT-rGHK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwNiBTYWx0ZWRfX8ulw2C8zTMak
 zBqw20Fl2NR2bm0CsuvEK30P9NhStrfkoVAgBKOgPWWPtCipPC5atx0ZWjQj/+CtuQfXO9YsSOG
 kwSYRKNFhpYQEY3EJY5h+CpL+lmljib0zf7sDcSygRxNraXNm2zf2U52T1tNE34dj9BNcTZEvI1
 EPcYgaJ9k/SQjiOJTP+YYkDdLVEgMYb+tqxR7HsgM9CEbttKhN5z9w/JpJkWJ8FFw0gNbSnRdFz
 8z4n/DMqkPEucUjipbCefrK5A2yHxOITvNJwGODVk6tZcjAuXIc2dSNnkop3rBJn7lCw1H6NdOi
 2/oO4sobamspbPtc8OJEqsEn0+164HS7uRw1/nLIpZ6bq7s5kGhu7v66DtGxEISVFUHQszTvhlL
 1PjA/Y8C+11dnt4E/HuWjiIweF20ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1031 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160106
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 12:43:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2801

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Add builder for Qualcomm BSP layer meta-qcom that can be individually
triggered.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 config.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 2408602..2b4d7bc 100644
--- a/config.py
+++ b/config.py
@@ -18,6 +18,7 @@ buildertorepos = {
     "meta-arm": baserepos + ["meta-arm"],
     "meta-agl-core": baserepos + ["meta-agl"],
     "meta-aws": baserepos + ["meta-aws", "meta-openembedded"],
+    "meta-qcom": baserepos + ["meta-qcom"],
     "meta-clang": baserepos + ["meta-clang"],
     "buildtools-docs": baserepos + ["meta-openembedded"],
     "qemuarm-oecore": ["oecore", "bitbake"],
@@ -147,7 +148,8 @@ builders_others = [
     "edgerouter", "edgerouter-alt",
     "oe-selftest-ubuntu", "oe-selftest-centos", "oe-selftest-opensuse",
     "non-gpl3",
-    "meta-webosose"
+    "meta-webosose",
+    "meta-qcom"
 ] + old_arch_full + riscv
 
 subbuilders = list(set(trigger_builders_wait_quick + trigger_builders_wait_full + trigger_builders_wait_perf + builders_others))
@@ -283,6 +285,7 @@ builder_tags = {
     "meta-aws": ["layers"],
     "meta-agl-core": ["layers"],
     "meta-virt": ["layers"],
+    "meta-qcom": ["layers"],
 
     "musl-qemux86": ["musl"],
     "musl-qemux86-64": ["musl"],
-- 
2.52.0


