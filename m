Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750F4CAC598
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 02:08:59 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.12867.1758074936486876797
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Sep 2025 19:08:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=Ozmkvayk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=1355165e2e=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58H0wPOk261559;
	Tue, 16 Sep 2025 19:08:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=vwUQ9oufrtn2JNiomdBVraYM84ZailMCu1LMX0rWRQk=; b=Ozmkvayk5F1c
	5GNC4NCMt9t7xZBPgH6501YxCTprE4SLgOgGKGlSWUqCE1V5Cbb1SfMdJO+YTum8
	i2DLx9Ss9ZB36klOOZ38T5bZvyMkikEo8qVyytLxsFg3nz0Sw/mGqDZWJvF+uJsw
	3ooszrBkMstj5KTF7gxv6KA7XJggi6M79JEfYHLWuGqP756q0Z2BkNHB0lcLnF0Q
	HdJleZWfFyJbMb49AVIFTJ53pwFhie4eaIwljQo/CKDL9h1P2ey+h4k67nj+7M0I
	vpMvYdjn8uDEF8adnhZ+nay9u9z5sTE95+zS8t8cqQefyqMExer3qSThthrzA7wd
	t2Pt3OLNxA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 497fwr056k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 19:08:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtwAfVtHNonjv6LK8SfWa5ibt0410hZAr79drfjxiGaLxGhDvswGt/Keani+yNrsTjCRQB5efa0Q5uXdfCcounzrQAjGtN21rqh3JbjL5e7muj0nQCgzvAbNOlFyakCV89o8jLjORoWtuu/cK4wwjslZV3Gy1mbkFibGwd5oP/U/QXFI6kZQmMiQwW3+e2n9cjHmOEonyEcHX6Gs8RpWqBztL/6EN1fN4UpHR43cfj2sJ0zV+wxxpA4Gum+3p/JHQDQNryEw/XAkFC3VvhnXQspZ6Q1gg103gpdgRVRn5UAdMUz+72w1BATLeCI1/LtHbwf7jyhYSw950WI0TJwejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwUQ9oufrtn2JNiomdBVraYM84ZailMCu1LMX0rWRQk=;
 b=px5m7EuULZvxuOWXRGaeCAsKom14x7jGUYhIkZKsEc4wE5NSNpNQMhaRRdN6O2Xf9pDeTQGq8L7h5PYLTLCCS7RqiKQPNoqcGfLSAXjK69ggFS+WzA2CuQGSaAIaip9NUrw0pbPcO8yqxi3yn+9hm9Bza2WpMz5EiKcJ5qrWOE1PErs88+8cgBTf+kxMBivzoLgrEsuZMGtzpphSGP6ZYsKhteZQu46G9B+J9ZjEhZY6mva9jWPjiS59yZYtNzUBgnlZhCadth7bi8M/rqOJI/YJ41XUvBSR0U+Vw6yElF54DFQHG9u5F4UqfTNspYREh8p9JKBbR9fk7ue5DxuZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 02:08:50 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%5]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 02:08:50 +0000
Message-ID: <82d8fef3-e46e-46f7-b75b-0b812c0b0cb0@windriver.com>
Date: Wed, 17 Sep 2025 10:08:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][walnascar][PATCH] bazel-native:
 fix build with gcc-15
To: Martin Jansa <martin.jansa@gmail.com>,
        yocto-patches@lists.yoctoproject.org
References: <185CE350789F6CFE.8958@lists.yoctoproject.org>
 <CA+chaQdqb7f+oo44idJwqdOd7PR4PK3Q2r4iD4mQf9F5YZzAQQ@mail.gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <CA+chaQdqb7f+oo44idJwqdOd7PR4PK3Q2r4iD4mQf9F5YZzAQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|CH3PR11MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac91ba9-b9ac-45b1-9231-08ddf58f24c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|4022899009|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YzJjQlhmblVBbjd4N2htT1NzZWZUUFA3TnNCSmVpUDBzMVF4a05pQ2Z1OEZR?=
 =?utf-8?B?T2xKQVR2MnFLcmJEbVF1VVMrV0RlTVJQZ0RXOHQrS3B3N3h6UUpBbktSL21I?=
 =?utf-8?B?NnN6MDl1ZXZCQ0ZZbURzWTI0eFQ3RlNGME9vMG9jaGhhbkFBZHBMQW5qcHIw?=
 =?utf-8?B?NDcvc3N1TmtPcW9jWlBsMGh5RCtkZ21KNkN1dDJSeWlPK3pqVWduZ0VwMXps?=
 =?utf-8?B?TzA2SXhTK1oyQjQyeWpyRVorK3dqeFNKNVoyRUR2ZU1mdTAxYXZSYTh0VmpJ?=
 =?utf-8?B?dVRvUFR6ZXpsMkN4dmI4Nk9uaUZ0STE1K1RXdDc2YzNEWWtscVlVWHFsN1o1?=
 =?utf-8?B?OHpYSGo4a1hIclNtR1dzTnN6RHoxem9adDIremwvV0JvVURaelNuV1lrbnZz?=
 =?utf-8?B?SjZPU3VaY09UaVN2aVV3SDFybERWNVVtdjEzUkhOcXZyeUNFTFVpK0tHR1Vp?=
 =?utf-8?B?dElRSHVhUzEyOFMxblFVMXQ3QXN6NE8yMTdkbE02QzNyZVBYTUE1Nk80anl5?=
 =?utf-8?B?Zm9UMVNMSlNOV1MreU9tWXhFc2ZpUTIxVXV3dTJHNFZ6alA1NTErYUJpK2Nn?=
 =?utf-8?B?UU80WDlIcW5velBnb056aFF6MTZ4b3M4Z0lPam9lam0zWnZ1Qk5Bc3ZZeEJH?=
 =?utf-8?B?NktPdC9iYVFQZlhMdHZCdHpNUDNiaUlrc3NsL1lRY0M3ckViWm9XOTJ0VmpC?=
 =?utf-8?B?Q1VlYmJBclBCb0RrNDJUYWxIV2pROEd6aDR0Ri82NEV1RFNKQ0JWNUxxanBK?=
 =?utf-8?B?OFBySURya2ppQjIzUnFXQ3ZhWll0WiszbmFVQVZBK3ZHY25Hemh6dmwyRWZa?=
 =?utf-8?B?NWY1bmUrazN4aVBLc2l4Q054d0VoMnVPU3JzUTFvY01qYkpBMXYrdWhCaFU0?=
 =?utf-8?B?ZDIzVW4rNFRmMFFxZWErZk9zdHhSS2Z6dURzREpSTmN6Qm9QdUxlQTZUS1RR?=
 =?utf-8?B?RjdwczRXK29aclB4c3RyNk9pclFoMFpOTlFPRTkrenREOGJLQjFuQ3RzSVJj?=
 =?utf-8?B?YkRoeUUxN21kUmhYWWtia0dkRjZGN3BiWjEvd1h5MjZBRTdzc05vbndEeDZN?=
 =?utf-8?B?YXdTUWFnaWplVy9lWmxXQnRvRFdyUlI0Tll5VlBibWRlS2N5ejJpNzcwendz?=
 =?utf-8?B?TURvbmpldGU0ZUh6MVZ4OEJNTnZGdmpVZWExQ1laVHNINCtrdWNLVlQ4Y01n?=
 =?utf-8?B?RXIwTXl3QXRFQTBZZkE1bUNLRmpKZEhhZXBCeHhvZGVVcGQrN3dLY3d5NlVw?=
 =?utf-8?B?M0JkblR3ckZpaWRBTmdyUzBnS0NTTUxMZVJNZFNlREtqMEZGRmMybmFUQThD?=
 =?utf-8?B?Rm5DbDZramJ4TEh0U3RPZ2RNb1hDMG1lR0JKem1WY0F2bEw2cFdyZ3QvWFRk?=
 =?utf-8?B?a0syT05yaTVMWUFrbStzWmwvcW9nY2FOWWxxN1kzbmxySWxHL0QrZmRoTklH?=
 =?utf-8?B?VzB6Z21DMFFEZFY3Z2RSZXlHS2NIN0gyZkFlUklscm4wSU54eFJZaGdsWm1S?=
 =?utf-8?B?M1B6Z3lYdHhvZnNoSEp4WG4zUmMvNDMyblRhZzQ2TnoxQVpqSEZUN2ZFWnlL?=
 =?utf-8?B?ZjBsUlVJbGROWFZtRmNjU2RQWXoycTN6NTZkeGFqWEloL3hPeExEeUJKQTB2?=
 =?utf-8?B?Wm5OeFRSMVhXZk1iZXZpU0JkWVovaWR2ZnZaQnFYRFJ0TmorTmZKdlVsRU8y?=
 =?utf-8?B?SVdPOHZWSXpJWGhhQzM2WkNpUnRZMTE5dDhzVWdsd0Y1MTU0cFQrcGxyaGRq?=
 =?utf-8?B?d3BNTzJMT1o0bUpocVFHZlZNYzk0QnVmOWttL1ZIcEpQbkZ3YmpnSVgyL3Jw?=
 =?utf-8?Q?FWEeFW3j6eQQejLBAwJY3W+PqnA7EFHOv1XVg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4022899009)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2V0VUJZMEFnYWNucjBMWkRlM0RzbTB2N1V4ZDlzYnZ0L0UzRFNjakxpSTNa?=
 =?utf-8?B?ZXR0VHdreW5QUWc4dkxhNENidDE2dGZNM01lbTJOY3hrOXc4V21Ccm03Wk9D?=
 =?utf-8?B?cmlYZlJvcXJUaXI5emJmNUxKMHV2V2hsbVJ2bmszMWM0RnBtR3hOWjgwV0tz?=
 =?utf-8?B?RjZ6M0NsR3JaZ200K1puZUQxRkZyU05BekxVMEtKSjJDWEFiRUNOSzVpeVVz?=
 =?utf-8?B?em0rcmpyYlYrUlJvWDNTTW5XK0RiSG1kdkx2dXZQUDV1WjNGZDY0dlNZSm9J?=
 =?utf-8?B?d3EzRDFPbTgxSXJiUkpjNmgzV0JPZHpoQzYwK2FhRHZlMFhnOVlCM25KQjRj?=
 =?utf-8?B?Rm5FUnJmaVlEK0tRNGE1MUVtMzgyTWZGMGhlZXdTQTEvUjEyclZuWTVUM1NW?=
 =?utf-8?B?N1lMd3lySi9kVUZSeFRvZGE5dk8vSkVvQlBHcG5kVWk1THVBTEpMS2x1aExu?=
 =?utf-8?B?SFVNMjk1VHpmUFFjeXpUQ3JYL3NQU1JrRGdrUG9ZcFNpeFJvOHErZTZpZ2Yy?=
 =?utf-8?B?Y3JRMWNFTTRwcGtKV1JMUUpZWmwrMllhVnpHMXZaZjIxQlM5N3FQNmJiYzJ4?=
 =?utf-8?B?UWRTc2ltM2JYckQ2Qk41Tk5kZFBvVXhvUHNrUk9YcGc3QlU2bmI4YnljQUYz?=
 =?utf-8?B?YzZBUnFWVWcwYzl6QmNNdHVzekx3bmEzdGUwNXNwTzErNWJtQk8rMFB2dmta?=
 =?utf-8?B?eHBSTjIzQXNjaGN4WVFNS25na1dvNGlIWUpFRFAva3VsUm5wOHJteUdRUXZ4?=
 =?utf-8?B?VytUYlhCSVNRaVhZa3NZdXAxWllFZlZ3YmhxVDA4M2NpdTlWSTJHVDBEcTNO?=
 =?utf-8?B?WWoyTEFPdE1lZElkUEM4Y0pZQkRXeGJZOXpiaXpOY3hMNEZhdERWSlJERStM?=
 =?utf-8?B?cS9EbkR0R0ZpVHpqVmZ3eHhkT0NvYTg0ZXJ0OU81T1ZQWDZMOTJ0L2Z0b015?=
 =?utf-8?B?SGIycVVUOXIyb1dFN0tjSHYrZWhpeEdmdG9Iam8zc1BmUERnUXoweEEzenRM?=
 =?utf-8?B?bjh1THFsR1pFOFlYSEFJRVgyNHdkWWFmR3VBS3pQaFpBKzh5bjJwcTAwVSsw?=
 =?utf-8?B?QjhLb2FUQlBJbFhVL2RhMmI1VEpZQkppRTVobkxjUTZBMnhVQnBPQ3Y2dEFV?=
 =?utf-8?B?c3k1M3pmUlJzVGhUVzgvYllFbjlTOStVNFZTNER4bUJIakkxRVI2T05GUDV4?=
 =?utf-8?B?YzhqaUVmajR1c1RyUWVodStYckphYzFhOHBnaC9iUXdaVVhpTjN5cEpjcXgz?=
 =?utf-8?B?OTZPRUJPNjVuc0xpY2F1bUlwOS9FdjcycjBsS1M5UUY0TUQ2M3hqRzh2amNC?=
 =?utf-8?B?QnhydTk1cG0zR053bXozTWZjWEViamZHdkZaL0ZVd00rUW9veUtHQkhuTlha?=
 =?utf-8?B?c1ptNFZ4K2o1RjJKL3E0OTFtODNTV3pPREFzRjdVbTYvZnZlcUJ5Um5lZHRZ?=
 =?utf-8?B?cEhZMnBQaHhGbnJKZ3R5Y3NuN2luZ3B1ZVhBMkJIRUVHRmZhYllSaDJpRFJG?=
 =?utf-8?B?eEtlcU5US2ZVZWkweFovTzdlaC9nWll4R1Y3NFJiaHRKdEZjN2p6SFZseU9X?=
 =?utf-8?B?a3pXUFd2S21EeVBIenhBOE5uS0xDRTVpNlcwc1F1OEs1M1QwQ3gyNVk2NmVx?=
 =?utf-8?B?dFk5eVBia1ZoRWFWT2NvZ25SS2tkd1RPdkJsY3lUL0Y0VzJjQXVhSlV0QTRp?=
 =?utf-8?B?NUVvaVlwb3drcG5rTGhOY0diTXBmV0U5VzA5N2syakcxY2RZcksyTmpaRmoz?=
 =?utf-8?B?M0I0T0tLS0Vvb1NRV2lURkVFemFTK2ZscFJMbTJuaFJUL2E4bWR3cktPUDc4?=
 =?utf-8?B?d2xTS2xvMzcrb3VKVW9GcXg3Y3VKL3NrVFIyZi9LODgvTGVLYWJBMU96YVdz?=
 =?utf-8?B?Q240NmVCYUdObnhWak1mMXZIeFpOMDY5SmtEMXE2STRnL1RDWXg4MFNFR1F2?=
 =?utf-8?B?RkhPNm9GdFdDL2NHTWpwYnV5MUU4Mko2RXlHZVVqTWhKeW5hUWxpMkVQQTR2?=
 =?utf-8?B?RHhnNWxXTVJDNWloUis5V25kQTJvNGNHMFlmZUtYL29CN011a2NOL3E1NmtJ?=
 =?utf-8?B?dHZNcmpLQ29QYklHVnh3cStNSHEvcklnanVKUDZDTThYK1RPY01MVU9ESmR5?=
 =?utf-8?B?R0hOZjQwbjlzaFdNWHVQdFlwOXpyT2dwODk2K0JOQ2UwenFrNVU1c2MwdSsv?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac91ba9-b9ac-45b1-9231-08ddf58f24c8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 02:08:50.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRuUowS038zYoJFS0BFSy00tO/1ha/CoXBsXaoCaXMnHPtsMYRYqbqnpsVaMyvb/AuUJ9W42Tmyj5RjclyLsH0iZWJnKA/F51oLthnykEd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8185
X-Proofpoint-GUID: SPIg88K1fM3or1noji2bg1FxHXvEc-2X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDAxOSBTYWx0ZWRfX9EqaNEQ1954w
 310T5qLtzoAeS0ajuEfs4kD0SyNYy+5EXAjhXk4qFMrGE3IxhW39Zb+nBuAgwxb/lWO10MceqHy
 ulQTywyV0kkl/LEK8R9oL9K+aRqFJ8k/OWXPqDBBXtlFT7+jQd3UuXOhCBOL1Mk1/BsQ5BzQxWn
 DpxkFZyzq2mwu2lWV1XvZuSRGSywG9rFE4kFwwDY9dITAxCpwfqEyp/sU62iYoRnPM69C2qHkm1
 6URrFc5/RB3XMEI7ihhKl2wKuIeKkftZYZIx//l6qeA02ABl6mYyrYCzEmy/PRVGWXKCW3y6ozm
 GpU7f6CRjpBf8SfjHqhv5+DWpWKPWMRM25jLHGooiFlAeDiV/heK8Fr+MqGt+Q=
X-Authority-Analysis: v=2.4 cv=WvsrMcfv c=1 sm=1 tr=0 ts=68ca1836 cx=c_pps
 a=LawZwnZ+dX5EiMlPDlYRuw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8
 a=iGHA9ds3AAAA:8 a=pGLkceISAAAA:8 a=VtfK8tnSK1RsHKa6bQQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: SPIg88K1fM3or1noji2bg1FxHXvEc-2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 58H0wPOk261559
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 02:08:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2202

On 9/15/25 21:01, Martin Jansa wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> ping2
>
> On Mon, Aug 18, 2025 at 4:38=E2=80=AFPM Martin Jansa via
> lists.yoctoproject.org <martin.jansa=3Dgmail.com@lists.yoctoproject.org=
>
> wrote:
>> From: Martin Jansa <martin.jansa@gmail.com>

I force update git repo to correct the author, no change on content,=20
just commit message and author updates

//Hongxu

>> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
>> ---
>>   recipes-devtools/bazel/bazel-native_6.0.0.bb  |  1 +
>>   .../bazel/files/include_stdint.patch          | 28 +++++++++++++++++=
++
>>   2 files changed, 29 insertions(+)
>>   create mode 100644 recipes-devtools/bazel/files/include_stdint.patch
>>
>> diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-de=
vtools/bazel/bazel-native_6.0.0.bb
>> index 19b411b..a0daa3b 100644
>> --- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
>> +++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
>> @@ -12,6 +12,7 @@ SRC_URI =3D "https://github.com/bazelbuild/bazel/rel=
eases/download/${PV}/bazel-${P
>>              file://0001-cutsomize-native-toolchains-for-Yocto.patch \
>>              file://0001-fix-compile-failure-on-gcc-13.patch \
>>              file://1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch \
>> +           file://include_stdint.patch \
>>   "
>>
>>   inherit python3native
>> diff --git a/recipes-devtools/bazel/files/include_stdint.patch b/recip=
es-devtools/bazel/files/include_stdint.patch
>> new file mode 100644
>> index 0000000..35c57c2
>> --- /dev/null
>> +++ b/recipes-devtools/bazel/files/include_stdint.patch
>> @@ -0,0 +1,28 @@
>> +https://github.com/lihaohong6/COPR/blob/bf48c5450a909cf8358e3cbd81cdd=
e26df426e12/bazel7/include_stdint.patch
>> +
>> +Upstream-Status: Submitted [https://github.com/bazelbuild/bazel/issue=
s/25514]
>> +
>> +diff --git a/src/main/cpp/archive_utils.h b/src/main/cpp/archive_util=
s.h
>> +index 18856ab..5298a36 100644
>> +--- a/src/main/cpp/archive_utils.h
>> ++++ b/src/main/cpp/archive_utils.h
>> +@@ -15,6 +15,7 @@
>> + #ifndef BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
>> + #define BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
>> +
>> ++#include <cstdint>
>> + #include <string>
>> + #include <vector>
>> +
>> +diff --git a/src/main/cpp/util/logging.h b/src/main/cpp/util/logging.=
h
>> +index b2cd459..7bf5a00 100644
>> +--- a/src/main/cpp/util/logging.h
>> ++++ b/src/main/cpp/util/logging.h
>> +@@ -14,6 +14,7 @@
>> + #ifndef BAZEL_SRC_MAIN_CPP_LOGGING_H_
>> + #define BAZEL_SRC_MAIN_CPP_LOGGING_H_
>> +
>> ++#include <cstdint>
>> + #include <memory>
>> + #include <sstream>
>> + #include <string>
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#2035): https://lists.yoctoproject.org/g/yocto-patc=
hes/message/2035
>> Mute This Topic: https://lists.yoctoproject.org/mt/114764168/3617156
>> Group Owner: yocto-patches+owner@lists.yoctoproject.org
>> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338=
8836/3617156/66960823/xyzzy [martin.jansa@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>


