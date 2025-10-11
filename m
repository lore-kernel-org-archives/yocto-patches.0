Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C1DCCD184
	for <webhook@archiver.kernel.org>; Sat, 11 Oct 2025 09:54:23 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.8110.1760176454312521034
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 11 Oct 2025 02:54:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=an6fQR9l;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=23790b5689=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59B9d3p3578546;
	Sat, 11 Oct 2025 09:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=7l1QH1AWD
	Jmzbw1QSd2+BGwPVRsKyA5FiJAmDbG7Ocw=; b=an6fQR9lhG29Uo2nSQzsRCpTR
	0NUlbgK504mhmB6wWNQtMp5CQJI6ffe6aqqtolgMelv2GhH4LHAZkb8+OxABcpj8
	dqqhvrRhAn5SXtzcpzWJda0IKfppmCOvuiQqKQUM8XntE475lOi7obvqeqekejO3
	pf4FVy7D+VS1EWnaL8fNGvoBODVeWxNGNIuLd7SggPxq+TzWv0kXg4BFSCZMcU1s
	U44e3qldOredq1Bak+BwPDaOdurTE0nbt94iw5nFC+CGJY5jLw9hBC9arpntTPxL
	NZ3FLLmE2odULhUDkT02FgFFviFrsKyoCd2Qa+clt+qVZBoyU5JOXuwu3TCGA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qe7687n5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 11 Oct 2025 09:54:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Snaygp0NDZwf1Pmc8+2IukEAtocgqISRcn+H7mOoNbSZee/yeMnUhBtWNZ5edZxoBEjNsEwhZIkjfVOK2DY2x+enFGwSWr298I7iLym/tHkXzlvAlabBIaJCh6kY9vPaBSFfLPLzNIA5wCNalAqVbuWsXDTGoNp1s8PIgYhaPPG403baW619ZgrFKBmYyyoMdK0mrLWe/uDnbprBCUgkBUQWssQ4he29Gs/jXCjVBLiqn1weAXOC6hyLg6p1XzdyJiBeIxlZtf+DrPxhrXOJRFnZhtR/i+MAHAFticxgHkHiKoamzSKVoUZJIUhbX7laOUvC9h7RQdhQnhrTCQoNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7l1QH1AWDJmzbw1QSd2+BGwPVRsKyA5FiJAmDbG7Ocw=;
 b=MjwCbgJpd2slZBEpYMlk8YT/ahNKOcsS7p/4kWWvmZeQpb560e+VdzkmtFdgiGiBkMsRbbOUJCDsd0t1jfkLSzLTliCGWYqP5a01RkYc79vfWeT/OibP3PoBPNJaxugDAAVIMkEMRWa+R2LNWnO5V0RXwY6UrtAIX7k4JDw8YVxxIFW4XMa/nGlhqdjhva5wljdFZNyl/l6LweMSkUnJ4Wjf9umTr0sJOLGWO3l692BghHlB9vjePtbpCJCFI98jETUfEQfApeOuctNwoZcl2DHCqXc4/TUQKSkw4OUhYGGYDx5oDbp2qGjdm0izgzLpB1mH7cmuedeYdk5JW+P/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SA3PR11MB7536.namprd11.prod.outlook.com (2603:10b6:806:320::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:54:08 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 09:54:08 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com
Subject: [meta-security][PATCH 1/3] openscap: upgrade 1.4.1 -> 1.4.2
Date: Sat, 11 Oct 2025 17:53:51 +0800
Message-Id: <20251011095353.2909174-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::19) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SA3PR11MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 290b81fb-e189-4a84-76ce-08de08ac1f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XcwEh7J9GYRCJdT9y1hiFkvMSyQD38MDaCRTodx6ydJvWXExxxc+egii89Yg?=
 =?us-ascii?Q?36D6Hgre8PM8cf3K3llYkg+CRKUHrkhuzbNYLi5i6D2nhp3pAs3IFCklMp6c?=
 =?us-ascii?Q?hPIBV/h2FwxqOAdHzp+F3JTbSG8zNvBM0mlSRS96CNbkoXX8qCqELBHZhN79?=
 =?us-ascii?Q?Uv2Ta1TpVuGQ4LyL1R6qbrPaXXHhFoInX8A1uzwHyO6L/qMZgyJLOgd5Ro8U?=
 =?us-ascii?Q?pcS3sO6+vlD1Pmam2mUWiLojFqbPWUyAy0pTVQpmy5oibpfX9axLiOCqc1nP?=
 =?us-ascii?Q?H9AkkMtPTdLecE7lSqcFWh5dXShPbcTNZdaYT+B3IE6G1K5BNCBzwPXJ3USN?=
 =?us-ascii?Q?f7xGdb870YlPUWAhIkIdgnXtPba3ZX9wnGJTvG9zS15I3cN6o4TyPE/oSGAl?=
 =?us-ascii?Q?0sCX2P2dd1Mg03oJoIO56mJ9D64vcqSa50Ga/UDxV6NfFf1QRTBTbVZs8l0f?=
 =?us-ascii?Q?LI/jTGjspQfPVOq21DB9c6hO80x5zBnrw1S5d+ByAp7f783lKc9b5tPDurOL?=
 =?us-ascii?Q?G1hv1IW0QdguxF5tBdoA2TBxLaqFNauQ+7PyirpCs5ByFjWtuj3793r58sCZ?=
 =?us-ascii?Q?RcIiKdFRjlXeftcCR2nPZXCUmQf20hgW1hKxCigMJk0Wn5GJEyj3sH7wPdv3?=
 =?us-ascii?Q?cbTMSwLHd3IBFfIz8JmDfQaqCgTj7ewJID4EnMcOtCmgXcLPpXhFIS1tzXAZ?=
 =?us-ascii?Q?5P9vmtpQDuyQvYHAORZeNNdVs7syo3wxc6eKbCp3zGUprj8gMho4X20Kdx1x?=
 =?us-ascii?Q?x9yl5iZ49fFvlhi6xUh/D3Ba7s/fw7171fuFpMu1yKmZspzsZPFdF8n0WDif?=
 =?us-ascii?Q?I+y1q4igxqauPJ8Dy+R7vIX+XGc0eR3kFeFk9ffrXSiWuUQkYhA92u3Iy4Ev?=
 =?us-ascii?Q?zpOWQMPzZswDHv218BuOG6D1Z+vYho6XoRQzqBr9xTGtLmt6LnEKtNUspEC9?=
 =?us-ascii?Q?jIVxH85KN4QKaH9OUrjiJ8FMoItSbUz8hNYfW6GrttaMI/fwP7cPhFDm6GF8?=
 =?us-ascii?Q?p6KyITiZezD9fXtAefs2Co2FGrUxqYuLPk66hqaEY6jsegQLSwJn7kRY5odC?=
 =?us-ascii?Q?xcDYY13+/Fm197ZEykHFQr1TbBSZDFj5U8S3VO8EJhM9ixnr9gf/h/CYzeR4?=
 =?us-ascii?Q?ZkYN/EdrxYa2kqbyTifd9e/0tPlHgYNW66KG1MD0B6rDhUglnxNWOC6MUtH9?=
 =?us-ascii?Q?EVGTMA9Uo5irlJDB7Tuu5hHfgFBNWDX72NnBVnqAHsuBR1LL+9Y+2hTJo5eJ?=
 =?us-ascii?Q?aT8bq5mSa23a0auoEuy9+guJRptmR3jwEzYFVN6h/E6NWYn0zJxKKou14njm?=
 =?us-ascii?Q?P7ehdXEdEmv7nyGU5lM0LBXC0OkBJRrXkhlOq/AaZgur8ra4WgO7k2t4Kts1?=
 =?us-ascii?Q?EVuMEi0FWmuj2uCwlcY5L93fwzjOOxMHt5f5AvmiEe7oV7Df+UERFnyRtSpd?=
 =?us-ascii?Q?J6W//3J8rQglQGO2dQT+lw5T+Bs2XStiWiCGAqUuueKpYwCU7OdF9x8wSTxu?=
 =?us-ascii?Q?mzTOyiNH87QPMWMKeW/Upe1owUztQ3RTbl7a?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ojpXaJa9C6xrhrKVbyOuwFDZoFhYhJ5k5BVYdvmKQD5WTgXVhZQ4vHZKAD1Z?=
 =?us-ascii?Q?66X9AQwXfswOhlZn494ubHJG+tnyMTJQiN2vZXSR5ZurWsrdl0TqW6MN670C?=
 =?us-ascii?Q?bMK/MxGpDTUCYNa11D4gjIGM/qlmZHT+GTL6+HUo+3DzivpebaSlhB7GnDQ7?=
 =?us-ascii?Q?NiuEahTpilUdr0U0K2Ojr9u7pYpyPIjavSxihWolWIDM/Rqcd7lH4EEEB9Sz?=
 =?us-ascii?Q?ajH6EEjeYTjLPzxnwK+hSyhgs6N2DLz1m2tiH+jbWCSl/oyj4xSCJWjWIjZM?=
 =?us-ascii?Q?7jeV6ssY9HXUpb8EboeRRmFhUk03pk1MmPmxOSv5LXjGZwyGxTwJ27CqAm9w?=
 =?us-ascii?Q?IV1utqZkmch1+7GYAqXoHAEPCsA6uogvhJi6dhtq8m0aM6m1ae4l6Bw3pAgx?=
 =?us-ascii?Q?nyILgUKMRZ9vu+/GHQj3zIfYEjRk7q4M/fOoZ1woC7QdakZKO4okf7H4VkgR?=
 =?us-ascii?Q?EFchOAjGNYIdytys6C2I6Cy8wHBTgewh2zECcLDDEY4dh58c7/hei/BWcgW5?=
 =?us-ascii?Q?3gOkXoean4qJavqAOSvy1tbu/8jQ9umvr/+7NWHAnXbfxXD18F+a36xEvuHN?=
 =?us-ascii?Q?/TC0z4cHjU8wQ/P136z9nz198vPbROmXwOUj0UoEyE9zlREhCwcUbM7YjfRF?=
 =?us-ascii?Q?D6gbTUO35myx7aFWjvNPUfGDa7lL9AdkL12D1QzcqMNte2LT0gEvHDpr2tS/?=
 =?us-ascii?Q?IS3uaqZdh8rWpwnDzYNaekpkO4Qzds8GBoIDNIo5ddF1L3jRrrLIRxtBGcmp?=
 =?us-ascii?Q?YJ1Q+a6lZBPIaGMUnZ/rVzr8Nt1lmmOCpuvfrX4HyQXO1iIu7IzxJG6BQbyx?=
 =?us-ascii?Q?0epX+3IEJuRiGZf8SeSfW48dF2oEW2lWk6CxijvBVkMRj6JquHUAWBzHbwju?=
 =?us-ascii?Q?IxbTkiyzNWQWOvTakhpH2lNXvNrXMRuEvNi2Zciex2eseQR2Ybo8aX0qJMem?=
 =?us-ascii?Q?7peXszcrZIwcLm4BzWgQc3nNdAKuNalfhq/HhwLy8vMF9mQp1UGW2HgDrffH?=
 =?us-ascii?Q?l9TgNd99AVi+lAjbFQaKJuRNeIyLmD5Cp9ZEvlOnxUZxTE/GwjD1DvsNKATJ?=
 =?us-ascii?Q?cJL+2GBkBCzAl83EikThNp3ub3aO7vWIQ7dBChq8M7CZ8LzQEElgB+EjV9k2?=
 =?us-ascii?Q?pZmo9HRRxPpU9OR/YGRbhcLTAR+ZN0OiqOyDnT7tpi7UYPVBgGGf4GHPzR7H?=
 =?us-ascii?Q?nHSsZvPQLKQzeJkkYTBk8BTQ8Nbw3cb1c/IdM/afUEPWIE86b8mR48I/ZFaK?=
 =?us-ascii?Q?kn+bd7VKdsmw4gxV/2sNxsSbAiH0ZnPSXJRnIJTyMW8i8FzpegA8EAbzc1xr?=
 =?us-ascii?Q?tO8zc7xXCiRf3R7BYn4PJfZLktPjMmcoKzlwOkjpdQm4D/Y+PF8IO3SUTDeW?=
 =?us-ascii?Q?7fIHWcsTtNS59UaRUuhjuiZMWeqMSlSdItFFdfV0HcbchkjipRkRgir5rO30?=
 =?us-ascii?Q?elOggJmO/1+4t69Ic5AQP8aPvH2WAoj8s3kZ0i/k2cQyXCZa7hI4SIk5QkEX?=
 =?us-ascii?Q?zvMAXnFtX4qGIb9XM5Xt7xhtL1J4U7+vd9LE0jzW1GMuBFBCqFzSyiAkQ2th?=
 =?us-ascii?Q?QDKqW2aY4xcJ3A4RYR9IBjqRI8Us8Ha7euQ/4TfA?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290b81fb-e189-4a84-76ce-08de08ac1f33
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:54:08.7088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlgABHVWab6eFJ26g96GZ4C05Ti5TTWJgA6azgKoAKCfhesrLssqrv0n7D6MB+myn8deGhlmY2UOoSu878kB+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7536
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDA1MyBTYWx0ZWRfX9lzI+FYacqOY
 6pBLhXikSPwSQ1FF5mR4vADzBjAhzc8lXI2BiXrMYJTnEks2HC5SH/DqenyrSTxw0NPxp3497UM
 TCJiMqI4huXrAlb1A9KxCqL0BZ8FCv2CULShs1e5qZUvpGH/dgOIseVQkcz2Hc46UuoVaz2yEWT
 U8OL5ubDmMcFVD20CA0YrvnJMcc/bSBbj/jQWFW9vjXb/+8s84diScEdJ6wqNdMN0GAzMh0Xob9
 67buv8qKY6Wz1NTlH2hCec+j4e49shNbpZY+v0mrz0MrqsP/UhemOrMKGQdfNBof04HdvK2Ujw9
 6VQLq8Y9hnKxwjM5EI/luMdf/x1XqBe6YNKaNx5dRd7OLOdeRw4vD04xIivYLN1lZb249ucPbXv
 iAJ+CO+YE4CEbXvZ7Po18fEr8vHHPA==
X-Authority-Analysis: v=2.4 cv=E8vAZKdl c=1 sm=1 tr=0 ts=68ea2943 cx=c_pps
 a=mniIB+Hk/8HPdz+5sH7poA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=vBJHuO1lpNUdV-viS6kA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: QD5V_OOKTD9i9klZcTPmSoBQISZZhx-8
X-Proofpoint-ORIG-GUID: QD5V_OOKTD9i9klZcTPmSoBQISZZhx-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510110053
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 11 Oct 2025 09:54:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2288

ChangeLog:
https://github.com/OpenSCAP/openscap/releases/tag/1.4.2

Disable building on musl as scap-security-guide already does.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../openscap/{openscap_1.4.1.bb => openscap_1.4.2.bb}         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
 rename recipes-compliance/openscap/{openscap_1.4.1.bb => openscap_1.4.2.bb} (97%)

diff --git a/recipes-compliance/openscap/openscap_1.4.1.bb b/recipes-compliance/openscap/openscap_1.4.2.bb
similarity index 97%
rename from recipes-compliance/openscap/openscap_1.4.1.bb
rename to recipes-compliance/openscap/openscap_1.4.2.bb
index 3e5f00a..f1eb647 100644
--- a/recipes-compliance/openscap/openscap_1.4.1.bb
+++ b/recipes-compliance/openscap/openscap_1.4.2.bb
@@ -13,7 +13,9 @@ SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
            file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
           "
 
-SRCREV = "23a8ea3de3c4fd6017db4067675a81287177166e"
+SRCREV = "e9b2a41f5796f5ead3d1e2d9df1fb06818a569ac"
+
+COMPATIBLE_HOST:libc-musl = "null"
 
 inherit cmake pkgconfig python3native python3targetconfig perlnative systemd
 
-- 
2.34.1


