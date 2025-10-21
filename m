Return-Path: <Haixiao.Yan.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E0CCD184
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 05:43:52 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.4592.1761025423414011944
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 22:43:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=AagpduZ0;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=2389587ef6=haixiao.yan.cn@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59L5QLb8260535
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 05:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=f+q4XxNcbFrFo1bT2HTx
	4qvhTijo06tJ0IH2kUdh/e4=; b=AagpduZ0fl2TGkdmUfg1c4rJW6WClZCoe0K7
	2WExX4JZxl/1N3Pjipu9Zc94o+CB4yjhkqmBwutaeWv4raUs9Gwy7ESH1aKHRaTz
	blWJTKwCEpgLc4NabCxC1/tV4XW4NycqrPw/VRJ4Y3BSeviRNwuNwyjE1rrR5eDT
	Pj+swiSUaP7X6RAYWnJWekshd6TbY5IZ+U9qehMMbFtJzsrY243zXKr3jDR/Ne7N
	hcJeMHCZQtGTSOG10v8jD3k8Xotfl4Kzkz67j5Ee5KuLs6+VKjwu2+hKov9/IdUh
	/N18XJfauTNg/SbVpaXv+k8XgdBuRrOjcWkGkYg67DHd5hnbOA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49wrpx8m4j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 05:43:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VB2A+BwgsgzN9xFZvIREx7d5YEN/Kh5hfnOIJFdKDY8J1PUYdFUVTeNUNci77WJcvcLV2cTvfzvfkYBd6Zpzq6wyGQUE6+koMKklkR75uYg5o/rjTFHXSujlMlpsqXdwzAG6fPdrS7lkfccv4PhAnzxx5jPG1vTIxurxcnoMlVXY9yRm9o3Dirnd+2JyBN75LviyCKp9NyvXMH3EN9QUqhSl8uEbGMeK/RS1x30RjT5RK7aNGvH4zNlfe1KBXUpC4hOYZZetDpg9sUHs25fy5evNomB7JkgnZ4/0qdur6Kfj9nWeoeDeqiM5EInRb0vTNbaeawod7vAbYmBZNawiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+q4XxNcbFrFo1bT2HTx4qvhTijo06tJ0IH2kUdh/e4=;
 b=IMT6yMWHldZuk9xchebOM8a/Z04cYeo7X7v5X0ULRfVkr2OWP0jrVyxr+Q3ZBmT8snRuj8v0IL2nTETlbCxWDV13zZMudS+FGC4cR5tSlK23D+9WCwTzSdV85lBtSSO9Mwhc45X1+AcbvMxmVsZHMmVBCSLgxjUUkifpsUILYMZn2bRp2w9oYno2al4p3aJC6+RktgS12uB+SEKZI0ma/kkLQeaxeU23dbF5EiJCsftCJPzQy+ryy5u8SRUwel0TqQagRQ4O2BV+d7ZV2nFD7QQuwHDPuyvjbJ5536Q+qZPwqc2zdhmXmm+UaV/71YwtNQoJBVE8OInOodwR0ueLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 05:43:39 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%3]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 05:43:38 +0000
From: haixiao.yan.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] fail2ban: Adapt test output to Automake format for ptest compatibility
Date: Tue, 21 Oct 2025 13:43:22 +0800
Message-Id: <20251021054322.819911-1-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0312.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::19) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|SJ0PR11MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 60842ef7-82a7-4ab5-2f39-08de1064c8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zQFYA0mTC82Cg6HwCCw2EAi7m0Nyv1PtaZndfqau4sP9Z9FTrF0Li65AZxsY?=
 =?us-ascii?Q?2KOx5NIocCTSu0wCphD7hZA8ddtLHoMRYcYem0rzMr7V49u/npL3r80vIxbu?=
 =?us-ascii?Q?h+MghezyoH83YTrp+wQB0Om2SIcMZbSC5IsQaozdPcfa//Xr5u6asB3vYVT1?=
 =?us-ascii?Q?y10cwKisXZVmx4WzEq96AN8mvpfOdMft2LfzW/rkLNx4d9+yJ6akwNvI4xQT?=
 =?us-ascii?Q?cygsf/Lr8JzPMbDwnTXtVE5zR8nebdC1cZ4L/hejuSrczigLM2dMDIQUSyQX?=
 =?us-ascii?Q?l2co6e4bOiZlb7YtFtNNx5qv5z8Zxask6U/FSoobZh7LguTpP7zuZjPRNNQu?=
 =?us-ascii?Q?1f5wN0+sJaZ5fHnx4V9R38X3a5EgkuN6gbpxLFDfGxj5TLHYZfm8IsRXyR/V?=
 =?us-ascii?Q?n2rgrP582TGISorhYrkOX//fTa02T6Ze8LTzXaRfkNPPVgNzOgFvDBGSMtkS?=
 =?us-ascii?Q?ULxWoDaNtr3Ud8cJuayR8fglAAsc+vrnVHZInWNPYJVnAPAiIyvazva4qjDG?=
 =?us-ascii?Q?gEb92y7awtEBimMlYkDf8lorvXbdGj6adYlqAMNDwSpPUGdTA54DHA92iF/o?=
 =?us-ascii?Q?4yG3V/e4K0UJmkQrG4MVGllK91+8io6xIs1Agti9yfi4lIp+HHlSuCWLhxn7?=
 =?us-ascii?Q?sJoKPAmUGkrpuwb2m6dAwrgC0tYSqtk427xamozaCtZjllAG8NRbwRuk3HTJ?=
 =?us-ascii?Q?kAwfB1abYRP2NJdlGvuhcUyVEjeP2ujbabFPY5WkD355gbv3k8hg0p5N3QxV?=
 =?us-ascii?Q?/hKbBP/bskgoiwahBttkWktodxRfU07JoueOX0hte+iRqKEfrQuuLKiLFolh?=
 =?us-ascii?Q?8tgS/Tz4NQebfw5p5Mpa8lUxher0WuT0mqfv0OhQwmgwJd5gibkxXaNsERi2?=
 =?us-ascii?Q?1laby6syrjGev0WZQd1Ea/zDdKb1odi2kjUeOx4RCZYDY3iB+nJ+Qi3UjqS5?=
 =?us-ascii?Q?1hNottlmD3+FMnsnPS3dlzIrWOSc7sUbhul12KORU6zpWh/ytPuyKg+9blL6?=
 =?us-ascii?Q?a7khwd+Yi+E+JT7dMb3lD24g6tLjYFk1xdWu3vw/ZbFntIUEsDWHsww0SpVa?=
 =?us-ascii?Q?8Myun+t0/1P/0jbD/Zxd5cjZD4COmPjYRw00iYfHeykPnfDG3/dasTlEame/?=
 =?us-ascii?Q?k+V8JPZGoTLwGmcPm3gsIcXGYogbJC1srEN3XnQ3S3kZr5P0SA2nLqnpLYla?=
 =?us-ascii?Q?g5PUPkniFDAfKGW1Mo7AJ3w0p0jtgMxE2RGBZ1GR4HEDhvrlcLLFGK6RHNM6?=
 =?us-ascii?Q?5rFaOBv+ganfKN0NG6lElm/kTllw8Q8zcx7TXtm4v9TBzGqrsFlKJiVe4evw?=
 =?us-ascii?Q?9yGRPp/xunzMq3VXhPDSJQk8Kk0w4VfcngYH/kB/kdPPd1t0yNj7gT1bbInd?=
 =?us-ascii?Q?4lbjDCSkl8ho8KqSjAy5jUuLyGdcrmg/89zKRtn8fZNSBmjWNaKUTVhrK/0d?=
 =?us-ascii?Q?fX61lNLVkbhtl2z+u0cm0djva7AxyaWU1rFl7oB105A1jfHwErsCponi1aSE?=
 =?us-ascii?Q?kkANZvMEr5TfSUxipJFz/LNTKXxmSp5rRYPs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9NprAO6QpEu3ndtIDjHnCHKaVNJFlAanMwcyHpdfAvvrm1o2iPMdG0pTHZWk?=
 =?us-ascii?Q?ZNSb4HzOpgIz0Kdmcm4PV0ozbKVMkZEVk7VHknSWFc45eaWchZni9xvar/WP?=
 =?us-ascii?Q?6M9TzwZCKwy5nE+HpA1HnC16eA3+QFJIkmabX529Fic4I9AUn8IBOuodSwfy?=
 =?us-ascii?Q?BLDmwtqWu+LMWYI1VLJqw+w8ZK9BSe8K3GO7qVK/ifTpCaBj/0bZg5s2M2sr?=
 =?us-ascii?Q?BUZyDfhoGijC/MJqTirZ5Oo0VGNYtUCrgjE+bd92Y2nk8p87sF6N9OOWnEIj?=
 =?us-ascii?Q?AHPglc00bcBYGXXIYss8+mQAKK54JxPpbrKV1MlDzJzqtQW52FeSXdAC174l?=
 =?us-ascii?Q?O9L+9M5GpUIZCxz09fl5pg3fuYlEzYF1IOlAsDh7OAkO1GLTqxlJSmT8SYVV?=
 =?us-ascii?Q?s/pID2erxPiY3Odfs1nlUHsR+de8gx0/33LbiOIVXO3RlrVthmDJJKmk+yVr?=
 =?us-ascii?Q?uvxQMEQdCEujQ1rYxDoCaddJolpFHU4fgNguyF+yXiaIYUX/mRKBC/JsNhq7?=
 =?us-ascii?Q?pyHpP09VTptwbOpHlLw1w1W+Uzr+ML88TbpdnHz3Y6kXqC9zdrvkbDhn1grM?=
 =?us-ascii?Q?tHwn8uXKFctmT5AJruP3sDcCjVVeKrDlrM23HPPeVgH7k7t2Wrv7GDEur0he?=
 =?us-ascii?Q?4mlgRH/eiGoJLJRVo4SliiJ28w3HaNJDbJkJv+fvpAEekCEyhzZy2ovJdXmW?=
 =?us-ascii?Q?p1oDmhtMkiODU8OTKVgqzu+EFI1dGxqP8Q2j5qKlyHIfCmroKHW6aVO1zbop?=
 =?us-ascii?Q?kuVRmzmk2hof9AGOd7VgImY5QcieaHMFWCXbKCGlBk83zK4uLDcSkyibeG47?=
 =?us-ascii?Q?5sg7ThSnGzq0HiFQiaVHe6whhqXN/0p0wKm03NyGVE4wEtw8pVVCNFZUQKYO?=
 =?us-ascii?Q?S4oYEozYNAsvxoMrlmzoR06Ks612KQ+Wzwr4Z5ZY3ItetEt9hBNszd5VtORi?=
 =?us-ascii?Q?pig0uMw3+6++l1ykym//Bv4b0XcfWM2zfThhF3vIfvOPmqUxf1PJgJYwvEkl?=
 =?us-ascii?Q?1Bhdb01WuWHd5w7FS1O/ZjH+zWDKPmsuubs8TwvY0wLCRIf9YRCcjl4Fov4v?=
 =?us-ascii?Q?jLimKd9Mu+n2spMicKXTEPuIyfpl0GDF2SkD78FAnQWq+x1b8z3tu78ebmFf?=
 =?us-ascii?Q?r1becoS5NGgFOVagwF+Am0xb2qLNx65Qi3hWAsqJc19L3FFCwSwpZnRonBsB?=
 =?us-ascii?Q?IW7+im4astSMdLX0IQh2a+5C0/mtteDj7BHQxU1tC4dDbp7+hjVdH5y0YD+6?=
 =?us-ascii?Q?7+f4VYzxsuFLy7hYhnsFiEPZwyxA/Stj8re8XsCk8A/etNnAwJPLOgJmXPRW?=
 =?us-ascii?Q?qItJm2T/vvZrNUwTGvr5/8Zzigk7Qc4GotsWgOUqbJpV3FdDGPLYOgvWRf2T?=
 =?us-ascii?Q?IKlW4XVoTbXsU7wVSk3tapYPXKNe46oF1oZBViE+oVyQXMZR7UJXHatYbBDd?=
 =?us-ascii?Q?t7R8OSDIZm/6e2iOzf/MmHT7Z0gyO0wU8bT8iddXi2tOW9X8GmyIjshwwdjN?=
 =?us-ascii?Q?xtmFl04d0tkXXZAJ7jtNxm7RfjYbWYIELTzQWbWTuZywFvgL3TadXEsPLd2g?=
 =?us-ascii?Q?7lFAkriojV/SAUpRxLOl0sivZu6E8X/euaD8poLsEwA47zBq9W1sl6ybN6IO?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60842ef7-82a7-4ab5-2f39-08de1064c8d6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 05:43:38.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXvVCySaZTwrrTej2TmsEOcb96nL4n+7JT850MrwFP2X+mzaus9DBya+MLWITspJo3lJ+2POM0a1wvTS6sMCu6E0n/NOurGTcSuoRFJczcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4893
X-Authority-Analysis: v=2.4 cv=b9O/I9Gx c=1 sm=1 tr=0 ts=68f71d8e cx=c_pps
 a=eQn4vQZDn50HuGbH8T6KOA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=3d01TAmHAuPuTfK4mfwA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: WFG0_Gdcunlrn-PGGhp1vQIi_dWWctPW
X-Proofpoint-ORIG-GUID: WFG0_Gdcunlrn-PGGhp1vQIi_dWWctPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA0MyBTYWx0ZWRfX5aS0pVfYcc4s
 tjTVTkG4IM7tRdmCu0FN1TZ1Xa7jeSJkZZXHVryCfM2nHFewdc6E4tdkWwp4HJyADqMSDmWLmvH
 dLSVt2fCto7xZ5Gg4qOVAeiw+Pu905CoIepeiWy2gz+m1udfJbG4xaU4kLVabKTgnsM3pQMV1cF
 Vl39TbEpa8onY4/HIKg1ybi1XeOfdfvusrK249O/Vf8bjUAYV4cTMxnOJkor04GKoRXtiHA2mSY
 eR1HP/aDsaOszK0MV4KKpz693J2xOM6hELoTJTLQaPgxUMlrUqVWB2gyzAlWdgmwKlPykLgb2IP
 TXgmgjXY2SeUUOhSfwnm4wJyEv/Ogxx5Hkkbypfos73YotKcd2QeQ7LK/+nwaLFCHYpo3PV0ir8
 BHE+SQ2++taEAFvL4bzzB/p40njmfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510210043
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 05:43:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2375

From: Haixiao Yan <haixiao.yan.cn@windriver.com>

Convert fail2ban-testcases output to follow Automake-compatible format
(PASS:/FAIL:) so that ptest-runner can correctly parse and
report test results.

root@intel-x86-64:~# ptest-runner python3-fail2ban -t 300
START: ptest-runner
2025-09-22T07:57
BEGIN: /usr/lib64/python3-fail2ban/ptest
Fail2ban 1.1.1.dev1 test suite. Python 3.12.11 (main, Jun  3 2025, 15:41:47) [GCC 13.4.0]. Please wait...
I: Skipping smtp tests: No module named 'smtpd'
I: Skipping SSL smtp tests: No module named 'aiosmtpd'
PASS: fail2ban.tests.servertestcase.Transmitter.testAction
PASS: fail2ban.tests.servertestcase.Transmitter.testAddJail
PASS: fail2ban.tests.servertestcase.Transmitter.testDatabase
PASS: fail2ban.tests.servertestcase.Transmitter.testDatePattern
PASS: fail2ban.tests.servertestcase.Transmitter.testGetNOK
PASS: fail2ban.tests.servertestcase.Transmitter.testJailAttemptIP
PASS: fail2ban.tests.servertestcase.Transmitter.testJailBanIP
...
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testBanTimeIncr
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testFlushLogs
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testLogLevel
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testLogTarget
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testLogTargetSYSLOG
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testSyslogSocket
PASS: fail2ban.tests.servertestcase.TransmitterLogging.testSyslogSocketNOK

============================================================================
Testsuite summary
DURATION: 48
END: /usr/lib64/python3-fail2ban/ptest
2025-09-22T07:58
STOP: ptest-runner
TOTAL: 1 FAIL: 0

Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
 ...ao.unittest.TestRunner-for-ptest-out.patch | 43 +++++++++++++++++++
 .../fail2ban/python3-fail2ban_git.bb          |  9 +++-
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
new file mode 100644
index 000000000000..c6729cc1818e
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch
@@ -0,0 +1,43 @@
+From 7b42974b5bf20d9db8e788e9d6817004556d660d Mon Sep 17 00:00:00 2001
+From: Haixiao Yan <haixiao.yan.cn@windriver.com>
+Date: Fri, 19 Sep 2025 15:03:56 +0800
+Subject: [PATCH] fail2ban: use putao.unittest.TestRunner for ptest output
+
+Switch the test runner from unittest's default TextTestRunner to
+putao.unittest.TestRunner (provided by unittest-automake-output) so
+that results are reported in Automake-compatible PASS/FAIL format.
+This enables ptest-runner to correctly parse and summarize individual
+test results.
+
+Upstream-Status: Pending
+
+Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
+---
+ bin/fail2ban-testcases | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/bin/fail2ban-testcases b/bin/fail2ban-testcases
+index 48aae4b5ffdc..20db4a01a3d6 100755
+--- a/bin/fail2ban-testcases
++++ b/bin/fail2ban-testcases
+@@ -28,7 +28,7 @@ import logging
+ import os
+ import sys
+ import time
+-import unittest
++import putao.unittest
+ 
+ # Check if local fail2ban module exists, and use if it exists by
+ # modifying the path. This is done so that tests can be used in dev
+@@ -63,7 +63,7 @@ tests = gatherTests(regexps, opts)
+ #
+ # Run the tests
+ #
+-testRunner = unittest.TextTestRunner(verbosity=verbosity)
++testRunner = putao.unittest.TestRunner() 
+ 
+ tests_results = testRunner.run(tests)
+ 
+-- 
+2.34.1
+
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index c85953aef266..4238c9f59f82 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -13,6 +13,7 @@ DEPENDS = "python3-native"
 
 SRCREV = "2856092709470250dc299931bc748f112590059f"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
+           file://0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch \
            file://initd \
            file://run-ptest \
            "
@@ -67,6 +68,12 @@ INSANE_SKIP:${PN}:append = "already-stripped"
 RDEPENDS:${PN} = "${VIRTUAL-RUNTIME_base-utils-syslog} nftables python3-core python3-pyinotify"
 RDEPENDS:${PN} += "python3-sqlite3"
 RDEPENDS:${PN} += " python3-logging python3-fcntl python3-json"
-RDEPENDS:${PN}-ptest = "python3-core python3-io python3-modules python3-fail2ban"
+RDEPENDS:${PN}-ptest = " \
+    python3-core \
+    python3-io \
+    python3-modules \
+    python3-fail2ban \
+    python3-unittest-automake-output \
+    "
 
 RRECOMMENDS:${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'python3-systemd', '', d)}"
-- 
2.34.1


