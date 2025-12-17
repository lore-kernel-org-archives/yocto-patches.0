Return-Path: <Ruiqiang.Hao@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BA5D64079
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 05:51:34 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8040.1765950684018788163
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Dec 2025 21:51:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=QGq/8P4X;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=444693418e=ruiqiang.hao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH4AuNm2367653;
	Wed, 17 Dec 2025 05:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=Na+RT6mgr9Mo/AapFz+1
	btH0hd28FTCsY4jR+/UnBGw=; b=QGq/8P4XbVla8JI50RSAgFhuIZcwwm2E2iaX
	6kNpsIA7y4BNGiNCcyGjMY3kj6b4otxlfDuZ//qIwJNYVEo9adayk6496OWEnfS3
	uOD3Kk7zvl2weCi1fYtGoac7CN+FVmmphDTgRIsBWOPwySYYjN8T39qifkNzy5aF
	eWnEECVB0eRtR2F/zvPx6wYeVyUI0dPkVhoHnlVtDmIhaHEUVOyp5+Aa2HVdNVkJ
	BnB1gIe/7T2E4RgFgRTAtnRtsrZTe3pwsl+XTlILcvmtlwT+grYp5a7p/zySx0ar
	xBM7bibxycKt6WetRtJfTaMsXhtrgiz2SqZnjkTNsPRQXxMQtg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4b3k0br5s7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 05:51:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLpvV1MH9M101YLVJ86upO7UlsVw+S63uBbZWKikkX3evg1+Dm+d6XxaTRcnCyfnvRUXg1P0sTGVgKN+A8jUabR2lNm40D2eNDP0/ULfSUEuG9NFoSWM2Uq7ibIyOR0+B4K5O/Hd1JLKLFzRwwUxdLa3r/a51/845gRO5jTcCKZ3vU1Y1ZtYwueSWJKx618j8UUvl1yhQG8/TUEWAus9b0F/9CMHxf3f/7kJnIShF1lvnXj3cmWNoGpXSsxzeoSHE3i9vwzX33PZvo05sNQrk66RDnW02BzZBO8w40YC/rMttCOE9u5OLGNwDNuKe1IOei204hgdmvhlBrHG3oyLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Na+RT6mgr9Mo/AapFz+1btH0hd28FTCsY4jR+/UnBGw=;
 b=G1YWnP14cX9wI4gy/drqFaV/hEXgH0ebi0kH0L5QZr7yofov6eghAMlVzOqJx9ih5g+t/CDikzrFp9RDvtr2U3Dkks3OCGK97Pgr1IrqSlbf3GVu83snz8KaPNB+rrr3MYC3joetbu3dyRz09Q4vvvRaQKAlAx888x04V24DP4HZgZeJ0zZ6SeKtIevXk3zN0mG/du6DMyqMBvafoMv0EsLcLTspX6alaQyQf/Ux9yCCZtmIbN9e4w83AbiicEOl6wbxBBUMRem5//nWk6DsPVEqTSoeFmA5gpV0tbWlW8WTGg90sjXqApnLHefPR6xc0iuvM5g3HM6IDsV1xz9G5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19)
 by CH8PR11MB9458.namprd11.prod.outlook.com (2603:10b6:610:2bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 05:51:18 +0000
Received: from SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a]) by SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 05:51:18 +0000
From: Ruiqiang Hao <ruiqiang.hao@windriver.com>
To: anuj.mittal@oss.qualcomm.com, yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH v3] dpdk: upgrade 23.11.1 -> 25.11.0
Date: Wed, 17 Dec 2025 13:51:03 +0800
Message-ID: <20251217055103.3695009-1-ruiqiang.hao@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0111.jpnprd01.prod.outlook.com
 (2603:1096:405:378::12) To SN7PR11MB8025.namprd11.prod.outlook.com
 (2603:10b6:806:2dc::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8025:EE_|CH8PR11MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b1c913-3cc7-455c-795b-08de3d304c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cDY0FlHF14ETZeh6r1xSeehVyrN8qVDJyLAQffWHClM4sFocFMK6N1MaiDdR?=
 =?us-ascii?Q?e4NhcLFH+B1NO7am2hliW796mUClK4c24euE54vSCDxEuLqvT8U3wOQVlvA3?=
 =?us-ascii?Q?Faj9FBhksQwA27gRjcF7rgSFeliWQ8ptGnQAJKwYcFhe647wJaxbpnmSKjGl?=
 =?us-ascii?Q?GkDJmbEaenbStm+NRYZCmPi0cQlh3tjNTtSIHODw+JW2fjkvzDy3Q3ZcXuJU?=
 =?us-ascii?Q?AqkP4dy1kv5beqkIQGHqvf1zJ223AVQGnjpxL8LKj0nw7wl28YbxLWShcEWD?=
 =?us-ascii?Q?KS04Pz1w46h76Dz3DHBSw6ogmXUCmIg7HuY6z1idXEQspS995PXsscJ+zTPk?=
 =?us-ascii?Q?jjaCt0lud+1oOUPVnTP1g446gTuVI6788d1tqMYcTGHW7SpXTolvEzRcVdQp?=
 =?us-ascii?Q?vTNK7wYA7ezsC/mJaC++jnbh6oNJNy3obMIOdBYig0HBDeBQfuj4EURerYb6?=
 =?us-ascii?Q?HzIOEFeRLoLEu4FQxPCf5ad0LKF94UvDrHbySuvI0z2ynZRhNkwsFQqGzTjX?=
 =?us-ascii?Q?Y46GuUB0jFZ7PmmRM9nOswwZ6lhc/gzFE3KJiR3+8LsgfRICHnEHqDavmlr6?=
 =?us-ascii?Q?erHgvXdB2DxNHWN2rsoD5uRywDV9pRcqHoNVH9/1RBuoSPaD43HvrNe7b0z4?=
 =?us-ascii?Q?tn3SbA6fznk0l8ZWPf1rtX6ZIR5nj3k1jZ3uxVjctFZgstdsWcYlIr2YP7ta?=
 =?us-ascii?Q?qHKeJRO2sHVES1Qm465cw5n9UkqCws87BILcjbPDpIYF9xxuHyIeR/l7YI33?=
 =?us-ascii?Q?fYfKX9EhG+teeSMEva8rVYlHdH40IK1RHpFYip/acd2Mdf8jsISqT4YUcOP3?=
 =?us-ascii?Q?eZchnU/vHwmBOvt08mMVinB6Sc88AKrb2eNLGMRnIDHGz0zVXKiptHzIcjFS?=
 =?us-ascii?Q?x1atjXHaju4QkQX770m6DwswEmdYK8KytlExAuBGF8ZbzDETmtbMeqjv81VD?=
 =?us-ascii?Q?M+qV4cZNHQHs7uHa8T4Z0lVGw8blG6Nm1j2EIHbMNzeQiUKM1qeu0i+2YK63?=
 =?us-ascii?Q?fdCkN2PJy51HNgeezJAibC/hok2RpZNjQi5yKEp+e6NmSVIpDbR9OcyTOPJk?=
 =?us-ascii?Q?Vd9rL4bZBlSl6HpR9Tvx6GBSXwFFkv8ehHWCsLr4oDXkB9QgyE63ACVNuVBu?=
 =?us-ascii?Q?7myXv/FxAkv5NIsNhfsBTUrFd7oJ9yq6HxNXNEDXNKvy1Msn6RBhsmvxa2Bh?=
 =?us-ascii?Q?Cr07PWbuDpft9um5p0vfhXGcYWL3GoJPHnaebkR2O7UAnTIu8Kgc7DpclzRB?=
 =?us-ascii?Q?S5M7r0HMFhjEGBXSTb6BMWxg8sX0NjqoU3CtRKFk3aQEE0egof6gPCkt4hf5?=
 =?us-ascii?Q?mGWFOiZyU6FhS/dQVniLgQil+YKjo4Dlx7yFNhXuqOW6BRUrhjL/ONhTXhdw?=
 =?us-ascii?Q?Mnls2X2WSfhIf0tEEQ2zbNlfPTsVhUAEZZ1wURvSucg7CG2vIUEtdkHqv5Ps?=
 =?us-ascii?Q?YKN6ghfcmTzIvehayC4BsuVXEjvL3r+tLVmlwI1nCsPU6XiwiucdDw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8025.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Z6kFTwGm34KEPBp/Ms7WAxdzJ4SfhzEAUwXB17jmfMgDrGJzZsVz/t7gaSdK?=
 =?us-ascii?Q?nD7c1hHY7vL1LhXeKWaLt7mLPIFS6OJPikWfd/3jDmJpcp6/LtjnMw007n2K?=
 =?us-ascii?Q?CQKDtqefwU2bqhQOtHRtH6MDGZi2QdS/s7XyKniPNDu3uonDSxxDMltZI98A?=
 =?us-ascii?Q?7Y0FkRgh4TgxkwUGN6LQoiVlVnRNKhAK31JYyFPLz0MJ69LAA41rxc1MaNNs?=
 =?us-ascii?Q?e6UNFZsTjjvkWVrscYs1LysZFcb7d+c/PNtBAT+ATjcMTg09+/ocWma41cs5?=
 =?us-ascii?Q?jcqT4qXUBeKJBqAmfVNuulyOvj2JJMDSq2ukNbSc67FqMflYv7RwJcJBg7rM?=
 =?us-ascii?Q?yITdzah5nbnr1tfEcatx45qFrNxOBFugFun7Dq5uixcElS8EAMNYIn/g4Wep?=
 =?us-ascii?Q?PHiwrB6TeKm2MZlbJ6M6gNh47jYhmL2bElpWqmDCx3XuhfTqBt9Q6yHJDx80?=
 =?us-ascii?Q?0odQHW15FXNAVhsH8Ryfg4Q9Be/n9m1cnM9aN6DjuCRyODZt6uiqZ12gb7M8?=
 =?us-ascii?Q?dHpcWNzHDiHRlKD6zQ/7Y9uh2YyrDMKKjLwj5ZHNQcncUMjJ+MkCG9bUOq3V?=
 =?us-ascii?Q?9S7SX4rm9fvBFl5dJKKB3JQiCkMe/Bnx2PUSeQPYGAfyoWPUIpLM1SgJkGBF?=
 =?us-ascii?Q?lnHCVmL5HOlBO8KFH88yNjeTAh24VczLt1loF2wNpG0pSzaF8nOCgDxKWRfB?=
 =?us-ascii?Q?uiQEJrqWTWSeZp4Gx6JcU7nHRPDPADle3y3Slj6kQAM89BBVlCV6k7KJTY3A?=
 =?us-ascii?Q?ZS71tXrMe46SXAOXuMSE529oQrXz3OIkDO8FXxuWFQMOG4Q2Mg6ZUJRN+C1l?=
 =?us-ascii?Q?vn4BTukLJhmQtEgRCKa5MArdd5SUfU4QzVE8AfSCVg7vmW+lTnq/ZCGlVHX9?=
 =?us-ascii?Q?vOPKaCWdNyh6Aj7/O0+aFKgvEBRDSga1oTdkuBGkqUONxWzSCJbZlzgXIshs?=
 =?us-ascii?Q?a3oQMdUuTV6OWz9dNr78hPIpXEj7mvtZE6XeDD4lEmbZkQhRrvpzFE2F+nMM?=
 =?us-ascii?Q?Jr9fpQGxBQhCbytGCI3dUJw3bOAV88HrCITJXkfHzdEqj28Rl/k4VJYROOVd?=
 =?us-ascii?Q?XQLYPMTo9IvDYB7JB0vi04utu2YNpGD1gU1THckYIfgA18wFr+72u2KGrEtl?=
 =?us-ascii?Q?2hGaYNZ68kVi8HbzMBIveHjnB86QJ+T2W285rl+QD+ixZSZB++2VufLzAtIK?=
 =?us-ascii?Q?HRKwO1fsGGFOVQ4/PjKa7Cz99xbZQF9w0nTn1iuaPMdDbjPu4JEymjEAV9Be?=
 =?us-ascii?Q?7t1v0NwTLzY1zXcRB7YisTymxjIBdf0ZwnsDVEVtui8tnuVxT/jMwsHQjqOt?=
 =?us-ascii?Q?Vi+bK4HYDAz9tWnTj6a1O/0Os1AcZX7qt5C6fGxf0JxaGGxkz0OBMsjrCZvY?=
 =?us-ascii?Q?MGIfOrXU+TzZ1mbleOgVrl77E89XIq16xoioCNehtpMA77insYGnHDFCCmsq?=
 =?us-ascii?Q?j+dzG80uq8Oj38UZD9VaTTg879jRWDW64+1gXlb3mgN6JoovmIiDdlgvKetX?=
 =?us-ascii?Q?gf1q6gw5DHitjBpE4OcN3qy3sOI6AQGpQ95p1uPAk3SdcNePjvJyxVSmigoX?=
 =?us-ascii?Q?lT/I00oMaxweIPv1ldus6hRJkzJptDkj3c6PEIMy0d9P+hNMsg6A9H2hjQEn?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b1c913-3cc7-455c-795b-08de3d304c3f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8025.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 05:51:18.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieBPvwAvAKmMN+wRjxulG/4H6y/RLxCOg0rPH5POE74jKASgBqRw1fu1jqPrvsItcfDmR/EzXITJeWhLDbK4vJyX2hxMX2KAufzSS9P8/Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9458
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA0NCBTYWx0ZWRfX6nS8/syygiYD
 VMlm479sOSnxPgtWK8wCvy7lEbJRs6283bHubMowqLK4pc1yOP8y4LAd2kNaUFSpUum+i4zv1jJ
 760rZaBrxr6j4uYAtvIs6L6FneNpKsbkPN2jBt8j372Aeb3rIXmBjxzUboQguY/G/ffprEQaMzX
 WmpYBiEw117hNBc+Z1c/sp/aYSt2CBqbUxXFVMs8QDtGJZYX4P9kQIpGIiK5aKaLnis9tqNUOHX
 VpP18E11eYiSHdtc56kgQ3NP7bc4P/zn5elexbsaFx2cQzkySEEjPKf63ULiUK84HfiD3ATuwpp
 /Wzg09s568XHZmCehY3VJpc/aZyLXFTB9rjB3wrZWNG8UjnAPzWE0fWPgzK4nS+IHbzqKhcBZy0
 W+vxOAget+C3LnnDjGMzZVhI0x+Spg==
X-Proofpoint-ORIG-GUID: Qa_yf8F2Dcl-lw8l0LA0TJx5pIZ6wDFI
X-Proofpoint-GUID: Qa_yf8F2Dcl-lw8l0LA0TJx5pIZ6wDFI
X-Authority-Analysis: v=2.4 cv=C+HkCAP+ c=1 sm=1 tr=0 ts=694244da cx=c_pps
 a=air8cPz1/yJpzemNVwtxUg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=t7CeM3EgAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=r2HGPOCozAU88W8aTVMA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170044
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 05:51:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2809

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
 .../dpdk/{dpdk_23.11.1.bb => dpdk_25.11.0.bb} |  11 +-
 4 files changed, 4 insertions(+), 281 deletions(-)
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
index b5aab21..c409fa0 100644
--- a/recipes-extended/dpdk/dpdk_23.11.1.bb
+++ b/recipes-extended/dpdk/dpdk_25.11.0.bb
@@ -1,13 +1,10 @@
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
 
 def get_cpu_instruction_set(bb, d):
     import re
@@ -55,7 +52,7 @@ PACKAGES =+ "${PN}-examples ${PN}-tools"
 FILES:${PN} += " ${bindir}/dpdk-testpmd \
 		 ${bindir}/dpdk-proc-info \
 		 ${libdir}/*.so* \
-		 ${libdir}/dpdk/pmds-24.0/*.so* \
+		 ${libdir}/dpdk/pmds-26.0/*.so* \
 		 "
 FILES:${PN}-examples = " \
 	${prefix}/share/dpdk/examples/* \
-- 
2.35.5


