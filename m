Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10739.1795491231180459819
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Nov 2026 19:33:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=RWCR0Jk5;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: nirameka@qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2kkEx3738514;
	Tue, 24 Nov 2026 03:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9P6lWQu2UdZRFCvoErkUInilWsqLB+sQAjJ
	H7a1wies=; b=RWCR0Jk5LeMcjTlW73OiR2C3enL4xLGUKxk66GDlGFXuxraDFTX
	g90YyG1gfUhlWmjKJMr3cYcq7mTC9pkC9x/xDPSxG4QxPZGLq1wTUEGT5gpNtfwI
	NJzyjRYMJAHLPjFuiIxE6ocrUk78BvVzW2teQU7cAhNUt+ZmNWIFig/27qGa0i4I
	ZwpfaPQc+hP8uVfpqeokaxSEUtfkQB6Q1R1lHbYZlYwFWDnD/l8IQi/ivkBtNZSs
	Z5jmgbtnv2h/2ecLcmo1rTx7N0Q2hrJw1tAav+i5L6537iCK7TYmQaEQgsmfsPUh
	TAiTdTANSassCq3UiCRaDDu2+C4IJtRq2ig==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7uuk0s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 03:33:49 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO3XmxO3755095;
	Tue, 24 Nov 2026 03:33:48 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-nirameka-lv.qualcomm.com [10.81.87.106])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AO3Xmru3755089
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 03:33:48 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4849491)
	id B986922202; Mon, 23 Nov 2026 19:33:47 -0800 (PST)
From: Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com,
        Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>
Subject: [meta-security][PATCH 0/2] swtpm: upgrade to 0.10.2 and backport sysusers/tmpfiles support
Date: Mon, 23 Nov 2026 19:33:40 -0800
Message-ID: <20261124033342.3126460-1-nirameka@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: ukuPnDLQbZpdndHmCKnYBOeYGsJSNyI5
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b05059d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=uxKpXQ1AqjNjovMwOLwA:9
X-Proofpoint-GUID: ukuPnDLQbZpdndHmCKnYBOeYGsJSNyI5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAxMyBTYWx0ZWRfX2fd2xGEJK3Gt
 QESNelGcLnoHxE0htJuaNzuWCXogwljZyrowSBy9JYdwL+W/XPPzVvjV4QS5Oq5I5f5GJt1r9YS
 cbNVFtt5CXtHy4hEJrXgPLm0Nz34308=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAxMyBTYWx0ZWRfX7laSZT24FuLC
 ZXn/zcuCl7vMT4asFNR10TWJIU+/kbigurgsU5+EsRugKXL7hr/wzaA/yP97Lss5yPRsst55EPT
 tAIrsCsZNNbLEEuc2Lo79qm1f3Ty9zDyobH9DCERELaL2xl50hsHhgdXWKUk0Lu8dlGjgigxw9E
 1SVOL49gserNwRGEyckBnWhjcbEEq2ZP1/E0zw3iBr1AGKGh1NtaBH+/6Id0inmEO/XTL0JZ3wt
 GX6rjGDa8uhU4y+E0/Es+4xCmL4STvECzaA9xTl3zytb7cYHv+8lS13QOe+/cXfGXiT11iRrEx7
 vRUGoEIBVOOq4YOxlF/+DHtcPVOW0JdVcZUz6fK3lbsjUKZOJtHST626r42cyCimx6XBNaH4osT
 y3v0AYQoLgbWp5X4X443x0drJEFPwlv5d7FKuwMl8VfgYx8CHwCWh382FZo4QUtKPHpjyrcvDNd
 OeT4L6HswSD1dbENGlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240013
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 03:34:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5497
Content-Type: text/plain; charset="utf-8"

Hi,

This series updates swtpm from 0.10.0 to 0.10.2 and backports the
upstream sysusers.d and tmpfiles.d integration.

The sysusers/tmpfiles changes provide declarative provisioning of the
tss user and /var/lib/swtpm-localca. The follow-up upstream change is
also included to keep the tss sysusers definition consistent with
tpm2-tss and avoid conflicting definitions.

Patch 1 updates the recipe to swtpm 0.10.2.

Patch 2 backports the two upstream swtpm changes and packages the
generated sysusers.d and tmpfiles.d configuration.

The separate swtpm SELinux policy-build issue is not addressed by this
series and is being investigated separately.

Regards,
Niranjan Reddy Mekala

Niranjan Reddy Mekala (2):
  swtpm: upgrade 0.10.0 -> 0.10.2
  swtpm: backport sysusers and tmpfiles support

 ...ll-sysusers.d-and-tmpfiles.d-configs.patch | 86 +++++++++++++++++++
 ...2-swtpm-sync-sysuser.d-with-tpm2-tss.patch | 29 +++++++
 .../{swtpm_0.10.0.bb => swtpm_0.10.2.bb}      | 11 ++-
 3 files changed, 124 insertions(+), 2 deletions(-)
 create mode 100644 meta-tpm/recipes-tpm/swtpm/swtpm/0001-swtpm-install-sysusers.d-and-tmpfiles.d-configs.patch
 create mode 100644 meta-tpm/recipes-tpm/swtpm/swtpm/0002-swtpm-sync-sysuser.d-with-tpm2-tss.patch
 rename meta-tpm/recipes-tpm/swtpm/{swtpm_0.10.0.bb => swtpm_0.10.2.bb} (84%)

-- 
2.43.0

