Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15096.1795782736107419694
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Nov 2026 04:32:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Wp8IY8Zx;
 spf=pass (domain: cherry.de, ip: 52.101.69.15, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP8rr1vOrLHaO9jHmsU/X7pVP7TEvxj62/MMIzdL6QqeJK3rHgP3dyDP3INQPVHvpCuhuKyzeeGyonzRtD86BwsuGwsuSuCOYMcREzPblmLC4x2FgBOSUwXKeiEwsc7/alhQJPgj7I9DpZsC493fb371+1AmNxmQ8zW1UYjD9K2wLpiP/PWM/jrkxOoWFsz4wc3Jb2xdpsSZXZT6c9LGdZuP5O8F7pM6mUP/ZK+uUGI1abIWxycHlSddjoMZMT3zKo0/9rmvAQSzMSTH5cGENRxLefzM8sNyaxgG9dIDN+Vd8kTPw0nzBxEs13n0vSfA9ccQNMnGp4UTUnaStLi7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSlxNI761i9yIw0b8P+FNs1ne/527xix/PiddN1eELs=;
 b=ma0cwknCN9B5v22VLEdDla5XGwY251tQpIyKiMUc1lp+K6GaXDt6nLybl/tKob335MzcYmsLqO5fELaWcJT9KVpv4vV5EwZzmKm+LHB7zqJ8B/88b9c1xtr+EQb4OkNn4Wby0ubvbQKJJZ4hp5d5g7kZ6R03Te32im24TCyrsaQVo9sNxWbBMKIAQayiH2P6TbPj7BKVFTJ1YqwDWx8CkEHa3ZE2nWdSIH90yYj5k9WIrIBMdB9gMGcvBzoOpUuLheltc0+nAdYWZ/niWLNaLTMWJ9D5FoeTaTt8wTqG3wpeb71Q/B1ylGnVLe2L07Wfdc8FyfDQ6iU90Pm/tovDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSlxNI761i9yIw0b8P+FNs1ne/527xix/PiddN1eELs=;
 b=Wp8IY8ZxnPSHFwxKobJjVFLYRm0ifyjmYfgHFhAXpe0ZRWVI5EY5ipLOJj+ZOn23zVfH0qqu62DvFyYpaOeTKrmLfB7+Qhba6Qkj3tsiGRRbeyxPaKs6e6asZ7y+PVbCav04u6o+Iq5jJSojAABIJyvzA3m1x2U6XDdb1ldyHto=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MMZPR04MB144766.eurprd04.prod.outlook.com (2603:10a6:190:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 12:32:07 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 12:32:06 +0000
Message-ID: <78a2c5c2-a4d2-4563-a7c3-44b2606590f4@cherry.de>
Date: Fri, 27 Nov 2026 13:32:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 1/2] kernel: only add the
 rocket NPU fragment on rk3588s
To: yocto-patches@lists.yoctoproject.org
References: <20261127114049.3566943-1-twoerner@gmail.com>
 <6b21fbb2-cc3f-4553-a6f2-cfb202bdb89e@cherry.de>
 <awlziqHj7tx47PjX@localhost.localdomain>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <awlziqHj7tx47PjX@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0272.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::39) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MMZPR04MB144766:EE_
X-MS-Office365-Filtering-Correlation-Id: 8636c135-b659-4c06-0b66-08df4c8272f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|4143699003|18002099003|22082099003|11063799006|10067099003|56012099006|261026121527099003;
X-Microsoft-Antispam-Message-Info: +TY7bb3PJGKSKz1FeOBd0qotZNopNKhoTO/sZxKFvx76ZpRAM+8tYy8df32xmgzNWwaWZpyaJHCL3Qv847mGhpV8AJx0rOZSNRDfhvU9e4yYJJjgJH9U4eYegj/BC3VdkT0FIJlfFzZOS0nW1PZtAwRjBZVq7c0jSvLw1OkZz9Oc3DFd+VhufHNplUs3tfpqymxDBfmuJGm9+e0xzuFWmvGV3K3H05N5qKWVcq9oFxVCy/+ZMV7AjNUMO7NhGOrFoLBS/5xz5pLpzZdNdeyjnGD+NpR4k1B2+ipE9ymr3iwZKYP4RAgjPoZI2AtfkhmHa6wpOy2u0JuTlmdau3CAlKx4Gw3goL4kh2/3JpzHa3Gc5hXN8FvyG9gNy9JEXkxH/nZTJ3kwMVSxX11oKI/pXohTWkeMD0uK0Q9pXb0lhpIKXWs8PY4DQTALWPrL3I+me7FZCPkJTTLmb/9YsSAWxq3jXjQvbtO8zsQ7RaojMfCg21LZS7f4vxfj9epnSsK/qglz3txOnBe0FJv81rREOtUbMzPNGYEFv9O/vZ/vHv+yvt44YHarAmZiQLZe43GjF1Fff0d9uLJavgFKlbA3YX6IFMpSaIbH9zJ+mcvw8YzAea/Tcb4IfdK7ymk5tJKFCKehRBx3yZQAPw6XuXim60+gEta0KmokOAu9+LwrrZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlJoYjl1eCtwWkNaZWJHOEpvN0VuaHNyaTRqY05aZHVlUzFDcks5eis1QSt5?=
 =?utf-8?B?K3RXMEU1K1NGQjZpV2tSRC9WVWdxb1k3bkxlQmZFLytnSUo4NHVrNks5MWk2?=
 =?utf-8?B?WWpnUHNwbTd5K2FyVkhMQTlZYW1rOXRncFJJZFhlR2FnQzU2NkdZTVhESk8z?=
 =?utf-8?B?QUZ3UnhGdk9od001Z1IrRkpsM2ZUYUhPNXZzNmVxNUZKL3FLQmlVbzUrdC9Y?=
 =?utf-8?B?QTB4U0d6YStoeWY0K245UlljVnFoZmVIa2NsVDlWa3JWYStUUlU1SEVYWHE0?=
 =?utf-8?B?TlV1SkhMdTVwSS9aUWg0eG9yS25UOGh5bTBFbjMxSzQ4SWFCSit2REZjUWk4?=
 =?utf-8?B?bUdYOHVUend3ZGw2Tk9YU29TckZHQ0FTck1kZ0R3bkZtNTZyeVptbjB0dEIx?=
 =?utf-8?B?b0RUbUM5SHFVTGJUUWdHNUUwaXlxVFRVRXo1Qlg1Sy9UNGpkS2ROcW10bHha?=
 =?utf-8?B?Sm9YbFY0ZXNQSzdHdTRXRGhvT3d6M2xVM1ZaTjA5bVErMmZKUTE1MGR3ZVh0?=
 =?utf-8?B?VUxLUVA4bFIzUEIzd1ovOUFHemk1RjFhUzVCY3NEUTAwVXg2NFpEenlvZTFP?=
 =?utf-8?B?MEJPZ3BHbGxob24xMUR4RFZZNGFLMmhmRWMyNUN0YUVMa2x5V2ZkamtUOEth?=
 =?utf-8?B?bEhuODF6ejdydTI4N2lVSERXKzVCbnhxa21BRzgrcXZ5Q25uak1TbjducWxo?=
 =?utf-8?B?MWlObXZRdkpVZUNYSUdydk9uS2hhQTg1QzlLNXQyTElMd0IwUDdMSFpXeHRB?=
 =?utf-8?B?UlczQ1BHZ05BcTN4MXJZd1MwWVZTYUY5WUEwNHBkT2JEdDErS1JYOStDQ1Zk?=
 =?utf-8?B?WWxjNmVuV3N1VmkzbHlkNjcrMEhzTzh5RzUyRkRDSTMzVHlkeFZvdkRtTmRi?=
 =?utf-8?B?QjkwWXFMbUs0RGc5d0loWlFNY05ValJKUlg4d3IrUkVaQ2Nra3N3NVVMQTdL?=
 =?utf-8?B?Q1NtcitmYU9DVDVxOHlWZUFTMEVkODlXTkVHbzlKZ3EzOVNRRGg1TkhJa1RX?=
 =?utf-8?B?UjI5dkdGWUVDNEJNc2F4OVkzMkFMM0xqWklGSEFaRWZaeWp0WmFNYWxROHMv?=
 =?utf-8?B?VlYzVnJYV0lrR2FaRWtpK1R6V2t5bVozVkZOY1pER3NicytZcUZMWlZyZXJR?=
 =?utf-8?B?cmczcEdNVVd0MWFnMjBROWd4WnFtTUZkbXdhN0lQa3hjT3ZZbTFEblJkUEgv?=
 =?utf-8?B?WE01dXFwQzEvSWFkcGZWeFhBTzhwcEJWT2FtcThQekZOaXlSK1VVSS85TDdr?=
 =?utf-8?B?ZnBUOUdNWlZNUDJaRmpOdEpFK0NsSFBLU3krL2lUaDRjRGtkZVlDZzAvbE8w?=
 =?utf-8?B?cTkxMVZZRjY1dytJMzFNK2tPS2NKY3VSUFNRMWFxNWhQVlNiaE45VVY0cmla?=
 =?utf-8?B?TGQ0ME9FbGV5dCtlR2U4UXoyYzJLQzlPeXRnN0NuSFZwbDJKdTUyem9EYWlZ?=
 =?utf-8?B?eGNBdnJFa2tHdmUrUzZGYVV2YVMwWEl2OG9CcGRKUVVFOXFEc0Vab01aYStn?=
 =?utf-8?B?QSt5S3UxeVBxY2VIVWpvdkhUdG5RSFRxNklidXg1MWVURXhnMDYzZ2pod1lr?=
 =?utf-8?B?RGxHWUU3SWJpMlFDdFAxa2ViM1hnbFBreHQ4RFJQTEpwMGZxck1HUnVNSXhL?=
 =?utf-8?B?cFl2VStOcTZtSmdHVEMwV3l0TmJKM0FJN0FtVjFyWkNsa2RFN1FLTHRPTEho?=
 =?utf-8?B?OUh0cE5mUUhlVWpSa1ZIL1ljeHBrWERqdTcyeXROeU52djJYa3pWQktIajdO?=
 =?utf-8?B?RElMMHkzVUJYUnVzTFBBNTg4VlROc0V1bXRubytBaEk4dTFSU20wY2Nrd2dW?=
 =?utf-8?B?V244UUlMSUx3YXo5ZlptaHBzcU9tL296bUZEcjBUejR4U0FaNjJNbmZ4ZWU0?=
 =?utf-8?B?NGhUcnN5WVM2UVl3SE9RMGFxbnhxb0UwRnd6ejJab29kOFF1eERJSGFlMlFG?=
 =?utf-8?B?REk0K3EwbUFwaVVFYzlGdVBKZ3AyamJuUndUdWJ6VFAwNHVkaEVSQzhYZ0RG?=
 =?utf-8?B?Mk5GNkdqZUwrOGR1eTZDeis2MVE2WWpCOVZjNlRyTlhSMWxobExmVFpqVkE1?=
 =?utf-8?B?TmVVODg4bXMxVVo1RnNhUG40bGZFVTA1QURXSnpORzI0T1JXNGhnQjUwSkNY?=
 =?utf-8?B?cjJUeW9qVDFUd1g3NFV2OVhNMkdRNTBxS1E0ejQ2cXl4RFBOTXNUbnVhQVNh?=
 =?utf-8?B?Sm1VcmI3eWFJT2FMdUF2WUtURW54eTcvRVR4VXBtK2swQzFLTm0xd3YzS1hE?=
 =?utf-8?B?QkRBOFUybnNrRHRDMFVBcEU4b1dva1ByNktWMTNlSDg2Q3BZNC9UTjR2bWtp?=
 =?utf-8?B?eklQK0hDVEE4b0xyZCtYejEzcDcxa3RtbmlJTElYZXRqVVNjc0JmQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8636c135-b659-4c06-0b66-08df4c8272f5
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 12:32:06.9543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9XdrvmgMd15IXeht28le88faExYihSWCAXpnfSuHYLDtn5RZN2Bc3h8Ray6CJgvleBMrnhleo2g4Q+v52tYvltlmbBLyWU4hipXCHOPFR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB144766
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 12:32:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5552



On 11/27/26 1:11 PM, Trevor Woerner via yocto-patches wrote:
> On Fri 2026-11-27 @ 12:52:49 PM, Quentin Schulz wrote:
>> Hi Trevor,
>>
>> On 11/27/26 12:40 PM, Trevor Woerner wrote:
>>> The fragment was appended for every rockchip machine, so setting
>>
>> No? It's clearly only added when you set ENABLE_UPSTREAM_RKNPU boolean.
>> Don't set it for SoCs that don't support it?
> 
> I just performed a build test where I set
> 
> 	ENABLE_UPSTREAM_RKNPU = "1"
> 
> in conf/local.conf then build for every MACHINE in meta-rockchip. All of

Why would you do that? We clearly specify that ENABLE_UPSTREAM_RKNPU is 
only supported by RK3588, so its place is in a machine conf for an 
RK3588-based machine? Anything else is unsupported.

If you really want to use local.conf for that (why?), then use 
ENABLE_UPSTREAM_RKNPU:rk3588s = "1"?

Cheers,
Quentin
