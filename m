Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F754FF885A
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 03:17:02 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3886.1777432611287634722
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Apr 2026 20:16:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=WAtnpYOS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95795ebc5b=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T2qZZt1339736;
	Wed, 29 Apr 2026 03:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wehFiPOhZ1SJNFhPEGymjVHVv3m27wnzk6r+N/3aARo=; b=
	WAtnpYOSEFl7fwf9i/YOLGZ/WhRAaz6XFDOJGJ94bhMgGWUUVNkoRxTH9SAwk9T1
	3lHtnLkU6y2iwV88C2+NLS+CX/YLPGg4afCpYJ8XYTr3Y+t60ptShJYg3RastHK6
	KI+/C3bGCM3fy2DwEHAq2TrER2GIhR6Hp570m3prDosehsjhTdr7fEHetRd/R6+0
	qu7awCVP9WMfoNrvsfyMO3gOvTTeAb0mFlcqEQpERyXq3X1252kA+IsTAadWCzho
	uszPtoqKZylDhnmyD8ubg7QimfpxH5/VEomzsH5Vqfz/GBPdB323/GWLxVN72esx
	jkTjyEGM/H2ePNkqa9R1og==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drmk6vcj0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 03:16:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGQwMUEkkCfZN+GSBAmUFGmnsY/f/oorFzxXMMgjF7L+MX0coYmy873knGpBDuPXsPjd5EFAuku0Ck/h3Iu0Lhe18HB2gAxUG+sL1CSaXMGM69SyBjQRiJoSj96InnsbH05gnRY8OKMhzoPo11S1D1qZyJ9/a8GpAHR2rbejbMoJfdH3MDQfbTffxlfswwkzz6dF4e0BpUsE2SncJe48+sUsaasuFjqdbJRo6ReXJkg4FJSLrjQ+Yva3tHwVz1pWRKreyY3U9sZOKS/nHiVAKvYNgfjop0fW3J5SOK951JGXOEL8dFOmFza1cGPaKZSvyHyg+B9ZKVRkWLbPUeGgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wehFiPOhZ1SJNFhPEGymjVHVv3m27wnzk6r+N/3aARo=;
 b=Yb7jbzp2IY064jkPqozKgoruE16NvHas0dsuVGhRgT3oFup+dHzSkdjnU3eiAuOa9LjqLOED8fIkFgDxyRohpCgPfuN2eWMgm4HCKJk86Bdsi1KAP/QHPTuVu6OjXN93RzAp7M794mYes3dwDEv1i83djicHj/bEhStycFaRSolNy3Ko00NsFVpqR3Kmj7Ca0jWsz3Qn/bQV+MzWQOtSLcRWuahxIP6g6473YQh3w43g7V4XjLgQDaksCnJXGGXscO9FaruA3p2AurV+dgO7Rx0NueyCZKyGUYE4u4KOpI6JeNnmq0v0mcxgexRhm5zVcvUaN+GrehUu4GEPQSw38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS7PR11MB6080.namprd11.prod.outlook.com (2603:10b6:8:84::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.18; Wed, 29 Apr 2026 03:16:46 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 03:16:45 +0000
Message-ID: <4bc66585-9948-4ae9-bbf6-3f4e0db49dc5@windriver.com>
Date: Wed, 29 Apr 2026 11:16:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [auh][PATCH 2/3] modules/steps.py: refactor
 compile() to use parallel per-machine builds
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: "yocto-patches@lists.yoctoproject.org"
 <yocto-patches@lists.yoctoproject.org>,
        "MacLeod, Randy" <Randy.MacLeod@windriver.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20260414053202.3869771-1-Qi.Chen@windriver.com>
 <20260414053202.3869771-2-Qi.Chen@windriver.com>
 <CANNYZj9PmjiMDbz6jknMrYubDx=xk5cW2KeGJXVyHCNbFhkpAw@mail.gmail.com>
 <de8caefe20ca7301a8f104e8d9751ffd8ca50e38.camel@linuxfoundation.org>
 <CANNYZj-r9mM0sOHT+cMF2WK6x-odOT-CTRcwbg4b5xVSf2yVuQ@mail.gmail.com>
 <38fc4650-148c-40aa-81e8-3459b380387b@windriver.com>
 <CANNYZj8dwq7RR0Z14rkrSR8rznCQ9=4=E0XxOGsbXLUOaxbphQ@mail.gmail.com>
 <CO6PR11MB5602A0CB35F09BE577F33A28ED372@CO6PR11MB5602.namprd11.prod.outlook.com>
 <CANNYZj_Sy-W6c=B154jsiuP7H3qmmeag=Qc8NnbP6j979T8K3g@mail.gmail.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CANNYZj_Sy-W6c=B154jsiuP7H3qmmeag=Qc8NnbP6j979T8K3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SE2P216CA0206.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::11) To PH0PR11MB5611.namprd11.prod.outlook.com
 (2603:10b6:510:ed::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS7PR11MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 439cc734-3a6f-430b-551e-08dea59dbc21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	oJ2KhOPjbboLK8b7KORt0+5MB4dHXtB+4gRYHJjN38H+Inq2NHN5rDBMDm/0eJ3HJMQkfgEmzNJN06v32XJK+v2pIoHuV4+9W95uqEEUS1YFitgDs0nAxc5mA97mPuzGFBl0wQFrz8wZj5hQQBFD+sk9IoyFyoZGO6b41u1F1HlZTMgRLbyN7qunxTRulPg/FBnJc8g+MNz+GjVv4P9JDB2mj0r/6J3R1KKLLWz0hhgOKEoCqwjmo2+glNC9fDYQ0CcRriVlkPm4gPfu9Ts0zcGCo3hOTfNqs/xVW87zKpa+G/pyJYtvbCt1AsTyZPRccXzPWk4EtV33n3pXu8TabeyBQL/6JhU7vYEOL0dLEXVd+70G4lnwjX+gksxX7hM0nh3/iwZlRViXeSJhQKnjqRaj3sJo8GvLnXvYORqs1f9bog9ZcGYIlpCOIHwA8UURJDlMk22QMl/Zz1bR6vh6j8jVjCw0mjZtgsxt/I+ImEqJ/8swdwceH8yMobIzsVRFzLPe9i5wELdvRrrxiaPD3p8GTq5GKoL6w4ePazCrM5m71SBpQFWbWQ0pFVNhQmjHWjv1yEA8o/uvLIp4bJA9PhRP3qIdKidRKD6txtz8Mf3pogFDKQk3D1ilFMwmTv4lj/jv2TzpO7o6dQo0uW9a3r6CykyyWLExwpqxrYU7V2AYffHuEldPSPPPHLkQ0lOs31c8hIYF+E0HBUgc/S2CIztuf1zjs3YMasl9tDGnIe0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGVXUDdjTjU1MGJvU3pyUDU5dlpXRWdHWm14bkFNQjhwempNMWpjblNQWHZa?=
 =?utf-8?B?a3lJZHNFWEMxTWxxWjlQTjVsTy9vc1JiVTl0SExCemZibGZKeXJWMnpZSzZi?=
 =?utf-8?B?WnlzcTJwUXNWMllIak5POThGN0JUcm1ReWhpUGZaVnlXWDdIV0RnTGtEVXlK?=
 =?utf-8?B?K3lqeDRIOEdRSWFqREV5SVlYbk1Oa1R0dlJGQ1RGSFZPTHJWVDhPaDc3VUNy?=
 =?utf-8?B?RlVlODJKemFmczkxdVI0Q3pFakZqak1kcWVkT21yUFd2MEpBYWZUYXZwNTFU?=
 =?utf-8?B?ZnpTc1JOLzJRemdDQVpRVjZGU2oxVmhyY3BNdDRGYUIvdURKcVZuei8xdjNT?=
 =?utf-8?B?VjdpVytEZHRMTEEvbWJZaEg4QXExV004M3NWRGh2Z1o4NkpJa0xQdHVaNkpL?=
 =?utf-8?B?aEFXVDRHUkJYSzNXQ3dHaTNUSzlWWXAyZC9Jc0xLdGljWURESlBmVE1vZVlw?=
 =?utf-8?B?WlRhRHRON1M4QUdsaUF1VVgrVXBmd2JDTWdZc2NBUHdsTVZ4NVZrT3NoQndJ?=
 =?utf-8?B?dTE4YUwxT2JiQWZ0WCtFZnp1QUhSSGo0NEF6SCtmR2k3Z0EyVzdGNEJTVmpE?=
 =?utf-8?B?RmQrVGpJVGx5T0IxTDQzVE1DNEN0eGl5b1c0LzBQdXI3VGNqNjZyNi9VMVE5?=
 =?utf-8?B?L3V5OFVxbWgrOHZCM0NWa2VMZ1FyMWFjT1oycmNQMGRtNVZmVFRtTnA2NEVM?=
 =?utf-8?B?c3NCZCtJWmxPUWxMOGNrWUVSMWkxTEVPTngyclRYalVHblZ0Nk03OHdEWEs5?=
 =?utf-8?B?cGpZNkxZT2QreEVBeXVIOEYvUE9jUnpPUUh2QWFQYkl5eW1zaXhhU3E0WTBO?=
 =?utf-8?B?V1JrcTkvWGRHZUhJZ0lUQ3JxZWhpd0JqZ043WHpwbmtvZ1QxMWlJbmtpNS9u?=
 =?utf-8?B?ay93clZMTUF3V0lmcnVXUVZIRmdERmNXaXRGZ3MyalJPZUdnR3c0SjVnZUxw?=
 =?utf-8?B?c3UvQzdVRXRTckFLaUo1TExEMVZVTjFISVhLclFUYjJ4U0dJeHUzK0VSRzBv?=
 =?utf-8?B?NTJlU2FVNGhUNW5PQm91SHRKSllvalhMQkR0UXJvdnM1MlNxbXVMTVhFcnpp?=
 =?utf-8?B?TEtpMHNpb29oOGVhclYzblpKUHhraGRzYk8rU2ZzZFRYRmUvOWhMbmVzYWFp?=
 =?utf-8?B?L3R0TUk5M1luS1lzKzg2eVV3TEJkeWJWNTdCRXlKZlU0L0dPNXdoY2xQYW5t?=
 =?utf-8?B?aDl1eHBYdEhpajcyN1BMZ0VEVDk5R1JNN0ExbUx6d25CU0VNWThZaVdPdk1s?=
 =?utf-8?B?eG9VY2RuZnpZZWlWZnZFbHNKeGZmVFQvVGlrZkFWTnFPZFptaHljL0RjbDEv?=
 =?utf-8?B?ZHZKVmR5QWpxRDdQSXRwNnp3WkNIREFEZmRMdU9YalYzZEgzbXJXVllpSkZ2?=
 =?utf-8?B?dGZmNmZGSG9BQzRweFhTKzlTbDZneklCNzZ0OTkrOEtSQmwxRFFDZmJPY3p4?=
 =?utf-8?B?bXhLQ3hNajR5NGlsL1MyQmJyWEdFSzUzQXRyaVVjUDAvVFprN0RybVZBSHBi?=
 =?utf-8?B?dTJoRVlnUlFsVmpCYS85cGRaN2ZBb0FudUpwNk1TYU1zRUIyK014TW1RcW9k?=
 =?utf-8?B?aEtUQlRlZzRHYitrekVoVzA5bXg4ZjNxNTdxb1MvOC9tdUJ2Z0NGZG5aK0Zn?=
 =?utf-8?B?a2hyQ1dPQ0tVcFowSlpUR2tYUHdHWHNhaW1VaVNueWxvZ2VsMTZZQ25RYXZw?=
 =?utf-8?B?WXJDNjdBMnVHa1ZDSUJld0tEOTRNSnoxQ2NYSytHYTl2Tk9ZZkNaOW1oOS93?=
 =?utf-8?B?ekFsU2poTHg3VnNwU3Z2YjRyOU5udFNQamFvM0dwSlZyZ1JHcnZ0MkRkcW01?=
 =?utf-8?B?NVVmWEhvclF6SHg0eDFRbnlERUVuOVVyd2NPd3lEQWdFUGdYajM0eDVWNHNN?=
 =?utf-8?B?aWpUVnZtNk9GNXhTVTZEUjBWREJSMm9QYWt0dnVMM1hiQW5PRU5WT0FGblNq?=
 =?utf-8?B?MW5ub29oVHNTdjIvcVBSajR0NW9wdGY1U2JiVnRBTnRNeG9iRDltanY0bkZs?=
 =?utf-8?B?NEQ3SldZb1g0ZzZmQTdkdXdqTmhhaUp3OU5VMWRncmdmODc2QmFqYUZQemtR?=
 =?utf-8?B?Z2ZKZi9ZVjFvTWNRRHFjMDBIY1RKR0FVayt3ZG9WQUdZRktwWTFzQllId2RT?=
 =?utf-8?B?eVljTC9zYUhobUwwNjdwUFJFdU9LNk01MjFvSDdSNXJENENCSEtxUlpUcnVa?=
 =?utf-8?B?R1l2OFYwMmxpWXZ2MXB6SnRuTDBvbFlQMEQ0NXY5QW8xbXlHa3dPSFoxZkwv?=
 =?utf-8?B?MmVYNnVPSFZlY2lvdGd2cm02Z29lbDNhUlVSN3Bvam5SR3BzSVR2MmV0WW9Q?=
 =?utf-8?B?RFNmOFZIT2R1K3lZY3dzRmlRaDJxNS9xa1BaL2lENlFhUXFXTHdPdz09?=
X-Exchange-RoutingPolicyChecked: 
	HWRczFEj985+Wb+VGKGJJaeKXA1OQnIwQ2ROhZZy5uMv0P5AZlGqra6p7erOOA2Z57iLPCQ88e75V+WX/+t6whswVCxHQibGvqOCUVI45/FOpqmG/F5gWknD8goa2yLCogD5PkXdd/bD6FuG/XI9zfk5EpgjLzQuz6xNU2azapLz0fq5R3bBeGnWh/aUui1F/w79PsWKSpDi2RoESeiXwn3T023oBNGwCmSbdKz8WuTpr5dm2E3kmgo1JH/AtFZdk6dZCCzwuXQCw3Ak4FVdWtgLwtJWN+TDy1LZWJwkkASJjl8CdMCwMwzjPH8USUxOmGq56O4950VE4AAHWSeTxg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439cc734-3a6f-430b-551e-08dea59dbc21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 03:16:45.2610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1Dss1CLwSKz6Eaaj9aze8bx1IAZISov81+u009i8ZN16ukmNuJugwApJ2kNcsio//ghc+ArTX9XtDBiVtc+hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6080
X-Proofpoint-ORIG-GUID: AdK33vA_NxBW6I0K3iFEDT1GYAvFIZ1I
X-Proofpoint-GUID: AdK33vA_NxBW6I0K3iFEDT1GYAvFIZ1I
X-Authority-Analysis: v=2.4 cv=RN6D2Yi+ c=1 sm=1 tr=0 ts=69f17820 cx=c_pps
 a=CM6yQ3ajfX3ct242QRRZiw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8 a=iGHA9ds3AAAA:8 a=zYTZNbrlCMcdnbHcaD8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyOCBTYWx0ZWRfX6452u7xAKUBR
 81/zpnGzfHawYFEJtOxrvQc/3TSJ7Fz4FsMqdTIEFy6vctqQmUVAG6onxDwONUjrDTgkf2VIHmb
 jeOrZo+B/BEQyxMU1YghQqd8wU/j3U43BfodHfJ/u7L2Q8zUYYMqK3m4WvwZjQhRJRmxJ107CXR
 azX6j3YSILFST/4luy5hmlpgdU2THFYmNYm+Yy6jcMYLewKWcMrpjydmHp2q0UpE8SG6EkxFObM
 IZXZM1itvO6eGh2Hy/Qqv45uHXaoOsqgEU0iox6+HvyvAUeY1UfeShglUHYKZvO0FF1nA9qpzC4
 dKepjPVEsBEvR2F6JkjDNhMBY6+ytABXQAuliq97NvxgPHyhBJz/CqvXATGTLAo6nrQz8yJgmR8
 EGJ5Z/oMFBLFYtHvf+dxRWMvX8uTWRXxhdyTJXSRgNYWhtvkbtH8FAzSseOiLxNh8hcyauxoP5E
 D47+p967pv7dbJqvUxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290028
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 63T2qZZt1339736
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 03:17:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3872

Hi Alex,

See comments inline.

On 4/28/26 19:39, Alexander Kanavin wrote:
> Hello Qi,
>
> thanks for the detailed answer. I fully agree those would be useful
> improvements, my concern is that AUH right now is a very shaky
> foundation for doing them. Specifically:
>
> 1. No test suite. This is becoming a real problem, as I struggle to
> have confidence in non-trivial patches, and especially when they add
> new features instead of refactoring code. This code can and does break
> easily, as the amount of corner cases is particularly large. If I take
> this patch, you'll expect me to take more patches that add even more
> code, while still not having any way to test them.
>
> This could be addressed by having 'mock' versions of bitbake and
> devtool in the test suite. The 'mock' versions would print things that
> AUH expects, both in 'success' and 'fail' scenarios, and maybe write
> out 'upgraded' recipes, but otherwise do nothing. That way, all or
> most code paths in AUH would be exercised, without having to run a
> 'real' upgrade, which is heavy, takes forever, and not really suitable
> for testing changes.
>
> 2. Which brings me to the other issue, and it probably should be
> addressed first: the brittle interface with devtool and bitbake. AUH
> makes decisions based on finding strings in human readable output of
> these tools. This isn't great. One way to address that is to move at
> least the upgrade/finish/build/test/commit loop into a new devtool
> plugin, so that it would use devtool libraries directly, and interface
> with bitbake via tinfoil. Then AUH's job would be simply to determine
> what needs to be updated, call devtool with appropriate command line
> arguments (or maybe json config with the 'upgrade job' specification)
> and to make reports/emails from resulting patches and logs.

I believe this is the correct path.

This will also address the above testsuite concern. When the major=20
functionalities are in devtool/bitbake, things can be reliably tested by=20
oeqa.

>
> Once we have these things, adding more features becomes a lot more
> sustainable. I understand such a refactor is non-trivial, but equally
> AUH as it is can't take much more extensions.
I agree. When reading source codes of AUH, I found that it was designed=20
to be a simple tool. It mainly relies on=20
oe.recipeutils.get_recipe_upgrade_status and 'devtool upgrade/finish' to=20
do the job. It even does not use tinfoil and specially uses=20
layer_mode/layer_dir. If AUH can use tinfoil, it really does not need=20
layer_mode/layer_dir design, as it can easily know where the recipe is.=20
I'm not sure if this is a deliberate design, but in practice, this=20
turned out to be a robust implementation.
>
> I also have a side question: when you say "Upgrade recipes (stable
> version upgrades only) ", how do you determine the stable versions?
> There's an ongoing discussion about this with some patches; figuring
> out what the stable versions are isn't trivial.
>
> Alex

I modified recipeutils.py and bitbake fetchers to add an optional=20
parameter to them.

e.g.,
recipesutils:
-def get_recipe_upgrade_status(recipes=3DNone):
+def get_recipe_upgrade_status(recipes=3DNone, same_major_version=3DFalse=
):

bitbake fetchers:
-=C2=A0 =C2=A0 def latest_versionstring(self, ud, d):
+=C2=A0 =C2=A0 def latest_versionstring(self, ud, d, major_version=3DNone=
)

I used this method because, as I said above, I found AUH is a simple=20
tool, and the major functionalities should remain in devtool/bitbake.

With the changes in recipeutils and bitbake, what AUH needs is just to=20
pass same_major_version=3DTrue to=20
the=C2=A0oe.recipeutils.get_recipe_upgrade_status call when it gets some=20
option (I used --lts locally).

My initial plan was to send out these patches after at least two local=20
runs, so that I can see in advance if anything's not working.

My first round of the AUH stable upgrades was finished about two weeks=20
ago, things were working pretty well. The second round was scheduled to=20
happen around 5/20.

Now I know that there's an on-going discussion. I'll send out these=20
bitbake/recipeutils patches as RFC for more discussion.

Regards,
Qi

>
>
> On Tue, 28 Apr 2026 at 05:34, Chen, Qi <Qi.Chen@windriver.com> wrote:
>> Hi Alex,
>>
>> I totally agree with you that "It's far more likely that an update bui=
lds fine by itself, but breaks something not covered by AUH recipe builds=
".
>>
>> Let me first share my local practice and then share my thoughts on AUH=
 improvements.
>>
>> Here's my local practice for LTS releases:
>> Upgrade recipes (stable version upgrades only) for each layer using AU=
H (parallel build enabled) + manually checking the upgrade results + worl=
d build
>>
>> I'm using world build instead of some extra build tests for each upgra=
de because I'm upgrading quite a few recipes in multiple layers, the upgr=
ades are stable upgrades and the server is powerful enough to finish a wo=
rld build in a few hours.
>>
>> What I have in mind for AUH improvement for oe-core master is that, ap=
art from this parallel change, we can also add some other changes to AUH =
so that it can be more efficient and save developers time.
>>
>> 1. A new step, compile_direct_dependents, could be added after the com=
pile step.
>> What this step does it building recipes that depend directly on the re=
cipe that  was just upgraded. The can be got by using 'bitbake -g world' =
+ some filtering.
>> This step can be enabled by default, but could be also be skipped by s=
ettings. When enabled, it only builds those recipes for the first machine.
>>
>> 2. The machines settings could be extended to include fragements
>> e.g.,
>> machines =3D qemux86-64:core/yocto-autobuilder/multilib-x86-lib32 qemu=
arm64_musl:some-fragment-to-enable-debug-build ....
>> In this way, we're giving AUH more build coverage.
>>
>> With the above improvements finished, a successful AUH upgrade in oe-c=
ore means:
>> 1) it builds successfully for all specified machines and configuration=
s
>> 2) all recipes that directly depend on it build successfully
>> 3) testimage passes (which means if it has ptest, its ptest passes)
>>
>> When the emails are sent out, the maintainers really do not have much =
to do with a successful upgrade. The maintainer just reviews the changes,=
 correct license if there's some license change, put some commit log and =
send out the patch which is a sign of commitment to fix any further probl=
ems. When the AUH upgrade fails, the maintainer can also easily  see what=
 the problem is and how to reproduce it.
>>
>> What do you think about this?
>>
>> Regards,
>> Qi
>>
>>
>> -----Original Message-----
>> From: Alexander Kanavin <alex.kanavin@gmail.com>
>> Sent: Monday, April 27, 2026 4:55 PM
>> To: Chen, Qi <Qi.Chen@windriver.com>
>> Cc: yocto-patches@lists.yoctoproject.org; MacLeod, Randy <Randy.MacLeo=
d@windriver.com>
>> Subject: Re: [yocto-patches] [auh][PATCH 2/3] modules/steps.py: refact=
or compile() to use parallel per-machine builds
>>
>> On Mon, 27 Apr 2026 at 04:09, ChenQi <Qi.Chen@windriver.com> wrote:
>>
>>> With this parallel build added, Yocto can configure oe-core's upgrade
>>> to use machines that oe-core uses as the acceptance criteria. This
>>> means a successful auh upgrade will very like to be merged without an=
y change.
>>> If there is some failure, e.g., qemuarm64_musl, the
>>> developers/maintainers can see it directly without doing more local b=
uilds.
>> For the purpose of updating oe-core, I feel a bit different about bene=
fits of adding more machines actually. I think it's unlikely that adding =
more entries to the two existing ones (qemux86_64 and
>> qemuarm_musl) will help uncover more issues - if 32 bit and musl varia=
nts are already covered between these two, then it's unlikely there will =
a particular 32 bit x86 issue, or 64 bit arm issue, or a risc-v issue, e.=
g. something that those additional machines would catch.
>>
>> It's far more likely that an update builds fine by itself, but breaks =
something not covered by AUH recipe builds, e.g. a dependent recipe, ptes=
ts, oe-selftest, or runtime behavior. Such things are unrealistic to test=
 for each update, and so they're done after the fact, in a-full.
>>
>> I agree that speeding up AUH would be beneficial, but that is better d=
one in the outermoost loop, which takes recipe groups and updates them on=
e by one. Parallelizing that is more complicated, as each update operatio=
n would need its own copy of oe-core repo in addition to its own build di=
rectory, but it would really run everything in parallel, including devtoo=
l upgrade (which can be very sluggish on large source trees or large comm=
it histories), buildhistory, and test builds. And of course, lack of AUH =
tests hinders such large refactor efforts as well.
>>
>> Alex



