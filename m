Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F4C5AC7C
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 12:42:25 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18853.1786020133943842754
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Aug 2026 05:42:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=NQmtpEGn;
 spf=pass (domain: cherry.de, ip: 52.101.66.61, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Paost8PdTx6/djEGctCUEow7hiuN6eR9IFk4DDkFXXmBi4Dg4lSGcUeNfuphlpOV8BGWD/8k9+mVVEV070WW7Ijdc9sLpbRSzYEWL44WeRwpE44aPQ0vbwknJHedUIWIDmJ5e3A8RYDdKJGuy7DC+tOluiuGS+/q7oyGVgBwPRWbVH9JBcTl+cyusF9jcT0F2gqDcp1MJlIkaA+lIuQ/F4vdM9sautyA2Qc6xwHeNCjDpSVOTOO/Rbf2VSfvk6bbEcxhDx5bOH2c89kYchsbpYtkpusnAcSVzGTk+BHid5e/VyDIx9v+vElrjUPu0e7v1GC2ucgN2Tc409UYbhEOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q90FmhxNh8KUXj+zNiEJEn0w9aUGBvrfu81jcNMJR3k=;
 b=Tq7tVrgS/1ICHEJd5kSiX3TMWDhxacpCijFWVWMWjgFnXNsBo8L+fmRC8QCF+1EdeIuqpXik/GhnPxnibdIxVq5wkPYTJ1mw06QwVl+BUISQlTCXUe9C4536fOWDZUfolZB3VIstbAe18PaXpu2rXcmMJ2JaLlJTnhA/RS8C9PmxeeMHAZYNMDRf0vp0EOUy57/XIq1NJWofYSldpmgyIkGLa9dVFCuNq+56PF878YUfklhqXcvX3NFSUOcDAaZsMIR6TmdiGuE39NK61nFvezU2W7D+3gmbCZugACD+xGOnWA/1BtFjspRYcGWf4yWlKcrho3LehCQW+1zld0QnjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q90FmhxNh8KUXj+zNiEJEn0w9aUGBvrfu81jcNMJR3k=;
 b=NQmtpEGn0jtNyI1OndgyzyEZ71osIZ5ugQ5HB8789YOtnO61y5qOQHUXUD8kSyo/Cw2eu/FeByZ+0gIk46kiHxX9o5FR9nf1MCO2WRPRxOHY4CDTpD9jdcYazl4QSGQQo8Swu4VUGTBGqGqFXkoFBnhCP6hLTYcQdyLikwhuCrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18)
 by FRRPR04MB12571.eurprd04.prod.outlook.com (2603:10a6:d10:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 12:42:17 +0000
Received: from AS8PR04MB7733.eurprd04.prod.outlook.com
 ([fe80::8f86:fafb:dce7:bcd5]) by AS8PR04MB7733.eurprd04.prod.outlook.com
 ([fe80::8f86:fafb:dce7:bcd5%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 12:42:17 +0000
Message-ID: <99e79a7d-7786-47d2-b451-5e4c7611837f@cherry.de>
Date: Thu, 6 Aug 2026 12:31:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 3/3] bsp: rkbin:
 rk3308-rkbin: replace deprecated CLOSED license with a LicenseRef
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
 <20260805121327.3946788-4-sputnik@on-the-web.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260805121327.3946788-4-sputnik@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0063.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::18) To AS8PR04MB7733.eurprd04.prod.outlook.com
 (2603:10a6:20b:288::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7733:EE_|FRRPR04MB12571:EE_
X-MS-Office365-Filtering-Correlation-Id: e0acb827-0df4-4920-dc4e-08def3b82667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|10070799003|376014|366016|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	5lXrGmkDdIz+KXDnL+D+qeiD+zOCFpbTkHLxd5nbOmb/k8uoopbwctu0z08yzvDV7m9yzJ5ZU40ehJq9jgD6j/1OCA2aKFgUGcP4u5eggZT6F8XVivaEQ4bi6UeMar4ns2hW12woA81IBnpFyVLjWpBipV6LM0D7SiST6AH9YkWrEM5Ar/D0C3bb6R6y8zgIVR7XBh26c48jJVnIJOcGSMk+TcgkcWGs7s9Am8ZS+tjsj45c+3N5jLo4Tdv4ZNgzaU1XAdg80PkMxk6rigbMNy3rb/tqo2SQx5XKz5tckncQjYcyxOmrSSf1JGhRq1Qf2jrC8uALQs2alQoB3HQ2sWG/Q88rk0ZmuMNNM85hXCrRWTCfv+LBHSpifhWAq4cGG+mDdomnwzStzkeisDU8bHLNIylMPGOePMz9dxDkLlkJ6m5gIOrvr10+k03WpiUQZ4p4koE8CO/H7vcXupBp0JqzUaJlSneVGWMqjyf4Uwm6Z7ypx1gPhQLJRIoe27Jk+deJxrPazgiMVo/bFeMe5GBDjRjNPxx9oyPItoTiKGa3dVxI2vKzx/pgI75kZYMS1WcHMgZZEfTZ7HHhRZ7/bk0iW+I0K8sAYvM4+U4YlY1LFUbBWfXH6LC2CFuppsRHXlviBcN2d/RQfi1DsVE/LRUbmL4Bj9pcrQaiNCUARro=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7733.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eU8zTXM2dHQ1RytTbzBWSEdYY1JHb0FDbTRCNzU5M0ZFRHdSb1VVdERzK0NY?=
 =?utf-8?B?Si9qYTNoU2hsOFV4bGVOVFBTd0lrc0VabHgvR0dpZ2RVWWhMdmg2ZmxKWmVP?=
 =?utf-8?B?MXJveFpxZS9sTFNUalJYZWF6d3FwdVd0NzVGdk5acWFHSmxsMWxKbnFseWcr?=
 =?utf-8?B?ZWNSQ0dJVVZJM1VVd2RlNEp1cExlWjlxQjRseXNZQ2ZMMVBpdXhjWlZwWmRB?=
 =?utf-8?B?R1RxMENwRFpiNklyYlV0TklqdE5qZ3hKZEVlZ2ZnTk9tcldqRVVtKzZrdnBz?=
 =?utf-8?B?dExzMEM5YUpzQmtpQmdvd0pjNUYrZEdzbXlMdndTSHdRMlRvRE40TjBWayt3?=
 =?utf-8?B?bDViWC9GbG9Ob2ZsRVVMdWpqd1pkenM2cWhhVUEwOU1ScTVCZFFGNHlZZk8w?=
 =?utf-8?B?UE9uVHp3ZERJeXFjVnQxVUFHMDNpL1F2T2dvd3B3bGQxa2V5eXR0aFR1Rzdz?=
 =?utf-8?B?YVNMTXBWcjBEZm54T0U0c0FzOEJZUGZ0emErcmxEVXF5b2hQNFdFNlNYRWps?=
 =?utf-8?B?QkhxZ0loZk1JUEtmNDFKeGhOYlVTWTJ3ZEQ0NWU3ZzZMQU9CUm9Pd3JrNDBs?=
 =?utf-8?B?ZXVtR1pBZDhhQVRPdnFydXZ3cWs5WlM2SldHWW9VVFd2NWpQa3pqVmMrN2lB?=
 =?utf-8?B?SWJiY3FlQWZFcmNKdjZ6Mmc2eWN1VWlYekJoMUFhejdKNTQzR1M4dlpSY2xR?=
 =?utf-8?B?UXRZTElOa1pVLytWdzh3cURNTXZnMWxjNWkybmowRThqREhCRFoxRmFzeUF2?=
 =?utf-8?B?UUNKODFrMFlpVGdSK0pTSDBWTDlCWjZUY2RuTmxBZnpGaHhKL3NJV0U4L2Ft?=
 =?utf-8?B?SEhwNURtZHNDYUpuNTZ0eVpZSDVQdlFJVVphNnFraU9yUThDTVBDYXhqd1M2?=
 =?utf-8?B?d2N6ZkgvOXNBOGcyc0ZtbExNeVRsbmFFdnBGWTBYam9yRHBTazBOalR4N01W?=
 =?utf-8?B?MmNSbk45VEVBRWhyWXZZK2UvK2lTMWdocmlrVU9CYnRLYmZNREdNY1dKK3ov?=
 =?utf-8?B?QitRaUY0K0NkV0Y4NGhQZ3ZOaDRjTWRvbDR2ODhQVXBmb015NmsvV1RlOFhz?=
 =?utf-8?B?cDZXKzRZczlXb2toT1pKVGF1ZEFWQTBiV3I1bytGQmszWldIa1hmVFRpTG4v?=
 =?utf-8?B?dFlvUUY2MGRMdEh3L3NzdXEweE43UWwrMVFNMnd5T0VyelcyWjBQV0lNYit2?=
 =?utf-8?B?SXdMd25HSWRjL2JORS9nd1dDWmJvQkwvVmdSS2NjbzRTV2ZrcWovbEVDR2No?=
 =?utf-8?B?OTB5TTFkZmY2RVM3Y3ppOEh0Q3F4YVFjR2FZOW1zTnVuQURSaXhuakRTSHk2?=
 =?utf-8?B?QVNvbG44S2VNWG1zbDEvSkx3MnJpVFM0WEErZXlxZk1VT2NtTFppV09KMjhT?=
 =?utf-8?B?alh0dzdqak5Bck0xNmhleXNPNTlONDZNRXFWaVozQkNEV3ljT2NmWHE1K2Nz?=
 =?utf-8?B?YUk5ODk3UlhaSHdMY0dEUUNDaUR4cDhnT1F4Q0ZGU0lpSFhtdXh1ZnMwM0kv?=
 =?utf-8?B?WEFENFo2eTBRS3Avck0yNGxOcWg4NG5JVnV6c3U2WVNpVnVkcXk3N0lYaHdB?=
 =?utf-8?B?bE55Vnk5cUYwSzY1K2l5ZTFsbGNHTkdhMHZkRkExeEJJNWljUlduQnloRFNx?=
 =?utf-8?B?UTBKZjFaSS80ZkV0aW43MGpaVnpwbUtNd0o4TGJyNTI5RkpvdW9wVFI1SU1Y?=
 =?utf-8?B?aHd2ekxxeWxrcXZJamJpZVQvaWtubmNEbWFEbjJYTk00RVQvUU1lWExmMnkx?=
 =?utf-8?B?b2VBdUtmRDUxS0ttTWhKSDk5NTRRZjRxNFNLTWNxVTlKaVh6TEkwWVROTElP?=
 =?utf-8?B?WExJaU5nTFF2ZlRZaDh1T2pSNU9zN24xckNXZTZNSzF1eC9QRzJZR2dZOEVF?=
 =?utf-8?B?TUhYTlU5QmRoVjQyS2xBd1ZBRzRDSlVYV0lmMUs0ei9ybEI0SWJoYWtJaDlk?=
 =?utf-8?B?N1Z4NEQ0SzVZYVhPR0RESVJvUTVXR3dDRDlBQnZTTkhES1lqT2t2cHl2Ykg3?=
 =?utf-8?B?azN4QXV4ZjFUQS9WcnRuVnUvbEU1WkJLVUpSUEo3OUxiQ0t6c0JOVjc0SllM?=
 =?utf-8?B?ODlYSm9TUm03QnZFVGdPaVpLS0lmK2xZN0JUQTEzQUloVXNYYlM5cXVxeWxp?=
 =?utf-8?B?TitENlUvQlM1aEVpVUZkTzhlQ040MFVDWkEvNzBMdCtmQTc5R3hUaWl4ZlVI?=
 =?utf-8?B?UFVtSExPdC8zQmoxNC8yamg4Y0ZqMXJVK0JnaU5ZK3RNQWRrM09oTU1wZjNH?=
 =?utf-8?B?MEMrTUI0STRpazRRVTV3YXk2ejRtQy9lZWJQOFhieDgyQmdIWU1qN0FiUnJV?=
 =?utf-8?B?NXNjTStWTGlLNlkxM3FKdU5CNVpyU1hoV1k2dG1udU90cVdVeFA0N1JNa2J5?=
 =?utf-8?Q?IjzValuhfiMe5SiE2RTO9qVLzlGJ/i2vP3O26Ub7WWwma?=
X-MS-Exchange-AntiSpam-MessageData-1: eXzT9/ImIED0AnFrlDIFATIZk94leqAZYiE=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e0acb827-0df4-4920-dc4e-08def3b82667
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7733.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:42:17.8156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lFyrK6SaJb8vZz38K+mMxJa1ZpWs/E46h0jPnsWpWlP5APF6FYZiW6Lyruj6PoSFibTxjhhgZ1V/2G8MADJkC3/NTpSDh/Rt+ba75MHubE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR04MB12571
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Aug 2026 12:42:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4640

Hi Martin,

On 8/5/26 2:14 PM, Martin Herren via lists.yoctoproject.org wrote:
> From: Martin Herren <sputnik@on-the-web.ch>
> 
> OE-Core now deprecates `LICENSE = "CLOSED"` in favour of a LicenseRef
> backed by NO_GENERIC_LICENSE.
> 
> This recipe pins an older rkbin revision whose tree ships no LICENSE
> file, which is probably why it historically used CLOSED as well as
> pointing its LIC_FILES_CHKSUM at the README.
> 
> References: oe-core e9d424738d6f ("classes/conf/lib: Parse LICENSE as SPDX Expression")
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

