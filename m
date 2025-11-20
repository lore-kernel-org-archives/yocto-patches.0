Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A90ECF8841
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 10:40:15 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31317.1763635209355256149
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 02:40:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=YBF105mX;
 spf=pass (domain: cherry.de, ip: 40.107.159.70, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GC2jnTCEO1qaR5KmXp3aoaPwPE4TQMQypm8qIEqZ8eSG7WnOTNC4h50wt7S9HOtCxYFVyKJrXQ9pYu0u+vpzefFK5xVYm/a9LUbxkZzIFvdcTBc4FRYWCrN0REeCMyf13MPBhfImrEu6s9cfpnoEVTqqCO2BmOCrIszbPUZK0ZFpEvNUUXHigBmryeOMwtY2SwRT0smSXLiNZHQdKqi8F65lqisij/puGzN3QWp1SSPQqWmdNs7YPIuFV3Bq9HxVY7t9NMjDTOX0w0Lhhu+LHniR9j0l35VC3oAGy8ds9o1+J/36A7lDQtFHeWq6LE+TlOOyQ6dFHj4/MGvMZNQQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThuZiMGRYsIwxiM0xX3AmmQNd11MobcrsLDcyDdRGxw=;
 b=LoYupyCuFuKj8B9q/w3I9bJtFCMGzV/RGWjRecHHlf3nugWiPs7razoYjh1SmFZIYtJWhPK67GwRDiDH6jxNQyp2Vl4+wdsU9J5whDDlgPryYLTAYW2bdV88KrJpOzSNm3x/6FR1Zkaz718DMD0IlrJOH1GQDAaxmm/J7D8TSW5VNED8+UmYL7cxhS9tKpGNXcZILtEB+ORvs4vEnbG0UfOQ6wsVQt4aGIRdujrAK+cp0lnDmMSSjG41rlEd+ZC5Wa7E/oHOtWjeq39TPJGBcV383F9rC7ByElJZt5JQuUtgXwWqQTNaRfpqGhZv/x5Y/p7dTC1VO4ncLF7g6JOdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThuZiMGRYsIwxiM0xX3AmmQNd11MobcrsLDcyDdRGxw=;
 b=YBF105mX3/nN8B3RqUu5WO2oaIXD2ZN4UIQ0ms7kLXeMP7QGBmb9ajSniRaKtioL9K7HerF7FK90TuZ6WkuSedJXKaBltM1VJ/qnYda5NkQ6P+xY9EI8LU5nFC7SWeZRwaYzFhGXvKH+aO6Zx5PcUhKTbITbzdksXoDbrB4CIO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7990.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 10:40:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 10:40:06 +0000
Message-ID: <58102c94-8c32-450a-bccf-1edd16bbad3f@cherry.de>
Date: Thu, 20 Nov 2025 11:40:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip] orangepi-3b: add
To: yocto-patches@lists.yoctoproject.org
Cc: michael.opdenacker@rootcommit.com
References: <1879B0158049C4B6.1423420@lists.yoctoproject.org>
 <f176e971-d19f-47a1-a591-d2a501d16079@rootcommit.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <f176e971-d19f-47a1-a591-d2a501d16079@rootcommit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: b21dee83-7ad9-439f-7a41-08de28212b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bEZSUGVscXBOMWJDWmErdWoyZnd6Vm5nUnJHWDM5T2lNOEppQ2NOenpETGpw?=
 =?utf-8?B?dGtYZFNXaW9XUitlL3hhVVB2ZnZ2NjVjT0xmejB0Y29JcTgvN2RpZUlIRDRm?=
 =?utf-8?B?YmV1dzNNaVVBdzhWT3BEdm5jRDdwQit4S0VDN29XSVdOVk5RQklPbWNIOTY4?=
 =?utf-8?B?VEJCeDlFOVNIL1JzdSsyN0g3NHc1bTc3SW5iRGZJSHZkdHM4YnlabXlucW96?=
 =?utf-8?B?ajNZNlZoT2E1clZtdHByREkvTDRPS0Z4NE9DTG9VdjhWL2RHMlZZbkRmUzlt?=
 =?utf-8?B?WU1EUHF2TTJmUlpPT1NZem1KTDhId0RUOVplUzZ6a1FiOUFEVlpMOWJzeUZh?=
 =?utf-8?B?T3haVm5NNjA4dDE1dTRUWk0vVVh6NnFoODg1S1JPNFF6MDgvMERsRStzajA5?=
 =?utf-8?B?ZnlKZXVqY0ttei9XcWQ0L1hQSkUxRE1kZmpmVlRxWUF3dDM0amE4d3F4MDBI?=
 =?utf-8?B?ekRJcndiM2R4QUhMNkhzZitCUEU1SlpaLzArbUpXbXFwUFhyMlI1N3pKSjlK?=
 =?utf-8?B?ZlZHcHhMMHZ5bE1hM29lWVJnR01uR2VwajNnNTJwTXhhNHYxWnFXdlF5bUQz?=
 =?utf-8?B?VWtWUVVVaVpqUUZFOU1OYk5ZSVBqdzV3SkFtOU5oRTUrRHdCY2gxeXlyTUxn?=
 =?utf-8?B?cEMrNFVtZUdvZ01ISWJLaUovQzRFanU3dHNnZTMrWkJNTzRvc1pGYjVUajl5?=
 =?utf-8?B?WmxxZVpiZXJoWXFDR2I4Y2tNR3h0TXowKzkrTGw5QUIzdjdwNGZZdE11ZW1m?=
 =?utf-8?B?RC9HeFVEYlpIekxLN2JuVzNGY0YxaEcwcXlFZ2VoUUFkdCtqd2JTWlZwKzJI?=
 =?utf-8?B?eVNqc1YxUDlJcmdLV2pOWnE5OGVNMUhUb0dKODVLTE5NVXVxR2hBc1E0Nk00?=
 =?utf-8?B?NGlMYmtxZzA2YVArWTNTaUFIbEowb01HN1lIWDh1OFJaTG5qbEptWFlHZCt5?=
 =?utf-8?B?SUY1UWIvRmhFcStyMWQxVExDSVRDTVgrai9Kd0k4MjZWUllLYTR0RXZMczlP?=
 =?utf-8?B?T2E0eGtzVDMrYU0xM09VbkQ3alN2NGorVEpMNU14VXRST1VnNEJlbU5uN1d1?=
 =?utf-8?B?QWx0YWx4WUZ6S294WEJ3b2ZSRFI2WTdsVmxISXFFcGtDT0cwYXhXYzdlekE5?=
 =?utf-8?B?Wmg2MmhCclRqSnUyVmtHZ1pRQk53Ynd1RVhZV2JtWWxta2pLWk9wS1UvVHo3?=
 =?utf-8?B?eXdPM0FibnUrVE54ZDNzR2xRNmFJY2tuMktyLzMxRUNEcFBVSmgvb1llRkdu?=
 =?utf-8?B?K1BHYUhJTkFvMEVBRHdWNFNoQkZtN3ZKcEZDc1ZjS05OSEplUHZRMmNpREVu?=
 =?utf-8?B?VjVqbXB5STZKSWJGbTBUQnpJeW1rWjZ1YXB5d3VHVmVNelFrS1UrTHRQencz?=
 =?utf-8?B?R0I5WGg5NkZSM0VXaUlvTERrWjdmWmRuNEhpMk9TVmFlc21SY0t4YVdwajVn?=
 =?utf-8?B?SDJ5MVYzTmpKY0E2a2Q3bzdPdFJpbjgrOUkzaml0RVQwVGhLZ1ZOcEV0Mm9G?=
 =?utf-8?B?UUp1V1NyeldaN3hKK0ZxdThpWmhoaFFVWkNHVFlqdy9ySURCbzJFRjd2NVRR?=
 =?utf-8?B?cXRUNm9id1BSVWdpYnFiNGprRk4wOFhRSkRSTnBWY0JkOVFPMEtha3c0V1Ju?=
 =?utf-8?B?cTVpL1BkSWJxOG9OamZMNytwSjFzdGtBam1EYnpGN2g4enJ2WUx2NmZFYlpJ?=
 =?utf-8?B?UW9XbWJWUC9hTFhzaU1xYi9MaHRVdE9oa25rTDR2OHhjSzJQRm1MNHNqRGgx?=
 =?utf-8?B?dGdXU0hGRkVkRGNTcitSWGVSMk1hR21ETUFzMVpPQWJROXhTakVoajZwU2l3?=
 =?utf-8?B?QUIvNHBjMWNac1Y2N2k4R25reW1CNWNWUVNFbkt5Y29yM2tWaWx2ZG1PMlRj?=
 =?utf-8?B?TXo4UWY4KzcyOWl2RDVuWWhwaTFDbUpJTHpyWHo1UTlIU1BrTG9yTzU4SW5D?=
 =?utf-8?Q?Yx4iYEkrxYCOyau0pObuMoHJD7jAiplK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjFSVWk3SkZlUkNtaFltUENkZ3NBWVZsTVhhSkk2RnZoZXdIZFNNV2svU1B6?=
 =?utf-8?B?MklCNHlOaUsyTmtrc0VzV2VUc3RiV25aR0V6VjdxL3NRdmJMTXQ1MksvTm1B?=
 =?utf-8?B?Q0hNT3lkTGRVVkUzN3k3U2NlUnN3UERuMnB4Tm85aElHditEMytzYnAvekFM?=
 =?utf-8?B?R1NKRlpyY0FRbkwxZ0t1cU5xNHRtQUFFclhaTEVMMUV1Z3c5VGYyMy9aZ2dX?=
 =?utf-8?B?UU9tclpsVG55bUF5N1lJR2J1WVVLNzN1V1RZbWt2WUNzL3JxZHJTMFFsZExO?=
 =?utf-8?B?bmJWZEp5NEdaeU5ETVJzQ1BPdWdiY3NVamhzbGJsbVNDSitjNkQ0SDlPZ0tr?=
 =?utf-8?B?bjR6ZG5qLzdjdTVGbFhDbGM1YnpRaWVvRlNRNFpQUWRIWXVIR3pFcmVGYTd5?=
 =?utf-8?B?S21TYTE4c2FMd0xZQjBHWlhmVVYrS0ZodzFhUGhNSzRzWDBpSWcweXQwMU1N?=
 =?utf-8?B?R0tNcnQ0RXlHdDFGV0NmM2VlZ1dtS0t6YWoveDluZEZnOFF1OGZ0enhOS3Vv?=
 =?utf-8?B?Y1laUkFmUWt5blRIWTJ3dXpkeUswTDlBQzI1S0ZadkRvNWNwNHR1TVNwOWF0?=
 =?utf-8?B?VkV0d2ZqZUtpRU5aZXJaNnpGL1ZyZmZmNWpuVFc3dytYMXRWMHAwY0NiamE0?=
 =?utf-8?B?NzBaMXlra2IzdzQ3cGJob1dybGdzaFJYdTBGRjBIUUxNeGZVK0N3Zmk2WEpC?=
 =?utf-8?B?ZVU2QWdOb0dxZGtWMUMwV0dlQ0RKeklSbFFkLzZwSXZ5azBVb0o2bjd1MDZp?=
 =?utf-8?B?UUlPY0hVUzhrMW0yOTlqQmY2SXE2U1ZZVTVqV0ZYbTlibDk3RVNadlBzNXVv?=
 =?utf-8?B?bE04dTRqbEtCdWtvbDk5U1B3clBNM3VmTCtKSnVlRU0vSS9Bd1BJak5HbUll?=
 =?utf-8?B?U3N1b29BSUsvMnJSUHBQUGxhcTFWdUNENU5HemovMU4wb1pTN1Z2bHFRWVpM?=
 =?utf-8?B?eDg2STNvRVplMmJwUDhScGtEMldzUWdBdnlFTDZaWVNJbm5zSk0vR1VPdStU?=
 =?utf-8?B?RlZmOWVPc1JubVpEdVg5TE5SQ1RCb3ZpVFFWSUcyK1d2VjY1blJGdlFoc1Fh?=
 =?utf-8?B?U3VBMHJPa1VXYVFUbTJTSVNmOHZzRyt3bS93cTdoaFFzdnN0RzhacmhKV1NE?=
 =?utf-8?B?Zk90b3ZRWlpiVXJWN1IvUlFWcTZpMHhQVjZCRnJXdHhtTFVNcjFNbHZSQytZ?=
 =?utf-8?B?dXlIa2kwMVRKaW00N21CUWdtaWVackFnN1ZKbUNTdEI2VUZ2RWNIclo4RjRy?=
 =?utf-8?B?NWR5dGRMNUZMN21mbE0yZVhVcGlHOTBpWmFobGF2N1dISFJBTWIyR2Jlamp6?=
 =?utf-8?B?d0psL3cwTTdEMXYvWlBwOUdzMkRjSkJWSHVxNURRcFhhKzY3b1VkUU9tM1ZC?=
 =?utf-8?B?QUdNSVNpWUwwcHVhT2dOcW1LYVZzRVVnLzRiUFJ6QUVCYVV6QVpOUFd5cHdL?=
 =?utf-8?B?TEkzR0huOVhkdk9ERGxsMVhCM0tnbkFJOERvY1hleU1NVFU0VlVZUVo4bzY5?=
 =?utf-8?B?d0hSbnZYSEVQRzdnMWoyVVFQcjNYcUhWSHp3bGVoZCtudHV6T0wrdUljNE94?=
 =?utf-8?B?WHE0N05lZkpIV3JlM3A4VmIxVzJ4emJxYmlXMEloZkxGaWJld2lPZHBFMHJS?=
 =?utf-8?B?aFlFQ21ISW9ldDRMVy91MUp0Q05sSkQvNWZpeU5nR1gyUkFGTExmaGdNWmMv?=
 =?utf-8?B?Y3IxRGw0S2FYTWt4WngwNXUydE41bHRpMForTklWY244OXZaYjd1Y2d5clJ2?=
 =?utf-8?B?RWVBUHMyM2d3Q01zaXNqbWJsVmhoQlY0bStYLzNNY1lsY2ZFbCs1Wi9QSlp3?=
 =?utf-8?B?NUdBbHg3WHE2RnRnekJhdlJqazQxWmFpYUdiWWZJR1RsT1ZmRnM0VzNxQ1o0?=
 =?utf-8?B?cUpMajFNV3oyVFlDVy9TZjZleXFacktRY0pUV2VuRloza0JTYytUREhiY1Ns?=
 =?utf-8?B?UTBaaW1BQk81azJYOUFWZ2h3azdEUEFveW9EcGtnWC9PakxsejU3ekF2U3U2?=
 =?utf-8?B?d3R2Vzg3RVVMS1EzUGpMK1JNekxOcXRQdmNlWms4ZlFuRllpQ05nUXN3NDZG?=
 =?utf-8?B?YTBjQUpjeUFSTWY1V3JIYWRhd25kZFRoNE1KMHJNQ2VGUFVwYWJqYkxOVjhC?=
 =?utf-8?B?ZnVCNlNEUk9ibWJVUVlReU9ZSmVJR01tU0tzSFZsL2o5WXdZT0QvbFJlRkJa?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b21dee83-7ad9-439f-7a41-08de28212b68
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:40:06.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jABCA/X92aZuTfvYYIIhhXXm7Kr6NLU40Shp3ZPCFFEma71l7gg3fjmvjKS1jnaRTCkunnokjtw9MmPMPFzil3GfsXxo6uGAEhZXzaPwFrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7990
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 10:40:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2624

Hi Michael,

On 11/20/25 11:34 AM, Michael Opdenacker via lists.yoctoproject.org wrote:
> Oops, it seems b4 messed up the subject line.
> It should contain "[meta-rockchip][PATCH]"
> 

All my patches sent by b4 have the same pattern as yours. Glancing at 
b4's code, I believe this is how it's intended to work, c.f. 
get_rebuilt_subject() in src/b4/__init__.py

Cheers,
Quentin

