Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE87ACCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 14:00:08 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17741.1762869598800374921
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 05:59:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=oCFqk2hk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3410f2cc19=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABDPoAE1946358;
	Tue, 11 Nov 2025 13:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=SrWx2iVyNntmst/b15+b
	99P+Z2LVz5LuWICGYGqnCR0=; b=oCFqk2hkZfHsxrRw/2HlRYTAtbIfOeBA7rTV
	hY99ior+od7eCtAZRx9PzsMYMc1qOXdVwQeDrc7U2AKlx7ekKcPUMGYEQ+rgoyN3
	NxXJ1AGeRwzLerpfmnPbO8SyBJ3HsWjikbptFw7y+3WjsvAXHPOm2XPr+UVF0twU
	uKolXAohOEVlvh3K+ZvanfC/fekNN9Gd461HPKhMNQ+D5UuvswfMdbSRTsLE/1eC
	DtRcCwbAuaBbJD+tZKsBaiTt7hjaIs3DkY27RDDMB+o1nWkNaREOOvb0iv96KuBN
	4a0nq98lYKvh0G3yxt1BmJPj4ZCZg8HgGijahrGCtQkFSiV04Q==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a9u2x3dce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 13:59:54 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 11 Nov 2025 05:59:53 -0800
Received: from pek-hjia-d2.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 11 Nov 2025 05:59:52 -0800
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>,
        <richard.purdie@linuxfoundation.org>, <mark.hatle@amd.com>
Subject: [pseudo][PATCH 1/2] pseudo_ipc.h: make 8 byte alignment for structure pseudo_msg_t
Date: Tue, 11 Nov 2025 21:59:50 +0800
Message-ID: <20251111135951.2121065-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExMiBTYWx0ZWRfX2dvNqon9IFL5
 Hu/tgERMpfJxEp7XlHiKKvBd6rbH1w6FpWWDlS9IydDdtWQHAIcNdaA6zEmGAdqz48/PHd+vy8+
 /UMnksIbuJ3pjOWs6EYEdECF1aiFlE9FRXoVlVrbCoK2Bc2isG81mNCxoCMehEh6J7DAAIm8+82
 4zE9rGjSGeIzXuJdSH/+I+PvA3HyVBM+2bYzH+rvE7Pl9I2dOvgZLBimuHnmRSuztc8ylpsYV6j
 5bncL51bdAb6MUPLOhIXseS6cR/Vhbd6Rt8zNH88SLCsjfMIOBoQCYwRa2P8VtdkI8g8ofuuClx
 IIkv5NIqSzzBFy5+whbPw4SvAHHfYySXmsJdAhFclKRziuq5VJaPyeOR+7EKaE2iKmatUyZ/E9s
 26e1YsoiCwH0VQ8bdagJmRmZCOtU4w==
X-Proofpoint-GUID: qYjHGLiC8qXbrGAdSvVWDIuQSoyyzpfF
X-Authority-Analysis: v=2.4 cv=Uvpu9uwB c=1 sm=1 tr=0 ts=6913415b cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=c-VF-FKvAAAA:8 a=t7CeM3EgAAAA:8
 a=YF631qdcisYsBJbiT4wA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: qYjHGLiC8qXbrGAdSvVWDIuQSoyyzpfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110112
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 14:00:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2484

typedef struct {
    pseudo_msg_type_t type;
    ...
    char path[];
} pseudo_msg_t;

The [] item at the end of the struct is a C99 feature:
Flexible Array Members in a structure in C [1]. The size
of path in structure should be 0.

On 64-bit arch, sizeof(pseudo_msg_t) = 80, but PSEUDO_HEADER_SIZE =
offsetof(pseudo_msg_t, path) = 76, the reason is 8 byte alignment
in 64-bit arch.

The differ between sizeof(pseudo_msg_t) and PSEUDO_HEADER_SIZE
made memory overlab in memcpy, such as

  memcpy(oldmsg, msg, PSEUDO_HEADER_SIZE);
  memcpy(newmsg, old, sizeof(pseudo_msg_t) + old->pathlen);

Add 4 chars to structure as reserved for 8 byte alignment, then
PSEUDO_HEADER_SIZE = sizeof(pseudo_msg_t) = 80.

[1] https://www.geeksforgeeks.org/c/flexible-array-members-structure-c/

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 pseudo_ipc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pseudo_ipc.h b/pseudo_ipc.h
index d945257..2836cc4 100644
--- a/pseudo_ipc.h
+++ b/pseudo_ipc.h
@@ -26,6 +26,7 @@ typedef struct {
 	unsigned int pathlen;
 	int nlink;
 	int deleting;
+	char reserved[4];
 	char path[];
 } pseudo_msg_t;
 
-- 
2.34.1


