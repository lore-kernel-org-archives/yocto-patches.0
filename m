Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13811.1794582863791493000
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 07:14:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=KIyU9KvQ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5777f9e512=hpranav.nayak@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADDbAe92896799;
	Fri, 13 Nov 2026 07:14:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Wov7Oa5+D
	9KBiKjEfZsGRF68Mgz4Pz4MaIG+rsYJxV8=; b=KIyU9KvQvxqZrJ6vmK0YWvPde
	TuDih+BZP1+XkO3I1oK83Nx62BtVZQxnsTSsk4VSfftRIIlejx/8gYG47p6HZkHX
	dIC7vC+kOOhg3LHSIgU3EZToBXbv4ppXL7R7VhFqmWqJsXfN+UTtxNrQ+pbNX+vQ
	g8TZO9+qNAU9p58hbQBOFE3DnBeV3Fj6mvBSMTJZoycBrR0nlOb/s72RV+6u6PMs
	0tMIE7HpYq5SEp8OWE6aoLwpq6GL/gdnBHvoejwusLmocxz/QljHe9TK2ZdO5jt9
	9R/yYjFJAYZkzG/dlpPfVF8c/U0Fp53zkOYp/QKVIO00Tlh6ix/8OhT1JHkCQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4hx3kg85rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 07:14:22 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.61; Fri, 13 Nov 2026 07:14:21 -0800
Received: from oak-lpgbuild07.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 13 Nov 2026 07:14:21 -0800
From: H Pranav Nayak <hpranav.nayak@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <jpewhacker@gmail.com>
Subject: [meta-mingw] [PATCH] zlib: Update version to match core
Date: Fri, 13 Nov 2026 15:14:10 +0000
Message-ID: <20261113151410.2058188-1-hpranav.nayak@windriver.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2MCBTYWx0ZWRfX28tEf9IH1uEM
 sWXA98GiuOPQiCWaOCPxjTobsmkYUnqjXQJuRVDrE589LO1rOriA3k8YadO6zdbj1MnSKLP88bh
 rITzxcT+EZHa5eaNjmj/URn2oaclC3o8Gvinp4dR+ZrdFxs81MS5
X-Proofpoint-ORIG-GUID: zgdLMFsyFQweleQ6jGMpMjUrVO2mMGWh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2MCBTYWx0ZWRfX6ysVfuph2BDM
 7AbFZNUVXyt0J2wwoQlilv3w11faUHX6MI9yNGr2ys0Js8KjGljJen/9TBHd6NDSRp1DiL2vZb4
 AP/IcHcy8/nRXR71Sh1Kzq5XhKfVA2j+zH3HUZTvoLkk79iOdMg1dOJ9Y59oRiDy4moqwfP40W1
 qp6iZFjib8Uzw22VYxguBvVR2nvdsD8uGOgM9c5lrjHvdB6UhdiIW955UltX0CCtFVYbCamwRGo
 gwnzXLZ7F1BD51jqyw676wW4WE4aywcL16ArhnzWmZL5TMPpgxrmNjLqGbgjfmCqf7HISC6UMC5
 Nr5CAcsySAz4kpbzNiwBLnSdsiJN/EudkqoonyLpl9q0bATGDcXGNVWpbz6safZt4pY2yIgSJQY
 AZPM+ccav3gQifxFxVEirDk801AJURS3x4MlKtFSHzLDQyNDoFeQz0+03yvLPSR5/C96utsbjr0
 n/6gLKkMgG66/7oQQIg==
X-Proofpoint-GUID: zgdLMFsyFQweleQ6jGMpMjUrVO2mMGWh
X-Authority-Analysis: v=2.4 cv=d55gWhjE c=1 sm=1 tr=0 ts=6af7294e cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8 a=hOZQkUyAdtYLH-zM4WMA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130060
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 15:14:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5337
Content-Type: text/plain; charset="utf-8"

Signed-off-by: H Pranav Nayak <hpranav.nayak@windriver.com>
---
 recipes-core/zlib/{zlib_1.3%.bbappend => zlib_1.4%.bbappend} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-core/zlib/{zlib_1.3%.bbappend => zlib_1.4%.bbappend} (100%)

diff --git a/recipes-core/zlib/zlib_1.3%.bbappend b/recipes-core/zlib/zlib_1.4%.bbappend
similarity index 100%
rename from recipes-core/zlib/zlib_1.3%.bbappend
rename to recipes-core/zlib/zlib_1.4%.bbappend
-- 
2.54.0

