Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452A7D59D8E
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 19:11:53 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1245.1765566710797197245
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Dec 2025 11:11:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Ssr4Yzuz;
 spf=pass (domain: cherry.de, ip: 40.107.130.50, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nwk53EZgBsdTk40Vsi7YNv/LYS0MDceZd1nXojBA7zftJOzUVNLjblxsbzI12I2Etbui41aotd5ajSPLQPi/4BXsLdyT5hSBUqaScm5DRvsVX5AMwzyJWCMNHQJl1uDmMahglvgwuM6ehw+IAEigd462313N2yAN9vkA4ybKgtW1Th66hmksN0wsnODVJxGZk1xZuPyzFTtHHvkK2Po24zjDMJcB5lV1C5AXWwfBzg6+th1+85CAJ0xd9GMeWl4k3mIE/XsIkrbj1NF97lc0NCYWlYKMC3oXvZ9QPV9c8oDWp+C5AC8O57h+cR2ALywLmvcb+xcF7eiyIgS65NLpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFZmnyp4McsICvIF3vXTKm+CQtQCCPDY6XDLssrbo30=;
 b=QMN3ZOwEGujVDdafwMJiwuga1w2KkI0luvmz3AyJWji3aPIQyb5d+QVcLx8lrJzq08ftlM7R6RVNCfyGUmA7qBzEIB3XIbaiAJaNWdPJJIMGVbyXUj2RARAdKqkYJ401N2ybjViQEgnlqgTLRm/oLCSZbm5I9igB/06vt8As6lfV8GT7VfY17iddygitFKwJwOoXHaR7E2xDncOh9bZMjYEmUEQqwHXx7m7t20oO0IHjGBikpiYDsWmdf9Bm0/k2oCsp6fxM8cV+sbaK6vkgPrKTyI53wR4GxtUR4/RUmlitsKOrvAPjnU5AX8qHOYT4iDIEbizWenzLDHH56ZkCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFZmnyp4McsICvIF3vXTKm+CQtQCCPDY6XDLssrbo30=;
 b=Ssr4YzuziT8TmSZcPClEY2RlV54kcroalGa7xtRSOUlamWZSjxhSaj6UgbdG7L0WvKhpN97A7DmvCDNAF7EWOCIopdiza+3Fmk681izkxDKm5+8wKwJqVhvMNy2fe1nufhdA/SE7gqWL20GzecUp3a4JK7bB+baOvA6L4ubIF6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU2PR04MB9017.eurprd04.prod.outlook.com (2603:10a6:10:2d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 19:11:46 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 19:11:46 +0000
Message-ID: <96cf4f0b-d3ce-4b15-9f5d-e7d16a3f4162@cherry.de>
Date: Fri, 12 Dec 2025 20:11:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/2] provide a
 filesystem overlay example
To: yocto-patches@lists.yoctoproject.org
References: <20251212182420.24920-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251212182420.24920-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU2PR04MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 2faba6d4-236c-41ee-df70-08de39b24b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UitWZzZpQ3ZKYXJYazlaQi9UMEpSTCtQMGZvYWt0QjVBR0FWMER0YktlNDkz?=
 =?utf-8?B?cXpxTlEzRXl2NHovZ08rZmNRWjQ3d3F3bkpMc2x3UUZFT0ZlNitkY2IycG1p?=
 =?utf-8?B?MzhaMFhGNVk5UVVHME0yTVNONEZ6QUkxMld2Z0ticFZ4ekk2a1d6eXpxUGJR?=
 =?utf-8?B?M1JTTmNRcDVnSy84UVIrT1JoeUhSYVV0QmhyMEpjOXRHVFBCYzMrZUZwYUtW?=
 =?utf-8?B?QytRMzRYdVlzalBwN2pCRHA0SUpjeW4rRndDbFgxbGV0akJ5TmorZHhKbW9o?=
 =?utf-8?B?U0FDQ0NJK2xsYWY2RTVrL3dFN09mTGIwYk9WUGltUGI3TSt4d3lWcnV4VHpx?=
 =?utf-8?B?VGoxK0cwQ3V5RnNOTTk1NE1PdW9keXVHYkVJTjVhMjQ1UmY1U2FYUWVkZ05V?=
 =?utf-8?B?VjlDTUpqM2VoSGQyekI5dC9pOTZUNzNJMWt3bTN4MlE2SjBjczBIa3hRWHo1?=
 =?utf-8?B?QkpRQUtyeU8wNkVIWVMrUEV1OVdySFQzU1B4aGMxRUFoTy9ydE5kbHlWaDRX?=
 =?utf-8?B?RmJGQzFuK2JNWFVMSTE2LzFSNGYxRmcrbEhDU2U0eUUyM1FxQ1VsZ0NlSmlT?=
 =?utf-8?B?QjQ5MUFMWGtjblo5ZEovNjFtOGtTZGZXNDlPVkpDVjV2WVVhMEZRakNCWjEy?=
 =?utf-8?B?RUM5YURJMENRdTBkTXR4MkUvSjI5OEhBV0ZyekFhZlE3SlBKRElMdlh1eFlH?=
 =?utf-8?B?a1I3ZFR1a2FzM0VHbWFKTlNRMVZRSTVzQXBhOU9xZXhvK21SNUtkL2RtSDJy?=
 =?utf-8?B?R2tLbHhYcmVwaEFCOURIUzJhV0hKMFZQeGVKQzdMUEF3OTNWS3o0N0ZkVTM1?=
 =?utf-8?B?RXI0dzBKUVUwMmQ1bXUyMkN0UDhDcTcxakRuOXJzV0NnNHd4R0s5VHdQeHRq?=
 =?utf-8?B?aTNDKzFtTjRoczZFeWpvSFBWcUE0Zms4ai8rTEhtWkJFdVEzdWRDV201eGly?=
 =?utf-8?B?eEpaT21idTRqMnNhTWZTdDVPMndUU0JvaEoySUQ5UWlHMjNVRW83NG1vNDNm?=
 =?utf-8?B?azk5cHFQVUZuamZPTlB1a2FBSDg1MGFsbFBaSzFCQnVXNk9kSCs2R1R0Vksx?=
 =?utf-8?B?M0ZTdWZTbkFsQnZIVlZaNFJDbUFyQ2VWQVpFcEM1VUxwS05BTlVaZUhTbTNE?=
 =?utf-8?B?SkRkUXZSSFRPaDVOR1k1ZitNeS9TR0J3OUp3MmFQSWYxMExVNWRacHk2Z3dn?=
 =?utf-8?B?TFNBVXYrVFRqeXJSakVFK2d4V2JlQTBZdVJHdDZrdmFXMmtwTndpb29YdlJW?=
 =?utf-8?B?MWJleXAvWDRHT1hKYVpJSGF6bjN6Zk1IeGdYRHBVQzlxZ3pGZWVQbjJyRFoy?=
 =?utf-8?B?bDdIbVNGMEloZW5SVklDZ2REaGY1Y29xdTR3Vk9xUlVta29Cd3QrRW83TTdm?=
 =?utf-8?B?TkRibXlsRzNmWUUza1g0NHlUMm1kTC9BOEFXakZWZVVOOWZlK1pLKzFzV25V?=
 =?utf-8?B?c2tSRWF3ellrdGlxb3lmcVlXUldNeG9OaGZ2aDdBdHd3akdoNGxlTWJwSnR2?=
 =?utf-8?B?ZHBsK0NTdGFsNURQTmNDS1JuNmNyck1jRnFKVmRKWGVBalRRcFk1enZ5TFds?=
 =?utf-8?B?V2Q3Wjk2YVpCNENQSjZjRUp5WVlQUmJaSGV2SlI1amVVejBsUTVSRHF6ZzJH?=
 =?utf-8?B?M0NHMFFOVDQ5SThRUTBoNWoyMjNQVXFXalp5YmtTMTE5NlIvOWJuVkhlcmlp?=
 =?utf-8?B?WmlVczNFbTlCbUk4TWsvU0wyMTNKZVhNdGxtSHhzdVdFMHNqVmpoakpQeW5M?=
 =?utf-8?B?V09UVTRSRGx2UVZlN2xBQmcrbHZmZnNNblV3VjlCU0dqNlNNUW5veGNsMTBB?=
 =?utf-8?B?ZnVmc3JxYVVkRFVLWi82K1VWOThvUW1LYWhhMm03aXUvWnR4dCtiTmJrRVpN?=
 =?utf-8?B?dkd2djNGNngvZ3JMZlpDMUNnUkxtMWhOQlF2cmRxcHVKSkdnSWFDbDVKeHVj?=
 =?utf-8?Q?5C7kLbyAQSoQ4SoqieURvh/fCqusNMmC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHdBQTkyWldETEdnZFNhQjBhak4wTWJVbW16aE1hVmtWMEhFZWhxRDVpR2xp?=
 =?utf-8?B?TnFhZHg2NW0yVWprYyszalR1SC9ad1ZEQndyUjZZd0UwQ25qK1BFL1hDeVFO?=
 =?utf-8?B?cDgyUU1aZVRheXpiREhVT3JZUWtWTE1IdjNaWUg5a1RXZGdQM2h3LzVuMFh1?=
 =?utf-8?B?eXd3bkZtdXlmd0tpckIzL0hNSkh1SUpXM1pTY0h1UmxXU3NuU3E5blQwSldF?=
 =?utf-8?B?T1ZxYlhFbjIwQmM5UHQ4eUg1c2F3SWdCV1ptcllDdXZRU25WampFMzJkTEtN?=
 =?utf-8?B?L2JrQ3hqNFBEa0YvMlNQSVVsNzVpUk1vdVVJTVNmSnM4U1RhWmgvM2NoYnl4?=
 =?utf-8?B?TEs1b0taOVNDTmhLWDVpWlRnN2xYVWMrdnoySW81QTgvYUNLOVcydzVNMXhU?=
 =?utf-8?B?UXUrSkVLMGRpMUlVR0ZZTG55amkvOVBmYTJsVzB2cUljcmZLTityY2NENVFT?=
 =?utf-8?B?ZTI3M0liVlFPbDRMY3ZaeHZPY1VraDBoRGVBVTkxOVZVbXJaU2IyVEhJNlZQ?=
 =?utf-8?B?TkVLNmNsK3ZTeEtTWkVZeXhYTWt4Qzh6amRjRVYzTXBIR2xWQnRIYU1zYmNL?=
 =?utf-8?B?Nkk1anpnZnFVMjc5dHh4YUxVMjZnMlVpN1k3dWdVeFV3WmVrNmVXcXg4Qkda?=
 =?utf-8?B?ZExWZ0o1UzI0TldMdFZBS0VVMjVZeDVueTVKMXJESzFTMTZkcUNNUVBWUEJh?=
 =?utf-8?B?TENuZDM5MTd4MThUaWVuUFk2WiswcW5sdUNFaFpGTmdkellpN0pRMW5XRkVI?=
 =?utf-8?B?M0c2Vzd1MUZaTXlWQnl1aWhtRmlDcHVOenduK1djMGorK1VrR2JReGxwM0Ri?=
 =?utf-8?B?ZjBMVjVWZW5NYytueFhSdUxlbzFRUTFsTnh3Y1lXdTd1K2VydC91SjJ1bXU2?=
 =?utf-8?B?dzdkRys3dEJGNDl5VVkycVh0SGlsTFlYMnhKSHIyT0RzRmZHQ0xqbVE3bU9l?=
 =?utf-8?B?Z0RmQjhCNjBsYWRGeFZSVnZXSUlrUGJYRHhhNkVwR3hPZmJzZTVxLzI1WEhF?=
 =?utf-8?B?aVVZc1lsNVZGOTduNDdzMTFxTlhrZW9zOEFzT1RYWE4wTTNDdEU1L2NySmNR?=
 =?utf-8?B?NTN3aGlKSVdMY2ZSTFB3WDlWVXN6WTNDY29RK0xuNHZwcCsrcjl4NXBNc0Nn?=
 =?utf-8?B?RzZmR1RXTDZJVEtDV1JEZXE1YTRiZnQvVE4rR0diYUpFMHdyQlNGR3huUUhr?=
 =?utf-8?B?R0dRWlg3WTllbWg1a0YwdXl2YnZjektPMG9jZWJCeHZXL2phZWlYS2g1a1Jk?=
 =?utf-8?B?L0tCdnRBRUJnK1d4Q2l6aGsvSTIyWFUrd2ViSnhpVUs2eEptQ2hlTzZaYXZ4?=
 =?utf-8?B?d2k5anBmbDJnZzdtOEJiVjFrT2pKSHh6R3VubEhRRFpCR1hyZ0VuQnpoOVRD?=
 =?utf-8?B?UThEVTViWVAweFFYM1hFV0E3ZjZEVDUwNFZrbkFqRkxhZ1dEMTFoQXNoU3Z3?=
 =?utf-8?B?K09yeXBObWcxOElmeVB6cDg3NHpHcjN5OWJxbGF1WHBLa1BqQ1ZUQ3liUlhI?=
 =?utf-8?B?d000RUJoamVMR04yQUdxcTJsdmRob01EbjZWamJyRW1qNWZoMUdpZnJ5dERh?=
 =?utf-8?B?VG85cE5wUlIzTjl3WC85ODFPYmd3SnV6VktkVDRGVUt4eEdybzhKL1NGZTl0?=
 =?utf-8?B?dS9QTHJWcTZOeHNtQ2ZNZGFKL2xHd09lYVhnd3hLOWlOcWl0RkJKK3hzSVhX?=
 =?utf-8?B?elkvRlBTL051TXdRTkJKUjIyeVBncGozdDk5YlVkL3RWT2grWWVVUjR0UmZj?=
 =?utf-8?B?eXM5SklCckVXeldtbE5MdThYZjhFQ3psOFpxT3I4cTdSOE83elhZeW5TR29E?=
 =?utf-8?B?cHdYcHV4WUVkcUdGMW9RczVJOVJKem5HcDZiRWFnRGdJT3dtVmRLcXN1ZXJo?=
 =?utf-8?B?SVc0VzJQQUl3QUVPUjFjeGpGOFQ1M3puUTB0L3prazJDTS92MjVzZWs0VUZo?=
 =?utf-8?B?Z1ZzMXpwNXdXbUw0Rk0xcHFFcWJCOGtZSStibkVXRUtOcFcrNDNZZHNwNUNF?=
 =?utf-8?B?Ui84S2E0b2l5R3dxSjMwUy9SNDJGSFRoc2JVTzE1bnhCeGNFSTFabjd4RUdy?=
 =?utf-8?B?aUlOU0JtamY5NDZVTXZNOWQ0L3MyN3g3clp5MTAzUVhqa2p2eDQ5OE9mbUFW?=
 =?utf-8?B?dTVUeVJoWjg0RU9ZQWUwbkt1TUxHUDdVNFBqQktRb3pqclllMUhkUmJkZ0M2?=
 =?utf-8?Q?P51RQjX9BLRQkJyV5/n3BBQ=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faba6d4-236c-41ee-df70-08de39b24b47
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 19:11:46.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T8JOE3IGZzC1DXe6tPYyHzQ9Cc+QLDfRLZyg7QesMwqh8HJ74ffMxNgQ03tC4S/s9P8P1Z3USqNnZ4PF51UaZoCXtb8LvjUfYGCsCC/8H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9017
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 19:11:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2779

Hi Trevor,

On 12/12/25 7:24 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Most implementations that use an A/B, full-partition update mechanism
> (such as RAUC configured for this scenario) need some way of preserving
> system configurations in a location that survives updates. The RAUC demo
> provided in this layer is an example of a full-partition update,
> therefore provide an example of using a filesystem overlay to preserve
> the /etc and /home locations.
> 
> This example is gated by a configuration knob:
> 
> 	RK_OVERLAY_DEMO
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

