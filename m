Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27697CCD187
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 08:52:28 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web10.10480.1760431938746868676
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Oct 2025 01:52:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=KyL89Wo9;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: quicinc.com, ip: 205.220.168.131, mailfrom: quic_sasikuma@quicinc.com)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87IEV017790;
	Tue, 14 Oct 2025 08:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PS8LCuOUxPoPK9t4dNFGXkKM
	1UHDdOQEa3t47VIoyWM=; b=KyL89Wo9d4YwVVJW0+aq368zxeLhQvUHsFEsMkxi
	Mj5yjGSULZDyik+QIDOD1JPdhwvtV1Tj/xHAZej6pNXuq0tXxN8qREZofYQOe22X
	PNW+872YpwHGx7gcgdVg5ScCYIrRrstxGEYuM25iis/3QL6NEs0qk7z8qAuivJEh
	q8ttDyo0ji90BsytUGSmb8mzMMcW69SdiCebPh7sQvClDJ4OHreL7OQGuBke0WDf
	xbDU1b5BVVz5O6QAnaQpNt9rEztjAAkuKatvCzNT0Z3MBWYLimcci+mLHS22Wnmg
	hLKqdUGWMhocQwG22rwdoUI21cfSyDPqXpvhdgETopF24Q==
Received: from dm2pr04cu003.outbound.protection.outlook.com (mail-dm2pr04cu00300.outbound.protection.outlook.com [40.93.13.56])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1ac4s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 08:52:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weRnf+K81XClPqXtAO3gbNkuiuKXUl2eyxdRfd1YgOFkgpMmYiRAacB1CNTmZYma+bvhlC6ykiJEUjbhBKOoKcEKrCCqChKqJXB7NdptWEigOCCPydzYT+ju9aDASAWi7J6v9XCq5ZJAjPP0B5uB7JhAtUz3GV6Pz0O6SASKc2EJ1QFhRraPwXSKoRg3EpgZMJhOKNNOTu+S2ZlRkjHFTY+75Qy3PxmQqNxAtBGKSiN3VTF9GQlvejjHc29PZbuw8D3/hMV7G/xkJPYoXt/nzCLS8daSAjvHBLibmVjwYF7RnOB/Ye1Cqzc/d/eBlHg8zPxPxLUTYzcnAmcfVciNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS8LCuOUxPoPK9t4dNFGXkKM1UHDdOQEa3t47VIoyWM=;
 b=NarVciEyKQuYIrGKey7NB9T0RXtcvda99EJ/U4wZy8PDZJRd4dhGNiPum8+udqcdiFXgPtejJ9PCgyXnBD0HBWCZHonbvjXq/uiAHKqs4AABEpFFD6DUjzYoNoYe2BR+O9WCSn4MNCbzmY7nNdQCqzUBa2da5ql/sXMEl8+PZEbr00WFHlksFYrUEeOftDWlEULW5JrsvivrpvlbQjPIFEGT7s2P8GWJx/UpABi+V4xIHr3Bmi9iSuAfnL6He6qljV8jSZDQdtrTpRruptp/CYLq/4T6ZHx2JHHpq2ia7vkLvM9aaQKQzeoE6eOPUL3szceLNcNEGV/RUgXzg8QkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL3PR02MB8986.namprd02.prod.outlook.com (2603:10b6:208:3b6::10)
 by SJ0PR02MB7134.namprd02.prod.outlook.com (2603:10b6:a03:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 08:52:13 +0000
Received: from BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35]) by BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 08:52:13 +0000
From: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>
To: Yi Zhao <yi.zhao@windriver.com>,
        "Sasi Kumar Maddineni (QUIC)"
	<quic_sasikuma@quicinc.com>,
        "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: meta-selinux][PATCH - Do not look HLL files when
 POLICY_MONOLITHIC=y is configured
Thread-Topic: meta-selinux][PATCH - Do not look HLL files when
 POLICY_MONOLITHIC=y is configured
Thread-Index: Adw8L9X3DxEoxiLUTsiBneUmKF6KlQAtOdMAAAAIIRAAAGfAsA==
Date: Tue, 14 Oct 2025 08:52:13 +0000
Message-ID: 
 <BL3PR02MB898682DC436D91B19BA8D1D7E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
References: 
 <BL3PR02MB89865DB6BD360CBD532D749AE8EAA@BL3PR02MB8986.namprd02.prod.outlook.com>
 <a5ad7b6e-3a31-4fa5-83f8-918744c6c32e@windriver.com>
 <BL3PR02MB89860445FD4D9D47B7135FB6E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
In-Reply-To: 
 <BL3PR02MB89860445FD4D9D47B7135FB6E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: yi.zhao@windriver.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB8986:EE_|SJ0PR02MB7134:EE_
x-ms-office365-filtering-correlation-id: 70784ee8-18bf-4dd1-8c70-08de0afef849
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007|8096899003|4053099003|4013099003;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?WdS+ocLL8QO815k1E3IyF9Z0rgM+NiRMJD2bhyhlrIGuvEvou3H3FcXgDkk4?=
 =?us-ascii?Q?1XsvOwVV32MOf6kVdy26c8fUw6YOMOl9OGuLl4GHYufWDpoA3rmza9H1AXoW?=
 =?us-ascii?Q?KlGn1TRXyuR2qoTrFyax58EpnXDeLty9EkGPpmyJWZPCPjSZxbMtPT72JEOz?=
 =?us-ascii?Q?wKdV64uHEwQYUQ0/C5Pil/e933NsC94ZPzEg0lG1Vm9RoOxDKPrpVecd83W9?=
 =?us-ascii?Q?1n5JL7cHK3eLU2GoenF8M/mjRCWnHY+BCxHlXwbAvUe6R3Yq4WpzwEB8D/+d?=
 =?us-ascii?Q?5DRVH/6gc8bwc/6qE8iYkL6WUSXosaUhMyARn2GY8otlBDJgKbw8v33Z7AYz?=
 =?us-ascii?Q?qKhRUEtUgAklahWUGeuy9a5ljYYDcJcV6PNKO/Pv5s4mjPlp84iRdWtQdqny?=
 =?us-ascii?Q?YGEcWKG7D/oRCpmo8WkWFvEkK5AYJBg3T+wDJdi/FcQGdE25gm/GHznkR8A7?=
 =?us-ascii?Q?/GMqhPqUGBHTtdoLN7Ug0qQc6pgpktWiUrKMrxzvLTgBigp8BJ/GuT6LWVD1?=
 =?us-ascii?Q?aEkaQDYn5b1ljgW6ewPjoCz2FE6NtqHD+lJqdximri7Qdquu0sT28RYGgRsO?=
 =?us-ascii?Q?dEFlyKOEk6iHt98YsJHxxmJtkY0seBUKz0JBSnXpVU7v7vbIbXYYi0ZKK8kP?=
 =?us-ascii?Q?+hXhkvcilZ2Gy6V9TN0A9YOOmVaUFLTwkZgyOgQkKTLsuO+EXv/lVSNzb5mw?=
 =?us-ascii?Q?MA1KHeutV5KgNmBpoinlomgRrlUe1lo2481MTMz7WP1WJuXwWJbfAYyE5xhX?=
 =?us-ascii?Q?C587jPrrIzD65jcC3FyeCOzUn7zxO6uxWAwbAPL5WS1exlRdQkBWAgRUVGy0?=
 =?us-ascii?Q?Z1aePoxIOY3uX226xakoQ9xuCPxywHxmyf6R/ttng7aoj0Onb/IMX3Og8+h4?=
 =?us-ascii?Q?tGWCx8TbdInnLa9Au0NzKqkWqYtnqpHjpLZiit0yddKJ+T/Ritobh7EHT14w?=
 =?us-ascii?Q?BqvrrwygOnxpn0qDMMVra/oqgUvyc9P0XYRFxSWy9HOGaqKp9HU/W8bsiwAz?=
 =?us-ascii?Q?4ReW5tLCk3HwH7nJX08CqGHerhKtG1Pm1aG7yWd2L18Cm0KVNVhhkZy0Qpch?=
 =?us-ascii?Q?y5dGPuzhM0HmgOl/oXexsTqI7jGLxWTuM6KhceYJYtSEFkhv/gh9JO2ZkL6y?=
 =?us-ascii?Q?1+yOLu2LE30LvEQLoK1v+/6r9Y1btxm7M/smJv85eewZhfQ7FatJFGzhH0gq?=
 =?us-ascii?Q?GJ/8gStaHF//jO01eJe5hNWodzVLMr22Q5SdOHbsWPIJg/0u1D3GhGHZO7KY?=
 =?us-ascii?Q?wSCerBrsgRxiJBkz1GaZZVm+RPBrLkfkciYxT9Pp/S960gx9SzPNQ1Bq1OqQ?=
 =?us-ascii?Q?ZKYnezAWEBW/QuUJ1TuD0SxP4+Wj29v+qfQ8uKLg2MlmUL2LD+FqhXmT5Dta?=
 =?us-ascii?Q?WtFhmGR9mrqKMf1kBWfdj/JuIb0q+a4m/aDQawLsWWi80jBWzjC5yUxKCE16?=
 =?us-ascii?Q?cAeCR3a4cmGGaepqSGaerwgVLAmdtBqzIIlFV3VHs0qg0ds4jZJbgi4//ERB?=
 =?us-ascii?Q?7Y4RCkVuJpSaly20f8zEYDg1cHE4nYDk5ALe?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007)(8096899003)(4053099003)(4013099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Spld6MS8W7leZfEHh5onMbt30FRivPgPJN3Mf60aMRGWLKx4278j+lSsEy3B?=
 =?us-ascii?Q?qrvE6DCdaoT4bjcGubJZlSE0+3xHHGQfa0CLZNWJy5m+E5n0DJy6hO4bsAqo?=
 =?us-ascii?Q?t48AONB242Cw8UFGVK/H/LxZl6LRGIN3fdQnIq/d3sF+vC9oXl0im6Iw8I+d?=
 =?us-ascii?Q?o///NHqJywYvRJwBqDuhLpt8kuPF4CFGKNvoqh80tda7qshDIwfrjoB/Y7/J?=
 =?us-ascii?Q?N2jfwtpRU3aZ6u1V9ad1DZFo5G/AAd9Fz1y6iepyF1FXWBjgJqSG2gAg8TZ/?=
 =?us-ascii?Q?MNjYQ5Hkji3SamTbxEcy5HKYSBrCvfEEtlNeZ0+Ziryjy5U7XLNbCILooAEk?=
 =?us-ascii?Q?l7KngG4LqeG+1Vl4S5z54P6BppJ+WC5KuWbdhDSXk1pQTWzePrwNVoOxFCFE?=
 =?us-ascii?Q?GpXqV0Lzgm8Df3RF0MCUC9q+hMFDZlZV55hKA+b/xqm79CccHLLFyXj6g5FS?=
 =?us-ascii?Q?78gsz8Mxvn8QPV/bTI4liipZASsDNk3gVKbr6Iya2gs0xYTmNKDeaL7oOvF/?=
 =?us-ascii?Q?0xiBm5wqzxxaUZCFTVFW6uLYklD7ZNPJLhXyLIVfIEDqN/rrJClk+3O5Aevn?=
 =?us-ascii?Q?Hi5XF5HqU3LhG3XEgY8Kk62Wo8tP3BtTUUtFb10W0uAHrmqEnD5D+LGd1nIv?=
 =?us-ascii?Q?M0I4CmXr/PJ57H+Zqjh6OWpHHSwNC9pbuf02GZs4Zxcs489y/3Hadmq5SOto?=
 =?us-ascii?Q?l+lR8S2r79+McqyoHHRWqAAf7a/9e/P1Gj4m7HbpI/F6LYeBKXDi+Q5FynXB?=
 =?us-ascii?Q?RAbPO8yxjNNazRh0WhIt6NZRndZo+6cxfcL4wC4BU3DeYM/ZU7KtyTJjEIIq?=
 =?us-ascii?Q?vKeuwhrFGTRlFjCilPj0HISusZvv40B6XTOL1skN/K17r1TuVucyGX/TJZJy?=
 =?us-ascii?Q?cBVcUccTDop7TidwiKnAACU3tk4kU+tKYQiVpxt7Kz0nH9fSXlBmWDr7HRB9?=
 =?us-ascii?Q?CdHAIM4OIY954F3bUDMpC+/Qb0eIAEgac9vlMOIEmX8qnOv2l5r+eiosK28Z?=
 =?us-ascii?Q?31PK/577x5yEpX6/aCs8/YmF6vbKL3vL5NnVuOezFk9QUKk1ldZV6wiBGVX1?=
 =?us-ascii?Q?XVm4uC+hYSUpPp9D00cJ/1QtmpfdoN55TAmCsoMw54ypnymdQ12x9NEenkqe?=
 =?us-ascii?Q?SxTaw+Jt9eWhiKvbAHvanXNVjAQBmxWjSZgXObRncWC9wvokCQpxImyKD12V?=
 =?us-ascii?Q?pFjhh9qf1LTg+SbfYgB0uW8YVWsJ9CyVy7Q3JGEgoK3UuI4kddS+OtGobdYM?=
 =?us-ascii?Q?2BSXPx04FR5/mNzZr+rhlTe3iAr91K6bwc65ehdrT+w/Mp5cLAoPsiaXafAY?=
 =?us-ascii?Q?7YBZcUlB2IKTknPj9Xtp2w0DF9LVh+8YU9Btoh67tLrfwt8fB/veoc1NUnWI?=
 =?us-ascii?Q?7NqC6g1HS5TY4rImZ3R0dkKztIzOoIHepuMQ1Kv6mE6k/6LX+eTz2cSTvNlX?=
 =?us-ascii?Q?1gcqZr/5ZcGoAV99KcTRe3Bi5ZubIouAqyztx7LWyhAs+dtE2ZhLVk1Z2pcE?=
 =?us-ascii?Q?tie6q9HjFSdkkaiXM1Cs9QI6EazWkp2js4kxEczKPnH6n3n34S5ohhJM/Ze9?=
 =?us-ascii?Q?wl1WCMz+/rm61/Ouu1pu6LVldrsClVhni4dj944D?=
Content-Type: multipart/mixed;
	boundary="_005_BL3PR02MB898682DC436D91B19BA8D1D7E8EBABL3PR02MB8986namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9MsFyWuzFqEAiuf7H6w2KNkKQwcqiKxIOjXKP1hA7opF5lgKcNamdzoeg7y0qEZ6D5zzkLW2tWnnIwmc4tZrj33Zc0YwPSvmlc9TaOwL1CBrjg8uk0fZMeD88wbKg3QuCZ/Mc/+stlsoyt9inzn57ubgFij/gSZ1zb29d6y1VXiBABnsEfDSEwsxaW9w/ZJhmFm/r1UCkQY1bvkGP5ZzxWP5OdLEw81DEjOTNOkrAI/MVUJ8wpqya5813VR/IkPnSDt6K2OZCXz7q7okqUrQLHF5vaZV7Odd6IIDMAZdI60NWGaSdhiU2j4YHi6t3VJL9BXjZYN5/dZuSbBSO6FBlB+AOTyVIZm8BygREu3zwhgCF/Z+zG9zwFw9SMd1UStGYBde2n4A/iqInhIZtrw3yupoHKF9EDl2T2E1BnYBHTJq771fIoHdDkHUvMamjXXQmeOIpuCh1VoLZLtYTr40Ztd/xtCK4EWMJmMYCuUXYB4qDmA9LdbbElZA9L1b8Wig1smvaIlP4eE+R0c430CzTRuken3XeqMAeh/jB7fDJ6K5dt022J9eKrvQpQKdAPZ8QNNRFAhCttF22hOLmhPwVmisgJCpDnCw2AAaECz7n674woVtZ9sNReAou80dW25s
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70784ee8-18bf-4dd1-8c70-08de0afef849
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 08:52:13.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IeHnQCTm5GGd9RTfIxYVpm3HwXKRhszi0bs9fKkly/tREcqe2911AJrrUMMzexDoelRvXfn6GyVGfWe+esK44/zT4BF0bFi+HOcc5twTC68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7134
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ee0f42 cx=c_pps
 a=wTW14iHPWsjxmVSX4jmdzg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=COk6AnOGAAAA:8 a=iGHA9ds3AAAA:8
 a=JZAv2bsQOfyt6W66-AAA:9 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=qODO415F75pXo8RfmBAA:9 a=iqxcGQUJe6CFmoLh:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
 a=hnIUdSgYGJrKyR2U0r8A:9 a=B2y7HmGcmWMA:10 a=BswEn3vCGKkgpsjylGoA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=TjNXssC_j7lpFel5tvFf:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: YpUp112ZmqOx12i_kFm04qORuKzHNtT8
X-Proofpoint-ORIG-GUID: YpUp112ZmqOx12i_kFm04qORuKzHNtT8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfXxIwshZZdBoWW
 4vH6JxoPnrq5TwzO4habolyQms9icJGP6CAer7mptpZSBcIKu2dK3xOzqvet485bLSdlvCbnZQ/
 WYWlA+/psCjT3N1LmfhG8Sj8Rs4Tc9lEaedJV56pTKw9/GbNMrvRXB6mBqWg4zNdExcx5iHld5G
 tt37GyFSlG1gW0ab1rNko/p8UOAyq9P/DU3XeBUploXJlQtdrjZ0+e27HEP55dC7lOWmHgey4ns
 RoiozeTNyv/54m4xytIz+ye77QjivRF51EaR75o961HMn+3zBAV/QeDfKQefhzFa3IcEcIe3acs
 xMR0N4rRBLww5FZzhPnSYAj+e+jHTc7Mra8TMSmjAznuDw1E9d8RClV+TKsYR8Mp1nPNtzrYQtr
 wZbJtCHCXjvqh7yKF/0F3EC3xk8Ryw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 08:52:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2299

--_005_BL3PR02MB898682DC436D91B19BA8D1D7E8EBABL3PR02MB8986namp_
Content-Type: multipart/alternative;
	boundary="_000_BL3PR02MB898682DC436D91B19BA8D1D7E8EBABL3PR02MB8986namp_"

--_000_BL3PR02MB898682DC436D91B19BA8D1D7E8EBABL3PR02MB8986namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi @'Yi Zhao'<mailto:yi.zhao@windriver.com>,


Attached additional patches required for compilation of refpolicy in MONOLI=
TIHIC design and also corrected policy version in semanage.conf as per chec=
kpolicy.

Apply patches in indexed order.

Also, why we don't we configure POLICY_MONOLITHIC to 'y', if our focus is c=
onsumer embedded devices instead of server distributions?


Regards,
Sasi.

From: Sasi Kumar Maddineni
Sent: Tuesday, October 14, 2025 2:04 PM
To: 'Yi Zhao' <yi.zhao@windriver.com>; Sasi Kumar Maddineni (QUIC) <quic_sa=
sikuma@quicinc.com>; yocto-patches@lists.yoctoproject.org
Subject: RE: meta-selinux][PATCH - Do not look HLL files when POLICY_MONOLI=
THIC=3Dy is configured

Hi @Yi Zhao<mailto:yi.zhao@windriver.com>,

I have few more patches to send. I will share by EOD.

1. One issue is the build system is picking the host libsepol instead of re=
cipe-sysroot.
2. Another issue is in rebuild_policy, we need to change policy version to =
35, since policy version depends on checkpolicy version.

I will share patches in a while today.

Regards,
Sasi Kumar Maddineni,
Qualcomm Innovation Center.

From: Yi Zhao <yi.zhao@windriver.com<mailto:yi.zhao@windriver.com>>
Sent: Tuesday, October 14, 2025 2:00 PM
To: Sasi Kumar Maddineni (QUIC) <quic_sasikuma@quicinc.com<mailto:quic_sasi=
kuma@quicinc.com>>; yocto-patches@lists.yoctoproject.org<mailto:yocto-patch=
es@lists.yoctoproject.org>
Subject: Re: meta-selinux][PATCH - Do not look HLL files when POLICY_MONOLI=
THIC=3Dy is configured


WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

Hi Sasi,
On 10/13/25 18:59, Sasi Kumar Maddineni (QUIC) wrote:
Hi @Yi Zhao<mailto:yi.zhao@windriver.com>,


I tried configuring POLICY_MONOLITHIC=3Dy for our consumer embedded devices=
 platform.
The recipe is looking HLL(.pp) files in case of MONOLITHIC as well and buil=
d is failing, which it should not be doing.

So, I raised a patch with the fix and shared the attachment.

Please review provide your valuable comments.



Thank you for your patch. I found that even with this patch applied, buildi=
ng refpolicy still failed when POLICY_MONOLITHIC=3Dy. So it looks like more=
 changes are needed.



//Yi




Regards,
Sasi Kumar Maddineni,
Qualcomm Innovation Center.

--_000_BL3PR02MB898682DC436D91B19BA8D1D7E8EBABL3PR02MB8986namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi <a id=3D"OWAAMBBCC4A59E57B4FDB8A73BA0861EF52CB" h=
ref=3D"mailto:yi.zhao@windriver.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@'Yi Zhao'</span></a>,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Attached additional patches required for compilation=
 of refpolicy in MONOLITIHIC design and also corrected policy version in se=
manage.conf as per checkpolicy.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Apply patches in indexed order.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Also, why we don&#8217;t we configure POLICY_MONOLIT=
HIC to &#8216;y&#8217;, if our focus is consumer embedded devices instead o=
f server distributions?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sasi.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatur=
es:none"> Sasi Kumar Maddineni
<br>
<b>Sent:</b> Tuesday, October 14, 2025 2:04 PM<br>
<b>To:</b> 'Yi Zhao' &lt;yi.zhao@windriver.com&gt;; Sasi Kumar Maddineni (Q=
UIC) &lt;quic_sasikuma@quicinc.com&gt;; yocto-patches@lists.yoctoproject.or=
g<br>
<b>Subject:</b> RE: meta-selinux][PATCH - Do not look HLL files when POLICY=
_MONOLITHIC=3Dy is configured<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi <a id=3D"OWAAM76F26AF067584A9B8776F54127DF480F" h=
ref=3D"mailto:yi.zhao@windriver.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Yi Zhao</span></a>,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have few more patches to send. I will share by EOD=
.<br>
<br>
1. One issue is the build system is picking the host libsepol instead of re=
cipe-sysroot.<br>
2. Another issue is in rebuild_policy, we need to change policy version to =
35, since policy version depends on checkpolicy version.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I will share patches in a while today.<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sasi Kumar Maddineni,<o:p></o:p></p>
<p class=3D"MsoNormal">Qualcomm Innovation Center.<o:p></o:p></p>
<p class=3D"MsoNormal"><b><o:p>&nbsp;</o:p></b></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatur=
es:none"> Yi Zhao &lt;</span><a href=3D"mailto:yi.zhao@windriver.com"><span=
 style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-l=
igatures:none">yi.zhao@windriver.com</span></a><span style=3D"font-size:11.=
0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">&gt;
<br>
<b>Sent:</b> Tuesday, October 14, 2025 2:00 PM<br>
<b>To:</b> Sasi Kumar Maddineni (QUIC) &lt;</span><a href=3D"mailto:quic_sa=
sikuma@quicinc.com"><span style=3D"font-size:11.0pt;font-family:&quot;Calib=
ri&quot;,sans-serif;mso-ligatures:none">quic_sasikuma@quicinc.com</span></a=
><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif=
;mso-ligatures:none">&gt;;
</span><a href=3D"mailto:yocto-patches@lists.yoctoproject.org"><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatur=
es:none">yocto-patches@lists.yoctoproject.org</span></a><span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none"=
><br>
<b>Subject:</b> Re: meta-selinux][PATCH - Do not look HLL files when POLICY=
_MONOLITHIC=3Dy is configured<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p align=3D"center" style=3D"text-align:center"><strong><span style=3D"font=
-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black;backgroun=
d:yellow">WARNING:</span></strong><span style=3D"font-size:10.5pt;font-fami=
ly:&quot;Arial&quot;,sans-serif;color:black;background:yellow">
 This email originated from outside of Qualcomm. Please be wary of any link=
s or attachments, and do not enable macros.</span><o:p></o:p></p>
<div>
<p>Hi Sasi,<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">On 10/13/25 18:59, Sasi Kumar Maddineni (QUIC) wrote=
:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">Hi <a id=3D"OWAAMD1F1AEE518A641D18477FC9978CA9D0C" h=
ref=3D"mailto:yi.zhao@windriver.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Yi Zhao</span></a>,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">I tried configuring POLICY_MONOLITHIC=3Dy for our co=
nsumer embedded devices platform.
<o:p></o:p></p>
<p class=3D"MsoNormal">The recipe is looking HLL(.pp) files in case of MONO=
LITHIC as well and build is failing, which it should not be doing.<o:p></o:=
p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">So, I raised a patch with the fix and shared the att=
achment.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Please review provide your valuable comments.<o:p></=
o:p></p>
</blockquote>
<p><o:p>&nbsp;</o:p></p>
<p style=3D"margin-bottom:12.0pt">Thank you for your patch. I found that ev=
en with this patch applied, building refpolicy still failed when POLICY_MON=
OLITHIC=3Dy. So it looks like more changes are needed.<o:p></o:p></p>
<p><o:p>&nbsp;</o:p></p>
<p>//Yi<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sasi Kumar Maddineni,<o:p></o:p></p>
<p class=3D"MsoNormal">Qualcomm Innovation Center.<o:p></o:p></p>
</blockquote>
</div>
</div>
</body>
</html>

--_000_BL3PR02MB898682DC436D91B19BA8D1D7E8EBABL3PR02MB8986namp_--

--_005_BL3PR02MB898682DC436D91B19BA8D1D7E8EBABL3PR02MB8986namp_
Content-Type: application/octet-stream;
	name="0002-libsepol-add-change-to-pick-libsepol-from-recipe-sys.patch"
Content-Description: 
 0002-libsepol-add-change-to-pick-libsepol-from-recipe-sys.patch
Content-Disposition: attachment;
	filename="0002-libsepol-add-change-to-pick-libsepol-from-recipe-sys.patch";
	size=1245; creation-date="Tue, 14 Oct 2025 08:51:36 GMT";
	modification-date="Tue, 14 Oct 2025 08:52:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1Y2IwNWM3YzBkYmM3MjlhMTQwNWI5YzM4ZGZhNTZkN2MxYWMzMTdkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYXNpIEt1bWFyIE1hZGRpbmVuaSA8cXVpY19zYXNpa3VtYUBx
dWljaW5jLmNvbT4KRGF0ZTogVHVlLCAxNCBPY3QgMjAyNSAxNDowOTo0MSArMDUzMApTdWJqZWN0
OiBbbWV0YS1zZWxpbnV4XVtQQVRDSF0gbGlic2Vwb2w6IGFkZCBjaGFuZ2UgdG8gcGljayBsaWJz
ZXBvbCBmcm9tCiByZWNpcGUtc3lzcm9vdCBzYmluLgoKd2hpbGUgYnVpbGRpbmcgaG9zdCBtYWNo
aW5lJ3MgbGlic2Vwb2wgbGliIGlzIGdldHRpbmcgcGlja2VkLAppbnN0ZWFkIG9mIHBpY2tpbmcg
cmVjaXBlLXN5c3Jvb3Qgc2JpbiBkaXJlY3RvcnkuCgppbml0aWFsaXplICd0Y19zYmluZGlyJyB3
aXRoIHJlY2lwZS1zeXNyb290IHNiaW4gcGF0aC4KClNpZ25lZC1vZmYtYnk6IFNhc2kgS3VtYXIg
TWFkZGluZW5pIDxxdWljX3Nhc2lrdW1hQHF1aWNpbmMuY29tPgotLS0KIHJlY2lwZXMtc2VjdXJp
dHkvcmVmcG9saWN5L3JlZnBvbGljeV9jb21tb24uaW5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9yZWNpcGVzLXNlY3VyaXR5L3JlZnBvbGljeS9y
ZWZwb2xpY3lfY29tbW9uLmluYyBiL3JlY2lwZXMtc2VjdXJpdHkvcmVmcG9saWN5L3JlZnBvbGlj
eV9jb21tb24uaW5jCmluZGV4IDI3YWFjNDQuLjhiYTRkMjggMTAwNjQ0Ci0tLSBhL3JlY2lwZXMt
c2VjdXJpdHkvcmVmcG9saWN5L3JlZnBvbGljeV9jb21tb24uaW5jCisrKyBiL3JlY2lwZXMtc2Vj
dXJpdHkvcmVmcG9saWN5L3JlZnBvbGljeV9jb21tb24uaW5jCkBAIC0xMzEsNiArMTMxLDcgQEAg
RVhUUkFfT0VNQUtFID0gIk5BTUU9JHtQT0xJQ1lfTkFNRX0gXAogICAgIE1DU19DQVRTPSR7UE9M
SUNZX01DU19DQVRTfSIKIAogRVhUUkFfT0VNQUtFICs9ICJ0Y191c3JiaW5kaXI9JHtTVEFHSU5H
X0JJTkRJUl9OQVRJVkV9IgorRVhUUkFfT0VNQUtFICs9ICJ0Y19zYmluZGlyPSR7U1RBR0lOR19E
SVJfTkFUSVZFfSR7YmFzZV9zYmluZGlyX25hdGl2ZX0iCiBFWFRSQV9PRU1BS0UgKz0gIk9VVFBV
VF9QT0xJQ1k9YCR7U1RBR0lOR19CSU5ESVJfTkFUSVZFfS9jaGVja3BvbGljeSAtViB8IGN1dCAt
ZCcgJyAtZjFgIgogRVhUUkFfT0VNQUtFICs9ICJDQz0nJHtCVUlMRF9DQ30nIENGTEFHUz0nJHtC
VUlMRF9DRkxBR1N9JyBQWVRIT049JyR7UFlUSE9OfSciCiAKLS0gCjIuMzQuMQoK

--_005_BL3PR02MB898682DC436D91B19BA8D1D7E8EBABL3PR02MB8986namp_
Content-Type: application/octet-stream;
	name="0003-Correct-policy-version-semanage.conf-as-per-checkpol.patch"
Content-Description: 
 0003-Correct-policy-version-semanage.conf-as-per-checkpol.patch
Content-Disposition: attachment;
	filename="0003-Correct-policy-version-semanage.conf-as-per-checkpol.patch";
	size=1102; creation-date="Tue, 14 Oct 2025 08:51:36 GMT";
	modification-date="Tue, 14 Oct 2025 08:52:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0M2JlNzY2NzU1N2I0NDllOWE0YWZjMDQ2NTU4MWIzZGZmZDUyNDczIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYXNpIEt1bWFyIE1hZGRpbmVuaSA8cXVpY19zYXNpa3VtYUBx
dWljaW5jLmNvbT4KRGF0ZTogVHVlLCAxNCBPY3QgMjAyNSAxNDoxNTozMyArMDUzMApTdWJqZWN0
OiBbbWV0YS1zZWxpbnV4XVtQQVRDSF0gQ29ycmVjdCBwb2xpY3kgdmVyc2lvbiBzZW1hbmFnZS5j
b25mIGFzIHBlcgogY2hlY2twb2xpY3kKClRoZSBjb2RlICJPVVRQVVRfUE9MSUNZPWAke1NUQUdJ
TkdfQklORElSX05BVElWRX0vY2hlY2twb2xpY3kgLVYgfCBjdXQgLWQnICcgLWYxYCIKYXNzaWdu
cyBPVVRQVVRfUE9MSUNZIHdpdGggMzUgYW5kIHBvbGljeS4zNSBpcyBnZXR0dGluZyBnZW5lcmF0
ZWQuCgpTbywgY29ycmVjdGluZyB0aGUgcG9saWN5IHZlcnNpb24gaW4gc2VtYW5hZ2UuY29uZiBm
aWxlIHRvby4KClNpZ25lZC1vZmYtYnk6IFNhc2kgS3VtYXIgTWFkZGluZW5pIDxxdWljX3Nhc2lr
dW1hQHF1aWNpbmMuY29tPgotLS0KIHJlY2lwZXMtc2VjdXJpdHkvcmVmcG9saWN5L3JlZnBvbGlj
eV9jb21tb24uaW5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvcmVjaXBlcy1zZWN1cml0eS9yZWZwb2xpY3kvcmVmcG9s
aWN5X2NvbW1vbi5pbmMgYi9yZWNpcGVzLXNlY3VyaXR5L3JlZnBvbGljeS9yZWZwb2xpY3lfY29t
bW9uLmluYwppbmRleCA4YmE0ZDI4Li45ZjdjODYzIDEwMDY0NAotLS0gYS9yZWNpcGVzLXNlY3Vy
aXR5L3JlZnBvbGljeS9yZWZwb2xpY3lfY29tbW9uLmluYworKysgYi9yZWNpcGVzLXNlY3VyaXR5
L3JlZnBvbGljeS9yZWZwb2xpY3lfY29tbW9uLmluYwpAQCAtMjA1LDcgKzIwNSw3IEBAIHBhdGgg
PSAke1NUQUdJTkdfRElSX05BVElWRX0ke3NiaW5kaXJfbmF0aXZlfS9zZWZjb250ZXh0X2NvbXBp
bGUKIGFyZ3MgPSBcJEAKIFtlbmRdCiAKLXBvbGljeS12ZXJzaW9uID0gMzMKK3BvbGljeS12ZXJz
aW9uID0gMzUKIEVPRgogCiAgICAgIyBDcmVhdGUgcG9saWN5IHN0b3JlIGFuZCBidWlsZCB0aGUg
cG9saWN5Ci0tIAoyLjM0LjEKCg==

--_005_BL3PR02MB898682DC436D91B19BA8D1D7E8EBABL3PR02MB8986namp_--

