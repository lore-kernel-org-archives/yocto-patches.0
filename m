Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359CAD5E131
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 11:12:05 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12663.1765852999356082153
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Dec 2025 18:43:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=IjTiXyxc;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=4445fc7214=ruiqiang.hao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG0oml61195622;
	Tue, 16 Dec 2025 02:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=5r1vGKIFvlvPShOZ2Zb6
	o+9Kl039evjvhDjv8vhrMk8=; b=IjTiXyxcNUZ7/Jz6cIToTvfTC3145znDM2dB
	BXD1AWhRxgCt33zAlLwWXEqNZkI1W2nGD7bgNYYnkeTMS3QAZmj0t3FPOPb7wFSf
	2Srjcn2LV3kVKzcWSzd6h8eaHlXgyYcJGiPGobcLM4hMwkN06qfsPluMoYa9Xm7/
	E+fkG3nhkjuvT7OkZhsd6Ktn5fBKF6ec/O7fkqeuk/nQHSmMO5n3G97kXN6ILTlp
	6ErGAmBXYX72pXbQnMN5StcPoOGOXF8x+ZCIQJk/jGUMe0e1IEIqc8habWE+aQBD
	Qs6xSbiwSqb5N5qdwMsxh8JsiXh3S8PBh3CRrpLZYJlJooLnJQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4b0wc0jkx4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 02:43:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKIuRdOc5tBs253tWiIqVgmWuUAzBjEwvUh5vpATnnaKt4YoSlRaKIQAcQqJINtNxMXQISRPPb35YO+2BOrymj+BOLfwpHvGz5iD07vgN593PtcZYw1HZUaLPwyN5JlXO0exY2WHBiPsEbY3lLd28PZeQR7l6s6hUK9n+MZRvUPVhEzcm80h8ZApTmHus50+m3ptsrRiJvMb4cTYql7f0BYB/vGbCW+z1LCfm7N5ZekvJJ2LMVZbaWLfpRkT8j67gXvAfM4rKy3Izq99h4nD7G8WuTUIdL97jtAThh/NNNarG3W8qomzezSJGSoIINIM35jClyWikA5o0ubBhiaBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5r1vGKIFvlvPShOZ2Zb6o+9Kl039evjvhDjv8vhrMk8=;
 b=JtRLJ8KWjpe244CXPvUEQ/pkGsBvXXrdMV8V+GWwj/LdBUFcfLoXPvWTtKNBFvDFWR1ZP4yK+dg21U2MYviJG96NOUqKTPyYGHMfxDF0mKtE1+bq+vtmYex/3QDCb3Tovd/OZ/VJ16jYeTfy4H91KfnEm1Tyg3/l5kOGQL74q4kopcZTFjm6JXkBm3cMYmwfabf6ff8tHPKH9brWgSL+gdNETj16pzPOFGFmq6qifFwo28DkL0u2H6snfY8OjYRcU25TPYi/jyguGZjzuCBH4l9PNM4qF21igI8amWnp1xcyhY1PMOhaOnmyZ1mkSf96fhZrSJ5ZPDwVO/F0+0vQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19)
 by SN7PR11MB6774.namprd11.prod.outlook.com (2603:10b6:806:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 02:43:14 +0000
Received: from SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a]) by SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 02:43:14 +0000
From: "Ruiqiang Hao" <Ruiqiang.Hao@windriver.com>
To: anuj.mittal@oss.qualcomm.com, yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH] dpdk: upgrade to 25.11
Date: Tue, 16 Dec 2025 10:43:01 +0800
Message-ID: <20251216024301.2972678-1-ruiqiang.hao@windriver.com>
X-Mailer: git-send-email 2.46.2
X-ClientProxiedBy: TYCP286CA0181.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::19) To SN7PR11MB8025.namprd11.prod.outlook.com
 (2603:10b6:806:2dc::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8025:EE_|SN7PR11MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: db686229-c576-4cf7-9d81-08de3c4cdbfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OeM/Z9GPCgoUoi99zqQjneQd8eIG9Zyy+w3nVtJUq0ZEed881l3utChjVSW1?=
 =?us-ascii?Q?GidcLTWh6DI3+gCdqts2oyZtmhUIInKPY4NtUEhTxN/xSH7kx9E5Nqep6cr6?=
 =?us-ascii?Q?xZS3xT9IyblZcETUMi5w2mu4lY2Fq15EnuFeIovgDrzXQtqgaN/avpK8Lge6?=
 =?us-ascii?Q?B87l/Jwn+UBixf4iqOb1BtOcp1KH+56WQjOiz/hCNVIFajGD8UZLwWHJ/GMX?=
 =?us-ascii?Q?wC51q3oKcvW+LX0fVNNL86SHQWRCnOO18r00SZhoAy42AMa8rrHtMyYsp+R6?=
 =?us-ascii?Q?0g9dNNX7K5hOmel6sqwmfuSkUvrj7d+e5Dt5K66RwxAjCeh7/e4sx4hrmFSv?=
 =?us-ascii?Q?gx1YSdpKZcFpmLwyK/THV3Op4oBayBr6TLPZIQrMs1zhcb+BYGWog5TfYgz0?=
 =?us-ascii?Q?EBtWTV3/guaJBZZrrsQ7qws/O8ntTsuJj6P0G5Ts9OsBIs2/zWMKTqLA9JSV?=
 =?us-ascii?Q?JGCgeMTZVSCU1YS63fpBncSA1+qvmEmvjiXn6vIVW0oJC8uT90/ilZHvDSCu?=
 =?us-ascii?Q?hIpQNxCfgXNCmWTIhgR8hN5RfBEK9RCz2lFlLXIMTUct1xOqhWkGesFU9ohu?=
 =?us-ascii?Q?H17fkrqCKEZWKlGy/j+ydeuy3RyEjIvrRXBB7OP5u/LxvPsmUuyI3YwVV4FQ?=
 =?us-ascii?Q?oQmGC4SC+5VQWdx2kI/aaaqc8g6DPambqA9FWGPO6mbbuyFSbQ+QMyrUBHuI?=
 =?us-ascii?Q?7Lg7Vn9on2RMcg3M2ksZ4bYxIZyd/4VKrlUIJTSELw5aje9udP5nvzapSoUL?=
 =?us-ascii?Q?/XEY4/Aler+3znVdz2Y9xXEsooTSnknv6n0qFrB6zPWUfsDPmVpTXlg6Y20H?=
 =?us-ascii?Q?NHs+53nRkBpCJ1tAFuhMZOAR3vG3AnmAzNLQxHo3UqsZZg6nmf57ty9n5Tuq?=
 =?us-ascii?Q?/t+UrDM6m1eCEc1vOGJ9uJSqOJuh34EhalHpC5XLF+W+9QwpJ3R0cH7kFM8C?=
 =?us-ascii?Q?v7VtjPhkzR5Z0y66WCnBZiycOGY8v+na1mw/vpBIUrTx5pohRyhM3Oitcw8b?=
 =?us-ascii?Q?IyZyKj69pUQuVpbrTMSxsv8m56h9oflCG+/qCgv5F3Gdopf+MUL9d9R3XQ8R?=
 =?us-ascii?Q?Dn8VqLqgo/zGqn3jQ8FhOjqpKYGV+v4jhF+qFJgwCTGM8+HjqJ15vceG4hw0?=
 =?us-ascii?Q?AICF663WFwx5WOExKEXBAstLUQ2h/A0QAsy2vhttOah4+zYrsc4dlqQAZkFB?=
 =?us-ascii?Q?AsTpkU3doGaCE7D3+1FGOIZqv38oSeGLNm6Pju7kYeC3djvLm1AKmg3iOCHp?=
 =?us-ascii?Q?CTMbfFPIaX5xSNiy242HqXWVKhoWT6Z0XEJocBjCH1r9jGwnfqc3fqxa9GHh?=
 =?us-ascii?Q?5teMxVVD779NXfe5k50/pRFV/gOkWS1m8N3gkqN7rEcGUCPT9LMtOWeW7f1n?=
 =?us-ascii?Q?pmdoFQbLDohZfbyDmCuLQWqJ16GFIGdtuJLaP1TG8OWj/29pc1y5UZ61ke2R?=
 =?us-ascii?Q?wnzhalBHhRWTwmdjoR6vHcStnGWZuVMGN7AAuM10l2goyVUXbx9AjKh7WJBM?=
 =?us-ascii?Q?Znih6tE/SlV0FTiKwZAr6ZgiCc/qipfnt082?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8025.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nbqKu4BmPgOt/7gQR13on3puiHKCUrArPGQm8hQC9hLKWctW4P7/vCMOirPw?=
 =?us-ascii?Q?uedXb5GUAQjs52s4rybNY9RW+8EMvxprOnaTyCpqcZY8WHjwnwx4cJFnVdUA?=
 =?us-ascii?Q?D5Kcz25N7vm/07v5rdpaohqrKXSG1Ve6QQfxJdC2L/Wj6lBURHrdah1atToW?=
 =?us-ascii?Q?voG6XUay53zlBP8B5zyw7pEdisnsOkWzNB+iZY0ZdJX4OyXxYzUKNZCZF1DY?=
 =?us-ascii?Q?WQSqn3LhglYj3cprE+jWxrVNBGLh/8kDvQ9OLk0t2sHfpmlB24jnawzRVQLn?=
 =?us-ascii?Q?4PtBVUbfnA58bB50aFaAAWX9W2GFK5BvYXTaEBof1DfbUNTr0inYpqhOeJcB?=
 =?us-ascii?Q?sdAhVcj1tTXF714TuR6hIw8TNMKfOkF1Sh2M7x33KC3ng4ZfVjwVDxJ5DYfs?=
 =?us-ascii?Q?J4s0Ioh5AJezfMpaYyczx9PnaE0DKhAH3U+xM5qvL+uCrb9JWsboKNlVW0ih?=
 =?us-ascii?Q?op8aMK3FDuR/TpPumyRikDHiXJ2IhhkOoHOsayHfut1h4KmabpjAhJGTrf6G?=
 =?us-ascii?Q?nvoVPAY03qivQ66gsW6GVLaXEVMRbTWbD1GcXoPpcYyBZJkiUVazbsIPHYWH?=
 =?us-ascii?Q?ehquv1ZFf0Mm0S3XwiWXujORyk0YZqjy5B5HXFcV+OiduBuxopfyi6i4dpaw?=
 =?us-ascii?Q?jaCGr+KJ9xi4EJFjU6XqYGB05GJXZIYwBUV1PLPBL8kNb8wx2TFhHIm/u3XJ?=
 =?us-ascii?Q?SxCYVYEUfaWsBlqVgQPJk+GWJYowX5djHlKelvIQDIChIgEluHsdIdRCkKpg?=
 =?us-ascii?Q?mV4OC81xnMmc9I+crNC97FW7vwkZJQj8hnalvW9eFj9KhU60r7eLSoGpCf0t?=
 =?us-ascii?Q?lmK3v/8CQEjja0lOa4o3d+ftOxqsqUB/gdE7lOKok9sNOJq8WBEGeM7fXnQy?=
 =?us-ascii?Q?aUj7CE3p0z/mDMF5J6/ofUcdPUzLlY4jX9ZEmKRozktIIujJ9ZwimGtdUXT7?=
 =?us-ascii?Q?Fg5Nm69vcvRMqsgHTxM8vgHIhVhcweCGXLGrTCH23KBJIc8Tks1BxM60q5v9?=
 =?us-ascii?Q?7QGphVPzAWChAn/0I287onMKL3g0kwtgjI68QBbkLOdMLZ8e/TBiTSvyCZWc?=
 =?us-ascii?Q?BZzcZIxotaWjw4fEWgVR4zRjaXJiUdGt1zo2B+Xz/72HDEWv+D+3555OHPaX?=
 =?us-ascii?Q?cnRDuhSiTxEyreHxCNxGdjRcL7QGonODJh0CzMvuOjZJMhj++f+R2SVesfv/?=
 =?us-ascii?Q?HTGgFTZxpD60/480fJ7Cu1ikrNp8vaHkeSjEkff6NxY/WGE9BF5k1OCRANR8?=
 =?us-ascii?Q?3kJRnM6ze2BIyS41LeDz2/ylER2ABYsy0IMNLqGpHlNzdFCycEjIRTZ0g91U?=
 =?us-ascii?Q?NEbnGArP2vgvWyfXrPKUyv3wuYYtwl0Yrlm0APp5Qqcws26XTL+Ttuc27qj7?=
 =?us-ascii?Q?E/9uZxnWakm/R89QwZm7MkQvtMdw/zB8sOo8e6wycvxTlxJZ5DVyzyLka+ZG?=
 =?us-ascii?Q?7KJ1SRs7kWov0J0X4hxERN/6uUc5fV5FBACW3L+XgchAJeIUNl0lw/TpbGOu?=
 =?us-ascii?Q?AmL/YGNzvR0E5m1KcL99OqyAjdbyjSfZ7BuMQ9cj5OtxRekKfsfoDXtD/hCK?=
 =?us-ascii?Q?GdzBCnGX/GwCBWEs2ZTFi140sIt08oobT/Yvk1i4s2nNlwPOfRmiXaRiQqcl?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db686229-c576-4cf7-9d81-08de3c4cdbfd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8025.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 02:43:14.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHd2jR5w7vcKIwkUt0mwZNWtRUzkGtm6IhU35xziO4BCWS8BNED42eHy/21oe4K4ekPtz7YIfITwED8oenNPQCHRkTykI3CZ7zO8IXOtM48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6774
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDAyMSBTYWx0ZWRfXyJbs2+AC7hKZ
 DBfLG/5mfdw5C/jnrBCDlv5Upn/bpJplPbSCt7mvKPe/3kukqreufTodTEumeI1Cz2EwJCfwSlH
 bGpHGB6KuIrilTj7MLpG+DPdcPjc6AlPdo9JfP1yw3jWkedtgmIpiJQUuC19OqIxaqvR/BuZekk
 A7GQXV6dF6gPWefz+3TUoIc66iwvKrVhDZGKH7zeN2tkMpZRG1ABcK+BjfV9oCewaUqo67awDAV
 sK5PoYdu6uckFL+GzAw3DvCcYUKIQh30+V50BHfteMs6xZ5pkaj9inRerhsrHcwPStxa4olFdJw
 bQEmqSL9mCpaLftZVf6sSyiIgKuEKHiaUBrk5R1D7bNCkR+ahc97y/d4opaz7J6wXHAMWtqGk9j
 AJYlz56w2gskLTp9q08HlvqpLjC42A==
X-Proofpoint-GUID: oWYVnvuL6yPUbFDgCBsVMxXYZ-yBhHo8
X-Proofpoint-ORIG-GUID: oWYVnvuL6yPUbFDgCBsVMxXYZ-yBhHo8
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=6940c746 cx=c_pps
 a=tYtg4CXWOAG754Cl0Lh34g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=93XguWIUVlBO5DPANR8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160021
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 11:12:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2800

From: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>

Upgrade to dpdk 25.11 release.

Signed-off-by: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
---
 recipes-extended/dpdk/dpdk_25.11.0.bb | 71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 recipes-extended/dpdk/dpdk_25.11.0.bb

diff --git a/recipes-extended/dpdk/dpdk_25.11.0.bb b/recipes-extended/dpdk/dpdk_25.11.0.bb
new file mode 100644
index 0000000..eb3a0d4
--- /dev/null
+++ b/recipes-extended/dpdk/dpdk_25.11.0.bb
@@ -0,0 +1,71 @@
+include dpdk.inc
+
+SRC_URI += " file://0001-config-meson-get-cpu_instruction_set-from-meson-opti.patch"
+
+STABLE = "-stable"
+BRANCH = "v25.11"
+SRCREV = "ed957165eadbe60a47d5ec223578cdd1c13d0bd9"
+S = "${WORKDIR}/git"
+
+def get_cpu_instruction_set(bb, d):
+    import re
+    march = re.search(r'-march=([^\s]*)', d.getVar('CC'))
+    if march:
+        return march.group(1)
+    else:
+        return "core2"
+
+EXTRA_OEMESON = " -Dexamples=all -Dcpu_instruction_set=${@get_cpu_instruction_set(bb, d)} "
+
+COMPATIBLE_MACHINE = "null"
+COMPATIBLE_HOST:libc-musl:class-target = "null"
+COMPATIBLE_HOST:linux-gnux32 = "null"
+
+PACKAGECONFIG ??= " "
+PACKAGECONFIG[afxdp] = ",,libbpf xdp-tools"
+PACKAGECONFIG[libvirt] = ",,libvirt"
+
+RDEPENDS:${PN} += "pciutils python3-core"
+RDEPENDS:${PN}-examples += "bash"
+DEPENDS = "numactl python3-pyelftools-native"
+
+inherit meson pkgconfig
+
+INSTALL_PATH = "${prefix}/share/dpdk"
+
+do_install:append(){
+    # remove  source files
+    rm -rf ${D}/${INSTALL_PATH}/examples/*
+
+    # Install examples
+    install -m 0755 -d ${D}/${INSTALL_PATH}/examples/
+    for dirname in ${B}/examples/dpdk-*
+    do
+        if [ ! -d ${dirname} ] && [ -x ${dirname} ]; then
+            install -m 0755 ${dirname} ${D}/${INSTALL_PATH}/examples/
+        fi
+    done
+
+}
+
+PACKAGES =+ "${PN}-examples ${PN}-tools"
+
+FILES:${PN} += " ${bindir}/dpdk-testpmd \
+		 ${bindir}/dpdk-proc-info \
+		 ${libdir}/*.so* \
+		 ${libdir}/dpdk/pmds-26.0/*.so* \
+		 "
+FILES:${PN}-examples = " \
+	${prefix}/share/dpdk/examples/* \
+	"
+
+FILES:${PN}-tools = " \
+    ${bindir}/dpdk-pdump \
+    ${bindir}/dpdk-test \
+    ${bindir}/dpdk-test-* \
+    ${bindir}/dpdk-*.py \
+    "
+
+CVE_PRODUCT = "data_plane_development_kit"
+
+INSANE_SKIP:${PN} = "dev-so"
-- 
2.46.2


