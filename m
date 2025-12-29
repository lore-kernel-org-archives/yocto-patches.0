Return-Path: <Ruiqiang.Hao@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32352E8FDB1
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 09:40:31 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40655.1767001222778339237
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Dec 2025 01:40:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=oHKq5YZu;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5458b22316=ruiqiang.hao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT8evDP2292470;
	Mon, 29 Dec 2025 09:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=uEa8GxxXMxjAHLM9kyL8
	2iBjMRFKMRonRufbG1oYzJ0=; b=oHKq5YZuAD8irsmGkmWvvf36Gkf7EbQbHDKk
	jCCp5ZNziEpY8DMbnKpXsLGfV5mmUjLp5BFBfTFiNqDXcCW/upn7gS9IZcO2/5Az
	BJGiF5CQFY8pRchK+IV+3JMSi9j6L13+QZ2He3Mddz+n+b180yjVbqY3gyA8T65t
	5TumAS56TepsRucVsmvFvO/Bz8CB3yS5N+uD79Sy73A8dMRPPdGMuCSsS3FqI5W+
	6MhBks1Jil9JiQOQbdohiqYeYVc3OWvY1WRkaZr59QyiK1/WN9wQsLr6y6SPx9fY
	DiqOCuP9lB2Sp54UIYe9aYNJi1eVPP5qDrsAAJiVkyFdGSJUVQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ba6e4shr4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 09:40:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agfWh9WAXP02vvStgH7WgfZrQXgIXV43PrHn0vZOdoJjTSx12lNQ0HpVN3FZdbhEcnA13sCr32w8SPLfRX75OYtnYr+AHqNAI6zzP1X34gyLfEqFU3689alcLvIurxYKqz3EggO/Ghy50D4+/i7JxsoT+xPB4QG/LO2PXr7gPjwjHgrEknzG6JiqX9Miy2EIl/ECDjsMIBjtDOBx0VZKi9Ny3wojrF06HUkwbczsRq/mdMKbN4aiEN0U+wYuuAAvJy4epfG/pCeJoGT773a4DPjEnjVlyBmzVYssEW88MxGkCvv1Nvq+pugkaEKk98qEpUZZB65NdA/26+cHdm2utA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEa8GxxXMxjAHLM9kyL82iBjMRFKMRonRufbG1oYzJ0=;
 b=UXiQ4KDjyiYgHowIOMyJgBzfEkIWfe1Jy3xVTPBlrXYAcJZFe/w2VBU1W1G1jy9adQN/2KMeqHj05gXoSmm6iyRvKUPzuJhZoeT7Lbfhm2if0wkD2IvVIahOf/Qky2fh580K2MiNdz7CBBRaoB9R52JvgnkULOFlooukccZHBFSvJd8QbIXGcP8HUs/GmUblil4485aqmAQIQy6X0ljdgS5ylg9Pz0XVVtw6YUMMo1GxLl4WXphNxbuzVH8uuYTlth5s8hwWvv4W0QnDu+L+MyI8xv1Ir3HSnpii9ONr/61pn9q1uKbNMQhl2bwZAXiqKWAlh9rJlsglyC/7shNFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19)
 by PH3PPFC067E5C7D.namprd11.prod.outlook.com (2603:10b6:518:1::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 09:40:19 +0000
Received: from SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a]) by SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a%4]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 09:40:19 +0000
From: Ruiqiang Hao <ruiqiang.hao@windriver.com>
To: anuj.mittal@oss.qualcomm.com, yocto-patches@lists.yoctoproject.org
Subject: [PATCH] dpdk: rename recipe to match tag format
Date: Mon, 29 Dec 2025 17:39:46 +0800
Message-ID: <20251229093946.2776440-1-ruiqiang.hao@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To SN7PR11MB8025.namprd11.prod.outlook.com
 (2603:10b6:806:2dc::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8025:EE_|PH3PPFC067E5C7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b157ee7-c118-4af3-6cb3-08de46be475c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Uwma+aUrx/qXw5m/8sO1DjyuUKf2PxQisYzNUht2Sks6P7qR59IT0NHym2RH?=
 =?us-ascii?Q?k6KNcq8I23iNHvQHVgGWmfogUOhf4kyGcLuZVc6eo30j9gfulTg9MZ2a56yg?=
 =?us-ascii?Q?RTMVq2Tq5+VDwkRLsLZf4Iam2Y3/gZVxh/RRINBx++6GZO1ard71sG4lc71P?=
 =?us-ascii?Q?s+51hXmuJJlx75U1mwZq8jFpmdfAX76zAm8PzpLj2xRHhHl+TJngGF9yeLGE?=
 =?us-ascii?Q?j6A3FPMaBpqA77uD3YnSfQBPAwoiB0YGTwOhhEvao4JF6sgqXb20jJY5Zvks?=
 =?us-ascii?Q?35s5tyMiv33xzqWoK1+lED/yhZje1WjxqQk6NWgOcpZAlDaQ4DrH4bLr34KB?=
 =?us-ascii?Q?wbflT9Mcxdh4xk53TQ97n31JQX2LS/dCcqwFkTf7L1gAMdxiDPNwnvIweC9N?=
 =?us-ascii?Q?+ANzbVYc3WseJTSKL1TzEqwnWL7p9uAiSfdQoXfJFtfraSGOJEQhqIP2BjR7?=
 =?us-ascii?Q?5O3BU0M4rTSjs2HqRklWXzR9IwRsbD6vZK8Vu0JK/hiLd453hxLg70UE2qQL?=
 =?us-ascii?Q?JrNMiJm2rlqRYhCnfDcQzWOS25OpOa5iyOiLap52mCzuAPfO0tDlwM7b4FPd?=
 =?us-ascii?Q?TYZZDF9QmMbzrGpNE7PkSTli4Le44I8H1sgIYlvkxeniW89bnRhzU5CDGCDS?=
 =?us-ascii?Q?0BjMruOp9PIZi416KgEezrjNWdHPQTKGc4aeql/EibZcmwwmhXBaQ2T5mJmF?=
 =?us-ascii?Q?8aQIyhYSZMS1o54XRGIZdxJMeCstQSwcB635d4jYqDp+xkaS2pCbLRypihpW?=
 =?us-ascii?Q?ajblElwly9FcuAjfx7qdbK6UQKBx21siQnEq92Gij6IbAJPCaBooUf2lOpmT?=
 =?us-ascii?Q?RAIG5OQBgZERGo+ViqrP/tquBvTkjDBxSfWgUUGtkGgsoiTXJfHNcbd/eK3e?=
 =?us-ascii?Q?4znGSstlQ5ZRsjH5EjnVy0wVRNHkdpxfzlB3ujNZXps7CAR750EeLbXku/Bo?=
 =?us-ascii?Q?X68CHD1E2uYUqjxDzQGqOI/IpQiUjHQdbiiyOxtU4cJS8t/SIxvfWONGi3jG?=
 =?us-ascii?Q?tQy6Yjpm1phJDDi2Ya0X/uiI8Ri/ILMO40fTxCrFZi9zDMsqk8XEQjHBi6Tn?=
 =?us-ascii?Q?jpWNldeVbWoZyJKBaBvAqlsJXIInBrNqMK5bK16yDcRIRHXhX3hAWGNMn48j?=
 =?us-ascii?Q?+PzKaAGccxAhcKj+TN9vaGdzemurqSoXelh+viaQdMw+eLDtKQmpO2NHmNzg?=
 =?us-ascii?Q?WMi0bSBbShe29IaEHJp5UcLM0v+DTHCSF0rbuDFdK+7Nu0zXskLEX5sfdeKp?=
 =?us-ascii?Q?bTxzklCYTzxjrGzyctb3qSH+YiACFfyEtYnENsclGNi0DnO0IsnEd4J8mEQF?=
 =?us-ascii?Q?FFfjIXD0UoG3BIPByd1uT0wnFyWc3A3ELw8EURBCHuTwf8dhDeQSfBp8Hfwv?=
 =?us-ascii?Q?XKeVMUyjnc+fTkPSYwPPxiHRxJBIyKWdSAan3VkNF+++nFz4Vu5nKgKs9PKm?=
 =?us-ascii?Q?jzKK6Mmp393iYTaIJmCfRFBadWCjTsaWHRqVmH9SIQCaT5s5nVbzsBqHyPxd?=
 =?us-ascii?Q?I7W4BkPf6cxhB7VlUdv2gzJyPCjDufxXzLH/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8025.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QzY97dfProziD/RFNERxdqJP6w/yRdBAYxgkeg+/+TB/O20dOUOaBUs+er1o?=
 =?us-ascii?Q?Ah5lgTmFLawAFQx7+FhDQ2ziGyrL9bApYH1F9BHHgx8Fy4ICVbLoCos34EDV?=
 =?us-ascii?Q?yaWiLuUt70YtZKNxyfdrz+nMHycvO6sekueD7LZzKhbigNk+bJZQVrgZj8Pt?=
 =?us-ascii?Q?6at5vt/9Kr0fzPPvUyZRWtc4dZmA2d0Ea8r8OIBjv78guYsLcEqEbwShuhyB?=
 =?us-ascii?Q?yaJYQmVVCecApjxMDSRN0wP3gy1A9YF3aq9QVC039rRr8lRR6JFVZRC3EzPv?=
 =?us-ascii?Q?MdruCvQoll6qbYYpIC0cHTOnKD5SCdv3tmYENhZlm4/WFgrNn9T7r+AlPA11?=
 =?us-ascii?Q?ITAC8M9k4axus5XSHaQOAYCy2Nv4/xAYgCWf56DFWMtwkcAlI6GpX95Go1Ho?=
 =?us-ascii?Q?ZucYfBtLgvOijzSIAJfGsrIbpI4VgnzxQikK5vs+UnYxxS8/0Raewdsbk8Yy?=
 =?us-ascii?Q?OllnKGOlipe8gcNoU0D3FZOhqpAekAupBET+lId8RI57HkoWTeDbNW7z96+n?=
 =?us-ascii?Q?G7AOr7O0kMktKr8ty73IV+bE2HDbWHRjy6ndqevGko0Wi63XXYoPmfpruGzR?=
 =?us-ascii?Q?2ZYKSZHs+4PiEy2i2pHCQaO6XpNMIUlYWE0FtZ556radk3MwOfP/5BzpWKtQ?=
 =?us-ascii?Q?kawk6nguW3UyXwDYX2Szr5TEDLYoaCpgt8LwwOXHADmp6WkCAZz7Ileper7g?=
 =?us-ascii?Q?Udv6UqgHtuDp/UZZHgWYmIVDcDVDL57kqRnROkA3ee7z+1XD+Y9TP+nUHR9N?=
 =?us-ascii?Q?DKiDKDbvvy+BofBMUqqia8974mdd8MP1aze3twLz1w9Du1t7jVONt02X66BB?=
 =?us-ascii?Q?IHfuq0/+H+1W8BIiLpVnd//hLQOF231lYcmSyNR//WKMOjjGIVeHawBT1iCX?=
 =?us-ascii?Q?Xy93VCrV+BufPwVzuZriRN0fodSlgYH+BO5om0QVQR4ZHtB9m6i5763MMkuX?=
 =?us-ascii?Q?URexgCo1JmsAAGNw9jLH/+c4OVQ1Qp/DnKH82BA+/AJzuPz+eYp5Rmiri+dl?=
 =?us-ascii?Q?/CX6oaHc9mBc+uByg26EmaM/TNLZYKUVdM9jwbn22UKfs5pO6fvquMafIckU?=
 =?us-ascii?Q?djftXjsxgiNYVELC4YP8xpot4+B2PK2XMM066Jsy9cLdtRk4vllKZVi2eLao?=
 =?us-ascii?Q?1an4pFjqOGnOgmH5DHrdxJZLOTN8U68NockHmal049qyUqr2l3B1Es3MoCKy?=
 =?us-ascii?Q?dEss2T2JyntySSWKrfvtvrelmn04tpBiN6bmZ7gG+turfcYBQ4Xp0vSCtEE9?=
 =?us-ascii?Q?4SPs2M+Y0Pwh795Hhg760LTUh+poQi9HOpCxN0I+yMPMrigp6KeoCmsRAsd7?=
 =?us-ascii?Q?FthdxEsT+f/1JENTFL5P1eGq2PgQW66KrJWROlY8Jw8sdA6ynRIkVVx5qY+q?=
 =?us-ascii?Q?Fx/gWblStlZoRo6Yj3oM1Kcu1gLRrv4bUTSCH1rv1BnB/2nuHBesIxvnsgG8?=
 =?us-ascii?Q?r+4PPhnHrMchGvXT8RAfrKUjmBgOlhjIOK7xCr+K6btZdB72AmklBDuUpm7o?=
 =?us-ascii?Q?3HkdKkkx05YvjRi9OuJKHAeNiMMoSiQBiJW7mg/WQu7NBczTXLaQXg+PjMc8?=
 =?us-ascii?Q?5A9T1Y7/2Wyvr1CEUslynUAUr0L7P0CNIvsP475uCi3TDPcerOGlXbx2M+Ok?=
 =?us-ascii?Q?OoJa0OpKRpTSunLAPejnWUJnOSXWMkxS9TnvaxnuUW90e9wVjRFsSH/8vYlB?=
 =?us-ascii?Q?3FgStnt4izphXtReh0NJQYb+UHE/VX+059oQxEoHi3njO5KCTup3P6ERRcn6?=
 =?us-ascii?Q?pZBPV0u3yHbnrGkGcUltHyHuf8/i3rA=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b157ee7-c118-4af3-6cb3-08de46be475c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8025.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 09:40:19.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMR2N0hULflrCmmDwedHAID/SVYlTdJrypRqqr5ZmAdR1eQyeSOiOlCofKpMI7TZKwm1q3Dd0bIxNIkbCpcV2XfiMr80rWFzU++gnnejCEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC067E5C7D
X-Proofpoint-ORIG-GUID: OVFbbc8gWt4Sa93u7OBwysHa2UjY2vaR
X-Authority-Analysis: v=2.4 cv=V4NwEOni c=1 sm=1 tr=0 ts=69524c85 cx=c_pps
 a=BcPl/o76WFXIZ3b3OvynCQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=chCutb8OJ4mkReG8jygA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: OVFbbc8gWt4Sa93u7OBwysHa2UjY2vaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA4OSBTYWx0ZWRfX3xIz53egt5eI
 8OkW81MBUSQ/PYhFOEb6jsVb+uR8aEsvOqnqafXmiqPJzkp1YZYyBcyOub4vuTAoupOaCdPEzCQ
 q31phBYR5qWUhXRuqiR1N/6dAFvoT+A2lFNbe0fd+P33dJbeoeP7vQ8dmTZqcjalonPc/ZBqpzu
 FEn2wynclxu/4c8VS3swBMamPiRPwsco9nVeNYDmjosNATOGrENVbBcKx/F92cdwsrKtcbts4Yj
 /xPXnJtK6D+RbdgxQy7wEIEnauMeLYTBVKVnQkLXn3GJWHF4k8yYOrYcO2QER3arcmrqG4ocJ56
 oze6fAzHM5dBOlCjUgCZ4wOU5f4uSEOBYMX20LW5ZXHjwy7LzQP1zbZEkx2Dqm826pxizomtH++
 s6JynJ0k9aquuaKXY9OOLhH69fOCe9EO97dXbYFPubhTG8lYO9vvSV4lp6u4OB9GmAm3MKc6mle
 ZE6RQ7MRtxr2URg+Rew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_02,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290089
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Dec 2025 09:40:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2879

From: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>

Rename dpdk_25.11.0.bb to dpdk_25.11.bb to align with v${PV}
tag format and prevent fetch failures.

Signed-off-by: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
---
 recipes-extended/dpdk/{dpdk_25.11.0.bb => dpdk_25.11.bb} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-extended/dpdk/{dpdk_25.11.0.bb => dpdk_25.11.bb} (100%)

diff --git a/recipes-extended/dpdk/dpdk_25.11.0.bb b/recipes-extended/dpdk/dpdk_25.11.bb
similarity index 100%
rename from recipes-extended/dpdk/dpdk_25.11.0.bb
rename to recipes-extended/dpdk/dpdk_25.11.bb
-- 
2.46.2


