Return-Path: <Haixiao.Yan.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7485CCD1AB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 02:06:19 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.4555.1761098775834764134
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Oct 2025 19:06:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=grZeqXSL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=2390f65e28=haixiao.yan.cn@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M1x5LS2299378
	for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 02:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=+2wPtUpWvPDxcXpa+MGv0AWuMydXnthiqajJAM8lysU=; b=grZeqXSLB2Pt
	W+HbU2GF3CFuuNnb0DIE+GaFFU+LNj0RnJvFdzxiurMeQ5rTEjSjRDRrSn09PCCi
	4M006Z7uyi6czfDQ8eF9edMt1cFRzvYq/xAsmgV++/ow40rxj69cPjwsepHZlEX7
	B8qx4GXDo5g2NKg7xwxch1Sr2UuMObsIRTGWP4bQ5c1muYADUsiodFRvdSiA6GDJ
	L1wUJ/E90Ytx/8Z6/YrtD1DzhMpovM3z40RTeaWkqW6Iw0bncMFFNpAp7IJDyrH4
	ofxLaiYFbDBfbQ2hT6lRyikuBsjHPzBFoZ4YUHHA+9cP1Va19lbdbJ3vJ2+Xhoat
	xz7Y/AW39A==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49wrpx9wkd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 02:06:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O623iI3sOT5/AMcqE3cW70AN27/eZbiEHYdGqqbZUTlIjAe5S8d/HCO0MkrAQ5bUQ8Ee975uhhjpS/vmjxkrxS+5HQT6xw1yY3gaSlTCwGORf5C5Td8LjkSSMnP4kKkhEPwr80G87kJ4UnZSeuDyoZDCGPQ6Gzb6gWCfOyWo6qrVMj50FDFNJ6Dmap5EpSNdIbA8KcpsV8PwwLdEh6l0nNXBYh8se5vKLg6oAaLkWgeZhokbmwhjt7iSPD5y/MxbFDiSWFBnqbmOfRYpnMLZclpS4JiYzIe2xZiCNhgWtrIPYnmV/Kkr7ddHBsBLepqFur4v2Rs286dZb9v0H/EYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2wPtUpWvPDxcXpa+MGv0AWuMydXnthiqajJAM8lysU=;
 b=t12C7InhNtjE7/HqYNzIHpCehOtOAaTvAlwHHkXyepC1f+fMgIFV4tiDNfTqL8VUMAFL36IL8BTT4bLhxo0GTD/L17p5bQl6MYPB8Ned/N4RsjVPw5VGyuW/eidqYsljQttlDp3Jb9lxpbnX1tX9kV7d2fIgUJvws7wE+P16WZdsSwJEWhnyPpns/Hs/mOmg6Lpp492f6R/ZIW1ieDhFpfsUOVdYvs+g+8fBsqLVco5EcWIlu33MuCSt2fJqkw6eaw7n88xgqIVTeoqG551DBzQ9eJhu183beZT4sWVrd4TL8i5m0uawO+ssbb3DexRUjU22wRjgrZf8UdOaVx4euA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 02:06:12 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::b6d:5228:91bf:469e%4]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 02:06:12 +0000
From: haixiao.yan.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][walnascar][PATCH 3/3] fail2ban: Adapt test output to Automake format for ptest compatibility
Date: Wed, 22 Oct 2025 10:05:48 +0800
Message-Id: <20251022020548.3644179-3-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022020548.3644179-1-haixiao.yan.cn@windriver.com>
References: <20251022020548.3644179-1-haixiao.yan.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0135.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::19) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: b9366bb2-91f5-4632-5a6a-08de110f931e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vtYXf2WekG4IU3uilIRC+FJJ9f/tQzxRz2HDx7ulYYxwk1x4dE79GXI5er+p?=
 =?us-ascii?Q?fGh1vEUNGdRkd1gt2u5UryKCsbdaw+TZ1FiIhjn9+SqUni+O/DM8fOGKIEnQ?=
 =?us-ascii?Q?Vyf2JHuh6LxiRPB50bZpbtA13WxtnBipRj+33patbgHwbs36qLiSoYWahT/+?=
 =?us-ascii?Q?qZ5oaacvu81Ce1iNP6Bew3FCTt4skXg/JGWeyUOmfDIbQ3yDIDXiK760MASE?=
 =?us-ascii?Q?uP/TlOVdk/IxN38jKx7+efxkLCq6PfMqyfHYSkAzjssS++QpK09QpZ3QjIHT?=
 =?us-ascii?Q?IJSG82R+31Q/VIvysP4+qvp8Qggn7xLUMQ83xnFVVBSGmeHLEBZy4mPS512n?=
 =?us-ascii?Q?4+pMBtC9j6f0q+RFnla75S3K+wbwXvUchFZ1ITzsivq6iJXryB/3r5a8cP/i?=
 =?us-ascii?Q?lFUatXBodV4nxN84Sm7oT9wvzvX4vjRDhEfIxhxou9aWvHOz9yJs7U7RsU4f?=
 =?us-ascii?Q?oW1wxA5AXBle3IKldm8JIk5VGBgx7UzdzbLPFXk8+yvkmerNDqkIdpH2rc6+?=
 =?us-ascii?Q?Xq38EqGK0X83SCREGjydUYfQnog8QLFFBhNuDwmHz0ZOrvOnLvHjUeBmlgMG?=
 =?us-ascii?Q?ZR3E8ccj18H/z1UPzfsJGdF574s9R9aEeeuz/2JDi9jdKmKGqYGI1ytHtJfO?=
 =?us-ascii?Q?uFcuu4IQZgCNt9UKOWy57sjDXZ1wxd9BW4Ff+JElxk0sRrpzdJ6ky0h8a7fO?=
 =?us-ascii?Q?b+kEHAXbc6qc62rHGYD1yVGLMr+Wt1Yk4w4YSs8WwmvpPUiiDV3v2xPReHnL?=
 =?us-ascii?Q?T6V9Ti/PFoWGfZUZE3mTI0BHScM6tdTT57XLI3I7gtEOjf1vIG8upNnQFoJc?=
 =?us-ascii?Q?pdG5iRVVv64HDBArT3U/28zQa2q0GEmS4ZehkL8dr9DVhRN6R1E7NK46auK+?=
 =?us-ascii?Q?war2AEFPCtHIpSi4Wagv++UzjltCB9dNrLaBzKguHEdH8wGjUNQ3bnqRlo15?=
 =?us-ascii?Q?Ej8Fh6rf5WgQvhpijRveAktK2uLbztGoeN9rxuJm+iBy+ea6Zv3YAILjH6Mw?=
 =?us-ascii?Q?G1b8c+vw8I5+RqtdvZ99UBOZYrpEiXnSLLC9wrhV2HBQT6jNbWf6x+AwQEJn?=
 =?us-ascii?Q?u0AyZ6MYEVEsl61W4XY4UrGU67QqmyC70NmLbDamY2FIZ2j+Bm+8dD3+XxPS?=
 =?us-ascii?Q?+KRcZywmKk2T6BiyrFwNyS+7C7dYw9yPKLJT5Wk1j/DS2pupB+kl29Ks/Njg?=
 =?us-ascii?Q?ZWg6UhN0yPDCMzRtUQPXE9nhGNo5Nrv91PanRSbScvTK/TedNGEKjUJG7Ep0?=
 =?us-ascii?Q?MjBYb3i/a7BoxtoEWUGdR1e4NWruNYsAuije2gMcbtM4JTSaQLHt6TmfgtVF?=
 =?us-ascii?Q?qmL/VlOc30Fjh9Rtvz45VmGOCYN7xagxBgBfBvGpAuTEf2n/4QSR1dyR1iro?=
 =?us-ascii?Q?8EEGjy4uQ9wlZodasGCWnW41gAHW1eIs1bd8ncYcK2clS33Hhi12FbOZ2+oW?=
 =?us-ascii?Q?V/uTDo9t5tKHZ3QOfUU5Xc3xKVlHhB0tqXrw4fMgAW/7ij1GeaDym609aXdX?=
 =?us-ascii?Q?uAGcGPRC2pkfq7PrkAA8XRbUQKg50GBvbIbq?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vnYLsA1cZTG4Pb0WrtUiduCe7o4AXPUw4clOCTf8G9f8mHMvNnK0htD44FKm?=
 =?us-ascii?Q?4Tp4tXHYTrbugzJi5h/ki50tJmCnoYK9NnIRs6LfPlkGRkeSDNXKpq0bENBM?=
 =?us-ascii?Q?pY7+3EmfV9TJHlP3PEPQFndyDMZp2HnTdDqMB5rq/ZEVIzKIlCz4+p+MPGBN?=
 =?us-ascii?Q?0liOaa4GbBQAkF3xBLG7I1Sqbw0bJ6n+iTgNsTMZoS7uG17kfw/7NV+hiZyR?=
 =?us-ascii?Q?F27jiaDTBow5SXM82ldC3RkLBUgst4BeAgeBBtwvDIlDGJ9XMUpR2ewVqxpb?=
 =?us-ascii?Q?5boTFPV0kXDbx+/T1MtpnLD7ieAT42cEDG1Y5J+cQTWlyFcjpZuNpIBZWzjV?=
 =?us-ascii?Q?Mkx1G4LCygykNJdlRVV0kZIq9yud6hNIZl9kL3akcQPoT2AVXiBPWzKPDRGX?=
 =?us-ascii?Q?i2HXgMWYCZkjNP0U/39wS0w7SVbAY9fo9iB6FZ016gbyRbaU66AMIO1rsAlK?=
 =?us-ascii?Q?Rga0CBJnmnDReDmktTvUxndOqZ+J+fqtqQMFdQNgPWMHbJ4CBL9Z1NIbt1kQ?=
 =?us-ascii?Q?bTxXzAkSlQw0y7KH0VVx+ITqgN7rarx9R3AGXYV+shPhTDn1/1B9jb2w5qIY?=
 =?us-ascii?Q?BblaB/kPD5G2FWB1juUvZSB4vplSLCY8mTUYklbxIX9Diq82mwX1r8TOxU97?=
 =?us-ascii?Q?ahRHR+ZzmQepDP0zraIWvdNivrD/0OHzjHIL/rvnzRkCthsfONRzBdeqwnN1?=
 =?us-ascii?Q?fqBA6sQLyrShiVWN1Myyt9SZO+e7TZCljQwfRoICcqsrGsqg4Rs2VnKyNOhg?=
 =?us-ascii?Q?/UHrMYwV5KRXmLD01XvHH3DHes55JmjxynRvlsziBNUuzyU2OFlRIB6zdZiT?=
 =?us-ascii?Q?BXjlcBu/aQ06QpOHoRTNi4TTPeSUlBvDG3UXa1AAAgt7N5IX9/VQlyIqS25O?=
 =?us-ascii?Q?xHCnA89oSPbS0kN9i/veDCXrZ7Llz6MNCbx12anHrGfXUckz0duRVVeP2P1r?=
 =?us-ascii?Q?lLpprLSbcCvqnAy1khQQg4BVh5rL1kA6SfAFwZ09hKmGNqhpbfTQv3qUpGA2?=
 =?us-ascii?Q?qbiKHiRMlJj8bW+ECYcBogFv+rgdp/eXbk0LsyY5FuUpOR4VAjg8jcLeT0S0?=
 =?us-ascii?Q?rp8gLedISl8qySRW30xKwPcbB7lT9YAJhWylCOWaRYzxQQ7InulC7lb0a+K8?=
 =?us-ascii?Q?8TYChAX9pisvJRTKcEYfW+hJ4RiEkOx0QE0Slbr45moSuB1tbwyA3ADq2F8X?=
 =?us-ascii?Q?mKhoUWfMS4qv7O7AUVRPBFSkPYTscarLfsWi8DZo4YbSq+93BvZ23KQwDG4c?=
 =?us-ascii?Q?+kWkavISv1lHwkKjqijI9z1BpNMHX1yOUxwQgeEbs/py1hiK4MGgzbvUqOec?=
 =?us-ascii?Q?SjCModhdeClYP4qIuRkV+h5wTftsykn2yKJmDXb2kIHpNxtxvLmlZa0tAHiK?=
 =?us-ascii?Q?3QJYVuo80sZLSvzAtGLCtzZTitvW0leGfGT9glGMzvFjZn4j0z4Qg6YFw9K0?=
 =?us-ascii?Q?OWn2sGDNdQVCln7cyz5K+MJzso+eyGBs8QbeR6xl1xWzMnlIeu3qT7bco4N7?=
 =?us-ascii?Q?05EBAEKdDS+zk+tH9GIdXapKUgOVm98a44yeVuc6/6ni9DBfsebMDFrXGTav?=
 =?us-ascii?Q?C9qhjUptPoQ+7KfU5a5g36KWVgN/c+5aBglAOLu0ECtxxVBe/EaPxlZkW1Qo?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9366bb2-91f5-4632-5a6a-08de110f931e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 02:06:12.5599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ctVn9uYpU/PvwvSa0oMlwmBWDXz4+J8OM2WMHQKVBsOFSDVvRTRBzMlZ1d2iOXf/qhP8zDDTFjkmJp00i4JWmCl/AKsBVWgXhNCBQ1O0+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-Authority-Analysis: v=2.4 cv=b9O/I9Gx c=1 sm=1 tr=0 ts=68f83c16 cx=c_pps
 a=lEAAG6kgDLZw1ps4cEx4qA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=3d01TAmHAuPuTfK4mfwA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: aQ6Fy4U-NTb-yyivYM4ybvDH94zYWTAq
X-Proofpoint-ORIG-GUID: aQ6Fy4U-NTb-yyivYM4ybvDH94zYWTAq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDAxNiBTYWx0ZWRfX4dOhTlE2pYpX
 xx1U2t/12x8s6Vns7DhTayqEgxLS/vwJa8i6a06hzTCturw/8Kl56YXZVkvQgoLHsNFA98VnTms
 UUxJ/l5Q1mbVF8m/V3DnCnqdAEnBt7AhzTkBGEoPBFhiFLVs/mhOOO71bE7KKdZ0G9rxFNcekjx
 OYC7tzWa+p/2uK82EC4Suzr48sj15q73/xomcErBnvwGRjlSeNyXBxW4BdvEkJEjDGNTJLOIUlq
 UrDZDVA1TVeRMjflWpPPzcCIWA4DWG0XUwNgHcjy72Pjg0BjGKxxM0bd6ybLjQO8AEQ88MqUyi4
 Sc3GUTX01zvIGmnf5bonnSTkAxOBzlVoutfgnli8trouca535dLOiHf21fLHXYeW4FEZlKjdUD1
 eKso1qavjmON4mHhqp0VQviDMG6fiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510220016
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 02:06:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2381

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
index 98f581ba8074..0cac7abcb73d 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -13,6 +13,7 @@ DEPENDS = "python3-native"
 
 SRCREV = "2856092709470250dc299931bc748f112590059f"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
+           file://0001-fail2ban-use-putao.unittest.TestRunner-for-ptest-out.patch \
            file://initd \
            file://run-ptest \
            "
@@ -69,6 +70,12 @@ INSANE_SKIP:${PN}:append = "already-stripped"
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


