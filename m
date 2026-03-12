Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E032FED2C4
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:44:14 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13846.1773287052655474514
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:44:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=gwZyQ5OT;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C1wXFH855255;
	Wed, 11 Mar 2026 20:44:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=IrcWobpoB7GATvTK3dHkE+2KvkmDaQEiZ93q90uLoxc=; b=
	gwZyQ5OTKyZz3cm2u9I3CyaBh5ExNzUfeVcYuc3d8FuO6l5x/CdRnofFAcu86sBN
	7wns5Spq2/+pKlYc3mMu0ro1EokIOFI6WlO/PWN6ziEeQOab7sAYIZ4qomSHGcVu
	Kq1mPro865QJN4G5KzmBhEC3STY8oFe5Q2C2o6FQLUTq0xRHqUVZnFwDcwwUDSqB
	fwkKXR/8Op9y45dpEhRCNrkZ4znHwm+nh5/AryWqVjEY1qc/n+4wpHMM5O9dafbt
	01p5Ji15c+tdo8KfPQsj4qgWCFkI3/x2zt0TfWhVELlvXnotaC2o3YqoEtpaSBp2
	hory1MNUdGRtpIc+AaIpFw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh6t87wf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 20:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuwEjazwV8L6d+XzI/0JUWPOEwo/ZDyHKU1WzPuK9g2YeNxRRAF9sGsZQRs3GECPDpFKo3swAo0KsFA5/KPOj2uODlN7KmuB0hrmXvff/FEoTI8V3L2MHsaAQ6Bp9WU352Hqk3tWIYDUifHAvx8hRH2Yof9mI2TkPNo2IdnLEsNZSQt4mk+sunKcX7DDphkSKcHxK9RtCQEA7BtJYMyW05ALJaXbXxQ8V9Qh5+xIfuuctoW3fmSUZFI1ZIzhsMFISeH5qkA6Yx5efRfyw5iQSFPJLVm8y7xzrdIzEhrwJNX9saxFe7CIoywNzbeVB8fKldgBLpT2kLeIHS3W8pRZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrcWobpoB7GATvTK3dHkE+2KvkmDaQEiZ93q90uLoxc=;
 b=fn10bYkMBINN1oxN1FH2MGz+8R47eaBFGYAgRrfxQlgL1i1+29tbksCFbZibwPfwjh81fScsCFDrxi6zKmb+f5/58+dH5txrm09xa8YTaLZ2dyFqfNKhO9ZvQ/AVBQSWSmKtpjDSOUFRJgf3Gnou2Gm+D2/GVuLogaR/3NUfcBooflDvoAApdYmbKKZfLviCcR/BdunH53ehjnqYpM8Kj2ozcCcuSJYv9LBL6E8B+sDIY9ht4SWCKLUMiJ4Fh4jOpxQGH+hfbqg6jSjOl3bfwQt/wWFb9qDbe1XZ8gIHYqj0X+whUCVVv230M+NP41VRvSjWcrfj/QOdeBBjg/jddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DM6PR11MB4515.namprd11.prod.outlook.com (2603:10b6:5:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 03:44:07 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:44:07 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        "MacLeod, Randy"
	<Randy.MacLeod@windriver.com>
Subject: RE: [auh][PATCH V2 06/12] modules/utils/git.py: include repo_dir
 information in the raised exception
Thread-Topic: [auh][PATCH V2 06/12] modules/utils/git.py: include repo_dir
 information in the raised exception
Thread-Index: AQHcsSMVPPbzo9TITUKKQkUFnG0XPrWpsxeAgACPeyA=
Date: Thu, 12 Mar 2026 03:44:07 +0000
Message-ID: 
 <CO6PR11MB560222D0F854CBBC58C8518DED44A@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20260311064813.619683-1-Qi.Chen@windriver.com>
 <20260311064813.619683-6-Qi.Chen@windriver.com>
 <CANNYZj8ZA0vN3FuUNaUktXvL_XpFm_GT=nB6g0KJQCz2Yx-5eA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj8ZA0vN3FuUNaUktXvL_XpFm_GT=nB6g0KJQCz2Yx-5eA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=08f503e0-41e4-4f47-8484-bfb0b27a53c8;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-03-12T03:43:43Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|DM6PR11MB4515:EE_
x-ms-office365-filtering-correlation-id: 30d282ab-c51c-4df3-77c5-08de7fe99d34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 z+qce0h5XtVyeRU+kA3BApM8jgVJislcb5nnH9RrGYFcrmNAd5asM6oGFtqsoK/OUeoLy/uOqgk2NdfaeFU3dqJysezsA0yfmJBbl+0V733YLlyoykKSgjShP7UnzOJTuRGhyoSY/H15TCmKIhKmBNApUm6UWURpNfihLTYMq2oiVK8s/Q678IZwLwPWQy11YNn4Bxpqvitt93zlEFNGr3ND2X3u7KkfaMdfVToQiQLOuI8NslkViAgaU8VEg3CbLY3AfdGwOSihWqCvODT6gjXrK4GPTaDyHNY2ei5qDsPCo99izKQQ6S4FQ9U+yxr/FcUcwYc1M0h0NezrI1u43DYt+eF5CCs+yWmqnGpM0rA9S7PhEJsa8AYA7ondXIpZaWn+gBbdki2mxjEyPjljuNhPtK7oEfaQqnkg9wR3qjBUMQN83OOx5YDVQWMEHLvqqyeh9aaJ+7NKgQzdiLWeq+5SuyriLQtVKhTuwY51CDrMIIuaomgLTcQ9zDYv5PhXdUt3eGuFqbgatz9rgso3lmWyjRlW4Pr8/2w5HgIj/AfaBkLByrx7AREBBUd85qdAekh1VGD5soKuRBB9PKMKCWCa+0ZXHv/Fc6hMfs++E24OsoH8km6OvlqvkoApJ/5IIHAv7nbZFLECCC4boIfVFAYDy/+otanr1Vt2bsdk5oreDzBIc7z0z1hCfAupXeRd96oKrY3md6jakI4Qlu2a1bLhGIKS/bL5yx1h5FM4MtppQ5c7FWgKfr77kHHO277IexOlfVHlGYVZVl6tfBHQcDDrJsiAwxfpj2598OK7uVc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cytJdzJvbW1uSVN1MkNXbzB0UWpKRGdjUUJRK0hZYk5iN1lwTkEwZDBkY3ZP?=
 =?utf-8?B?VzdtdXh5ei9razNIWVV6N3d3d1dDaTQ5bFQ2OVlHVmJUY0dQQmc3TGE1RzRa?=
 =?utf-8?B?RHorK0tVakJ4Q0NqdE5kSkU3d2p4L3plZEsrblV2NjJNQWJ2ekRKS0RwcUk2?=
 =?utf-8?B?bmNOL0lPTlJNZUpyQ3RPY0Y2ZXBYanU4VkR4Qm45d1dBQXVCbzNCVWVVaEgx?=
 =?utf-8?B?SHlQbE0xbzJGM3pMYk96N2piQlQ1a2Q2RkEzTmE2SkhGcjJKWUFIQjRzQ1dv?=
 =?utf-8?B?UzNmVzVFSGxNQmc3dExpSVNad3RkYlhUUnRKYldpaWdOTitJNll0Q3puYnhj?=
 =?utf-8?B?R05VSTN1am9RM1pOWW1RSnZDRStZb0I1YkJGcnFzVEtFb212WUlWWFExbUVh?=
 =?utf-8?B?aU5ZcDBWNjFyejJ0a3Q5QjZPZWc1dGpXaWUvUEkxREVsTERmcjdPdEpheFJF?=
 =?utf-8?B?enZ4UkdCcEJxcDNBUytyRFJpaHY3c2x1Z1VQSnFCS2llbS9TMkJWSm5uSVVa?=
 =?utf-8?B?Q01yd3hMUUMzcGJQVG50aHcyVTJUSC9LOHZoWndXZ1hkZCt2UWdpNGErc1pW?=
 =?utf-8?B?OVdXdnBqQ0tCZzJNL1NVYUFKY2V1WHRLL2RGMDhaNXhNZUNVaUVlZ0gwQmYw?=
 =?utf-8?B?bnVVb3dTTGV0S2VuaEJZMWx6eUFYVXB0MU15M1lhNGVBdHREZStZbmZ0TStp?=
 =?utf-8?B?dkE0THl1T1FZQVVEUGtNVzdHeGxNZHo5VldDY0RDY3dHcHRqUXNDWFNoMmo2?=
 =?utf-8?B?TkFtTVY1dFJMd3dESEJxMjJ5Mml5aHZuVHI2dGZoeEpKdnYwK0J4TGxzYmNJ?=
 =?utf-8?B?OUN4MlFSZk1uc3B4SFJXb0I3YjZLaXdXeVljZC93WTdFUWd1NGF0WW41RVV4?=
 =?utf-8?B?dng3WlFWMmE5VkNMbWxiaTJCZmRYSE5YVHJTM2dlRzU3ZGE1RytuRE0vVDU2?=
 =?utf-8?B?VEtwenJLbHIwQnBvVTF0UGdIK2NzSUJ2TkRmU2Q2eUI4VFZta2pOMy9IVTlQ?=
 =?utf-8?B?V1ZjV2dzVG51VkZpYmJlL3RCMWxwMXdzUWZSMmE3RGJjZGJWNWRpVHpMWDg3?=
 =?utf-8?B?MVlta3YwaVFwY0hpc3V5TzlCV21hSm02aWJZYmt4cDF4aUw2NnFPdVdJd05Q?=
 =?utf-8?B?V0NNS3ZUc3c3M2RVdzF0WEd1WlUwVzFWWm9PbElocklxUjM0eEpDMWw4WG9M?=
 =?utf-8?B?UkZXdjVrU2lpRk84TFc0TlBGQ1ZkWnkraEp4a0VlTjZkb1NwYVF2bkFVOUVN?=
 =?utf-8?B?OWEyalRNcU5pWXh1MEQ2bFlSZHpYU2xoaGl5ZEZFUWpsUm5ETHVrNGN4L3Y1?=
 =?utf-8?B?L0JQdWJSZEtDanFaNHZVTEdRNTNPVjcwN2VpeTIyWm5vb3JodkZjUG9OQTZZ?=
 =?utf-8?B?OFFGaFVqZFJYV2t2blhWM1lLQ1hmREtxZHl2WmtlSUt4YWs0cXlMU3N1S1FL?=
 =?utf-8?B?ZnMrY0VZUmk2ZC9Wem9VZXdTVXEwQzRXYWx5bUpiZWNNcXZqdi9uZHpibWZV?=
 =?utf-8?B?bUtJRnRqcEdveW15UnhPVGdMb3MyWTN1VnFvMTdNb1VEK2FIQVZpblFhS2VG?=
 =?utf-8?B?T0loUUpoQmgxbWFnMVNHK2oxOHU2RXpsSnZ0enN3RE1iYTNUeEFPU3VZeENY?=
 =?utf-8?B?eURaa01GQWZNblp0cGpMemo0SzJjem1IUGx5T043aVQ3ejJsYnpiRHVnMDZt?=
 =?utf-8?B?dTBqODdMcmhOcG5JR0tibHpQamV4YjF0MXRZWXNYclFxR1JNTHNCK2tDc0pj?=
 =?utf-8?B?WllBbWRjT2NVMlhyUC9BS2c0a2hlVmhRZW82TnA2dDYvQ3U1MHUxbnRZcmVS?=
 =?utf-8?B?Rjl0d3FEaUJiYkFZK0N5NUtiQy9wNFM2aHQ2QXFxQkFveVZ4dmpubVdiUVhr?=
 =?utf-8?B?QzhMeFBNZGZlWHJadExHT09lalN3ZDBpSWVxaTUwSFYzcXBVRTU4ZExxS1NJ?=
 =?utf-8?B?R0IrcGpPaUc4c21GbStISXA3enFXT1RUSmRaNUJ3K0pIa3lBTE9PclE4Sk1T?=
 =?utf-8?B?d3JLa0lma0ovUStiWW1iMWFPeDFvcW5HU1ZZZmZrNGw5Q1VBU042TXVIV1VD?=
 =?utf-8?B?M0Z0dmRIb3VSMm4rUnY1MjlJSGRCTVNDOXVTQllBZm1pcjkxbXVLWkVyOVhM?=
 =?utf-8?B?UkgwYmZnZmQvamJmTG9rY2VVODBzWitsS1QxcFl2M0E5R0JkanN0Y2NxeUx5?=
 =?utf-8?B?YnpxSHdjZDFHbmwrS0FHUnd2cXdhS2hmVmdtSUlIZmFVaXhTSk5NU3dkNUNo?=
 =?utf-8?B?ZGpDaXE0cmIxekZkRzdIV1FMdWdwMnVxQWE2T2ZtK3B2T2NSTkMxajhReGJD?=
 =?utf-8?B?MmhVYzkxWU5CMitqeSswZVdpSTNLSlRGeU9MaThCeXdhR2RDYzZhZDl4cklt?=
 =?utf-8?Q?fOjNWgHX90/NtHh91WQqLQotJ+sH0Cvt+Hr7lMQt7dP9n?=
x-ms-exchange-antispam-messagedata-1: TOuWB3qAjctisg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	baThcW3vnTut+MRXyqwzfAFN2dSwONEBtZxyNdwQ7957hySUVMcbGpIBisL0mZQMw+141/RG7H9vwAKx161lgaLvgRmDVEd58M2FEXLJExR2m6ftZZmhoNOnIun0j9fXLP//Pk5hrMPWAEKNhNYNpu1nn6HdOciwZiml5t8jALDoOrxjHlA6pbnVXHuPxLImvuoEGtizOTyyvT5/mG1wJ5hIOmwP+LNh0tNNf9yD3iU0Cfhm46/m7SEJxBQWP+MxSJ5dD/LUQpxv0IVVWFWQ3jTZECMKwElbLF9acLuNn84bCROpO8lz0PU5fH1yYQoaUadNuFL36Psrvbrh8Nauqw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d282ab-c51c-4df3-77c5-08de7fe99d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 03:44:07.4510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQqCY0bMcphbqXb3SnDKzvHj1pSAlWvOalaFoev6rIb/rhVohuBppKIHk5VvOtV2mXFW6nKlXaqbnoosPie1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4515
X-Proofpoint-GUID: 6oySE2MTrrO-97kCIuIj--yP0Wk8aTL9
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=69b2368a cx=c_pps
 a=sI2t2Ij5wXDMAk54xGiwVg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=iGHA9ds3AAAA:8
 a=6mxkgYvdzaQt9anJsN4A:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: 6oySE2MTrrO-97kCIuIj--yP0Wk8aTL9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNiBTYWx0ZWRfXyLxr87Y0k5lr
 DCm7TIKrgz2cdTViWMEwAswGGMjiBOoHPMSAMLnfFXbk302JATdkfReiYG19N391kHRHewSEtgv
 F4odVEcYankGbiedzXpkk6bxCnfg0YYRrK/S4rnoEavxz53gxFxNK6clfzR7IGPwyGgAWVyGGW4
 5lqVFbAZe2UXa2BEWpjrhnKL8vHZi5Nn2TnFvGabsSvUoIda9cuK0uGnlrkunGIMfQf25T4t6ZR
 tMkEwRkCDIP1w964IJEF73gN/OXTxXSCpBI7JVyadbJ7Kz7Zqs5MEcTqRyIrt2hnZqUSVvFe2gI
 ZUzsEMaCsEed1ORCsYELFJDcYb0bNAIsz9oFng40nXVLfXdyZdjh2QTsdKuLTkukP8IbI158apv
 Jvok3PYNmh56gOcN5SFSWO/vMZ2FUWZrCSrFENzQGJvqAtjklSd8ybwDlzWxk8JbkiBGuO3KBh4
 +KnptCxIRBRpxmg/AbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120026
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 03:44:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3437

SGkgQWxleCwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4gSSdsbCBmaXggdGhpcyBhbmQgc2Vu
ZCBvdXQgVjMuDQoNClJlZ2FyZHMsDQpRaQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogQWxleGFuZGVyIEthbmF2aW4gPGFsZXgua2FuYXZpbkBnbWFpbC5jb20+IA0KU2VudDog
VGh1cnNkYXksIE1hcmNoIDEyLCAyMDI2IDM6MTAgQU0NClRvOiBDaGVuLCBRaSA8UWkuQ2hlbkB3
aW5kcml2ZXIuY29tPg0KQ2M6IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZzsg
TWFjTGVvZCwgUmFuZHkgPFJhbmR5Lk1hY0xlb2RAd2luZHJpdmVyLmNvbT4NClN1YmplY3Q6IFJl
OiBbYXVoXVtQQVRDSCBWMiAwNi8xMl0gbW9kdWxlcy91dGlscy9naXQucHk6IGluY2x1ZGUgcmVw
b19kaXIgaW5mb3JtYXRpb24gaW4gdGhlIHJhaXNlZCBleGNlcHRpb24NCg0KT24gV2VkLCAxMSBN
YXIgMjAyNiBhdCAwNzo0OCwgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT4gd3JvdGU6DQo+ICAgICAg
ICAgICAgICBzdGRvdXQsIHN0ZGVyciA9IGJiLnByb2Nlc3MucnVuKGNtZCkNCj4gICAgICAgICAg
ZXhjZXB0IGJiLnByb2Nlc3MuRXhlY3V0aW9uRXJyb3IgYXMgZToNCj4gICAgICAgICAgICAgIFco
IiVzIGV4ZWN1dGVkIGZyb20gJXMgcmV0dXJuZWQ6XG4lcyIgJSAoY21kLCBzZWxmLnJlcG9fZGly
LCBlLl9fc3RyX18oKSkpDQo+IC0gICAgICAgICAgICByYWlzZSBFcnJvcigiVGhlIGZvbGxvd2lu
ZyBnaXQgY29tbWFuZCBmYWlsZWQ6ICIgKyBvcGVyYXRpb24sDQo+ICsgICAgICAgICAgICByYWlz
ZSBFcnJvcigiVGhlIGZvbGxvd2luZyBnaXQgY29tbWFuZCBmYWlsZWQgaW4gJXM6ICVzIiANCj4g
KyAlIChzZWxmLnJlcG9fZGlyLCBvcGVyYXRpb24pLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgZS5zdGRvdXQsIGUuc3RkZXJyKQ0KDQpIZWxsbyBDaGVuLA0KDQpjYW4geW91IGNvbWJpbmUg
cGF0Y2ggNCBhbmQgNiAodGhpcyBvbmUpIGludG8gYSBzaW5nbGUgcGF0Y2ggdGhhdCByZW1vdmVz
IHRoZSBkZWJ1Zy93YXJuaW5nIHByaW50LCBhbmQganVzdCBwdXRzIGFsbCByZWxldmFudCBpbmZv
cm1hdGlvbiBpbnRvIHRoZSBleGNlcHRpb24/DQoNClRoZSByZWFzb24gaXMgdGhhdDoNCi0gYXVo
IHdvcmtzIGluIHN1Y2ggYSB3YXkgdGhhdCBoYXZpbmcgZ2l0IGZhaWwgaXMgc29tZXRpbWVzIG9r
YXksIGFuZCB0aGUgY2FsbGVyIHdpbGwgaGFuZGxlIHRoZSBleGNlcHRpb24gKGUuZy4gc2VlIHRo
ZSAnbm90aGluZyB0byBjb21taXQnDQpoYW5kbGluZyBpbiB1cGdyYWRlLWhlbHBlci5weSkNCi0g
aWYgZ2l0IGRvZXMgZmFpbCwgd2UgZG9uJ3Qgd2FudCB0byBmbG9vZCB0aGUgY29uc29sZSB3aXRo
IHdhcm5pbmdzIHdoZW4gaXQgaXMgbm90IGEgcmVhbCBmYWlsdXJlLiBSYXRoZXIganVzdCBoYW5k
bGUgdGhlIGV4Y2VwdGlvbiwgb3IgaWYgdGhlcmUncyBubyBoYW5kbGVyLCB0aGVuIGl0IHdpbGwg
YmUgcmFpc2VkIGFuZCBwcmludCBldmVyeXRoaW5nIHJlbGV2YW50Lg0KDQpBbGV4DQo=

