Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736F5F5545C
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 05:22:49 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39520.1771996962497174074
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Feb 2026 21:22:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=TuHBvVK9;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=651653ddfe=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P4r9k73222282;
	Wed, 25 Feb 2026 05:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=wOPJw4YHnF5AkddSpI0GoR
	0PA1s8QJlIyHO29X2T61o=; b=TuHBvVK9ONhgskZwZPOLBLL/MHX/hUp1IgCZwR
	Iw4Pri5JV26hipMPQ7A+BYKoYHaZ/fhsC2vwzAvSzTIMvHqOoSON2RAMY5ENM0q3
	XF9boTTjcv7APr0Zy2ukscsbU+8iAQ7VzgCMMZRj6T2kDrEJpj2teK3xs2BgPA7V
	WLEec0SaXf5SsmgKeX2SFCM/Lz/AA6YCAJxkFVB8PSCD8FM4+qQZF1TKheChPMwa
	xjFZeGK+I7HtXL8+Fdt8On23Jk3tF450xHstzhcXBiLm7sSI04KGwgIGWt0j3zYY
	lJt/Y28TOOSlqQXcQhHEdPx3YlQ0kfUJKeVmYTvwT31h6Ggw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cf3p4cd4e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 05:22:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnG4e4xzrw2EcAbQL9Gu9fNpS+U4wt+dARz67VYoIOotxeok+kVDsjBU/33cmzxjfuWM8j0ZviMon7IfPvHNvP6yVdl42ln4Sz+lZtIRIt5458J8zF7M9bYpFAFJEInMwA9IyexdU/rMsFVuuyPmA/gOVf+sZ7hQQEJelArV8s4syOfpEiMB//dkzjdIoUYUNSls7BMnFdukoHpga5c0pSxLN68z5yy2qQvGIOkBWEJGhzEFM5Ixd9Lf4R86gOl7dW+1V5/nDDqa0wFlZk1Vqgf3bMVIws6LtilGW7NEAmQgpBhtiiR5MtH/WDlkuB0RjYR7VCq/R6F91/Ur67SdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOPJw4YHnF5AkddSpI0GoR0PA1s8QJlIyHO29X2T61o=;
 b=ObuA+JVMhME/atgUshqF8+kBnAzhMLH2njjfiB9aynfDvOLBbUSPeXb5thkswuJmKEaHPItwbUFTeKfbbTYKlXbTPYe9DshkmWUk4Iwww5JSB28e2Vno8XqqQ+yo3RF5wuxT8ZKNix93xf/ywy9c96kZcWfwFKoEskCSWjwAQGt484n+/WYzgz9JK2RewJEmE/J9WZqimTNDD4M+y8ovVrtQWsRBsxmlPK08gzr4R8GAU0KmJWLT5QpjeO6IXWWf1wdM3UpDgiap48WgmdKQVpsYTk49SykZeqCbCS2pF8VnxBB8jG6gv+VttJFGgg/R9O3FeRT7R133JMeSGIZb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 05:22:33 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 05:22:33 +0000
Content-Type: multipart/alternative;
 boundary="------------g30A68LdpwZzG9ijdj1fewd2"
Message-ID: <a9595b8e-813a-4dd0-ba7c-ae0138cff01f@windriver.com>
Date: Wed, 25 Feb 2026 13:22:25 +0800
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
        "Chen, Qi" <Qi.Chen@windriver.com>,
        Koen Kooi <koen.kooi@oss.qualcomm.com>,
        Ross Burton <ross.burton@arm.com>
References: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
 <8d6d05baeee00bfe96dfa816be9affe2ff0e421f.camel@linuxfoundation.org>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <8d6d05baeee00bfe96dfa816be9affe2ff0e421f.camel@linuxfoundation.org>
X-ClientProxiedBy: SEWP216CA0108.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::13) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|PH8PR11MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 196953b5-642d-401a-056d-08de742de112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VEUxQi90NThYVndPaWtRSUl4TTh2My9EbHNkbW9LLy90UFZBb2hUZXBiUzlV?=
 =?utf-8?B?QTdKVktxM1ozbWxaQmZycG5PbHlLc1lZUmV5TVhEUGlmWXdYOURHQ0lQMG11?=
 =?utf-8?B?bXZSdWhYeHpwaEREejhBMlljQlk3SnNyNVdqcXNSbXpCbU16Q0dMS3pKZWU5?=
 =?utf-8?B?SXM0S2k2S2d3U0NXb3RhTmpyeFdWaFZuV0VPZmllYzFhd3piRDByekxKZnVk?=
 =?utf-8?B?blNkR20ram03bFN2UVlpeVpHS0lZK1R4WUVnMjJxbXgwTmRCK0pqOWlZd3VC?=
 =?utf-8?B?bjQ4TGZiNlJPME1BZ0QrRWhRRTZsaENGWWJwaVEwZzNtaXQ2b25RYjJwRXEx?=
 =?utf-8?B?azdrMG9RQklIMmVQckMrWjJDZ3A1enVHeVJvWEhYQ0c2ZWhYVjU0bTJoMmFD?=
 =?utf-8?B?SjJGSWtydlVveTRKLzZzKzlmUjNOVCtyS0h1TFpMZWZjVTBDSFNMbjVMMGtY?=
 =?utf-8?B?SHduMHVmWVpWRnNGL3ZEN1VPRVJLU0FsaEM4TC9IZEJLRUtaWk1qWVFxVWc3?=
 =?utf-8?B?N1NWcFRQNVpxSXRkcFM1WGNiTG9zYktMOURJeG51RytxZ1NHSWdXaFVNYWxP?=
 =?utf-8?B?Mkc1OGlKWU4xTUNxR1pxb01LdHZQQ3FaM290VVFJWHdvUEU4UXVYVUpyN1pY?=
 =?utf-8?B?SnV5V01zZW5BcVRIdnYvZ3BqMy83eTVETVB4QnFJeUpjSDJSdzBFZUhDNitx?=
 =?utf-8?B?dnQ0RUpxUWl0N1dHbWpCRFFyaksxUGJFenZueVlRT0s2dy96YUtLU0NMWEs1?=
 =?utf-8?B?NmNCWDg4WGJRSTU2aldJdWxWeS9SY2lYc2R3bkZyN2NFdGwxc2g3d1hkUHBB?=
 =?utf-8?B?TEkwNEtUMC9QZStoKy9kZmZDT29aQzhwOUx6aWZ0WUs3OXorRzJsQ1lPY1Nj?=
 =?utf-8?B?Q0hqZ3Q5MGtkZmVOYjRUSGRGcVo3YjFLVmlYNHJkZjBvejJadGgxZkF4RmhV?=
 =?utf-8?B?RXE3TTF0ckVCZUhKWlpyM0RBRjEvZ2d1ZzFVSzBHRUNBbzdSRmtpKzNYN1F4?=
 =?utf-8?B?WDdreDg5dnByME1NbVBJcWdReWwva2pqV2xKcGVkTFd1c05uRWdvVHl6ei9t?=
 =?utf-8?B?emdKSWF2MnhQRXVUMCtQUU96WTVpYzhnZVFreThaMFhqNVpwRlNMNFkzR3JY?=
 =?utf-8?B?QkViM1paTGhVdjlVRHZ5Uzh0R0d1SGExMCs2MGFkMUY5SkJaSEkrWE5OWlNx?=
 =?utf-8?B?eGpwOU50UCsyMUt4dnlsYVFFQ1h0azBpVEpvOXZ3SEVZNGVoQ0dIMnJnci9S?=
 =?utf-8?B?NnJtczRVSnBkOENtTmxOZkZveXZxZXM0akpMem03UkIycFBTYlJZWE41OXNp?=
 =?utf-8?B?YzZON0dYWUpLYmp4ZUhSeHhkc1YrUFUvSExXSjk0ZjhMeVJPV2psMXQ4ekxH?=
 =?utf-8?B?Wlp0dDhLNVY4RzBpaFZIcHFNMTZWUk5Nek41VnVYVVlaaVpuRlgwQVJOMUhS?=
 =?utf-8?B?bitXZkd5WjR6R2hlaW5IK2FGSTgybmE5UzhhYTM3ZW8rcGdXWE44cUoxNjl2?=
 =?utf-8?B?cUJOOXFwcHRFNEttMUYwaDNodFRHT0hxL2lKdU1sZGRnMktDYWRRaFBOOGVQ?=
 =?utf-8?B?M2xQTUF2QzA5VzNJUFBRK2gzbjlIejRZRjVCSWxTZGI1U2VzZ0RMNEl6L0N4?=
 =?utf-8?B?OFRWWW5wbGxDNE9kSm5QZXIvS3NwNjh4Z25lWjRqeEpwVmlyUVJvakxBbVJ3?=
 =?utf-8?B?VG9lTVpXMmhPMG9lVTJ4bU5qbmxVb2VZYkdlcm5WOFZCckxXZjlkVEd2NEQ1?=
 =?utf-8?B?aWlDaDdBODZldUlITldhQXZSMVpGTldsWWM0Q0hKTHdRck1jZzJMWUpJc1pI?=
 =?utf-8?B?ODJUWkl1czNwYVV3OUJ4ZGN2MEx2b0gvL3djVVREMjJ0RUltRWZmVFQrcUd2?=
 =?utf-8?B?S2o1MjlRMm9VOVVkK215dDYxRk9vZ0svZUt3Qm4zL2JaSGJyRDNJOEtpN1NC?=
 =?utf-8?B?YTVtTmxHTGx4ZFNidk9mcWM2VGQxOGdXbkNmTVo0aVpXUjFEM3Q4RTNOVUZC?=
 =?utf-8?Q?yBGzrr4Dw6vRrtwrXqfVKy/BRoIZ74=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUVCZlZ5Ry9UczZXUTZhTUNNenVVcldFTjg1L2RzRFhvdHhrakFVK1VXdC84?=
 =?utf-8?B?dVMwUm00U0Vrek9MUWkvUXRWendXTU5mZmxCa0x2eEdES1JlbmR0R2hLWXB6?=
 =?utf-8?B?MmVTK2hneXpFZVpXUGRnTWpCTGs2Q2h0VlhCY0gwZ2lEVlN4c0FDYzd3d0hB?=
 =?utf-8?B?SVJ1NUxSWGtTa2xSNjB6ZzN2U1VXNlNFTEdieUFjcExyVjFoM2lTWnNKQWRB?=
 =?utf-8?B?anNxZ0dGWldaKy9oMDFhQTdjcjczQzJQTk9hV3VUcnV0S2xSOFFjM0Z5SmIz?=
 =?utf-8?B?dE1uWHN2UFFhSzFoNTZTVkZoMmRtN25jbWRBd1ZlOXhmSnY3eVJITnIwTUdt?=
 =?utf-8?B?cU81d0k2c0NmdC9VQlhGZHNrSWhzcEw2WStTdTNGVHdKSENXem1QV3RuY3hK?=
 =?utf-8?B?Wm1nczg0WDM5TVJDM1Q0ek1PLzBOZkFZclNLeEhZR2MxUG1PbFJJd0Fibm1i?=
 =?utf-8?B?QVhuR0dydkxXaWtTZnpHTGxJeGtIbW9JdlJBUm5lOEhnWWE1MDBpczdsZHA0?=
 =?utf-8?B?eExtSDd0dFFDZFJYVUppcXBHZWRqY2kvUzE4ODMreVNEVXluU3cvNmE0ZjJH?=
 =?utf-8?B?NW1FMGlLSm96dElQcDFZa21MWmI1VGhzS1RVazBpaXdsTjZDeCtSenZiL3pV?=
 =?utf-8?B?S3d0NmdGbjcvYmJoemsxaHorSis2Wm9qQmVJcllpdlJxcEYweVE0dzJPdkFV?=
 =?utf-8?B?VnZ5V2tZRkp1K0Fwd3JTeDcxL2RwWUc5ZEtOUEFMMDJzV1VFcUJ3eGhxbmM2?=
 =?utf-8?B?aFdHNmlVajc0STYxN3lpWlU0bGR0SE10VE14aFg3RnNDVzA5TWtsWUx1UkxW?=
 =?utf-8?B?aXVNZ04xMDIwYUpmbjFlYzNvdnllcHNYd2w4eVNmckFGeHY0TGI0Z1ZUNzVl?=
 =?utf-8?B?TWdBYmIvM1hkRE1wQkFjb1RzRVRrYnhGTVo5bzFQRFVzbnBEN0VOb0lrTURN?=
 =?utf-8?B?YXZoTUx3U0R5bkNnL3dYSU5haGd6eThwQ0ZwY1J4a3h1WjlLai9sS3hVVDNn?=
 =?utf-8?B?N1Y5MmFUL2JrRnVkc1A2QTJLVEpZeU1VVEQrclRTeGFDUGNOTEpBYk4ySVFl?=
 =?utf-8?B?VExIRXRSeTQ0K291Q1VUL0VibTlReUZ0Z0RlbE1kamhYcFRoL1Y0SW1XZlZR?=
 =?utf-8?B?QVVUUHF1eWFKT2lOeENXV0R1dWZMMlBJY3lpZjMrRFN1azk4WWxESkFuSlZ5?=
 =?utf-8?B?cGlxaTVsMFZObXpGdUZ5YmdIZ1R4bEpQZVZrZTBTY2UrcUNieEJxeWlhRDhX?=
 =?utf-8?B?SUhCb1lJOVE4ZWpYWUpSNXcrNmF0NmhiWjI3MXozbDZ5bnhGckNOUk9mazFY?=
 =?utf-8?B?dEcrSnE4eW8vRjdsallKeUdSZmozZGNFdXNJdFdSOFIxOVkvWnJBaG1TVXVR?=
 =?utf-8?B?RzFFMUFpdU5kTnFMb2toN1pLemtZY0JzclQxT0RVNzNZcTg0RnRma21PM3M0?=
 =?utf-8?B?OWRPR200MFMzU0phT3l5V085Qk41a28zelllUDVsNkVNbnBDNXBIdWoydGJj?=
 =?utf-8?B?N0d6WW4rUWx1d2FjdVZLWHlRVFdqbjMzOTFzOGZHbDJkZDJsQnF2T3NWUGhq?=
 =?utf-8?B?OHpIeGM4NHgrMXYxaVh0dmlJMlNjdEdOeVRDRVRCTW9NQmJPaVkxSWNXeUxm?=
 =?utf-8?B?aUtUMXh0cVhYb0JEK3ZROEFlV3ZuSktDTGVWTjd1QTQwYjFRQVYxNUw0YTFB?=
 =?utf-8?B?aGEvMWxmcEsyWXpUUUVuR1dnMUxJbmo0SUpnTko5dmxMUTl5eDZNdXhkVUs1?=
 =?utf-8?B?Q1J0MkJKdjhySzZnZjJ3UmIwY1N1a0wzaWpURmx1NjVtZzE4SHN2K3VWS2ZE?=
 =?utf-8?B?N1NXNXpMWWMxOHNzemVvNnFsVUtXbEs5SEJycFQvUmlPRlhUQ05RUytTWkZ1?=
 =?utf-8?B?dzI1VTA1NDVZdkJUdndacDNDT3dDL013TGdPalBaSENJc014Z25hT3lZVFBk?=
 =?utf-8?B?SlNOMnR2WDRiMW94K01xYUREUTU0azUvTzlOZCtlSXRmb0hkcHpOaGFLQ3dD?=
 =?utf-8?B?S01tVFl0eCtveUZiYTR1ek5jVU5neGFvSVMzNUVmaWx5SGRvL3R6YU85TkZn?=
 =?utf-8?B?SGZUWU5BVlkrWnVIanU4OEZWUSt0NGVKZEZCUm9ZV21vOVYwYTY5djBxQ1Q0?=
 =?utf-8?B?QzF0WjRkOGczTlFiYk0waFJqTkxsT3B3KzdsOWxrdmlDdGhVYXl6UEVrN0dm?=
 =?utf-8?B?d21VS29IdW1iUHpPM2lSNUx3T0JVQk42SC81aFQ3TThuZmRuU2pja1dPQWl5?=
 =?utf-8?B?b3Z4SHB2eWZFd2VHY0VuTXJvd3F4RE5xVi9YUmVpYSs0RGVPdVZjYXhDSnRB?=
 =?utf-8?B?WFpsTkxhdUM3ZjZHZzd4M1NjcEVMV2o0NnFVTGUzQXNJTmVIQXNhQT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196953b5-642d-401a-056d-08de742de112
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 05:22:33.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kP71nO1V+KRLQp0+E2/KgMcrIpNDb312FW3ApYelkts5Dw+X4TVPSUrXV2nryam7I3f/1Y5amrJSlzlJO85/2DCNedVia4tZ8XxnUWSyIV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7965
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V4xwEOni c=1 sm=1 tr=0 ts=699e871c cx=c_pps
 a=t5Pm7pJ6jXSUtateXttj1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=iGHA9ds3AAAA:8
 a=Q4-j1AaZAAAA:8 a=eKs6hjrnnnHfhilUlXgA:9 a=QEXdDO2ut3YA:10 a=ag1SF4gXAAAA:8
 a=wvPkM9v7g1_ikmSEda4A:9 a=hnhWE5TvWu-nOCaL:21 a=_W_S_7VecoQA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA1MCBTYWx0ZWRfXzs38dIOCjbX2
 FMjF5hCbjv5Dmj6f6ib7ryTmW6W6S6pq7ueOuj9dltYZODj9HhhYMWiw4NGaazb0KZWpxecXZBw
 wBj5gGE5xxGj4eerVMLPrv3dUhGHNWKkhR1RZpZCTV/paGOGhf+bagI9yQJGMT/0VFav2APQ0eu
 ZYdpMJgfxAPqLbAn9o6OZw3fAD3KE4hmE3R0laT3nmBQAV4pXRv1hHZPvVdBynxNfEv5vIcXJjD
 xdqNXt98qYcaJyq9tKF7NWqdJY1hWKdj6dSks8dJK0RIcZvm2+UpSY5Uxry7Z/d1mGU5GdjWSjz
 F1BHePyMKOfDF6GenPRMQMZsBUArE2YqCNMcepkLpQXrPnbD5qPqvzFpjdl4BCwfDSHyi9T2aoG
 9xa9Myt72GV5WzVvW95IyDAyT8rmb/8GPuUZmwixp4gFqyAS0ct2T6afbzwufY0ZlxO+tGA1zxJ
 QvpKMAXcRdl1sqbFB6w==
X-Proofpoint-GUID: uenU08ghHLvY4hCP7UG4WPWIsxxBNBaA
X-Proofpoint-ORIG-GUID: 1MnpqG0_YqoZwVcVwqiDM_KT30lKxZK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250050
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Feb 2026 05:22:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3277

--------------g30A68LdpwZzG9ijdj1fewd2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

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

Hi Richard,

Ping, what is the status of the approval from Yocto Project TSC?

About the suggestion to rename the layer to meta-ai or meta-llm and 
collect other LLM applications, such as llama.cpp.

I am open to it, but I strongly insist to maintain meta-ollama as a 
standalone layer, further more, if we support llama.cpp later, we should 
add it as meta-llama-cpp

Then we could customize and isolate each LLM application in a layer, 
including:

- Add model recipe for LLM application, the format of LLM differs for 
each application (ollama vs llama.cpp)

- Boot up LLM application for Yocto image, add systemd service file

- Customize GPU support (CUDA) for LLM application

If Yocto decides to use meta-ai or meta-llm, I suggest to add 
meta-ollama and meta-llama-cpp as the subset of it, such as meta-xx in 
meta-openembedded

//Hongxu

> Cheers,
>
> Richard


--------------g30A68LdpwZzG9ijdj1fewd2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 1/31/26 00:56, Richard Purdie wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8d6d05baeee00bfe96dfa816be9affe2ff0e421f.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and know the content is safe.

Hi Hongxu,

On Fri, 2026-01-30 at 13:20 +0800, hongxu via lists.openembedded.org wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Would you please approve to add this layer to
<a class="moz-txt-link-freetext" href="https://git.yoctoproject.org/">https://git.yoctoproject.org/</a>, I will maintain
meta-ollama for recipe uprev and bug fix
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Thanks for sharing this, it looks really interesting and I like the
idea of it a lot.

Also, thanks for volunteering to maintain it, that does help alleviate
various concerns.

Approval for this rests with the Yocto Project TSC so I have asked them
about it. We should have a decision after our next meeting.
</pre>
    </blockquote>
    <p>Hi Richard,</p>
    <p>Ping, what is the status of the approval from <span style="white-space: pre-wrap">Yocto Project </span>TSC?</p>
    <p>About the suggestion to rename the layer to meta-ai or meta-llm
      and collect other LLM applications, such as <span style="white-space: pre-wrap">llama.cpp.</span></p>
    <p><span style="white-space: pre-wrap">I am open to it, but I strongly insist to maintain meta-ollama as a standalone layer, f</span>urther
      more, if we support llama.cpp later, we should add it as
      meta-llama-cpp</p>
    <p><span style="white-space: pre-wrap">Then we could </span><span data-slate-fragment="JTVCJTdCJTIydHlwZSUyMiUzQSUyMnBhcmFncmFwaCUyMiUyQyUyMmNoaWxkcmVuJTIyJTNBJTVCJTdCJTIyaWQlMjIlM0ElMjJ2TkE3SmtyT3ExJTIyJTJDJTIycGFyYUlkeCUyMiUzQTAlMkMlMjJzcmMlMjIlM0ElMjJjdXN0b21pemUlMjIlMkMlMjJkc3QlMjIlM0ElMjIlRTUlQUUlOUElRTUlODglQjYlMjIlMkMlMjJtZXRhZGF0YSUyMiUzQSUyMiUyMiUyQyUyMm1hdGNoZXMlMjIlM0FudWxsJTJDJTIydHJhbnNsYXRlZEJ5JTIyJTNBbnVsbCUyQyUyMm1ldGFEYXRhJTIyJTNBJTVCJTVEJTJDJTIydGV4dCUyMiUzQSUyMmN1c3RvbWl6ZSUyMiU3RCU1RCU3RCU1RA==" style="white-space: pre;">customize and </span><span style="white-space: pre-wrap">isolate each LLM application in a layer, including:</span></p>
    <p><span style="white-space: pre-wrap">- Add model recipe for </span><span style="white-space: pre-wrap">LLM application, the format of LLM differs for each </span><span style="white-space: pre-wrap">application (ollama vs llama.cpp)</span></p>
    <p><span style="white-space: pre-wrap">- Boot up </span><span style="white-space: pre-wrap">LLM application for Yocto image, add </span><span style="white-space: pre-wrap">systemd service file</span></p>
    <p></p>
    <p><span style="white-space: pre-wrap">- Customize GPU support (CUDA) </span><span style="white-space: pre-wrap">for LLM application</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap">If Yocto decides to use </span>
      meta-ai or meta-llm, I suggest to add <span style="white-space: pre-wrap">meta-ollama and </span>meta-llama-cpp
      as the subset of it, such as meta-xx in meta-openembedded<br>
    </p>
    <p><span style="white-space: pre-wrap">//Hongxu
</span></p>
    <blockquote type="cite" cite="mid:8d6d05baeee00bfe96dfa816be9affe2ff0e421f.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">
Cheers,

Richard
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------g30A68LdpwZzG9ijdj1fewd2--

