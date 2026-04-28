Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501BEFF8864
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 03:34:34 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4220.1777347266232036294
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 20:34:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=rSekg+UJ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8578072242=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S2w2Z41041559;
	Mon, 27 Apr 2026 20:34:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=PS/bYUSZDqwyjCd/2gKxQx8z8k83ukxdPHSuwNmzP7w=; b=
	rSekg+UJ9G4vUiDJxteLTTGNhNC9H5znCVm+ksg+Cff4FHnrQ5wO/a00so7hT5rm
	wSQ6Zg7URx2JSAshIyq1OyHgLV88sWSc4fLascGj4XjHadqjFRhJp5pA4fU+R6nl
	CE9xEQK4ymUasRD1h5t43PBiv6C4kKWu3L7O8p8vzHMXPjYW7gWdw8q6imPOdJwT
	b5N4dH060qz7SrRu7L0tqcG2psvIiFUllj84muyCXHZKIQKvW13mi/FMh716+IHu
	hQdrepfUsEiCKnChRF/a3kcxu2CwH7auCHSGufyPHw0Ob+vDDU71fQyK8gh/VZJF
	hGiG7lRNjCatRZqPikZCbg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drrw2tprv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 20:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnu4VMo7djybuw6DNIZik5oF64ChRi2YH6vpkZ4mD0Xj72QyD2nq595Qk2NneHNSFjmH59CGFOee4sJg3ekA70pG09E6gfQ3TXZkoYnS68fNKklZjZZTrEcTapX7xb7+H/xk+cwSGiTIHZj21k+ByXOYCNVFAat7NSTk6ghb/uOdeFqrxumC1Tny2MFcGFez115tmXHw28g2H/fEU5ErXLwMrl2qadLPGmCvQMTT1vhoRHQw5KWH2l8dlwMzbQfCKjdllys9wGy0sAwd8XIIqR+2Qk8LzYn9oXaQYzgFTbSNge9O0oLtrFkiq3xU6hEUidm7hLDaIKg2ZQrlu6hKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS/bYUSZDqwyjCd/2gKxQx8z8k83ukxdPHSuwNmzP7w=;
 b=HusrnznDSeBBEiO10Cw02VS+Ca1lwgoiJ+xBDfik417Z90KGWfDJlrc5d+fp1SZ9mpsnhya/NtNzBKxkwRW5Jfciij5vqfk7g8YPN96nLNuPb72UytRGz86C72hFojkGlqKqVAA0jmdsz7PfA0YIFuhwZZ6wqcfMlWatG1DMI+rJSwdSqgtm+H/9RFAKRXkndlDd+8oOoqUe5vmL1zmG3wGMWfRpv4F2GxyKtDw81gziaIXxIqxqCozm2Wi0oQr5KGYY748PqM9+rnbrEHA3BPdXtVSIzv0x7/6ZDNQ1NteA+yw4cAf1cdwxFdsQ5PRPeL6VGw7YL4wTITei6GThuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA3PR11MB9225.namprd11.prod.outlook.com (2603:10b6:208:570::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:34:19 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:34:19 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        "MacLeod, Randy"
	<Randy.MacLeod@windriver.com>,
        Richard Purdie
	<richard.purdie@linuxfoundation.org>
Subject: RE: [yocto-patches] [auh][PATCH 2/3] modules/steps.py: refactor
 compile() to use parallel per-machine builds
Thread-Topic: [yocto-patches] [auh][PATCH 2/3] modules/steps.py: refactor
 compile() to use parallel per-machine builds
Thread-Index: 
 AQHcy9AKyzV/rsvxNUuRFaNmdvAa0LXuTvuAgAAyFQCAAB4dgIADnt+AgABxfoCAATNBgA==
Date: Tue, 28 Apr 2026 03:34:19 +0000
Message-ID: 
 <CO6PR11MB5602A0CB35F09BE577F33A28ED372@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20260414053202.3869771-1-Qi.Chen@windriver.com>
 <20260414053202.3869771-2-Qi.Chen@windriver.com>
 <CANNYZj9PmjiMDbz6jknMrYubDx=xk5cW2KeGJXVyHCNbFhkpAw@mail.gmail.com>
 <de8caefe20ca7301a8f104e8d9751ffd8ca50e38.camel@linuxfoundation.org>
 <CANNYZj-r9mM0sOHT+cMF2WK6x-odOT-CTRcwbg4b5xVSf2yVuQ@mail.gmail.com>
 <38fc4650-148c-40aa-81e8-3459b380387b@windriver.com>
 <CANNYZj8dwq7RR0Z14rkrSR8rznCQ9=4=E0XxOGsbXLUOaxbphQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj8dwq7RR0Z14rkrSR8rznCQ9=4=E0XxOGsbXLUOaxbphQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=cdc66030-db1a-4202-91d9-a8b6074bbd77;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-04-28T03:15:05Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|IA3PR11MB9225:EE_
x-ms-office365-filtering-correlation-id: a2091379-7e2a-460b-2aab-08dea4d70809
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18096099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 QbdGTowvjVy3X6HwMy6Xc49JpLr3BacvoRXWDX2gDKd40/DUJUmE0hMs8fEmrYKjIhkt/Wrttt8JpHiVf74biINpwPGOJL6e8mxcL6FUbiMOCsQP7YMevuiKUAl+p+dOC1HckgY4jfyzQ4bvuV2vgGrev4JcOn/nEp5FTSb9ZI/YpZ2aEPsDLI3J1O4eAoIwY4ojI4WpAC7N4ic2io1so38rcpjlZue8eWNmDU9O6zqWHNYKwLEcoblGYQkWasM5ETF6IVBCV/EBSCsSQ3Y0l7/d0NzDXlnVoQYB1Bh7+Nbcb+DTOFoDo46WQA+ILXqGeITr+4kr6cI6nPHTMEP54qHVCls1lunmyboSTkIvnCGwpdUVqXfVannN7QWlLRBHnc6gWQSoRbcR1ypkZ/FTQkMsfZNmMAsB+9qMblKPQZ1Zv9lvLEYMY8aUIwkljIwd55iZ5tLh66ciNdJBLCf8smPGXpZHfWQgtSLXDKyEBZIf7XU665siWx6IFmjhG07Zp7MWHhDzW18V1reePcyDajKDOT1NPsveEqOA++0PQFzytMYdBaLdd4WYeJkToi+ZwVTTwunciQSQc9PPxq61xhPFZNztny4K5eHkml2rd9KTbwbD1QLKEItrCPIQuFzqost/NaJJroXXsPPZzV628nO+93EcriD+Q/K1pCiRGrsfoG9TTPUISnaZTcqTK52YrtKginUE09jCwm9QtMO+PQUWrEqluBaP1YvrCxCHRV7mq2NjtycUtUCqhTU4r22XXwfumPtgz6jsyPOlGxy4XynsWeFDY1xQ+9wL5mjEJI8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18096099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SWx6SDV2R2k1YmtRa29pNXpKNlFPcERzTUoxcDRNNngrcy9NbmxQeW5FRG11?=
 =?utf-8?B?L2tYRW1QYllSaklRZ05kRmhZTkRHekkyd1c1NUlpaFRkcWpxY0ZydDBOaFZ1?=
 =?utf-8?B?ZDZ4bVVVZWYxQjhxTjNvTGRrRlUrdzVPR2JueXlTUjVNanVuaG44NkZWTHg1?=
 =?utf-8?B?ZHhOUXRvQ25qeDM3a0tXYW9VN2ovQk9OeHJNUE1naFcwejZxcEtvSDZmblRY?=
 =?utf-8?B?clBMMDJSSXBiaFRYUDFhUzBIbWd6WWFXNjM1ZHpoOHFlY1hTem45L2lMVU5q?=
 =?utf-8?B?U2tVN0lVNTBWdjJsS0NtQmJpVThaYUdRMkFQTE9NZ1hOMCtZZG1JZ0J0V3Nx?=
 =?utf-8?B?RWZQRSswM1ZkKzlaVjFCODh4MHlVMHhtdXpuQVRiTW1IZVQ1QlBZZW9pM0ty?=
 =?utf-8?B?a1NVV0xId1E2M1NiVnBQVHdENHNRVkRMdGhEMVJOWlVVdE1pMVFzSDJjaWVN?=
 =?utf-8?B?ZzYxNnAvU2hPZXdDcnlYZGIzV0lHRmNGSUU2ZEdtWG5ubmdUbVZvbFo0QU9h?=
 =?utf-8?B?dWlJcUN6aXZocEFaSElQT3RPUG5acm1ZM1ZDMFNkaGg4V2wwZ3JWY2JWbDRY?=
 =?utf-8?B?V0NYM2FEUldMRFgwSUZMdU45eERqSXV5RFFhY09jRFZ6SnIzeEF5N01iLzJn?=
 =?utf-8?B?emRac1VJdDBUQVowT1NxdGZvYU1ieXFaVWp0OXBaampDY2M5eTJ2VUJFSUZz?=
 =?utf-8?B?dTFvQjRXUVN1ZUtnVG85L3dZVTc4RGZidmJTQWpzakw5ajhlTm5ZVzFjZnRS?=
 =?utf-8?B?Qzd0YVU1Uy93RGVwdFVlZU1DQ05RK1hUaE5GYXFTNkJadnJ5ZDdFWVBlVWt0?=
 =?utf-8?B?MHJ5bjR5UHBSdXkyVzR5NTd5ZU9UQ2cwNk9pRHlWTDNQRTdSUmloYTA1MlJE?=
 =?utf-8?B?RjZxc0NzNDFGRTArb0MxZTh2YU1CeW5zOVpRK2lzTDVDR1o2OGg2YmwrWTlN?=
 =?utf-8?B?QmpPREU5OXAyWHB5WkhwQjMrRzQ2OGZuWVRKSzdRWEVta1gxcGpEUkVyOUdY?=
 =?utf-8?B?VHBCMksycG05YUVEN25PKzYvQ2d3M2VMWko1QnlDZjZpQkp0UXV6RVR0RnE4?=
 =?utf-8?B?L0JpK3JleUwyTW1QK0FyZXovNWdrTndCTVRkb0RXTjVReGJ2b3BhYUduSHRt?=
 =?utf-8?B?c3JXU0UvNVNFdkZXOWUxK051Z05lU2l4Q09NZ0VMWWtuOHZCdjV0QTVONjkr?=
 =?utf-8?B?S1VjYVlBNlJ0SFVwQTNuMkFwbVZYTnJKUGxWOER0c1VYbCtRSlBaSW5ZNzVD?=
 =?utf-8?B?eWFQNXluNEVwak42Yzl0cDJqRDJJczJCQUxqT21RZzg1enI4K1JQTVdQQU9w?=
 =?utf-8?B?L1EyZHU5VXA0a0VsUlZRNEdJNnhVZjU5Z3hOK3N5bGcvV3Z4L01yRk5Vam03?=
 =?utf-8?B?ZjJLZmZvRjVvZUNZWGtnQWROTXJML3V6Sm03cnlwTlptc2FDMzZnQlRRaFFP?=
 =?utf-8?B?TndQZHNKWFVNRTJGTmpmdXZEMk4zUFpva1J4aHRsUmhKYWxnNXJGRFhTYUlH?=
 =?utf-8?B?MWxqUFpqYUludksvVGtJNklsK2lneTU4VHFTeVg3S0x4cTZBOFhDSTVwc2tB?=
 =?utf-8?B?eHFNN1E5ZTNMWk5LN2FuT1BOWm5VN3Frdmpqc3dHWkhRNzFCREViOGVuRmE2?=
 =?utf-8?B?cGpKbWJUNkIrQVFZZit1QmJVRGRZZkg2Q09iRFlraThURFp0c1pEd2lRUWk0?=
 =?utf-8?B?R0hoSURmWXIrSGY0SDdsS3U0N0NJNFMyTWxkMHRoT1BRVW1MbjJPclJxYTNS?=
 =?utf-8?B?MVlSYU9hZmZuVEowY3F1Q0FYSXhieGRibzRmOFpxTVZsRkFmQ1FhSmJrWUdZ?=
 =?utf-8?B?VnFvbm5ML1MrbWVKQjFtMVMrdjNyWFNaYklDK0dZcm4yOTZXR1V4NFdSM0tt?=
 =?utf-8?B?OXhaVjU1b2RZWFJmNkF3SGRNa1dSaGJyOEQ5N0lITUNEbG5rUWZxTkhQOW13?=
 =?utf-8?B?WXp0bSs1alFvMkVKNzlPbXhYd3NpS2w0TXN6eDc1cVNqRERIRzJVNnRQZnNC?=
 =?utf-8?B?RkI4MjdQUWJVRFJ0VGdLOVduODFEVFRqN1dDT1RvcHd6NHJNeGc3VkxkMHBK?=
 =?utf-8?B?Yi9mbUQydVFJOTF4MkQxRnAvc2liWGcySUtQSVgybm1mS1g1N3VFU0gwRXZq?=
 =?utf-8?B?VmtXWHB1aFk2L2IvcjFIbXptcG9FTW11clhCVGJRMjZNNkhrQ1dBS21nc2xz?=
 =?utf-8?B?M1VZakE1NEcwYnJpNkFkWHRKKzJjS29nQ3VHTnFoSnpXQm9wUnltU0padGJ3?=
 =?utf-8?B?c0tucnN6UFUweVFMVlNFZ0J3ZkZLNnlPRnpxTThCQnpWRlZKTi9BVWxYL3dq?=
 =?utf-8?B?bHBFWmxPOXpRL3RLb1JKd2RuVmhGM253OHM5ZzVPaFRBWU56QXZVQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	O6i0N1D9477gJsmvGcqo8/CZI0rqswVTShsh3nDf/qGGvvK74KXafRE8nARcm282EyU23PtzjEmXawTfCWYiRW/WLckkUvueOvtIzW2ZZRIIqmAcJmOojjNfXL/jWzR3kfi/k6s5ljuE8uk/wSx1abiPfj7nfSQ+DbNBLfPTrwtVvBYa5u5PNRe0GDg+pcdLhbIHIHSmt6rRdcppgzDP0IVcNmoL9I8jQGg+k8x4ddTBU1lB/XsCXJpp2vGRniYY8muIF4tKm/nKgas1dh4echaIhot0see+BaaRzdqigsF2xWjYLKA9lpCBH5LNrSH0fmJdIJRM0LdLWBk9+35QQA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2091379-7e2a-460b-2aab-08dea4d70809
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:34:19.2303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vh+9NqbhQuiUzpvqTYpMH8K7HV9PjpxA//evwTUFj5sHmDPIiKvHUAHWirrCQvjioE6Jf7wc6atJkcOCggXvlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9225
X-Proofpoint-GUID: 0AyE5t08IK82wim9FnCtkAAGZLkX0HcH
X-Proofpoint-ORIG-GUID: 0AyE5t08IK82wim9FnCtkAAGZLkX0HcH
X-Authority-Analysis: v=2.4 cv=Pu+jqQM3 c=1 sm=1 tr=0 ts=69f02abf cx=c_pps
 a=1c0oZQ8MA7sDNsoFSDv1iA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=iGHA9ds3AAAA:8
 a=ft_kRsl8AXO6rghyejYA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyOSBTYWx0ZWRfX/U/Fhrc2LelV
 KwCEZeKw7I3RRVAfIrEVgZhk6JPjl8bC/f5DHMEcMsTssEF3K1lcE6N3K1xnGTeYYVdCne9wzeS
 x9IRBcV0VFD8/CTreCL8gI+TKDfvzKe2wZawfUXVKH6N3Zsal4oV/Sx7uG7WwfF7q5zwZGC8nMe
 MM/yyv8k0bXW6eUGEwWoF122/wROGlwdUgqF+RNdTlo0exbWv3mlCR4Y6CmmX9J3l/12wrW38y2
 E8GBwvftHxYyc9F6aaoerJ4hawXDWqA1aCIK0Teusa/c3ubczbxS1+8t8bN31vX/XizAZo75bpT
 zuMYYEcj7/F6Q9eaV0OnX2zEoOYseJaNKKmA9GXvN8ZJCeZz0iZrRwhde/4zj8HCOyRNQsV1bps
 zV73su6MKMHn4XI94BMIlUOC+XoqgcE2ZbhOZAkZM0Jul5/RViQkowr2GGpKq6BUmRV91pNh60a
 vP/Paw1sllDnssiG5yA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280029
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 03:34:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3861

SGkgQWxleCwNCg0KSSB0b3RhbGx5IGFncmVlIHdpdGggeW91IHRoYXQgIkl0J3MgZmFyIG1vcmUg
bGlrZWx5IHRoYXQgYW4gdXBkYXRlIGJ1aWxkcyBmaW5lIGJ5IGl0c2VsZiwgYnV0IGJyZWFrcyBz
b21ldGhpbmcgbm90IGNvdmVyZWQgYnkgQVVIIHJlY2lwZSBidWlsZHMiLg0KDQpMZXQgbWUgZmly
c3Qgc2hhcmUgbXkgbG9jYWwgcHJhY3RpY2UgYW5kIHRoZW4gc2hhcmUgbXkgdGhvdWdodHMgb24g
QVVIIGltcHJvdmVtZW50cy4NCg0KSGVyZSdzIG15IGxvY2FsIHByYWN0aWNlIGZvciBMVFMgcmVs
ZWFzZXM6DQpVcGdyYWRlIHJlY2lwZXMgKHN0YWJsZSB2ZXJzaW9uIHVwZ3JhZGVzIG9ubHkpIGZv
ciBlYWNoIGxheWVyIHVzaW5nIEFVSCAocGFyYWxsZWwgYnVpbGQgZW5hYmxlZCkgKyBtYW51YWxs
eSBjaGVja2luZyB0aGUgdXBncmFkZSByZXN1bHRzICsgd29ybGQgYnVpbGQNCg0KSSdtIHVzaW5n
IHdvcmxkIGJ1aWxkIGluc3RlYWQgb2Ygc29tZSBleHRyYSBidWlsZCB0ZXN0cyBmb3IgZWFjaCB1
cGdyYWRlIGJlY2F1c2UgSSdtIHVwZ3JhZGluZyBxdWl0ZSBhIGZldyByZWNpcGVzIGluIG11bHRp
cGxlIGxheWVycywgdGhlIHVwZ3JhZGVzIGFyZSBzdGFibGUgdXBncmFkZXMgYW5kIHRoZSBzZXJ2
ZXIgaXMgcG93ZXJmdWwgZW5vdWdoIHRvIGZpbmlzaCBhIHdvcmxkIGJ1aWxkIGluIGEgZmV3IGhv
dXJzLg0KDQpXaGF0IEkgaGF2ZSBpbiBtaW5kIGZvciBBVUggaW1wcm92ZW1lbnQgZm9yIG9lLWNv
cmUgbWFzdGVyIGlzIHRoYXQsIGFwYXJ0IGZyb20gdGhpcyBwYXJhbGxlbCBjaGFuZ2UsIHdlIGNh
biBhbHNvIGFkZCBzb21lIG90aGVyIGNoYW5nZXMgdG8gQVVIIHNvIHRoYXQgaXQgY2FuIGJlIG1v
cmUgZWZmaWNpZW50IGFuZCBzYXZlIGRldmVsb3BlcnMgdGltZS4NCg0KMS4gQSBuZXcgc3RlcCwg
Y29tcGlsZV9kaXJlY3RfZGVwZW5kZW50cywgY291bGQgYmUgYWRkZWQgYWZ0ZXIgdGhlIGNvbXBp
bGUgc3RlcC4NCldoYXQgdGhpcyBzdGVwIGRvZXMgaXQgYnVpbGRpbmcgcmVjaXBlcyB0aGF0IGRl
cGVuZCBkaXJlY3RseSBvbiB0aGUgcmVjaXBlIHRoYXQgIHdhcyBqdXN0IHVwZ3JhZGVkLiBUaGUg
Y2FuIGJlIGdvdCBieSB1c2luZyAnYml0YmFrZSAtZyB3b3JsZCcgKyBzb21lIGZpbHRlcmluZy4N
ClRoaXMgc3RlcCBjYW4gYmUgZW5hYmxlZCBieSBkZWZhdWx0LCBidXQgY291bGQgYmUgYWxzbyBi
ZSBza2lwcGVkIGJ5IHNldHRpbmdzLiBXaGVuIGVuYWJsZWQsIGl0IG9ubHkgYnVpbGRzIHRob3Nl
IHJlY2lwZXMgZm9yIHRoZSBmaXJzdCBtYWNoaW5lLg0KDQoyLiBUaGUgbWFjaGluZXMgc2V0dGlu
Z3MgY291bGQgYmUgZXh0ZW5kZWQgdG8gaW5jbHVkZSBmcmFnZW1lbnRzDQplLmcuLA0KbWFjaGlu
ZXMgPSBxZW11eDg2LTY0OmNvcmUveW9jdG8tYXV0b2J1aWxkZXIvbXVsdGlsaWIteDg2LWxpYjMy
IHFlbXVhcm02NF9tdXNsOnNvbWUtZnJhZ21lbnQtdG8tZW5hYmxlLWRlYnVnLWJ1aWxkIC4uLi4N
CkluIHRoaXMgd2F5LCB3ZSdyZSBnaXZpbmcgQVVIIG1vcmUgYnVpbGQgY292ZXJhZ2UuDQoNCldp
dGggdGhlIGFib3ZlIGltcHJvdmVtZW50cyBmaW5pc2hlZCwgYSBzdWNjZXNzZnVsIEFVSCB1cGdy
YWRlIGluIG9lLWNvcmUgbWVhbnM6DQoxKSBpdCBidWlsZHMgc3VjY2Vzc2Z1bGx5IGZvciBhbGwg
c3BlY2lmaWVkIG1hY2hpbmVzIGFuZCBjb25maWd1cmF0aW9ucw0KMikgYWxsIHJlY2lwZXMgdGhh
dCBkaXJlY3RseSBkZXBlbmQgb24gaXQgYnVpbGQgc3VjY2Vzc2Z1bGx5DQozKSB0ZXN0aW1hZ2Ug
cGFzc2VzICh3aGljaCBtZWFucyBpZiBpdCBoYXMgcHRlc3QsIGl0cyBwdGVzdCBwYXNzZXMpDQoN
CldoZW4gdGhlIGVtYWlscyBhcmUgc2VudCBvdXQsIHRoZSBtYWludGFpbmVycyByZWFsbHkgZG8g
bm90IGhhdmUgbXVjaCB0byBkbyB3aXRoIGEgc3VjY2Vzc2Z1bCB1cGdyYWRlLiBUaGUgbWFpbnRh
aW5lciBqdXN0IHJldmlld3MgdGhlIGNoYW5nZXMsIGNvcnJlY3QgbGljZW5zZSBpZiB0aGVyZSdz
IHNvbWUgbGljZW5zZSBjaGFuZ2UsIHB1dCBzb21lIGNvbW1pdCBsb2cgYW5kIHNlbmQgb3V0IHRo
ZSBwYXRjaCB3aGljaCBpcyBhIHNpZ24gb2YgY29tbWl0bWVudCB0byBmaXggYW55IGZ1cnRoZXIg
cHJvYmxlbXMuIFdoZW4gdGhlIEFVSCB1cGdyYWRlIGZhaWxzLCB0aGUgbWFpbnRhaW5lciBjYW4g
YWxzbyBlYXNpbHkgIHNlZSB3aGF0IHRoZSBwcm9ibGVtIGlzIGFuZCBob3cgdG8gcmVwcm9kdWNl
IGl0Lg0KDQpXaGF0IGRvIHlvdSB0aGluayBhYm91dCB0aGlzPw0KDQpSZWdhcmRzLA0KUWkNCg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleGFuZGVyIEthbmF2aW4gPGFs
ZXgua2FuYXZpbkBnbWFpbC5jb20+IA0KU2VudDogTW9uZGF5LCBBcHJpbCAyNywgMjAyNiA0OjU1
IFBNDQpUbzogQ2hlbiwgUWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT4NCkNjOiB5b2N0by1wYXRj
aGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc7IE1hY0xlb2QsIFJhbmR5IDxSYW5keS5NYWNMZW9k
QHdpbmRyaXZlci5jb20+DQpTdWJqZWN0OiBSZTogW3lvY3RvLXBhdGNoZXNdIFthdWhdW1BBVENI
IDIvM10gbW9kdWxlcy9zdGVwcy5weTogcmVmYWN0b3IgY29tcGlsZSgpIHRvIHVzZSBwYXJhbGxl
bCBwZXItbWFjaGluZSBidWlsZHMNCg0KT24gTW9uLCAyNyBBcHIgMjAyNiBhdCAwNDowOSwgQ2hl
blFpIDxRaS5DaGVuQHdpbmRyaXZlci5jb20+IHdyb3RlOg0KDQo+IFdpdGggdGhpcyBwYXJhbGxl
bCBidWlsZCBhZGRlZCwgWW9jdG8gY2FuIGNvbmZpZ3VyZSBvZS1jb3JlJ3MgdXBncmFkZSANCj4g
dG8gdXNlIG1hY2hpbmVzIHRoYXQgb2UtY29yZSB1c2VzIGFzIHRoZSBhY2NlcHRhbmNlIGNyaXRl
cmlhLiBUaGlzIA0KPiBtZWFucyBhIHN1Y2Nlc3NmdWwgYXVoIHVwZ3JhZGUgd2lsbCB2ZXJ5IGxp
a2UgdG8gYmUgbWVyZ2VkIHdpdGhvdXQgYW55IGNoYW5nZS4NCj4gSWYgdGhlcmUgaXMgc29tZSBm
YWlsdXJlLCBlLmcuLCBxZW11YXJtNjRfbXVzbCwgdGhlIA0KPiBkZXZlbG9wZXJzL21haW50YWlu
ZXJzIGNhbiBzZWUgaXQgZGlyZWN0bHkgd2l0aG91dCBkb2luZyBtb3JlIGxvY2FsIGJ1aWxkcy4N
Cg0KRm9yIHRoZSBwdXJwb3NlIG9mIHVwZGF0aW5nIG9lLWNvcmUsIEkgZmVlbCBhIGJpdCBkaWZm
ZXJlbnQgYWJvdXQgYmVuZWZpdHMgb2YgYWRkaW5nIG1vcmUgbWFjaGluZXMgYWN0dWFsbHkuIEkg
dGhpbmsgaXQncyB1bmxpa2VseSB0aGF0IGFkZGluZyBtb3JlIGVudHJpZXMgdG8gdGhlIHR3byBl
eGlzdGluZyBvbmVzIChxZW11eDg2XzY0IGFuZA0KcWVtdWFybV9tdXNsKSB3aWxsIGhlbHAgdW5j
b3ZlciBtb3JlIGlzc3VlcyAtIGlmIDMyIGJpdCBhbmQgbXVzbCB2YXJpYW50cyBhcmUgYWxyZWFk
eSBjb3ZlcmVkIGJldHdlZW4gdGhlc2UgdHdvLCB0aGVuIGl0J3MgdW5saWtlbHkgdGhlcmUgd2ls
bCBhIHBhcnRpY3VsYXIgMzIgYml0IHg4NiBpc3N1ZSwgb3IgNjQgYml0IGFybSBpc3N1ZSwgb3Ig
YSByaXNjLXYgaXNzdWUsIGUuZy4gc29tZXRoaW5nIHRoYXQgdGhvc2UgYWRkaXRpb25hbCBtYWNo
aW5lcyB3b3VsZCBjYXRjaC4NCg0KSXQncyBmYXIgbW9yZSBsaWtlbHkgdGhhdCBhbiB1cGRhdGUg
YnVpbGRzIGZpbmUgYnkgaXRzZWxmLCBidXQgYnJlYWtzIHNvbWV0aGluZyBub3QgY292ZXJlZCBi
eSBBVUggcmVjaXBlIGJ1aWxkcywgZS5nLiBhIGRlcGVuZGVudCByZWNpcGUsIHB0ZXN0cywgb2Ut
c2VsZnRlc3QsIG9yIHJ1bnRpbWUgYmVoYXZpb3IuIFN1Y2ggdGhpbmdzIGFyZSB1bnJlYWxpc3Rp
YyB0byB0ZXN0IGZvciBlYWNoIHVwZGF0ZSwgYW5kIHNvIHRoZXkncmUgZG9uZSBhZnRlciB0aGUg
ZmFjdCwgaW4gYS1mdWxsLg0KDQpJIGFncmVlIHRoYXQgc3BlZWRpbmcgdXAgQVVIIHdvdWxkIGJl
IGJlbmVmaWNpYWwsIGJ1dCB0aGF0IGlzIGJldHRlciBkb25lIGluIHRoZSBvdXRlcm1vb3N0IGxv
b3AsIHdoaWNoIHRha2VzIHJlY2lwZSBncm91cHMgYW5kIHVwZGF0ZXMgdGhlbSBvbmUgYnkgb25l
LiBQYXJhbGxlbGl6aW5nIHRoYXQgaXMgbW9yZSBjb21wbGljYXRlZCwgYXMgZWFjaCB1cGRhdGUg
b3BlcmF0aW9uIHdvdWxkIG5lZWQgaXRzIG93biBjb3B5IG9mIG9lLWNvcmUgcmVwbyBpbiBhZGRp
dGlvbiB0byBpdHMgb3duIGJ1aWxkIGRpcmVjdG9yeSwgYnV0IGl0IHdvdWxkIHJlYWxseSBydW4g
ZXZlcnl0aGluZyBpbiBwYXJhbGxlbCwgaW5jbHVkaW5nIGRldnRvb2wgdXBncmFkZSAod2hpY2gg
Y2FuIGJlIHZlcnkgc2x1Z2dpc2ggb24gbGFyZ2Ugc291cmNlIHRyZWVzIG9yIGxhcmdlIGNvbW1p
dCBoaXN0b3JpZXMpLCBidWlsZGhpc3RvcnksIGFuZCB0ZXN0IGJ1aWxkcy4gQW5kIG9mIGNvdXJz
ZSwgbGFjayBvZiBBVUggdGVzdHMgaGluZGVycyBzdWNoIGxhcmdlIHJlZmFjdG9yIGVmZm9ydHMg
YXMgd2VsbC4NCg0KQWxleA0K

