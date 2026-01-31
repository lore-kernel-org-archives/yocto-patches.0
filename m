Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C37D73EB1
	for <webhook@archiver.kernel.org>; Sat, 31 Jan 2026 02:47:24 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2167.1769827631963869741
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 Jan 2026 18:47:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=KO2P8Jlp;
 spf=temperror, err=temporary DNS error (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6491212346=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V2gXFI3576803;
	Sat, 31 Jan 2026 02:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=vEKl26ef6lyhZBiKTELi/FJPTCnGx2iPGbAwwIzARwY=; b=
	KO2P8Jlp14TRoOg6dkk+Ayw//w2nrJE37Em6+AfIMizRmZ+RvbaL55yaOrgPNVB8
	UVnbAmlM5iUO/+tMTUsbTrZpGXeB2tCFd2lNC7qje8+CGIARcWEXAppvAG4dnBvF
	8VOeQX9NGwA9yAOGWDzh18VuJc74NT5VMAui9QiWYT1kydu1qL5BAHLAf1spTIuQ
	8CRStIctpPitmRWHmRw+rIG/mzzwjHXPMqz7Emz1e7SGDINqGqmDl4sDU8jNAluQ
	Z5wvaKl++fkaG1wFaiEJE56EfvA4j93v65ONlzNO4tH5KGLZjOvN21Hx33+0yFuN
	jdviqWAW6vbr6fGWkH6DeQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c18q3r0kk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 31 Jan 2026 02:47:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtIJZ3+pEz0OltngEdnfe8jPsT3qysvtmIQCiKuj/kyvC5K8IovGQW1cCWfy2wdMZdVT0gvErMgEXXakObLEHurzP0zp8ll0NtoGy+UcWlY+FSZRCIlAG4IcIVq9vnymOSGwWNghx3i87gr3cjQtiWLkuUe05Esi6V3Es7kZMAYC85nt4g4Rs003ZGU+j/izGcyif4yvFglssVBzsO5dIooESgG4qhaf9ryUMSVal86MY4IQX5zBObjmv2f1QEACYChqEYaDAQXkQV2vjij8S0nZdb6ir50+bs2VhC/JgPxagaKpGFGHjM1U/GEpVU4RrJQUMty8CnduY6ngLcgeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEKl26ef6lyhZBiKTELi/FJPTCnGx2iPGbAwwIzARwY=;
 b=CqNRwvcZ+PbktLrUIGpxUksN2kt5POVy+KK+CrLawEpkja2L2nt20ROMDg/F72qv3TioCYn7jY2LtgpI0A3tZC7FbchemegOCroPUD74jXeL/RLW2BDbiNouwIQnrCGqdxuEwPxhtXe9OCBuLUMr/fvOo1TcNzjpEjpjRhX5OWX8Kmx5G8EVbPMHPpradPg8e/3bfiCLMWnznPjdkiUwaRPNxz+6eyoiFJPSbNvudAxAmR37dVlK5IGP7QOBIchQ3QHFgWnF9Sc6ABW5+5uGInmRN0MYBF7GAVKYDFmJboJmpawOHywJwS+ky3wfjfnI2e2NG+aK9G58KTrdDP4G+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Sat, 31 Jan
 2026 02:47:05 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45%3]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 02:47:05 +0000
Message-ID: <a8145fe2-1195-4408-a6c3-b5445d84ed98@windriver.com>
Date: Sat, 31 Jan 2026 10:46:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Openembedded-architecture] Running Large Language Models Locally
 -- Contribute meta-ollama to Yocto
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Michael Halstead <mhalstead@linuxfoundation.org>,
        yocto-patches@lists.yoctoproject.org, Khem Raj <raj.khem@gmail.com>,
        Alexander Kanavin <alex.kanavin@gmail.com>,
        openembedded-architecture <openembedded-architecture@lists.openembedded.org>
Cc: "Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>,
        Robert Yang <liezhi.yang@windriver.com>,
        Randy MacLeod <Randy.MacLeod@windriver.com>,
        Mark Asselstine <mark.asselstine@windriver.com>,
        "Holmberg, Tomas" <Tomas.Holmberg@windriver.com>,
        "Chen, Qi" <Qi.Chen@windriver.com>
References: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
 <8d6d05baeee00bfe96dfa816be9affe2ff0e421f.camel@linuxfoundation.org>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <8d6d05baeee00bfe96dfa816be9affe2ff0e421f.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|DS0PR11MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 093c1176-6896-49fb-e885-08de60730492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L3dqWWN0S2NIazdteVJQa0g0SEZqNFBpbHpjYTFOR1NrZmJzbTZkbVZZaTlk?=
 =?utf-8?B?TVZHNFlMMmdzUVllc2pDVHJpcGRBd0oxOFQrWXpMdlRpZjRkZ0NzM1BjT0FP?=
 =?utf-8?B?NzBjZWRUUWk2d2pobTRhOGxSQTBoMVZJNS9VZDhrckwyQTV0a3A3cUx3R0xF?=
 =?utf-8?B?cDJ5YXBXczJxZm9qME1jVVl0VmZCckEyUVVCTWtJU3ZEN3BpMkFGMHBGbUlN?=
 =?utf-8?B?R0g5aUU4c2V0dTNRY1BUT3p2R0t6NEhtK0syaGtPM3R1MDZEazAwN3A3a3Vm?=
 =?utf-8?B?bEFWWTJGdDlxNEJqbFVDN0RSQjZaaEg1NDZpcDBoRTRXZTJOaThqWkFnZU45?=
 =?utf-8?B?SU5yVFhrQ0d2ZUVRRVpxcldmS1owMUsvcTBSSkpVZHFMYkJ4WC85ZW9RZUVh?=
 =?utf-8?B?dzZKVDBVS2o1QUlIakpoemZiUnZ3TmZWTTQ1RmE3WkpqL2dFR0JMb1VMZ2hS?=
 =?utf-8?B?czlMYjZjbmw2NmJkUWs4MUtmNzFFWG5tS0NsV3hsUWlmamw3bkdFSmxMMmFL?=
 =?utf-8?B?QzlSeXVmNFlnVXBVa1cvZVE0RktpWjd4dzEva283dlZIT3UvczRYanJYYkMx?=
 =?utf-8?B?VzRMUUtFT0gvLzVRZW5TUDJBbjBXT3FpQlU3M2crNzdtTXBlY3ZnbEl3Ti9o?=
 =?utf-8?B?OTQwQ2p5dFdOSHRsdjFXcFRZeVRJa0RyTHdZa1ZLbkJ5R1lxZ20xQU9GaHEr?=
 =?utf-8?B?Q2VCVVN2bm52UkhHMkliMFBoRFNGVUEyVmF1dEo3SzBJY1U3Rk5zOE1VeEhN?=
 =?utf-8?B?NnF0dzlORk45VnI4Y25ITmhZUjRGS3FTbVhiYnFNMWVZdGhka3lNem05ODAx?=
 =?utf-8?B?UTZzN1liM09XeVUrVDVZVEIzVmZGZWpGRmlMZkpib1pBdUU0S2dtaTZ5Y21a?=
 =?utf-8?B?QktKY2FpbnRWY3FZUnJUbVU3L3I4YXNFOHgrYUNqZ0VIREU4WERzbEk3cU4x?=
 =?utf-8?B?bDFxZFRKWHJMM1lhdVozbGdZN1ptVWdnSTcyTldlKzhUeVFDQ3FrbUFBTHNO?=
 =?utf-8?B?azZpMVAyZmVadzNWTXVxYWcyNWFSM1ZmYXh6MVN2UWtBKy9yaGorSVFmSXF2?=
 =?utf-8?B?MFh5NFVZM3MyczJGb0lPZXNqVFRFQUVIMzRWcTFTR1hHaDBtZ2hSaFlnSVd1?=
 =?utf-8?B?elVrbDdUalJwK2x5WUVtQ3F6bXRQRFdtSVdwc3RqUlpUVXZFYURSZDVsQnBy?=
 =?utf-8?B?RHBhcWNheHA2cEhyY0wyK1VVNmFPZWVNbXlOSjlyWmh1c0UvN1g2d0dQUUdQ?=
 =?utf-8?B?NmZpekxoV2FhdmRYbVo0MEwzQ0JPeVZ3b1FFKzg1cmhVcjdtcXRGOG56K3BJ?=
 =?utf-8?B?ejgrVWE5NnFUVXFwdXg4K0xPL256MXNTUVpEdnByNzhPUUpHM210WGw5NHdW?=
 =?utf-8?B?V0dOT25pMktJWGVSaHcwQVVmVGU5MDBaTlBQd0NkWEppdGNWY0E1M1pPZ25l?=
 =?utf-8?B?QTRabkJOZ3Q1OFNvUGJyM1VzU0UxUGQ2QVVlR0pNNWJ6cWVVT3JzZ3NSdlBn?=
 =?utf-8?B?SzBITHV2b0JIaHNFeHdBb0pEZkM4UGszTC9WZTlRR0hwMzRCWnV4Q1JFclBs?=
 =?utf-8?B?d2hBbXdtWDNxWDhtcTg3TndFYzRRY0ZoVHZqUEpXZlZpNVFDQUQ4RWRXMy9H?=
 =?utf-8?B?aVpkb0dsOHR0b0hzTlRPeHVSMlJUTUNSV2wvMWR5M0kyU2x4WG91VFJDRmVE?=
 =?utf-8?B?T0F1Z0pkRnRsQVBNN3dSd2NQVjkvc011NUhhV0ZwbG83a0czeXZsYlNkOWIx?=
 =?utf-8?B?d1Z1RW03MXA4RFJia0FJOUhyZmxwWDdnNXZYY210N0FkRFFGOWJPMnJFdUxB?=
 =?utf-8?B?OGVTeFVUWDdLVHN0aHBoOGpZdE92SWFwandiYmg3MlRaUGd4SlFhVHJ3dGMv?=
 =?utf-8?B?alcrVnY5WDFlTmxrcnlwNTUveEtYR2FEc25teXRFaTgybjJ1NnJ3S00zQ3My?=
 =?utf-8?B?bExuQVVDbUZiSnd4OGtKNHhBOGdYTDhpYzZFYVhrZXlzVXJiMTRYOENvK2hB?=
 =?utf-8?B?Q2lXTUlWT29JNG1OUTYwbllaODRkSytRRW80UkZOV3Y3Zm1HWUtIZ2M2LzN2?=
 =?utf-8?Q?6sqVXV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cm53SFAvU1BST05vL21yZDdJNHhNQmhaZW9tZ0NIYXBFbGRLRDhobUlhQnNQ?=
 =?utf-8?B?ci96MjBxQ3IyL2E1ZXYyOEhucWUzdkw1QlA0UnhVVE5XbWsxYmJvZ2YydmdQ?=
 =?utf-8?B?VFMrUHdjUWlXVlRtUUlINEtxeUNYejVINm5oSjFJa0JDSkh4Z20vbkI0V01j?=
 =?utf-8?B?Qm1IWElCOGNqN0hwb0dBaElESHh0WFo1V1FQQ252UGRtQ0grOWtJcXRRRC9P?=
 =?utf-8?B?cjNpSy9Zbzh1dHlwQ2tUemxZRjRSNHg5YmRXUXhubVV4dEc5b3dldDJqK01J?=
 =?utf-8?B?RTZ0ZzQzbHF4THdFQWxOSHhxNmxaWVB0UHIwc0FqTXFVRkxxQUtMRGVvbDdB?=
 =?utf-8?B?cXFzZ3QrQXZlTGVUVkdTSjQ5R05pNVBUWmhqaXlITHdoWDFkdGJ0M2JtRFV2?=
 =?utf-8?B?NG95RFN1UUxNcDcrdS9odHI5Mmp4N254dEtpMmhGRjYvNVFteDRKWTZuRTVO?=
 =?utf-8?B?dEFlSTVSQ1pFMFg2QXRYdFJRZzc5andlRmZidWlBdEdDaC9wc0tmbmVvZERw?=
 =?utf-8?B?RmY3T2ZtQ1U1SGh6V040MFIyakxjUmZmSW1mUlVWbkFQOC9LdThZN0JSYTAw?=
 =?utf-8?B?WGl4dC83TU9kTnB1STZld280cXgyR1ZVWUJoL05oSFdoVlJ2aHhyb1Y0VTls?=
 =?utf-8?B?MnNUMDVhM0IvY3FubEpET3d5MFZ2UDJMVWM1RFlJdlNEb1JaSmtTSEFtVUt6?=
 =?utf-8?B?ckNFY2dXUUVoVGJTVElTeXlnd3E4L1pGMnA4SUtzOUI3anpHcXYwSHlBRE8z?=
 =?utf-8?B?ZGxnMEFXcDVseG5IWXdmczN6R29GcWI4ajlSS0tSSXV4dmlYQWgybCtLd1Zh?=
 =?utf-8?B?eGphdVgzOUd2eFZGL21Qbyt1RnFicnhXSEtYakR1TStIR1g0VnRLbVBhRFBY?=
 =?utf-8?B?RVVld1JNODhBZU01ejRPSDFDSDlnZ09GWmRSV2ordzZ5MkRVVGRLQlNReG8w?=
 =?utf-8?B?R1A2MHhVNFduenc4NnhPajhQV3M0bS84MExnR1psR0IzS1ZKVng0cnNObUZ2?=
 =?utf-8?B?NFkxSHp2ZjdoUWxjZEV3N0RsWjJBN2JkbW9xamRlYk8zZ2ladnJudmdtNG9J?=
 =?utf-8?B?MHpLU20zWmRSSUJPcmRYL1BWeVNOTE1FYnRqaFhGNHpINHlWcnFhbVpBbHZn?=
 =?utf-8?B?WW1nRW5RNDdQLzBseXYxdWJsdkVqTC9QcFcwOStSRTJZamp1c0xFaERUVDRk?=
 =?utf-8?B?RHowK0NHWTVtTWJaUTFjc3pYOUpZWkVDUVRWZ2hSMGtjWjkvTVBmZUdkMncv?=
 =?utf-8?B?SVh1bUk4S2xCSVBwRW9paVdOMmZFNG1BUU9QSUlsUWZsWWwrOGxIUFpGdmFW?=
 =?utf-8?B?aWEyTlVxQmxmSnhXUlRSeVdKeG9VclVML2JuOExjWjN6UzNDU29wQngwcWRm?=
 =?utf-8?B?MjI2UDJ0emFzSkRkSFI4c1hqaGJlZTh4Z3NWZ05mTStxRnh5WUdZaC9MSmxh?=
 =?utf-8?B?RWMyK3QxSERjY1d3ajhBYUxwTEtBa2YzVXdVWTFrNkxqbi9yRk4vSHlDdUhI?=
 =?utf-8?B?L1RnUmw5TDdkWUJRZmhnYVdhT00xcDFodGlDcjE4RnpVRHF4MVp3WFhxdEhJ?=
 =?utf-8?B?ZVFaWjFaYkZGTlZOd1F1ZTlycCtRMXVsWnhxRFUxUlBQTENqWVVBV1RSSTNw?=
 =?utf-8?B?KzJFR29qMkg3M0pONUtuelZnSFlXbnB3dGM3KzFVaVJLSUxNWDRBLy9TRTRz?=
 =?utf-8?B?dCtpOG9XdTdkOFJPajA4Qitrd1FjUTVnU1BWeExPbzZXaHRuTWJ0a0U3VEQ5?=
 =?utf-8?B?S3d3QTUyYjNTcVNNc01iLzhzd2ROanNsQ3V1U1RCNkpYUHFDZHRULzhvZWxt?=
 =?utf-8?B?VE1zMVJodmZSc2RzTTlzWmZSL0RrWm1BZVhIQmZtQWNnTDBQUm9DakhIZEFU?=
 =?utf-8?B?UkdFa09YUFp3cWhLa1IrWlJlVTI2Q1BHeFB2MFBFbWY1NktwZXh3dTl5T0tX?=
 =?utf-8?B?OW5nMnJUL2VkK245ajkyeGdyOGdOL0ljVHo1MDZldkk0cTVGN0NFb2hoM3k2?=
 =?utf-8?B?L1lyT0tVMHdrTWRDL0ZBbURjU3ppSzVqRWY3T2x5bTdpU2U1U2lhcTRSUEsx?=
 =?utf-8?B?SHY5THFZU1VmZVhmZ3p6V280RXhFeVhBT1B4dkdiWWhpZVFyWjRTcTI0cm5W?=
 =?utf-8?B?eUdvSnVxSFlSajJlK21SVkh4RzFIblJ0bEhsckdxdzJQU1F1RlpwSHdnL0Nu?=
 =?utf-8?B?cDNqYW43OGlrUUpmSVA4RXJJS01yMFdic2YxSDA4WlpDb0U3ek5GTnF2UWsx?=
 =?utf-8?B?MXgyU0V0bDROUlh0YnhWQW50QVE4cCtCWmx3bGxkYk9XT29QaFk0d1hJWlVQ?=
 =?utf-8?B?Sm1wNHlzV2FTbEdqWjBTYy9wYldGNjkrWFV1cDV6OThLU0ttTmdVdz09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093c1176-6896-49fb-e885-08de60730492
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 02:47:05.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCnWpAbqPf61PL63dErRBW0G2v5mGmHPAC5kpo704S1OT4S6OfKuqE6q4S1EwwPwKrEvsm8yvAVagP4gwXLFmO+nZXQGBNlpjP5ASVpS6Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: QaKh7Id_1H8naCEYTi3FNYh5tXcQeXi4
X-Authority-Analysis: v=2.4 cv=Au7jHe9P c=1 sm=1 tr=0 ts=697d6d2d cx=c_pps
 a=1lugHNwfFMYeWqdp2xp0VQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=Q4-j1AaZAAAA:8
 a=MjleUSwd5qAcYXlZDhkA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDAyMSBTYWx0ZWRfX1uqZ8+9Kfgoc
 FryW1EN4b6vcluFHuDkYbtrxVHKo9ExvCgbhO3jRInjAa7x6ytOqqIarEJz9qIM0Y5OpXIN2DCl
 hXNTk51Vg7yz3BZ79TAdRSVH8Xs6MyGcGOMB1UWngq9OOyGVDF7lb5988FZFtM6Vae6WBPLj5oe
 fwMwB2t61k2JKSWuYl+YyOlGlk0SL/L2b2Y8nMbQMeVM6VFuGfmxxVcLjf/DqZX7JpK7Dd5587i
 z/BsFetnFgbuxPTe/LhAksG/5VpdmS7lLZnhR5GLdFY2yRrb9OxlzfKvy3B4zDj2HDkHMInJeyE
 0ezVDpUV2G1i7dB9FPcJ8mMx3Kc5t/cq9+eUaI5sRPcrp0Z1W7esjBvap63/xQZNtFifnLdagGa
 zG8KG5ISJSkVLDmyyn4FVbCDzylu6QpsbjjKVyuj9vHzC3S7sYRePISED6gLCLGpeiXviQ/0W9F
 e6fuAHWkKkQ71UN/fjQ==
X-Proofpoint-ORIG-GUID: QwUmyOxejzK2X86PEHNDSEi5O1-XgmHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601310021
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 02:47:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3153

On 1/31/26 00:56, Richard Purdie wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Hongxu,
>
> On Fri, 2026-01-30 at 13:20 +0800, hongxu via lists.openembedded.org wrote:
>> Would you please approve to add this layer to
>> https://git.yoctoproject.org/, I will maintain
>> meta-ollama for recipe uprev and bug fix
> Thanks for sharing this, it looks really interesting and I like the
> idea of it a lot.
>
> Also, thanks for volunteering to maintain it, that does help alleviate
> various concerns.
>
> Approval for this rests with the Yocto Project TSC so I have asked them
> about it. We should have a decision after our next meeting.

Copy, thank you for your support!

//Hongxu

> Cheers,
>
> Richard



