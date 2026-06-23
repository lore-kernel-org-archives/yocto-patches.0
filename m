Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4990FCD4F26
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 09:46:12 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17473.1782207969886710401
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 02:46:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=OrrOsB5a;
 spf=pass (domain: cherry.de, ip: 40.107.159.51, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0lYn75Z3zpqEkMjtExgbexwMaJRYioKsV1gLrijXdai/xtVdswc6ayHt4yQbzZbiH1Sd0O2Mcbq/po+XiSyVXXhKhIXO/nGxNmuPvbE39zJrjGo+pFnAAd5kBj3b/Eoi0Ub6yfWHdR5NqxNrYoMEqcezIUZnjWTj7uTvht0+z9rdH+YCdotLX/e9ShQIFj7PrtTnmmQbJYQDtMA1HRoAlMXu/6lrIN7Bj3D7gYhJu/HPMVYFfkV/RVTrNDnimVesnnLQWofISKA6mxIEkrM2O6q9sZr7v3BbOxnkcMg7B2LzRRQ6ec1eikfSHodDCW5Ic2zpO06DYao5uAaGofANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFtQtsCpU3Q5QWKJcAikHr1KyTzbPPqjnbr6rvTwdgc=;
 b=OYThDuTiloSYHDhg4YrBPyRxEn4YypwDLRQePqX+XEGPO9J5w9o2SbTo5x1mQmYQVi0Usslu63kBtpeEUMD8zZ/o5YCAIkxhUxCftstK3ONOO4Xq9YVRP+6VCQRp7hialCppre5dc0TJoaaw0shb7cs/4ksZsCZ6vwCyfzw74QI50C3YpOw6E/Rkp5Gyf6h/hzSkJPiEglI64eHSCypONJbzacxnwog9KazoOzGT09kusoRlqpjP3swq5KxXvFQAJo3o7xaxvBwJIHenr82hoRTgbYq1LneANcGECJyDbyOi33TUyV1SYqJKxzFGPBOBcikLkR4yqh4tGfvD6AB2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFtQtsCpU3Q5QWKJcAikHr1KyTzbPPqjnbr6rvTwdgc=;
 b=OrrOsB5auAdNtnWvWRW1dAQG+JvbzxLRV4WBL7xWQ1HgxnN4Z7VcoX1yf+gcL7Va6rhbZ463NZmf5iYoEPIWKfoRGVVZOBFcFNExyGvkBi1QMF16x4pczSs6UpRQ79tHP7hoe/Hvic3+phVu/KAWspgfH+RUs3gGk7lTJ1gPENE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM8PR04MB8004.eurprd04.prod.outlook.com (2603:10a6:20b:248::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:46:05 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 09:46:04 +0000
Message-ID: <d178a482-ef60-4e78-8788-04d16b19842c@cherry.de>
Date: Tue, 23 Jun 2026 11:46:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [wic][PATCH] bootimg_pcbios: fix typo in comment
To: yocto-patches@lists.yoctoproject.org
CC: twoerner@gmail.com, =?UTF-8?Q?Ga=C3=ABl_PORTAY?=
 <gael.portay+rtone@gmail.com>
References: <20260617074007.2599873-1-gael.portay@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260617074007.2599873-1-gael.portay@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR0102CA0096.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::37) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM8PR04MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 7327dc1f-5168-4a38-4492-08ded10c3e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	xFbpsv6PCHIjDydGPkELfCqlRdyefVF938Ao3LkNEUdwlEg4I+qRlfRZbFWcxDTW+M4CtF0ud6neLUdseVLbecTKS5pPyFToZFwUP4BbOy2nCg9ODr+4Ypx0rVnpCSeAXFppMQJPLF2QaIFLf5fz319m0jezqkVRJHYSZcRS/Udx3ybwoPeqYC8vDGPe+d/2ctjXrxlzQlV8M0lroLkyz8TA7d+e6PKuPyyeBucVT6w9Ki4X5zCXAmP/fknLnyDAvSiT3ibs+FhtEb7UHhqqQbz52eJ6AV9eDWzIcq0QtkekVzGXl+nFbTwTsBuTLUilNE1St3iRxrO0hP6I0Ex1YSW4+IrJl8W1++jo8LKGw8rioHlWW4fEg3K2bmtSmWr3V5y7qTPneo9/wnL19ea6mFiLlwz8ndVK8g+VFZA6D/D9suWEstFllkSOu8Y9UaqN4rRNGwLFvZPq7lTZFsPIZbFQ9+1KbqlbjI8VwMdK3mJWr5ZHoqMxi+YPs2OxuRAhGCX/3PIv8WqatQ7JbxDjhTsdQNhd8aRZYYX+M+C7sfJbGBc52cSA2YuOBWpC+LV1BHR/6M/zVR8sTOaAjJgicUC0XxIJpRIYi17NGbvlkdNj8FK6XD8ytXScGX+Ca9mjwhpuHnPx+5lwA5GHlw0yC3ViQF5J65mLaYn6Tk0Lmfw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?28OrmwKjs9/OdEjBzsRUkHTj7t0jFlDQIrVM4ccZDfLXgYI9kVNTmK/A6VlW?=
 =?us-ascii?Q?EwLFgo37BC1FDdIgEoWqzzmDhGjqC+r+EdbTiRzKckc4vBOYKKtJhVSOzF3b?=
 =?us-ascii?Q?Oi2sbABrCY3p7WWn2LNlPo6MwEeo2Yltwy6BOddUn6BJ992uEMRNdpHJWgTJ?=
 =?us-ascii?Q?yapSRqsViwriWV1RAabE7p/H0UrIyGHiezF8uHxEDcevMk06KeiDDgFu8UDb?=
 =?us-ascii?Q?ovHSovullD8PqvAPG7cFYfsO76Xv1Oh/GRS9wKWhMwn02EIiqbVRO8fWk74X?=
 =?us-ascii?Q?bLx5pgiNLOOLuZMPVtwVVMjoGwsqqS2YNXso0xfHnGbWBtWlxeepHtzsHyKj?=
 =?us-ascii?Q?+xTBM3JleHCvnkzfAFX8V1n2C/1wWXK6hMd7P//QeYgOpPacSlCxo80HS9kW?=
 =?us-ascii?Q?nuC58kmZGwBAAx92lv1sM5IzQvEBoYqLj0W0E70Vpt1GrrfkHHtpmaElahpM?=
 =?us-ascii?Q?6gNDQwrgC2tlZCNookAbZ0u2yb1XArVzWlhuzqMuE6c+/c8CKUXejAVPJTlO?=
 =?us-ascii?Q?3B1OdOiiFxRTXHWEcuWqYieV7qbtqC00E9s1emzMKwbekoSnmj8eXcMXXB4K?=
 =?us-ascii?Q?S+wIaRSGT3VTh6IjXizzsmvhAi+l+n5oFnVGzo9SUPIiyxAHJ6SJMedghDHQ?=
 =?us-ascii?Q?pGVErDoByWFw6FZhahGlr5Qkb35nb4xjj9Zhnhig6MIfm5Ni2uFaLpDtGk1K?=
 =?us-ascii?Q?9KFdQ1IXJaY+Nv6qbnLQg5kbqomWOqWLnsmi9fyEUX9zFh1bjxfiSv8Y2W6n?=
 =?us-ascii?Q?XpsAnctfXKEGwRY00jke9K5yK6xKdHlIM78So4u6qyaiM7W3TBbjxGpqmDyS?=
 =?us-ascii?Q?cDhJ2N3lmsvMEYpU4nZi56j+IqIMAGS5nNKnPAieEoCxJSIqG77gobhoSbPc?=
 =?us-ascii?Q?Ly0CZHNM1EiBykhE/bGvq/2FNyYMrH9+ZUgdtSUFYidGVF5xjiamJd3dBGPv?=
 =?us-ascii?Q?6tr4e7StsGJIJ6iHtoN0HY9iDM/cJO9Zstz4AzXMW6CopO0nRL7wAR//voTX?=
 =?us-ascii?Q?rYcmtztJxRVR7RVqXe7dt4e01F5PaMe0peVJrPHHRLNiej1URPSwwWej4ZbL?=
 =?us-ascii?Q?xcusobIphr/Ymelz3opN/pvguZiMTKRirY1I8DkzrPQgNEFLQZuJD5S8VtJm?=
 =?us-ascii?Q?Dhgop47uIMlQUHf8ZSAwyctGpXslTG7ojGUkVUSiphXl9UwLqQMIoGhZbT2k?=
 =?us-ascii?Q?mf/CrZESwrSPJrC3oXSuZiMcMF42EkfgBGTfUSo5L74wzWiDOQACubCdUsqn?=
 =?us-ascii?Q?cVhxlm1U0hJt+OBIeSKdWk60LlDAtMy9QZpQ5LcvJN8gLje1ScHfbUffKQGw?=
 =?us-ascii?Q?Rpqq9QrZdhu0Q1ELAKnbqRivKXk48UGM5TBF93iq+4QMGWC0P1D3TNTRkOly?=
 =?us-ascii?Q?NiSi7eYu2FxJ8QhlckJr77WqQho8z2AYnVDKm0ZAIjExH+ntjgzcQq2g/eGP?=
 =?us-ascii?Q?U27TypvuPbD6ZumDAnc1XEznVL2DI2MhCA74M4mlnNKjENP+3+xROP2nJNBJ?=
 =?us-ascii?Q?by5s1ReUJgPpdIVIt5hZ/06XbsQy+BPhbOYu/ZoUR6mfRP8XXHBElG3B6ALj?=
 =?us-ascii?Q?14/6B3yrhndW2hsqKradaDdF6mct+3f2OvgW5PKq7jO2RZoBu/yIDpuA5Nnf?=
 =?us-ascii?Q?INfUM5xzPTvStuFzhDk4soAaMvSNaGRBXygnPKgF48QWbp8hlHDgN8n6dzQD?=
 =?us-ascii?Q?fhYWpbOtorZ71agQUv52gW4OsIxF8CapBSqYe9r1NZJ4fYGzOe40WU7kycEx?=
 =?us-ascii?Q?I4Oyflvzxw=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7327dc1f-5168-4a38-4492-08ded10c3e27
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:46:04.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUWrrbMi2d/GfeiT5MkgyIf03LTMlaBzuowkn/3PfYBTHh7mHgttJ+ZRxYlxQMwWkQK+LWAw88JEYTEnnWex7dKbXpSIX1Pnz280vUdskjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8004
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 09:46:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4275

Hi Ga=C3=ABl,

On 6/17/26 9:40 AM, "Ga=C3=ABl PORTAY via lists.yoctoproject.org wrote:
> From: Ga=C3=ABl PORTAY <gael.portay+rtone@gmail.com>
>=20

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

