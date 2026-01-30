Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2301D61019
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 06:47:27 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5352.1769755637392367665
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Jan 2026 22:47:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=Pz5h8sq0;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6490fa592d=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U6K1bX1485620;
	Fri, 30 Jan 2026 06:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=jg+Z1Ev20g+zSCYJOeEe397+Vl6gXLDMQidOxQE++dk=; b=
	Pz5h8sq05y8lUV3vjw76P0MP03fDytgz0s10QP40BNm00laF4OgzpMV/uLN2J8Gf
	+JQxvJ8AxE0YzdIP9tLYmqM1eygWbD9Ef1APOX9XHLTnvsKgpNq4WngZOvrRchsu
	vkhe64HOzZwFyQ7Gp9f8RZdNKecjA2EH4e3vXcXVsMseIWQeBO5EuftyJ0U5OLTv
	gDwmz/MGav+GKZA9pqDg+baUqaJj2aDammRNmqGCWNVdX1/gPIu31XwRdn4K62gB
	aKKRteIIbhIqazmaLgfHmlXEX0H5dQpRkcSZGOt46SMpu089CbHFMFzprQ/LeUNn
	CZYxeAfOqyDUQEEJcqsvPQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bywwjhxdk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 06:47:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKlXHgJmHZZjYWXF3ql3nmygXVHisaZdGTDwAdNDTKpQy403WIkpa+6MR90S+OaMh+Py5askbNr7BIPQRraP6ByxqvLG6V0Y1BjxE9FpYhJj7lD+ymhrfmxz3sKZeLme/srgi+NqICh6/7dyJbH9KmprkfOiONbeMSdteHyb5FaEHdD5NE/VKiBt7EU281pTSbS+vfce/AYFiKk17xZKPYsW/QgDxj7xmVrpYqimedWfjg3KBfn2BZ4sNHbe4LXRgXqIVt4gbYyBixBBfu2jaIM/RREWETvxz/+4mLTwfR+L5DSmNZk+q0miAV55y5CGofXVQJ71bELuHGNL/h14OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg+Z1Ev20g+zSCYJOeEe397+Vl6gXLDMQidOxQE++dk=;
 b=nv7qef19la6XK34WAa9Vf3/GXPCZWO3Q7IFsZkC9wllJrmEhfUR0WEj2DNV9OiG2t9T8278rw1IAGZwyzdN9RHLBlMaAfw2HizIfmWMAJfYvbYDsHcshOkRDdP5/3sVTK3ENSTr7SvkK9VNetR+dN1mkgSASZMCfPDrDkP94VFr8O9E0msAIAlHCYO32tYmYJSbTnNx/2NEwOCb04RvbAogvFdZfgBphGFEn7F0l7NiChvzBFyxWDPAlPla7WQqtrhDQl5jUaeSXWaVXpqNcOHI5MNXg/+ckFDeOIDdAIUSJJEf/8U497rlVE44L9/XQRDkiCVPywBpRciuFDG1DbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Fri, 30 Jan 2026 06:47:13 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 06:47:13 +0000
Message-ID: <8bc62b8a-ace4-4f1e-af85-ef0e2d920061@windriver.com>
Date: Fri, 30 Jan 2026 14:47:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH] [meta-selinux][master][PATCH] refpolicy:
 brctl - add changes to access devpts
To: Wei Deng <wei.deng@oss.qualcomm.com>, yocto-patches@lists.yoctoproject.org
Cc: cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        quic_mohamull@quicinc.com
References: <20260128150814.2273926-1-wei.deng@oss.qualcomm.com>
 <aae1b4af-225b-4c7b-a573-ccb3f8a04c1e@windriver.com>
 <50724a7f-6cc7-41c6-9406-017777b7801f@oss.qualcomm.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <50724a7f-6cc7-41c6-9406-017777b7801f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: KL1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:820:c::22) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CY5PR11MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a3ad37-9e14-4677-946f-08de5fcb6634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|4022899009|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K3ByT1VsYmwycXk1VjNwRGlsNm93UHhkeDBMQmVvYW9md01iY095bEpkbk9S?=
 =?utf-8?B?Ti9KdkRTbGMvekdrY3NnM2FrM1ZHU0RhNjBib2c4RzkyRXpmMmlTQlFZaUR4?=
 =?utf-8?B?UUhsZkJFL2NaZGJEd29UMWxYYm93bWgwVGlaSVpBTDNVNS91RWl0UnZQSVpk?=
 =?utf-8?B?RzNoR2YxZVgzVytWSytFMUdQcW53b2RNNmZoMCtFS0traTZlTm9pdDJyT3Yy?=
 =?utf-8?B?UlkwQVFhTDdUM0RTZzJWT211WElhckY3YVpVZitrclVBcElMT2RpS1VqVFpD?=
 =?utf-8?B?NHNTdmZVWUdZMUxHbnJzNW9xbS9ndlozeVBrb2srd2RoYmJxdUxGVkpISkM2?=
 =?utf-8?B?VlVjOVpJRGJvZFh3ajJzMC9TQ1U0dEo4THFSQ1hDMkEzNTdZUmt5UllqTG5r?=
 =?utf-8?B?SEtxbDF2c3BzYWl4b3JMQ2ZsSXVkRGpHVzhvYzVNa0ZrZUt1TTJFVmY1MVhk?=
 =?utf-8?B?am1Xak9LZXV6NzQyVmFGM3NpR2lEeHZHOEpnZGhVRnNaVERkOGRzUGxqVlp5?=
 =?utf-8?B?aFRvbzVHWHZkNFBGTDlza2hkVWZkZDZUWG9JcmtSUWN2a0xsSy9VamtMbGJL?=
 =?utf-8?B?bUFkSm9veVJUb0o3QTFZbWpyMlJzR3BERWZ6OXRZMUVld1RRM3NWQmNYQkhq?=
 =?utf-8?B?VkZYMlJ2OVlNSzk1UUxjYTkrd2JQMit5dDBQUFYwajN6QlBKTXFaN3NNVTho?=
 =?utf-8?B?N0ZWSnVyTzB3TU9oQ3hUaWs1S3pFa0prVHRYYkNKWHdhYXhZWG5hdytvUzdp?=
 =?utf-8?B?ZjBucnZwQTU5Y0gyMnNpcUIwZ0V3YkdEbjdiNjR3dHpnZ3AzdUhCdFZWS2Ev?=
 =?utf-8?B?UDJMeGZrSlE2TDB3ZXcwWDAyWEdwdUFEZElaUGtpMm9HUCtNcmNtT2IvVnVk?=
 =?utf-8?B?c0d0RzZ4cmM5ZU12UGdxbEgwSnVNMzRvNlorNmVKYTNmMGFabGpNV04wNTRk?=
 =?utf-8?B?dW94NTljS3Y5OTBJejA0cWdVZkRKVjVmV2hFSk8xM1cxQUR1QWJVZER2T1p6?=
 =?utf-8?B?OVNzREIzQnB0M0tOSEYzcXBlMGEyMk1EMkNSMG4wdk1teDBIV3NEOWRXb2o2?=
 =?utf-8?B?REVFSEd4RDVvSkExWWVZRHhrSGZNR0swL085RFp1Qmo2RlpidExOaWRqOWF4?=
 =?utf-8?B?NGhHN1VSRGdESTlDVURlbmtndW01TXFENnJlYWVMVHVXd0FRQ2lERW9CUXht?=
 =?utf-8?B?U2w0enUvWVNhNHlyMUxIOFZHbDZoU1Y3b1QzQUJuOFdiOFlCb0VyYzJLSkl5?=
 =?utf-8?B?cXZtUTVnRmZSR2ZKakxjeDZra2twb3k0L1ZQRi9lMEhhWXJtUDhVQ095WEdx?=
 =?utf-8?B?bWxnZ3NkZ0w5NUVhVGd3emxnbGdFWFpqZS9hTHpMQ3RFRUtsQzBsM1hEVEds?=
 =?utf-8?B?UE0zZEZzNHRGemNJMnRFMjNxSVRIWUNEa1h3dGFlYlUyUUo4amJpRE5EajBW?=
 =?utf-8?B?VCt0allNdUR1ZWhieTJBVUVBNTVHdGlaR2pLR1FzTkd4cFZ2OUFXZ3YxZ2R3?=
 =?utf-8?B?VmF0REdhMjdNWFpkV2UvbVhMb3VqZ3JaYk1UbUtxVWFldE14MlhPYTlBSnZn?=
 =?utf-8?B?RG5jenduSSt1UDZUMnYwNlRIZjlORHp0MnRKVXVNSmlxMGNuK3ZYUmlWT0ZM?=
 =?utf-8?B?dW9Qc2prNEI4Yjd5akZrT1VuUXlvcVNXZjUrdzdGTTd4VHB1ejV0cTd1SEJ4?=
 =?utf-8?B?N0t3ZUo5TkVCUW16WjNmSzFnQXgrUGRpYjJJcXI0bjdXM3p6UHJtMzVRQ2Jo?=
 =?utf-8?B?ekRUOGJFVXUxMmEzR0h2T3FOYlhwbEJpUmcyY2RkcjE0YkI3OXFPanZHSkxX?=
 =?utf-8?B?SGNPTnFRckhSeEVhU3A5Z2NRVkRaakRJUm44VHg4c3VMUXBaSTBrc2NZMU05?=
 =?utf-8?B?NHQwMngxMkpDWHRXVTliZTkxSnhQaXZMbHZFeVhRTzAvZUxYaCtWWWgySzcw?=
 =?utf-8?B?dlUrUnIreXdIY3NhdUhhMWFUVjFTZGl1a1RacWkxT0F0U0dzYVErWHkyM3U3?=
 =?utf-8?B?d2lnQ1FxQXJsTEJjelJXR0MxcmlRWjFyR1IyaDVJaStvdWtnbDhPVFNBMGJZ?=
 =?utf-8?Q?xD8/RL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dGlVQVlTZ1E2YmVOajJXNHg1WitqOVdMNWY4cGRKVmFjMFp6YkNMQnlRSFlo?=
 =?utf-8?B?STgweWFRNHpLS28vSTBJUHN4RlBRKzRrN3JCMUV4ODBhTVBVaHJqQjJqOExK?=
 =?utf-8?B?QXVVKzc3NUxZNGxZdW1lVmRpWFlXMEk3d21hYzFWcnZsY0dBckdwdTROSUty?=
 =?utf-8?B?dk1rYVVSaXIrSXZ3ckZXby9WOCt3QlRidVAvQ0pUbGlDYmZpT0pCa24zNVhQ?=
 =?utf-8?B?OE1yRXc5ajVnTkh0L3dSUlpYUVh3Z0huWW9KUGhHTHFRWldMMnJUeDM4NmJy?=
 =?utf-8?B?S2h6YUZYQy9JcEszWldaOG5HRkJmZERBMDNGaWFQOTcxaURnTi9xT3MybGc3?=
 =?utf-8?B?QThuRHQyOFdjSGt6aVRkS01MZjl3TVRzRTYwbk9zSHB1TmN5MXhURHRoNGNk?=
 =?utf-8?B?MVpnZFpCNjBscWJ4Zml3ZlVtSTk2S0E0cjM0L2hkV2h2YWprYXloUFVhczFw?=
 =?utf-8?B?NDRySGtjOE05R3d1SW9odm9CaTVQVU5sZUlwcXVnSUJ1bGV4QzVZUGJxVnV1?=
 =?utf-8?B?Z2orc0R4WEFYMm1KTDZLRk96anpuTlpXOUoreitRRDBRekZ4dlZyQ2R6Wkd3?=
 =?utf-8?B?dGgzWVlqekEyVUZjMm1qV2xGWkZkTC9Ra1Q5ekhmamdxdyswa29KT0hlVzUv?=
 =?utf-8?B?Z2pBMEtvV3A4eldjSkxMTFM1dXoyclRCS011RTRSKytsaitiWlg0c0VSQ25y?=
 =?utf-8?B?RGdQUWpnWVlSOXBoMGpDcGdqK0VIZ0V5SmgyYkN3d3JuY3R0TkVDbWRzTmMw?=
 =?utf-8?B?NFhDSkhZaGgyUm4vQTJPaG5JRTRwUGlBdlJxa0k3SDNpSktSOUJGOVpVb0x4?=
 =?utf-8?B?dHYxTFdSS0EwMXdhd2VkWjNlSlUzNDhaMjR0UEdSeWpINjcxMWZscEpEWkZX?=
 =?utf-8?B?MVl3bTB6VnR2Vm1RRlBLdGxwUmxLRUZnNU9MTmJvM3Z4WDJFdjVFRDhqZm5X?=
 =?utf-8?B?TkQ2VHIyK25uelE0N2NnS1RxdmtveUF4cVFrd0dTMmJtUldiZWdnWWJoaFlT?=
 =?utf-8?B?TExLOEtWUzNPL3pYVDlaYWRaa1BoaTEyem42RHA0d0Z6QlJHcVBVeGxreVhC?=
 =?utf-8?B?ZDNmWUdLL043cXU5S1lUVzdxZzBRVHZRTmZCbXl1Y0ZHUlNRWldPdXZBTmpy?=
 =?utf-8?B?eXVVbGhJNGxVWWptMUN1RFRLcXVTakd3c0t5YmdwVlF0d3lzaTR1OWhNR3dI?=
 =?utf-8?B?SDJiWkQrV2JFNC9QSUFLSUFEb2ZTNlNEVnF0bUduM2R4SER0MG0zZHZxNGJU?=
 =?utf-8?B?b0RuM043TVN0OVo1d2pnN1FsUjR5ZTR1OHRaZWNPcXJrRmVhN0IwcWdYQzRz?=
 =?utf-8?B?SHh4QURNc3hqWDBvWlJSWVVVVmpiU0poR2NnejhKYlFIQ24xM1dtdHBQZmRF?=
 =?utf-8?B?YTE0Zloya2s2UWhmSXZ0QkRDeVJjY1o0eEdKaW1kUTdrc21rKzdBNHpHdDhY?=
 =?utf-8?B?Q1JoS0Rpb0FoS3RvbGVyK3VDQWtVangzRXkwMjQ3MzRwVU1Ic2xzdnN3d1Ji?=
 =?utf-8?B?eFQ2b2RsWjIwN0NsQzVpelVQc0NDc0poVU5LWDR0WlRERVdERjdnNEUxMG1z?=
 =?utf-8?B?THAwNXdsenE3bU5HRC9KMkJBTTZEN1JJMTJTaXVQMFZQbVlOSWxMZ29lNlN2?=
 =?utf-8?B?ZXVZSXpjTUZpdE1PM2t6SGFrSjV5OGl1TVVXc2N1M0plTHJMYU5hMnoySCtM?=
 =?utf-8?B?aVJMZ0M1elBleHpHM2tSaENiaXBHcUJnbEV4QnNVbDJpQlJuR2RKM2RDQUhv?=
 =?utf-8?B?emtEUXNPV0FIRmtzWDhyRFZJNlhKZ05idUdOdmJhK3FJRFcvNWZ4YkNUbHlZ?=
 =?utf-8?B?bjJ2RHJZQVQ5WnRmRzc1dHF3VFYvSTJTU01xZUtVU2FYZFJMekxBMkx2MGpN?=
 =?utf-8?B?YlFyNDYzQy8yVVVFTmpXdUt4b2lvclJNTzJZa3cyN3UxWStNc3Q5OWtwaXZs?=
 =?utf-8?B?ejd4M3g1d0ZqbHZPS3N3b0laVjVXVmhVRUljN1hVSVdaMmNtK0J5eVprMnlS?=
 =?utf-8?B?QnNMc1Mwc3FnbmU2d2ZqRVByVlNFbkVDSlQzYk5WY2tOM1RqUm1BRDloVG84?=
 =?utf-8?B?a0NVSFJNcW1OUWNLVVk4dnlkT21FMDlXM2N6cE1Vcmc5cWNYc2hhRDFjaVJn?=
 =?utf-8?B?YkR5YitkQ2xQazVYeTB1UHk0R2NaWUF3d2p0YmtNKzU3c3ZJZzZWTkx3WUFT?=
 =?utf-8?B?U1BSenRpRkh5UGtPTk9jOTFBMHlESUs2Ri93TWIxS3BrYWc0WDVWaWVobjBy?=
 =?utf-8?B?d24wVGlqVDB2eG5BWEVqRkQ0cnpwbWM0K2NQVnJ4ZUdwanovdGlzUlE4MkFu?=
 =?utf-8?B?QWdicUo0ZXlIbGdGaWZFNXNEQ2dXbmEwdzkvY3o4NkJ2c1Vvdzg4UT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a3ad37-9e14-4677-946f-08de5fcb6634
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 06:47:13.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/nhs2WzK1xfueyAuFpgtlEFdyvppahgRgMq1o+F1A96QLMexK0c1zZVrVUS3ZpbkNfnaXWTr2qMJh+xZNsxog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA1MCBTYWx0ZWRfX++xmst2tI4oc
 IM2WzKxYxPmNDQrosnZlVccnOMcvC4z+ZFdgJiz5gEpglmBS9LhwENb2jx9SjUBUYbeIhfudwB0
 qcv+V/X8EG6DJL/H9vm7RQkX7SCT5qj3tHKUQQyrOo3mWIIANCw796IxUF/EF15gfOUtWfofQGq
 LVT+Cno3maG+hQ/+gVF4tCViG48PSHTeisDOxALyz7Ep15OSYvdOQkBez94YW017DOcp9JzDNaz
 VczraeuYBDRl3LcmctsErTMf4WSKgPcU8Ild1yrY7FBVBZ7YA8RYt+s18XotwQLQvm9fDovJktS
 PyYu9dKnh5y/eh0CrG0k0B20aFyghTFV4UqYPoRpuRQjjCDCKk1+jItzHUbGqbX8qnHNGvBoGnC
 JpB9emPz4spsAAfB+Z1zVQ+uXuzThG1y0gdnJIUCfpQPRL8WU0lWod1BCsZD52h5EOMmQZshaKg
 mxAyrqQvWGaEysMDanw==
X-Authority-Analysis: v=2.4 cv=I7hohdgg c=1 sm=1 tr=0 ts=697c53f3 cx=c_pps
 a=9TxNVFKjsEmGPsTOmRxrqw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8
 a=PZxMGCFiTf-PHRCx3ykA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: PNvdslBYy4qDsnnoTNS3Z0suICc_EUEi
X-Proofpoint-ORIG-GUID: PNvdslBYy4qDsnnoTNS3Z0suICc_EUEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300050
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 60U6K1bX1485620
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 06:47:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3150


On 1/30/26 13:38, Wei Deng wrote:
> Hi Yi,
> Thanks for your reply.
>
> On 1/30/2026 11:22 AM, Yi Zhao via lists.yoctoproject.org wrote:
>> Thanks for your patch. I won't merge it at this time because I am curr=
ently working on updating refpolicy, and this backport patch will be incl=
uded in the updated version.
>>
> We have another patch need backport as below, hope it alse be included =
in the updated version. Thanks.
> https://github.com/SELinuxProject/refpolicy/commit/1783c0c4eb9aaff6b7b1=
b18fbd86f933e398ce5b
Yes. This will also be included in the upcoming update.

//Yi


>
>> //Yi
>>
>> On 1/28/26 23:08, Wei Deng wrote:
>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>> ---
>>>  =C2=A0 ...cy-modules-admin-brctl-access-devpts.patch | 39 ++++++++++=
+++++++++
>>>  =C2=A0 .../refpolicy/refpolicy_common.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>  =C2=A0 2 files changed, 40 insertions(+)
>>>  =C2=A0 create mode 100644 recipes-security/refpolicy/refpolicy/0057-=
policy-modules-admin-brctl-access-devpts.patch
>>>
>>> diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modules=
-admin-brctl-access-devpts.patch b/recipes-security/refpolicy/refpolicy/0=
057-policy-modules-admin-brctl-access-devpts.patch
>>> new file mode 100644
>>> index 0000000..cc6abd1
>>> --- /dev/null
>>> +++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-admin-=
brctl-access-devpts.patch
>>> @@ -0,0 +1,39 @@
>>> +From 43ef3db9bc4247222d773bb24da71352bf84f4e5 Mon Sep 17 00:00:00 20=
01
>>> +From: Wei Deng <wei.deng@oss.qualcomm.com>
>>> +Date: Tue, 20 Jan 2026 08:28:45 +0530
>>> +Subject: [PATCH] Sepolicy changes for brctl to access devpts
>>> +
>>> +Resolve selinux permission for brctl tool failed to launch in adb mo=
de
>>> +with enforcing mode enabled.
>>> +
>>> +Below avc denials that are fixed with this patch -
>>> +
>>> +avc:=C2=A0 denied=C2=A0 { read write } for=C2=A0 pid=3D1407 comm=3D"=
brctl"
>>> +path=3D"/dev/pts/0" dev=3D"devpts" ino=3D3
>>> +scontext=3Dsystem_u:system_r:brctl_t:s0
>>> +tcontext=3Dsystem_u:object_r:initrc_devpts_t:s0 tclass=3Dchr_file
>>> +permissive=3D0
>>> +
>>> +Upstream-Status: Backport [https://github.com/SELinuxProject/refpoli=
cy/commit/43ef3db9bc4247222d773bb24da71352bf84f4e5]
>>> +
>>> +Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>> +---
>>> + policy/modules/admin/brctl.te | 2 ++
>>> + 1 file changed, 2 insertions(+)
>>> +
>>> +diff --git a/policy/modules/admin/brctl.te b/policy/modules/admin/br=
ctl.te
>>> +index 026b0002d..45ca94c60 100644
>>> +--- a/policy/modules/admin/brctl.te
>>> ++++ b/policy/modules/admin/brctl.te
>>> +@@ -23,6 +23,8 @@ allow brctl_t self:unix_stream_socket create_strea=
m_socket_perms;
>>> + allow brctl_t self:unix_dgram_socket create_socket_perms;
>>> + allow brctl_t self:tcp_socket create_socket_perms;
>>> +
>>> ++init_use_script_ptys(brctl_t)
>>> ++
>>> + kernel_request_load_module(brctl_t)
>>> + kernel_read_network_state(brctl_t)
>>> + kernel_read_sysctl(brctl_t)
>>> +--
>>> +2.25.1
>>> +
>>> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipe=
s-security/refpolicy/refpolicy_common.inc
>>> index 59dfecd..4af7f43 100644
>>> --- a/recipes-security/refpolicy/refpolicy_common.inc
>>> +++ b/recipes-security/refpolicy/refpolicy_common.inc
>>> @@ -72,6 +72,7 @@ SRC_URI +=3D " \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0054-p=
olicy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0055-p=
olicy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0056-p=
olicy-modules-system-logging-make-syslogd_runtime_t.patch \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://0057-policy-module=
s-admin-brctl-access-devpts.patch \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>>>  =C2=A0 =C2=A0 S =3D "${UNPACKDIR}/refpolicy"
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#3147): https://lists.yoctoproject.org/g/yocto-patc=
hes/message/3147
>> Mute This Topic: https://lists.yoctoproject.org/mt/117539373/10240238
>> Group Owner: yocto-patches+owner@lists.yoctoproject.org
>> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1486=
6895/10240238/1555622025/xyzzy [wei.deng@oss.qualcomm.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>

