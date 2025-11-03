Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDE0CCFA00
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 02:19:16 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11942.1762136349636688864
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 02 Nov 2025 18:19:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=BDyw12ph;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3402980684=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A324X89739900;
	Sun, 2 Nov 2025 18:19:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=SMN3XVBSn
	fQU0wJoVEHmu18j2wELGPjBZsLkg8ghMX8=; b=BDyw12phuw+3DgYyGqBy/mNul
	G0tVOcE3nuoOZsAA+wVsCdV9/wzv/ZefG/ANY5ihsV6iAledB/RJDvQW+D7lVQRp
	CJAWh1dARwhgNiThcLlFfHFFdc1anCQG2ubUdNRXZkmWJBB7z7fp5ly0HLsjckUx
	1KM4Z1vSxB/h9d2eLIA3boOHUTtDa9GcM7TRhQNdJUburDF6Mbs//ILjwNk/Owmf
	5eWA+n3XJuavqdVZP3AioBUyFpLTtWmTEedbrV0xM8ceNuoPgpN5uH1xRsC4M2Xt
	nLz8pkaky5oL9XV1Gb4IC+ezHsWcC+0WDoRRWUFZzo9wxF0blA/nvBSntD/RQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a5dfy14ts-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 02 Nov 2025 18:19:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJ1E3VtHJbL71pSvKFng6hPkr7QgtA8zDzt+PWuVghngJ8Ydi5/AybuEB7C0X2mDF2mEx2DNxRgUk+3cIMtNL9Ig5Vz1hzXERJBXr5LAKT+61tCp8tmZ8uk2ZZNrCzQLJnS2H0BPe6R4JH83Iga7bLRnd8fwQwHKYKtvH1rOZcRcvGIvVaTQ4CxpDS7ZYdsjBO04jN5gTgCJazHtbSqZg/frxu8X/SMghMEdLOKVvTrcJZfQqF3s08/47J6OuidgYY3dl2eVkvboZOo+y2ClisBTjvkwqaeU/hEE5l0J0mauKPErXpd3p9jo4u3bwAZKgedWeHueuWn9t6ZTNg4iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMN3XVBSnfQU0wJoVEHmu18j2wELGPjBZsLkg8ghMX8=;
 b=CY1W0nGZx0YrfxHvFahNMAy/AtauojFCfrIFrA9Thw9/rlB2HHeydcFl+aMld3LEG5tORaBUN0UD/OMRYCmU/fGBnncEH40t6pYLg1cWxvbWesgRw7sjv9EwYnGIA9K7bpLLVtvi993yt14y/jTj8N5QR1K/kYVumBRq4knUEdZJvfQW97icmHwJP25K+tUEZgDVmaNXxVOoEsLAE4bYvUaqvennuhvStjLSgMAClXVM+3bR3+pjzRgUjJ3hT1eYG4mkuyOJl3N6X7wOBvsAXwxuq/uc5ivhZpPw9SUiwoUHOrF3O1B3Kqa0SWZ8nmfD5RMU54CkYcj74mw9OTECEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH7PR11MB8058.namprd11.prod.outlook.com (2603:10b6:510:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Mon, 3 Nov
 2025 02:19:06 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 02:19:06 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com, qi.chen@windriver.com, paul@pbarker.dev
Subject: [meta-mingw][PATCH V2] meta-mingw: support generating Windows SDK with no symlink
Date: Mon,  3 Nov 2025 10:18:48 +0800
Message-Id: <20251103021848.3068540-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU1PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:802:18::21) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH7PR11MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 320a0cb7-d42c-4ae6-fe30-08de1a7f5d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uGgo3i+PM9zC6T8/rIRqBCcPuD/f3IhDAVErkMO388DrTArOuAka1USqsd14?=
 =?us-ascii?Q?EaE65zN4zpwAGBGbGEjqlieJJ4avHEVgYGQE4bjj9HROvEsfZlfGgp9o1FjJ?=
 =?us-ascii?Q?fq+0w7qGyO3cljA9+sRvlLnaO8gINaFVYbgkjN1HmiotBX7z3XkLU6HhLxEN?=
 =?us-ascii?Q?M/x6eE+ErQqnlXeCHXvujvNINjSAgwQXPHyQWWpI7QIF3KTr/36MXfRODYJu?=
 =?us-ascii?Q?Q4O53sL9RLI7w6tfzou51cS0Nz2cVk7vprGOYJLOti0fZinZQG33yzjN5gjt?=
 =?us-ascii?Q?ZRo5EvCuOVMGNYEyCTRQvF8zZg+LLU/fO4hRAuBFbtr/S9u8xLFSVo+P63kj?=
 =?us-ascii?Q?o5S4ThyRUlsMgkJNx/tcQkUjxj0Z1TN5p/6xHQVbVuQipQEINL0U2V+xHFvz?=
 =?us-ascii?Q?jf73EIHYEP9FSUd5VgHAgiHLR10fZ0cXy4rKhhRbNlvGjVtCHztBPXacKfB4?=
 =?us-ascii?Q?ySB05Pf9f6kMiEDUsDQA3h3pc0Q6H//sAbm2UyAidJl3TyDwT4qmfRhPU8Ul?=
 =?us-ascii?Q?qIrGvFcXffvh/8TGIXzuInA+i8zMdjd8qXt1YwyL3fXFgUyKweJ9bt723wK4?=
 =?us-ascii?Q?LjVDVQq9WQeeqKBEWfZV25Z66ZAQvCS3BpBMimQPPWpof+Qg8hMJVptnz8Qz?=
 =?us-ascii?Q?Fud2JRwM4auBkXwoLYUu552+mv2dNNFhZZUCRxUBCGtSYX7rQQKhDiQrGuFf?=
 =?us-ascii?Q?2EePCU4NdzLq3lgGK5QHkSjyjgS//AhRJ7iM6+lZRKdiC1mq4c05/kzK5l/u?=
 =?us-ascii?Q?4iMoWZNS+6n7YekeBhYFHXOt3SqhviLXQ51iN+YaLwrQbD9n2AOTyUaD6dOx?=
 =?us-ascii?Q?XI5Hufo0SqZ7q0gBB4l+wfUldzrY0sKdZj2921wUOi9SFrtskLwC+NXfOGwj?=
 =?us-ascii?Q?/ts/yH1xPbug668v7btMflLBtDVMGNkt6tVHTCVwGtQ+aYOn1VXbvNQD9nn4?=
 =?us-ascii?Q?wUV4/xy8nO5pKlFQw4sRV4RSDO1odWShmngVxG2M7Pvn7eVE/Chl9rvBUKCA?=
 =?us-ascii?Q?1WJSvwQ4uq4vsBOBEGNHYB7GRCVNdgpCHU8KWlmTs0Iyr4K/mEK6dQH420X9?=
 =?us-ascii?Q?Q3zTKTUBO7r1pVUp+aJ0spKCfaZIAjwWqLqf6ztIdB+KsKHfFHq68EOQKdCE?=
 =?us-ascii?Q?XM2QcYss7MkLg8UOHGiXwgbolrUiD0h7IqRgfnTkDwrOJ0tSmpYwhidKDRkU?=
 =?us-ascii?Q?iakFZzaWDrYMvm4loLMwk2m7X4fQm1RhkE6yWlSSeYNONM5F90f/vVL5azxF?=
 =?us-ascii?Q?w3UFKnM3mgPkakxeMbMr5kEDGJr6rdsziaLjnbiwgt9XGuIpwwWKtsJ9dkXa?=
 =?us-ascii?Q?E/fWIy1fBtfP+tJi8B4QXD9IA3reM1y53c5RVfZUidSTTCfwUXx4rcZfLfcX?=
 =?us-ascii?Q?fk7A7PfGxBS9hRWaalrKi38ZHINXR/QdL/cm5Bx8NPrWRbgXShAJawDO9zaB?=
 =?us-ascii?Q?ZEYrjhKu7ANSH6+B+EA+vT+CuZMnlyc5UPBmQ3d173kDt+yZUpdkl0uakAg6?=
 =?us-ascii?Q?tCQ/xUq9zvoMPgyH4ZqX+dFtElNxMSLOZ3MP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ldrO1rXHOF1Dr7AellfBwVo9oFbEE/Gp2bvf+sHHt+Yez4+z106m4AFuJNP4?=
 =?us-ascii?Q?QGHmyn9Ik/qItWPuanLuekkhjby9susQxK6Plp8p80vCgOVXHjTtCllFc/o1?=
 =?us-ascii?Q?AZ5zfHxjllwVS6oZGVQzC7fYKlCU7RrqWFFlC+Fhquob3qy2/WaJGNEsfS80?=
 =?us-ascii?Q?P97bsOO1JNl3FvVj7tAEWcMJ5SNYrF4hh0U4EYxVS4jnu5YAt0EDJPVafFoP?=
 =?us-ascii?Q?fo9YvQKbRxPTf6c9hb7QAQnLDuu7FvaJXzJqhwcd4JhFQO2+mqkIfjweykYc?=
 =?us-ascii?Q?C2Dn1qJzHZ0o7fxTaboetddqFRdaIuTo6Gqd5pqz0FavtpvIZ1L6MZLMkf0Q?=
 =?us-ascii?Q?ojzz2mYjs6Y0hYVsKDmvyEdPXSrK/TptJrU6FPwX2FZblifCwMyO6i/aAAza?=
 =?us-ascii?Q?nalPnkVUGwbWkShYIA2FZM45TIPEgf1SuoHBlZ3meWkAzrIac0p4uZEIPdaL?=
 =?us-ascii?Q?EarRLI3Y/OQ7NG13oKGePV1mjZlTeOeeGLbEZoICEA1RR8g0gKg+t4R8Jfq5?=
 =?us-ascii?Q?+D1QG9RwZr53GNTper1PRgKAk6JOTQz3nlu4ZEu0gCpFoXy5eSBQQ1N3HtWu?=
 =?us-ascii?Q?8pkpekl6CsStQYeyIth4BHQsXX2xTKrfmTXi8ASojYfG2cga8Hm6oylF4jEq?=
 =?us-ascii?Q?kHpa7mo2RBCFhAQJmEnUDgyw3zBd7o/Eo79G2TbfuDMg/Z/r0zobmugrGc9K?=
 =?us-ascii?Q?gpl4JUu9pnAiDEM7+I/Djo46hM/G1dKbC0qFVUhbgHN/lfUC1/AVaBwZCsvh?=
 =?us-ascii?Q?HEWXyIkiBF5fwIw98KZ11Q9ZdXBIduPC/fBR9LgVov4HTziRSG+0M0QqG3hh?=
 =?us-ascii?Q?am7ZhLSzWcFXZHxERrIdNI+UwcxUW1PO2/RXMX1J4MIi0joeqOhb4f50Mv6x?=
 =?us-ascii?Q?rO+Jys7BJeJQs2hY4pz57VPqHdJPdL55V3AkFhQrNtdBuYZUjfjqo6Dd9xYt?=
 =?us-ascii?Q?ICmFC0fA8eAybru858AOiIXnjynYSCcs9AlOzpVdIoQ2tl9Vv2yPupvPy03F?=
 =?us-ascii?Q?QnTfULFoocs9BGcg07pHSHd+MEvDQWlAhw9IxlMONAKBzunFJwAiaAGVe+Ky?=
 =?us-ascii?Q?zipvV81p52RZkCIqRo4PrMdbph30ad6SK/nWhJFt1wzgCMlvXlrnfgo86A8H?=
 =?us-ascii?Q?pUkF/oau+Uv615LROrELSw3nZNapa2YCC+jgGZhxmbErVK5QhJUnMouDFdGt?=
 =?us-ascii?Q?z0hQANMFdY07o6+/Rzd8n5go3o6TnmYBvugWAVMSwuW8gbcaHgrMwR7NmMi/?=
 =?us-ascii?Q?dB+F/kvgWRS+RgXVz/gT1z5KStOSvO1abEycm3whoxJgCFLpTEnJvaUQSVzN?=
 =?us-ascii?Q?RAAYL7segilafPNKHtbpwAvNRWsllF4+I5p/VXhdWKhzH4kzyYwA2uxB4WHA?=
 =?us-ascii?Q?BKyJQKLenf8ibjk9NkKROQ0zDzYt/q/N0lRnu3l9zMG9Cxq6PshzSouDRGhk?=
 =?us-ascii?Q?4hUYrSorQcl6X8qWw5ASvVIGsXzOb+AsVnjUnCuWOvLth96oYeZI05gDiVec?=
 =?us-ascii?Q?UsJiqVAmBW/UM0DsbqUg5AuV5I6a3X0EbkrL8PtaPtl6pun7ltBPqmRSOzP+?=
 =?us-ascii?Q?fsWkjWquqjUI096X+Se9XKed2peoEosMXIxZvrxx?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320a0cb7-d42c-4ae6-fe30-08de1a7f5d21
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 02:19:06.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0va3C4/HpMW8FMDYCQffE2/K2hCP1oNfeImy5uzogp6p33+fCxQk1UkLxxF+AJtlbopTIp4XVUorbnAp22jHRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8058
X-Authority-Analysis: v=2.4 cv=G5QR0tk5 c=1 sm=1 tr=0 ts=6908111c cx=c_pps
 a=VTZ9QiboGVM1ljQMw9N7kA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=LtwcJJPwdmsIudEpcK8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: LMoo_F1Te3e127bhvWAilQslBwo3Jz47
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDAxOSBTYWx0ZWRfX8U45bFITAsCo
 W0tYQ90oYwuWzbUhs2xTc176yVjsYW1BUc/sNyo/pv+cZUDphwD6N55nuT526cyz1mk+b/w6w7n
 6AG8e5Rr1wGxkNJytHyT+322+4yBwfftzF8bF2evN8xLWfldjHJ2kl0aVtmeVEfgQSk4ttEgdr5
 RsKbR7qGp79emcorhUsF0GsJxLdjeeT54ULz+zLN2T7u4y+2txxNyVwzunJOKOAdh8BJJJvBLHj
 KDQFA7bOkoGdOKzaLfqpoXr/g/5jDqsIJUPKXcrdloq49AgjU+Rc5fKhfYRiKIZzfAuZxIl6qX0
 pKA6Tn4swqnSM1NwpvJ3IPLUi8nSVG+zN4TZGh98fX2emJt+JdGx1HPzr/+gAQvMCowLJD/hedF
 oIChXibTBYwXprqYEQW3JU14ZrR90g==
X-Proofpoint-GUID: LMoo_F1Te3e127bhvWAilQslBwo3Jz47
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030019
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 03 Nov 2025 02:19:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2411

From: Chen Qi <Qi.Chen@windriver.com>

On some Windows systems, symlinks are not allowed due to IT policy.
We need to be able to generate Windows SDK without symlinks.

To do this, a new variable, WINSDK_NO_SYMLINK, and a new bbclass,
mingw_sdk_handle_symlink.bbclass, are introduced to achieve this.

By default, things work as before; when setting WINSDK_NO_SYMLINK
to "1", SDK will replace all symlinks with the actual contents.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 classes/mingw_sdk_handle_symlink.bbclass    | 25 +++++++++++++++++++++
 conf/machine-sdk/include/mingw32-common.inc |  3 +++
 2 files changed, 28 insertions(+)
 create mode 100644 classes/mingw_sdk_handle_symlink.bbclass

diff --git a/classes/mingw_sdk_handle_symlink.bbclass b/classes/mingw_sdk_handle_symlink.bbclass
new file mode 100644
index 0000000..2f6dbe6
--- /dev/null
+++ b/classes/mingw_sdk_handle_symlink.bbclass
@@ -0,0 +1,25 @@
+WINSDK_NO_SYMLINK ?= "0"
+
+archive_sdk:prepend:sdkmingw32 () {
+	if [ "${WINSDK_NO_SYMLINK}" = "1" ]; then
+		for parse_type in "file" "directory"; do
+			find "${SDK_OUTPUT}/${SDKPATH}" -type l -print0 | while IFS= read -r -d '' symlink; do
+				target=$(readlink -f "$symlink" || echo "NOTVALID")
+				if [ "$target" = "NOTVALID" ]; then
+					continue
+				fi
+				if [ ! -e "$target" ]; then
+					continue
+				elif [ -d "$target" ]; then
+					if [ "$parse_type" = "directory" ]; then
+						rm "$symlink" && cp -r "$target" "$symlink"
+					fi
+				else
+					if [ "$parse_type" = "file" ]; then
+						rm "$symlink" && cp "$target" "$symlink"
+					fi
+				fi
+			done
+		done
+	fi
+}
diff --git a/conf/machine-sdk/include/mingw32-common.inc b/conf/machine-sdk/include/mingw32-common.inc
index 56b8052..bf3f14e 100644
--- a/conf/machine-sdk/include/mingw32-common.inc
+++ b/conf/machine-sdk/include/mingw32-common.inc
@@ -59,3 +59,6 @@ GCCPIE:mingw32 = ""
 
 # wine and wineserver are required to test MinGW SDKs
 HOSTTOOLS_NONFATAL += "wine wineserver"
+
+# handle symlinks
+INHERIT += "mingw_sdk_handle_symlink"
-- 
2.34.1


