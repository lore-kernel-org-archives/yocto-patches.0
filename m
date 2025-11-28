Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A83CFD376
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 03:33:46 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8218.1764300817446630863
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 19:33:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=cbPb7mHD;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3427ccacfe=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS2UFUo1683947
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 19:33:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=BsQ9CboPXaX2NxLsGaUw
	7ML4VojoU+zTR32v7QSYiuM=; b=cbPb7mHDp6DSMHVjcXiat3bnae+M1HUY+8wR
	zJ0IgVlvYHdXVB8ZxkFD6ek7PP9XE0nYLJ841xV+IJLnGZ6J0TzHUX/Nw2bFNjP2
	f9w/junpYH2DwMpO/Ff6mtnKM/JVinGE370/R0QhuhiFiOoAgziyd9AVy4z4FGK/
	yCX5ixqsUY/EqUG2jTR+75LwMnqVkiUKa4/aKSx6W4hZvOzpfFpVgh+lYWhTcoXP
	UYIgtA/IaJva7IlMs4IOs2fHf0kIwrxNoccmiD9SVtgEaWokyiBCN0/33OqQ+Jqb
	yaqd6sOpAeoGQ6C736N/VE0DFW6YG+fy5W+LafTttOnlCIk9Kw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4akdjje58n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 19:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMk8NR45q1QonzZ/Jl6ZxTpTyayQJcpWacZ5t14KGSj9sqRu47DNAEfuxzx1ElBNkiGwcQLdFrNDrU72YlNrQCJwTxxGgW8F8U98C0O53FKnWcV/dmO4owhY+uq7TSMLZOFBqe9/XY8J0itnu9gBgWudwMAMTDodgg6Dl1jnXnCD0rkDYJ74dWoxyX/XptIr261oyk6ifc6ptZwDPAxdqCo5+WnLWb4o+WaMunSJwJ5WMWOlJEX+HKDrtwnQqqLiwzSpZzVasYeLQ2ZBNJswy2nvX8Sr0+A0xEgniD6BBhLrIfGjmzkAJUo7kr0ZMXwar+aGSW6qRnujpWhDVwS0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsQ9CboPXaX2NxLsGaUw7ML4VojoU+zTR32v7QSYiuM=;
 b=dLQcpV1+4XWhEa4gf8dvGMMYPBgbgpnwhAqNvtVVRx8lEjPnwwmJd6uL27LPzT3f65SgkZYm04K7qCAs9QO4PSnmnusFCADCXyY3rcLIKyxbcExnCQ6XmtUFUHpFh8JAsofOKLWEByjoIxFcSYjZOK4IN+/ViQfnR1O+lHzpqrVab9pqm1K0/g1cJ9+ImO3k+lUTVb7SVGBKunGM4sCxZrvyk8qqkd/H1zh0qbDfz8IEa08pk1t09X/YOZQyVwFISGyw/53Ovg7OdUDtF0edsz3BGM7akMMD841ySVm96799zPJR4NNjvUB1gbM1hGVXU6dOgppUQMsCc+qq7sVj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CY8PR11MB6937.namprd11.prod.outlook.com (2603:10b6:930:5b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.13; Fri, 28 Nov 2025 03:33:35 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 03:33:35 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-mingw][PATCH] mingw-libgnurx: add UPSTREAM_CHECK_URI
Date: Fri, 28 Nov 2025 11:33:14 +0800
Message-Id: <20251128033314.768621-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CY8PR11MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f64052e-d973-4b54-72dc-08de2e2ee92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QSupdhY9P0b3cx5adHUUExwCPCM004YyJyuRO3Jxc4WzmF/C9bP2b6664b7/?=
 =?us-ascii?Q?ZL3krL2gohVC9ih3Y6/tvNULYkhWb3v9AMoK/Qt05kbtc3zk4ZhqqiPpbkzV?=
 =?us-ascii?Q?ER4Se4pca89A2pNwnQ9mZUuV+jnntThz3nL13sRaSyNj1C1Gmlc8PeJWs+38?=
 =?us-ascii?Q?VQOZSLUX8ugmEDmLR32ERg2ea6Z8h5gv6PEzpwCGC9UA784bbIZhSXB5dkMC?=
 =?us-ascii?Q?sc1mjgLPop+YKFfNTr2JLVNcjdvWEb4NNz0CusXHfx8a4VxBcK9QTj9uJrO6?=
 =?us-ascii?Q?iTD8go8cimznx3gS3uKD4cVpujrIZWY3uEnKzjBW82k3XSswnTWCHRfbc5L5?=
 =?us-ascii?Q?B0K4Re4qvGkC6F/6U5uM2WU9CzBkk7V+pzUcHeefW/LT2dq3bIJuJmWYDMwl?=
 =?us-ascii?Q?g2My1KmdBbk2L+T8EJuYnt6xGoFJDPJI7WJIaNEdl3ZgMyOjOg5VfPuQkoeM?=
 =?us-ascii?Q?cVrcpfIJoBYItBnKRvdmTs5ZbLxYE4b4B7RRAROtz4eqLsBYxqPO5ihY+hdG?=
 =?us-ascii?Q?vw+XxcaIRrJuY5WitXsoLRDwpwG146qFL6OW825k1W7WPs2iXAjgTb4YsBzq?=
 =?us-ascii?Q?klNKZRimQzkKOoKaCC2cfWY2nkgpd9PPvBdxhaORM5CErR0rVLA3Ncn4nuwE?=
 =?us-ascii?Q?ZBTSjq4hvOiVWTv4gakii4CmEIXs+lhqHy1QAYghQU6yUIFr0bw5ECaTxDTw?=
 =?us-ascii?Q?WMRtgg8jcF6X0A6OHLqIv/3kMbSriv06DDpIRboNYn9G8qsVW0gGI/jUQIPV?=
 =?us-ascii?Q?AaTz4BjpGqazGwdSpqGJs5qPrFuP6fWp5kryL9qMlB/WJJ6oxF22DVb2iH/C?=
 =?us-ascii?Q?TsIMQQkkGVQEGGL4DxiBnisz2wm9dByFERui8I7fSL+4hkoM/ZRpTskZek0O?=
 =?us-ascii?Q?DNGyC2QhNr9YgXiI6+1iLKopRk3KTRHtOw5jv+OO7KbxDBO6dp6Yqf/b6z9w?=
 =?us-ascii?Q?FQSoHTGsRWsZ4ZlwP0OfdY9sGNfWQesVx8i1r14X0cwlaBzIl8kBS0PhfxKO?=
 =?us-ascii?Q?KvhbqVzjop6MiattXUKLfVXKUXO8Sdh3zS+HUE7lBRmrIqITQlPLSDPeblOo?=
 =?us-ascii?Q?bdPj3x4M7+PSdH/GMdMKy48Fr55TDH64KRguOOtoX7EPI8rMdX8D4NROuzH5?=
 =?us-ascii?Q?8NxSy7Wk3CMOGtyIpXnIUZK5b84cXcUdBOvbwH7n9tDABEhlMNnJwjUIG5tv?=
 =?us-ascii?Q?Nf+kbppFpbwUfDkAL9nqKw0rZ/7exnXvWxCaJri+iuQ5+pstp9boCoNGwJe9?=
 =?us-ascii?Q?f6Gaufamb2haK5i4lEcjm19WVzlM6QitIHJ8Mj+/vJsom/OekW6iEp40Vfqn?=
 =?us-ascii?Q?L0Huy9APCJIYYfEkA6Er1SyFXT0As+wbadDIfx+f3tW2oQeXRdnQQd9ecSyR?=
 =?us-ascii?Q?Aj1AsHg/1/8PFQQSFwxF5Exz5tqah0gaH//Kcc3GWDnlz7jhiTSlnMIyzHf2?=
 =?us-ascii?Q?/9SaNo+5UIK67l8gzt97JceikBC3n3jBY8Tx1pl4DrFoZz+7Jb6oe0ktKJ1t?=
 =?us-ascii?Q?xnzpTAmvzB/Pwd9o9VVjTA+fvVe3p0AxKdgt?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hU6s/fqb27FFzoGZ1TY+zQfT34klaZqW6NXikNoDcaPb91bSVqHFsHha2Awt?=
 =?us-ascii?Q?lvNKMTDwE/au2tNYaJReBuHXulzONBp+nzyIG/FY+Oo2Rxv76ivru6eObg5B?=
 =?us-ascii?Q?x+5soK+W3a+cQInzKqiQ2ZjKyqALR+l/09skMcBw8b8yW9cZbSqVbx/D+CUX?=
 =?us-ascii?Q?RWuZxQt3ODDmm6mVU+TznMgUzlVkEcJ6+kx0IAYbfAF9OVNnIF4TRK578OFs?=
 =?us-ascii?Q?m+MQMRLLJmn8xQ/aUA9SI1xiXMV32JCHDQPGLQH5SCgkL3wCKWn3U3SOO1VV?=
 =?us-ascii?Q?yqnE+MBij6/q0S5n/hiV+VotlS4x18hHjc1kKVOrD4AbHanSM7uWB89fHdmn?=
 =?us-ascii?Q?TKLueGCKTKR5pc/A5XlRH6Y+stwr5cJMO9IvJwh5fT9yZzlgbtIkjWeAAzIO?=
 =?us-ascii?Q?dnE6NCReao3IiIBQ8PWRfpcIdq9b7nx4iiJfLk13PCBxx4KQNs8oiVf7+dnS?=
 =?us-ascii?Q?Ascs79t/5Mbi0KVMtUzBiDvYkEvm8rqJbrvTv285ism9yT8YL9K3VLUxAS3p?=
 =?us-ascii?Q?6WEKyKDbGPqix9iv06hqBPQapxP9RyCOyDU50m9QqZFgScd+KOxB9kZr5E+6?=
 =?us-ascii?Q?4yEssLDho6XrOFwb0kLi9I/FBjSh2czv5uZWE6i7XxCm6K9i3zBe66mAWQQ4?=
 =?us-ascii?Q?NOKvIL5a16gwHkvLDWAkp0TwrGhds0Q+ToBzJcDPC1ap27IbwA3DsSjtCsEV?=
 =?us-ascii?Q?dZdcUo1NYYhhR+co3oOcUKdc5WBe1199aAbJfoWERVmebGb3wDlRVSUG31If?=
 =?us-ascii?Q?LelxMlH+vka0q8JT7p/pThLOwv/OOsCqW1Q9UDmanv5D8MBDpSKmJZkn65uL?=
 =?us-ascii?Q?d6HQ8SKDt1xJMDsJAXJxqCokk87UomlEnTdKOzMP07qGO1RJb9Pj6pTz36n5?=
 =?us-ascii?Q?zfZmsvWi2GHgD+3sjJenCzOKsC4PIaCVQNW4dI+pE6gUchRZma3pGbycFD9r?=
 =?us-ascii?Q?gbdDzUFAJ8mCV69g8VmqDYUc0H1vkvN1OMz5zdDymygjcpCE3cKKzOZCLk/m?=
 =?us-ascii?Q?nSpH1f3zatqipApkA68Oe6dSDEZiBLr9AwVs2OSS3gQ6kEznzIPtrOZdiOy8?=
 =?us-ascii?Q?RHUY1CQO4NUpDeuu0XrMhW9gjMT4y8PGDpcJVAweVb2bTLXqE+ylg4xRUjCs?=
 =?us-ascii?Q?HRAMZUglNXExnwO/04gGxeRkpkl2yJmDFmdAPfXwfeXRr2B1YHoDKyylTONy?=
 =?us-ascii?Q?g2Ms4p6qF1gEWPxKMO7DM2rhQq1JAC+fS1W3c1MoivJhM67X4ih58PJVrhXB?=
 =?us-ascii?Q?05HTgZBgipTtkTV0X1VZAGWuuMgip+CD9a2iAUvqf0/dBsKSE07/OU3C5uf/?=
 =?us-ascii?Q?gx72lgYcnpJpRDVbnMCeUEZk43E/nUZidnYOCKCWq8NzZ1qo8ugX5YzJs9ak?=
 =?us-ascii?Q?YoatXsYZ95tAuTmn6wP55+xOxJRqwaj5DTnCrP9vw44triK4LQqZJ91ckX12?=
 =?us-ascii?Q?8tvLTCMY69H8+xKz4WUXftj2juHyCkHFHMTVgUHfvkKBYEduwdKXHtxO/15Y?=
 =?us-ascii?Q?g+RYChiVp9LwBWEQbtI5/dOKqf2ZqGXRKzRK3TDvyEaDrtW8OJHgAti2QXld?=
 =?us-ascii?Q?IimNLb1MCPOcCgTVS7imNJPT8/vZIdAXMyB4gY51?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f64052e-d973-4b54-72dc-08de2e2ee92b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 03:33:35.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnilHF6NHRMYM3o4gAsOLWxaau35LDgXkCY+e8l25Vwr24acv6ikxsYFyMFfnqwzh+AuRgHrZLq/cVTQ31aFeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDAyNCBTYWx0ZWRfXyVxZ5D/eA+CX
 VIt43RR2S/P+Iy+ZZLBG/wPshZrxb8n6orFor2NPdInGttSJxLTNB46kU5ik0pJ5oY4Td9xNIlz
 +eEL/R6ZUPYZRQ/lHig0uDAAriVrRILLQkXfhtMdaayVW9Tkvu5oXLprAnj8SQ+fQjEn+ops7N9
 7Zps2LpR5quzlNRJFMlV9kPRkYoHlbzb+IHcIBAFef08HlIkcot2pkszGm/YoSqFQqZMGCib2li
 Y6N5dhp9sol1kF6a4bhCJH3EJnqd/G+bJ92LWutZgotKlWsE6ijKRwjERiAGvXxUHFNAKWc4fv3
 edJQs0HSnEFogGf7tPAx2TJ7da6u4srp0JKrJJfH94AKLNx8W+Tbe8tlZsYAKKAuNmjG2C6R8k2
 vk3wwkMJzktEe5D7WJmEtF7VI1iOHg==
X-Proofpoint-ORIG-GUID: ipX5FwHT_-DSZWVpzPlCZGByZ54KVDEf
X-Authority-Analysis: v=2.4 cv=Wq8m8Nfv c=1 sm=1 tr=0 ts=69291810 cx=c_pps
 a=J0RhwYao4za//xiv/28V8w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FP58Ms26AAAA:8 a=t7CeM3EgAAAA:8 a=mNHsb0-Uc7lwXIYu_wkA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ipX5FwHT_-DSZWVpzPlCZGByZ54KVDEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511280024
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Nov 2025 03:33:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2729

Add UPSTREAM_CHECK_URI and UPSTREAM_CHECK_REGEX to check the correct
latest stable verison.

Before the patch:
$ devtool latest-version mingw-libgnurx
INFO: Current version: 2.5.1
INFO: Latest version:

After the patch:
$ devtool latest-version mingw-libgnurx
INFO: Current version: 2.5.1
INFO: Latest version: 2.5.1

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
index 4547298..5318ca4 100644
--- a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
+++ b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
@@ -9,6 +9,9 @@ SRC_URI = "http://download.sourceforge.net/mingw/Other/UserContributed/regex/min
            "
 SRC_URI[sha256sum] = "7147b7f806ec3d007843b38e19f42a5b7c65894a57ffc297a76b0dcd5f675d76"
 
+UPSTREAM_CHECK_URI = "https://sourceforge.net/projects/mingw/files/Other/UserContributed/regex/"
+UPSTREAM_CHECK_REGEX = "mingw-regex-(?P<pver>\d+(\.\d+)+)"
+
 inherit autotools
 
 # Specify any options you want to pass to the configure script using EXTRA_OECONF:
-- 
2.34.1


