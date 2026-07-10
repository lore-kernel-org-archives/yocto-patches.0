Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58211C43458
	for <webhook@archiver.kernel.org>; Fri, 10 Jul 2026 14:36:13 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.30])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.366.1783694166230058304
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Jul 2026 07:36:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=H3w2AThP;
 spf=pass (domain: cherry.de, ip: 52.101.84.30, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrIdLZcBuR5yrFkrtNZMWk82wvPBwHsNwiM4jjH4scGDPXCyZEKKoaYPSkz7EIXq/7/MgJ1yMQ4SovhR0F1L8K4c+khMmB2DWywIWIznLCLieRUU9ps/o7/zO38J2B3koy8chM97Q7IQNeKrMEAAjv8wU1W68ZTFJmzhnRPMP0jHXTU+BzyQsDPy6ZtLhs1KCMGmCyLZ9K5SeG/u2qcV7u+IgfUjmb5aA1OzR5zU6WMqlB62fWvdXhFTtUeLyW/C7xqcW4jK6jPvBxeTHgQBxO2xoHJ91snFxWurLEbZA3H4OurYcw9NzPhUNUO/JwYgW4z9J9SbEGCnon/o3TUlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4DhbcAa95uaQp2sHfsl16dclSG9tizPLbd13cw4Gvg=;
 b=af3EUuC0lSXYZo5yXSKYkaHekb/5OxEPEHiaDiAUqQsSeCeV7OY6VRPd9kG9ZgJO1Jlqt/GmZhJQnirKmICwt9dF2MO50Yg8IJKfNHR+X43KpS9UvkoR3CpZVDx8Km8mx7zI0WpDTj2odQt3u7WxTcIXfwyXp1P5e7qHYlh4Zu2HzaHW33755Bq4uiwfZEkmuJxLTeOwVzuw27ajOdzDO3Qj/H5QBNL+c9Ma+qVUp5dAZLugkMNQO4WNZGTeZLZkkftLQWTG/yQv159psE8lxf0HDbvADKPub7BABgG1YHmfWWgrSiprBCUIn1dngPg9k4Qubq45BM9BhA+BMjcHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4DhbcAa95uaQp2sHfsl16dclSG9tizPLbd13cw4Gvg=;
 b=H3w2AThPrt0d/97S6mdHFRE54OugN6oHi7TXM9bk071ihI75aoqhF5ZSlPI6rBUlJwuwws3NBRMaGHSQXUsH8XL6I/G2dKttihesjKFi+a4FpJs74LYExBOVjwkc8vPyrUVakIeIfSY2epmWEv8tD5YV9KKwUc8M6WHHq/zqdyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 14:36:01 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 14:35:59 +0000
Message-ID: <08cc79c4-2e3a-4986-8246-d0175e85854b@cherry.de>
Date: Fri, 10 Jul 2026 16:35:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [rockchip][PATCH] rauc: update keyring path for
 meta-rauc relocation
To: yocto-patches@lists.yoctoproject.org
References: <20260709223924.3480606-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260709223924.3480606-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B94.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::630) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 45eef305-ff92-4bf7-6039-08dede908ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	W5PDBTi4np0L7XSBQthwerxpI3RA3CqYE6AReGiQWn2qmrgg0Cr4dEQeVk03N3kHCMNWkiI6kCEPxoJFNPnkSF5vtbV7MBaFd/pskv5GMsZO18glqbbP644tDeuIyynZNj6OReTPr0fC43dmohTmGMYPDffT4ELVpNMeda6b30be+/t7G2i8V8Xbn5M7NdKdnxiWiN4Glzi3MAPxTMpzmOoC0ZXuF45RafTJfzzXJsrNEeRxr9NXDjcyHKtVkBwVwyjc1o/oRNRQIcVfHq6BpL/1tG04UOocPRzx+RBBwORmJyfnMdLfOBSORQHKVRiwatrQLV61lVms1xLWer3vOfNoVfVhnb8Q3b3zMFkDNeTUGGcBknbMPDvNl8HETFjR5+7vkiL5JFJb+19LyRf5gP/E5tcyYE5wgPeQKVb5FQ/2CZRbGBBgh/q9MlrDqCoDD0EFVfjVhp69I8zqsykeZf1Dekg6LdTAalZk8K7cpFpn16buqyYOil4r3P3YjOuV1w02xh5rYBMBlqzjRNXDkGezms5MUCIxMJM2I/EkUXgQcW4wn4RRRQX7x9g6GNM8z5XGqY5FiATNAOIrBESaeLoNZ/3RE5yXd1dzUEo2lm1dBTubMd/n0ujMWml0wMovODo3uBPRGnh8lpnLNqkf0i+Wyhf2wYiW3ttnbqTYV/8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZFQzZm1xdnpZa0FKc3p3eWJDTTBXZmwrWWhJUlY2WnVud2YzT1cwYkYvaDdT?=
 =?utf-8?B?TTVkNjJIT0NhRVBUVnFZQlpNdjhYRjhaMU9mME9mZG43MGlvT1NOOFNNbGxu?=
 =?utf-8?B?WHV5aUN5UFFpVEZYSmpWdCtLMWxQRTFWaHI1OHdHSVBYbDVRN0kxckdUazlW?=
 =?utf-8?B?U2hsU0NFVVNYWnVCYWlkd1A5TmVuN1NaeXFzUzZXcERJVkhkVHo3R2RNQ3M3?=
 =?utf-8?B?b0RZT3FxWFJwYWJSOGx0R1BvempZR0tBd1d2b1h3d1BDZTZ2ZHgvcGRaM1Ur?=
 =?utf-8?B?MUFLeWxOVSt0SXdHRklLcmtsOHJaWnR4U1djY3h4aEZDRG9sM3Juem9pMytG?=
 =?utf-8?B?N3JXWVAyL2NlZStWQ2krSEE4Z3dkMExyMlpmNkhRVTFJcFpHSHpVRkdCME4y?=
 =?utf-8?B?Vmtrem8zMWdXOFdaSGpiWWhMWnBlcnN4VU5TTFpobGNDYk1RNFBiNGVRTXVh?=
 =?utf-8?B?SndBTHZoZmwzY3JMMUxmb2hBWDVNdE51WFdtYXhvdVZaOVd5RnRWUm51bFdU?=
 =?utf-8?B?aDVTMzg0aWE5a1ZrMzkzdS9GdENIMDFZVW45dzk4WUNiNFZRQnVxTWZTL0FT?=
 =?utf-8?B?eVR0Q3YrRTVQWjF5TzBOME1wV2d0djlVcDFJbWlyQmVlbWovanFSTWFuVUZE?=
 =?utf-8?B?UVB1MEJNUFdFQVJCOGJSYkhEZWZXT1VqVVNZZEZEdnVqM0t3cG9RU0d3YzRq?=
 =?utf-8?B?RmhiMjR4cGlodzMraS9zS1NnbWJmQlI3cEZvdEN0ajU0dkZ2RXlTSUh6SU1K?=
 =?utf-8?B?Vnl1SENLUFMvT2c0ektwK3pwWjFRYnpvWlpPU1Mzc25OZlhacUxJTXNWcFBi?=
 =?utf-8?B?QUlDS3k5QnBuekZjTnhqb2p6VER0aGlDZzViZHdwdlZ6UlowZTM1WkxIMmtp?=
 =?utf-8?B?Szh3YnJrUVowdFpQM3R0Q1NLNjA0Z0Vub3FHT3EyKzBZVTZ4Q3IxZmkrMCtw?=
 =?utf-8?B?MzV3SGJwQWdibnFFVzdpdXladjg2M0NQV2NCQ081VXRaZFcxOHZJWU9GWHdR?=
 =?utf-8?B?cjBQWHluM3dESUlzdzFzNlVmVjlBYWl6WlpXVVdDVmRtWW1paHBiOFNjMWx3?=
 =?utf-8?B?RTkvUWZPS0MvOVk4cUI5Vmh5eldhQldmT3JlaE9nMVNUZG5VcUFZclRaOFpa?=
 =?utf-8?B?R09sSThBWlAwRi9RcHJOSDR1NzdQNjNKS0IwM1hrL1pFTlBKT0dwMVdJTE1z?=
 =?utf-8?B?RXpkajlzeXZmQWhRb2xiZnRxMDN4bk0rL0RrRnlIY01QRVQyMERRSFJwbWll?=
 =?utf-8?B?Z3BtSE51NG1EUEQvbWE1YmVzbTRITGQxeGZ2UE0xVVpUclExLzFKVCtHcENu?=
 =?utf-8?B?bUFHYitLTzlsNlRJNGJBYWlvOTEwWVMxV3MxMkxrdVlveFF1NmlGTzRLU1lK?=
 =?utf-8?B?eGVHUk5wTW5zS3VDN2QzSDdiOTNITGswcVBDamhvMTJJNzJ6ZDcxampwOS9j?=
 =?utf-8?B?dVZEWU9tY0lRU1RSeUY4M2lmdVRTa21wbHdkWklQNHI5c1dDVDNKNXRVTzNR?=
 =?utf-8?B?UEJFZWt4MXdHWk93VndVV0hlZXFad093ODM4RG5McW02b3lvVGVFSTdNLzNH?=
 =?utf-8?B?R3B6ZVdvWXZINWpDc2ROMS9hR1UvZFlmVzBuK0xuMHpLL3lGYzlGcGpKZ2E4?=
 =?utf-8?B?ajY3amQxWDkvRzQrQlEzVURPL003TVRJTURFRlFDWUU5N1gzWjFsdGRYWHBq?=
 =?utf-8?B?ZVUrZmtiSW5VejRQSWsybFl6cCszVnVEc0MyT3hsRlgxMmt6dmFhallnSzBs?=
 =?utf-8?B?Zy91aHJpS0wyRjdsRHlKRUo2eXhFWGhqZEFMN1NaUFhReTk3OVF5ajc3QXlL?=
 =?utf-8?B?dUx5cVBoaERDRXVTRzd6My9la09GMEJ3L1VrZnI3djY3blNEcWRyUjRKVTZK?=
 =?utf-8?B?UHArOGVYMVBJOFVGbmpWUHNuSVJ3ZlY2ZE9BWEhQR25QWCtlTkpaNnFsR3Rs?=
 =?utf-8?B?aURuQldOMTJJUmNyTzdaRXpkRUx4a3hmUzUxOTRWSm9aVW5RVkhua3NMT1Np?=
 =?utf-8?B?TEMxR2RKYm1kYlBkNVRadXFDd1RyYzQ2Q0w4WCtXbkU0bjBDcTViRCtZSER0?=
 =?utf-8?B?VmNkTFI1UVF3WDRLK1lUT2NzbkM1ZXhFZmJOZXMveWlKWGtHUDlEU1lwcVM4?=
 =?utf-8?B?elc3alBEcWdvaWhraHc4ejNhTXpBbmNQRmovNmwvdW5XcHB0cmI2SXVVZXZN?=
 =?utf-8?B?aS9OUHhHbkcxMHU2ZE9lRGpKdGNCZFF5WXVMM2lTZnpwTWVqMFQ1dytheHdl?=
 =?utf-8?B?ZERDcC85anBZa2R5aHdhSHV5QVVwQWhMNmZHdDJtOTl5a1JPcncwUmVBRzhC?=
 =?utf-8?B?M1BHVTIvVDZQTlVJNnJ6TFRPYm4zUjkyb1dqQnU4Z3NXaDNlaWRqQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 45eef305-ff92-4bf7-6039-08dede908ee8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:35:58.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgpwi11ae+FrB0Rl5PBSWVDvsE4wUvnOocsPLP/wiExSqhS621Ya26SncZNEuGtXoyJ2rcd519thkIm/HqtSuCmXABfOMBT4oi/Y4pYkrGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jul 2026 14:36:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4466

Hi Trevor,

On 7/10/26 12:39 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> meta-rauc moved the keyring installation directory from
> ${sysconfdir}/rauc (/etc/rauc) to ${nonarch_libdir}/rauc
> (/usr/lib/rauc) in rauc-conf.bb [1]. Update system.conf to match
> the new location so RAUC can find the verification certificate
> at runtime.
> 
> [1] meta-rauc: 01f7e1bbde16 ("rauc: prepare for hermetic /usr/")
> 
> AI-Generated: codex/claude-sonnet 4.6 (high)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

