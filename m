Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130EECCFA1A
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 03:32:51 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39449.1762745563496446086
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 09 Nov 2025 19:32:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ZUXLnmDS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3409dc8381=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA2eb0K2675619;
	Mon, 10 Nov 2025 03:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=QHvFDPGs6/ZAbpP/CRRLrrFw1GbcySqJoyGgd3snMAk=; b=
	ZUXLnmDSOrU2mKHcnxmVvW6bvLNBgca9gAGrQX7YuotixMz5rQzSY//yKoO41Jy+
	iBVD4JlKJ53QC7l8a/YXiftuBdi0Wd4r1udJ9jYTBiZk2TubPnUnFfo0VZAD8vm2
	6GtHh6ZsZ3ZylH4lnkzuHpe0PNsufA9M/oV+6M6EGxm73mhVTj9Tm4j/yxQ8W3Z2
	BTDHJn276ZT7TQIoi/TOtk6vmPmTHUhEScaDpe3NFoXgl1GuxqWobKAOm6f+W8YS
	YNfPq2qZ1Pf6CYftIi/0o1hzP4Ylpl9nzmhQwe40oD7+Rz23eqWL8DISaAAt5cgg
	H3NXitOxVMwoBJN+5yVf5g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a9u2x1h8t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 03:32:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7JHoMKeWP4NeDop+sgzr3bUwC7G8w5GgwR6H+puArRQEoaQ5Q7LazMKiytLExGw6+/Yp0dl+cHwIJBXxpCPZ1JDlKBLyxxHvwzT2z7KJxxE0z0vKNnKHWQOmnMsn1s/AM+Cgu33LQpJ4WCi2k04Wcxaz4Y/ekz42zxKBroqxrsweSNr1Bvc8wgd4A966zB4hwL1graI+Tko+fbkMgRvIHoRSvRYcxzgLT5eaaVbDbD3Gk61LMK9yPkrCJQtk8IPLg0FDbDvRhAWoeNt6snk4Q3+MzAUDynjWgJGWtNNo3g9WcmagrjfCYA77Yh4+W7OH8yk6055qAlpW7lWR+tZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHvFDPGs6/ZAbpP/CRRLrrFw1GbcySqJoyGgd3snMAk=;
 b=QWXannR2BlFAADYHkkKPTXCAr8mCyyDD05nPaDj/vMCro7jeiK9Q1eO5hb3n0Mdiof5piG3EQcbS64iUgFOxuAMQi79s/S71d4llZ9IcWKcSl6jDtUYwN2xWveNpwK6StacXsCPo3vrnIRcrzKjACpwPQZwv5v+UDATFRsAcPaqAWvc7rz7x51rA/7XUuRjPbLf3xOcrk1bVS5nr2tZRyliRXLePHCRIl/UM2ezy9XWk1zSJ2bnsJsSJuiYK0G9Sns/EBd9p7akymTvAcxJvXVgXemPF3J0ndAX24qnXPD2csNOYVEuFboFL0/KvKMt4I47uih4G9kFEkAVMy3T5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 03:32:39 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 03:32:39 +0000
Message-ID: <d25b7932-1dcc-4b01-91ad-00c46227a52a@windriver.com>
Date: Mon, 10 Nov 2025 11:32:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-mingw][PATCH V2] meta-mingw: support generating Windows SDK
 with no symlink
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com, paul@pbarker.dev
References: <20251103021848.3068540-1-Qi.Chen@windriver.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <20251103021848.3068540-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::23) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CO1PR11MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: acf12dda-e233-46b5-5172-08de2009cc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bjYrYi9aUVg5MGo1SGtFZUdsbW41eTd3STV2dlJGa1MreVRsa1RUWDR2d3VW?=
 =?utf-8?B?N21CWms4ZXJCcmpnTGs5TVZrSmNHTWRZQW9MYkR1dVB5RU55Sk1acjFYSWFV?=
 =?utf-8?B?a0cvSURibXh2dnkrZzd2ZGVEeDAyakZHanpwdExKaDdEdHpJSmFhczZOTWc3?=
 =?utf-8?B?YjU3Um5VZy9OY3BZY2pyejIvSWF3bkhHYXhQaUl6U2haUGpPVXNMaG0wWmNn?=
 =?utf-8?B?aUxUbXhnK21OZHd2cW5KbzlwOXVsdW1ST21LcWRiMklsVFRMdzRHWHZJTkNa?=
 =?utf-8?B?TVNXMzUwM1JPVzQ2eUU4UnJCa29RU00rWTZCNlkvYS9iQzlwWFNLQ1FaWmQ5?=
 =?utf-8?B?ekRpMDdjNW9PbEdyMXFwNS9CSzgwMzV5Y0ZNOHFWNFNSRFpoSlorZ3N0TElO?=
 =?utf-8?B?SUNIaUZiU2VSUk9nSzJZVERPYWJFV1hIRjlJWnZlYXhyOGc5UUFVRFlmL0dl?=
 =?utf-8?B?bC9nSWo5b3VNZlVFcnMvcVpPc3NSTXJIaE1GM09aKzRYTGE4cll6dEN2QkQx?=
 =?utf-8?B?VjFTZTFFWTBid2RFL3RhSUd6R3NZZFlPbndwZ1pHZWgvMk9MVzVFQXYwUTRL?=
 =?utf-8?B?SklVVTVxZGVKK2hWZHJhcEt0ZmprVWhCOWdHYUFTcW5hb05wRzlNTzc0WEQ4?=
 =?utf-8?B?S2h6MTRpdFB0OFpoQjdPZkdjdUs3bEFZd1Q1YjdWNEdWbzZzRVdoVnV2TDhE?=
 =?utf-8?B?eGVHZlhzaUVCQndnZlBIVlg2WlJ2VU1mTFdCc2lKNXlabW02c1lKeXZjM1A0?=
 =?utf-8?B?V1F0b1c3ZkJwcEdiV21GV0JZOVhpczAycHgyZ0dsN3pBbElLSEpWZjNtMzA0?=
 =?utf-8?B?bmtvSHhMbnM5cE1wZHB2NTY1aVJLNUhtMlNQTnpnVGNvM0w4dWtvcHhjSDZC?=
 =?utf-8?B?Rkl1UTMzMEwwQ3M1OS9YbVBtaVV2MVIzZmdKakZ3aGpYYkVCanJqWWIxdnZB?=
 =?utf-8?B?UHJuRVFuMzJNaVNPaHdGbzk0Wm9HWERZampCL0JFd2dVUE9KN2F3Z1ExWnVl?=
 =?utf-8?B?KzRGdnFNT3BETG13SlB6LzVuTEVNb056NUh2Um0rQWpta0pxb2pva3hMQnJa?=
 =?utf-8?B?Snd5MDMyTUxCNVpTRENyQk1lekhERDc4MDJDR0xLZEhrNGZuY2tNbVJldGVa?=
 =?utf-8?B?U2EzRXA3Y2k1YXpmNTBGOTFJWHRCM2RiWGN3b3l1bnJpT3F3QnUvMDFrZm1m?=
 =?utf-8?B?VUZTY3JXam1aUUFtNEc4ZjJIakVvVTlWQmhHTDIzL0xaQ001TEd4REdJMjdS?=
 =?utf-8?B?d0RrYXo1SmhGUmJvdnlCa0QwSXFzbXRmYkVEVmlQQXVrV2NEb2NZUm1IYnJX?=
 =?utf-8?B?UWd4ZUV0eEIxVXlFT3hpUVNacjVjRmJvU1VFTEpyVnVMRldXK3czbE8yRnNq?=
 =?utf-8?B?VFJsdlpHS3R1S2V1cUlWSHArNnpqRmxhM3RlWHhETFlSUWhLUEsvRThmUEsx?=
 =?utf-8?B?aGMwT1F4WEdJaU9uK2xGSCtxN0p0SDNDelVpcnNKMXR1b3hXTlNjYnA4Sk40?=
 =?utf-8?B?YVBoKzc0UDFpMTc1TlRaSW16bE91bGdkMFd2NG1XSFJsTjE2anBaaHFYRlFz?=
 =?utf-8?B?TTM3U2huNE9qaHEvS2RCZUtCVFR2b1BWa2FXTjZYb2lmRVBFVCsyODF3bE9P?=
 =?utf-8?B?MkkvdkFQR2RabzBaSmpEckJwOXpYaVdaZVV2UG1aL205QWRTMmRFT1FLN1dH?=
 =?utf-8?B?L0tMa3M4aWxhZTNhaDN2WW9XMkdPOVA1MzM1OG9ucC9kc01Kb291NnRoOTN5?=
 =?utf-8?B?eS9aaG5vaEZLSDlDSHBoWnNsUmJZNWlJd3Q4c3IrbDZHYTVQNGVIK1BIM2lF?=
 =?utf-8?B?RUloZjhYYVhyY2tScVE2R05wOEQxaktOTGl6RVVMcklxbEU0SmcweDZyRHlG?=
 =?utf-8?B?Q1FnRENIeGpqM09YVVVZN0dJZ3BLeEVac1gvbEl1bDJvSDA4dVgrUzlhUjdi?=
 =?utf-8?Q?CH0e3gHg+6c+GPHPwN9m+AcxJnTZ177T?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHRXbFczQWYrWExVVFc5VGpFcldRTE8xZEsrQ1hmQ29IVStleWszdVYyY3pv?=
 =?utf-8?B?S2ZpbDNzejZNVksvT0hhQTU3R1RjWFFyd2x5b3ArOUhVVXNwcmxhcU1LNVZL?=
 =?utf-8?B?STFFUStpK2R4RklBeUJPVkM1YjdCUURJa1dSYS9udEhXeHpHS2F3UUtiaFcx?=
 =?utf-8?B?OE9oWUVoSzRwai9keWl3UmpRT0h2VHd3TUxFZi9ObzhDV2x4Rk8rLzMrM1NX?=
 =?utf-8?B?UGNzY2IveUpQZXErR3RCL0xyQXl6em9zZlR3TGNrblFGd0JDdTBKT2xhZXo0?=
 =?utf-8?B?cmhOVnkwbTBVTnNERmxaWWRPRHc1RUgyNWQ5RmVObGxEaXhpV0IyMEJUQ3lZ?=
 =?utf-8?B?bkluZGpQM2U2bHo5aEpKUDRhWllxK2FWaitBSFBVbGJzTXVnMGJCRDVicUtr?=
 =?utf-8?B?ajlHYmR0SUtVRzArLzIvNGhYWkdPeXIrREM3ZFk0VkdwZUJLbTJGTkpWZW13?=
 =?utf-8?B?a3dGYXM0LzJ1dmt0V0VneWIwVlVQcFFCUFNYajhnQ1BtbE0zb2ZlRzBFUk0x?=
 =?utf-8?B?V2lMSm9MeURNLy9yeUo3N3p1VmUrc0JrRzhKQVlDb1hsaTZCQnVoa2pOMUFO?=
 =?utf-8?B?V1gwd2I2VkJIM2hiZmdMQjdlYzdsN01wZ0lRTHpIOUR5SUlTWmJHdUVmMzFX?=
 =?utf-8?B?aU4zY2syZDllUWxvV0xaQURYbkdtY29HY2ZRak1jczIwbXZINitRWUZyWkh0?=
 =?utf-8?B?a3hYTG14UjJvbWFPZXg4Y2tkMXhiSE9TZGpkdWgrNTkzQVNwajArTE5mMldm?=
 =?utf-8?B?cFhoaW5KaGJWdHU4enQxejlaQTE4TTBUdkFUWHc2MlB5UDJqd1F4aGhIaVBv?=
 =?utf-8?B?ZmRxT2RlTlZNQ29peW96UmZKQlBlQmg2WExuWVhEWTRtZ0lnNkFtUHoyZER1?=
 =?utf-8?B?bEpacnpha0hzQStwbmNVS3BYZ0Q3RTh1Sm1RcHkxSkNsRnFQODJ1RE9PNVVy?=
 =?utf-8?B?ZGNKblVDRk5jZDJZQWdBTTN4QU5zeEt5MzhQWEJPNzVnVDBIRE1LaEx2Q2Nz?=
 =?utf-8?B?b09POUtFckpIU2FvQXZJTmpmUS96K2pTanNQK3kxTGtpTmNzbW82cUMxNFZQ?=
 =?utf-8?B?WXpFSVlBbXpYbnZ3dVB0eUJ3aWxPTitDZWxWa2R2REV1L2ZGeHFUMVZyem4v?=
 =?utf-8?B?R3crRnFiT012TS9EYlZCUmJtSUw0b0QyaTdxSTdHU29maHU1NXR6WGFZS1Bv?=
 =?utf-8?B?UWJhWFR6OUZ4c0Y4UGprMFErNTdtRjVSdHNTRVZyTklJd2JhcVgrdzdmZHhZ?=
 =?utf-8?B?KzJLUlhaYVVRY0lDbDFNclRCQnRSeTJwKzJabDJzMmRDZG0rTGIvZHIxTTRl?=
 =?utf-8?B?R2MvelZVTTZPcWZOUi82QnZ5WmExZldxWHJiTVpXYXF4QS90aDh4RktwNzNj?=
 =?utf-8?B?NkJnalU2dC90Z0RTdDJjWHhLUXp5Rkk0U3BZazMrOVY1MHNlclVDMnVxZkdr?=
 =?utf-8?B?VG4xaW8ySmtzSVhFY1RJNGNDMmxwYTJvRnR4dDBJV09DUTI3WldYT1ZkZXVu?=
 =?utf-8?B?K21nOVAzNGpHSzBIcnB2OVh1V3Ftek96UWZ4NGc4NFhMZVR1LzJwaDZFM0U3?=
 =?utf-8?B?ZmplQzFwWDJjOTB6ZEd2UWZRRVpIVFQ5YUJZejhhem1lY3VwaUNaZ1h2T2gr?=
 =?utf-8?B?R2xHaytPWVNlays5ZlRHL3hZenFqK2RPUVZqOXhwRllZOXd6azlXMFVmaDBa?=
 =?utf-8?B?TVVaRjEwSTB3Z1JQa1FTaUVQVVdDTkpORGtFckd0Y0htM3FiSlJjN2lnKy9m?=
 =?utf-8?B?dXBRUzdsUUk2T2oyK0dQQXd5QzJzYTV2UXpyajh3RUZ3OWpQOVpQMkl0aHFt?=
 =?utf-8?B?ak9VNlpOSGZ0a2FCOEUzclNxZnJwcG9GOXJzZEtVMmVjdWdUZVF5ajRZdlJk?=
 =?utf-8?B?SWtlcDJGdGMwaWEvaTFDWEtWOTh4L0NYSERYWkVVMjd0TG1xdC9ZakJJelhh?=
 =?utf-8?B?M0xhcUlYazJiVUp0V3U1Y0VxQnZYV0NRV3YwU0Nxd0VXbnZkWFhVRkF6b2Qr?=
 =?utf-8?B?SEIyTGhZRFZXNHZqc0t5S2ZidUNEdHB0WkFhSGdYaFNRdCtuVDBhZ3VXa21N?=
 =?utf-8?B?T2tJVURSM29nQnFucDQzVm1XRE1vajV6c3ZRRldveTJIOEhmYWYzOGpyNXg1?=
 =?utf-8?Q?bC/An9dRkSmq9bM9413lSMbZq?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf12dda-e233-46b5-5172-08de2009cc68
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 03:32:39.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSnvZ+NtBvTWyFMYsskIKXb7Ytlfb838wnNip5zrV0xRnPUjzddWvYdJg4ogro4DuuYhFm15m8ci0UZLCcHOEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4865
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDAyOCBTYWx0ZWRfXxdiJKUJHv797
 0++uJEJ17jO79hYqezxiOkgrzHz80Nse7qWz1HQF5cN+KHJSnNGX52RBLJyeL2okv7gHDWsZy8P
 NIHfBEmaro4W4iN4ejWp4v1lxjWocbOK16DLJPSwmdM2bNSPoiQvkhSB4cuWWtVzkbdGSgtlKtx
 aF38UVC5B6g4QIiPrr5BB9dzhYO0exc1TUXybAqls4xYD82VtWDG7uIdU3Ph84oPd6HCDTtuSBa
 q3wlgkl55zMmXhfEbrOK8OTUpzmkfMVBtUSjWMseim6Zh3ZZVh8mox+/WUpCIaqHKliy6Fa6wRv
 lK3Puf7r1jRpDv1JfhROJxv+JJRias0BwW84rVQqstOIEusYL5Ig3QxtcK6TAAKfOXNnqekJyPi
 KnQh1R8Q8PuUMz8uHNz7Lrga+Aei/w==
X-Proofpoint-GUID: rZ1gknFA1ppMDTFzqBzxL0JuRu55sSji
X-Authority-Analysis: v=2.4 cv=Uvpu9uwB c=1 sm=1 tr=0 ts=69115cda cx=c_pps
 a=rnKATYkPCuOGZDe3J0X1vA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=uZuYBlGWEboLjwUAboIA:9
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: rZ1gknFA1ppMDTFzqBzxL0JuRu55sSji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100028
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 03:32:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2465

ping

On 11/3/25 10:18, Qi.Chen@windriver.com wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>
> On some Windows systems, symlinks are not allowed due to IT policy.
> We need to be able to generate Windows SDK without symlinks.
>
> To do this, a new variable, WINSDK_NO_SYMLINK, and a new bbclass,
> mingw_sdk_handle_symlink.bbclass, are introduced to achieve this.
>
> By default, things work as before; when setting WINSDK_NO_SYMLINK
> to "1", SDK will replace all symlinks with the actual contents.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   classes/mingw_sdk_handle_symlink.bbclass    | 25 +++++++++++++++++++++
>   conf/machine-sdk/include/mingw32-common.inc |  3 +++
>   2 files changed, 28 insertions(+)
>   create mode 100644 classes/mingw_sdk_handle_symlink.bbclass
>
> diff --git a/classes/mingw_sdk_handle_symlink.bbclass b/classes/mingw_sdk_handle_symlink.bbclass
> new file mode 100644
> index 0000000..2f6dbe6
> --- /dev/null
> +++ b/classes/mingw_sdk_handle_symlink.bbclass
> @@ -0,0 +1,25 @@
> +WINSDK_NO_SYMLINK ?= "0"
> +
> +archive_sdk:prepend:sdkmingw32 () {
> +	if [ "${WINSDK_NO_SYMLINK}" = "1" ]; then
> +		for parse_type in "file" "directory"; do
> +			find "${SDK_OUTPUT}/${SDKPATH}" -type l -print0 | while IFS= read -r -d '' symlink; do
> +				target=$(readlink -f "$symlink" || echo "NOTVALID")
> +				if [ "$target" = "NOTVALID" ]; then
> +					continue
> +				fi
> +				if [ ! -e "$target" ]; then
> +					continue
> +				elif [ -d "$target" ]; then
> +					if [ "$parse_type" = "directory" ]; then
> +						rm "$symlink" && cp -r "$target" "$symlink"
> +					fi
> +				else
> +					if [ "$parse_type" = "file" ]; then
> +						rm "$symlink" && cp "$target" "$symlink"
> +					fi
> +				fi
> +			done
> +		done
> +	fi
> +}
> diff --git a/conf/machine-sdk/include/mingw32-common.inc b/conf/machine-sdk/include/mingw32-common.inc
> index 56b8052..bf3f14e 100644
> --- a/conf/machine-sdk/include/mingw32-common.inc
> +++ b/conf/machine-sdk/include/mingw32-common.inc
> @@ -59,3 +59,6 @@ GCCPIE:mingw32 = ""
>   
>   # wine and wineserver are required to test MinGW SDKs
>   HOSTTOOLS_NONFATAL += "wine wineserver"
> +
> +# handle symlinks
> +INHERIT += "mingw_sdk_handle_symlink"



