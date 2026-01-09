Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A7AD16805
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 10:44:57 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7621.1767955495110812176
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 09 Jan 2026 02:44:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=UI0swjz5;
 spf=pass (domain: cherry.de, ip: 52.101.69.12, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/Rl1JaMctfCmb3rExQt91oXzkWicc8gbwnUeG5NcKaKiFBz9vPDD0FltzkZBpGlK7q46SMu6yIkpzyFPWpzHOYU7sc/aATJOUjbxLjnZl86JOlol6J6n2SwXfhZGzmTeMkkc8/O8Jdj6f2Dd6H5gAuVdPe1BJFL6anpTDRCPhfIVJaGnfDZ7JBtFrMHDQ/9+E5sjc0kbgCpdwS1vkgVcnP50JalIwaubAL7Im6jGzXiJk5UIYmUz9BhSXTPbi0RC/NgzTrr0cnOQFaSAR+0yvspX9pu48c1CIjB5AHQ3wEbapgZEvo1In/hWx33LyV4Qh5R7jcZtvnBk7mmiO9Dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+Eq02n1YgFIbnV/yHyrf1q7dqVfMQU5Mg4ZtGUh2Rk=;
 b=CjxYLuS/xlYyeZVNPSfr2x07dLcKOOxb9kYYRVmMmIDp+F9A7hA0QXwjSJV2deYWVAKVVzHs8CQAhjCZubrb+kqwhLqqWfBanx2FC+TlpGWHxMtQnsQ+cf3OikoOv7wvZJOamUfwm9ea0ku4Bh9FA/YJWtHmbkpvkGWv1O3P92ZiapPnA92xYWu1nKh77q8ySKRp6mkJmkUZOPTyKhjn0afYpnt6YkEDhmoxG1l0Grira3CE5pe467v8VRN9lV+HbOp7v8F4q9opHSu5eYPP0nQSznRoC4VB94JDVteSTixFiy3yk2n+WzIgF31aceeKhrWpU3bDscJCmybmrgZMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+Eq02n1YgFIbnV/yHyrf1q7dqVfMQU5Mg4ZtGUh2Rk=;
 b=UI0swjz5AnMmLUBSCyRQ4iqaK+bDNtqGv5WOOjOAmiD5NGDFSUIqJMK4hLd1On44pBeMcYzY+Yt8tfxPjyPyLxY+083VS5tK+YGYcRYsMnGMErJQI/PTohwdlbUrRD4+DK3oarBymLi8NbZrowpnwShifLVnBsde/Iqdjvkde/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU0PR04MB9694.eurprd04.prod.outlook.com (2603:10a6:10:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 10:44:51 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 10:44:51 +0000
Message-ID: <587d00ac-457c-439a-84f2-0dedb46b4784@cherry.de>
Date: Fri, 9 Jan 2026 11:44:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 3/5] move
 KERNEL_FEATURES
To: yocto-patches@lists.yoctoproject.org
References: <20251221004843.31946-1-twoerner@gmail.com>
 <20251221004843.31946-3-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251221004843.31946-3-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU0PR04MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d02be7-854a-4882-7265-08de4f6c1e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WUNZeGEwRTB2N1U5MVR3TVdFZWgwd1c4QjI0TDhnbGxVYnhIODczdnZzNEZ2?=
 =?utf-8?B?enE2ZGtPSC8xdkRhNmpEem9uV0xTUkN6UnhBQkpMZklrZmthdEhqMkNSb0xj?=
 =?utf-8?B?bWdtMXB5UDhsMm1TengyZ1hZRmlab2N4MFVVSVRSUk9jY2dON2MyVk5sRHlD?=
 =?utf-8?B?bFZYaHBUTXdzRzhWMFJ3K2p3YkhCSDVTN3RxN2p3VC9RNTJjTlhXRmc4Q3pE?=
 =?utf-8?B?dVQvTTltcHdDVU5LUnFBTlgxd1BvV1R4Y2hNblRvaExOZnZiVndUQnhibzVj?=
 =?utf-8?B?RmJzNGVnM2FxRlUyUkV4R0E3aVlYeWtoTFpVanJhUFRYYWN2RElmamVidjNN?=
 =?utf-8?B?am9yMUxiVldsc1lwSENUazE1ekUzZXAvOHY1V3pGaUQvdGlzTXRWYml5M0NG?=
 =?utf-8?B?UFlRRWZ3bzUvd2w3YlRXb0w4eENzTmpaNElhVmVOOGF0QkVBUTlyNFJNYjFJ?=
 =?utf-8?B?L1MyZFBkTkNXb0JTOGZ2RjhITWt4MVZHclAySGZTdHpLRXhLUTVBOFZLMkJP?=
 =?utf-8?B?S0RwNGExRXJOQm1WR2ZhVmR6OVQ3SHlDYWwxY3ZSMWk3YjJiRG1IUzFESHlr?=
 =?utf-8?B?YzJmejhyRVpNY2lWb0ZqSS8xblcxdk0rdkY5WkMrUEFmMm5qL0dZM3J1eXNl?=
 =?utf-8?B?QVgxMVZSNSsrVWZPR1V4akQ3RVJXNmRoZ3pqTnV6VzVFaFgwNDA2TnJHNmRx?=
 =?utf-8?B?VjJITmx3YUhUc0ZYbHNQcEdjbFNQeks5TDhIYmU0c3pWcXB5ZXJhMFVVaC9k?=
 =?utf-8?B?SGFFQ1ZSY3lTMzBhTmowMHJFbnZOQXJlbzg5MVlqUVZzY21ESzdCZ0NjMWlY?=
 =?utf-8?B?UG1RN3VVbWx2Q3FYNmJkMld4dGJZdzAxRytaa3FYajJqZy8rWlBUVVZRNEUx?=
 =?utf-8?B?MlNndlJTVWxLU09TTTRBMTd4VlVONyswY2RmNVo2WXdWZG5WaVM1dWVubEl6?=
 =?utf-8?B?bHRvK0dLd09uWkpuSXBwc0RvcU1MNHNMdnlTUDFBQzBVMzdXUHhXOW94WU9s?=
 =?utf-8?B?VFpjQS9YVVFDcHRyTlM5Sk1sSm52cUVQYlFHdlRrZzg0blhpRWd1ZVRydlMz?=
 =?utf-8?B?dVgxREx5YzYrRDI4bVpQMTdoZDlVRnlQZS8rbnF5bkJzNnIrODJIV2s0Q1RD?=
 =?utf-8?B?dU9CUUdCdm42M1k2MHRXa3RkNWtUTlZkQjZzTkhsZ2NWU3g4RTJQYzZ1dTVu?=
 =?utf-8?B?dEFBL2pPUFN6dWJKWTJDZWcxWi9taVY5VE1kVW9qTVJPaFBUWHBzbWZWQ0NW?=
 =?utf-8?B?MStBdGMwOVlCME9aZWVoZlc3S3UyQUtUYUU2MG5yRXkwMWpqa2R5MjFRMldW?=
 =?utf-8?B?YnordksxMktkVFoyUGw3TDBLNmhoZGRGaHlpYkNaWkZWZGh1d3FKNTR1dW5U?=
 =?utf-8?B?aVVCcHpQQTFybHBTVVlrNitHcmJLNmdTYy9KMlRLSHRjMjN6SG9QRFQxSWds?=
 =?utf-8?B?V2RkWmUrSkdKZjV6anQyZVIzM1Y4Sjd3alJtdjBNTU1SeDJ1eE1OcTBZaHNy?=
 =?utf-8?B?VlNtZnprV2FPVVNJamxRN28xWjBydUcvbHZzTFp5d2MzVG9WZjFMMjhZbUlm?=
 =?utf-8?B?T0dhZjUyemtkYkxsZldoY2ppSEhYWnRSdEkzSGx6RXhDbDZhRE1Kdjd3dTI5?=
 =?utf-8?B?WW5pZ1dObytoYXVZNEMwVGJhQ3JKNzlya1pDN3plazJHSXdvRjhza3l1T2RS?=
 =?utf-8?B?bFhEZ2NJcnZlTFJ3TVcvKzBCYzFmMjFQSVg4cVphTFhhOWlXOWpUNElMV09J?=
 =?utf-8?B?QTZOVFczM20xMjVTQ240K1FrNU5WNm4rZmltSytFT1Z2cVVmbXVqaWg1OVZh?=
 =?utf-8?B?bWp3eFFXS05xQUJPcEZuSVFlS1h2eE1mclc4SUo2Q0NUV2d3Y2pwbjIxQ1Q2?=
 =?utf-8?B?K2s0KzNudHQ1blNxaGpOb1lUaXA4UlpGdVppZEFtR2d1bkJVZFBHbVRYTkVl?=
 =?utf-8?Q?U9mF9dIV7mrkCcdXWSKlIC5uLriAIXbi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YlhWUEFRU2VNMXJEaGZOQVpoZE5FSk5hYjB2T09CU3UxZ0VjcW1RY0xaMXdC?=
 =?utf-8?B?Q1g0bUtMT1FIV2RiUXV3MXJrVXUzdk9RV0JTVUc1dk1sdEJGYVF2THlhS2lN?=
 =?utf-8?B?a1VLYi9JbXA0YzE2aEpEdCtBbGVwY2syOHZhUmF6UElpQm1tNDIvWHVGcm8w?=
 =?utf-8?B?TTE3M1J6TEhOc1pBbnVkeU9UVjJ4VXNvaW41cVlJeUtSZ3NCSVQxcWtaeU5T?=
 =?utf-8?B?RW1BdkJ0NUtWUFphOGszYVJ0bS9sb1d4cTBnaWtsYmwxdVhLb0FsR25UZWV3?=
 =?utf-8?B?cmJxME5hRDNVWDhqS0NsR2FVby9Jd1RsUVBNYm5DQTFoRkFONi82bzdwVTNC?=
 =?utf-8?B?Z2NvdTRWRzYxN1F1UXpjTHpTOFZsbG5SbFRCWHNhYnBLa3k2TkU3UStDeTlK?=
 =?utf-8?B?N0JTckxSTWh1a0F2a3ptbmJGWjJUTDN4MGZXTWNvOWpTSFRUTnA5ZXhwWkJi?=
 =?utf-8?B?Sk02VTVwTmc3NDE0bEZVdnlvRTQ4ZUZTVVhjZjRxcjhCRERpeHM1SU9jTGVF?=
 =?utf-8?B?OVFndDZ1aWhEdXcwY3JlT2N0cmkyYWZPWWxoNG50VHl0SVBZdC9sVjNvTFNz?=
 =?utf-8?B?MUxieHpmRUFlUTg5VG43cXJ0Z0Q2SzFPWnJqR290MGhiK0Vyc3FvcDN2Sll5?=
 =?utf-8?B?c3Facm1PYjZPYmY4TU9CdndaSFhZMGhtb0ZBRXNIOEpSNG5NSGpKREZrYWVj?=
 =?utf-8?B?ZUdrNHVwRzVheHg2Uk1jQ2tVeTQzQmN4NzQ4V3dua1BEejhrS200QmZWRVVz?=
 =?utf-8?B?T2ZVSmR4bDhBMUhQNVg5S21nUjArUGl5TFlQV3JjUmd4UzBxRUdwWExka1dM?=
 =?utf-8?B?ZVpNaEZGRXU2cHBISjVTRVYzQiszYjRhejJUT3pGMW85SS9JalZBNW56aC90?=
 =?utf-8?B?NmRGZEkrNi9xTG4zM1g1Rm9CMW5ZWk80d0hUVzJDbXZzcU1Cc3M0NC9IVHFD?=
 =?utf-8?B?SlJaNFBGYm1kUWtyWXM2Y1JNWnBGWk9hSnRmVDJhbURPVkk5dEhBc2psMHFp?=
 =?utf-8?B?amJuNkN3b0RpODBvU3JLaWRTcW1GUkdmZU1jblpzeERDZTNUNnpwQ0FuWHNZ?=
 =?utf-8?B?eW9nMFMvNVBsSlpnNFRaMHpBODRkNUxrNXF2elo0aHdLaEx1TUlMKzdSVFZh?=
 =?utf-8?B?b3IzTjVURHRtMFhzYU1MbjlseFFTQkRialkvWjdOeXpjdEVDUXdITXhLNjhT?=
 =?utf-8?B?aUtYbEFValpJY2RtVmM0bVBERFpEVDlRV2ZRRGVvTHB3OFRpWHV1b0xkZW90?=
 =?utf-8?B?YXptZEsxTG1peUUrZTQ1NUIzcEQyS2lBNFArSVQ4VU5MdmlGSzN0YU9VMnF4?=
 =?utf-8?B?bVpwNWJnZ1l2RHlzZi9TMERtS2xlb3VYQ3JRUzRoWjB3ZXNhT2VLeGJSZTls?=
 =?utf-8?B?b2d2NzhIdkRWb1piSWxkbmRXMnhVdGFOVUd6c2NOd2ticHYrNDRUc21zeldI?=
 =?utf-8?B?VmI5elcyMHlYWUJzUkNBQ2RVeFZQcXRITUFoUmM0VFY3NERNTjRnS2FjZFhm?=
 =?utf-8?B?endkNlZpeWdEdE5XT3REVWpwQW9lRTM0d0thNktFV0k5Vk0vRnFzSi92RjBw?=
 =?utf-8?B?cFVkTnFHWHIyOFZGcWVBRnpKYjRHcUNyQ005RUMxaVhoNmlRNmw0b21aL2lp?=
 =?utf-8?B?TnZ2ZWhVdEFlaFdvd1VCVHpRcTN4WkxKTFRZTG5WTDc2Vmc2RldvcTlxQTBp?=
 =?utf-8?B?ZHV5dlpGSndmUzF3Q2l5SlZwV2UwTGJGd3REODRURnF4ZUJnT21zOHRHRVlL?=
 =?utf-8?B?YmI1TzZNNkN4TWNOTzB3TWs3RUxpZ2ltc2V1U21EQXp2Q0Y0Ry8rSCtMSGlB?=
 =?utf-8?B?ZkJRUTVvb3pnVnZkL25LcU1MdCtWWGJkNDFHYmw1bThBSEgwcEovdVZHMUlZ?=
 =?utf-8?B?bGg4NUZRemlPNldydzZ5M3JYUDVyS084WXphTkxYUnNuUkZJODNUNU9NeGxL?=
 =?utf-8?B?aGFpT2wvR1FRUGVSaldQQ0g3VDdlQUk0OCtQYU5xUDhveWVPMS9aVWdPbXJC?=
 =?utf-8?B?T1dDajZuTk1oUGh4cjRzVlhzS2tUZERHZHQ3L0RLOCsrNDNPR1JqY0NsT1Yy?=
 =?utf-8?B?Rytua0pVNVhPcFZ4djNhQmswaWdiYkMvNDBJRjNuRUpOcmo2Y01wNWtLUkYy?=
 =?utf-8?B?Q2krMVlOTHEzSVcvUUg5dlV2V2dYR3cyNkduMFBQaWh3Z3BZZmoyYWgxNnpM?=
 =?utf-8?B?ZWtBTjhnQUtnMW5QT09KZkcydjlSWEtWNXc1N1VnOE9Qcm5BZFhkMXU4ekNt?=
 =?utf-8?B?T2hqaGRCczRBdWdNbUxhWEk5Y01ScEo0SkVqRFVvb2Q3cDQ5U0lOeHZIUnk2?=
 =?utf-8?B?ZVV1eVJPbFRGdEhxUkRIYWY5Mk53ZHgrcGI1WGZBUUlGdDBBZERZZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d02be7-854a-4882-7265-08de4f6c1e2a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 10:44:51.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzHPTDb91Q7x30wUMGOr8fz1Jkpnia6qkjk61fLL3XHzGYk2jdXoCWbQemQwuebQB0jfoDuVq/G0Vh4pxKjS1jwX5vBpCQrpltvzI6kCiOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9694
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 10:44:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2921

Hi Trevor,

On 12/21/25 1:48 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> Move KERNEL_FEATURES from SoC configurations to linux kernel recipes.
> 

Thanks <3

Cheers,
Quentin

