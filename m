Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCC8CA1015
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 09:11:45 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.25])
 by mx.groups.io with SMTP id smtpd.web10.16892.1757063500828263637
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Sep 2025 02:11:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=LdM03WXM;
 spf=pass (domain: cherry.de, ip: 52.101.66.25, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvs9Gd0v0buoxcFeLULL4j9YvcLJRaso+pGz8puwW55aJ3x+xJj9KS57yp7bSxh9KdVNAtV0Ep0N3v9hornEY/ScRBkKaQPNXyEJkU9q6uRQJ9SC/a7iUj36pURy6ZcMw1jQXbAePZ4OXti8stkwEaqQYs/uFcOv1IqQddX13GivFsnW6YJ/cHDh2O8fPs7GRC6KP4SGPZQUNUMBkKmh8KY88eKPt6GS5oOXW37rIMsOB9fMp7396HwkzBHDMF3NG3Df+5/1RhA0lpuKlhZTW7se2XuIC504uPFcmZVcNFuAflC/8sSbj5uPMzdxh8HuNeVMq2y41+2f7DjeoPFDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTLard19+YypQ7h8bI7VPukuPOdw0B0WSyEzE0OsKVQ=;
 b=R57hYj2J4Up1BN1L8hMUaNE92659AmcAccJP6z7WJUxN3ZgNngish5uqGwCIN6vat8DsvUEbL2FLHE/uf0M+wr9lqkBgHtFeTcp6E4xfQSOIw880fmBZvoLqde4ZFQNU9zHDUMVwM8vtMPfKQnBAnbQgyoPdhOkFwlFP3SuxvVNut+vTdTGlu9Eh27bkCK88VGo08ZTf4xPFj8FOLdhXjy0AOvlO8cUbTkpfd/floLgPSBB+cTtmpOzOWJw1V/pCIprUG7pgmNGWNM1UA4gKwI8hzHvf3FoH8PAx/swrtOgKfFfMhOdHsq49RPd8SKuIgiQDWDfwoZVxcE7zz6k/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTLard19+YypQ7h8bI7VPukuPOdw0B0WSyEzE0OsKVQ=;
 b=LdM03WXME/jVyfCISRetGJBGF+ydKLo/AvDkm/h0Pv99qtrpOULg25Fhuuk2VqKoxG45zH/VJUTpjnt0ZrlYjqPibFGHLX9rJK1cVc7H5EPsz/ltWSoav8ymIy+N7rG58mhLSSkIjtw5Yz205dcATWhojnH7602NzHiF1dmqmBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 09:11:37 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%5]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 09:11:37 +0000
Message-ID: <6c0d40d7-747a-45fe-9a6e-b4ab04363c89@cherry.de>
Date: Fri, 5 Sep 2025 11:11:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 1/2] nanopi-r4s: remove 2nd
 eth work-around
To: yocto-patches@lists.yoctoproject.org
References: <20250904194529.22656-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250904194529.22656-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: eaab5d9b-e33d-425c-76dc-08ddec5c375f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QTQvWTBxLzVwUzRXYUdSZy9NUDg1QldKR2hMT2NwWS9xVmFZZjVFdElYZ0ZZ?=
 =?utf-8?B?TzhQL25wSTNvdEp1SmkwS1ZvNmtDeFphVzdvcFVMYmhqSGZ4eXl3L2pDZS8x?=
 =?utf-8?B?THc3T2dGTmNHdU80NG5SYmJTSHlwL3lLSEtKMkFpUW95cTQ3ZmNPNTBnN09y?=
 =?utf-8?B?ZXMyOHlsSlhaVjE1cktSeWQzUkFuaGhHdFJRUXMxZmNhVzlYZHhSeDZJK2FR?=
 =?utf-8?B?bmdvdnI2Z09DZW55REwvUWlDeklheC92eWFBUFpZYlhMcjgzd2NHNVNFR3VT?=
 =?utf-8?B?eVgvZGtzcjk3S0xUM2VzQ1Z5NmJDLy9HWTl2NEpiaUFRanE3WVVWa05tVjlM?=
 =?utf-8?B?bmFFS0pWaVFQY0t5NXAra0JnWml2ZWx0aWFQcXZZSS9yd1lURkZKUzA1ZE5t?=
 =?utf-8?B?dWpZWmduZGdMZ05zZS9Tc283RmV4VlZpbXhBU0dvQ1Fwa25aTTVnUXNDMDVr?=
 =?utf-8?B?QytKUXZIMjdKdHh5clRSQXM1cU5PQ1Z4VVFndGtQMGF5TENIbWh2TFhmcHhu?=
 =?utf-8?B?Y3RZSENTQmw3ZWhRQVhLN1ZXVER2eGFEN2E0bkxxc1RPSWFvRlRCY0xlZEhR?=
 =?utf-8?B?M3BvT1dGL25lamxyUm9QYVl2aHhhK05HRzZodWQwU01WZVpRcStDLzJhZitO?=
 =?utf-8?B?WkowZUtnUEJRU2tCclNNWHJtejBmaktFUDRSOVI0aFVINmNuTk9EdGRzTUVa?=
 =?utf-8?B?dGtJc1I1Yis0bkc1YlN3eWRLL3VkZnNEMDRtbjFrdzI1UE9HNUF3YkRjRHpS?=
 =?utf-8?B?S0xjODdwUGE5K2ltcnBNaEkwMjY2eEZOR1FjQ0EyNHdRVzVnN3g3OGRtanJC?=
 =?utf-8?B?U3VoZ0pSN1VyOW8zVG8vcXg1UGVldUpzNE5Eanh0ZExza2VtMFA0ODVPRTU3?=
 =?utf-8?B?N1RWYkZTNHoxR2pucnBRVk53cW05Y1dlVTcrcGVLd2dRa0k5Y3dsUDRzaEJo?=
 =?utf-8?B?M21nclY5dU11dEYwWG94dUVkRllOYXcrZzZiZGUrenBja3NRa1NtYWQ5NldZ?=
 =?utf-8?B?bWpKWnkrRWtVdHV5U2lHMk5nTDZ0UWtqMndIbWNaVmhWQU1kUG1xV2lmdHB2?=
 =?utf-8?B?UWRmekNjWHlyOFdUaVFjRUZkVzBWQVhUaVNFeGtid1V1SnJYSGo2TnFlOGF0?=
 =?utf-8?B?NE9YellKaFRMTDlqbjBvdlF3WHVDNjZLVUlRS1hkcjkyeVRQNFpEMWV1Wng1?=
 =?utf-8?B?NFk1UGNNQSsrRlRXRFV2aGYzM25ZeEE3M0ZFZ3ZuZE14VEdQRzZRRHI4ejd5?=
 =?utf-8?B?RjdIVzgvTmdnRXdEcUJOWFVYY0xZemdBcmsrdUVUY3NzaEYzR09hVmxURWcy?=
 =?utf-8?B?a2VseGVaQzVsTSt2OFVpTG5NZnREcnU4ZUgwRUlrcVQ3bXliMXRYbnhoQTVP?=
 =?utf-8?B?TncrY29OOVJvY2RjN3lGdS9ycllTclpObDI5Si83bFR2aGo2VmF0aW1BRi8y?=
 =?utf-8?B?bDMxdk9NZFZDUGRYUU95Y1pBQlJqUFZzOFE4SjFrWUF4V1BnRHJzcEdQMTgz?=
 =?utf-8?B?aVZjZFQySEd1VTNzTUtWaXhxY1NSZEY3aU1obHZrZ3VnbXdtR0d0Z2NJUU9p?=
 =?utf-8?B?UjNSWC9CbHViWDU5ZEFjdEdnOWVOZ3lkTUV4UVEvbE9iOE1WWHgxM040R3Rl?=
 =?utf-8?B?dTF0VVk3UnZDNllDcHJyQytLVVAzeVVLR3VYMTI5T3BHYmh5UVNnUFBMdEdH?=
 =?utf-8?B?dHZxcDNVTU5IbERTMlg3dnQ4dGJhblFqNXExYkl0eWZMNy9rb016YU1JRW1Y?=
 =?utf-8?B?WU54VFR5cW5aeDUvU1ZBaUJnakFQVjEzY0o0dnNwMEF6VWJWYlh4QUtEZEFi?=
 =?utf-8?B?a2gzRXYvMHNOSk1LVXpLM0x1cjV6SmtOem5jSWRlU3BZeGllNkp4dTZJOUk2?=
 =?utf-8?B?eDdGdjF2bVQvM3JBYmUvc1hwTHliNlRCUDJZb0lKQkhjZnc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFlxK3U5VlF2OHZmVWI1OUU0ZnFJU3N0bzVOcWJOdytwZVh0NjQzNmkvNndG?=
 =?utf-8?B?Ylhrd2ViUWRGU05DTDJZdXJ4ODlUdm1RNlhpcExSVzA0REZoZ1QxdUQzYkZG?=
 =?utf-8?B?SUNlbkhFQXVIZVpzYU5BQ2dJRHduTmNPMUw5SndjL1VkOFpUdFpGVlppdkxU?=
 =?utf-8?B?Qy9uQWlBdGdqNlZuZGhTZFNWMFgwL0JRVFFEWnFvTzZnQ2o3V1JaNGRYdlZm?=
 =?utf-8?B?MnB0TXo0diszdHFwMVVJMTNtcTdVOU96dWdPN2RzT3FHTGswb3NSMkY1a1lv?=
 =?utf-8?B?T2hBS3hOOVhVLzZxajRkSVJ0Sjhtbng4eGY1OUxvcDhmcFA2WTFxTjRjckxl?=
 =?utf-8?B?dnYybFVXQzNkYUhQemJZRlRQS2s5N3krRzFKbWdBTVlPRFVtVks3TVdDWTNN?=
 =?utf-8?B?VTAwVkdhM2o2eXRlWFZvYlV1dFdVTTRmMEh0YWh0azJrblgxZXlERTY3V0I1?=
 =?utf-8?B?eUE0UHJ6QlM5VXF6VnYydS9uaStlSmU4RWh4bWdPS2dwTUxLRnJnVUMxVDJT?=
 =?utf-8?B?VDlVK1dIbGo2WFoyVFlJQU11andtbTh5WWRianBnR2lxOE9OVkVEeXFsOElY?=
 =?utf-8?B?dXdHdmVXK2VaSHFYS25QNXM2SHd3MEpQU1FyMFVPWVhpY3lmcWhrMndGejN2?=
 =?utf-8?B?cTRaakxMSlEyYnVZUXhBZE44TnhaM1FXTkM3V1RsbDRONFdrZE44WnhkR3lO?=
 =?utf-8?B?a3lVTy83QVdNVTN4eGRucHBYL0xmS09qZytjeEgyWUlCUDNvUEZwdjhHMXFl?=
 =?utf-8?B?NDByazIzU216ZXZ1b3dDWkNYVWtibENIdklkWXFaZ0lQYlp6MEx4ejltcnAy?=
 =?utf-8?B?VnVrMkhHVnNKQ0s1dFFMK3E1QmJoS0dmYlFJTFpiS05UZW5KeFdKbHJ5UmI3?=
 =?utf-8?B?ZWpoeHV2eGRIOS9qc1hzQ012VGs1SUlIbUdnd3c3bHJTSldQcjF2QmgzRWk0?=
 =?utf-8?B?ZjJmekVnSEdlMWZJZWlCQWtINlBscERWZ0pTUng2Y1ZEbHRCdFdBdjFUWXJN?=
 =?utf-8?B?WVhpYjEwazF6Umg2RU5WSlBxcjlxUURvc3dBY01DNjNPZmwxSDNoZEw2Wnk0?=
 =?utf-8?B?SGFnbi9KdlhoNFBkSFNZYW1zRXpYOFJPczFndWF0ZHQ3dmxyTFVkUExxNGZF?=
 =?utf-8?B?TzlNNW9pQkx0ODk2TmFueEdpUElTd1hJa1lFdjNzRXNZbkJpOStCbGVpRjM1?=
 =?utf-8?B?akc3dTlWc2RoOTdDSGRQdFlnWVdXMFBtZCszaWpjOWo3UHdCZWkya3VhejlN?=
 =?utf-8?B?T09kQ2s3WTlSS3J5WmtXS0dWYVlMdzhwcG95bXRRS1dtcm1vRkgvOGdyWHlq?=
 =?utf-8?B?TE9kemtjbml4NTlRTG1QYTQvTEFiK0kwWTkxSDlvK2ZFUUpxM1lkVGdWa3Nz?=
 =?utf-8?B?blZ5eWsydFNmTWtuaGJEdmRYckdsUXU4OFBkVXlrdHhlVWRDTXBVQzJTSW9n?=
 =?utf-8?B?RHZYMXhBZjhwZjdUT2FyYTZvdmU0TCtnNy9lcFJaQ0hwTjV0SFZjNnhJUVJJ?=
 =?utf-8?B?QzN1QlBxV1lLZTZBZHpXOHRXdk1jMWw4Y0E2YU5nVXA1RGgxRkVhZ1dVYWZr?=
 =?utf-8?B?U0laTWJ3RllPUW01cEpCRGpxSGNCaEgzSXhrSkc5Y2JncHphQ1BYVTJZSmJp?=
 =?utf-8?B?eit0b2I3a3pSNlJ0SWlpWS9RaGNHRFA2dzM1VW1WbFUxRnlJYVB1OXcwVnRk?=
 =?utf-8?B?aW15U1l1ZU5YWUpHbkttQnNzWVFYSE14OElHVThBWEsyWlRPTFhOeHR6Wm1X?=
 =?utf-8?B?Zm5iclVIcXFQSDArTy9pbmg1TVFKSHh5dHlWMEJUNG05SjJ2eDNSSFdkRUJP?=
 =?utf-8?B?V2pNSnVFYnd3UitBQ0w1d2lHZGRoTDRxRk03Y1RjL3AzTWZYN0xuUUMxSzhX?=
 =?utf-8?B?TzBHMGhhQ2RPcTNMeWR4TFIyUWJSM1ptRVdxc1lxRFlaV1FPZnJINWdsVEV3?=
 =?utf-8?B?SS9scFV5ME9YUytVZE8vV0VWRytaaWRQSGcvanh6VlRSYXdWUVNhR20yQnhy?=
 =?utf-8?B?c3BuZjBlOVZrWDdoQkR2UFJqd2wwcXJ5Y1J6REJnRjZZem9DUXBBVVVQUE82?=
 =?utf-8?B?eWduU0xza29Nb2hJT2xjai9nTnVydmZYb2FKdGNmN3ljMWdkejI0TWpHTitt?=
 =?utf-8?B?c091RVVQVXQ0VmtqY0dtUiswUEQ3dFlzQklqb0RmNlhqK2EyK3VBajRCUXNS?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eaab5d9b-e33d-425c-76dc-08ddec5c375f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 09:11:37.0393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khbl1Sf5hcknotBL/JMBBx/RQ8ZxRBs76OerdfZXCX1CieZXg4Naos5FgK0S3wPDP+tRwfvGmVGaTT68od0bpdrreUZFxMF5Ccm8Ndq8F6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Sep 2025 09:11:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2139

Hi Trevor,

On 9/4/25 9:45 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Pre-6.16.y linux kernels needed a kludge in order for the second ethernet the
> work out of the box. With the update to the 6.16.y kernel the kludge no longer
> applies. Fixing up the kludge so that it does apply does not seem to bring up
> the second interface. However with the kludge removed altogether, the second
> interface comes up without issue.
> 
>      # lspci
>      00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port
>      01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

