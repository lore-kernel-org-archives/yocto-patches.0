Return-Path: <rong.fu.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1E8F99C86
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 05:25:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13571.1776662752562507002
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 19 Apr 2026 22:25:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=nXerRjmh;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=857010f8a7=rong.fu.cn@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K3w33s2454192
	for <yocto-patches@lists.yoctoproject.org>; Sun, 19 Apr 2026 22:25:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Ss7R56p0z
	QUbCQrLzOf3QiTtriWzaXrF8DsI5DqZwlE=; b=nXerRjmhxQ9oTSplh264PFkdG
	/LOTefrB3ZrYmSnatcfiKDPaun/bXUat4CDLyuwxEchKyIlfsgL+ab6rycQguYey
	bTQVjFuLY/C5m13lcOn+JDLRYNd7NmqupAHhlJHtiHgg1zMma7pNBUeT/Fp7fS95
	MfkxDzz4ZC/Kh75uFETv2rHj95bATzoec+is4sQU/zfrYgZsaPVoJb9vmV2epdNX
	XrJ8/UlAkkEHdxR/XkvLtgquGXH1nYmN67LSTw2bFScrcsRMYvqz0VB+GIoZgNj1
	xtqSTct3Xc8rWrDcISSrcSecBKmF30NXo7v31yEtZ6zR4PxNwdSiAkTebNrRA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dm9fcs77d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 19 Apr 2026 22:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTlyeE9HX8QBOVMOtQUTCcrsTra4rmTss3sz1ua/l9pLf5q+A+0WBw5FQsnamcC2dRrzxdGiJZO8LlSpDDw7kIKOvQDGH5NP+UGm+rQJHl8TesXmhZYfYz5fsYcn9V2JNGuuHrmgqe/FeKtmpApTCLGKrttpRvi+ekY24siszHMjybZSIZ846jBNeE7rcBFBIjZop46R3vP2VJahn3dxrJ5JDMNBYMMYMbOfBR2Z+7656ySV0vRPTGKugvg7cSHk4m0hTJTABXm3wmnskaeBDwVzwttRb9qYjLybpYIe4Nw7O7HybjqPuGHjzs9Zn/yFuw+0umX56lKXA8IHpggssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss7R56p0zQUbCQrLzOf3QiTtriWzaXrF8DsI5DqZwlE=;
 b=JBD3CKSk99W4WUiPHv+oTe7yvzFDC3TR17me5SvoSn8MCWxUFkvwi5RJhdhGf78oUb7DHLlFjf05V8hbTJx4PsJjhvgdZDhsM1KVjrTURwJRpXdp33qpwJyvF1Kw6EajW8+75yNZ+MO+/sQGi1Zp2lc74n2L1WoUxUgcF76jzT9RCHy3p/FlODa3WDMT6y7DSSMP1/WeTIAvkguZr+iETjBPlAf76moVx8ZjpMWHdHobYUyjHPnaCELgeXPjUFQ8vEN43SYyxFrHY5kbre7RnV+XZWmiG7zuucMzucTTfMJXx+yas7XAE8LESynsmmG6NKekmyIX2IIVDOp/6Nmitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9)
 by IA1PR11MB6220.namprd11.prod.outlook.com (2603:10b6:208:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 05:25:48 +0000
Received: from LV2PR11MB6069.namprd11.prod.outlook.com
 ([fe80::d94b:502e:dc16:ad36]) by LV2PR11MB6069.namprd11.prod.outlook.com
 ([fe80::d94b:502e:dc16:ad36%4]) with mapi id 15.20.9846.012; Mon, 20 Apr 2026
 05:25:48 +0000
From: Rong Fu <rong.fu.cn@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: rong.fu.cn@windriver.com
Subject: [meta-selinux][PATCH v2] libselinux-python: fix do_install line continuation and variable typo
Date: Mon, 20 Apr 2026 13:25:35 +0800
Message-Id: <20260420052535.4066745-1-rong.fu.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0181.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::7) To LV2PR11MB6069.namprd11.prod.outlook.com
 (2603:10b6:408:17a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB6069:EE_|IA1PR11MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 389a97af-fed9-422c-0643-08de9e9d4786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	nNcYkQy6jU8FPBmenp0gO46492+IqfNhwRL+fW0B29WuGBKoA0aDn+fH6Amd8NhFviweWTgk95KYIN5n72kDy/vY6ujhdoy1wmuKaczSsJvMvIltcAFkPuuRLF/R6U+fgvkQWzrIrDzFmqYcvbx24i1lpnZ6Kw87XsrrO8uF0RsURqNXC5reNmk4Ul5J6flfypzZH1Knh53oYfk8d/5fgZSXDXMHCVRbRDoDxPiMVgkvReEYp+s9cFGT0LlGhS0+99stTej9vorvaCnnKqXVSVyPXZMkzslMrgW5lxeepahDDLXB9uuoJbpssvrlZEERUOo5I8o5kyOCg/M9L0WV/EDvRVuwKK7obLcXNPwk3LEV9tzXqJTqqS+oCcOHQ1DqqNMY6AiD5lWhczjF0kZ3sDfUFAn3W7Sh1jUE5lvtCqXZLc33TafYsTBPLeg04BU4U0RI1kcvydWdTBtpnERGk/dLlV8VMNm3yGmjIbsbALnWMQfoPUvsOjq48h4OCF0usdqQlB9GbxlrSZlRdrddMUqCIF3PJoRFsgF03ILw57mO2q7WJJAivBCnqWgEVPxxL29a2I/dU7JTlJRiFzQX31k1pt0Nt5NP6SRvbOmNujk3cmFrmxayjMCXSLnO4ob4znUPH1R1SEO8UYDSWyMa8S0v1Na3d/x7Jof9HTBUfHVfoUQyCj6hP9B2z6SJh28/cgZU2TIYRsVy4D5rrhMoK103OjMaC+kQgqXbsjaMRXMMZphgU71TDTqSXYGSsKKWRY4fbhZrtZIGFTkVpnG8HXzmGM0qOBzJfPrjgTlfK90=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6069.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1tRPUXGIwd/Ou1bXDY5TpAdV4q1iwwpPiZ0tQaIBlHeEXalmHDOQAkhsjigC?=
 =?us-ascii?Q?XKg7IXmXR9G6yL/zJNjUhZuSo9nUw27XC1rut9Rvhqk86ZfONERxN7AUvKJI?=
 =?us-ascii?Q?zyeL2MKVax9TCep9GP4QTF3H/XMwX/Ne1SHF/y8y61gOcWrG8MbIMmps0qZD?=
 =?us-ascii?Q?MAQtWNrTo0N7mSjqX+sQQ1dhtbcCxdQkjh9I4t2/AcQ8syblHj6D3UOwQwmn?=
 =?us-ascii?Q?OctDVCuBCwrcf273u8LrirYgHlE5ww49dc5TgkOrXI5XA0JU3imbOr8Jxwmi?=
 =?us-ascii?Q?qANjbskaLwErp7u7HDW8f4qjF13KnAaKac/BPoOyanad1amHxoWiYzGVvCFn?=
 =?us-ascii?Q?/GDhSUQS9HZXMFO0r/hIsyRfP1G1bPeRiwe2IJKZitLqQbCbpCePZ77WO0E5?=
 =?us-ascii?Q?aaoGfg2NJ3dbTDXltUdJe0dkuxL7RXfX4JSaZImbmiseeMivBms4P6VMe9TJ?=
 =?us-ascii?Q?ag1FcYPSKMkjcJSscrP9/ej083CHePu5Go42kT5DfyKxWPRMAhIQiQPRTEX1?=
 =?us-ascii?Q?gNbRP45CT1floTrjSMwEhP268RlA3xHXJl9V7EGm55ucCwouLhsQ4EcpkLoL?=
 =?us-ascii?Q?SQpi37uYXKMLJPrpK1nkEeZDTxTjCalp1GHJ0Dc2W50oGzDz/VYNR3mVYxo7?=
 =?us-ascii?Q?QW0igM0eds/fz2SBOA4NQpnuDsLBoZREDiFgyH6oqOy7rywbnDFRxaK6Mt+g?=
 =?us-ascii?Q?Z4LM266RSFg55R7BuF09fCWThB85CfHWzhH6dYr/Rxvv2E7osSo9TdY1oVw4?=
 =?us-ascii?Q?7rfVmd5KC8l1B5/KXSYMfx24vIcS84AXohfrmK/9g+bvH9MkspgrLeqpcKlr?=
 =?us-ascii?Q?HZcOvGutS77uWXrPZ14P8zwpMq8+N+AsOxxv6kykZjVQUNBKm/IvH/ZeBg0q?=
 =?us-ascii?Q?HlG808NlljBQ+SGqi6jJ+b2WJq0EvS0be/kNaWj+vr7nZnunev70v38GMrZz?=
 =?us-ascii?Q?sZ5D6a+pNLwATMdO6Ggwp0REOk3QWGFAXpGByLB46my0D3uSPCpQ+LuLM1T1?=
 =?us-ascii?Q?OxyPHOr07PmeFKjiECgoLFJndZg9OczczJVblBiyWVjNYg+tNFtLUUnSDcwW?=
 =?us-ascii?Q?eUh7XCeMJ9HOz5c9jI0sSk3U9FU/V1OA9SBLlci2hw5240/h+PKTzyF9VypK?=
 =?us-ascii?Q?jLErsZKJkcgT3Lc8PxJcg8IXeNAUT8sSHxvcpmWDq3vvpnFxEPDRe8/l98V+?=
 =?us-ascii?Q?qWvMOD84cOsNQDSm1l7dRCXgLhBWVj1jI1AilYSskZ723+2IqeQQl6iryFnD?=
 =?us-ascii?Q?p5GBIWRU582dkl1/kKPLqkDdWfmU67v4iplApgwjC01vtHSiGaQfriF19mSZ?=
 =?us-ascii?Q?nv83ZlDVc/KcdveiF5lHZ2nIrquiQbLOIQp6P79vuwk0WIvK/+SebwydeFCs?=
 =?us-ascii?Q?5OXjups38aYhwuw7aNg2t60fTajHpdPfJo7nplzPNuVRm/zH0weqsMAJmtHE?=
 =?us-ascii?Q?TDKLd+kq+ALeT+lkChaCpo63PUL7kBKfn+skS3Rb/8FhIf6SW6jpaMMsKz0x?=
 =?us-ascii?Q?O6jFaXO4mQlNyLbsu1K0+NALAUpxqwaBQrJxGiFPH+faiYuM4Fruugv0VUpu?=
 =?us-ascii?Q?/MWFJKahA21xZTb79I/MJSbUg+sVQcqOMIhVEvyV/38qIAKafPBUAirA4eiH?=
 =?us-ascii?Q?fkQ/ILWugByIS5yKHBlQXPdBzIxZ+vCR7gwGmOj1eV+7q0rIfR0nv/PxC61d?=
 =?us-ascii?Q?4wLx3NKFoN5QJ1q2IGVvTQtyakjHycH8PVlEcrBoekxZxQ05UNiRuzpIS1PA?=
 =?us-ascii?Q?Lp0eiayHpU8OucVUsDTNvJniwj18tMs=3D?=
X-Exchange-RoutingPolicyChecked: 
	htGFshuD6AaA2QDNj6Zc0f7DMa2oVJR38+AfLVc2gjDqdsEXxFhj6MiSDEa1XMCjzUCh/HcvzT7T7cPp/U39zQRC0s8FJHpRCbYos1TfiP2FuOGqoGD/pMma6Y3Arx9InMGbY0kArud2Hm08Il1K5Lc+/8pN/HJLFW726rYMBntrjvOHx6edr4G/72n5cIioMI1La537WBXiXnIRH5Y2e6ihzN+c3+/s3OBxhttG0Lc8Ej/oNPoBhD0+i2z5gkgplzHUtKEYW1lstJkJyem04w12lTANAbrssWRaS4CFyz2/oSUWKa198AyoQFptEsqhnEv03kTra/9DpFcnXVSLpQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389a97af-fed9-422c-0643-08de9e9d4786
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6069.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 05:25:48.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7msP+B9cBm49yUoz4n57pFhEQ60h8KH6nyZ7EDLqtkhWtqTrH3hEJhgD9AbxaJQWNpB5FOojL2lH9k4PW5oTykDeODi2CaPvVjyYL8q3BLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6220
X-Proofpoint-ORIG-GUID: 5e-BUOA-YzXGp0H1jRTbFgzpLTsv8b8t
X-Proofpoint-GUID: 5e-BUOA-YzXGp0H1jRTbFgzpLTsv8b8t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA0OSBTYWx0ZWRfXy/p8vmTKbqT7
 Nwk0St4vHHsW3YBihM4zWrhjZNdL09H6uCMGBj/QIddIu2RumGJDJWYL+Fku1pf7rHzDRCSPehu
 cBsGHJ9y30HhZAW9MMcQvhWafC6GMMRhglaDK9VBvuIDrMxZteV1mT43PEMYtfVZSpZ5IcrDDZh
 StB2qjEKSykoZhQpMmoOAeh8pry9qIomMtRkU6Dc6ws2wQvu/mZbhcLFXX3Ak5Mz9NoOOcMtKGj
 e+iInRIZXWroohV5jPNE1VmHPDUIw2o0Q9hK43PtXDDwnTbfOrjKLN4Xva1c5icxqUwED62HCBt
 38a0rTH/RupeZy2ncVgxLz6YlXOVaIo3btQeFWDy0JeeP0qOsE8p0frB2LMxT12lts8ora5v7E1
 /cqgS5evhPgl2fXnUU5wXGkF0ZawwF14Vo52CGo1mbzS64ABUQ9HIlPvIANeXY57vhYS2upEcRs
 qaR1cZh4POZ6nlzfI7A==
X-Authority-Analysis: v=2.4 cv=WKZPmHsR c=1 sm=1 tr=0 ts=69e5b8de cx=c_pps
 a=5k1muW5XIJfqWNzrwyhXkQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=tK2F-7LOLerRfl_UxpwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200049
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 05:25:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3732

Add missing line continuation backslash after PREFIX=${prefix} in do_install().
Fix variable name typo: rename 'dicect_url_json' to 'direct_url_json'.

Signed-off-by: Rong Fu <rong.fu.cn@windriver.com>
---
 recipes-security/selinux/libselinux-python_3.10.bb | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/recipes-security/selinux/libselinux-python_3.10.bb b/recipes-security/selinux/libselinux-python_3.10.bb
index 5777dee..98296e1 100644
--- a/recipes-security/selinux/libselinux-python_3.10.bb
+++ b/recipes-security/selinux/libselinux-python_3.10.bb
@@ -48,18 +48,18 @@ do_install() {
     oe_runmake install-pywrap \
         PIP_NO_BUILD_ISOLATION=0 \
         DESTDIR=${D} \
-        PREFIX=${prefix}
+        PREFIX=${prefix} \
         PYLIBVER='python${PYTHON_BASEVERSION}' \
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}'
 
-    dicect_url_json="${D}${PYTHON_SITEPACKAGES_DIR}/selinux-${PV}.dist-info/direct_url.json"
-    oldhash=$(nativepython3 -c "from pip._internal.operations.install.wheel import rehash; hash,len = rehash('$dicect_url_json'); print(f'{hash},{len}')")
+    direct_url_json="${D}${PYTHON_SITEPACKAGES_DIR}/selinux-${PV}.dist-info/direct_url.json"
+    oldhash=$(nativepython3 -c "from pip._internal.operations.install.wheel import rehash; hash,len = rehash('$direct_url_json'); print(f'{hash},{len}')")
 
     # Fix buildpaths issue
     sed -i -e 's,${WORKDIR},,g' \
-        $dicect_url_json
+        $direct_url_json
 
-    newhash=$(nativepython3 -c "from pip._internal.operations.install.wheel import rehash; hash,len = rehash('$dicect_url_json'); print(f'{hash},{len}')")
+    newhash=$(nativepython3 -c "from pip._internal.operations.install.wheel import rehash; hash,len = rehash('$direct_url_json'); print(f'{hash},{len}')")
 
     # Update hash of direct_url.json in RECORD after build path was removed
     sed -i -e "s/$oldhash/$newhash/g" \
-- 
2.34.1


