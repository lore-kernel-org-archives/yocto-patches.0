Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D5CAC5B0
	for <webhook@archiver.kernel.org>; Sat, 27 Sep 2025 06:08:16 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.6716.1758953284444705387
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Sep 2025 23:08:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=nQHqnjcs;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1365fe416d=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58R675Yt4132606;
	Sat, 27 Sep 2025 06:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=w18yCmpsiVln2TpnKLgRxpt3g9OXMprKvLZq4BktCuU=; b=
	nQHqnjcsVEgQ72c9tk+teoEYcvlUaPWqIxu5a64NiVcautbm+W3KbmdItrOKaHzL
	n8lSJc6K41c/rCS8QqAhOAwgwthmIs/0hGIBjcnykerxcKuA3dCD6VlyO99nOhLA
	Z5HxA6trBJO2u8qZRa2T0/G0jsj8noetU9qPmV+OALqDJj8f0nYR4gfAWioLp5rU
	8nXkIxhQzzNY03JUSVGxro5TbSjsEtjmiRTmhnR+i6XVEHTPljGjtL+eEF0eeEPm
	n+eJAU9XtzueSbPFg9d2MNYVGLx8LTbeETPKPfGuGgrcj8cuC3kOwwN0RQt9/hHr
	+Wqkk5XrA+SEfdLoQhe+vA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49e54wr5tk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 27 Sep 2025 06:08:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifH1ccCrlsfL0OekP+aSmhhrj8zlmHyFGXt//23HY0QNJcqcJN6aZK8qJ2FjMlJLSmUeszfGtplzFnirTi0YA5Sfdit+3BCafZ4CtTFFcvnZ2JCZ6c55A/hlnbp3zFZKVVKQlwBKd65MnHoVLHnBm/y44da9kD3MwR3Q6ERNcTkN2BtKfH8aQWUCF7f4Z5ReWKeiaN6mFgdPthZMsOvvnequnL33eKT/oH0WkEOBocnE8OmU1lrliCFdE7Gd6CYx5wK+krMJ0jXNOgAkvZw/CPYQKLyneRlURAM0VAWdD6nehBY+x9JemSDNBCl6yvuXeSflWNNzuiRXrxv8vPaJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w18yCmpsiVln2TpnKLgRxpt3g9OXMprKvLZq4BktCuU=;
 b=xb/Hdn/urmI4N0ClrEXI+xRRudBtjdTNtu7hEoKb6kxiFy8dmBvhTw8+pDhAX+JVZAu3wb3mAJ30La64TxaA1BNcTDm5wXFrzgGVYy7zGoCDZ8t233Wx7JYJUup2stbXAsQ4AV5ydheH6ZeSyb/BvQA0UDqXJ+C5GMw/BAY8jwBwgmPRD0HOIU8YSGYi0K8D4AclZxRwQSggq43eHztSXB7JJnHoBNo/wvwc4qsSH/DelDm/zhu0rsOaMfDXgQW3UXdqIZKR8nxlop7t3Y4ltR9H9w6bck1lJBQTXnFnICqGviyPAkt4DiiPPYHhWNCjHS/XdKdRHbZs2SpsQCW38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH3PPF9D9CDC305.namprd11.prod.outlook.com (2603:10b6:518:1::d3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sat, 27 Sep
 2025 06:07:58 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9160.010; Sat, 27 Sep 2025
 06:07:57 +0000
Message-ID: <b9b4efc3-7702-41c4-9d9f-85d2595d819d@windriver.com>
Date: Sat, 27 Sep 2025 14:07:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-security][PATCH] libmhash: fix build with gcc 15
To: Scott Murray <scott.murray@konsulko.com>
Cc: yocto-patches@lists.yoctoproject.org, rybczynska@gmail.com
References: <20250926061054.1868481-1-yi.zhao@windriver.com>
 <2ebef80a-a8eb-323b-cc9e-9a214380079c@konsulko.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <2ebef80a-a8eb-323b-cc9e-9a214380079c@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::16) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH3PPF9D9CDC305:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac83dfa-bf0a-48a5-d73d-08ddfd8c3470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SlFOQ1JMVkNpOTVQeEtHcXJFYWtTMmsybFpXeFJUS3MrV3BZQVNuNUlqZHVZ?=
 =?utf-8?B?cmM0ejBZQ1podkp3dzludlB1Tm5MVWFYa3NubDFENi94Vmd5bEFyblN5cC9R?=
 =?utf-8?B?Q25PUzM5dVR3VTRnd2hmTkIzVGFaTzhzbXVDWnVkUEFqa1lpMXpOVVFDQkpT?=
 =?utf-8?B?cU5odDM5QlFYZlJZeGdHRENsTmFqZC9PenlFZ0VHb3hWV1VpK1E1M2Qzc3lH?=
 =?utf-8?B?MTdRcnY5RXRkZVpMZllBWlpOVExRNWVUU1F4TTVWNnlmM0NmYVFGR2JpNHk3?=
 =?utf-8?B?QmhjMGlMT0lONzJ4czNrOEVRaUdKamNBRTI4R0RMVjZxUDBIbjcvaFc4V0U5?=
 =?utf-8?B?Z1JqTnVXTUZzOHVvTEtaQzZmTVh0OHFlNjF3NFQzNElEbDk4d1dkVVowbThX?=
 =?utf-8?B?Vmc3ajVRU1VhN2MvQjRPQXl5UHR0VGZLSW82SlBLOVRqb0NLVEp6Wjk0S2Q1?=
 =?utf-8?B?OWVjWnV0V282YlpvRmpTbzdYYTFQRnozUDFsUjd5R0Z1VDdaZVNGdGJ6S2ZM?=
 =?utf-8?B?Z3VtS3dNTUdHbFZIUG56aXJxcmVXcktnUGhvdXU0WEtRWDc4U01rQm9FR0Rn?=
 =?utf-8?B?RFdTdlpydVQ0WkY5cTM4blpxOHBVaGVIRXQ4OS83N0R0ZUtQWkovSzNQa0FP?=
 =?utf-8?B?SXZ4MmI5czRjRG1LL20zRi9zeGRFK3hDTDdFdnJDc0twalVlTFVPZVpLWWpF?=
 =?utf-8?B?czBRY0Mzbldka3ExOGd5SCtxeFROdmk2eUo3THZsR2Y4emRLN3ZnUUREQlBs?=
 =?utf-8?B?b2RyTGJLK05kWkczdWFXM2VPMTJoZXRpb1FmWFJIWElzMi96OEdjUHAxWEtR?=
 =?utf-8?B?YXpLcHpScFVRVVpqaS9maDR0K0JwTlNPbTNlUnNjYTBieWthNi9YMERZYTQr?=
 =?utf-8?B?ejdqT3RHRmJPN2licndzSWUzdThISTBBSkc2VGxXZzk5cm42TElCZVpPRFZY?=
 =?utf-8?B?d2lyWnlDbGxGNGcybDNYbldhOWVyeVFHZFV3eE9za0M5UHFQU28vdXdIUjhr?=
 =?utf-8?B?SEJKOXQ3S0dFdFQ1UytmMk9xTDh5MmpFNkJOajN1NmxaOWp6T1ZJUDFrdURH?=
 =?utf-8?B?Z1o1Nm4xUmVnMUIyNkNuM2RvNHlVUytGRGt3NzhwZ29CcEFjdmR3NGdHdDdt?=
 =?utf-8?B?T0hhTE5ZNG1Gbld2SVBybm1MdEluUnd0aUNYT3BtS1d4K2MrTGZwWktSN05i?=
 =?utf-8?B?MXVTNWpKRjh1Y1VlaHY2UUFoaE43cW50ZXAzTFloOTBld1VwSTg2WTJaOEx4?=
 =?utf-8?B?STlEVTJmV053QWt0cXZyd3gzWXVaYkJOTFNQdGZ0Rzd6aFpEeEFhWVlIclh3?=
 =?utf-8?B?OGZzYmtBS2dYU05udHVScDlsTU8rUW9pTlN4UnVRbzk2UW0xd1d3L0ZrTDRY?=
 =?utf-8?B?bkNUT3BWTzhFeUxscWZXQVJpQzJRTC9LZStLeHYxNTJuRXkrU0FjSnNnWlV2?=
 =?utf-8?B?VmtrMkkxNkdheDVyVExyamFzWVlLcGd4WFBWY3VGaGd5UjZobGxJQVp6Rm83?=
 =?utf-8?B?bEQyUTIrOWFDWGVydVROMmJOUTVucmZVK0h0eTdjdnQ5cVBCUlk4cjgzelVN?=
 =?utf-8?B?RGM3YWtTN2JpdnBaVzN1dzUzM1dWUjU1WHdsNGxlMTZtbGdZdE5EeGo3RzNy?=
 =?utf-8?B?UE81NnFiQlA0akhLTXc2Uy8rcktYaW5mRzZvaFZjUnVLMnhZUWczVkl3d2tH?=
 =?utf-8?B?Tk8wR0JybnIvSG5lemVYamxWTWJFODM3UEYvaERrdjFTbWJ6eGtQTGpOcHpE?=
 =?utf-8?B?QXhFTllUR0plZ0VWUHIzRWdIQ21STnN5NHlFek0zcC9OUlcyR1Z5dXBkUVBN?=
 =?utf-8?B?NnJhQ0dreTA2TmcwV3Bta2k4YVNBM3E0MERmYnM0bkJvVHJ6cjM0RTFCYTVD?=
 =?utf-8?B?Z3N1OHRIeVJzNHNNZEZNVjRqdW1IWDdVUlpDQmtFY3VVTUpSQWgrTSszc25C?=
 =?utf-8?Q?n5+vm/UY/AjMusrlUOY3+veS7oi8NhHM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1hjVzEzRWJqM1JzbElMbm5KaFV0alFNN1NsL1p1aVQ3YXhOdDVqNFFhZWpG?=
 =?utf-8?B?RFpueTUwN1ZtMVdCcUtjbEpRSkFIejBYZlZFdEZjeUtKMmxUVjl5UkdpbHdM?=
 =?utf-8?B?SldpRmRVRE1yOFB6WjZEMWZsZkVLQ29MV0IrWVc5NGpzM2pOZkg4WWpXMkps?=
 =?utf-8?B?TVRNbFZIbkliRThYdVYraGFoaGgvdWtCL1l4cytPTkpZT2srZGVNTjNab2oz?=
 =?utf-8?B?dytrb3FWdHk3dWpSZkZhdFZFZHo4RVNNMXN0TVNLTEJkdHo1RHJVNjBkMVVm?=
 =?utf-8?B?Z2NBekc3V20xMldMQVVZall1bkJ5VGVOck9WUUpMTTkvOXhmc25ZRTdycE9a?=
 =?utf-8?B?WXZ4SUdwQ0VPZCs0aGdrZFVjM2wza2FZU1dSSWpUS2s2Q2plMG9UZ0VjT3FU?=
 =?utf-8?B?RTlGRVdSN3liTWJpUGx5SEhPQ0FtK1N4K3Y3ZnQ3djBORnY0c1REQ0p5MXMy?=
 =?utf-8?B?L2txSWNERnUxT0g0b3VRdkJxV2dOSnJ6WW43MkpDWDJTSlpEb29MMzBwWXls?=
 =?utf-8?B?eVRzQzJnYnZwTzdRYTB5TTFWbElsb0hoZUIrd0FpRnIxaEV1T3AxRnhkSmxV?=
 =?utf-8?B?ZVN4dTgxK1liRlVINGJnZWR4dCtlRlNpc3V6MU9hbXJleGhjMFdFZGtYU1h1?=
 =?utf-8?B?REFXSnB4Kzk4WHdkcUx4ZGhoM1BEbGtNLzFReWZIeS84RjFYdXF3Unl6SFVi?=
 =?utf-8?B?elAzY1Rydmc1L3doaXYvQXFteVZZQXQzS2J6OVBMNEZuYTVBV2kzbGRZMndE?=
 =?utf-8?B?aXVFc0FOQW5MME4vMUFhSTB4ZmdQdnZaTHlkVno0QktQZTNTT2RqSXl6WmVl?=
 =?utf-8?B?RlVoRzc0S0lCOVNicXE5U28yeWc3QjdQcUl3bXhZOHhvYnlNMDltOTJGMlhK?=
 =?utf-8?B?eW5xd3cvbEc0M29yUG5vbDVEWEM3bGtlTytmWEZhN2NHSGtjZWMyclE3emsv?=
 =?utf-8?B?YUpHclY4ampjbGhIV25CMm5pcVZwSktldk5sRGdjYVdqUjFIc29YSmZESGZB?=
 =?utf-8?B?UWNmR0FEOVpWVU0rNkRrWGlYVFZnTDJsVS9Obzk5ekU0dUxtL3dBK0Y0SmRw?=
 =?utf-8?B?UGRESE1QTDVOMTVpZy9TRlZiZTE3Uk1LS01CTU50cGJZS0pFSlRlZkROVHZy?=
 =?utf-8?B?amx3VjFNMFRlTWVCc0VjVmtWTEpwSXFhSFhDeGM4dUh2OVJLaWNMczFMSmk1?=
 =?utf-8?B?ZjV5YXJKSHNzTU9ETW1IOTRuQUlRVTU2ajJud3J0Z3MwRTAzY1JabFB4WVpI?=
 =?utf-8?B?eS9IdkY3Z1k4N0VXRkV2cU01M2JLZ28yTk9CV08vdU9NN1JNUGdoeWVYVnJC?=
 =?utf-8?B?NTB6YllVbWYvdTFkU1FTb3lob1B6UDZ3VVFqcXpaMWEzSXFKTE5GSnVjOHMx?=
 =?utf-8?B?M243L20wYWgwcWpUcVVTWmovOVRqb2c5OHg2TE1mVm9OSXBpL2U0Y1hMRkxE?=
 =?utf-8?B?bUNPMFh3ZmpYQzV4T2xQT29SSGhTWFZmK3ZOTWdaRHdEVE16SUJOUzJFYTJI?=
 =?utf-8?B?dEVsZGd2SkhxbUF3K1JVb3ZRbGtrSnJIQ1o3U1NoRE9USGxFdlU4cmx6Uml5?=
 =?utf-8?B?RUQyamJuOGVLdFNWdGlTMlRPbElQTFlIckFnY2VUb1dUbGpnSkozL2F3RU5N?=
 =?utf-8?B?K3pNTkE0ckowcGhFdWRTMlhZVTdCbENaQkFCTUlSWlpxVnBxYktVSThsWldX?=
 =?utf-8?B?UiswYTRnV1gxUGRvYlFYaWZjWXdKZnBZN0J5Q0pyM1ltMW5LWjRWTld5cFBo?=
 =?utf-8?B?RGpQa0JUWEVUdjV6MXZoRVNuU1ZKcEpHREg2OTBieGRMa2dRbmkyWkpxT0ls?=
 =?utf-8?B?UStCbWUxRWNyN2JQVDd1bzdkYmdacTFBSk13cGs1RW1Ec0p1c1A5U3I4a0FC?=
 =?utf-8?B?WGs3M1cyT0w4enFNYjFJZDhHdCtiRlVkTnNZOEhlN0FQVit6dE9tV1RCTG1l?=
 =?utf-8?B?TUk1OEJibWRIbkswZys1eDZUbFdydFYwLzEza2Z4WTNJVU5GajUrcWVrSkVN?=
 =?utf-8?B?eXJFUStVN0w1SlZlTkorNGJxQjRiT2M0eGtyM1pCUlBCNWxSWHdCNmwrelN3?=
 =?utf-8?B?REhMcFAzeERwK2d5Tjhxcll0c3VsV1l6N1RocnNmb3p1ZnVWdlJFbUV1Vks5?=
 =?utf-8?Q?ByHSHJr7w5PWrZfzlUw746TjV?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac83dfa-bf0a-48a5-d73d-08ddfd8c3470
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 06:07:57.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKlrkjP8z28hrazj96KmOHOOGx9Sq4B+g9Y3yVkzvDlsjA1/3W5YdB96aVwp4BAI15B62Djx44GRBfq2BLFVLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9D9CDC305
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA1NiBTYWx0ZWRfX+qbm1oMf2Ldl
 D/TUxcEQgb4f6FnhqtlbmdhuigBaVg2DpO2Rird6U9tm+gaI9mlF+yHIn5uPbt+ro/pdXfgpUbc
 VuZ7xSqk5Nji93H+rCyRp50JFyktFlBVqvrigc7ZOUF0Fda9EyDH7RH2FSTxMz/vv5coAcLT6tt
 2H+cNpAGewThWECn3D2yGE3NBcYN5gS/JZ4LRan4BUu/5t1cj0gmkK2zAoVO4E7pOvzMTMlL2gO
 qvO5d7rneminrFTHf/vhGxAb2mWT47wPYDQ4mVb7tKroxW4qnL95qtKo14PVeFqvVZ/NhfXO87v
 VEMA+W4YK36fYyRsgkVStsZA6BbEulkPpEDi8E2WCALAFKE6yHr7SRH7P42o6brONOPiDzM1HYm
 vFza01hQbdGfqfAih7xsm+vPHEl+vg==
X-Authority-Analysis: v=2.4 cv=ZNPaWH7b c=1 sm=1 tr=0 ts=68d77f42 cx=c_pps
 a=XY6iRpq9SnwSJlsx6znn0w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8
 a=z4TFCehLiA-TOWsEpPkA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: HOCvLjESauphJL07UF9kwNz9cdolpG8G
X-Proofpoint-GUID: HOCvLjESauphJL07UF9kwNz9cdolpG8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-27_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2509150000
 definitions=main-2509270056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 27 Sep 2025 06:08:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2244


On 9/27/25 01:19, Scott Murray wrote:
> On Fri, 26 Sep 2025, Yi Zhao wrote:
>
>> GCC 15 switched to C23 by default, which libmhash does not yet support.
>> So keep using C17.
> Nothing in meta-security actually uses libmhash at the moment, so I'm
> curious if you have a usecase for using it standalone?  It used to be
> pulled in by the aide recipe via PACKAGECONFIG, but Armin disabled that
> last year with a note that newer releases will drop using it.  So my plan
> is to take this patch, but unless you can confirm you need the libmhash
> recipe for   something, we will drop it when aide is updated, which I
> intend to do soon.

Looking through our project, we don't use it either. So I'm fine with 
that, you can drop it.


Thanks,

Yi


>
> Thanks,
>
> Scott
>
>
>> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
>> ---
>>   recipes-security/libmhash/libmhash_0.9.9.9.bb | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/recipes-security/libmhash/libmhash_0.9.9.9.bb b/recipes-security/libmhash/libmhash_0.9.9.9.bb
>> index f5518d2..805cf05 100644
>> --- a/recipes-security/libmhash/libmhash_0.9.9.9.bb
>> +++ b/recipes-security/libmhash/libmhash_0.9.9.9.bb
>> @@ -25,6 +25,8 @@ SRC_URI[sha256sum] = "56521c52a9033779154432d0ae47ad7198914785265e1f570cee21ab24
>>
>>   inherit autotools-brokensep ptest multilib_header
>>
>> +CFLAGS += "-std=gnu17"
>> +
>>   do_install:append() {
>>       oe_multilib_header mutils/mhash_config.h
>>   }
>>

