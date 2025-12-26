Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27327E7AD7F
	for <webhook@archiver.kernel.org>; Fri, 26 Dec 2025 03:14:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.147664.1766718841401425860
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Dec 2025 19:14:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=JGSgrvTg;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=crhyhcPK;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BPNHPvB3814214
	for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Dec 2025 03:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yNo6lQlBKROLa5oQFeISRNGbuLf8ekrtpFP
	n9mHE02k=; b=JGSgrvTgh0kY938H1LK5mQbPjv72hZU27migK+cyGLwHjNTQwUV
	quwvYTO5Bg2eepgkoz5nUPaJIE3fyaTjSq3J9z7HeTG0Cvsdye8Xq+/jRA+kZix0
	xxhXKUmYxH8wm5xR+5j8dyZ0YmILwPdTUUJA3xZwV/gQFX8G3abFtYbkErJZ6fIR
	/jkTkOYpZIMru+/QYDWET3Vaho/fcW71cKTVYO1QmPj3n1x7c1n6MGtNSVeW3gbV
	wah6HpbrxloukJa9hoqMmFS971IZbwKzdmpMS0br3DaV89pe609zps/EDtnsVnSZ
	I7dEvLHcUvPKy7o8/FHuX/RLrYdmdGJ1SHg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b8p492gnf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Dec 2025 03:14:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f2381ea85so148954705ad.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Dec 2025 19:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766718839; x=1767323639; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNo6lQlBKROLa5oQFeISRNGbuLf8ekrtpFPn9mHE02k=;
        b=crhyhcPKp8a3CXQM6vkPA+IyqGpzsZx2OANPg+UoUu44OzRWGL8J6P5QB84OE/affQ
         aG3o5jl1zOvWZjfJoSfwMMvXmALs+XUqngKPFGmEJ1rlgpM41c+cQ/voUmnnowCPJc0V
         b2qi3WH+evfpiv8o1R3gf2I9FDLw11MiPHfl/1w5k2Cfr6MmrUKk2qzxjN2lp83j1P78
         0eA6NcNb2VFmmqe5Qi842lMGLFYGMcLlo8cOGjgOxzBWmWn9R5NdaWQFo/YUnHAcwief
         JCsM0WHH+SySX+0no6TLr59+b807kB2tvQc97HpK90iKD8HO6MxWPMkB3k4Yc4zS3TJH
         XQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766718839; x=1767323639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNo6lQlBKROLa5oQFeISRNGbuLf8ekrtpFPn9mHE02k=;
        b=l1MxCrcHK49FL6Vh0tRz3Go3vsjaj7xnozNa71WlK0BlJblta6uXEDz9D5dQNh+XZE
         ZpKvZ3JJSk+e7YKjYlXvnrTvU9Ht4oTFcZdN0Ho22bDITP/g4kgvvZgmif87J/Hy6NhP
         zV26LkiOjT6FosIbNLrkvQm2iT+IPZ24dWNDU4FM9d5UlgeV8px33eC6MBIiSr/D46cr
         C7towb1Sz1n4rWw438PVuxjElP7LPD7j31tuJKSwUC8qRaor/4K2urTMnAemrSTKSr/A
         QMxFThqAwqmO/vpbVKm/lLKbgSqd9yqA7rTDBjamAkVeYqdsF2TM6rSEGntVh7mZ5JEG
         uPkA==
X-Gm-Message-State: AOJu0Yy20EZ6vti63l8glZ3ePfSMNuYY/uh28zpQ4jOoKs5BtuB2YrGW
	8Udhc5w/s7IaAgjmSdVqdP1gZMlXVyGAlOh58XfmM4+u+JAJEjXIGsldeAPzXgdwbIXfxbo29hS
	lsb0ualex7tdz/GX27CMRAnfU7I+SsQIYYsNQ9XoEcv4ZRtO/vQIjQwjtSkLeNRY36CANsZlhlR
	w8tR0AiQ3D+Ep1
X-Gm-Gg: AY/fxX5fdhOGJFkz4DaztcDDkfhbVLm4cguIOrTfD0NNpWDRYDin9VoA+B5DeuR4kSb
	CNtgLs3QZi4NDcpsu1L7ybzEU9jCx377N5yM286F0KqfOfHeaQY4waYM48efGArOPDGzMFE5KG4
	8xivFW6AIc+EiOl+5ZgF+iC7EgYP8ALn42OwjhX9xd7dCc6m6aaDuCoq5mMlJ3zEj2hNAe8lazI
	P7csdbB/1oLKKGF6QY4yXMrsVvBpy+NburD5uW+J9vt4RucI7AwnkaVnifgW6n749B//gD9rY+Y
	emMi/isgXI8slZ5Vnskz0/1fvuFCuvllsWiAluA70PEEl2O5vSexTCi4Dd5TWtmkovJC2oz1UWz
	gYI7yTR+B80Wt3tUru2+OWohORun/DKGQxo4Sy9bN
X-Received: by 2002:a17:902:cf08:b0:2a0:f488:24e with SMTP id d9443c01a7336-2a2f2836817mr229191005ad.28.1766718839153;
        Thu, 25 Dec 2025 19:13:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpqJmNvpcgNufYolowLV4/jrjth1XRjx2B6wdK+kubuLZIi9paTnwZaBb0PyLP1pA1cFatfw==
X-Received: by 2002:a17:902:cf08:b0:2a0:f488:24e with SMTP id d9443c01a7336-2a2f2836817mr229190735ad.28.1766718838248;
        Thu, 25 Dec 2025 19:13:58 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77451sm193383085ad.96.2025.12.25.19.13.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 19:13:58 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [scarthgap][meta-dpdk][PATCH 1/2] dpdk: upgrade 23.11.1 -> 23.11.5
Date: Fri, 26 Dec 2025 08:43:50 +0530
Message-ID: <20251226031351.1828500-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6ibfok3oYXDI8u4R6K62pxdWNbTW8aoU
X-Authority-Analysis: v=2.4 cv=esbSD4pX c=1 sm=1 tr=0 ts=694dfd78 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=EUspDBNiAAAA:8 a=4YC7WVefAAAA:8 a=20KFwNOVAAAA:8
 a=t7CeM3EgAAAA:8 a=q3AWaYmuoOZe9QpbpcQA:9 a=1OuFwYUASf3TG4hYMiVC:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=tPzOKt3quolVTVSLigK1:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI2MDAyOCBTYWx0ZWRfX60gMXNv5S1Bm
 kh2n1huMWh4IFgbdSRg4tXi5UVThF+HuGpdSjsMpkm3TwMNnqrbUR/VtYvszfH6OhM/9qJW1GhZ
 jPDtxASKLU33zuj4gv0KetrspetBFd9KVBO96rwppfINAwScRqdL9P928wikEjxX+R/ISOEjCnJ
 ZSXNsYTO1Ka6q5Z1sQ9dJoZWjoeYTjZrMjyGepau6oMK1mw3kUIy0azLKghHLaH7JIMISQ25YRG
 1Yh2FpDhCvJFboWxj5e3uaWtledwpCsnvfyiyw4gg/GdwvNUWspcECTqgBqBVm4cADpUgGye+HF
 4oickLrFOEJYmeOJ0oPpDPFFyH1aRj2WVJxl7jnn2gkBwHkP6FWNBSq2Ct3t7fR+DuuV1ewtybU
 Y/U90D8r18nAxmiHB1uYjC9xxnHcG+5KVBnRk6dNXWbkaLyfdKYeMIsv8Qt3Yhn7LflmKaG8IGt
 PGVOjhJ54BP7+d3oQ2g==
X-Proofpoint-GUID: 6ibfok3oYXDI8u4R6K62pxdWNbTW8aoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-26_01,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512260028
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Dec 2025 03:14:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2873

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Upgrade to latest available minor version for 23.11 LTS.

Drop the CVE fix that is already merged.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 .../dpdk/dpdk/CVE-2024-11614.patch            | 44 -------------------
 .../dpdk/{dpdk_23.11.1.bb => dpdk_23.11.5.bb} |  3 +-
 2 files changed, 1 insertion(+), 46 deletions(-)
 delete mode 100644 recipes-extended/dpdk/dpdk/CVE-2024-11614.patch
 rename recipes-extended/dpdk/{dpdk_23.11.1.bb => dpdk_23.11.5.bb} (94%)

diff --git a/recipes-extended/dpdk/dpdk/CVE-2024-11614.patch b/recipes-extended/dpdk/dpdk/CVE-2024-11614.patch
deleted file mode 100644
index 1cf5507..0000000
--- a/recipes-extended/dpdk/dpdk/CVE-2024-11614.patch
+++ /dev/null
@@ -1,44 +0,0 @@
-From 4dc4e33ffa108e945fc8a1e2bbc7819791faa61e Mon Sep 17 00:00:00 2001
-From: Olivier Matz <olivier.matz@6wind.com>
-Date: Thu, 28 Nov 2024 12:09:56 +0100
-Subject: [PATCH] net/virtio: fix Rx checksum calculation
-
-If hdr->csum_start is larger than packet length, the len argument passed
-to rte_raw_cksum_mbuf() overflows and causes a segmentation fault.
-
-Ignore checksum computation in this case.
-
-CVE-2024-11614
-
-Fixes: ca7036b4af3a ("vhost: fix offload flags in Rx path")
-
-Signed-off-by: Maxime Gouin <maxime.gouin@6wind.com>
-Signed-off-by: Olivier Matz <olivier.matz@6wind.com>
-Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
-
-CVE: CVE-2024-11614
-
-Upstream-Status: Backport [https://git.dpdk.org/dpdk/commit/?id=4dc4e33ffa108e945fc8a1e2bbc7819791faa61e]
-
-Signed-off-by: Divya Chellam <divya.chellam@windriver.com>
----
- lib/vhost/virtio_net.c | 3 +++
- 1 file changed, 3 insertions(+)
-
-diff --git a/lib/vhost/virtio_net.c b/lib/vhost/virtio_net.c
-index 895a79cf51..058b5842f2 100644
---- a/lib/vhost/virtio_net.c
-+++ b/lib/vhost/virtio_net.c
-@@ -2831,6 +2831,9 @@ vhost_dequeue_offload(struct virtio_net *dev, struct virtio_net_hdr *hdr,
- 			 */
- 			uint16_t csum = 0, off;
- 
-+			if (hdr->csum_start >= rte_pktmbuf_pkt_len(m))
-+				return;
-+
- 			if (rte_raw_cksum_mbuf(m, hdr->csum_start,
- 					rte_pktmbuf_pkt_len(m) - hdr->csum_start, &csum) < 0)
- 				return;
--- 
-2.40.0
-
diff --git a/recipes-extended/dpdk/dpdk_23.11.1.bb b/recipes-extended/dpdk/dpdk_23.11.5.bb
similarity index 94%
rename from recipes-extended/dpdk/dpdk_23.11.1.bb
rename to recipes-extended/dpdk/dpdk_23.11.5.bb
index 4c6d234..50bab9a 100644
--- a/recipes-extended/dpdk/dpdk_23.11.1.bb
+++ b/recipes-extended/dpdk/dpdk_23.11.5.bb
@@ -1,12 +1,11 @@
 include dpdk.inc
 
 SRC_URI += " file://0001-config-meson-get-cpu_instruction_set-from-meson-opti.patch \
-             file://CVE-2024-11614.patch \
            "
 
 STABLE = "-stable"
 BRANCH = "23.11"
-SRCREV = "a6ec5765cf83d3d58cbd6d4ed5b92b4a06f8a808"
+SRCREV = "62f583c49bf67dd4d6733ece14e55fe6839e66d1"
 S = "${WORKDIR}/git"
 
 def get_cpu_instruction_set(bb, d):
-- 
2.52.0


