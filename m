Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10902.1795491234019934928
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Nov 2026 19:33:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Nxr/yQBx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: nirameka@qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2kPjM3851153;
	Tue, 24 Nov 2026 03:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wRC2Suap4Fq
	zkT6sxZY+D9umx37HG3TVnxU0uRxFg6Y=; b=Nxr/yQBxtiNhCEq345VZMm9RJbc
	8bsoEYtPq40dYeAadNf/Ve8ELXPrzYAMOkyRdiGmsFKnygBaTx0//oHi51QwjXpy
	wIOQIuyO0krpbXDj015wWhAWsQiByFwQYiH43LMtta9xeg5VA6aw2tJ78ouiVvsT
	YJapdA1VDy7KR/gnT6imU57CzNfaDnf8JLJQcJZFngxsmkpTZq3LHKUgabZXWltx
	9oCltO+4I2svPXn8S11QbB++5Q/POOFAuCtld8Wd2A0QKYLN5ZkasmvKldsZryBQ
	lNRnRzgt+fwnHCzR4U889yHtnm+/IGZ66GTpVjbKsvp5og2NVgnD/6L8sLw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvb0jr4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 03:33:52 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO3XmxP3755095;
	Tue, 24 Nov 2026 03:33:51 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-nirameka-lv.qualcomm.com [10.81.87.106])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AO3Xp5l3755117
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 03:33:51 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4849491)
	id D385122202; Mon, 23 Nov 2026 19:33:50 -0800 (PST)
From: Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com,
        Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>
Subject: [meta-security][PATCH 1/2] swtpm: upgrade 0.10.0 -> 0.10.2
Date: Mon, 23 Nov 2026 19:33:41 -0800
Message-ID: <20261124033342.3126460-2-nirameka@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124033342.3126460-1-nirameka@qti.qualcomm.com>
References: <20261124033342.3126460-1-nirameka@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6b0505a0 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=YntGecZepZ1ufEIDqaYA:9
X-Proofpoint-ORIG-GUID: M9DJwsQBZK3A8qmi1BIYOhf4DeyG1LmS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAxMyBTYWx0ZWRfX2akTgFL+3H2g
 IkMHIQbMiFYtxW3Q3dqoZpeuRreea6TGUTf/KEXfHQVBeKMAW5aTLaC6VKa6aX5P0kKQSoidK5c
 WlIY6vhvoTHtcctxUjTnkRotAP2PIZo=
X-Proofpoint-GUID: M9DJwsQBZK3A8qmi1BIYOhf4DeyG1LmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAxMyBTYWx0ZWRfX2tb+FwbBsGO1
 xV2Mjv8f3EEWX1wqy/e65W9iqsO9FMkUQ1h+YUW8kdcuSyzSB+XbLM8GiDfkgY0hbU75bFyyl8z
 sPMAfIli9TWexNLgLq8j+xWcZjgleFUHJMOttLPhIPJMcmZ5oUNOj9lFSkpe+px/J/hqet7HneG
 MnJEUvvduQ7gSs+eG9eoJIwxyhJ6RcOkfkUgLSz6Poo/7z19xMSk6MVfBf5bYqKxgWo+WoPAep7
 C/CbV6uF4AtY0VIR2VT+E+5OxlNWCtAWruPHzqlNxnHiwZNX5JHXlSrt/iNmT/F4oiCX7H0DLzo
 VVcQlRugRVCsC2br2MIdYLTfnsCN+xpbAl40Ht1Pq2JvWbUnjlQXV06wOrh9lUqnPsWr4O2atbT
 +pN7Mlj2gFcKyNeKZlvFO840QLOaL3ApdFtkMoOJTVocL2P62VUO5qxbct7Ay6xEcz93B+Zcy7P
 +NEUcp3OEJUgviuMnwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240013
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 03:34:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5498
Content-Type: text/plain; charset="utf-8"

Upgrade swtpm to the 0.10.2 release.

Signed-off-by: Niranjan Reddy Mekala <nirameka@qti.qualcomm.com>
---
 meta-tpm/recipes-tpm/swtpm/{swtpm_0.10.0.bb => swtpm_0.10.2.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-tpm/recipes-tpm/swtpm/{swtpm_0.10.0.bb => swtpm_0.10.2.bb} (97%)

diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
similarity index 97%
rename from meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
rename to meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
index 8488d01..1e91a91 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.2.bb
@@ -7,7 +7,7 @@ SECTION = "apps"
 # expect-native, socat-native, coreutils-native and net-tools-native are reportedly only required for the tests
 DEPENDS = "libtasn1 coreutils-native expect-native socat-native glib-2.0 net-tools-native libtpms json-glib"
 
-SRCREV = "54f4bb1e702a8b80d990ca00b6f72d5031dd131a"
+SRCREV = "32b5a0575991a73398de9749d63cafd847008af2"
 SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.10;protocol=https"
 PE = "2"
 
-- 
2.43.0

