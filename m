Return-Path: <Haixiao.Yan.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE69C83F09
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 02:46:35 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.51149.1751856389932630752
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 06 Jul 2025 19:46:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9283243bde=haixiao.yan.cn@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567202sX011402
	for <yocto-patches@lists.yoctoproject.org>; Sun, 6 Jul 2025 19:46:29 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47q3jn0ygv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 06 Jul 2025 19:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOXigfEOU5mHSRkE23pR7d4H5LdYBxE0ASrNH7pydg3EH15Opf8o390CQtaD/HI3H6t2fRwREKzuHeSlSu3BKHjojle9izTVEQXmRWj6yNt2oYsHaV070j/FlU3o8HQfwQ1Lu69luesTVwGDdhqdgHQX5lYSve4X2Kenawie2yixIhQRefuZRmKzuwg16UzP/h2NTkk9dcfsvXifCbewjXccXHZlEE88g8dnDaDiZ4YuPRQU/A1GdfFha8bL0WfuG61oq6taoqd+XCPpJxpHJRu0pXVIZs+qf2we+m1NqIkcVcjaDPYWRfVeAXoSgmOIFbkho4cPNiMJ7Ax9ZaN6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJCAfrh3g3wHoeMtZIVDPld++hhQ2Ap0ZjTJ9nfg7jY=;
 b=SCg0L9NuDt+1frRbvDdeyRmmTUbZUVi2yX5nt+kFln6FClGy7vLLa+OOqGaBMgE1T3WV+wzikN1Kv3dte5DT/r3nIYhIVpYDfy6UCYP+XyU5yjFDx37G70jm1Zg8micFPWro+fqBY7HqXbJCIOP4NsXsTxhShQvArdja7D9de/isy6v5zHcPdSo2GM09u70GhDibX1FXLGcCI3PhTW3be+4y2oHV5Q4qGAvIjYTOsU4ZVgYmbDsYoaRkl7CrDz+Og0RHz7TnO/p1yJ3Lv5dR36F33fe4bslwWtnz6cTzPZ688vxqeR2SvjRQlpzGrt//XFIAlbA0hzPfTb4IOTdR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 02:46:26 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%4]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 02:46:26 +0000
From: haixiao.yan.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/1] samhain: Adapt test output to Automake format for ptest compatibility
Date: Mon,  7 Jul 2025 10:46:09 +0800
Message-Id: <20250707024609.3028355-1-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0106.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::21) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|CY5PR11MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a732695-18c5-427a-e7eb-08ddbd0077c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5DssiUvExO0jmMCMlFoj/f26M04f+sl0xUUHxZyQQASpbaEPRLS8PvT7pjPV?=
 =?us-ascii?Q?AO9m0tD9YHZo9PRhyMwWmbgxaUJSe9V/xW3lr5oKX3/Pke/B0WMsJNs4WgtU?=
 =?us-ascii?Q?Ecmqde6CIKkIA2I9r3iVEO/zwiwZ6ySslx3QN6Pu9kHRXXejIwzb/3ur/GZ2?=
 =?us-ascii?Q?Lq7QZDX91qJR2PYsN/y8ftoWag+47JJaH+iTYntHNR66WcyBuvCy1WQgAHzy?=
 =?us-ascii?Q?HSO+YzPPxay2mGPZbNk+fLvkmSUSOwf9PdUv9dOZ/NGN7ELqc+8Pa+wFIGf3?=
 =?us-ascii?Q?wq17xyYs6bWEiePsoFJ3N28hf+N/rQSIzcEBlLAB58yP/SPN723D4zxHKqGh?=
 =?us-ascii?Q?mXqXOEdNKf5AxSoS3YmmhhfjiprwShT4R6I3poJlzQiJZE+SqV0IRji/UuTt?=
 =?us-ascii?Q?Guw3CiqqDT76RoAWsNjK0RqqUdBtoBEL0LlWjgJ2LhfqvY3Py1DRbDG/u2V+?=
 =?us-ascii?Q?5e/2aee+4PAKTTxl2oqvTqgWbTnVtukZYB72II+xjo/bqF75K0+KhBolZ2Oz?=
 =?us-ascii?Q?7l67qidaTJACWXPLof3B1qjcfSpakj6Xyhf8RGDOeEDzuvasxevX7rxNZjhz?=
 =?us-ascii?Q?8Q9GQ2eH5BO8uNEPQuqMtSpV8pH0J/eVNX4fDjDzjetiRvNU22+PAXtFtyEh?=
 =?us-ascii?Q?oOAwkvsn29JwC7KBK/tgqiMc8/CYSWj6kr1wuwx4MXiPYkpWoyfzZvOwX/Qu?=
 =?us-ascii?Q?vz6yYK4Aj6v8Qb4Y3gc+ValrqGFPBWfa0xDJ6RHXrRfcWEdfYIac0ZEfn0cD?=
 =?us-ascii?Q?ry6J7mvCTsxRL/nNBs5YPFroeeLkqAe4mZNaVxqshRNF9KT7MNJphtUKaQOQ?=
 =?us-ascii?Q?EQq5k8jNEwTkwZmdoXw4y3J8/rHz/wGGHEquDZIEIaL7Qmr4dpbHnYzids2O?=
 =?us-ascii?Q?fLa2trBUvJ1jH0fcNcRTBS8eduKVr+ib/BS7sDCdvAm2J8uno5LHrziXWJC/?=
 =?us-ascii?Q?7azB9+Wamt+5TujVYUDJLq2/y7DUB4LZmrgKfg4U5HfwFvNE4cLXdOOnNf4w?=
 =?us-ascii?Q?Fh9IhkNXrQrhnZt7spvzGp8nCXlGpx391WQk8iouHtLvqySxEnzmPP5Hx4xe?=
 =?us-ascii?Q?gAbJ/74+gjkE8zaiVYc5ZXZ6zVQdwspOAq7bR8tNWsCvVM9caCbBDfuHm9Ci?=
 =?us-ascii?Q?eLJ9KtQU/tQd23WF5ogNegmM3S5YyGihV3oSEkhR9Nj8fUJk/Hz9w4LTyobV?=
 =?us-ascii?Q?ek13/IK9vzyH7mqaxbgdvgu6J7r7C7AvyU48kWKHY6FCt5cWRj6mwUzgNRYH?=
 =?us-ascii?Q?tfb2yzIo7Ls163RTdV1q81PBJpAp13YCAV2G6VTXBINiwNYWhK7TPrHnu9nn?=
 =?us-ascii?Q?Ti8xTbhFdae2CKa97RGQn/5/Rp4Zz0h/vwT24/1iHaKG21U9oNzUvKZrZLqh?=
 =?us-ascii?Q?OaqOCF3bvA1yEryBOqnL8owQs46Hepu9evDmv4tjmUY2iAiGJvr79bCUvv7a?=
 =?us-ascii?Q?hkQAXcW89Bk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?osdfLXAtbHY/J4Iy+tqJv5jbB9o7+voRKvE5B518xti7nspF6/nwju4LPaDn?=
 =?us-ascii?Q?nC9I5Zt585jCNo2ljT6zPsFZm61QWfYbsvRm8jHdDNza1wcf7IEWC5R7Vjhb?=
 =?us-ascii?Q?CuTVL2bhgCmvRQm/3YOOLXnBOnZTbT/T9VPUOduOrt4iowiifAWTSr0BWlVC?=
 =?us-ascii?Q?rxEfeOcqlfzR9v9UyLiiSiF9eDQMxSWWSbABX4GYrvpX2D69DHfaytSoZCva?=
 =?us-ascii?Q?qHFGRtozpdQ5sGDsLE+gIEo4G/PW+Y9XHbk1lKl75mEt3V1vl3xtOy0c0XdY?=
 =?us-ascii?Q?XOREq1YDpfvv/ix1fipCJlIO9Hbmgk/BUdXIu4IpyoSLnnYAarJN584al01A?=
 =?us-ascii?Q?zHArREwSfCNc5yDYSFHVU+EVSlMbut9pSLpyoxSSSi8mdJoVfX3dWMa3fQkL?=
 =?us-ascii?Q?eDWnNU72tlSzxeINy/d5AdH2f8yejUOl2ty7Xdure1zdIRfoKjy6mOdscmzV?=
 =?us-ascii?Q?KKwkSaObC/b/1q6cO9T9qb/FWSNfAtcfM2wBIaeuyNVooJ/AblLmxrUNgtcW?=
 =?us-ascii?Q?Stebnl7LCM0GoQ7OzdXReVcR20Mr12waD+yiLmYnM/66JzTox9M8psTUZIF8?=
 =?us-ascii?Q?s5IqubbqIF1xyo3KbrI5tw1dl+hYPf1pl/z8E2rAWVwuGsz8taWVjCUdLA36?=
 =?us-ascii?Q?8LiX1VjvypdPPhVxUdzM8xgouSCZ/byLWNoE1VjWyDkmEH3NtOlwJu5iQgZy?=
 =?us-ascii?Q?843utIK7n4igwrDaex8EqyZ1R3ck5IHMTAuaEDfd6TOD0qs9rW4nlLNHezgt?=
 =?us-ascii?Q?rrEsivPQtfMFPU3/1dTQDLWF3CdzGw8tjLYju6KdODz3MsmJ4KyJYrzTYkmN?=
 =?us-ascii?Q?nEbpxrR42tN7h4MR1+Awkdoh78kZI3jeJFzQK9Wxi9xoy2UoIgOYGqYJ/2JR?=
 =?us-ascii?Q?W5EXfTAZ/nwzpOwW6ilwXetmIZnjbwssd/WeeHz/DYF9nVpCmzTvYW0UH2Ee?=
 =?us-ascii?Q?S3FZLFcHP/x48zeogjQR28YPvKAjXh5cd6EpFz13yOWxnwmFpxSL3qi7W/5S?=
 =?us-ascii?Q?N4XEQRtdWfzGVr3ocen4tOOvhAtygh6ju57U/tLvszL09QRn9Mu7XUC0t6MG?=
 =?us-ascii?Q?JknnczAw7wqPWdxMUgbt5NxRWrS8BDhQfaLUQAcyZRtjc1jxwwZAL16opOXL?=
 =?us-ascii?Q?RTemHtdowN1iy6zty9bAVWigDnSkqd8U0JH+wUZjtGh3uSgymfVG4o9GTjWl?=
 =?us-ascii?Q?TDaIESmmPiVsaYvAAbqdH6oNZz40C8SjNlUfDKBuX7PKbpxuowz41M8YoYfI?=
 =?us-ascii?Q?NikwMQ6KA8zCfxUwLRFPOmqI9MdzXRWUDqYrl/peTZtRpDqgHwdlNqrFV8j2?=
 =?us-ascii?Q?xRoFR00JFtIzYpL2B0/P+xyeaYwiA7pE/6Q4BgVie4tH3MNUuEsq890CdEEx?=
 =?us-ascii?Q?KAjKtQRKFnKiYsr99jMHamY4NNGjjZc30jAPV/OOUsaH/f4816OPSBAN40S/?=
 =?us-ascii?Q?OD9vv1pHeoHY0Kt00VteT/BkDR6+wxdgIPJMbnqwn2vxZ+Fq4S2YKV7/BEu9?=
 =?us-ascii?Q?AamTDtCRpjGq7A+D4CdZYqOd8lkRGkNHuZl1DjawsaGtWWv/MFWIi6XaDe1r?=
 =?us-ascii?Q?c1WyiMTCfjP8vh0lj9/gZ1pSh70TN/BlFkMQYH8hccSVrHQhSlBIVWkfr51j?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a732695-18c5-427a-e7eb-08ddbd0077c1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 02:46:26.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEa6LaEXZw0V9tnZLoNBfDaIniJk8LT4ihKQqvB096P00QAvxp07b7h7WNVfyVMom8SszCFmjnCWw+YTRXJaILz6ULUaXl7cEVftGqGmYk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-Proofpoint-GUID: nFjfBq4H8Q8W1c7OXk8D5oSd1ofgswP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAxNiBTYWx0ZWRfX140AHjFW+Ajm oDhIIyVf8Mi1lFjF48uno7dVfvFkJqndCOlcQ1XISibgbKxsYFA4Ms212KZLJEEB8BK/FSm5HQ+ meaWQve+4WESHwU30SJyHtKCQa8p/OFIlmLczYZMGgktFPd40y56Ob4Bfm0sYCLn41yMvdNmOi/
 ibzFGjomb7rdj6wq0ECd6GjGiMXWrqj4asSzfzPih3Jl3WaYx0qfSUr7+UAdFGXw0MeTWV48cVb Btlc3lUKU+KD9NqqBsIEMNoE26RHUEsFTsmNfOOI3LYsprsZzQLZZQ7u05iXcHWR+oKejWqwoxW lgh1FeyFuMeVTv2CJuKVP90Ae4k07V2eHWqj1ghkEnVOep2ZQmaMJFMMUyh23iOFZGy/k/CYkiW
 XZrEiUphjA4lB2hUvxlFHM3/kPS5Pa/kyJMrdqbBFFTA+PAO8jy8wBdfp/+u/yfn/RWsaq0w
X-Proofpoint-ORIG-GUID: nFjfBq4H8Q8W1c7OXk8D5oSd1ofgswP5
X-Authority-Analysis: v=2.4 cv=fv3cZE4f c=1 sm=1 tr=0 ts=686b3505 cx=c_pps a=9V7jihFXCHj8+gr6vrtDPw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=nDJU2pNIAAAA:8 a=t7CeM3EgAAAA:8 a=u-Ki5qhF6FRpIUQTSuQA:9 a=cvUpGn6QkLxiVzwzn9tb:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507070016
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 02:46:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1769

From: Haixiao Yan <haixiao.yan.cn@windriver.com>

Convert CuTest output to follow Automake-compatible format
(PASS:/FAIL:) so that ptest-runner can correctly parse and
report test results.

root@qemux86-64:~# ptest-runner samhain-standalone -t 3600
START: ptest-runner
2025-07-06T09:38
BEGIN: /usr/lib64/samhain-standalone/ptest
PASS: Test_quote_string_ok
PASS: Test_unquote_string_ok
PASS: Test_csv_escape_ok
PASS: Test_tiger
PASS: Test_tiger_file
PASS: Test_tiger_file_with_length
PASS: Test_sh_tools_safe_name_01
PASS: Test_sh_tools_safe_name_02
PASS: Test_sh_tools_safe_name_03
PASS: Test_sh_tools_safe_name_04
PASS: Test_sh_tools_safe_name_05
PASS: Test_sh_tools_safe_name_06
PASS: Test_sh_tools_safe_name_07
PASS: Test_is_numeric_01
PASS: Test_dnmalloc
PASS: Test_sh_unix_lookup_page
PASS: Test_sl_strlcpy
PASS: Test_sl_strlcat
PASS: Test_sh_util_acl_compact
PASS: Test_sh_util_strdup_ok
PASS: Test_sh_util_strconcat_ok
PASS: Test_sh_util_base64_enc_ok
PASS: Test_sh_util_dirname_ok
PASS: Test_sh_util_basename_ok
PASS: Test_sh_util_utf8_ok
PASS: Test_sh_util_obscure_ok
PASS: Test_sl_stale
PASS: Test_sl_snprintf
PASS: Test_sl_ts_strncmp
PASS: Test_sl_strcasecmp
PASS: Test_zAVLTree
PASS: Test_sha256
PASS: Test_entropy
PASS: Test_fifo
PASS: Test_file_lists
PASS: Test_file_dequote
PASS: Test_uuid
PASS: Test_ignore_ok
PASS: Test_inotify
PASS: Test_ipvx
PASS: Test_login
PASS: Test_login
PASS: Test_portcheck_lists
PASS: Test_processcheck_watchlist_ok
PASS: Test_processcheck_listhandle_ok
PASS: Test_restrict
PASS: Test_cmdlist
PASS: Test_srp
PASS: Test_string

DURATION: 0
END: /usr/lib64/samhain-standalone/ptest
2025-07-06T09:38
STOP: ptest-runner
TOTAL: 1 FAIL: 0
root@qemux86-64:~#

Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
 ...t-output-to-match-Automake-standards.patch | 102 ++++++++++++++++++
 recipes-ids/samhain/samhain.inc               |   1 +
 2 files changed, 103 insertions(+)
 create mode 100644 recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch

diff --git a/recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch b/recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch
new file mode 100644
index 000000000000..eccd24290ce1
--- /dev/null
+++ b/recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch
@@ -0,0 +1,102 @@
+From 065813e5ec274942c4e8803d813ae863fb17313f Mon Sep 17 00:00:00 2001
+From: Haixiao Yan <haixiao.yan.cn@windriver.com>
+Date: Sun, 6 Jul 2025 14:34:08 +0800
+Subject: [PATCH] Format test output to match Automake standards
+
+Upstream-Status: Pending
+
+Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
+---
+ src/CuTest.c      | 63 +++++++++++++++--------------------------------
+ src/make-tests.sh |  1 -
+ 2 files changed, 20 insertions(+), 44 deletions(-)
+
+diff --git a/src/CuTest.c b/src/CuTest.c
+index c1884daedbd8..44007fdb97ff 100644
+--- a/src/CuTest.c
++++ b/src/CuTest.c
+@@ -302,49 +302,26 @@ void CuSuiteRun(CuSuite* testSuite)
+ 	}
+ }
+ 
+-void CuSuiteSummary(CuSuite* testSuite, CuString* summary)
+-{
+-	int i;
+-	for (i = 0 ; i < testSuite->count ; ++i)
+-	{
+-		CuTest* testCase = testSuite->list[i];
+-		CuStringAppend(summary, testCase->failed ? "F" : ".");
+-	}
+-	CuStringAppend(summary, "\n\n");
+-}
+-
+ void CuSuiteDetails(CuSuite* testSuite, CuString* details)
+ {
+-	int i;
+-	int failCount = 0;
+-
+-	if (testSuite->failCount == 0)
+-	{
+-		int passCount = testSuite->count - testSuite->failCount;
+-		const char* testWord = passCount == 1 ? "test" : "tests";
+-		CuStringAppendFormat(details, "OK (%d %s)\n", passCount, testWord);
+-	}
+-	else
+-	{
+-		if (testSuite->failCount == 1)
+-			CuStringAppend(details, "There was 1 failure:\n");
+-		else
+-			CuStringAppendFormat(details, "There were %d failures:\n", testSuite->failCount);
+-
+-		for (i = 0 ; i < testSuite->count ; ++i)
+-		{
+-			CuTest* testCase = testSuite->list[i];
+-			if (testCase->failed)
+-			{
+-				failCount++;
+-				CuStringAppendFormat(details, "%d) %s: %s\n",
+-					failCount, testCase->name, testCase->message);
+-			}
+-		}
+-		CuStringAppend(details, "\n!!!FAILURES!!!\n");
+-
+-		CuStringAppendFormat(details, "Runs: %d ",   testSuite->count);
+-		CuStringAppendFormat(details, "Passes: %d ", testSuite->count - testSuite->failCount);
+-		CuStringAppendFormat(details, "Fails: %d\n",  testSuite->failCount);
+-	}
++    int i;
++
++    for (i = 0; i < testSuite->count; ++i)
++    {
++        CuTest* testCase = testSuite->list[i];
++        if (testCase->failed)
++        {
++            CuStringAppendFormat(details, "FAIL: %s\n", testCase->name);
++        }
++        else
++        {
++            CuStringAppendFormat(details, "PASS: %s\n", testCase->name);
++        }
++    }
++
++    CuStringAppend(details, "\n");
++    CuStringAppendFormat(details, "# TOTAL: %d\n", testSuite->count);
++    CuStringAppendFormat(details, "# PASS:  %d\n", testSuite->count - testSuite->failCount);
++    CuStringAppendFormat(details, "# FAIL:  %d\n", testSuite->failCount);
+ }
++
+diff --git a/src/make-tests.sh b/src/make-tests.sh
+index b6cf814e7030..01399ca75775 100755
+--- a/src/make-tests.sh
++++ b/src/make-tests.sh
+@@ -45,7 +45,6 @@ cat $FILES | grep '^void Test' |
+ echo \
+ '
+     CuSuiteRun(suite);
+-    CuSuiteSummary(suite, output);
+     CuSuiteDetails(suite, output);
+     if (suite->failCount > 0)
+       fprintf(stderr, "%s%c", output->buffer, 0x0A);
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index 6b8d30e1bcdb..fc4e4237fe2a 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -19,6 +19,7 @@ SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://0008-Add-LDFLAGS-variable-for-compiling-samhain_setpwd.patch \
            file://0009-fix-build-with-new-version-attr.patch \
            file://0010-Fix-initializer-element-is-not-constant.patch \
+           file://0001-Format-test-output-to-match-Automake-standards.patch \
            "
 
 SRC_URI[sha256sum] = "0b5d3534fd60ecf45dfd79bd415e81f7a56eba7f1755771735e204f334033578"
-- 
2.34.1


