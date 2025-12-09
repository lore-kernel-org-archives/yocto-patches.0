Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE98D1CDC6
	for <webhook@archiver.kernel.org>; Tue,  9 Dec 2025 06:49:19 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1811.1765262955870705522
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Dec 2025 22:49:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=PsrbWEb/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4438bd960f=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B93GG5W2930812
	for <yocto-patches@lists.yoctoproject.org>; Mon, 8 Dec 2025 22:49:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=0g64EQvwp
	62/4X5YDulyTpsM3Dgdskh328JXGPstFe0=; b=PsrbWEb/iA99JmoNJPVhfwuz7
	ht1J0tb/YOZlbhUcRoc/Fi+mUzPnH0wxpKYlS4FdAN/lU/ct+i1jVymgjnQSAmpG
	yl4vSOzI9JHf2GWALCStIIIGkoJW7JyD8y+NiVEgGYdoC5pJm7oo3NoQlXvQsqfm
	8kVTSZytd3VAo9l5BMYNqjSsd0IGl54rm8eBk4ZukzS2HbocAOeJ6a4bt87TcNj0
	YfTfN3zDvZblygbXshveGvrHensy17yHEPqb8IsBQCUPOVKEQ6JTb0iAEcIZPZ7j
	NwgqfWZ9ipjmJoM9lY8xlkYg19/cewIDGjIcNov8ui5xHsJi7at0RAxb/WWng==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4avmvhac7f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 08 Dec 2025 22:49:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mn6d5RG1nhSXN+n4Cg0GGd9j3INeU8gZntFXH/ngHHHkX+VpBQeWUtqUHnQq/j00CHretRe6sx0QxRtksYgnCU/ZJxwB8APYuVuESuVFiev/V+7Teu+rBCqiqt8SrKNARxMqjwHRr/U5J+4LnsHFyAWFKS9PGGA3moYa7eXYvv3NntWmMMKhEfG4YSlTg+Okfe16ZSiITCsTAFMzWdoUj3Vvi7LjgIKJhMznKbJo3eWsjVtduyCO+XYil7VrYrFo+3QjsR3ebnIGyqEjbg+XVFUJnoMunj7CgjvOnfa8Y3i23U6iB4FVKFu+ENH9L4gf4ESOgzI5wFofWHxL6/hc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g64EQvwp62/4X5YDulyTpsM3Dgdskh328JXGPstFe0=;
 b=bQS/Jlf9gqgeA0RZm43E99qu/tXpQq1uFcuUzp7G7E18Q3sC4ZULLy4JyswnLSolqejClLodbOcHv7mJ33bbCsNCg8vGLcrphylJ0qigRDMOkK8DTW3iLpa/G4COP3g0PEvRKX5m0rDIifAOqTWJHt2VNO1zXAU5s9BpQKzp658Uh/PSAuX+OMkDSVrRmiu6JmzJzGcdBb2qovFhY9bhUKiSxmUWdPKfbM4Hm/k5HTnmog/6VC9LfiuypS540YKrje1EMJTk69rANy9MpVKEUBKPEKkWRyrN9n2LhuUrRmJ4396+WrVjmX9h2An1yUIgwBgwfcRytu9pC5ovquy0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH3PR11MB8707.namprd11.prod.outlook.com (2603:10b6:610:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 06:49:12 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 06:49:12 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: kai.kang@windriver.com
Subject: [meta-anaconda][PATCH] systemd-serialgetty.bbappend: fix S setting in case of anaconda
Date: Tue,  9 Dec 2025 14:48:55 +0800
Message-Id: <20251209064855.543981-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0038.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::7) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH3PR11MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 8579d0c6-e9eb-486d-f268-08de36ef0f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NyITokFgSBQuhakWJR+unMQ63n9nudyacWCrcvc/Zf3gds/SrR1w5HlAINeO?=
 =?us-ascii?Q?gJT9gE5bqZMZ+jWH0CWOcfqd5QTvpY9awjLq7fAZ8mswg7z1Hl31PXKBLjBV?=
 =?us-ascii?Q?YPvYkg6tD5OmUs1RhiNJIkbeSrT/XYDb7lTxMiM7ikvajMRAF15aZj6Y+T1O?=
 =?us-ascii?Q?UPsyhGMjcnGEX9TC9M6dFzETETmMOSgNumxpWuxTyHhx9xSDDQEU/oCrwXuk?=
 =?us-ascii?Q?Cl0LXmlTiQ4XYCWpuVuty76xazTobtmtVHolK8fTaNK8+7fA27lsA2OZOaTq?=
 =?us-ascii?Q?J0wGo1imAq1JME3gPNffsPg5FyZH7xFS0KmxQAP0kzYoP2ACq5Tv4RjasfRD?=
 =?us-ascii?Q?keyK7Hit+4dPw9/NrpsmneBUs2FF7urvA1BWhdXe8xO9Hc/CPkcwG6C1vA49?=
 =?us-ascii?Q?u7wLDt9cSQVJjE1UroEi5B1stoZ4qm0MjTbBwfH572rPA1HV4T6/279GKlK7?=
 =?us-ascii?Q?IAUKGIgA+yYzJHIgy6b3Mf9LaJlozxF4AehGCRMLN3VK/jBIP5OGnSzRlSN8?=
 =?us-ascii?Q?mGDSXliijbQAjk5DqB9t9zSBwGG/WoS/hiKZHtCplhVqHuPSTi6xP2/dJ1ZH?=
 =?us-ascii?Q?vaqM7vBmFRQORIz7Jj4pkNJGotbNxgWKaTQ3alGgvZFWHNBaEkE8pyHW67Ex?=
 =?us-ascii?Q?jGFTVOuFV46G506J7hrednhY60Q+8w1I45RyHhsXNt6q7EJeWPWzOiTYFL/G?=
 =?us-ascii?Q?fBMhsH1ZkeV22bdl6LKy5fUK9Rvh/rrK+7OD9szJi2092ialNSVXzmhaZwC1?=
 =?us-ascii?Q?CnASg7Cfua58lBQg+wGYI8VT4TIKQMpO1CW9Atl6m3pGT/6b+GZsBzbUlyuL?=
 =?us-ascii?Q?Bux9kPKs9Z+lHRu0bG4oOTDziQqMncQLyTIglzVeipvycz3A1osPZuygPKjQ?=
 =?us-ascii?Q?yzvf7cZlSfJO+QHLM/y6/ddFvyZu85fJqXcWbNhRIrJCxLltcSWB3IKGX7EY?=
 =?us-ascii?Q?CMMT9/chanrbZIBB9oqcqs4pBHf35e/Jh/vu51kiJfzr3E9hBnZbTBLxFMkA?=
 =?us-ascii?Q?leCa0SNQImlO4A3YH1AWDMmNfdv+wH/sNfrVdwR2JlV3pMKm4VdjveWTDXuy?=
 =?us-ascii?Q?2zZQkzVyyh8vj35n2faqg+sF2UpkI+5tgo/l4zBamtruT5fKanGfLVHILRel?=
 =?us-ascii?Q?m+wLIXNG4BHdJ4SIPS3/O2L7CCH0K08RmhX2S0yAiJpj30AgLZDgg9+ER+ck?=
 =?us-ascii?Q?dBHhsiFikR0lvcMk4ebXMQDAvqKGcKPc16n/uqJHo5xzjcJMavO+yptChfV5?=
 =?us-ascii?Q?yt7pFDiJhZB8hxYv0MBARxLdH4VgYeN775ykLQn0qZPtGC5ge9BlGU+nyGud?=
 =?us-ascii?Q?u4BknOtidnJpBgQFtlDJ0ORgAiH/55fhLPIpnvIWp/6wuzFlrz31twVgmqoG?=
 =?us-ascii?Q?tW8vQuhxWYTyLFqJGAhSo/tgwKawbYEJr6cyCrRuzcWBdnRwrXNnWsnU81ti?=
 =?us-ascii?Q?dmf0JtCIgGfsWNq+USAgRd8rRIGLgvA1tGSreGFwQc6n9s9DH9vmuo2kMVpi?=
 =?us-ascii?Q?ExGIUw8/oPDNKP+w29L1K8RlJhnck21TenPv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Crs01ilkGLeM9KkumQ87PiZ5VekWlJP6Er8ClvtPen3JLJl2w9Dg8Wsp6q3X?=
 =?us-ascii?Q?7JTCvevx3vq8OSq4jZ61TwyYnOA9PPDU7wObYdE4moJuyKH4wd8dM+eWuvqr?=
 =?us-ascii?Q?kXTnODSz2O13BYJuDJtq4ZnCJAaVqhGiASJ7f+gCWI/yvTYqlSK6r+uN/A68?=
 =?us-ascii?Q?bfdpaTvPiBz79Mg0kJhW1kgiAHDp+mt234kdNgdXwr0RiItiX/JYnOM4u4Hj?=
 =?us-ascii?Q?EKAyfB0kZUCHuNv+ceScRvFyr4Az1+TrFJr42i/9IT06Dm+vbrZlKTb25azM?=
 =?us-ascii?Q?SSTmUIc1VzxCsxAiay3AYph5bBG44Hw3ga+5lkWMg6g/qnFHmgRpn32bT2iR?=
 =?us-ascii?Q?FE4fXOnrcx4/5TfRToqMgeLzrvZZV0eHpP/kr0yZJ5Ci2e7WSp956CVDKb9g?=
 =?us-ascii?Q?64cMIDbCBKjg1/QvTa9bPR+sQEUf2wrI2UTYvnj60ujcunMkYs+/dVVJFcII?=
 =?us-ascii?Q?7gWXFbSVI/uaVfD5CdkeWcdPHlmRzdgKfhjiVLVQbJXBgd+Z07TewUKZSmrk?=
 =?us-ascii?Q?t3aT7lnA7Rp0ckrLTCrpttImGgenLrwAA6WIQR8PpZqaihllYZ+W4ZO2Irmn?=
 =?us-ascii?Q?g1afeBxhB3QDIZio4MwcuXtCGhQgkE1DYX9BPx8YzF7fmnz3aWlCTHIpap0e?=
 =?us-ascii?Q?/VGkH/X0knAyzglBZhTyUSVnoP0A/ohyRFvsHsOhGNAbWa4ggbpR61vCvdW5?=
 =?us-ascii?Q?Ykk2ex6zWpStudRTqwhx9fwHEO6wP4NkTvsysQzuKgVjyCsapCIOOHuaZ4t1?=
 =?us-ascii?Q?PGEX3fhQLvlxClxek6ha6oebkj7LxGRFyzE4+E0wAacPVsWafK0sZEz1dYNH?=
 =?us-ascii?Q?7rCCX2h4MnC9zUehjXn54khew9ZAlf6O2ytwlpPvMDST1dVDmK9HRJ2Dnju4?=
 =?us-ascii?Q?uSdL0iL5s0bFthfAyHZM+lJ5ISSAxh79PG6poHW7cTIAWM3YMODnNN8/+oEs?=
 =?us-ascii?Q?icXRJ2+uyvlNiCT82br6Y7cX8S5awZNvZY1btsrU4XQ14HKRHBeHQoqcvXIm?=
 =?us-ascii?Q?tBhUnEH6tti4nYAxcQqxJQR5aFT5pE+0xwOZamTsdbhiuNK2pBaxElXaP/Ss?=
 =?us-ascii?Q?l1jwBgBKTx8m7yF23+aJJIWp3L0Wk66weFgbl8xWZJNvxf9/3DLrmcz5Qciw?=
 =?us-ascii?Q?uppsUfifWuRmdM3dxejSIgsH4XzNzDnXUEtyJ76I7T/ug3Imi6Qu+M0cdh8X?=
 =?us-ascii?Q?+qv2C96sISs17+hB3dKXLJwt8apXnBF+XY/+/GenvcZojnFHECzSNUP9zqKn?=
 =?us-ascii?Q?C0Cyyhw3V1119VYOhW0tSJpl6zGwwdY4UZt2vHXGHgDJEVt0FO6TbOURS8by?=
 =?us-ascii?Q?aWentJXPqk73GFtpYeO2HpTg8+fRZHGOqUhuYIljPMFxGvOpwEgnj7fhA6E8?=
 =?us-ascii?Q?NkQ6p3UuqZrbBYaDwgko6/7CyNqwBT5LaudnySGL9+66FnBJEpvlD7SLOO1K?=
 =?us-ascii?Q?/KT96CbNmFuHDkluMSnYNTNWjJ0EIhQDvSrkbFq6+olNcZ1T2YpxflgMaJdx?=
 =?us-ascii?Q?rRcl0Wo4fCjVRJImdbxPKL97lRFztm2L6ekZxrPDuKxPcVyH5ptI2MIAm0+z?=
 =?us-ascii?Q?S+S6RIEopZV7vmfJDkYtk1Sjrk/QbX5um/SLGbtu?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8579d0c6-e9eb-486d-f268-08de36ef0f6a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 06:49:11.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36rVYVv7PcRdT4S/CkEEMgrAQPsaFCR7X2UC8ozX5DhdO3dZUl2u2b5d3v6e1OpT/wwIYM0U5mfJ9p8XeTRDYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8707
X-Proofpoint-ORIG-GUID: xfzSYblfAbHTgP6sggBxz_viESKg1oTK
X-Authority-Analysis: v=2.4 cv=be9mkePB c=1 sm=1 tr=0 ts=6937c66b cx=c_pps
 a=9n5CQ2h0WC+XkeHDVU/11Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=P_7oHvulWgpmIqad-fAA:9 a=zZCYzV9kfG8A:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: xfzSYblfAbHTgP6sggBxz_viESKg1oTK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA0OSBTYWx0ZWRfX76/eYFdS/Gji
 EKzOSYpAr07ZlrypQiaCMvRI9S5foO7tqbOicQJgqFrRAIVxxyJiHYaO4K1ka35i0muW85yErAw
 RlyWEqFYPPqxhHtXoJoMt5PsplJqLw+ux+CvFGtixlUOCpTDgaLxfeQXOtYhE21Ls2pygUPE4Rx
 J9lxHde95/C08eRUjMMPdSQdWexanNwgSnFNRa+fHDEnPQ20RyNe1VutWt7afBK5C5h9d7+N0sY
 ADFg/dm2WyxY/VXnQKGnyUOx9xWPq6YRJrKfQPeYAoFmk0N+vqdqJndBnlc1kxUFCuo48A9n/Fi
 FOVUJq6IZi9apAu8M5USIZSkZH1nvRz912ixLOYvnaVhWWYtgZ+zJ4IQbHthBwqAll4+tV6xrBi
 qt8BD3MYzOWwRfB4U3a9EUIGZ6fxjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090049
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Dec 2025 06:49:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2754

From: Chen Qi <Qi.Chen@windriver.com>

Due to the above SRC_URI:append:anaconda setting, we have to set
S to ${UNPACKDIR} explicitly to avoid the following warning:

  WARNING: systemd-serialgetty: the directory ${UNPACKDIR}/${BP}
           pointed to by the S variable doesn't exist

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 recipes-core/systemd/systemd-serialgetty.bbappend | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-core/systemd/systemd-serialgetty.bbappend b/recipes-core/systemd/systemd-serialgetty.bbappend
index c69ad4e..8395ff4 100644
--- a/recipes-core/systemd/systemd-serialgetty.bbappend
+++ b/recipes-core/systemd/systemd-serialgetty.bbappend
@@ -4,6 +4,8 @@ SRC_URI:append:anaconda = " \
     ${@bb.utils.contains('INSTALLER_SERIAL', '1', 'file://serial-screen-anaconda.sh', '', d)} \
 "
 
+S:anaconda = "${UNPACKDIR}"
+
 do_install:append:anaconda() {
 	if [ "${INSTALLER_SERIAL}" = "1" ]; then
 		install -d ${D}${sysconfdir}/profile.d
-- 
2.34.1


