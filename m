Return-Path: <rong.fu.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D360CD37B2
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 01:05:55 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40248.1778461549724769829
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 May 2026 18:05:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ivvW6rB4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9591808096=rong.fu.cn@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B0wdRU100066
	for <yocto-patches@lists.yoctoproject.org>; Sun, 10 May 2026 18:05:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=rA0O3HSNp
	xaKM/CwgXyRlzkcAmaPjT0W9AJhxpGCaao=; b=ivvW6rB4NbWx62kVubjEmK/cp
	kFa5ULau4cUCEj0owoUv2m8qZG11z/RpHmkixcvbulWs03YBxBvbrTS9EGny6LsE
	9xcBlI57+2v+CGbixUk7+nk2sl84/PsDhSXRLL5kUYgZqMNtgxLtMW6Y5uhMAYRP
	0c5WaPR4AY03ru5S7dU0zDtfpzjVI4NIRIukswc71Z3Z/LcsN66+aJ50lH/9m9fX
	SOhaIJaT3nMbTX4h3LOby2cYihjZDRStnnHgdtrExDj/yFMp2Jiu941Y+EJwwG+i
	t7LChfU2IhPWAy0FmqcGSduDQ527NfWtm6igaGW+UWwjG4c7K7vzbt86MaIuQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e206xs83j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 10 May 2026 18:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLdfu2FeMBK8Yc4r1r6qQhH0ze8dIdGz5IkTvSEIHxuRmu6iqQfo42AS4u7M2w8YdcVj5Gr0/CDSJtpl8FBoFwdTJq/6kQawkJuPlPudDh4uD42oLaClmK1AALdhBBxYucWxB7AmgakSd+k1nyNJXs6ItJ//vocvYo5B7jeHCAC0REop2atb/FYotfwrPJYrCAG/qFMFp6Vz5uj/Wrvo3WNG3AAHh1R1VL1s6GszwD3ZyaLqkhZEqA47XrJnDs42nIKLLeyLrdSzf8v1sTBIjWFknt4QRnV5cxwksB0OIz+ioM2YZ7idijWlCP/0ML3cwWjTpFpyCs+vqzaLCxkkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA0O3HSNpxaKM/CwgXyRlzkcAmaPjT0W9AJhxpGCaao=;
 b=ZobqfkRr7dHaR/57DNzawemsK5EjgBbGxqd8rE+PUlQ1RivL4UbGELWvzjDcj7DJsFgNB9l3RLUNNtOMLMejNon5J9CTFcvyoIjj8TRW/SKnV8sLvfvr5pXOSCB1c8+FxzAwEsEcvveQB7hmWIfdqILYkbPyEcwYf147re5qwq1Cqw3G0R6Mv7ZZMbbh5yB5Vw5qKcB7yjdZcG+yAAkoHODw4KzStSNkPcYamAG/3RqJym3kHR1AKnAoFf5C7jxw0SDjJLoq6dW0JoS26XVA++3KnDhnieExW8nJFx74+TZfX4jf5dvmOUsyR/YLX5hHAfBHpeMPEsDLiXMJrbNxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9)
 by IA1PR11MB7199.namprd11.prod.outlook.com (2603:10b6:208:418::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 01:05:46 +0000
Received: from LV2PR11MB6069.namprd11.prod.outlook.com
 ([fe80::d94b:502e:dc16:ad36]) by LV2PR11MB6069.namprd11.prod.outlook.com
 ([fe80::d94b:502e:dc16:ad36%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 01:05:46 +0000
From: Rong Fu <rong.fu.cn@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: rong.fu.cn@windriver.com
Subject: [meta-selinux][scarthgap][PATCH] libselinux-python: fix do_install line continuation
Date: Mon, 11 May 2026 09:05:32 +0800
Message-Id: <20260511010532.813420-1-rong.fu.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::10) To LV2PR11MB6069.namprd11.prod.outlook.com
 (2603:10b6:408:17a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB6069:EE_|IA1PR11MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4386df-e100-458d-acbb-08deaef96ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	oZ3VBbz4K9e9kGjDd1zpoDCR80lHM86SVqoWLUWdMHZXzqUipbfLzRkGR29a8ZfzW3AGejDJQxOXxYPZXa2p22lGA91CCHIW7u3vQfj6bXF3xYEoeTH4qC9TF1SXVJo0eya7I45Bw5S3E/UcscMEbDTq1UqUY5bP9gfW8HLKH7gLn1cRPjhRAzCK9Tqf6kWckH4JhQkoCehsAyNKqPB+eFokPIgILQEx5RJnhpeGY6WHgy/BuQfYLJb9a2i9TctLD2rxkV1QZX1cvAidTftumVW5Z/UIP2y9P6oexb6Z0cW1FtEWx0ElXSQX/GI1JZwFVfyXTM5tgnwn4JThwqDoi3eFDnivHNjJ7CTjwAHZB2eSF1uzW6sRrNpGhgBgl5iUsGVcuRXQXYDRs0XM4Ndmp+JkOBc90tyK+uZcBW4J8tRyPsPmE6fG2ipfyT8B+y+huyrVAxvpmf2NPelYViOyV7rfegL489V1eDSLR4Z9rILjXzA9eJNR4/qZDagUQIKiBPYM7/DSYuMdhXmHuqK5+xzS4Po70pro7Zu1Hs+spzsOKNiYMadSttfIyz903vJkCuETYOMgcVmDIdnb1QMc90kpkiPP3K6k/987Tt9nLfDx9ce3UWZRvIbU+bbZ0RY65Fb/FI2Q3qif90e0BQEoimTjSVXbjvDZxvWLgYHAoXaDSflbytmorQDlKDHT0nn4xWgOonslU0AbvJPNF6P/8tDd3CiSULhx4pREw/KCoy5HPPmdt+PAs6VNFgiQOqZj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6069.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wkePHY0+LP/RaNnczxVwCgAiKC6ucb8J8OLvJLvnleo6fmXvAJCvCdhGTaAj?=
 =?us-ascii?Q?NeIHdZIhLtzIJzkUkujhSkjQtUp9w3xrH1tQHlqXNzA8x5CbuxZNjYWXfq6d?=
 =?us-ascii?Q?5YVMrQtjn2Wc3U1MN58ehfiddHGYFDPuQs9UByQwJ0vkiyc/2y15ihz38dxu?=
 =?us-ascii?Q?4YB9BsMXXhui0gThRbZFiWTxVchCbc+AYXp0OATp82Zv9he0FALMPMPpWUvH?=
 =?us-ascii?Q?JOb/sYsfhSig33carolFH0ZE7sDd1SNLieYQDEt+XkwdYJ1wZk1WBC0izAob?=
 =?us-ascii?Q?aRFKgZ3ttJmwtUtSHDSy1xhXIKiFXvg2btL/MF1T3OHDq16ACbp9ZTSomCOr?=
 =?us-ascii?Q?0h6Ve5q+4jLD21I5QWSP82YGJT3IrPF7ySi3qVFx/fAPWLFMYwyxh/0R7COT?=
 =?us-ascii?Q?mL9uPG51dQEh+Ri4kV/L//XpbnH+EewiUE2k7kblFG+64d7FKyvUBwjmVzS9?=
 =?us-ascii?Q?Y++mVf1outcavNm6uuppehTFlujfyYv/rozXVzbQQWlR+pr7HlfxL+NlXPGQ?=
 =?us-ascii?Q?V1D17UeqCyjzwKa9Bn469rxIzcF7q/vkcP5O4VPHlcfV9P2oDLs4d+jHJdaZ?=
 =?us-ascii?Q?C20fK5KDEZ7UdUmIITdXWNeuilKhAIWlFJXiGRSHPcMcGdrYRWby8WssZVcz?=
 =?us-ascii?Q?HNbj09MjYK+5MG80dI8Yt/clbZfV/pBPyPgRQLZCamHcoN0Rpr1FC/mtOERH?=
 =?us-ascii?Q?u8IHQB3iRYXqDx05xWvAWxNzjsXZmCic4w3uaG9Za2+xg7N3W4zWYDXP///S?=
 =?us-ascii?Q?zTK5zixTZchT9CwpWOQYQLJrasJM/ZcU4gcwrJqcNx8aNU7dk6Cpycj7UlC+?=
 =?us-ascii?Q?0X4mgv/6DRI5UhVxf2d2tvmygOdwah9RgEGEcAIpJzsJn0KwPmK2ykcr45qr?=
 =?us-ascii?Q?Py3NYvcPXj1swVjQIqOtEvRfQKMAbiZs7Lg06guyoWCYMwi6IQ8cobst7SlI?=
 =?us-ascii?Q?WL5psTCbSPvw13pdvjAIyttpDM0SJ07M4ZGAkvSh5olYkf3lizKWE6lQ1PJI?=
 =?us-ascii?Q?fykYRbEBAm/Hbx5bt//lhgvyBiDVgXbAArjKxZbQYIvizHPz/lGAusnsyy27?=
 =?us-ascii?Q?kGX1OcgJyLseZEqi8nQ5Co5hslKbIokS9g7cFvYU31lI2AXh9sPsCetjBhDQ?=
 =?us-ascii?Q?LAIDK76gAieOUNI5UDR9sCvHXz7pKpYkepy1bWyAib754Bm0rOkQYy+/fKxr?=
 =?us-ascii?Q?8+LEy/W7irGwqEZ/mXwGWhoVFQE9W03YVZmvuaBL+2qWJZZO410QeA/MoPPu?=
 =?us-ascii?Q?1u/QYzytSteo2a0ug3pC90dUZhAhV5JLVGup6LeOW8xuYSsVXZffuf1vlbwA?=
 =?us-ascii?Q?CQRyrB9+u7zgqkVMk1Gm1nVkHP2i3ZY+DoWjDdOS0VZ9NJLRDGyq1HtSyTcD?=
 =?us-ascii?Q?blcyTKRmBpPxU/SJMjQcVmsWiI7jTVbCTvgGMGN67nAqe151YGuy0jcABwsx?=
 =?us-ascii?Q?oGqpOt6DtEGZrmlXFoC8NqQV1qNVSZPZV9p0KObAdQIK3IbHYS8i+aCVdpik?=
 =?us-ascii?Q?U61nGrc1ltIkVxGE48BLFCFsQ4cyLOZg0K6dzU1q+pUbebTM1/Mp2B8eCD5u?=
 =?us-ascii?Q?oEt647g2wXItwHh4FR/l4toAH8pQzuGqZRougSE4hjaVxIlG9ZdQ7M1YwD67?=
 =?us-ascii?Q?WTdLBE3o1bttygjPgaIeCiILiWsJt8M6Hcpn5z8IssitiHCAYC6EGI33TSgD?=
 =?us-ascii?Q?kGYdEugKzmsnuwccqaJCpSMLBC+hk7k93H3MD/N4l2i8v0BXeJghqt5YAua5?=
 =?us-ascii?Q?68kCdGHYWg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	AeBUU/2kjoa9GjbIKZzBxT2xdkPb2ZlYyk1dnFQh2cllGphI9ZF30ajw9CadJj6hdgugF5duY44u5gB9GtZt35X9b8AuBe42llERlN0HkdUX2TeHmPc9UH3llALkeQGY+Ev/2v9KQciviMiwt2B9aW8wWBacILJurhNf1c2hZwgPwWSRPmcRtI8UAc4q35/CZ3aoCW+0arNckbI4cMLk2LnkaF6ngfMiiQfc8+GDCtg4D7aIqmxnCpiKefl1beHiKEis4NlaFr/8CN4uwv+k9OBNwNiRzZrsG7JhvHoXoMvztTEaouki5TuwJCOnuveAXmQyxlQpq97QmqCGs5K4pg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4386df-e100-458d-acbb-08deaef96ead
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6069.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 01:05:46.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR1VXS2AstwvRwpcDN0/hAtx+eGXhzjV/6r30oOWTKgWNW1IYcDpS9HxSwklJngSszuIzuooGcMid5kDSoZnzHsxF2tyZyvJZk7BLEajxk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAwOCBTYWx0ZWRfX1ZnLwnEmyred
 IJE/7psFxKWQC2JAs/IZDvRNrfaSUvZiEY7s9AHvXkvCQy12OhLS9mtdGaS0ImFbffIQVDFtjcK
 +MnDDnfpvB4e8WNO/bZkb6gFWn3kMZzs76PbvpYURC5eTlnzOAR5X1gw5zgBVJbCqSc3EeXgdJt
 OLLPmo7yoLwQbJPPwJ7geBffqoS7o+AiqICXr3HGEH7FFDDRNdRG54qUc8X9r+fpYwwHVB86tE7
 VnscT56OSBF0CelYqcIppVQomOLlMK5hglVhIe05Pc6mGKMfHDgF/fB/KvhwnovM0R2h7lXD1yk
 C6ORhAadS4xmjMtJqliQZbnkNM1r2anxXvv+DTbAe8FLwyuUwD8a3QEnTY39sLLLmUkOwlZDO4x
 24EilTyr7FsicY1XmLxI+s+MjO/3mQV61cZUvpxcKzVwKa4rHjTszr2RgTC5fjg3TYTQf/Jukvj
 BCrE0hekKPLrzh58M9w==
X-Proofpoint-ORIG-GUID: UQOxV3_cyU-CNW5XV4vQDKzwYpCLvbHn
X-Authority-Analysis: v=2.4 cv=CJMamxrD c=1 sm=1 tr=0 ts=6a012b6d cx=c_pps
 a=qSv8Sft3UEt4GReRCOm4JQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=Sl6XQQimaeeO5uW2YNIA:9 a=ZXulRonScM0A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: UQOxV3_cyU-CNW5XV4vQDKzwYpCLvbHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-10_06,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110008
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 01:05:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3963

Backport fix from master commit f7306d7af4425553684a860df6f6d0ee66efba31
to add missing line continuation backslash after PREFIX=${prefix} in
do_install().

Signed-off-by: Rong Fu <rong.fu.cn@windriver.com>
---
 recipes-security/selinux/libselinux-python_3.7.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/selinux/libselinux-python_3.7.bb b/recipes-security/selinux/libselinux-python_3.7.bb
index 9023769..e0207f7 100644
--- a/recipes-security/selinux/libselinux-python_3.7.bb
+++ b/recipes-security/selinux/libselinux-python_3.7.bb
@@ -47,7 +47,7 @@ do_compile() {
 do_install() {
     oe_runmake install-pywrap \
         DESTDIR=${D} \
-        PREFIX=${prefix}
+        PREFIX=${prefix} \
         PYLIBVER='python${PYTHON_BASEVERSION}' \
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}'
 
-- 
2.34.1


