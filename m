Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B91C52D7C
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 11:51:32 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.37])
 by mx.groups.io with SMTP id smtpd.web11.14256.1724413889741903374
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Aug 2024 04:51:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=f4oLgmVJ;
 spf=pass (domain: cherry.de, ip: 52.101.66.37, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3TZWt3KVzPFFyhHf7GBuX2yJUaS+LOr/07tWSrWtF3o9O+ELpucNdY4loB3XiLIZaQ3dATDluF6etzixFFh9KX15TpWlH/MwJmfcRNopF7ZHhLeGMB8LP7psULt9yF7MP0Clpsrm775X9UP1Ek3aaJK0x33JHGPL4L/BTeR1lLtCmpKZyLK6Tp1LcYe97ILOYdVlRJONg+Yn4kA4ILemo3mQYPdmp+d5TZeKLO9wTCm+E3eAw9g2/v9juqdvOhTuK6iF0pJzWc8Q0mJoX4VMPqFX+T+1pDUZQIRPTR1E/EW1Vf/bXC7LsAFJennYA66VeC+2H7M2/oj6hodA03dLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOh1NliDu+jho951KxjL46dyAmoGg93sF40eXUoTAe0=;
 b=oMeHM8ZIAk7dLLm/K44Ax4zuFC258p6EUfnw+tfg8YuVO9o/5ol4CKvEjwNV++HMovGjlV73DYBO+DiWSZlvtPEGYEuV8CwsYIr4jCh2CWgFJXTZ1c5oaTc3Kzdh5CiieCDyzy2+qxrRLYMUOly4I/5HVctCFVTbDsMFgHIfuENEmh12CLJ1vtjZJiySPgLs8VGVUv/EMOv1p4/S83IEuj+JklzrnDKu+5kOD6Py3smj8Ws3K5gD8xdNk27acYuAmQiyXX6qzHGpaxV+B+jAoGPT+T6gniWjGx6wsfXlEeGXruF5X7p6uiEb9L7wVo2RojHF2v24Z0iEZ1cHnX2zLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOh1NliDu+jho951KxjL46dyAmoGg93sF40eXUoTAe0=;
 b=f4oLgmVJmKlzf4R+acDvwLNxryz5x0bUrwvqT6PSQ872mwjP7na6Y/OvLYtvAeIDUHvanTs7hgkGh1labeAxpWqktAbDyhHs+p6jZPoZB9rSpX582yUZNC6vMYkgKmrDdApfL9yR47RxGDKn6PvPOgQxzBdHNiWS+8QyYXeEmRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10944.eurprd04.prod.outlook.com (2603:10a6:150:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 11:51:24 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 11:51:24 +0000
Message-ID: <d161fa57-8896-4950-be61-6fbcee56474f@cherry.de>
Date: Fri, 23 Aug 2024 13:51:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] mesa: rename bbappend to
 match new recipe name from oe-core
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com, Martin Jansa <martin.jansa@gmail.com>
References: <20240823114407.787597-1-martin.jansa@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240823114407.787597-1-martin.jansa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::27) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10944:EE_
X-MS-Office365-Filtering-Correlation-Id: aeced5a0-e33c-41fe-8e9c-08dcc369ea12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZTdNOG9aOHNKSzZwR1hNU2hoY3NIZGxvQzlORW1WT2FlVWx0SWRFYWRLSlRE?=
 =?utf-8?B?T05XQUJZejRtazlYT1NnS1g5YjFhSWs5bEVCR2xwUEl4N2lJaVMva1hnV0U0?=
 =?utf-8?B?Z3FFSGtZODBmMFJDaWRSaE1pK3preEwzaFNWY2k0eFp4OXRVdENQV0x1MXBx?=
 =?utf-8?B?VUlZMVFrR2FZTkZpNFBRdExFQmY4cHJtbUMweGYxS0ZHajFrcnMvM0RncVV0?=
 =?utf-8?B?RzI2eWdxa1ZiZUorRjQ5Z1ArZ1JNRWRhRTVXcG1pY21oRUlDdnZnNFZ0MnFU?=
 =?utf-8?B?MXJzQnVNNG1IZGZqL20ySHd3VmtJblhyb1hIVzJxbnEvaWd0cDZ6NkN2TUZZ?=
 =?utf-8?B?MVNPRmxabXAycmlSekVhMDVIVDlRdzdmd1BWTXN6TTFoUk53UUk4OTV6SXor?=
 =?utf-8?B?eVY3SUpSTVNpMnc0V3NQZGhBbFZsNDRVOG84MCswNWsvc01CREJ4amFLNDFU?=
 =?utf-8?B?dXJzM0ZnTWxTQXpuamIzVHhKZ2xGbThwRGo2WTdTdDlmM0UzT0NjR2g4eGg3?=
 =?utf-8?B?S2ZRL1NFZlpvZUFoT0RtZDJucDkrVk5xSTFUaERKcENmQnMrTmd5blIwRkRs?=
 =?utf-8?B?VElTVU91ZFdWbGtTdnZwY2YwbThmUHFseE1SbDFVNlFVUGlxOUM2OXoxVlNJ?=
 =?utf-8?B?KytBOVAwaW1qMEFGaE9wRDRhdUZTNTVLaEtKd2lFZmxBaUVJbHRIQXdpejMr?=
 =?utf-8?B?eGxmdEhKeWtqT2VrNEVrdkZUZVNVWE5FWmpsZWxUZXZyeTVhUjVFaVZQMjlV?=
 =?utf-8?B?VmgxRDlqSnBjS25ZZlU4ZjB4MWRBbWRLTTBVaUEzQkxkRTI3ZmF4Yk1lbCtP?=
 =?utf-8?B?WDJoRmlpbFVsU0lCaG14Y3RlUE8zYnNnV0ZDTGpPcmhQUUJTWC9hOFNnMzRu?=
 =?utf-8?B?Tjk4NHVwM2xKSzFMOHllSGh1SnhuMTFxWFlqbGFhZzJiQ2g3dGdiSnBwVkJv?=
 =?utf-8?B?ZVVoT0ZUL2lIY0dOb3lXR3BoazJvczUzcVl6MUtibVJWVU9KQW0yRnQ5MEw3?=
 =?utf-8?B?eVhiV3ZiSDJLQUdWSkxrN3E5M3hzcnRERHNUTjlaNFRLSjJiVXVFVVYyazFE?=
 =?utf-8?B?Q1Rhai9GN29oUnJQUStQY2t4ZVV2RS9rRytSZktENm9iZkc2M0UvR05wbWs5?=
 =?utf-8?B?VnplMlByL01sVklhTVpKRDc2ZG92SXhvWlFpdGRCMFJZa1BSU2FXVlNqYlYy?=
 =?utf-8?B?Q0dUMFFJZFI4bHc4akdHRG1BWE5GTlJKYXJqVmcyR3NYVHVzR0pCdWlmRUoy?=
 =?utf-8?B?RkxKTEdVWTVqMHhjeUxOTFRSTGhIdzlndTdRc3pHMlhoUVhOOGNVc0t1anpF?=
 =?utf-8?B?V1I0dVcxVXZRdzBNVE1yclo1WVVyT1FBV0krLzZlYjZWVUp0UWFOU0hmM25m?=
 =?utf-8?B?WXVSU2ZPb1MvUm42TFJRZTY4V0k0WjU4YzJXUkJIN0dvUGMydy9rdTdacW1T?=
 =?utf-8?B?TlNqT0ovQlhKaFV4b2crcGk4S0xFcW5pakRNeVJINGNXMzRDTlhKZGx6NnEx?=
 =?utf-8?B?eHVsQUh1R2tJN3Z6UlhCM3B4LzdOSzQ3bzVITFl3RWZDVXpzbUZaK0lsT0VX?=
 =?utf-8?B?OElPQmQvZXg4OW9LcDBVbEp4ZEIxb0p2OE1QRHh4dGd2UnNJQUppNUExMXZy?=
 =?utf-8?B?cUYzaGszUzI5SDU5d1hWSTdQckx6U01GeWxjdEMxNklJcWtmK0g0OGlORmxv?=
 =?utf-8?B?ZGtqNFJQME84QnNxQnZSNkRpRDQ0c0FEdDROQjFOTHBDTmt0ZGFMbDQ3ZlRK?=
 =?utf-8?Q?dEjhrmOOtGcZMzqgpY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WjNRS1VqKzczTXRMUTMzWDV1ZC9DL3JKTnNyWkRLUzVEZDZlV0srM0pTcG5L?=
 =?utf-8?B?dWt6WVp6T2M0UzRIZU1oaW1MSklqZkxuZzNXTGRHL2sxSUJRMmEyNTgvRXRF?=
 =?utf-8?B?Mm1LR2NmVk9RaTh0YWM5cFh6ZEZjWG1uSTVmdnlVZ0Y4SWRkOGNDejRpQ2pp?=
 =?utf-8?B?M2JlMmRBY2VoUDZZcHlLQUlubUp6Ly9QOWdROWtZUjhOZEMxTW9KclpaRmNt?=
 =?utf-8?B?UktPeUVTU0k1aEVPV3dBbElIWERGMC9OMXBhbGhCaW41Y09YMGwrVWtMYkJ6?=
 =?utf-8?B?NWdzRVpkV3YxaW1ya3FDRG9hK08rM2pnYWx6Qm5USmppWFBNUlROb1FOTS92?=
 =?utf-8?B?N01UL2RjVXl4cEEza2NHYWV4WGRkcWFQbUhsSDE4akUyMVN2Q0tDQzVwMTBs?=
 =?utf-8?B?U2ZqcFhRekxoQlp4NnNxSXdzM0NTbmR3d0tQbU1QOFZaaURKRmpEV3pDTWk5?=
 =?utf-8?B?dmUzaUpTcGZKMlJTYjBvd2lWUFdNaDRoR3NhcGgwbHBPU3JmbWJpOW1QKzg5?=
 =?utf-8?B?MVkwMmFyUGtZK3BGN1UySStRSkdLNkhRczlucXNzbHQwUk1EdmsrK2pBYkpG?=
 =?utf-8?B?WGlERnBBUER1cEtWQ1A2aDc5V2d4elhyZE9oazhwQTFnTCtyN1hTYkxBUUYy?=
 =?utf-8?B?ZFZRWlJZc29mY3gyd1RFY0J1aTNrenc1eUNHV1NoVC8yR0ZBS2RKUmVTL05Q?=
 =?utf-8?B?QkxtY2kzVjFkSmlVNW9CUnM2K2x5MmRia1lWK2U4L3hYSXpCRkw0eFA4NWd5?=
 =?utf-8?B?WWZ5a0lSR01wQWRDdldGSnl1WVpwVFpJOXdGUG5OS0hHSEhqNldWOC9qMTAy?=
 =?utf-8?B?MXEzZTVEMEMzZDRCbUtrUzI5NUJpQ3NDTXdGMDFLNC9MY0NSTzdvNitCdC9l?=
 =?utf-8?B?WEhnNUtBZ3RHMXVIcGFMdm5sSUVweFJ5WmdDdFJnRGtGNWVDbmJWTEl4WnF2?=
 =?utf-8?B?STVnc1FSV1FBNDFKM05IdGl5OWNZZ0gzTFhsZjBIdWdERnkrK2JmbktDK0Rn?=
 =?utf-8?B?V2FhWTh6c0ttcjhTcXZrNkFmem90TVdGZUZlaU4zT2RMcVdmb3JSSC9aSDdy?=
 =?utf-8?B?a2RsK2Q4Mm1kdnNWWTg2SkdUZWVoV3NNTi8wOVphL2tYY2ZhSG5DNkpuNlQ0?=
 =?utf-8?B?OVpkVlR6TC8yNHhPRTBuVXErcWMrTXF2dFM1dTBYWHdyT1hjMVc4TWE4bjNm?=
 =?utf-8?B?WFc4bVdtWnpjWGp1b0Nvdk8yUFJidENwUSsyUWFkbUt4MDU4L0N3SFdoZ2Ex?=
 =?utf-8?B?S2p2RDI4eG9USTdwMUUwTFJKK2paMFhrWktwTVVZOFJ5c0JzdHZIZVk5QzVU?=
 =?utf-8?B?RlE4aWtUNTJjZk4zQUVzcVpMdTdnSUdWdi9qUFFqTXpUTjkweUlVRHZvY1pq?=
 =?utf-8?B?VHJPbDFmY3I4SW1IZXJIMFpmY0JxTXBtb05ESmZ1cDFEbDlSUXM4NThFS3lY?=
 =?utf-8?B?eitoaTFMVkRHQXRuTmxheVhDOWtKQ2xwNVVxVjdpYnJSLzdsUnBHZWxJSU80?=
 =?utf-8?B?MlhnTFJOQTNjWElIdDNGTTUwVjBCYWg3MlBKLzRrL20xUGs1Q0xPTFo2K3lD?=
 =?utf-8?B?ZnJIZ2RXYzhkWUVtRHJkdysvaDBGWDB4U08yUTNZd3owcVJIMk1uc0pvT0dR?=
 =?utf-8?B?anZlSDBpb3VUVlJiaUVqN1NxZ2tTdlkxMmZVNkZ2MEZOZWQvVm5oc3R3OXlh?=
 =?utf-8?B?UUlWcWkxU0dJcmRSZzJiZUFRNCtTQTBYTm13Y1ljb0x2Y1krQTdhZ0lEemNU?=
 =?utf-8?B?WDF3c3Z6UEJWQjFwYS9uL1BKMEFoTTFMTFo4R1RrT1kyaFhFT3l6UzVwUzJS?=
 =?utf-8?B?eW84TVpsSC9UNkhmbmE4ZnhlYWNJSUY5ejBvRHdZdlZZUHVpUDVZQnVrY24x?=
 =?utf-8?B?Rmt4M0UrQ0VXWGk1UThnNXloS3Jyc0swMEh5UzllOG9mYVRlaXRWbVdJWUlN?=
 =?utf-8?B?aHlRODNlUVRHcmszQUY0N2cwOG5KNjEvZzlTOE1sYXl3Y3B4ZTNIK3BSQm5J?=
 =?utf-8?B?ditIZ3Ruak5JN29BNmFIK0NvWTh3STY2Rll4VGtjOTA3ckk0dy9xakxFY0J6?=
 =?utf-8?B?VkFzSXhMTEFyY05UanhETE1HVzUxZm82ZkkrZEk3NVlsNHZyRWIzODl6c1Ru?=
 =?utf-8?B?ZXk4ek9CN1RabThPbTNWK0oyUDQ3b01QaW81OW9rYnpEQXQ2QVFXM093UFpx?=
 =?utf-8?Q?MvPEI3IfwDlJCPRPNekYjMo=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aeced5a0-e33c-41fe-8e9c-08dcc369ea12
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:51:24.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /O2DpWgiDLYM2XqLEBOq3nW4VEHNe0ktcu7iPchf+Pw0j4Puy8NiTZCsThddLbCsUmrC05Zg4utiiU31/iyLh6xiBtpIX8w0QSlw9SVStGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10944
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 11:51:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/552

Hi Martin,

On 8/23/24 1:44 PM, Martin Jansa via lists.yoctoproject.org wrote:
> Otherwise it will fail to parse.
> 
> Renamed in:
> https://git.openembedded.org/openembedded-core/commit/?id=f5cfb3e23603cefb2f3f6bfe776afaedefd10808

Please add your signed-off-by in the commit log.

Otherwise,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

