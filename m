Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A1FC55ABF
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 12:42:25 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18853.1786020133943842754
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Aug 2026 05:42:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Le1fmexF;
 spf=pass (domain: cherry.de, ip: 52.101.66.61, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhpIA9AMUzMB5v5XVjroepF/mMi4nEkQLI2M7pc4wsSfiOXG1ZAvAcDTYCXxxRvYKLdZjPcFLM6NKBKg3TCkAHKWjjKfwyIavc7nN+wjD4wUKkxCXyGPo+n86zVX7zxgCv/rX5WBu9bOdrU1TvIeeomdaFAcveBOwusIgwpVYHNmaV4cVMhHAGBWiUHy2CbcxF6pe1/I4lvyHr5O86+UDXCAROpsJyQbf1LOhcuXoJNKovbT0QCUvoAXpgqwf3jvFNBJZWwShklGxsHAfAE1t1YEE2bTL6M7SV/m/4B12XB6drprgdbe0W59xEFpqA9iv9S3guBru1gI2AhKb0D/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1qEFQvEfI5HUcRagdDugwTU8fANOtj2t1V9dR0+vig=;
 b=TAUiUahP1wW0VPjX8gheTXBHTbtjXiTIITzHQnfYX9wt9saWk/sQpcI/RvC9r070fkUDu7zBLUG523zoplTvKeUBEUnUGE+hnVW2WV9h08JH+59q6JM1y7UHHmD0X7LTazC6AMHhIkiNk9hsJvS7a9EgclBFddodAitxLS6FzQ8rRfYGZZtHNiwZgafMh72duH9qCNbAWcWiYg1l2kU9CIJ8pMAqxmPBhr6R6Ksytg9BHBFoAN2oPhGM7QwYpHPKYXVbrlKfsFJeKtyzl8qFXU4U97C6h9ZlqZTNS9soSaXuFwTLORjG+Xrg2O+uzUF7Uh4VgC6D7MPqJ+ElK2BabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1qEFQvEfI5HUcRagdDugwTU8fANOtj2t1V9dR0+vig=;
 b=Le1fmexF45Iw7m4tlDfwHfYnpk3AUWZnuA/f7jbuojcJwSjtCHpxqfmhKLNJelmQLFkj+L2dr2pa/ds+9hpQHLsY2yuxFWZEUqjDYDUo9ACfKv4a2JZW27sRMdE2I0iIvjyZ2ljT5gRq658Pw18PTxNSfPai1cu3pQj7V+FiJ1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18)
 by FRRPR04MB12571.eurprd04.prod.outlook.com (2603:10a6:d10:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 12:42:19 +0000
Received: from AS8PR04MB7733.eurprd04.prod.outlook.com
 ([fe80::8f86:fafb:dce7:bcd5]) by AS8PR04MB7733.eurprd04.prod.outlook.com
 ([fe80::8f86:fafb:dce7:bcd5%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 12:42:19 +0000
Message-ID: <6c6aa0c0-64d2-45d6-898e-aa77c47b56d1@cherry.de>
Date: Thu, 6 Aug 2026 12:32:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 2/3] bsp: rkbin-native: use
 SPDX LicenseRef for Rockchip proprietary firmware
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
 <20260805121327.3946788-3-sputnik@on-the-web.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260805121327.3946788-3-sputnik@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0063.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::18) To AS8PR04MB7733.eurprd04.prod.outlook.com
 (2603:10a6:20b:288::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7733:EE_|FRRPR04MB12571:EE_
X-MS-Office365-Filtering-Correlation-Id: 744ea800-ad71-4817-4634-08def3b82748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|10070799003|376014|366016|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	KZAwX5LtUNbGbPQR1wLc4hzBM4jg3zZWRkCL5DJaf92WTKDiBbRs96woL4jvTQ/rPpsJTv0h7+I7QuoD+bSUxVbk2B/Emut82s01NKrZqGWKaDvoPULAcXg00osuNR/i2OG6VCYl2hd7ng6fVBDRZ8nGaCYX6GX/HXYSsNypy2WVG3llQ4Gy5kfB3XRUdwuHkk1O5GwG30DOAO6rKoLSRFdb7zikHJt7XIHGaW1gdvbKFp8F7xcH1xYe0Z1CGd056SvJtdKbhMSfNmNJRp5Ee+3/0703B5vq7j0VqCmi4wuEFprZHvrH+FGAN6WnU8dG972jujzH2ZSJ5VH8GIy0rjIwMyj3oCcVE5rj/Grj44JISsVH+WeKQbN8Vvx8nLAF8ysWb2YkqRpdj3GwXh36bCWzF8tQcH7cusgJbqQLbyGjuQyYcgMkVqSqSgIMXmEFick6fwIErJzaxiCBai9/OHiBJ1wIlyde8rWDdVzFRxNCPsuLxJdzA85rmo+mcWnOaKUXQOmiwc5av1DYKwIjUILBeFGr/OJWLFZd0roWQLfpF0+P1r/c2m9y26P0a71z8QIYi5LZQqyBq/wFtU9ZyALOSJ6Y1+rdgQC3/4QC1rOh61wdpnaGKDlbcqRZAObEMNhQFxnxZ32HvN8kgoJRvrd8Z60JB17CAa/ZNNwpLmY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7733.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RzNxTXpxM2dZeFF2Rjh1eFl4SlJEaFFnL1E1UTQyaFkwQ3c2Z0UvNmhUUXNs?=
 =?utf-8?B?RUxpUGxtYnNSMGtTc09BbThGak1QWDZJTTVXUTF0amxyWENwQVZXV0IrTXFH?=
 =?utf-8?B?RjNUc2tka3kzQlNsWCsyUGNRR1ZraVVLUFlHZFlRaE1RK0xidndINGd3RE5T?=
 =?utf-8?B?U3Z6bCtYUVpHZWo3OWxjaStPWG1zMEsrRWdRZ2dqbEZ4NXQrb2Nhb2dpbjd4?=
 =?utf-8?B?V3VhdUx4OVlCL2JqM3JhcXRpOVdkMWFFYk1DR2F1L3ZvUlBXVmdMa3J4Vk9V?=
 =?utf-8?B?NEpIYVRkYnNaVEZXa0ttNnBKbzNJaEdEQUVpbzZraGxkWUhWeDFiT3NHV0ZF?=
 =?utf-8?B?KzVoWnJMT2d6bVRaYmExTm5WS2hhQ3haSXNuM3VrUE1ZUFlmaGpwLzlYZ0Q2?=
 =?utf-8?B?K1IxREl6djEzWjJpWjlJTzdveXM1b2R4S3F6S2VTTlNza3RueFFBNll0WE95?=
 =?utf-8?B?b0NkZUJ2cWdYTklzZ1lJYUJkdmFVZ1VGQU1UcHY4VEE3YUhEdFArOU1TOXhr?=
 =?utf-8?B?M1c3YlhjUHlmU2VUZUJZZmJocDlFekZmR20rbDcybWV5NkMyQzdWNjhMQW9U?=
 =?utf-8?B?bGhQa0RkZXBlbnQ4RitGNkxFYzgxNUhoV0M3RDhVMEJWL2o5dmFaRlFsK3NF?=
 =?utf-8?B?blZySTRlb1dqVGFIYVhIWUlnMjNBYUlwY1JsenFBdFdZRHNEd21BRW5FYnd4?=
 =?utf-8?B?K3UrNDZGZGRVcUhFaW9MRm1kUXVXVnBVck1zazRNc2hBMDRhdzB4MVpib3lz?=
 =?utf-8?B?dEI3MTlCOHdMT01DcmtsdzY5eWlmTGJXQklNcW5Ocm0rN2NLZXd3ZDN4UG45?=
 =?utf-8?B?YWdXa0ZhOWVwbGIrK0JwWE14SGgybnNjRzRXMVhkaDI4ZmtkNmJJQTMxcVNr?=
 =?utf-8?B?NjVSL210VjNhREp3YzZOT1NtRlBzRWZQekhKZTMxU3diSUg5N1JWa1ZTQk8z?=
 =?utf-8?B?dk56Z3hMdTJDZjlwaWp4YWVNNDdRWkxGVGg3ZmQyYnVVa0pFR3Q0SEFUMmov?=
 =?utf-8?B?RytaaWZ2TXcwVWpuOEtHa2hUdlAxZUdFVmFQYXhkVWgwWnd2d29NN3IwdElj?=
 =?utf-8?B?UHkyVndJZnFleEZRZnp1bkduQXd5VzBjQWQ5Qnh5VWttN2lOcGR3ci9makRS?=
 =?utf-8?B?dms3bGkzOVJqeXFlTzJBZXVFbmIwRkhCbGhtRE1KZGZucnNQYVJwODNlRUVo?=
 =?utf-8?B?USs1T09FMmFqaEJFSnZJZk1tV0lGZHJuWmg5U0ExbUgySHA1Ukw2bEpaT1JB?=
 =?utf-8?B?bTNKb1JjQnJGTmJVMGJFVGN0ZU9CSWlHU2JEMjlnUENzamhSMmJWWVFmZldz?=
 =?utf-8?B?Z0c2OVpSWHNwN3I1Z2tLT2hiWEpqc2h5V2oyakFCZVU2ajdtZklpTWYyaUx3?=
 =?utf-8?B?MERiZFJNTmYrMVFuM3VlWDk0RitkbEJWanU4M0M4c1RRZU4zMk9RUGxjS09V?=
 =?utf-8?B?elVtZTNncmFQT0h6UDJWYXdncTlpNllFZUZOaExkd3JncWFYcEFIOFR2cGpS?=
 =?utf-8?B?ZlZVdWREb3V5U1RxVFo3R0JwVnhoVWlYZnRKajJ3WjF0YkRVRGFUc05hbmJv?=
 =?utf-8?B?bUFwdjhPMnZOdDZXWTVLdVdwYnNKQjNwTnZXazdjS2hQNWNYSWlKS2w0WVZs?=
 =?utf-8?B?bW1PcUpzUS9VN1lIRHlERmVBNkNVZjlXWlZON2VIU3lMRkdPVnpKMWxocTBV?=
 =?utf-8?B?QVNtWmY4RWxrWU1WbFY2aHdzeWZSekF5NjNqUjVXY0ZXb0JMYnl0S21rV1FZ?=
 =?utf-8?B?Yk8xelc2U3JscnpGVlIzRlNxNjNsdC9UOUF6QzBPTjNJTGNoUU1VU2RIczZo?=
 =?utf-8?B?NWYrSUxHaUlFT04vaTVYRVF5MkxEaUU2SzVURG5QMHgyRitvSXB0bktpSGxG?=
 =?utf-8?B?enQ2L1V4cm1KSkpoYnZtSDRnY0ZKdmVERGJjSUlhclhrZG9YMS9vbnR1a0ZN?=
 =?utf-8?B?YVFsZjdSRHVyQXh2T0FPVkNQVWR6ZkFLWE9IdFRkU01ZVXQ0alFUMXlDRkFN?=
 =?utf-8?B?VktZK0lTakxJV3lkK3JrOTdnMURXRHVmZUtxaW90Mk9aeHptemRiU3lrZlpH?=
 =?utf-8?B?cXB0bGt3WXRlV3dZOXJvcWFnWW4yZG54ZXdBNzNyRi8vUHhiTFlmKzJNWXkw?=
 =?utf-8?B?YkEvZzVNdWxST1ZrOVNaM2dEL21zWTRtMlpHRWppaC90c1NwaVF4aG1PcDB3?=
 =?utf-8?B?MUdXL0Q2bkZmRnhhMjExNHJYUlV4L29PTXNwbGl6VVRHcjE2M0lpSVk5blcr?=
 =?utf-8?B?TURGMXdHQ2NnZkQyYThBL3VMSjE3K3VyQVY3ZzBCa0ZLSmZEOWgySi9sVUVl?=
 =?utf-8?B?aHhsYUF6QjNCc0JoTU9PWCtHVHdBSUxjR0Rzd21XaGxrcDZLZjQ5NmdPZjQz?=
 =?utf-8?Q?F/msKkfGD63raGlv2GnLN6UYQSFL8Ne4RXK7LElbWEPuW?=
X-MS-Exchange-AntiSpam-MessageData-1: eEm0mkKQKiXQhsusAQv8mL3UkPkhcN8kEsE=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 744ea800-ad71-4817-4634-08def3b82748
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7733.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:42:19.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMcLDHSVsEaPdoqFLIUKjDpjOUiOQnjuBntjprdpFBaiaZvdrSUMwsr97R81WNLWNf35PzuFB592obc0izAi3LP/Ax65r3Pia9bfHD6gj2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR04MB12571
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Aug 2026 12:42:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4641

Hi Martin,

On 8/5/26 2:14 PM, Martin Herren via lists.yoctoproject.org wrote:
> From: Martin Herren <sputnik@on-the-web.ch>
> 
> OE-Core now parses LICENSE as an SPDX expression and warns on legacy
> non-SPDX names such as "Proprietary".
> 
> Switch rockchip-rkbin-native to a recipe-specific LicenseRef backed by
> NO_GENERIC_LICENSE.
> 
> References: oe-core e9d424738d6f ("classes/conf/lib: Parse LICENSE as SPDX Expression")
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

