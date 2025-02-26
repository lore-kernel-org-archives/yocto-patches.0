Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F43AC021B2
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 00:34:47 +0000 (UTC)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
 by mx.groups.io with SMTP id smtpd.web11.287.1740530083732245605
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Feb 2025 16:34:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=WplgIZ6d;
 spf=neutral (domain: fujitsu.com, ip: 216.71.158.34, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740530084; x=1772066084;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=l47z60BaMQj9YtLZyRmeyntdHpCQKG2HoLl35z8ag7c=;
  b=WplgIZ6dL/HVMT/gbf9PKF2VU8d5MJDo7CGbvWbGVSjOIA47hdgKSJCe
   Sj7PJKtaoUI3NfMvvRXxZeu0vXJHVprNSbtYFcWZwX5UIHHWqKTb53BEC
   lCpddeZC456GSgJKlCIM19SSoGyQC5MBbQ66FKSYYGQ6wjvimpL7o+pPL
   TIWwC2QfHyJ6ZI+/aZHqYSeXQJL9b6czPS1fuZn5TPHRUm2RDXdAeh2PA
   anvTFaxWSCYtJ4TvfLQqjsA/rk4Dv/i31qCdRz1CtwUvp+OLhuuwr0C7b
   4lDbxg1oCudT7Ck16kOYCvYj/X4SBEENtZYK1Xj7u8pnDsuUTX/zy7Ss4
   g==;
X-CSE-ConnectionGUID: nL8u1PgUQyq/Yzc3O5enXA==
X-CSE-MsgGUID: icPZv8P8QZaJ3gcHGpFSYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="147527495"
X-IronPort-AV: E=Sophos;i="6.13,314,1732546800"; 
   d="scan'208";a="147527495"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:34:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uX1PG9e40ljMe+Da2SHQFp3np1AFWWvBVKHegG6KL7kHXcmI9G2PVNbEdY/fofyDkLDgr456qZUdxt98lvD+nL1nTUBMxEOyjpSxaCJGfxWYSKoRGvDinQLsPUuBYmMr8SlM/E8LWXuSVMu60nUT1xKY7gpy+uZopbyBbB2Uu/toyT4pGIn9NpN+2Zw46ybsDJf26HXxK5nP+wjpCGg79IwZ+LzljdzHRfFpII2k36lCAcjSkOehGQFW5Pbj+r279KYG9KWlqdsPFozJ7kUwQsPHFDLyzYc9xcfQv90dt1orYFrsASHgRg/V6qvsHyT3FyPGw1SAgud/Pn0qbiJL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l47z60BaMQj9YtLZyRmeyntdHpCQKG2HoLl35z8ag7c=;
 b=XZvzIZmZ8N4lPm1BMWNKGX82SRrcVTbPrCYVTpcalq0s/75iUzbpj1RbudHSGcg6ZAqoYm7wq7SJcSKicTOr2vnTYv9R2pAPpmB8Lo3MisMxjR+HkchWxXsK4sVnm/zdghZCQJN6eOXRl50fmsIGvA5ZEMbk5pybYqyQVG4Vq0w8f1ryBKlPFIKIlzf6pxSwEDK9QVnF9gRSXAWYIMLLbgNXOXYM2vWVbc1/bvypO1KCtVMiz6FSqXvhs90DvtzYcDLTJPhR2l28CyCwCY4HGYxkjIULETtq1YJ4Hs3J4Jar9CV4jolsnvd7Y578cGf9grzKWY/ZoQwP9qgPpJkkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 (2603:1096:400:3fb::13) by OS3PR01MB8145.jpnprd01.prod.outlook.com
 (2603:1096:604:173::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 00:34:36 +0000
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342]) by TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 00:34:35 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: FW: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status
 in patch
Thread-Topic: FW: [yocto-patches] [meta-java] QA Issue: Missing
 Upstream-Status in patch
Thread-Index: 
 AduEDy+sEghkbMChQESqJcifNyWPJgAAxogAAAnxstAAAafPAAAASvSAALZIUZAAD+xfAAAiyoTA
Date: Wed, 26 Feb 2025 00:34:35 +0000
Message-ID: 
 <TYWPR01MB1186195D31D8A8A089D2D8C75DCC22@TYWPR01MB11861.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <CAMKF1sqJ3MS8gnN8gv1AMLNNZt=UEXtzXyQim-5TA+H9funFUw@mail.gmail.com>
 <TYWPR01MB11861B276559403A8AA76A8EFDCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <49dec7e116d95938712d10e4d76b78ed2df01ca9.camel@linuxfoundation.org>
 <CANNYZj-RPuuU+Ub5d0VBz7gmqg-LEB-yKN9dkJL8Qp-2UY2K1A@mail.gmail.com>
 <TYWPR01MB118611CBFD42C4CA304D6A552DCC32@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <CANNYZj8My6Uf78BFFkA09_VKYkHssxbk1z0UMiPF8jAAhYpB7w@mail.gmail.com>
In-Reply-To: 
 <CANNYZj8My6Uf78BFFkA09_VKYkHssxbk1z0UMiPF8jAAhYpB7w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9OWNhYzRlY2EtYjgwNi00YTg0LTk3MzQtZTA1NmEwM2Rj?=
 =?utf-8?B?MjFlO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTAyLTI2VDAwOjMyOjAzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11861:EE_|OS3PR01MB8145:EE_
x-ms-office365-filtering-correlation-id: bb9c26ae-42e4-4ff5-0124-08dd55fd587c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RXN6a0Z5dUdGWmhOV3pZWERjN01wQlcrMkRHeWtFTHhWb0UwQkM1dG8xazE1?=
 =?utf-8?B?UkV0VjlWS1B3N0FKU2c2OUpkV0ZlSHhHcUJPcmVMVGp2eERrKzRLSi9NY1RQ?=
 =?utf-8?B?NFhTYS93Y1BIS0loRVBZV05FK3J3NkJxRXNFRG5JSkxKa2UzZ1M3MGIwRXpo?=
 =?utf-8?B?QTZUaExtOWlJS2FHSlNLbkd0d3JqQnoxWVg5dkNoSFA1Y25DejB2YitIdEd0?=
 =?utf-8?B?Wms1ZjJmL29tdUhSWTNKQXpSYnRyZ3pyVUcwaGgreDc2UFppN2p4KzlmS1U3?=
 =?utf-8?B?bW5NQXduMjZzUnQvS0p5czUrQ0ppK1NvU1BDd2hwV3owRmxBK3Vpdm9hVnpj?=
 =?utf-8?B?aXhnUHlRTFJXRk5kZnFVRndIL2llSGlQdmIydDd5eXZ4V0dldTdlc3BUK241?=
 =?utf-8?B?NkRFVFVQZ0FwNkw3UGxFcmlCRnlkelMzcjhRNlVMNzFmdHVtbDRSOGh0RGln?=
 =?utf-8?B?U05nNUZTSU94bCtncDRwcjVKVjlNY1A1QlNrNSszMnpjYlhsd2x2WVl3SEZZ?=
 =?utf-8?B?UW1nWVdTZjVia2YrYmRYTGFEZExKMmtqMjI0dmUxUHV0bFp2YXFsQWpxYjdk?=
 =?utf-8?B?Tjk3Y3N5MFdEbmtqaHo1ZlRlYlRQK3JBVmozc29oRzJ3QzQwTkd2TittbDJp?=
 =?utf-8?B?bmJxRHlWVzFhMFJ3QVUwYTRhMTBwcVR5UEExYkRqd2tNL2tydlRZN0FIZHlh?=
 =?utf-8?B?UEVWU3ZnanUza2FxbENuYjM2akx5QnBJZ3Z5cTBKL1lCbHNMRDhyUUdXZlNZ?=
 =?utf-8?B?TkJ0MVJ1R1BuOGJ1ODlMeW01b2tJb1dsVko0b0Rld1NLMk85Ykhhb3dxZ3c4?=
 =?utf-8?B?YXRMdHlaWXU3cmN2Nzgya3dHdU00WExKZVVleUVCcHBrUEJZWDhZVldUOUFJ?=
 =?utf-8?B?eEU0VFlGN1BOMGoyYzR3bS9mQzBBL1JYOEJ2S0ZaRFBxZE1vd0ErODZnOEoz?=
 =?utf-8?B?cmI1MnRhclJob1FwN3VBOHRJaWE4TnlQcXVyNERKSlNmSnVucVdmdm1MQnV1?=
 =?utf-8?B?aGJ6dFFZd09oSlJ2MUlPdm5NVFF1ZWR2SW83bERvZ1R3czhtMzlORElScWln?=
 =?utf-8?B?ZjMxV1cwNWlReEhwOEJXcVlOMjNMMHJGTmsrVGlkN0xaTmtVaTVTU29aM0pQ?=
 =?utf-8?B?L2V6TW9FcEpNTXVnK1J2WlI0bmVjWDVxdlorVGVuL20xTytnZEVjcCtLVjJG?=
 =?utf-8?B?QnZ2eDNaaEphOE9pbXRtNXVKYnY3TlkrTThsUzBMcnY0VE83TlllMlB0RUl6?=
 =?utf-8?B?RUVJZjU0QTRQRFdpYkMxc0JpMDdIZ0p5SURQdVBXMldBYU9BbXVWcHNERjBM?=
 =?utf-8?B?bU12Uk9pZXFjaVc1em9KQ1FhYU1oek1waUsydVVGRVFXWnlZNS9ZRHQrQU9x?=
 =?utf-8?B?VWk0QStsNFN5WnUvZG41eFNvM3FuSjBMUG5RVCtGaHdQTVROVVZmTkdabzJH?=
 =?utf-8?B?RGdrZ280RDg0ckFwWjAwbFUzYnUxdWFXWENaaXZWWkxGT2lPZ2Y5d2NGWGFn?=
 =?utf-8?B?STAzbVFxN040VnhnWmZlMm03b1daZkMvRlh4YWF3ZTBCNG1kbDZadWhSLzBY?=
 =?utf-8?B?L0NKSkpUc29PYThzQ3h0OWtUbHhvb3J2bnAwWVU5cnRuZXF0UjFFM01ZaUNr?=
 =?utf-8?B?UHBseDFFbFFjZ1lxazU4VS9aazJBajRtcnk5dEF0Ukw2NlpsODR5MVBTR1pW?=
 =?utf-8?B?YVR4c1FCMHZXVGFReXgyNkZXdUVBc0RXVVFLbmJyekVzSVVFQlBvWldTeERW?=
 =?utf-8?B?ZGdyVFpiZUd6L1B1TTFHeTlDaTBKRUJNVkFRQU4yRm91dXVuRVhYNjhZaGMx?=
 =?utf-8?B?SXY3R2cwVmVJa1pob3BWaUloYTEvL1doa25CQTFtQXk5RTFpa3R1cGJNNFZU?=
 =?utf-8?B?UVliTUpTb2ZiMGxjUWhtWEJVZWZ4aTNQZ0M2UDUzK1VzbXlJZGxWTnFJcUxP?=
 =?utf-8?B?SUVVWU1GamRhU0h2Qk1qL29pb3BKR3VHaXpBVEl4Qi82UVdNb2d2NG9oMGhw?=
 =?utf-8?B?aFgzOXcrSkN3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11861.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c0JnOWVMaHhsZE9mR0hnVGZya3I0bXJOSDgyazNMRmYyK2I5ZzB1SitMYndP?=
 =?utf-8?B?MEw0aFhMSk5Zd3g0NUdJL2ZEYmRtMVYxYy9FeWJ2T0gzTW9ZV1p1b2FmeWp1?=
 =?utf-8?B?bzQvWmpoWmJnVi9QVmkvSTR6K2F6R3pqOFk3YlVLbDNRdVhxdlV1SEs2MDZQ?=
 =?utf-8?B?QkFkb1ZxTitzeXoyN0JrT0wvS09Lak9EY3dSMWUxWW04V3RUcEs1WW5VUVI2?=
 =?utf-8?B?Y2NSaFJYc2trbUxyUU1mRlJ6N1lKZ2dDdmJqQktnMnkxbmdWUTg1SWx4eTUr?=
 =?utf-8?B?MXo3SzU4NVh1ekIxamxpMzhGRC9oYzA4VnFLZGVtWXdqL0Yybk13YzJ4bUZz?=
 =?utf-8?B?anJsRkpiUnp5YmxHZUhmUGlVK0p5Q1Z2aEFZQmppMURNTGVnWlpoWml6K3E1?=
 =?utf-8?B?MWV4dzl5WGZLWmsxMTAxSTBxdEJ2VTY5c0pCdjFBVU5WNDZyTGp3dlcrYit2?=
 =?utf-8?B?RUIyK1p0VjMzVG5raWFqMHM4MFc3YWJGL1ZtbWx0VlBpL1VMdmZYOHYxaTVp?=
 =?utf-8?B?a3ZNQlF3bzJjSjFwVTc5RFNjY2J6Ui9yUmRMTjJ5VW0vM2xzaHlvcFJsc2U0?=
 =?utf-8?B?T3ZGcUJ4L3BtUHRKUkxJOVUwY1F0RFp5MjVyWnBaeFdkc09jdDRzVUthWVdD?=
 =?utf-8?B?RUF6NnN1enlUMzN2YnVjNDhVeUNqVW9KVWNSMndjb21tenZWSEpaRlRoRWNz?=
 =?utf-8?B?MXVlYUtRcnZQWkJXcjRpd21NQWpGREFsOHRCblp5Yjl5SjQrVkVDL2FONDVT?=
 =?utf-8?B?S1Rid1lSVGVaejNEUU1uV09pYjNMc2VYNjB0dVpSRlhTYUlTZWNocURIRG1R?=
 =?utf-8?B?Y1hXZlhWZVlrR2g1eEpxZ21NYXV5SzBZT1IxbEtpeDlseXFtQXNkd0kwUGhh?=
 =?utf-8?B?QUp1b1ZuZU5WOTBWUVUyNlpQVUF5UCtBa29hcHZOOGVla3MvZFFOQ0s1OXhG?=
 =?utf-8?B?aTZ4Z1I1c2VFc2kzNW90ZWJvZUdIK21MU1RmbGovRVBaNjdLNmY3M3VkWXB0?=
 =?utf-8?B?bFBnSkVHcXk2dUdjOCtrY00wUURiQXlNV0I4ZGxDWDlkLzJoWHFhejVvR2oz?=
 =?utf-8?B?VmR6dEtqTFo2R3dmRjd1c0dXbWwreUU0M2g3VGxRM0hXVmxvZnA0ZzAxb1VC?=
 =?utf-8?B?UDBpYWJvTktVcGRYcGVqa1NQZmRnN2FUdTZpbmppV0p4bm1VcGNMb1JaeXRm?=
 =?utf-8?B?WFN6TUw1K3ZKanp1eGdaeCt2T1Z0dGlUMWsrWUhRcXlkSDhmOHI0YUdybWtQ?=
 =?utf-8?B?dWpiY2lOd3RvZURJN0hvbC9UZWhpSkRrU1g4dDZ4MTBDNFlzS05McGZPTi9S?=
 =?utf-8?B?bEIxQUEwR1FDNThia01xQlo2MUtUTXZDei9nOXVDREF6bVpENkZpQi95VUpr?=
 =?utf-8?B?R2dVMGkwbHBoaGthWUdJZHlWSlJvdSsvbjI0UHFMRk9hWFRBK1h0cUtWM0RK?=
 =?utf-8?B?dlFMRXIwcm9TZzlwUnhia0Y1QzB6bW9NU2IwNTZXd3FTOUtKU1c2Q3ZhVHV6?=
 =?utf-8?B?ZDdtSHo2R2JWSkthdEExRFJlWjhVc2lqa1lUbXdBUXRhbnVOQVdiajBaY29F?=
 =?utf-8?B?ZGp3THNkL1dNMzU5cG9QamQrU1JrN042MVZYdzlZcVNkV2ZqM2w5eTZQQXI0?=
 =?utf-8?B?c0h1aDMxY0lUYWZxSmFRUmpabk9NbzUxbWpPaUlnNzdoMU1xMDRsWFdXYmtF?=
 =?utf-8?B?MklpL1ZWODhlZWZIYW8zdjlNYWJvRnNmcDVLQ2xiLzRxTFhEdFQwTlJGZGpa?=
 =?utf-8?B?b3NMb0NGNXpHTDFLaGtabkZmWEMwZ3Nvb2VKUHhkUjlYTGFZOC8zaHZRWVRS?=
 =?utf-8?B?Zjlub0xHc0FLSWlLcVVQK3ExUGpWMGczUklERENKQ09LdzJVYXhTRHV5UjUv?=
 =?utf-8?B?aExkZmVmNmVucjB3MEtMek1KMmNFbjE3aUJHbHkxSDJpQ2VCSXpRT2luK2lx?=
 =?utf-8?B?aitRczVPUlBJVVFsV2wzcEtEbFNaMTVvVlYrdTdZUHZ2dWE0Y2llc1krL0ZX?=
 =?utf-8?B?UlhWOTM3akNiOVNUazRpczFWS05FK3N3a0w0a2crSDdYUzFkWTJCSjFXY1RK?=
 =?utf-8?B?bUpCK0ZMWmFwUEFGc1pPekZNL2IwOU54TVNUYkY5NS8xbGNKMEFsQ0ZON0V2?=
 =?utf-8?Q?dKVTOJYdsTHnJWoWwAu21XgUa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aNRcxKF03pfFF5V7WN0hn1Ody0HalL5elDPS5iaK8CfDwuRg61i5b4k0uT72FuQHwAX5xHVngC1ypfUrqIaNtY/VZN69ZQkTIp9mOdNO6DAYtV8ruEOeAvpRIR8Ihrep1KZXBL3HfEHo+qM4lvjF/eaJiYE+OTldpmKttJAIx8zE9fAKg7tf89lU80jWwp+jsCjoZ+qhgXJGG0aRINer2UV+7dVXZGN1xvZweEH0yU2oBXK1wlsSbedPBvqBx2tHhyXDY69iKchlPiRlYARzwidzRqU4t/kqqQmMTSuYFe5j1z3OPVMl+NXorpAIMZk05n3shV2N/m59wAgO9tnaDgb3olJ/vnUSU9VwtZnhtafqdq1kTyMPBv7KFHsKsTqclbOIF8tMYlTAZMhEIjnxHxIWsz9uU65e5ndid3zxvfRUp3SBv0bM9E2cp+lRzqu5J8UmpyU/HVzHWIGR9EvvtlP2Gj0Lz+f0RvkWLN74BrUYmYDqDgk59NmcdjwwS8CAeksgYD9uizvDeoQazYXD7cENb5pk5RsXBD+SsUxl3NMb7iQM8V/26eH9918cNn8GKrbcFbGsxjz8wFo/Wz5kPfNQTpiUraMgAvl+wcHYDSRCCx48iJlDlq059nwTIaWa
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11861.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9c26ae-42e4-4ff5-0124-08dd55fd587c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 00:34:35.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9HnUdqOGgJWC9JLjkTq3t9r4e17EBPwRRyhmux8kyiTr3tvPhYPkwi2AYnAI63rYEYbZoTPgqDGZIL2kR2GLJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8145
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Feb 2025 00:34:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1132

VG8gQWxleCwNCg0KSSdtIHNvcnJ5LiBJIGhhdmUgcmVhZCBUaW0ncyBtZXNzYWdlLiBBcyB0aGUg
Zm9sbG93aW5nIGhlIHNhaWQsIGl0IHNlZW1zIHRoYXQgaGUgd2lsbCBtZXJnZSBwYXRjaGVzIHRv
IG1ldGEtamF2YS4gU28sIEkganVzdCB3YW50ZWQgdG8gZ2V0IHNvbWUgc3VnZ2VzdGlvbnMgZnJv
bSBoaW0uDQoNCj4gTXkgcmVxdWlyZW1lbnRzIGZvciB0aGUgY3VycmVudCBzdGF0ZSBvZiBtZXRh
LWphdmEgYXJlIHRoYXQgYW55IHBhdGNoZXMgTVVTVCBhcHBseSB0byAibWFzdGVyIiAobWVhbmlu
ZyB0aGUgZGV2ZWxvcG1lbnQgIndhbG5hc2NhciIgNS4yIHJlbGVhc2UgYXQgdGhpcyB0aW1lLCA+
IGJ1dCB3ZSd2ZSBiZWVuIGluIHRoaXMgc3RhdGUgc2luY2Ugc2NhcnRoZ2FwIGF0IGxlYXN0IGFu
ZCBwcm9iYWJseSBtb3JlIGxpa2Ugc2luY2Uga2lya3N0b25lKS4gSWYgcGF0Y2hlcyBhcHBseSBj
bGVhbmx5LCBpbmNsdWRpbmcgYnVpbGRpbmcgYW5kIHJ1bi10aW1lIHRlc3RpbmcsIHRoZW4gSSBh
bSB3aWxsaW5nIHRvIGFwcGx5IHRoZW0uIA0KDQoNCj5UaGUgb25seSBhbnN3ZXIgaXM6IG1ldGEt
amF2YSBoYXMgbm8gbWFpbnRhaW5lciwgYW5kIFRpbSwgb3IgYW55b25lICANCj5lbHNlLCBpcyB1
bmFibGUgdG8gaGVscCB5b3UuIFlvdSBuZWVkIHRvIGJlY29tZSB0aGUgbWFpbnRhaW5lciBmaXJz
dC4NCg0KSSB3b25kZXIgaWYgaXQgbWVhbnMgdGhhdCBJIG9yIHNvbWVib2R5IGVsc2UgY2FuIGJl
Y29tZSB0aGUgbWFpbnRhaW5lciBvZiBtZXRhLWphdmE/DQoNCiAgLS0NCkJlc3QgUmVnYXJkcw0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpXYW5n
IE1pbmd5dQ0KRlVKSVRTVSBOQU5KSU5HIFNPRlRXQVJFIFRFQ0hOT0xPR1kgQ08uLCBMVEQuIChG
TlNUKQ0KTm8uNiBXZW56aHUgUm9hZCwgTmFuamluZywgMjEwMDEyLCBDaGluYQ0KVEVM77yaKzg2
KzI1LTg2NjMwNTY2LS04NTY4DQpDT0lOUzogNzk5ODg1NDgNCkZBWDogKzg2KzI1LTgzMzE3Njg1
DQpNQUlMOiB3YW5nbXlAZnVqaXRzdS5jb20NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBBbGV4YW5kZXIgS2FuYXZpbiA8YWxleC5rYW5hdmluQGdtYWlsLmNvbT4NCj4g
U2VudDogVHVlc2RheSwgRmVicnVhcnkgMjUsIDIwMjUgMzo1NiBQTQ0KPiBUbzogeW9jdG8tcGF0
Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnOyBXYW5nLCBNaW5neXUv546LIOm4o+eRnA0KPiA8
d2FuZ215QGZ1aml0c3UuY29tPg0KPiBDYzogVGltIE9ybGluZyA8dGltLm9ybGluZ0Brb25zdWxr
by5jb20+DQo+IFN1YmplY3Q6IFJlOiBGVzogW3lvY3RvLXBhdGNoZXNdIFttZXRhLWphdmFdIFFB
IElzc3VlOiBNaXNzaW5nIFVwc3RyZWFtLVN0YXR1cw0KPiBpbiBwYXRjaA0KPiANCj4gT24gVHVl
LCAyNSBGZWIgMjAyNSBhdCAwMToyMSwgd2FuZ215IHZpYSBsaXN0cy55b2N0b3Byb2plY3Qub3Jn
DQo+IDx3YW5nbXk9ZnVqaXRzdS5jb21AbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4gd3JvdGU6DQo+
ID4gVGhlcmUncmUgbWFueSBwYXRjaGVzIHRoYXQgaGF2ZSB0aGUgZm9sbG93aW5nIGVycm9yIHdo
ZW4gYnVpbGQgdGhlbToNCj4gPiBkb19wYXRjaDogUUEgSXNzdWU6IE1pc3NpbmcgVXBzdHJlYW0t
U3RhdHVzIGluIHBhdGNoDQo+ID4NCj4gPiBEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnMgcmVn
YXJkaW5nIHRoZSBVcHN0cmVhbS1TdGF0dXMgZXJyb3I/DQo+ID4gU2hvdWxkIEkgZml4IHRoZW0g
YnkgYWRkaW5nICJVcHN0cmVtLVN0YXR1cyIgdG8gdGhlIHBhdGNoIGZpbGUsIG9yIGFkZCAiDQo+
IEVSUk9SX1FBOnJlbW92ZSA9ICJwYXRjaC1zdGF0dXMiICIgdG8gY29uZi9sYXllci5jb25mIHRv
IGlnbm9yZSB0aGUgZXJyb3IuDQo+ID4gT2YgY291cnNlLCB0aGUgbGF0dGVyIHJlcXVpcmVzIGEg
bG90IG9mIHRpbWUgdG8gZmlndXJlIG91dCB0aGUgcmVhc29ucw0KPiA+IGZvciB0aGUgZXhpc3Rl
bmNlIG9mIHRoZXNlIHBhdGNoZXMgYW5kIHRoZWlyIGxhdGVzdCBzdGF0dXMsIGFuZA0KPiA+IHBy
b2dyZXNzIG1heSBiZSBzbG93DQo+IA0KPiBZb3UgYXJlIGFza2luZyB0aGUgc2FtZSB0aGluZyBh
Z2FpbiBhbmQgYWdhaW4uIFBsZWFzZSBkbyBub3QgZG8gdGhpcy4NCj4gDQo+IFRoZSBvbmx5IGFu
c3dlciBpczogbWV0YS1qYXZhIGhhcyBubyBtYWludGFpbmVyLCBhbmQgVGltLCBvciBhbnlvbmUg
ZWxzZSwgaXMNCj4gdW5hYmxlIHRvIGhlbHAgeW91LiBZb3UgbmVlZCB0byBiZWNvbWUgdGhlIG1h
aW50YWluZXIgZmlyc3QuDQo+IA0KPiBBbGV4DQo=

