Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F29E7317E
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 01:39:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7311.1770082755896673837
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Feb 2026 17:39:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=XlKm0aK3;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=649472aa1a=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6123obRY2673194;
	Mon, 2 Feb 2026 17:39:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Wc6KpPmoEARBCa6oMYRDyLo7polce48iLsrQjkJXX2Q=; b=
	XlKm0aK35bmUA4YksjJ+0AtPun6ROAJyaeFZesF89bg36CwwYlAfZCHwTnzUpjdS
	uWEnV9pyJJZTt29uR5cD3rFr/+wNi/VhcL6v8j6ycz2LdmZKdHUgC2VEfnLOO9o/
	Uhkt1NtYy+lzG4utKe91bvSI8jOCgiHORZVBlxxE6R/3D6l43nj8BhKW1a7j633T
	++9Y0w5FeDxjUjay22d9fVaKV6SxJm3lhZFcHQ+l++Un7KsRg4F1jUIiXMBsuSuk
	w6jfXCCNcwY2BD35EMRSVCVQWXFjRBlVsFNCxBFad+8DegGf6HTdH76zX1dmHl08
	Hb0bvEYfAsJX+Xl6arKr+g==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c1dw0tkfe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 17:39:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+m7MJ7lFyZ4LzcVS3hjBCf/MOFoBWekjoGl0Rly26dN5dyInG6bjKhBFmvLljh0lzQTQtiir1zociaplqUx36Jg4M43b+hPYhZSAW/khntPpOKwxJOLPnlW6p0HQ7/FYptqyMuIOQ9QTem7Jn9IbUtqdP7DUgpOEMkReFb1a98As0bof7Eai3BTiq6WKYB9F8ek4xXTVt8ctdKfZLWSRKj4EjuhCd97Rpz55hOcXribc5avdJu9KCHW4JLzwfj4x1JyUt8MxMqrH+H/dSwx+ksO7i8nnAXi135O3AIOHpghtWC2oTxXDn7hgA410aOPQyVSwZo0thZTRAnjyTSFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc6KpPmoEARBCa6oMYRDyLo7polce48iLsrQjkJXX2Q=;
 b=GJ4lGW7dUNW1G5qJWbhBdoUICGWzytY5Js4PYqwMb7MQ+HSHHq+XbZiCKrAKitj3RkPn+Wu6+wgR+X/N4dskqGwtKiHRUQyhMHhsmV+Vh5Ns6nuJSTHwMZYYrGiNKZ6By0p24rb8a/XZMBvZC2LmQo3C9UWv6v3dHdgbMIugBB4NDaUcwr7ziE6eI2UoDQy2a4p1CHutMbOutuhtjhN3Grn14UKBtzR7edvznt9uZOLjCRb/PLU3sbsz0JErjh4KEq2EHDo5BoxkAs0BeIc16m3duj2OFLaUAmvFZB7Ef8dus8gdh0EpIFTiuc6isSG0Pc9mTNlyl3hzSvHz7u35cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by MW4PR11MB5797.namprd11.prod.outlook.com (2603:10b6:303:184::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:39:08 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:39:08 +0000
Message-ID: <993aa60e-46f9-4f31-8b8d-28a96d7fe651@windriver.com>
Date: Tue, 3 Feb 2026 09:39:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [Openembedded-architecture] Running Large
 Language Models Locally -- Contribute meta-ollama to Yocto
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Michael Halstead <mhalstead@linuxfoundation.org>,
        Khem Raj <raj.khem@gmail.com>,
        Alexander Kanavin <alex.kanavin@gmail.com>,
        openembedded-architecture
 <openembedded-architecture@lists.openembedded.org>,
        "Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>,
        Robert Yang <liezhi.yang@windriver.com>,
        Randy MacLeod <Randy.MacLeod@windriver.com>,
        Mark Asselstine <mark.asselstine@windriver.com>,
        "Holmberg, Tomas" <Tomas.Holmberg@windriver.com>,
        "Chen, Qi" <Qi.Chen@windriver.com>
References: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
 <20260202191704.GT11121@denix.org>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <20260202191704.GT11121@denix.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|MW4PR11MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f729a5-54a7-4543-2887-08de62c505e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|4022899009|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V0NraHduSCtFQk9XUDY3dG0rOE1zOHJ2bXVGM1RjTmtTQXRIdGROVVgxZjJp?=
 =?utf-8?B?ZVI4Mi92VzNCYnhhcG9wN2U1MXdoc1BoaVV6TktsaDZGYjZPdmJwdEFiOWx2?=
 =?utf-8?B?Nit2TFNnWktzYU1HRVJuQWdSU25IN0lXQ2tXMkQzVjdPTmxHOHkzSlM0UFlB?=
 =?utf-8?B?K2U0djAyLzBIVmE0TU8zS0VVVlB0aUFSYUl2QTVEc3dNRy9zcUplQUFkSEtk?=
 =?utf-8?B?WkxMSkNIV3NoLzNWaDJmKzlsMDkvZmJTMlozQk8xa2ZaVlpUMEtwUW9mYlRn?=
 =?utf-8?B?S1ArNktNVmJLNFRtMktRSytRMy9QbjdJellsa1lrME5OTyt5aTlHdm1WN0RX?=
 =?utf-8?B?UFZ2eU42dUE1NEF4SmFuY3V5Qk9uNmg1UTBrYUVqbDB6VVZLRHN1ODZEZjI1?=
 =?utf-8?B?YWVuYVlacWlnMGNUb2QrREZwekNheVVGU3RxaWd3dWE4NTRpbWxkWnBTNVRv?=
 =?utf-8?B?c3pESUJLdXNhZ3E4dHZyVEdtM1hDUkVwTGNMb2dsMHNGUlR2VHRQVjI0SW9w?=
 =?utf-8?B?Ym5YaU1RYjZzVWZEeTRRZmlRYjI1OXNvbnBmZmJEWFNORVFQRmpjOXZmaDFX?=
 =?utf-8?B?OVVvUDVuSC8zQU4zQTBvTTBxU1l4SUNNbVNhTFNXVTZLemErbEhuYmswcDB4?=
 =?utf-8?B?S1ZLZjZ1UnZEcVRia1Y5MklQa3lqMGpST0Jyc1o5Q2xmeFlBZTl1K3dtWC9K?=
 =?utf-8?B?OEwyYVpXS3hibDBkMjc5eEthdkk4UC9VM3QxNFUvUUlBUW5iaElseHpFYWJH?=
 =?utf-8?B?a3F3c0NKbWJLSTgrd21QK2xZUGxnc2JUbXo0RkhBU2dTbkJPdGhnL2tKSUVU?=
 =?utf-8?B?eXJvQ3RwTy9VSDJDVzIzK1IvK0J5NnJmb284czNjNzJpTk1SVTVCekt6RDVn?=
 =?utf-8?B?d28xdVBFbHRxb0Y0ZEJyck1lMStVVFM0aVBjNmxodHBYMUxLMy9TQlBXeTZC?=
 =?utf-8?B?OVFIcjFNSUQ1WkpWUUVlc1hYcWtwYWowbmtQaXZNRWhDdXc4SXoxRHVnMmpJ?=
 =?utf-8?B?b0pGSzFMTi8xVGJZQ3ZoaGRGaWZUd1JBdkc2SGhDRHRkd3dHNlM3V3pWRjJI?=
 =?utf-8?B?NlV5ME1mS1RUNGE0cnd2cVRidVpWcXFDdkRHTnZoUzh3QS8zS3lpc2lGeTRn?=
 =?utf-8?B?K1hrcmpPL1hSOXEyQXlpWHBhQjV0R1ZhWFRNTHJIaFdlYkNKSnZyclN4S3pI?=
 =?utf-8?B?c1ZsRTlza1lidTRFZVcxTlVQeWw3YnBxZG4rdjlkRDQwRGFjNFNKcjVJRjhv?=
 =?utf-8?B?ZkIrNm4wL24wTjZrWkI0TDc5WG1MQ1BpK0cwMVhIQ1RUcmVJWSsxSjNFN05S?=
 =?utf-8?B?U2psRzN3NG1TRXVVTWhCTUtrMFhzdlBKM0FyNU1uMzRTZXdjZnFGaDVOeGsw?=
 =?utf-8?B?MHRrRlVJU1dpUWdPbklDdWd1MHNBalJ1VnNHcDN6N0d2bmpWUVlIays3Z3Rl?=
 =?utf-8?B?dldOZFM5ZFdaVEZRTHhVYXFVVlJBNVhBemZmUXFXQk1qd0daZElsQ1VpSnZv?=
 =?utf-8?B?NWtGeFN2TTYvSWtCZnZQNWwyaDZkd0sxVTQzb1UrUEd3RGFrME11bFFTYVBq?=
 =?utf-8?B?c2loYXRIbXJ0U2F3clV6SWxJNHIrYzBKZldLSjBkNDdxMEpSVnVvMjhDT3Ni?=
 =?utf-8?B?d3M1N0ozKzNXT25mUVROc0RCZ2N4UmJPTS9ONEc0K1NlTnJJYmM5clpTSDN6?=
 =?utf-8?B?djFwbmxWakNDTFRiOWd6Qmh6S0Y3VWlUcldMTklPRzRYWER6dmN0OTJxdnFS?=
 =?utf-8?B?dmQ2L0NFNE4weXFCdmhIcmoxWkNqWUQ1L29IRUpUR3cza1ZZOGlCYlhwUzhr?=
 =?utf-8?B?NG4wQ2diOG5qL0YwZDdFZ3REcmlTMHJtcVhXV242MnZkSWRJS0o5bk1ZcTcx?=
 =?utf-8?B?L0FZcTdnMlkxY1ZxY2ErblBkd1FIbG5XOXA2Nm1yVWFDSDMxYkdJWHBVdlZG?=
 =?utf-8?B?cVBUMXZpQlVweDZuYmpYbXpZWGZCSU05dkE2RjB6WTFjT1FkQmpqZG94Y2hr?=
 =?utf-8?B?TTU3VWRwMHhpTlBDRmJ6LzA3U0w3OHNSdGRxM0kxT3NnS01nQ2FhNWI3NUJh?=
 =?utf-8?Q?qybjxS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4022899009)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NDB2WnhPeFJsNnZMSU8xK3h5RGVyTnlzZ3VtamtTMGFCL1k3N0JHZkdUbTdJ?=
 =?utf-8?B?bzdhUFRpRGc5NzEwR09GaU4zbkZoUUZ1TWZwQ1ZVWHFyVlZlY3M0aENGcUtV?=
 =?utf-8?B?cHhvelVHT2JYUHdpQU1aenRTQ2UrMWZvZnlSSmFFNXh2dE5rK1JRczdhSVJv?=
 =?utf-8?B?TzlWakJxdEVGSEdyYXB0aHFmK3d2Zno4dlBHYmZnTWFVQllyRFR3RC8vaEwr?=
 =?utf-8?B?T2J1Wi9tMEFMVDNUcmdrTlNMUzA4TThxTUI1SStmRElWMVBwY2NlcS9tTkRM?=
 =?utf-8?B?cWM3d0cyRXlTanZnTXJkMlh5Uk80V1RSbXU3aDhnVWQ4a2Jyd2EzSHorYlZl?=
 =?utf-8?B?VDFUNlpUU0pjYmMxYTBWbDhTMHFYUWsvdTZBTXNCV1NJRzcxY3lSV1QyU2hk?=
 =?utf-8?B?VStFT05VQlgzTnFHOWdIVDRCdGVQZ3NPbWVZNjlqc3BlaWJvc3B5TENEck11?=
 =?utf-8?B?ZEpESUxmUmp1QXJkYUJWbUNGQkFpSDVIVE9TU1VQNjZteTNqdDQyay9mYXdx?=
 =?utf-8?B?R3lQQm5kdGFkNE56Slc0Nm5qanJ1L0ZjZ1diZndxRDVmRWJmYk5FbHlLTmpP?=
 =?utf-8?B?OFI0bDJ3N2trbk5JTlVscEJHL3dqUS8xV0R6dUxoY0Z2OHlMODJOblBtNDBw?=
 =?utf-8?B?N0VubTlzeEMxNEJiSnlOaWRIRGdKTW81Rnh1NXlBQU4yM2V5V3VHT29yeDdl?=
 =?utf-8?B?UDJkb0luc2ErVUpHM0RKS3dSV3VLbHhUejZYeWdSTytZNm9IRHc4bFdMSHp3?=
 =?utf-8?B?N0VEVHVYYVRYWllIblVIdmRtYWJ6SFJ2UnA0U1ZZZGJpRW0rY0w3NnI5bGda?=
 =?utf-8?B?OFJGMiswdlduNU54SkRGblp1VHAzOG1ad3RHMzlpckJkM0VuWThsWU5QOEdV?=
 =?utf-8?B?UVJFb3MrMjNUZzUzMS9uQ0E3a0IzRno3cEdNOThWQWpMWElreXQ2TDdWRnlM?=
 =?utf-8?B?K0NGbE5xalhPbzNVUDA3UURKdFJrZE9wNFpNbjJ5N0k3YVZaMU14YnJxaVZ4?=
 =?utf-8?B?WTVlci9TRnhOV1FRUWRkeGhaQ0VUSC9vbFd5aFhaVndhanlQYXpERjltZTNN?=
 =?utf-8?B?ZVNhQjhOTm1sSGp5NGNhVGZXTXZ4bVVqa2dKZW1TaHZrSHZBSHZkY2JGRU9r?=
 =?utf-8?B?QmxzVkV0QllVNmtLZURLZndkWWc2d2NkSEFuZHZxd1luVWlzM3MzQmozUnFk?=
 =?utf-8?B?V3JhcmU1S3B0aVMwYUFwUENDVWVjRTJFV3JmNE1PcGl2d3ZuTEVzZ2dQYWI3?=
 =?utf-8?B?NUdqWHJWbC9jV1VsenNHa0x2cFJSbElLYm1QNW1SMTd1eUhkejc1VG1BaXlD?=
 =?utf-8?B?SW1FTnlsTXIyZGZqYllUbDNKY3lvN3Z5c2ttaURpa24xbklrWldSb1NtK1ZH?=
 =?utf-8?B?MTEwY3pWZU5pcXV5VE5YRjdvbFBGWm10REFlUXBkVUxyak13TVhMZFdEay9r?=
 =?utf-8?B?dGhhaW9UWjgvRTEyQjBMcEFRa1lGbm90a0drd2V2Q1plRVovS3ZiaVljYzhw?=
 =?utf-8?B?S2FJNUo1UWk5dlVUWXpTK0twOTdwMVA2U3JVY2daVDRvWE14aXFmZjYwVHdv?=
 =?utf-8?B?MXhWUDlVMExPbktIV0JlRWw5V2lFaHQzelVGcFZoRWdpbTlMVGhUNC83TlJH?=
 =?utf-8?B?QXR3blk3UUYvdlBRNjlVNUJLcWc2ZlNqcmt2N3NrWHB5NmViQmlib0tXVi92?=
 =?utf-8?B?Y2dxdGdjZFMxdWRIemk3TjhUODBiVk8zQmhiQkdkcFZLWUhqQUVxMnRFR3d2?=
 =?utf-8?B?bkw0L0l2eDE0Q2FWSWVXUURyNmFrekk3RG5PUnhLdCtmazRiWjBDTUxhM2tH?=
 =?utf-8?B?eWFZMEFHYnZqNzlTMDQ1QTcvL3dMMFdxWjVEb1k3R1VMTmRGcjBXditGdEtD?=
 =?utf-8?B?NkR2VXA1OHlOVGc0bHlwb0VOazB2NVU4RW13RC82cjF3RHNkR2x2V2FEVzdZ?=
 =?utf-8?B?R2NvU3FLSTYrUDVCTDV1KzJ1aDlYZWluTXF2OTNmb0xlMUdqT05BRUhZWjdD?=
 =?utf-8?B?cHVHTnVRVFIwVmJkUzFLTFpyZVg2eTIzQWNSUzFodUJ3WVdpV0ZIWkxmQjZz?=
 =?utf-8?B?K2hCNGNTM0w0dG41MzFjRFRiUEpUNFkrTUNYZURSVE9vSDZqaVVuVzFDVUV3?=
 =?utf-8?B?MlFvUlRmT2dkbTZVM2lMekhJdmdPemJhZ1VQV0pqS3c1OHdrc3QrMEsyUWRv?=
 =?utf-8?B?eXMvU1ExT2c0VVJhTWtQclA2a3FBajlYR3Npb0JhZDNwTENpTTVmb2taS1lZ?=
 =?utf-8?B?dERBb2R4bE5EMlByM2tIalkxOEJ1MVNML2RCK3VJWVh3MllkUmJTUWliRlFR?=
 =?utf-8?B?NDRtV0Vzd2lmVEZ3Z3k4cW51bkFrN0JORENlVnJJeVVGckNTMWNNdz09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f729a5-54a7-4543-2887-08de62c505e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:39:08.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgT3ZJIN9hW16U8xlCBRcSZoO9icCKHfoFIFdMmLIm9jGnXamO571W0aL2uRO89OEr05Lb6JFCN1nnDpgARn6e6KXOvNqB5iLnMi93Q2beM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5797
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ImVnP8Hwultge7zqOFe1jvL9uT_9LzKT
X-Proofpoint-ORIG-GUID: F-IuSQyGEEBHgVdNVVLYNUB-pwTcTgeN
X-Authority-Analysis: v=2.4 cv=Htd72kTS c=1 sm=1 tr=0 ts=698151bf cx=c_pps
 a=iNm6N7YJuWyXLwPauF+ZSw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=j0GEES8IAAAA:20 a=iGHA9ds3AAAA:8 a=Q4-j1AaZAAAA:8
 a=t7CeM3EgAAAA:8 a=ZQksEcIfAKEl85dfuqEA:9 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDAxMCBTYWx0ZWRfXxYUl91TzY3TU
 g52CcARZKa0VYwylEHf1KdnhurZ18FNqceet3x+YB7Er4fA58hOTFxuI6C6T/uWnfkE6/mog6aY
 nq93KozVkStQqfBKXfDM6crv1NU5KsUQQYmRP5FVzxQFbVz2mX4+S/Dw8WoW5qh/wFA9LAlhgFz
 b5T9XDxUDKN/GnUpc8J3xiC231AdotnkhOf98FbLsbdQywUi+fzUovpBahspCicnsartiaEfAep
 4AZ/klBvkfK/yGhRa/O42uzhdKTKna6u7ZekkxORyldZ19ZhztJnwRsJbGooU2TuYbl38KBtIOu
 zj7QTQqWRbO1Ofo3RQ7XPi8h6VAx4h7w5JO/C0p3V9fNxAq2+1k6Tk5/cyabIh6rYEwLjGhk0Jv
 6i3NLBR5EVN4krgHPdKrcV9ziIl3/tUsLekjGhDiTFWzjhhoIz4QIh9q5R97vMNSMc0ZgE/+M69
 ANt3PpgI1voa64ghomQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030010
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Feb 2026 01:39:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3172

On 2/3/26 03:17, Denys Dmytriyenko via lists.yoctoproject.org wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, Jan 30, 2026 at 01:20:42PM +0800, hongxu via lists.openembedded.org wrote:
>> Hi all,
>>
>> ChatGPT[1] has been popular for several years, perhaps you also know
>> Deepseek[2]
>> which is an open-source language model and run locally.
>>
>> The local runner to run Deepseek is Ollama[3]. It lets you download and run
>> large language models (LLMs) on your own machine, without relying on
>> cloud-hosted services.
>>
>> That is good for Yocto, so I integrate ollama to Yocto-based Linux system,
>> build from source, offline install and deploy.
>>
>> For the convenience of review, show it on my github [4] temporary,
> I had a question about your contribution policy, but I checked your README and
> MAINTAINERS that mention sending patches to either yocto@ or yocto-patches@

It should be yocto-patches@lists.yoctoproject.org, I've corrected 
https://github.com/hongxu-jia/meta-ollama/blob/main/MAINTAINERS.md

>
>> - The BUILD.md [5] provides the steps to build and run on CPU by default,
>> - The BUILD-cuda-x86-64.md [6] provides the steps to build and run
>> on NVIDIA GPU
>>    with CUDA for x86-64
>>
>> And now contribute meta-ollama to Yocto, the layer provides:
>>
>> - Recipe ollama: provides application ollama.
> Will you be open to llama.cpp client besides ollama?
I need some time to do the investigation and make the decision.
>
>>    It supports to run on CPU by default. And optional on NVIDIA GPU
>> with CUDA
>>
>> - Recipe llama3.2-1b and llama3.2-3b: the large language model by Meta [7]
>>
>> - Recipe gemma2-9b and gemma2-2b: the large language model by Google [8]
>>
>> - Recipe deepseek-r1-7b and deepseek-r1-1dot5b, the large language
>> model by Deepseek [9]
> Will you be open to Qwen3 LLM by Alibaba? GPT LLM by OpenAI?
I need some time to do the investigation and make the decision.
>
>> - Recipe nvidia-open-gpu-kernel-module: the kernel module for NVIDIA GPU
>>
>> - Recipe nvidia-driver-x86-64: provides firmware for NVIDIA kernel module,
>>    CUDA library and application nvidia-smi for x86-64 BSP. NOTE, no sources,
>>    only binaries from NVIDIA [10], license is Proprietary [11]
>>
>> - dynamic-layers/meta-tegra: customize meta-tegra to support CUDA for x86-64
> I'm not going to ask about other architectures for now...

For other arch, the CPU should be work by default, but AMD GPU is not 
supported

the arch in meta-tegra supports CUDA, but this layer does not support 
the machine in meta-tegra,

//Hongxu

> --
> Denys
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3171): https://lists.yoctoproject.org/g/yocto-patches/message/3171
> Mute This Topic: https://lists.yoctoproject.org/mt/117602554/3617049
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176071/3617049/43253763/xyzzy [hongxu.jia@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>


