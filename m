Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD7CC2A062
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 03:36:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57158.1767584180117115946
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 04 Jan 2026 19:36:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=XkkQFVsc;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: quicinc.com, ip: 205.220.180.131, mailfrom: quic_sasikuma@quicinc.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604Mi3OU3629275;
	Mon, 5 Jan 2026 03:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sk3/ybwn08H84sdKJqm5VCnmgguq6tssdYonL9mMB+k=; b=XkkQFVsc2U6WH0lA
	qQVDW7X61c71bFhYzPRQXQKvB7FTMQK/Xk2A/WKTXtcD0m4Tz5CKT34c5wymCiyg
	dz6bNwoU/I3T2vO/xxgLzlhVkq4orGiLyg0tfaSbPM4EVaD9DgfFfQmoDBAmkRUe
	sYYSdKRkCd4MpQOIGSPfo0R5+OjlkQ173XPUS6Ppe/sPC9aIP1ReN882+0kEbWQW
	ts7qg77YCCJpKTrCEW3hYcLnls8uTFs5c/gMU05sUgXa6uCexDvRwnkNDsQOdGNf
	nXKa0CgcxKbfBQ6r0jto0zRuFT3pkrdwlvwcpDtrom7pD+8S6zBpaE/zttsVqq28
	CM79Lw==
Received: from ds2pr08cu001.outbound.protection.outlook.com (mail-ds2pr08cu00106.outbound.protection.outlook.com [40.93.13.54])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4beu6t30e9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 03:36:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aI+YUyd2CJXTLVZ1wvOwd6+5PbYF0N/lVTrBpe04LYft6kGsFDxlGG6jggCFU/Wy/PIdhOwyMmdfK0JTIIYySPDENLtTupjk8ASu27vZbjiMk5t39BU95yoOrvWoEWh78dNJKmE4jiolkiuM9JgC9Wj8h61a0g8AHYJsFyoWbrnbifUgQfzf9PgrluV70gs2Q0hkzisSbeE/iG0fBJGc0iDkR9taDCjORBdv2ZC2fGsc+RDol5nLruDhDVlj53wika4+IMaIa2ISbT/eg+q1+NLKmqtk2cY0AWpeOfMDiQyUtS2bNpVk7YnDJxfedcy1HLoZNgE1Xl4XAoRiiExKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sk3/ybwn08H84sdKJqm5VCnmgguq6tssdYonL9mMB+k=;
 b=It7x+NXMCQci197McjP0oAZuHiooaYT5dH7EMxYopsOX+drJa6OahSi/i18Mgz03K86dslQHTeBKNm8IGld/gvHCQpdf0MJrrz+fR165Z64wr5gXCT7NTh1rvV1e290Q5aDFwOpmmBjc86QsfP8zSgrDMMbDwvcyA8WbW8bEw++6EJGGnt2+I3jlQykLRg+SdNuLhapaJWVQvmR3KZoVmmTPohOrkuxYujm+j0mmnSsBrTJV/8DjyjsX8qVh2kb8npkSNIXamcgm0pznFdFb6LiMOK/NVvQBGxV5DwGN+SX9T1/If0sk64RYSQopVh2nPvTKu3iZ1vsUn7gzlc0EEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL3PR02MB8986.namprd02.prod.outlook.com (2603:10b6:208:3b6::10)
 by PH7PR02MB9989.namprd02.prod.outlook.com (2603:10b6:510:2f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 03:36:15 +0000
Received: from BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35]) by BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 03:36:14 +0000
From: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>
To: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>,
        "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        Yi Zhao <yi.zhao@windriver.com>
CC: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>
Subject: RE: [meta-selinux][PATCH/V6] refpolicy: Add support to configure
 policy store root
Thread-Topic: [meta-selinux][PATCH/V6] refpolicy: Add support to configure
 policy store root
Thread-Index: AQHceKGN+Dn1P/mfTkKkEOut9eAfiLVC91AA
Date: Mon, 5 Jan 2026 03:36:14 +0000
Message-ID: 
 <BL3PR02MB8986D67092D4E0105B0E4293E886A@BL3PR02MB8986.namprd02.prod.outlook.com>
References: <20251229090000.3305357-1-quic_sasikuma@quicinc.com>
In-Reply-To: <20251229090000.3305357-1-quic_sasikuma@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB8986:EE_|PH7PR02MB9989:EE_
x-ms-office365-filtering-correlation-id: 7d437e44-2714-4529-f7d6-08de4c0b9421
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?92OR/bOwLWi/iCT/MHY6VESk66H2ly3rhywvQLt0mAbSRbr+tPeoir626QXs?=
 =?us-ascii?Q?ioob2a18EaBCT0gWQqDUpkDMhH0gxU0aFi+jUQ14D4J+KznpThrATDsykJta?=
 =?us-ascii?Q?KcNdy276m+Rx0LwG4VA8bV01g2jmJgcjj86Fvfd/04cc6tGqqpxA56ooW742?=
 =?us-ascii?Q?NRX10NOu7VyGvofvhGtSN29RNDn16S/k/m7KxaBR+60VBXGegVJ4Hieb7Svo?=
 =?us-ascii?Q?vT050REGmAs8onPY7djmOuy28MZePAF2TrMhrjw63akUSWfWgmwxKOltbSVv?=
 =?us-ascii?Q?sQxGgBuxUbqTxECbEWt0UZgDMtbJzQHsMtKuLvDCXsOxJ2lRabrLg/GSvL3w?=
 =?us-ascii?Q?KLLK1vch0qOkB9KlZfYJYHxVpSV7iQqCx9PZ6skEcEiK58IlKgipVYc7pnSx?=
 =?us-ascii?Q?TuZq+dazIX061E0QUzzc+St3egASf5XwISo/NnvqQn+0KrzxrgnT2Zyh8CCb?=
 =?us-ascii?Q?bDwJoShfxumGLwMFJroQxpENCieUkRgfJqF1sbhFVeaI93XCGWy8zP90er92?=
 =?us-ascii?Q?j8gOu6k7xl64CWCwycKsNxIxEoN13V4NqC3SkIi8CPI2lFWJXfUezqct/M2K?=
 =?us-ascii?Q?slA0VQcqHQKe2I0TtHQoOkYU3UsT8u/n7quNUVXipLhde/23rdaBGvnJOVXk?=
 =?us-ascii?Q?wNsHj1RahPvlM/yfItNElNXRJNGTzC1hvMwi9pFYJm28mJ9ZZnr9SgvU84tx?=
 =?us-ascii?Q?w/UkbfjBDUBZ07eFexPV6saR3KJ2Q3AfBWb+tg+48zF9SQDjCy7u857LziXf?=
 =?us-ascii?Q?lQ3TGXOMf7ROZiMxR6Et7D0i49hkLlynZBw8FISqrggUkkioXRLDeHnXxb4f?=
 =?us-ascii?Q?kvw7aHwUIvHZ2VCHh+APB9Tyrnd7DrBSd3F9ZhN5+uZoaWDTiNqkvkIC3DV2?=
 =?us-ascii?Q?T+HLxQQR4+zQNGFXeO3/wmcqLxFpyOwFUz7bXiC12shyMLKF8tWWI3eMok84?=
 =?us-ascii?Q?JePIvzfgkLBDwvQweEIEXTbwdJWbrq2966CBqRLpBzlr4M8NcrC0BHem937h?=
 =?us-ascii?Q?KTcDoeMFow+gS7CA8Raq1xTMmk/PvTA/PHRi9NivZnbTAGV/xu9mau42jtdu?=
 =?us-ascii?Q?ONsRmzY2n+4yfx1L29zKDk+X03Uh//SAtFWnMSlWVGEqM6n569q8P0Nm+n4D?=
 =?us-ascii?Q?ijODBsCqsiEdATLn5FcBKlVwali1oXumoHB798FGOxPrLcp7RC4BYcmfSNy3?=
 =?us-ascii?Q?9vEpJPJA9t14Q3CKPFGZCCGFCWoStKHAKpyQc90DxeNhCQzbEXEZc1Ic5Pm1?=
 =?us-ascii?Q?mLuReIKhpDWWw+P/GUQcIzOOwfu/pUoX/NFHERzTXO/ZqMFF1lASRhofMlxM?=
 =?us-ascii?Q?cjqAe636j2kaIBx1d7f7ihA5Q7NuNx87Es5x8Cp0O8wzpX9BV143jbMeXYLR?=
 =?us-ascii?Q?0VZIAgcyT5yTC2Vw3HwUdaCiOQRJy1DE+dCbeKgpA7IG5EarQO9FY2OO5ZCT?=
 =?us-ascii?Q?mCWK5RXITPtrBe41d/XRe9O+jbB/j04e769aE5AdscVEh5gzZuMVloRxVIoD?=
 =?us-ascii?Q?us/45LO00rOkzzwe6F6UkxlA1hgHUpglHzXe?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?bUTx1bghW/Cd7mY0Y+II9k/h77G5nhp0iN0DvY15iT2kBmpKxuDPHhUqohEU?=
 =?us-ascii?Q?6OVSOQ2aRGf9jRmqa/dws2vBy6pBopcJpBVAcBpNFWsRyAi0lx1Br92D2MrV?=
 =?us-ascii?Q?e0ujZt2cLkTkFvMTUGRdjhftMMIss+9peudzlRcRP1OLXMSPNSy2xH+39B5L?=
 =?us-ascii?Q?dH5fQxC6XNp5n7GHH9ajRyA64zHVVHKihkNufhs5VHSPqEHhoRf1TFQialXA?=
 =?us-ascii?Q?/GhRn/vKKi0bdVCrR1lYY/l36HGq/4qdHhysNOfqA8N2cQRjU14pJDjeh6fZ?=
 =?us-ascii?Q?J/qtU0/uBH3qCgohWWAiYAH2DZw5WxmWgbA9S0fC6NkRtE5USiHnzlQ8lvYL?=
 =?us-ascii?Q?sPc0/NAv8yNnUi2uHbPiWpURGuls9RPMVZJkWki5UN5cqoDnJ0mT2x5/XhQ9?=
 =?us-ascii?Q?KtuxCkqG7t0KvKJcj0Ma98kx+4syxSmYRpDSoUbmNqiNNDHPQGa7fMgert0i?=
 =?us-ascii?Q?Wc4kc7q8dhEvSku3zbHL7Hxwiv1o60MZgDMMi8kDxa5kx+baW47ZB2DMo353?=
 =?us-ascii?Q?3aCSmaNgJQ+9r1QbWedUSEg2r9Q72bFCFVCmBTh8wkqXk7PhEE75+tfMDqRe?=
 =?us-ascii?Q?u4CmBcKPJFBQRDBDCux6FV/9MNPqevkNZUx1q9gP8w48pknNmMGfjwHjjAnq?=
 =?us-ascii?Q?8UaF4o3A1pkiouOpJYFX3hDXH0DIRRU6PBpvEYqladcMTwX1rf9nKXYuBj3D?=
 =?us-ascii?Q?ZBXQr4KfBqs8pwCO5wY7drhT4n2jga7fA4amCSHQT4OE2QHffc8SVeIjh7L4?=
 =?us-ascii?Q?9KLdqt2+XvWMefxpKVLB08JGI/VgqT8eoaP1Gk2IH+qz3puhsSX9kcdOXujG?=
 =?us-ascii?Q?2FwC41wEOFoFYITGP7BimFQ3xR1wKZkcZrjsiJHCdA63skjGOLSH5ahv7AlB?=
 =?us-ascii?Q?4HSX/EaBvejN+Xh9Zh7lBDBtv92iHr1F8V9BZpfY4T4R/lt+F+4zKa3WgkhP?=
 =?us-ascii?Q?iFEmARQied3nQIspFVLnOHh8/ABthGmS9V1sfwckYjS7SgqROOFoLh+U7WFz?=
 =?us-ascii?Q?N4FWByhKVoCzyNM9GSEoqSw+Y4KxSnsUYFKxG44zF2PdhbrNm6cHGd7Jv7Zm?=
 =?us-ascii?Q?lAkGLlkz01Haq5ODaKQIr/2qF7H37lOZippjk86jweIlxFQVDuhevY31uG1h?=
 =?us-ascii?Q?2H0PoxvZUgpMzcBzz5Qa552/3nlomWROisuEf3YoqmpZVTWF981Nx63I1G82?=
 =?us-ascii?Q?GlSOGGGe3CGQFfise6CPKGF9/UwreK+pdcdPOGuH8hmE2JGE/kchwCVAVNJY?=
 =?us-ascii?Q?A5xaFVeQr7wL45U5KRtS8FcLetXWMWak3TVbKoFaVHPdZ8VQtNukczEr/l2w?=
 =?us-ascii?Q?agCQfPUIYbnaqNTcV3+CwkaWBJhXxogAfihxP4FNmr5wGd4rS8fMS5SozlbZ?=
 =?us-ascii?Q?YxTqQkUSDgiAgSMNVJaXPLTNsk2OnID6hnQ/86MIuDjST5jdXzsLzNpMK/SJ?=
 =?us-ascii?Q?x9wwuLhkUDBY62ntl2EvaLicIfGvy3StCyj1R+JB/v7KIur17QdcqPjt6fFX?=
 =?us-ascii?Q?0hs4G1Rvf14/O1YfWZuLBs4mWFJEOo87X0k20kp7h3gQtgv84UwVFwAqd6+t?=
 =?us-ascii?Q?EgdY6r6XJbrs5fhltNLVCuEY9AAZV8V9gh8RR7/EeF5MycmvK75fou/4M8pG?=
 =?us-ascii?Q?+qnDk4bR1HOzhTt8lFsaP8QHiqfl5l9MpkXagc1xctvYZFxo782u1ek/Fyiq?=
 =?us-ascii?Q?dO0DfdqT4+ZX1bkf5Qly/rtsy1FlEtPwjGdXi4G7wEG0u2Qgf7FEkKf+hg1n?=
 =?us-ascii?Q?PZsriRa0jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	C1QM0PCHeSaU3Md4j5WEbNPFXcSv1sWnJOwRmTuSUMXcoemhtgnrZG+DqB8Hh7r4grR/Xe41Qr6bjU6AgnvBM887ZNv/qIIHwHsJEL/H3x8obvr75II6SLVD3PJlgfmQvwSdlv0a9M31QE6NDPBuIXlE4VvdwTwvJ2J19LX3BnTmBd4dEXJnegRjAuD0FvPP3lFmd2U7+gxyKqb3yDsuaY0PtXSQ9LtL45j+7GwufhOXKfNrmtXTG4YlEnAMW3GzOSI8KaLIIhljwz3DpHinTL1S1C7MSH/FfgFOVZTPT5pI20Th0AOI6bxA0f5DZqOyQWKa1D4QGXtxKjPAvrw+3KYEXm2pT/gHSIB3FlZZhI2YTHPg66xSa4EVIR0/wmx/SfsXMIqDouo4RQOY3JJ3R2C/YWhZEU+0MBPHiV4emjI/iv4NzKkG37SlpZx0i7DnhV9dVOAhrlskZ4IEQG9c0ymQ+Gb5wPQBa1OytWqNwoLFO5nEwWytVAiJdHaBJbQkaTMDd1Yc60Xf7wBZaGe8Jnl9ULh9GUFBP/kTCGU6OeMD896YqGIFcAy742M5HSiGobqhkeI7iqNwmZNjHH3Jde6kNdy1DxK8QsGzqs1fd7dxwPNf2KoIM8Q68kKhcgXR
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d437e44-2714-4529-f7d6-08de4c0b9421
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 03:36:14.6766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lF1OhoDhM5DkrtV8IBp3nrifnNf6cnRgNgnjJmmTdzwJwbpJ3gSoltQHnk72Obyyo0tcSWQeXpZTaj4RDiqzzODW3NYmmBe4tE9ZHn6FHRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9989
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDAzMSBTYWx0ZWRfX1RyckX0j/3Ft
 tHAhr9AVMhOEUiuk1CxdREKbvrWilwtRGR/L5jQklDDUBVGp3XYXN6lvwEHsEk+VdnB/v81rtbD
 nGzGujEykLeMu/YQci9iMSQt2lgPR+3btbM20FEeRwWujBZlUsokhgpJlRWjGLHLpnI7JptZptt
 WHbo/7O6+cqcHERKHzMeDmjI/7WBmpzTbGYVTTtSWCt3gNYGt2+XEyJeuQAo3/6SIsfJCAqo1qh
 eFzIiyYVb5Q7gj42ksov/asNU0VobhCatRhPBWE56vyjfOYC1LSFdyOHFCi8WcZI4e35WaFOjDz
 /fD/SKvzkBikRJOHT8Xmme5Q4YLwV8vD9hGxvyi7QSwcEFq55hmht9CKwME4PLwjBa6iMAFJ5uF
 YdntKNCv02ocWzJHvuV+Fn4PyTy/lt89z0rf8fOZ9v6xh6Nq7YCx4fWkO5T4AHz9c2/Aoc/IZq5
 DX4C5Sz2p+fVnfgpPPA==
X-Authority-Analysis: v=2.4 cv=HLbO14tv c=1 sm=1 tr=0 ts=695b31b2 cx=c_pps
 a=GoGi1iBRA8+OE3v1NGiPow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=iGHA9ds3AAAA:8
 a=4p1s0Iwa_o4pawxpfK8A:9 a=CjuIK1q_8ugA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: ejiv9fN0J_SkyWbWM50OK7YElYT0PCUT
X-Proofpoint-ORIG-GUID: ejiv9fN0J_SkyWbWM50OK7YElYT0PCUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050031
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Jan 2026 03:36:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2894

Gentle reminder!!

Can you please review the V6 patch.



Regards,
Sasi.

-----Original Message-----
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>=20
Sent: Monday, December 29, 2025 2:30 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni (QUIC) <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/V6] refpolicy: Add support to configure polic=
y store root

By default, policy modules(*.pp) are stored in /var directory.
Features like: ostree remove files in folders like /var variable data direc=
tory while build time.

Added support for custom policy store. We can now configure path to custom =
policy store to variable `POLICY_STORE_ROOT`.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 .../refpolicy/refpolicy_common.inc            |  9 ++++++---
 recipes-security/selinux/libsemanage_3.9.bb   | 20 ++++++++++++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-secu=
rity/refpolicy/refpolicy_common.inc
index 964906b..59dfecd 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -77,10 +77,12 @@ SRC_URI +=3D " \
 S =3D "${UNPACKDIR}/refpolicy"
=20
 CONFFILES:${PN} =3D "${sysconfdir}/selinux/config"
+
+POLICY_STORE_ROOT ?=3D "${localstatedir}/lib/selinux"
 FILES:${PN} +=3D " \
     ${sysconfdir}/selinux/${POLICY_NAME}/ \
     ${datadir}/selinux/${POLICY_NAME}/*.pp \
-    ${localstatedir}/lib/selinux/${POLICY_NAME}/ \
+    ${POLICY_STORE_ROOT}/${POLICY_NAME}/ \
     "
 FILES:${PN}-dev =3D+ " \
     ${datadir}/selinux/${POLICY_NAME}/include/ \ @@ -165,7 +167,7 @@ prepa=
re_policy_store() {
     oe_runmake 'DESTDIR=3D${D}' 'prefix=3D${D}${prefix}' install
     POL_PRIORITY=3D100
     POL_SRC=3D${D}${datadir}/selinux/${POLICY_NAME}
-    POL_STORE=3D${D}${localstatedir}/lib/selinux/${POLICY_NAME}
+    POL_STORE=3D${D}${POLICY_STORE_ROOT}/${POLICY_NAME}
     POL_ACTIVE_MODS=3D${POL_STORE}/active/modules/${POL_PRIORITY}
=20
     # Prepare to create policy store
@@ -207,13 +209,14 @@ args =3D \$@
 [end]
=20
 policy-version =3D 35
+store-root =3D "${POLICY_STORE_ROOT}"
 EOF
=20
     # Create policy store and build the policy
     semodule -p ${D} -s ${POLICY_NAME} -n -B
     rm -f ${D}${sysconfdir}/selinux/semanage.conf
     # No need to leave final dir created by semanage laying around
-    rm -rf ${D}${localstatedir}/lib/selinux/final
+    rm -rf ${D}${POLICY_STORE_ROOT}/final
 }
=20
 install_misc_files() {
diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-security=
/selinux/libsemanage_3.9.bb
index 2425a2e..1279cce 100644
--- a/recipes-security/selinux/libsemanage_3.9.bb
+++ b/recipes-security/selinux/libsemanage_3.9.bb
@@ -32,6 +32,8 @@ FILES:${PN}-python =3D "${PYTHON_SITEPACKAGES_DIR}/* \  F=
ILES:${PN}-dbg +=3D "${PYTHON_SITEPACKAGES_DIR}/.debug/*"
 FILES:${PN} +=3D "${libexecdir}"
=20
+POLICY_STORE_ROOT ?=3D "${localstatedir}/lib/selinux"
+
 do_compile:append() {
     oe_runmake pywrap \
         PYLIBVER=3D'python${PYTHON_BASEVERSION}' \ @@ -46,9 +48,21 @@ do_i=
nstall:append() {
         PYLIBVER=3D'python${PYTHON_BASEVERSION}' \
         PYTHONLIBDIR=3D'${PYTHON_SITEPACKAGES_DIR}'
=20
-    # Update "policy-version" for semanage.conf
-    sed -i 's/^#\s*\(policy-version\s*=3D\).*$/\1 35/' \
-        ${D}/etc/selinux/semanage.conf
+    conf_file=3D"${D}/etc/selinux/semanage.conf"
+
+    if [ -f "${conf_file}" ]; then
+        # Update "policy-version" for semanage.conf
+        sed -i 's/^#\s*\(policy-version\s*=3D\).*$/\1 35/' \
+            ${D}/etc/selinux/semanage.conf
+
+        # Update "store-root" for semanage.conf
+        if grep -q '^store-root=3D' "${conf_file}"; then
+            sed -i "s|^store-root=3D.*$|store-root=3D${POLICY_STORE_ROOT}|=
" "${conf_file}"
+        else
+            printf 'store-root=3D%s\n' "${POLICY_STORE_ROOT}" >> "${conf_f=
ile}"
+        fi
+    fi
+
 }
=20
 BBCLASSEXTEND =3D "native"
--
2.43.0


