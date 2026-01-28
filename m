Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24398D35666
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 02:21:59 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4381.1769566913929997396
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 18:21:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=UwIGZtlD;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=548830a489=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S1VFwl2458826
	for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 18:21:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=kgPcRm+NVOj/mkLxe5TyYS8hayRTR//EEzIq185ZIl4=; b=UwIGZtlDchrm
	PO61xCl8nMr2WaUbiWyaO+wY2eMH3ITJDTRRFl/nKVQ52uwmbvbfD9zkjKmVzTHy
	BPl2GnDEhyeb0irDP+/eQy6fTT0r9WmcD8ZPEjHBo2tPMvxSGyJCZV0PwshiBmOg
	QYjmFl6dp8BUExj7L1h6vyLHu75domE5Z7diauMpkWYlDq6PF9dx8CrvQmFOPscW
	IWJPWTElUm+8UnRrDRxmb9h5u+PtIBX12U/aW1Us4A2NKequSeMIG7z47Ew4drD1
	4k+do9OU9exgjGNlvCP+Wq+87BhJ2N0qA4u2773GEWsjFhxQXUaDctiqffCR1b2r
	AJJVg3A63A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvt85c5fc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 18:21:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OF1YIHrZEY9W57cWoG9OV73H62fJjcjCjx+1tTDXd2nYwA03jw00uOz3iAZMoa/j+l1XkWoJ+1pSndml162pKOoBBKmDZttrqHex9GGf7vagZdcMcqvkjE/s3d+8sAiyO4hl8hZXU7rkUn6ZlIfuKWqjFTyvmHs7quwuiyVfqURWABjUPEnaoTJbfp2bg7ULl7h4YeNL6ZJdTOvU1doQC0wzwpQf3uLUcUNoYUWS4S3uO7ihtA9DSXBhQRV6VHgDO9+cT39nL9zQ/J088Y1oj2dpGI4OFrCE/27fngIfVB8jb3jxNwPlwa2ldMEHlPgaHkhcRSQaKYc2DZAKBGtInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgPcRm+NVOj/mkLxe5TyYS8hayRTR//EEzIq185ZIl4=;
 b=pZG2Rk/iQZLtva27e7f8CUL6vTUFnk7pGEveUwSvk7Ek1i+qp0srPtzhjwgGLpP+jD2AyzkcX/uKc0r33ph3DAFWEdUaHcD+KbMNi89EAM4z2OLkbfv6bRSI1tqThGAggF+VrvbIxAVLbQB5TsUrHli30/WY4IrmeDOwPkGv987wzAKkmf4TZFuE3I672IFgjm1j+sYyuMCTSkEyA8NK0GY9J2pKjpIpzFTlxskozQWUDM+tePnTVq5wtHr7EtzikFBdI4cw/qUbmIrSx7XfZu0P/dX7DhLvDPufhUlBSaJRrvFlOOdeaeYkH238OKJwY6WiSmdKebjfaanTkcHdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by SA0PR11MB4733.namprd11.prod.outlook.com (2603:10b6:806:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 02:21:50 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45%3]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 02:21:50 +0000
Message-ID: <ee18df0d-3770-4277-a55c-2dd38e5cc5be@windriver.com>
Date: Wed, 28 Jan 2026 10:21:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow] tensorflow-lite not buildable
 since 3.14 python upgrade
To: yocto-patches@lists.yoctoproject.org
References: <8087c0ac-48db-4682-a3ff-28da284f351a@cherry.de>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <8087c0ac-48db-4682-a3ff-28da284f351a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0097.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::10) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|SA0PR11MB4733:EE_
X-MS-Office365-Filtering-Correlation-Id: ced093c4-4e88-4a05-77bc-08de5e13fe8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bmVEWnNzRnNEbmpiWFVYYnNKQ3JIM1hwZXdqSEFCcUI5VzRBVDdVRU55VlRG?=
 =?utf-8?B?UEZKQ3NUT1kra3Rpdm9kcFh4UWh5TEVjaW1oVWFTTjJUYlNnemVKbldYMldw?=
 =?utf-8?B?TjhVNjJ1N3FVNHpWOG9xUzcvSFAxWUxhb1Z4MFpzRVlKT0hGYmlnTlVMamRL?=
 =?utf-8?B?THhkNFU2OTNxM2ZSQWpOZmpjZVRHemtVY2FHR1Qva1ZvSzF2R2lFUkFIT1Rx?=
 =?utf-8?B?YXB6cEQ0SWJ5N1JjOVpIUi9FNndnWlZNRXRoTktoR0xHZENCRlhtSDNvZzhU?=
 =?utf-8?B?NzZCRHpYdWZoeHJ1c2ZJem5odHNkRE1TZk1oRGJEeXhGNHFzcXRZZlNsQkdk?=
 =?utf-8?B?WDdONzFrMWE3czN3TGo1eWt6UXEvOTN1c2FlYlJKdFlBY28vR2c5UU4xWGxD?=
 =?utf-8?B?YmIxTHh2UmVXRGVKYTYyY2tJeTVaS2dRMHFSYWFlZmhGMXRsMnNDYVVuUFo1?=
 =?utf-8?B?eFNzbDZnbEFsc3VVY3MreWwvZ1J4ekVuR1RISTFBTGRiV3lOcjB5REJGSndQ?=
 =?utf-8?B?ZzltdElQR215cjI5RlVJdlJZUDgraUVOYzZEemtFUXNsd1dGdHZaL2xJTE5z?=
 =?utf-8?B?cVZzb0hnS2V1bXdWMVA2OExrcTNjSzlVN3dOUkl1T0dORkwyNDhaOXc2N2VI?=
 =?utf-8?B?Nno4d3dNQWJ3a0ZiYlJYMEp2VTV6R1BRcHltcTJCNXpQS2Y1QUlRbkt4aFpY?=
 =?utf-8?B?MExyQW10TUk0VFIrNk1XdkpnY3VEOFdqeGF3NXlNOEdZai9xcFhQaHQ4a2Zh?=
 =?utf-8?B?Q0xWZ2Fnbko5bHpRRVQvdUNQVTB5TitxUmtVcXQvZmVWY2VuV214VWMyU0gw?=
 =?utf-8?B?SzBOYVNNL2Z3NVF2OTJNanl6ZEhqc1UvdGMvZHF6ZkQ4ckFyVzBqV0JoK2dW?=
 =?utf-8?B?YzhTWm42cUxpcGpWZFMyQkZadzlzbnJEYVoxUkkzWmRhYUEvd3paM2tKOThV?=
 =?utf-8?B?V3dyL3NxRjgxL1E2SU10ZFhCeHFITHlTN3FIZ3lGVnJ2amFDc3VtQ3QyMTYy?=
 =?utf-8?B?K1BGSGIzOWt2QkJaSGxDTTl4U2xITUd5RDk5NUxmUytsdVR2T2hoU3hXSEF2?=
 =?utf-8?B?V2JFVHRBdEtoMVo4MzJFZGVZbVVmalc0Y0p5QUEyQmkzT21UZ1BZaHNJeENq?=
 =?utf-8?B?d2t5bll2dHdwSHFPeDd2TCtnT29EU3R2NmZSY1hMbGU1ZEhqN05xK0VWNVU3?=
 =?utf-8?B?MGVLVzVPTytHSW5MUE9ZZmQyK2ptbmJFd2s1UnVxOGVKa3N1dDJIeTVHYzJx?=
 =?utf-8?B?Z3Qvam9rSGhuZFBDYk9mbk1TUG5SdC9MVUhyZTNhRXp6ZnRCd3hHZWowZExJ?=
 =?utf-8?B?UlVDdjZEVXRObm90N2VqZjRSYkI5UURyWXU0azR1MFZYV1RqK2NPdEY0RVF0?=
 =?utf-8?B?QjRkV1BydTQ4RVhndGs3c2g4VDk0TE92VSsxQWljNitmaDhYS3dCY09PLzQ3?=
 =?utf-8?B?ME1sZVlWSVR0Q2JXTC9kQ3FkVEllVHFYQVVmUGFQTGR4U0VRbWJRUHNKK1NU?=
 =?utf-8?B?eDJkdEdMVmJYYlRsYURyYnpzZ08zc3BrcVBBT2VaV21hYU5YUlUwL1R6R2lh?=
 =?utf-8?B?Y2lKV1lCVUxiTDdwdXVITkx4S2g3MjgzWmhZczNWWTgwTCsrWFh0ZnJDckFq?=
 =?utf-8?B?S0JZY1I2ay9yYzVXYUZiT09BblFaaGo1bTZwQjR5ZktMeFdXTGh0LzRQZ3d2?=
 =?utf-8?B?M3RNNEVaeUR5SmZ5RlczVmI0dkx2MXJ1UUxVakluTk9NT3ZzVjlHT2s5Qnlu?=
 =?utf-8?B?cEVWQXdNdEVGYTRxcGJlbzZaVW9oSkhnbktpZTdMaDVadTQxaVc4SU1kdEZ2?=
 =?utf-8?B?NmUzUHQ3S2ZCeG82dlBTQU50S1BYVmIvTDloaHJMQWF5UUxBZzU3L256dHlJ?=
 =?utf-8?B?dzZxblFDQUN4bGRLM1lXSDhZeFdNRkgzZUExSnVBSU0xZFNqOEdWdmRpaFVa?=
 =?utf-8?B?RjBTa3pFRXpWVFZBRW9EdVQzR3VUSjdMWmtmS0hiUUp0S1BXTWx6Z3FIRU1H?=
 =?utf-8?B?TkRSNEV5cmQydFN2a2F5dUdoQXRwN2I3UEVLN1hkWjB3dkFQazIra1NlQ01W?=
 =?utf-8?Q?SP5V8P?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b0xRdWRPWVVnUCszWWpWTnFJa0pKdEx2SEU5NDBKdDFLbForN2Y2WDM3cVZL?=
 =?utf-8?B?TWFHVWNOMDd4RGdmVkliL092MzdUSDhPT1d2a3NsZzFOZHgxK2wxRWlzTTJp?=
 =?utf-8?B?aDhEVTJySjgrY0xOcEdHQ1ZUUFYzSWJCY0hrb0VGRWRTMU8ycmw4cmtob0U3?=
 =?utf-8?B?d1hCcFJDTC9ieG00L1ZnclRtM09CQmw3MTRXWjNuNitZN0YwMFNJNG9VT0Ny?=
 =?utf-8?B?VHRZbjF0dEx2QzJlZ2RodUNnQXMreTRSRy96dDJsZkt3SmJLNGppeDR2b082?=
 =?utf-8?B?TGsxRFU3cUF5LzFLS2JPOWNVc1lZNzhCa0Y1VC9NcFpQZ2tITWpmeEx3c0dV?=
 =?utf-8?B?ZDZIcXZtNWtkeEJoU0RwdStyVDczMkwreFJPYkZyWmhYZTRXNmpUOFVnQW0w?=
 =?utf-8?B?WldkcTJrSnZwYzNZL2NkUFhFMlFoVHdyekxUanErZ0pyejBZNjdnSFJqQ2Rl?=
 =?utf-8?B?MThmUnA5YzFBaU9KNzRNQ0pYdGxmNHlncXVFL0JDa2FoM3ZaZU5tdk9jWEhz?=
 =?utf-8?B?UEF4VGtuSUdMR1NHL1k1SjB2Q1Y2bEk1UEtSRmhEYkZIczRKdzlXaWlDOEZy?=
 =?utf-8?B?b3M1bnJuS3poMjl6ajdhTHl6WUxoNWdaRmhvZVFvYWdyZG5yUGlkY1Y0TEg1?=
 =?utf-8?B?eHA4SjRXeFo3aUkySXJhRlE4NS9EblpMS0VuNlFjaEowVkdZSkdNYlphckxH?=
 =?utf-8?B?UXJWcUpQc0xwaHo1VTBGYzE3ajhVNFFtMHRhbVBtMnNIYTVxN1FuL3hRN3Ix?=
 =?utf-8?B?U2g3a3dsYkZpZkhKNWNDUFVrVlpmbGpMempLYUZqOEl0ajY0QzBZVHQxL0U5?=
 =?utf-8?B?R0U0bnpYZkFVYkFPRmxhOWx4Rzg1K2dCeUNhT0dFL2sydDZQT1Jta1BzOUkz?=
 =?utf-8?B?Z25pYjFlL0ovMGlOYUYwWEhXWFIrNzZhM21tTy9jMkUwVW95azRxNi8rOXpt?=
 =?utf-8?B?eWtTS1NRcUNtYjNHR0x2dVRVSGJEREVzNVJZczZ2NHNUMU9PdlNrYldHOUk0?=
 =?utf-8?B?azRrZFdmUjJoazRDdk9UZXlrRDR1MkpMSHdaRXRNZ0dXekpSem9ob0U1K3lK?=
 =?utf-8?B?Z1owVDdhRUNDVFV4cVpRWVhQSE1HTitFMWx5ejBxSkxkU0Y0QzZyWXNoa3k4?=
 =?utf-8?B?bWtqRDFIbURMQzFVUmtrYlJoWER6U2dSeS9LOHJYZXg3cCtYUENBeERCc0VV?=
 =?utf-8?B?aGN1RGltVUNEVERkRmo3QzJ0UjYxTHZkT0N5c25kZDhtUUZubzFtc2srU2t0?=
 =?utf-8?B?aFNBc0xUdmgyb0NKci9Pb255cFhGN2lwY3hmOVdKcXpMdmJoWVkwRFY4WlFN?=
 =?utf-8?B?TmxGVURxcnhncEdHU2plMGJ4djBvMTZMOFF6bWRlaDNHQ0FFUkl0TkpJak9n?=
 =?utf-8?B?eEluV3lZd3RFdklNVE9wYlN4NG8vWmcwUEErQThVWW95ekJuc1h1aEFDR1Vx?=
 =?utf-8?B?MEE1cElQUDdLeklwNmJ3cVlMc1NaOThxOGF0TGx0akVSVTlLNW1SMGNxeEsx?=
 =?utf-8?B?akdqcDBreXR4VEUyN1ZHY0k2NERaY01JaGQ3bmNzQ1pIdVc5UkQ1L1ZnY2l6?=
 =?utf-8?B?L2s3dUxCanRhSTZEd25LS2RyL1lmemd2ZDdvcFM4cUdqcllaN2xUOVdyRk43?=
 =?utf-8?B?M0FZOVRldGQrOE1Ia1ppNjRIL29YS2JVd3UxT2M3QytjanFMTDc4YUlUNHZD?=
 =?utf-8?B?Y0xFeFQwRndMdnRwTTJYTjNBYXcrNGFwd1FQcDVzOHhZTjRqa1Z0RGNjR2lp?=
 =?utf-8?B?SWVtSU9QZ3FtSWIza1NPaHNyM053NzlNUUprV0lCRUVZWjlwQTJVcWdIdTE1?=
 =?utf-8?B?NVR3NkZ1cnFHdDZSeCtoTGRLZ3kwMWNKMEZmYWJlNWp2TEhxSC9SSzlyUWNG?=
 =?utf-8?B?aFAxSHA5NWNQOTdSaHZENWxGQkhzR2FRN0twK1ZSenBxVW9ubmJKRzhURzJV?=
 =?utf-8?B?U29wVFZIaExQV0tZYXNGcTZSenByWVdEVm54YjdiTGN5bFlmKzZzc0huK2NC?=
 =?utf-8?B?eGYra29aajBZQlVoZVppK3pNZ25lYUxwWW92VEs5QmRZYTJEeVVkejByakh6?=
 =?utf-8?B?NmJtL1AvVEFNSTM0NGNBcVI1cHJBelJ0RWt1eENUMGd4bGlpeXpNUlJRc2Yz?=
 =?utf-8?B?M2RTeGlpeE4rd0ZmejRacldwYmhYTmlKcjgrcUxnQnpHUTlLNldzaUpRUXk1?=
 =?utf-8?B?YjFKMWlzN1UzT09pWkgvc1k4bk8zM0tDRWhjajhoOHlCTnJycDdxMlI2bHFB?=
 =?utf-8?B?aVRQakErL0drU1hBdkJIRjJQd0pOS1FXcHJkMW9RMENyckxFUGljbkhLRnZj?=
 =?utf-8?B?SjNyZlhYT2tKM1lQNFhleWZTcUhaNVpHajBvREhHRDloL3NxT3Fmdz09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced093c4-4e88-4a05-77bc-08de5e13fe8c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:21:50.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nOFwsvwkt0vBLPXBT9Iu1AuhTom57RMaVk55FdUfTDjlaHJN5y0gFGidCcI0vrE0pJu5t7y+asx4QVJc/w9OvYPNG6tyJhAIf7XHj8qZSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4733
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAxNiBTYWx0ZWRfXxq3PAd75Z68M
 oYQNJkBgu4tin/pi9gz8hcWVqd3OY8j22aaypzE9sgFW4OafGMjfcCP5IIc9eJR6CkE6MuTPKIL
 nvB8Lfm5lZ1WIP29kq608yuyxSDzD/nEPWoV0YalnGFh6nUYXJd529WNSJrjX+SN62Xs5qIIGEB
 ffeYv5P6DDiR+xt5dysuSoGffaWH6k+01j51qlzxTe0HMUSKQ6YTpSVFpDChs4OEAfHjCn5JhxE
 hEwnK0U/9Y6ohVDiTHK8H25mkrP6Ap7aOmA58eJVOEobRod5smVqEJ23Vq1EnqaHozW5LTaB4AW
 IqGzb4A45dS9a92vPg745FHvmKFhHLJ8nkrpVJddO6GMGmPBHGsic8HP6VcYjpOJveuxrzBo1CJ
 jMsq8ldzsl4aASS2rdEcVbhabiW0FjNZRcBNf6RU4FIqN9trXENX8Ov1F1I1WQVFn7nOK8qgFWT
 ViYGEviG+1Y+h6ZDVTg==
X-Proofpoint-GUID: jYCdEGIuLEYvx9CIRs2QpbthOPW7Ortc
X-Authority-Analysis: v=2.4 cv=M6lA6iws c=1 sm=1 tr=0 ts=697972c1 cx=c_pps
 a=ht+bKkBNmLq2ln/DE6MnYA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8
 a=ThEx_QyDpc0v2QZUITEA:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: jYCdEGIuLEYvx9CIRs2QpbthOPW7Ortc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280016
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 02:21:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3122

On 1/28/26 01:29, Quentin Schulz via lists.yoctoproject.org wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
> Hi,
>
> Just a heads up that the tensorflow (I tried -lite) recipe(s) doesn't
> build since OE-Core moved to Python 3.14.
>
> There seems to be *some* support upstream (and plenty of people
> complaining there is no release with support for 3.14 yet) but it's
> still missing a requirements_lock_3_14.txt file which is the first thing
> that the recipe complains about.
>
Thanks for your reporting, we have to wait for upstream to support it [1]

[1] https://github.com/tensorflow/tensorflow/issues/102890

//Hongxu

> Cheers,
> Quentin
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3118): 
> https://lists.yoctoproject.org/g/yocto-patches/message/3118
> Mute This Topic: https://lists.yoctoproject.org/mt/117492755/3617049
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: 
> https://lists.yoctoproject.org/g/yocto-patches/leave/13176071/3617049/43253763/xyzzy 
> [hongxu.jia@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>


