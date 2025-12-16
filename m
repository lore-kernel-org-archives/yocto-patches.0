Return-Path: <Ruiqiang.Hao@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8896D5B161
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 05:36:52 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15275.1765863407340773628
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Dec 2025 21:36:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=S3G93IKX;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4445fc7214=ruiqiang.hao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG5K2AZ2913081;
	Mon, 15 Dec 2025 21:36:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=dP+0Lh43n8hB5cOaNjBv
	Vwi0t4pSyxNf35vbQjnT2GQ=; b=S3G93IKXaIAGUoxXrPrTvTeXwbFXtwlVgAT1
	E3H1dYeE8x6SQTTlU7qnXs2ICeDK5LDfm40uMPoFF33pgt96STv8mP+c35ljnuhg
	6YoAedegkfG+z2Sip60qc5Vi4DesE+/izVt5ej/V/zvhUcpvIIE2semdI6O9BB8z
	ugTOztzz0TX460AeG6SsI6OiHihEJ4FGezqQGN674N431cHwPEkqckQoePuqP+UT
	p0VHrw3v++y4RTNh4CStZOi3R+A3/Of0kTb4GeL5yzctszsAX24TS0brosGoH7HH
	xfMNIbNFzWBsaxmcKJ22rQslVhRtXCIu0rhcto/Xorcu0wEj5Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012053.outbound.protection.outlook.com [40.107.200.53])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4b18hmt9ay-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 15 Dec 2025 21:36:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqNe9s7iB8tlJ4ini61s0qQjkIFol7U7LN07hiShRC6BZDgTX0qVolQ6XbO7zNHpmemG3UTXIno71m090M/K/EfcNf7TwqQde9U3FrSdu8HUtXzalML1SbqQYNZh274XG7A+cFY1hqtbSc0nHeKE0FFaRpn5EEzNNO/2RvI8xahlDkqhExEWXdg1544+84BrsNocCy3UCSIOPaEAYSbPyIpw9tFGGoIBrSs8fQ9/2zU49wRILsj07XB7iN+uNT53tV3VwiyZ9acptPtehHEJ9zvFj2P+DYguHiKFpUnQNTnla22P5Y0F2A+7tmfI7kpdSglrVZKdNAx3+AVojgq/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP+0Lh43n8hB5cOaNjBvVwi0t4pSyxNf35vbQjnT2GQ=;
 b=wTFlGz8Cbjo2DhB8uC1QJZ0SQd52vAFf/h2+fRrbJc1YKSLXUkgONOIklHmyyUFQHSWE6S/hAB2D2QguWqUIb4HIQqlpSxrvRXnO4GvmXz2tl1h7UdvN0QzXh6bUbz1uyb2aGjDW6w/2EZaT+u0Q+tySN054wGFv7icDyQPFBY0bUjyY5aBfg+w8EJsHGAVOqOBqq7n8RivqHEMdonwH9bLZsfQdTAvTQIoFj26JJevnI2RVo82QQ9U7zo6OGUTZfWxrQRzaOUOwoeG8IRq7a0C+msxOzYeXA9JTyh+/mwAqGGwIP5L09xfLvzjBTKwO/nSSPMq88mdaSEzqO14J8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19)
 by PH7PR11MB6955.namprd11.prod.outlook.com (2603:10b6:510:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 05:36:42 +0000
Received: from SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a]) by SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 05:36:42 +0000
From: Ruiqiang Hao <ruiqiang.hao@windriver.com>
To: anuj.mittal@oss.qualcomm.com, yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH v2] dpdk: upgrade 23.11.1 -> 25.11.0
Date: Tue, 16 Dec 2025 13:36:30 +0800
Message-ID: <20251216053630.512423-1-ruiqiang.hao@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To SN7PR11MB8025.namprd11.prod.outlook.com
 (2603:10b6:806:2dc::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8025:EE_|PH7PR11MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c79cad-dd9d-40c5-1817-08de3c6517ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pOE0oWCZrd0wZunCCXraXVdxOuzWnsN/xajxNURN2EUQa3xVxX1S6SHgQgCg?=
 =?us-ascii?Q?LjlW17hRcBdjI2MLKLG+0fkl06PGCKRGyjZbDX/gvMn/mv0Nmoj/wN20rDOX?=
 =?us-ascii?Q?Db70ciy6VQ7GDbyjnxnq5v0zG/iacwNnsEo+EcaEiKZ9T8XkoI5Fib3N0Ru6?=
 =?us-ascii?Q?lDuZOv+zCNDw1DScBJ+cxijJ6kpt7iC+YZPz3Xr7JPQDLnAOHyzJMii0fQ/h?=
 =?us-ascii?Q?fwJzkrf7dQpJwwORD7gbXtfxVjqnaYk+mp8zeh92BwUwDKAge7LBj5Ho6+hX?=
 =?us-ascii?Q?WVZTY3e43/rucQIMXYSrDQkEU1rJAEQCbK12Ngh+eosnh1tvzNWZIFJvvtD7?=
 =?us-ascii?Q?gDdQltLfJeVAfR7rjNnK4LF8kIUMylgVqXrItRU3+2LaJ3AndcYcCQBduOLl?=
 =?us-ascii?Q?PYfP0dS/2H2kjtKBrpt7d6pgbZ5g7Hm2+Y492F7bS7URSXDdibkgZI/wFuPc?=
 =?us-ascii?Q?bDVAS66YlroQUG1YlH8PRnGw2oe1xDjezsK5c/2HbTqmynMO4QeiWkCiggnI?=
 =?us-ascii?Q?vA+fRgP9bvCm7iyXRp04U5Jz/m3J8UK2hpOWT1AnCA5ry2Vy9GI/mu2N2PLb?=
 =?us-ascii?Q?D1N8HaOdclaXtLj/SYr68LP1BijcWIQsXZpYrOfVGA9YjZQ9UB2WpC1VL9PL?=
 =?us-ascii?Q?R2Xk18UFKMoghTSTd+I0sLBBrQyk8TIDXZdrIxJgEJaNv8tfWNyVM0baeYWW?=
 =?us-ascii?Q?HhYl4LFSXLDB8v5hX/MKq1hBRtUVCgIF49JiEjEOsrZSEoXTL0NmH50bOUQ9?=
 =?us-ascii?Q?YzmYxru4BzAoGpTAQDWija5yCVF+Uj4719m1aWgYYKTrpNLMq6jDBcMtaUmF?=
 =?us-ascii?Q?3orRFN0/i9e0TqR+A6WgygDYpt46rC8nZLXozOOqmAE4eE21Y4/NYmHsXge4?=
 =?us-ascii?Q?vnc1LkF5htabjvSd6t7npWmQ5z1Lxuoz7WQMQgNiuQSzZuu46Cmf25w/DNUF?=
 =?us-ascii?Q?i598q/TBb58PDhm689YoXRHrEUCBrKXofkYZXeKRe1pOmIOqWfn4S1Q4xAYO?=
 =?us-ascii?Q?3/yc/KOPDU2CTkywaJm2pcKAW/+jlR1yQu1hlRUL8ZgxQX2Ze0HNXrSrGotg?=
 =?us-ascii?Q?o4r4qEixN5TNMoGMjRU+d7fWR/xmjJ+isWYZyR4FTqEFW+2br3ym6tOllLGZ?=
 =?us-ascii?Q?y8qZ3ctOF1gkZ3Z9nulyaYXrRfvCLAV6WLP+Ppu15v0UW8b+RlplLAW0X8MB?=
 =?us-ascii?Q?xsfQdiAxXxjO79Sq5DJpYwkb1Dikv0K3JgTJunX2iNj0Ee3NUen4IUfmW1Zh?=
 =?us-ascii?Q?gUwssH0Jahi8ZfHnisF8ZSlLiMUc5UOM08S4mji6f7xnKkWR2cHBzT1BXxF0?=
 =?us-ascii?Q?v5FQX+68KC6L5HcHsdWcfwTU8YhtMY34jvMPA/MebbYYpJ3x5lBCG/AEfWYw?=
 =?us-ascii?Q?+TEeC//rhlnvY3bmF1LZ8xrixHuIxWjWxnCa0HVYaXrQzDJPfh8R5mE54E4J?=
 =?us-ascii?Q?GGK1/WmOAjbxRlAdTfI23ZUIHBGk+/B6MBA4dWA6n8fC52Hu0qKfeA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8025.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Be2q3/nhPD3VK6OLCCh7gVwxE9ZThOKvGcYbOAkqGgj4SrR8jt9REQncnOA1?=
 =?us-ascii?Q?9rfDGnDhfex7O9mKCwvvbN9mQZWdtCJ9gYSfDawxG2xZEe7oY3foai5AQgg8?=
 =?us-ascii?Q?92mzW/DBSIel5qJ+lk4ppnnUrU/Lo0vWBWLxeO5DcuUnVm6DsJC7TUYcPwcc?=
 =?us-ascii?Q?WezXp/quOiU0F9ahh6lkBakLrGPLZ9yWn9DctHdNObN+p91xOmuj5NK/XDGI?=
 =?us-ascii?Q?1x6SYVYVY7TjDAfXYIp4FKli5dpgjT2mTdH5juwFqtJZR35CeDm1p7wmqd1Y?=
 =?us-ascii?Q?ts61pFr43dlyqgcVGkKNu6vbFzKoHVPy9IzDCb9wDARZD88WewKGCabYDzdK?=
 =?us-ascii?Q?JDi0Oglk3U5UBlouPI+U5hHm8tw9XrE9aHAP6/487I+S0Kw/ykAEO3tHkdCu?=
 =?us-ascii?Q?RyOZcsFOL6hlzCvWQetMON4tas+GH8prC/GsNKDenEWUUzcmh1pr6Ep6tEo3?=
 =?us-ascii?Q?IGApqNslSpN/drFr+a7xzqwtKdmYkCltcxCSwQWZ5VYG9WJ++3EYtF9hBFhu?=
 =?us-ascii?Q?2Ha9daG+oU3w28UtseD4wOSQioR0kl1lW+c4E8fv1/H8KDMrBc9TWOTY1gt5?=
 =?us-ascii?Q?EUu3hRiNVdieG0Ad09Y6GFvt0qmBXf8PGzm4IKGI00hVFg5SvzDl47K41CIb?=
 =?us-ascii?Q?AdVivg9AuarPQ0v76zWxqPmCFGo2vIpnL8YPQ74PP1daxy2XYZl6NXdOkSPr?=
 =?us-ascii?Q?eyfr/t8Zqh8XcgiwEaC8XC0bMAY6/1pFDv7PV8hXnlcCvLxrj5/xN6jC2cp1?=
 =?us-ascii?Q?ROw3EZBXroTa+tdLvBtY6jZyAP6L7Mx2kLJgrNvlhLEkFtoLYYW/on2uFN0w?=
 =?us-ascii?Q?PaiPNq2jsDn76uJbjNj6/BtH7b9XNchDIZaBvtc7mmAn/d3GWtAlHbiqiYv6?=
 =?us-ascii?Q?Wjr2ljQtDQGC0X5XO1OPch8BJEDtVLcWiyK89Gc6umDiKic6zGHX0P+/R5jh?=
 =?us-ascii?Q?l4LG/HU3JSO21ALSmBtmXl03G1nFMn+FF3lJa6eJCDeXJ+MuMrkoBSIXIOLR?=
 =?us-ascii?Q?YmVSfLd6Uw/fLoX6aJ1UXnuFtyMzJ/tTCyC/Ydy4xKB7XuKEMfA67u2+l5R5?=
 =?us-ascii?Q?x09mcQCkVUILXsgU49QxtHuRYYyPzOwYl9jHI9FauqQuztcGI38XXcQ6aqQb?=
 =?us-ascii?Q?Xac2eL6PDRm5L7/rYYWRoan6pm3XgAuxam1qlmU7IHYwhY5fV0FcrsXUR1Bd?=
 =?us-ascii?Q?Js753hIn7WexaqfpLHwBgGRxjzLF9OpucZPNz+9wGwPAqoSz1OScz32cLjkb?=
 =?us-ascii?Q?m+iRoNm04DMZIRvQaYUk+iLjwR/Jqsh9Dv/MeOerVKmsH39qouCE9ltIbDGl?=
 =?us-ascii?Q?XFASbf7otljI3+ChUCh5ACIVpQTDvVopKVlnuNSL0BDs0wJVgO8VVjMIpF0f?=
 =?us-ascii?Q?UvMcCPOdpILoVKR40keh/3B3/AEjLEqyC2hCidG8MxUYCNVwZyelwsyrEGL4?=
 =?us-ascii?Q?E5Mx3oEgzIKX6ECbfyLTwkoJO6WjTRtA7FbmV4NE4nplQP9pIQtLNbZiLGk3?=
 =?us-ascii?Q?GoI7PFOZ+vspFZkK+NmvUwuwWoaSLOB+AjlOMjDe6Cr9zESDj4ZTGcRgd9Ug?=
 =?us-ascii?Q?vzL9eUrzDD2FfcvwOLWkHFzlPcS8qXYlE93+m+nAYa4+sow7n1MDvG2fnO3N?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c79cad-dd9d-40c5-1817-08de3c6517ac
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8025.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 05:36:42.3572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqjLxuwatoxBwm4k1Fn0WVxHX25CVLmmUOgUr2ZyMusqfr78aVrZFYNeTiEj1XaUAfoRK9M3t/divmQJjBtLf4XQaguoe6MR4xECEcyfePw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6955
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA0NCBTYWx0ZWRfXyJNDUwwUbepP
 px4CVcVSQo9Ydg3lahSyA++ld7vmgPNYcZTnCWaBTzz+9jap1TAGPzDgC74SCCbp4jGq/GnIuQy
 wzqC7Wr/8Fb6f5CGL8lxE3GhRGmmQTnLBuEF0l5FA4xEyYk7vXqF+bYwqQumORQwYNfdg1vByxo
 cjnnJmWkt6e09Yp0LFWA94mJnH+lmJ4hxJFrQOYM08fMEfRJ5tH1Y+u1N7a6A31jDQAskrI6G8d
 jpTtorFd9jvi8UfGRAttDXR8UAFhHSAhQK7ntqXBeaJ53q7fxZXYC/djfKa/6qq2J+5ZSAaHfug
 D6nf8j4GEQ7r2rmS+gWKAnJJ2xkJnNUcwa2NtQ8j0Hy1K7wt58ucNCyxSRS7jf7WqaecHjYMKYA
 V32htDghE5YwZsqFGqcRrHTSA3Atkg==
X-Proofpoint-GUID: GuPpBwytFrm_k6F9Xka3jRP9iQfhCWHC
X-Proofpoint-ORIG-GUID: GuPpBwytFrm_k6F9Xka3jRP9iQfhCWHC
X-Authority-Analysis: v=2.4 cv=XMY9iAhE c=1 sm=1 tr=0 ts=6940efee cx=c_pps
 a=EGpQrqTzv4Kwq1gVXkqNKQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=t7CeM3EgAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=r2HGPOCozAU88W8aTVMA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160044
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 05:36:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2795

From: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>

Upgrade to DPDK 25.11 LTS release.

- Remove patches that are no longer needed in 25.11.0:
  * 0001-Add-new-tracepoint-function-for-type-time_t.patch
  * 0001-net-gve-base-fix-build-with-Fedora.patch
  * 0001-net-ionic-fix-build-with-Fedora.patch
- Update library path from pmds-24.0 to pmds-26.0
- Update SRCREV and branch references

Signed-off-by: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
---
 ...-tracepoint-function-for-type-time_t.patch | 114 ------------------
 ...1-net-gve-base-fix-build-with-Fedora.patch |  95 ---------------
 ...0001-net-ionic-fix-build-with-Fedora.patch |  65 ----------
 .../dpdk/{dpdk_23.11.1.bb => dpdk_25.11.0.bb} |  12 +-
 4 files changed, 5 insertions(+), 281 deletions(-)
 delete mode 100644 recipes-extended/dpdk/dpdk/0001-Add-new-tracepoint-function-for-type-time_t.patch
 delete mode 100644 recipes-extended/dpdk/dpdk/0001-net-gve-base-fix-build-with-Fedora.patch
 delete mode 100644 recipes-extended/dpdk/dpdk/0001-net-ionic-fix-build-with-Fedora.patch
 rename recipes-extended/dpdk/{dpdk_23.11.1.bb => dpdk_25.11.0.bb} (82%)

diff --git a/recipes-extended/dpdk/dpdk/0001-Add-new-tracepoint-function-for-type-time_t.patch b/recipes-extended/dpdk/dpdk/0001-Add-new-tracepoint-function-for-type-time_t.patch
deleted file mode 100644
index 56b4b43..0000000
--- a/recipes-extended/dpdk/dpdk/0001-Add-new-tracepoint-function-for-type-time_t.patch
+++ /dev/null
@@ -1,114 +0,0 @@
-From a97f93abc34731b73689c0c78bd189a91625779f Mon Sep 17 00:00:00 2001
-From: Changqing Li <changqing.li@windriver.com>
-Date: Tue, 29 Apr 2025 10:14:13 +0800
-Subject: [PATCH] Add new tracepoint function for type time_t
-
-To support Y2038 issue, for 32bit system, -D_TIME_BITS=64 is passed to
-gcc, struct timespec time->tv_sec is 64bit, but size_t is 32bits, so
-dpdk will compile failed with error:
-"../git/lib/ethdev/ethdev_trace.h: In function
-'rte_eth_trace_timesync_write_time':
-../git/lib/eal/include/rte_common.h:498:55: error: size of unnamed array
-is negative
-  498 | #define RTE_BUILD_BUG_ON(condition) ((void)sizeof(char[1 -
-      2*!!(condition)]))"
-
-Add a new tracepoint function for type time_t to fix this issue
-
-Upstream-Status: Submitted [https://patchwork.dpdk.org/project/dpdk/patch/20250527120404.2027529-1-changqing.li@windriver.com/]
-
-Signed-off-by: Changqing Li <changqing.li@windriver.com>
----
- lib/eal/common/eal_common_trace_ctf.c | 5 +++++
- lib/eal/include/rte_trace_point.h     | 4 ++++
- lib/ethdev/ethdev_trace.h             | 8 ++++----
- 3 files changed, 13 insertions(+), 4 deletions(-)
-
-diff --git a/lib/eal/common/eal_common_trace_ctf.c b/lib/eal/common/eal_common_trace_ctf.c
-index 04c4f71..055555e 100644
---- a/lib/eal/common/eal_common_trace_ctf.c
-+++ b/lib/eal/common/eal_common_trace_ctf.c
-@@ -88,6 +88,11 @@ meta_data_type_emit(char **meta, int *offset)
- 		"typealias integer {size = 64; base = x;} := size_t;\n"
- #else
- 		"typealias integer {size = 32; base = x;} := size_t;\n"
-+#endif
-+#if defined(_TIME_BITS) && _TIME_BITS == 64
-+		"typealias integer {size = 64; base = x;} := time_t;\n"
-+#else
-+		"typealias integer {size = 32; base = x;} := time_t;\n"
- #endif
- 		"typealias floating_point {\n"
- 		"    exp_dig = 8;\n"
-diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
-index 41e2a7f..d05422c 100644
---- a/lib/eal/include/rte_trace_point.h
-+++ b/lib/eal/include/rte_trace_point.h
-@@ -22,6 +22,7 @@ extern "C" {
- 
- #include <stdbool.h>
- #include <stdio.h>
-+#include <time.h>
- 
- #include <rte_branch_prediction.h>
- #include <rte_common.h>
-@@ -145,6 +146,8 @@ _tp _args \
- #define rte_trace_point_emit_ptr(val)
- /** Tracepoint function payload for string datatype */
- #define rte_trace_point_emit_string(val)
-+/** Tracepoint function payload for time_t datatype */
-+#define rte_trace_point_emit_time_t(val)
- /**
-  * Tracepoint function to capture a blob.
-  *
-@@ -429,6 +432,7 @@ do { \
- #define rte_trace_point_emit_float(in) __rte_trace_point_emit(in, float)
- #define rte_trace_point_emit_double(in) __rte_trace_point_emit(in, double)
- #define rte_trace_point_emit_ptr(in) __rte_trace_point_emit(in, uintptr_t)
-+#define rte_trace_point_emit_time_t(in) __rte_trace_point_emit(in, time_t)
- 
- #endif /* __DOXYGEN__ */
- 
-diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
-index 1b1ae0c..1d0dabb 100644
---- a/lib/ethdev/ethdev_trace.h
-+++ b/lib/ethdev/ethdev_trace.h
-@@ -1129,7 +1129,7 @@ RTE_TRACE_POINT(
- 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
- 		int ret),
- 	rte_trace_point_emit_u16(port_id);
--	rte_trace_point_emit_size_t(time->tv_sec);
-+	rte_trace_point_emit_time_t(time->tv_sec);
- 	rte_trace_point_emit_long(time->tv_nsec);
- 	rte_trace_point_emit_int(ret);
- )
-@@ -2146,7 +2146,7 @@ RTE_TRACE_POINT_FP(
- 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
- 		uint32_t flags, int ret),
- 	rte_trace_point_emit_u16(port_id);
--	rte_trace_point_emit_size_t(timestamp->tv_sec);
-+	rte_trace_point_emit_time_t(timestamp->tv_sec);
- 	rte_trace_point_emit_long(timestamp->tv_nsec);
- 	rte_trace_point_emit_u32(flags);
- 	rte_trace_point_emit_int(ret);
-@@ -2158,7 +2158,7 @@ RTE_TRACE_POINT_FP(
- 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *timestamp,
- 		int ret),
- 	rte_trace_point_emit_u16(port_id);
--	rte_trace_point_emit_size_t(timestamp->tv_sec);
-+	rte_trace_point_emit_time_t(timestamp->tv_sec);
- 	rte_trace_point_emit_long(timestamp->tv_nsec);
- 	rte_trace_point_emit_int(ret);
- )
-@@ -2169,7 +2169,7 @@ RTE_TRACE_POINT_FP(
- 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
- 		int ret),
- 	rte_trace_point_emit_u16(port_id);
--	rte_trace_point_emit_size_t(time->tv_sec);
-+	rte_trace_point_emit_time_t(time->tv_sec);
- 	rte_trace_point_emit_long(time->tv_nsec);
- 	rte_trace_point_emit_int(ret);
- )
--- 
-2.34.1
-
diff --git a/recipes-extended/dpdk/dpdk/0001-net-gve-base-fix-build-with-Fedora.patch b/recipes-extended/dpdk/dpdk/0001-net-gve-base-fix-build-with-Fedora.patch
deleted file mode 100644
index 05efc3f..0000000
--- a/recipes-extended/dpdk/dpdk/0001-net-gve-base-fix-build-with-Fedora.patch
+++ /dev/null
@@ -1,95 +0,0 @@
-From f0d9e787747dda0715654da9f0501f54fe105868 Mon Sep 17 00:00:00 2001
-From: Joshua Washington <joshwash@google.com>
-Date: Thu, 17 Oct 2024 16:42:33 -0700
-Subject: net/gve/base: fix build with Fedora Rawhide
-
-Currently, a number of integer types are typedef'd to their corresponding
-userspace or RTE values. This can be problematic if these types are
-already defined somewhere else, as it would cause type collisions.
-This patch changes the typedefs to #define macros which are only defined
-if the types are not defined already.
-
-Note: this was reported by OBS CI on 2024/10/17, when compiling DPDK
-in Fedora Rawhide.
-
-Fixes: c9ba2caf6302 ("net/gve/base: add OS-specific implementation")
-Fixes: abf1242fbb84 ("net/gve: add struct members and typedefs for DQO")
-Cc: stable@dpdk.org
-
-Upstream-Status: Backport [https://git.dpdk.org/dpdk/commit/?id=f0d9e787747dda0715654da9f0501f54fe105868]
-
-Reported-by: David Marchand <david.marchand@redhat.com>
-Signed-off-by: Joshua Washington <joshwash@google.com>
-Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
----
- drivers/net/gve/base/gve_osdep.h | 48 ++++++++++++++++++++++++++++++----------
- 1 file changed, 36 insertions(+), 12 deletions(-)
-
-(limited to 'drivers/net/gve/base/gve_osdep.h')
-
-diff --git a/drivers/net/gve/base/gve_osdep.h b/drivers/net/gve/base/gve_osdep.h
-index c0ee0d567c..64181cebd6 100644
---- a/drivers/net/gve/base/gve_osdep.h
-+++ b/drivers/net/gve/base/gve_osdep.h
-@@ -29,22 +29,46 @@
- #include <sys/utsname.h>
- #endif
- 
--typedef uint8_t u8;
--typedef uint16_t u16;
--typedef uint32_t u32;
--typedef uint64_t u64;
-+#ifndef u8
-+#define u8 uint8_t
-+#endif
-+#ifndef u16
-+#define u16 uint16_t
-+#endif
-+#ifndef u32
-+#define u32 uint32_t
-+#endif
-+#ifndef u64
-+#define u64 uint64_t
-+#endif
- 
--typedef rte_be16_t __sum16;
-+#ifndef __sum16
-+#define __sum16 rte_be16_t
-+#endif
- 
--typedef rte_be16_t __be16;
--typedef rte_be32_t __be32;
--typedef rte_be64_t __be64;
-+#ifndef __be16
-+#define __be16 rte_be16_t
-+#endif
-+#ifndef __be32
-+#define __be32 rte_be32_t
-+#endif
-+#ifndef __be64
-+#define __be64 rte_be64_t
-+#endif
- 
--typedef rte_le16_t __le16;
--typedef rte_le32_t __le32;
--typedef rte_le64_t __le64;
-+#ifndef __le16
-+#define __le16 rte_le16_t
-+#endif
-+#ifndef __le32
-+#define __le32 rte_le32_t
-+#endif
-+#ifndef __le64
-+#define __le64 rte_le64_t
-+#endif
- 
--typedef rte_iova_t dma_addr_t;
-+#ifndef dma_addr_t
-+#define dma_addr_t rte_iova_t
-+#endif
- 
- #define ETH_MIN_MTU	RTE_ETHER_MIN_MTU
- #define ETH_ALEN	RTE_ETHER_ADDR_LEN
--- 
-cgit v1.2.3
-
diff --git a/recipes-extended/dpdk/dpdk/0001-net-ionic-fix-build-with-Fedora.patch b/recipes-extended/dpdk/dpdk/0001-net-ionic-fix-build-with-Fedora.patch
deleted file mode 100644
index ce9a762..0000000
--- a/recipes-extended/dpdk/dpdk/0001-net-ionic-fix-build-with-Fedora.patch
+++ /dev/null
@@ -1,65 +0,0 @@
-From 45d48356e552d661885e1c29613891c11cd8ff4a Mon Sep 17 00:00:00 2001
-From: Timothy Redaelli <tredaelli@redhat.com>
-Date: Thu, 24 Oct 2024 11:30:06 +0200
-Subject: net/ionic: fix build with Fedora Rawhide
-
-Currently, a number of integer types are typedef'd to their corresponding
-userspace or RTE values. This can be problematic if these types are
-already defined somewhere else, as it would cause type collisions.
-This patch changes the typedefs to #define macros which are only defined
-if the types are not defined already.
-
-Fixes: 5ef518098ec6 ("net/ionic: register and initialize adapter")
-
-Upstream-Status: Backport [https://git.dpdk.org/dpdk-stable/patch/?id=45d48356e552d661885e1c29613891c11cd8ff4a]
-
-Signed-off-by: Timothy Redaelli <tredaelli@redhat.com>
-Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
----
- drivers/net/ionic/ionic_osdep.h | 30 ++++++++++++++++++++++--------
- 1 file changed, 22 insertions(+), 8 deletions(-)
-
-diff --git a/drivers/net/ionic/ionic_osdep.h b/drivers/net/ionic/ionic_osdep.h
-index 68f767b920..97188dfd59 100644
---- a/drivers/net/ionic/ionic_osdep.h
-+++ b/drivers/net/ionic/ionic_osdep.h
-@@ -30,14 +30,28 @@
- 
- #define __iomem
- 
--typedef uint8_t	 u8;
--typedef uint16_t u16;
--typedef uint32_t u32;
--typedef uint64_t u64;
--
--typedef uint16_t __le16;
--typedef uint32_t __le32;
--typedef uint64_t __le64;
-+#ifndef u8
-+#define u8 uint8_t
-+#endif
-+#ifndef u16
-+#define u16 uint16_t
-+#endif
-+#ifndef u32
-+#define u32 uint32_t
-+#endif
-+#ifndef u64
-+#define u64 uint64_t
-+#endif
-+
-+#ifndef __le16
-+#define __le16 rte_le16_t
-+#endif
-+#ifndef __le32
-+#define __le32 rte_le32_t
-+#endif
-+#ifndef __le64
-+#define __le64 rte_le64_t
-+#endif
- 
- #define ioread8(reg)		rte_read8(reg)
- #define ioread32(reg)		rte_read32(rte_le_to_cpu_32(reg))
--- 
-cgit v1.2.3
-
diff --git a/recipes-extended/dpdk/dpdk_23.11.1.bb b/recipes-extended/dpdk/dpdk_25.11.0.bb
similarity index 82%
rename from recipes-extended/dpdk/dpdk_23.11.1.bb
rename to recipes-extended/dpdk/dpdk_25.11.0.bb
index b5aab21..eb3a0d4 100644
--- a/recipes-extended/dpdk/dpdk_23.11.1.bb
+++ b/recipes-extended/dpdk/dpdk_25.11.0.bb
@@ -1,13 +1,11 @@
 include dpdk.inc
 
-SRC_URI += " file://0001-config-meson-get-cpu_instruction_set-from-meson-opti.patch \
-             file://0001-net-ionic-fix-build-with-Fedora.patch \
-             file://0001-net-gve-base-fix-build-with-Fedora.patch \
-             file://0001-Add-new-tracepoint-function-for-type-time_t.patch"
+SRC_URI += " file://0001-config-meson-get-cpu_instruction_set-from-meson-opti.patch"
 
 STABLE = "-stable"
-BRANCH = "23.11"
-SRCREV = "a6ec5765cf83d3d58cbd6d4ed5b92b4a06f8a808"
+BRANCH = "v25.11"
+SRCREV = "ed957165eadbe60a47d5ec223578cdd1c13d0bd9"
+S = "${WORKDIR}/git"
 
 def get_cpu_instruction_set(bb, d):
     import re
@@ -55,7 +53,7 @@ PACKAGES =+ "${PN}-examples ${PN}-tools"
 FILES:${PN} += " ${bindir}/dpdk-testpmd \
 		 ${bindir}/dpdk-proc-info \
 		 ${libdir}/*.so* \
-		 ${libdir}/dpdk/pmds-24.0/*.so* \
+		 ${libdir}/dpdk/pmds-26.0/*.so* \
 		 "
 FILES:${PN}-examples = " \
 	${prefix}/share/dpdk/examples/* \
-- 
2.46.2


