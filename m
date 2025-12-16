Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E52D5C0C0
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 02:15:31 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12148.1765851326842537532
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Dec 2025 18:15:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=SqI79eEm;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=KoDrxFzv;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFGisU91823828
	for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 02:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=z0eR9Mgf6qqxmFpx2pJQzGReJjrqsj/rnod
	0/sVYRtY=; b=SqI79eEm9tLqA324JuwVsuEG0bXntNBju0tfSGrFK6vfb6Wry/O
	D2T77w2qYFIR3UXj+kTDUQIx42IRkhHtbAkO0iqjFv8brgaA/qJwnQB767by11Ii
	H9Mn8uZIDGv5+o/WzBklY8PhYJlphA6KgC/8+R+iX+id2gQ41WVzN+Ox6W6VEPLM
	I5HEB68S1uyrciuec5P6lnQN80GiARheBHSkN2N7rgSR2VvIsEN/40FmHyGa8vpl
	pyYaI3NqTOJK7zrvmLsn09EX3yqxzcQP5LpP5Uh5czzcexz/NSGvvRRfH613wkok
	zdHgsMlQ8mIp9Byrq2+zUvs+0WAZ6Lzd7KQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2p4f1htp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 02:15:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0a0bad5dfso49487005ad.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 18:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765851325; x=1766456125; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0eR9Mgf6qqxmFpx2pJQzGReJjrqsj/rnod0/sVYRtY=;
        b=KoDrxFzvyLTF2xLfTYzKaapoWHsOgt0H3el4M7FAlhJHW4OkKmThKOIDsfkds+2ep6
         irgZ1YEkxFCMUYtWl1sxp8bFqcdN5uE+Jy/OciuwPAVMhWJHAW8xPc5AyK+x8USIA92k
         GzMuEk/mqBlnFMaUXu5BmG+RLGa4eXhh0jdazz4oL0IhlOxnMYJCyC9RgaDfjZUxWHXX
         JuXmB48wL+nNCPwczIqIKRVwqJz6AJOw4ayU9DNYRIwPDnqr3+GxihnCm9M50zvg3D/Y
         0XAOGKdOxwU0skNTShqxSpHSyCNhwbmxi8MGZasZjNomAe9w46Dnn1a74W+G1SYwkmlY
         aiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765851325; x=1766456125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0eR9Mgf6qqxmFpx2pJQzGReJjrqsj/rnod0/sVYRtY=;
        b=JI0sRaueYskljGTQaHgAHu1RhHvwKzUgvguUBSQCijm3anpZpiL57blWxIVvNB2xu/
         rWxFEOHT2XdHxSimavb2JY1/wmJ7EojlvQ/4a1xeAoVpPcPYjRTE8plywIfrGkSWBR2a
         3agaE2aPhp7IUl3FYXABw6QFgUscd3rTzVrYslfqfBmp0yN4Uamo1SlazNKmXanv10cl
         2Uq0Bsr5+ZDgsiSa6Ctm9edWxTZZAheUXlXu1itfo4qpejUKsJRqYlp5KXEBqVgc+e3s
         9UTdSOjszNwVaCuSohAVFhjM6wkwPqoz21UooK5pzrlUvoxxrTZl+XUp/BnZwFru3Esg
         F/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVif9lsZOge+045YmpPqFphCI59L94MyKyr80h6K7YMnjBEwidf1fdCeykbN2CGSuXCIB0iilTCy6qGnWeH@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzbAxLykXm3/R7Up3uzVaMYywDP2mvZevC4N/J0OlCcRTBd+gND
	w6t1wSXfkqlKLlfYzSsDtME/zC8yHLTX7Iht+Ac6wLP2qnRFAfWq2Uf5060hVpRtriA4JcRoAHB
	JEDDb/NoC2g8O9XJR+bJPfcLegJl1VceiJ6zXEbfA+VK0lV0DZTIhbhH8Lz65Pk9R1CfHmkxFF8
	VvvqOtAs9wZO38
X-Gm-Gg: AY/fxX4ZkSOBzE2ajGtYY+8WgwTNV72JbRwbjdWd+2y6NmasVdnDwMxCqgy13oRuo7E
	7YmahvXa+e+3G6TQ3VkozzVdLWsucypFb4S2wDZSI7BFFnLwmtLGkJN0gdxdPh7Qt6VmX1ZnG3j
	XN5BtXkqiB6/lW4hy69+ms481nrBKndpTJRdaVVpt+bfjtAyBnnK62PQVSix5yBBoWVF+2Dszab
	grekkIclLxBGwQGxO0Ia3m4ErkaVSK5uLT28tgx9F9Qf0ibII9RRDqizR/SnQdlDkADAi5iJUL9
	G5m/3vXr+g/BsBl4Mags7/VnbCdyoVNPNqWwtQ6Dd9OcbrTPQ0K11t7GA2zzA+tTWKmMXtDSHY2
	l+aZ2TnlwixvY5RPaMKfYAzlDR2LQ97B3pHA5RoAN
X-Received: by 2002:a17:903:46c7:b0:2a0:8966:7c9a with SMTP id d9443c01a7336-2a0896681ecmr94719655ad.58.1765851324576;
        Mon, 15 Dec 2025 18:15:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJYx8juV1E6Akd4XVQiWESjzr9o3rPB9Y1Iej90c1DXPTM4/dANeWtrB5r7vwFGt3LeFXG7w==
X-Received: by 2002:a17:903:46c7:b0:2a0:8966:7c9a with SMTP id d9443c01a7336-2a0896681ecmr94719415ad.58.1765851323954;
        Mon, 15 Dec 2025 18:15:23 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38c74sm147641925ad.31.2025.12.15.18.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 18:15:23 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: meta-intel@lists.yoctoproject.org, yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH] README: change mailing list for patch contribution
Date: Tue, 16 Dec 2025 07:45:16 +0530
Message-ID: <20251216021516.2600042-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AJgpZIuKwhEOza0qhVqzkGOBO0D6JRw7
X-Authority-Analysis: v=2.4 cv=OK8qHCaB c=1 sm=1 tr=0 ts=6940c0bd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=iGHA9ds3AAAA:8 a=QyXUC8HyAAAA:8 a=Eos-kMoa0IYxNzJ9UkQA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: AJgpZIuKwhEOza0qhVqzkGOBO0D6JRw7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDAxNyBTYWx0ZWRfX2EH/GGWd1SWh
 HHwlU6ibRPr72+5BoPblYg9GPZ4fnco4jgzLA9u6jlRTpk6yVUZgZUc8qWMtAlCjkfcUOsrFU6n
 YdIFBDKzifh9Eg8BbVa+/ZpRLqhEcnFs1hHXMickG6qke5T+QJrn0ZRcIDIEFniqKTWryHWhI0g
 FryXay8g3NPcv2O+QVSUV8OfRhdIa+2tVYGyJKL7WUPVXzG0czF6agwOkf7+bmNj0F+KCX86K/l
 jJoJtdzXFdbMKboHZSdZKhsQxUZR/WdRt6t6tfgTyu069RWpJkYxdyRBE2Ek7qG7ow0EbhpvzKu
 eq7vYnM9u8MRioQeJhq5800nXBD36GN6/7GI+WP2NSOxhRz2fRBA3ipQIVwsF+a+aDaa0/mScP5
 57vna3iJPOAMYR2pCL6GZZV/rKxtBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160017
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 02:15:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2792

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

yocto-patches is a more appropriate list for meta-dpdk since this is not
Intel specific.

Also, include my new email address.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 README | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 81703cf..2901214 100644
--- a/README
+++ b/README
@@ -20,8 +20,8 @@ This layer depends on:
 Guidelines for submitting patches
 ====================================
 
-Please submit any patches against meta-dpdk to the meta-intel
-mailing list (meta-intel@lists.yoctoproject.org). Also, if your patches are
+Please submit any patches against meta-dpdk to the yocto-patches
+mailing list (yocto-patches@lists.yoctoproject.org). Also, if your patches are
 available via a public git repository, please also include a URL to
 the repo and branch containing your patches as that makes it easier
 for maintainers to grab and test your patches.
@@ -69,4 +69,4 @@ a patch or patchset within 24 hours of the time it was posted.  For
 larger and/or more involved patches and patchsets, the review process
 may take longer.
 
-Maintainer: Anuj Mittal <anuj.mittal@intel.com>
+Maintainer: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
-- 
2.52.0


