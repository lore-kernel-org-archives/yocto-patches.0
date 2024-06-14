Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB10C27C75
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 09:01:37 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.132])
 by mx.groups.io with SMTP id smtpd.web10.7012.1718355692458344330
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Jun 2024 02:01:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=X017oQzl;
 spf=pass (domain: cherry.de, ip: 40.107.13.132, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz3KZLXO6sEjV11qF2Re7J7C2KXt3LhhnvbcPk0jRdmMvbsWThalXcoGTnOzYW6o7LS9q4/pzP3dkVb3/n5E2wKdG1h7lxdNWflXN+E3LmoQJZokyD+Xs/F8LyXyOFQ5AukYjIP28QIg93PJMV58cQyJmwofNL+U7LqPC+zVtuvhroSkj4rKw2YOZ7PjeI/sx3AU/acEgiP84hnW4q3vA+jMSoDeFNvohvj4Z5VfUPacyrpWhkBapJvdJblqsHN1TWGmllg1zpYhLqVbF4CN4nnLzSr+tsZ+7zog9lye8huSItIbPnBeR0rJa28Lo7a6m8K9oTJvq08G+8/Mg5Id9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRbMMcZY16BQs0a9oo8DmT+kmfqbFdBjHIGxjlrl3rY=;
 b=c4NpTxg99F5WO+EjbZJDH86r+Sk9qWBz7YBGTpWGj1uxHPAlMZHHhSbwFxa1cN3HiQ8Bh7ypgBaQ5gn/wkdZ8GX6OQJBBiY/A29TLc1yUdq8gveQHpraXqzISCN46JRKz/bKN+tRsItki7IKSmiBGADPvIy9UR+0aw+0N8a+DL0LBbe1iphVfM2EVBUDyQ1/RaOMyKBnos3ohpLeAt6rV1H/a9fkG42RPEgg/hYRqa4JNY2HuUNMrkwnTptP83Pokw2HjLLR2PE0aM/TjIUOm2VMeI+PVGGYdhPrwdm3EgKYPMekZkJn9qz7y3vrHS6uCcK40qx3es5MNBWPf3yYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRbMMcZY16BQs0a9oo8DmT+kmfqbFdBjHIGxjlrl3rY=;
 b=X017oQzlCz03W+zzbhAnZ4bemEvpGqHgC7hjEy6K3Bwktomlqrp//4dfN+HHps5Jcuav3OkgrRXzITrKzlEXC/6JzdNiMW/1Sy1XR0MWfHp5BN4LLppzxLJfHxhwkN26qZJQxTSBR7iH5XCnecibyXMKf5bc8CJuZowYa++j6OA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB9379.eurprd04.prod.outlook.com (2603:10a6:10:369::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 09:01:28 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 09:01:28 +0000
Message-ID: <915382c9-b496-4de3-a76d-30ce4afb9d74@cherry.de>
Date: Fri, 14 Jun 2024 11:01:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v3 4/4] README: sort
 MACHINE names
To: yocto-patches@lists.yoctoproject.org
References: <20240613170154.6441-1-twoerner@gmail.com>
 <20240613170154.6441-4-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240613170154.6441-4-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0037.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::17) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB9379:EE_
X-MS-Office365-Filtering-Correlation-Id: 0857036a-060b-4d2d-13f2-08dc8c509369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|366011|1800799019;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UlcvZTZXL0hJd0hPZlpvSlhMd25wa1o0K3FrN2pMY2dNZWVtRkU0NmhCbWRB?=
 =?utf-8?B?UzZaWWtZRXB0Z2NvdVZnL1BmekdmRHYzZklCWm9CaXlwT1RRaDFzdjZoTVJT?=
 =?utf-8?B?RGhlYzZDZXRVRHBWZExURnh3UHREZ3pBWE5CVDBGWXBzOW5tWGpsbXhRdXdZ?=
 =?utf-8?B?RlIzb0tzbWxheDg5ZWR1amlzWE9KakQ3bElEeUpkd3NzT09uWjdQMFBvYys5?=
 =?utf-8?B?TkJkT25RZy9ET0NWTDdDbVF2VFI0SVJyYjQ2Y0c2ZElWdVJ4NDViRGtqS1Va?=
 =?utf-8?B?d2h5ZmdQVDhoQ2prbkZtNkFFVVdpbUtzQXlwbTBYUmJXL2IyUXVZYkluTkRt?=
 =?utf-8?B?bklMaVZCQUVKNzIyTVZ6T3lpR2s2UkNmQlZrdDFObGJoZG9rcEdBZy9WTkQw?=
 =?utf-8?B?N3BDc0ZqNFpZYlVRMlBCeDZGaWNoRGNvZ3BzUUp1YlB2NVN5NHdZQ0o4ZDZQ?=
 =?utf-8?B?K3pFWmhmdlA0ZmI0Zm1IQW1ZUys5NEJBaUEzVkhzUm9ZVU8rN1ZkYkVObWo5?=
 =?utf-8?B?MTl2VlpCUndwSndYQVlJVHRZNXhTbGFnbkpGdC81N1IwVlJIYVNTQlBzcDM2?=
 =?utf-8?B?K0U0Y0dkVjRWbC93dU5lRFdtdUFPMzJVT1RXMnc4S2ZNaVV2U2FmSFpQYlE0?=
 =?utf-8?B?VkNhS29hWkZmM0o4T1F4cVV1dElFRTV4S2dwdzJYckNjV2t3d2Z4c3NiK1M2?=
 =?utf-8?B?ZkN4STdhOUwra3BkZkphREhxaTdxc0Y0QzVnak1ncHBuK3FJcVZxVXZaVmpQ?=
 =?utf-8?B?OGtOeHRiZFNUN2FSZzIwRHZWaWJrV2VuU3pWVnJJTG5Ga0hjbUFIL3lNeE9p?=
 =?utf-8?B?bjVSdnJaWEZqUGNQWXFiY0hMSSt3bXBlQU0zNEc4b3FQOE9NNUdabXB3Q25C?=
 =?utf-8?B?bUxjaVFjMXc5VkpWSFZ4aUxCWTF1RTE4QkgvL2VzR3VNWktwUFFhRXNqSWJR?=
 =?utf-8?B?Zlo1T2UwYmh3TzQrY0I4RDkydm1uc2RsUjFhaGJaQ1R4TEEwektQSVJOSElL?=
 =?utf-8?B?MWFjUDdrbnJCYk53ZlhZaEJkUVJ6eWhTbDc3U2RJMEtJa1lOdGdxbk1yaER2?=
 =?utf-8?B?V2ZKSUJza2s0V0IyR2h2Wk5wd2ZzanQvWW5tdmw1dTJnRmZoYk9UTjlzdmYw?=
 =?utf-8?B?ZXY3Q2RtOTlkaS9oNXErbkVHUWtFUTZyRkpBQ2hxK1JZQ0Y3ZHdmeFl5bXVz?=
 =?utf-8?B?NWVNT0h6RFpPZWlBVEwra2JyeTAraGFva1VrRHJMeVpYSmJ6UmFQbDhsQ1RM?=
 =?utf-8?B?Y1Q5TUZJTlI3bXpXSWlLL2pOVEtyc1NoTkN1ZVh6YUFMNVVWQXZhWmpqQWxa?=
 =?utf-8?B?Y2ZQcVB1Q0hXclVodFY0RUlmOVpJcGZWOVZIbkJma3BzamFEU1FpV2pMK1Bx?=
 =?utf-8?B?WWRuN0NsaFk4SHdNY1grendMeVh6TlJVSUt4ZkoweDFzWjhiTEE1M0hucDhH?=
 =?utf-8?B?b0tDM2Y1cnBObUVKZXFtTU9IQm5XWWRxSFcwS3ZqYkdEV25EUTNBMkJLKzdB?=
 =?utf-8?B?WTZxNklmTkVNTkxlNithSHptVzFZRk9mUUFkczBoVC9WSXZnc0hBWGszMmZ2?=
 =?utf-8?B?bWNOK2l2eXZ1aWN4c0lXTlQvdVBZS21HS1E3alBJY1dUS1lZbHhHeWhZQWlW?=
 =?utf-8?B?MmJTUmhnSHI2K0tleUk2YmZ6cHhpS21tRXFxMHJRNDNzY21XNDRBOVF2WVpF?=
 =?utf-8?B?OG5VVlEzMk1EUDRreDB3L2hXTjR2a0ViNGNNUzQxNHIrVXJjaHZLWWZ0NDRa?=
 =?utf-8?Q?UbV9j2ynpIXvdImYMQhyeU7XwyN6o3ZACdlkpHS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(366011)(1800799019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M3Jyc2E3NXRheWIyL0hCblV3SkcvY0pudnRKTmFkZHhvUTE3NVpkU0hjYmVN?=
 =?utf-8?B?N1lZTWg5Vmh5eGNsQ2lwbFpuWC9jNTRGb0VNUk1ldDZIOTF5VmI3VmsySzNp?=
 =?utf-8?B?NnhSU3RreklldVdCT2VCbjJLUTRBdlRTNTlSbXo1MFQwaWpWVm04RStXVGNN?=
 =?utf-8?B?eG9jUERkSUY5ODV6S0tibnlTamYvNHNYTnJqZTM4WENaVjNpTWZScEx1TS9y?=
 =?utf-8?B?LytlMVBoSmdoRHUvcmlVUGVQRjJGcVZVRmdzVUNVZFBUY281TWpCYlQ2bWRD?=
 =?utf-8?B?YlllSEEvV0RZMXB2SUdYbmQ1TFlabVlCR1dQSTZvL0RnSHZaZXkxSlEvL09Y?=
 =?utf-8?B?Ri84aWxMY3V1OU9NcTMzNlBBUWxsZjVvVVBVVkZWWlJQYVZLZFRPOGhzNy9Y?=
 =?utf-8?B?SUY4MzBmVXRoOGVOSVZSbVJIcUJ6aythL0NHaEFyNHVxQW9HY1pSZWZsbUs3?=
 =?utf-8?B?eU9adnIvVUpVc0VxU0c0RXlUQnl2RUhiRi94WDZRQ0F6cnpVekFaT3g3SC9z?=
 =?utf-8?B?MnljbkpSU3hBU0R0NVRQTFJTbEh3c0YyKzJuR1RtZXVwYVd1QktURGpjdHhT?=
 =?utf-8?B?N1ZhKy9ueXRkb1BDdmRQa09xTmx5VStXV3MxM0FVNzNPS0R4WjJPVnFqUG0v?=
 =?utf-8?B?Ris4bFZxSCtvOEFvQWtTd2IvemxyY3Z3bHNzbTR0WHNNTmMrMWhQWUxrNVZC?=
 =?utf-8?B?WWtBNG9WRmFlRUVsdkN3UjhzbFFzMjJ2VUxac3dYSUFTQUxSQjk5TC9RZEtK?=
 =?utf-8?B?SVhQL0J2aXJaamRwb1J4WStSUEdlaHkzOVlRWnVUdTBJejdrcDNTZm5zQmtE?=
 =?utf-8?B?bXlJUXZZMTBxeTYySHY3SlJJYU1LTXZjTUJwalQzdFVCNUFVWUVTb2NkODhk?=
 =?utf-8?B?RFQ3RUtPNlJUYitLN3dLS1hPQ0VhckZEM05WVm9GVFQvVDRuVWZpYmhDSUlr?=
 =?utf-8?B?UEx6cWk1MlRRYTVyT09ERE5HUGEzUERzSlZzOFhxQmZmdGdhK3JpU29GeEZz?=
 =?utf-8?B?TnFibXRsNzRFZGkwTTR4dTFxaWlEcVhZYWRGTjhPVEJyWlN1OFg5azVqTWFz?=
 =?utf-8?B?c1AyRWNGZGRtYk53SENhcXMxZGRZbXZpTmhYMThGTDRFM0Qxek5GdHVWVHZz?=
 =?utf-8?B?S2xCUjk1MUloKzRua3ZYWmRQK3Z5YVJ5dlJtdkJRVnZzOG1QWEtIbEpVWmor?=
 =?utf-8?B?ZHhhcWtuM0NXSFpKeUlTcUhyTjNTRUxOb0wwbEdrRHJkMkZLcFVuWkJTOUdZ?=
 =?utf-8?B?TWdOSk9TZFJJS3U2M2IzMUsxUWZxSXNjdk1iREh0MGhKVzdSSWU4T05TOWFV?=
 =?utf-8?B?dmE1R2FXc0VkZVZOcGFoTHdyTEY5aXd2UHdMR1FicFI5NE5EdEVnYnhZQkNZ?=
 =?utf-8?B?U2NyNnJ3aElXWjJlVmoxZGtzQjk2dkxhWnBFM3U0NU84YW1vRUlibFpWblZq?=
 =?utf-8?B?YjNpckhQTjVlSmNzaXdSekNvOGhqQkUyVTQ4OEZwSmY5Q1pEUTRiRzAvcTdU?=
 =?utf-8?B?Vm55SU1QMGduSENWOEErSmpWS09tSG83M2FsdmdpNzNwY2U0bVlpanc4UTE5?=
 =?utf-8?B?U3M5VFh4WmY5UXIzUkJheW9sTGZGRTJ2UDRLMzBxRVMrTWJscEZUd1czaXQv?=
 =?utf-8?B?VWt6RzhsWDlxa1pyQXphT3RuOXdWanpmdHV3bjVpaXYyUUFEMXFzMlJyVk5H?=
 =?utf-8?B?UnlnZTZoSklQVTA5T2VqMjE2bHFkTTNtdURWYnpRblAvZ0JNbUR3RVc2OEZW?=
 =?utf-8?B?QWpzT2d6WnpVcS9iUDFWTkRZL1ZaNlJZQ3RhZFBuNjlPN0sxYXlaYjFtRmJ2?=
 =?utf-8?B?UmZVSW1uVXpWUC9EUGN0T0NHeU12ak9BM2VxNmNPOXF0a01CYXpLUDRoN0hB?=
 =?utf-8?B?K01waE5mZ3RjVGFtcVNHN2dTVHFRN0FSRE1zSzJNeERWQVRvTUFURTY2Y0xF?=
 =?utf-8?B?NW8vdFpocUt4RTJmcnllUnlVQnl4cTI3bE1Ha3o3SWw1VlNId25TQ210SXdQ?=
 =?utf-8?B?RGZnSjA1NzJiR21JMWRvRjR3NkZ0TzBsMmZCTFBaMjZZNGxSbXd3UFVIVUxu?=
 =?utf-8?B?dHBsQzB1NmtOKzJDWExTdytiUmtZeHBQbysxb1l1TERjZGtmNERmc3FwYVk2?=
 =?utf-8?B?N2QydjlSZ0JrRkJVNUdHQnRFcEJoa3lCYi80VUhZVCswSUI0UGdkemdRcU5j?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0857036a-060b-4d2d-13f2-08dc8c509369
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:01:27.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5we/PiX+Vc0IFS2mk/H4dHgV+e35d50KrgHlkAYY/XGyARQ7377CFGhXu0T3Kpea4NK42q78vIAdiiU7WB2ZItYigdHlbxxr4MoDZv8I9ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9379
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Jun 2024 09:01:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/330

Hi Trevor,

On 6/13/24 7:01 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Previously the MACHINEs were listed in the order in which they were added to
> the layer. Going forward, separate the list into 32 vs 64 bit, sort each of
> those groups, while distinguishing between which boards support wic and which
> don't.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

