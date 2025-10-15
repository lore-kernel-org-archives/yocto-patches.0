Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2019CCD18E
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 04:31:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web10.8129.1760502662553749590
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Oct 2025 21:31:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=b8ouhtWC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: quicinc.com, ip: 205.220.168.131, mailfrom: quic_sasikuma@quicinc.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sAlF004061;
	Wed, 15 Oct 2025 04:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EtZzM73Io8P+UT7tWP5CA9la
	lwpFd0Pd/ENt4x181hM=; b=b8ouhtWCLh5epyJI5VOJD545d8390cdPLeh7XW8d
	cEhd44j0KGvj9n24Jj1WiS8Z88xNnxsKDGhCDTEQ2fYoBMKOCU09ZuaKHHr3kgzq
	54CFdlpd5fLGjGI4fy2Y5Rj9ZRug20thufCkD6VE4i+Ur5MsbXTjK7t4loEi9rIe
	jOju/LscEJrzUyqb4xUkK8qMdd7Mza7PhP8Dgx3B43jvCdpP4zqox6Jbfnp9vdJp
	wSVTUssQNOXvEQ/W9tiKCwOMij+oYtKRGVULYE00pOhyOfNYgHZYRezQizwd+Yh5
	yehvYFr6jlIuJ6uiuTOU6RDREi6FDvvGncpVOXXdw4Ztxw==
Received: from bl0pr07cu001.outbound.protection.outlook.com (mail-bl0pr07cu00100.outbound.protection.outlook.com [40.93.4.0])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwnb41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 04:31:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlIAM8jZ1KTf9C7kTnliv2T5js5RNOWe13cVcihF7WI/JznXl/JdQzhMONK4GgO/86Qr7NWvW8GJuf1n8Fqc+LzKrIKiewjFbO0oWuDvX8NxzF7vJXbGkj4V1674PraPsvfa8q93KzJzmP4DooqnYxTPk9INB4tnjFu5QJjWOuBPOrufP+hjX5Kpp9v92Vx6qVANZv/FUR9AeQUB2qusEqOEZdxtr4mU6sZ7sqKwbWm2Kqgpoju2kPbLKmMGUqdBBlwCjMz3DhX32Td8EMe6BqlkJu3gzVVPAk5mCO82Rx1wFoORgYh0V+rmP0JqnlEWtJ+TUwELCBGsXN+G1X46oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtZzM73Io8P+UT7tWP5CA9lalwpFd0Pd/ENt4x181hM=;
 b=ZYxCpXn4x7QQKxk+5SQ9i+paaMHopajpeY63S9oX8/GBp/frGEu2hsiVJbE2ZlSQmXKbwhKIwi8EebhAeO9agcrcmfbe4HH3TpoGZE3z1sRby6BAfhz+TjMdI9PxuZZnR2xc4dDGwUBiqanmWeOffSeaoirYhxDTboRK9JgzmOpJaBjmbAZ0LbUrkiM+qfv7nbkuPiOY538J8ncIbhlcaCzPYPveRlnZUFj3n4+Wo1aT3nH2IJYS0jPhuBPmzO6MjT7cGoZnK3MpMdoDcdO7X0NVHc8eT+ipD7rrYqabXwB257NT0fNqWtnqWlrMFWrGZy/sPENC4/f8akU9xyAfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL3PR02MB8986.namprd02.prod.outlook.com (2603:10b6:208:3b6::10)
 by CO6PR02MB7842.namprd02.prod.outlook.com (2603:10b6:303:ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 04:30:57 +0000
Received: from BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35]) by BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35%7]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 04:30:57 +0000
From: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>
To: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>,
        Yi Zhao
	<yi.zhao@windriver.com>,
        "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        "Ravi Kumar Siddojigari (QUIC)"
	<quic_rsiddoji@quicinc.com>
Subject: RE: meta-selinux][PATCH - Do not look HLL files when
 POLICY_MONOLITHIC=y is configured
Thread-Topic: meta-selinux][PATCH - Do not look HLL files when
 POLICY_MONOLITHIC=y is configured
Thread-Index: Adw8L9X3DxEoxiLUTsiBneUmKF6KlQAtOdMAAAAIIRAAAGfAsAALB2tAAB4sG9A=
Date: Wed, 15 Oct 2025 04:30:56 +0000
Message-ID: 
 <BL3PR02MB8986181C0A920AE4066F9950E8E8A@BL3PR02MB8986.namprd02.prod.outlook.com>
References: 
 <BL3PR02MB89865DB6BD360CBD532D749AE8EAA@BL3PR02MB8986.namprd02.prod.outlook.com>
 <a5ad7b6e-3a31-4fa5-83f8-918744c6c32e@windriver.com>
 <BL3PR02MB89860445FD4D9D47B7135FB6E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
 <BL3PR02MB898682DC436D91B19BA8D1D7E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
 <BL3PR02MB8986CD337ABA02BE9D5C7265E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
In-Reply-To: 
 <BL3PR02MB8986CD337ABA02BE9D5C7265E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: yi.zhao@windriver.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB8986:EE_|CO6PR02MB7842:EE_
x-ms-office365-filtering-correlation-id: df6901ed-f03d-4d0a-540d-08de0ba3a2b0
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|8096899003;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?wjI4Yu+Mz2IiRUTWP21NDXXA0EUwg/Pci9Bu9aybKUSDzwTs7IXVzUN0W2cj?=
 =?us-ascii?Q?DMU7nUXAdvYiKFduUcjdFTpYq5WWO35oX2+eqmN5d7Cu+ML81rX6aj47p/ri?=
 =?us-ascii?Q?QljPdNCS1OUo9GxfyJQu3Miq3YE3JoOveutlstl9ubUy+vxNED80E16wustk?=
 =?us-ascii?Q?gtkXpEOPzQaEqWx3naIUAJ22dBOBEOpWlK03q8bvDQxPsXfUSbwgVLoGAU+1?=
 =?us-ascii?Q?79hBT8/KhnYc1ZQlOAJL0m8p8u4E0iE0xBju+HAvljIcyNLVw82SNJB1BqDf?=
 =?us-ascii?Q?wgCGJxrgupqxjBAk/GpdIHNAZovlRIuAo99brweG460aU4qpkpr2lXw3YIjV?=
 =?us-ascii?Q?UBuv+BV48k2ZCdZ4gQBd3cd/ZmL1xJSYCJ4vFXVxHZQPfo5kVxFpB9hojX1z?=
 =?us-ascii?Q?YSIMD3wP86rfvF0D7NLoW7qmzE7QgeJ7+xZss3S9kWECStfcJcSXIexoalEy?=
 =?us-ascii?Q?/h2HfRwOzEfQdBHVETiOhv4Pv3LwOIKSJp51y0ui4SMmBWI1npGM/x20uXjF?=
 =?us-ascii?Q?1SG4M7WVxTsUeZL9jh9ITyRB1SP2SrTLNdWUKDiUTddAP9dmO5olcv0F0nZy?=
 =?us-ascii?Q?QW3Xzf1HN07OlhTKlHx/5OiPY/6VyRX2CdfUOKzT2N4TQSCXUVTP86kifZ3j?=
 =?us-ascii?Q?TdJsV11fzH5eI16eG0Ge3EowuWIRepGwnMIvWyjNqSqXo3xmVrRzrFx2nahv?=
 =?us-ascii?Q?+NoE9HNaz4LA471N3dve04t9dIhdH2CvNQ9lYgDdQpJYO7LNzRTFve7sXPCn?=
 =?us-ascii?Q?4NOE2PslislxHBC1XprXe7p8PM5v1ns/k08D/TkZl6hRUfoqB6FCmaNL4eAD?=
 =?us-ascii?Q?zpdNzWG4LWSZSX1mWF3tUKzxPIXq2OdnPYwAyEGFrTPHsZaBsSstK5SDkR24?=
 =?us-ascii?Q?PXkBeGFWqY0UxJQVVzwAagwSI1yJ/wB3vztokA29Lctu1SZfo/Zlq+1F5J70?=
 =?us-ascii?Q?0bBhv0izH+JuRqynKWAQ4fT2iKD4kk2cKG6cGnfDZ6cIy9n1tCfjwAVs5RoG?=
 =?us-ascii?Q?hL4v0TrYTgtGtpd1HEol1QeTf+foBUgo6/tGFmUp+n53TsX4j+lfuaeCPEx9?=
 =?us-ascii?Q?dr4fbRWtL/JFj8Rr3LiK6Ibc6mkLrdlHLmIPipl/oR55wzKvPSrK/YxOt9Yq?=
 =?us-ascii?Q?2jPD1TCasl5HCqJgnJLRKkU2paUrYAH54PC4VpNOds78ExLXiQFCOpGrMMO3?=
 =?us-ascii?Q?MSLYh8fEe0NNTMZW88tVh54dbvArdjm/60f50OSmS+MPat1Tu9yyp0CCp+ce?=
 =?us-ascii?Q?+rCRN5rwyfwAjgwdJxzyrO+gSdnMtiq2kKvj80ia3mOk4/HAyRknUzJ5w9he?=
 =?us-ascii?Q?HffFqoAAy4at8QoP17NBt7vrI9YIRA+730w4+Xb3CLbfp7tdUd02FhSLleSl?=
 =?us-ascii?Q?KBmRVwUBNe2MM1cKf8Pya7CMdRrRbbLqA2oNw/5i27s6RbBhZ4a90Jp71Y0S?=
 =?us-ascii?Q?oj9kfwVV33MzczoUWnhAS36Gq74SAkDQo7lTIHb5ubfpj5qb02I/OxxNzFC3?=
 =?us-ascii?Q?AvrPu58F/9YLf5CR5ltDFk9YJjDWOy0JdkRW?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?qwcFVNUHMzSyVC4HdDwuykRKJ+0bw2YPGnw0okJorBZEFRkjdPtJemI6Vcn7?=
 =?us-ascii?Q?6q6WS8Nx9DA1ADLcsrBbHXTMTrhUhcl14ILAvzHX0t+uN2S8A8eGjBRSlziz?=
 =?us-ascii?Q?Zcx//s8uuZALg5ZD0kcMxXicbMIAKWQEJM8XmbJMn+c7RpApCZTKQZKB3XaN?=
 =?us-ascii?Q?o8PZ3AI8hiry+gA8bY8JAAxo1o+sCnnEy5HFvrJBsXvbE6XtlOBV1bMBJpL7?=
 =?us-ascii?Q?6vq8r9TJa7DvCdk1IvPAnQ+7pJyerFpUT8RasMfhoB22angNbqpGv09xHt8c?=
 =?us-ascii?Q?ye1hkid01hZvE9AE+/TnAUhsjTIv/ZdXqlP1dhbTVfyphG2u03YgSgHYe6ZR?=
 =?us-ascii?Q?pXy9LTL8t3yz57lapQNndjNyuyGv6E7Kou+n6R2lGOmqJUgY8JIXKqwvR7y/?=
 =?us-ascii?Q?yDOGlalIeIl9tIkBhyEy5qSk1yB1YCayw9KjxYizG5FRz7kbzoXRxJjotTIP?=
 =?us-ascii?Q?tCd8zrvpF/zsBG8fpqRbobhOmwX6hqsNe0VjwWwapSktlkuBh6C624/Zf9pO?=
 =?us-ascii?Q?V/6+QznYr3LB72SBa+Cy848ADdQnQ25kvsQenUgkdpNgWKLKtc3u/2o9iYbW?=
 =?us-ascii?Q?B1GACbJMsTPw6tc9O99zmvzaSkfMdDJxWyyyJGcwFkKv4985pPoBwmG0iJGK?=
 =?us-ascii?Q?2mJ/B6UzqYTgZFatS4AedZ/JMf4IKQjWKgwpB8YCak5FkxlXNai4seTtZy3c?=
 =?us-ascii?Q?bk2dkFjb1p0Iwo6Pn4EbFmdKinECoWf2yw1JStok5xngBwpcMkNHKGH5kO0r?=
 =?us-ascii?Q?l2kopO0Pjxm9feVGHdYZ1Jgfg1tb0vRSZ7Xlpb07lwpGdMTR9TWqICxW2yCr?=
 =?us-ascii?Q?WApw8SSz9MbrvlK3R8x94MsYNlx2ZR4/av+hXaAenpuDuVycOIgFRSHoRO7F?=
 =?us-ascii?Q?U92LctGGW9lBS3AouAnBXpVdzTpxZCk/xNvPPIKuUg1N9aHgC3apFG/xGPtb?=
 =?us-ascii?Q?JcFdm6G4CIdajYsbO2SS6m7bmhU0SaROpXhVzTs4h60pZirKUSY6RT2y5PUH?=
 =?us-ascii?Q?RdYkUv+2e/DuP1Pe9CaYrSs3r0bP5KdGwPFWNAcf/11tq2bQZhJ/AkwRpA/Z?=
 =?us-ascii?Q?cCytlKOi28pV9uIwiHYtIinSjLBZKfhgJl9m7g6HptOPxJyUEP3nx+XGgPF/?=
 =?us-ascii?Q?E6JrFgBu1EWwji9wS6w7KMaPvIZrrClVnA2AhjNwaC9lF0J8hHNslAUTGLxf?=
 =?us-ascii?Q?lRVefinmCaccTfQ5+lt/l4BtS4Hi+WZIDgvPNsyGB/rEyXuaxm51Bzw9WZtE?=
 =?us-ascii?Q?exnJQaVw/XHPYFPnOPozICy/L642EGQE1RYrqcFNB9toOhRmo4kqyrPm9MpK?=
 =?us-ascii?Q?NLQQvxQ9PfyxF8Vg2LZxn/E3SHSPhcqMsaqtqgZDU2e8/fu8I5gtH1BiRvZ3?=
 =?us-ascii?Q?0Xm/JQlGAAfVZhItz8XV9kPu9s4gUijmOukbdfCrl484IZjdf7uhSKGHrw8s?=
 =?us-ascii?Q?9u0Mu5br9adDRZ1yLy9NYGsX9u7umCJuVTYcomFEK/Y35UpXySjR3NB7ZUYP?=
 =?us-ascii?Q?9xSlo7zMxc+7c0D9XOAjbF/gLDfGhdgpnsRYNZiXCRJnACcaKre3fka6h8Gd?=
 =?us-ascii?Q?+nzv/SKzGLwvn21LdD88XyCaKhZdrstLA/2ITpuD?=
Content-Type: multipart/alternative;
	boundary="_000_BL3PR02MB8986181C0A920AE4066F9950E8E8ABL3PR02MB8986namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	o+Rd4RXbOA6JoavQ4sb88KvbCxvnu6jomPsbcH8gSIr76WIB/V4gwKGMgFBxFWgvbqiZmmICd+FwCIliINwoEObQx5p1oacu8gLhKMitevZxjkPjpHZ77PARXYZl5l2e5lAdKBbDnJ+in4fobfNJw+SN0ToxnjINORMyT4wjLoVsDcOOjCNkwUX03UTRJa7sn6iMC6EJQSkqzoUS/qQLEhESdgVhuUzEePH9vQt8J/tzt4IZrb7EIrKsUKCLvR5dy83L1k2SkOId4nubyWxkg+DFZyqaVPu9xq6ER1LzkIwUzfj6b7rQ6++/lm6njQStK36pGXuHf0GWwsfX/ZUA/+punzOytX4K+z9JeHVb1TV3x6L4UZpqkDuTRMzBu09YR4rvij1qDDd5lZ6wYI567Hlj+trPgLj0pm0b0SoQAqIl2YL2ZUFxseAhtwdyu6ioTc6otGGs7uFtmDilMeZW81cOpF1vc5Pb7sDbTqEtBTw4UziJTL2gqGkO2uRmViR7zlIshSEa8neHWerWGgcy0F6IOcRiL8PcChDBtfgCseBoLVA6uxtLwZ/DUaMycUne78rdneXbddz4Uy3cyi51H9bWPmr+dBliQ7GEJOgLoR3qKqXIEdGx+MZZ+AXfYPe+
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6901ed-f03d-4d0a-540d-08de0ba3a2b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 04:30:57.0049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYk9gZWL0ABer4qJJOxj1ex4/0PdLKayYUmwZl+wegbXSs4djILAOgoW2uOGZh4t+dzkbjD+dhGseweEaWga7mhUu6wsN/dreRcrCGhT1FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7842
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX4HbHeIT7bgCt
 TpdUoG+c+98Dwyo9fbmtNdGy/tIIfqDwoBestMUQLV2cGEnLVUqdTfg0v3Q2ATzCJ+wdMGjqugk
 tdYJCd25rKjbkHePMWNNgrVevL9mIicRddFp9+ICaGymY2HjODNrhssU8+T2nkyCi1ZWz518Fr3
 U4lTpVS7PxqF3Qziof/ic5xY7rZPCD6V8UMx10cW41nSsGzkkG6nGTYE+uF/FcI2XRBxAl1VF8I
 cyGyG4mqbYwZignOtZKVIpR+l0CKBMfMEQpJAjLc9RmE4wm6YFOZ3BbEUibkPkk8BfhaH81wxPJ
 kQUJv4tWGoIK0Wn62E9WwY+DU+DNXgBUjCPOl9tE4qrZIHVbOiTBZEc0yrCrLC2NB+O9Fca03xF
 1Ihja6s65u4OQTNTDH28fsLkgqvXBg==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68ef2386 cx=c_pps
 a=R7I9PRAlQjBSNlIBhwzs+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=COk6AnOGAAAA:8 a=iGHA9ds3AAAA:8
 a=dfANX6N1_J-R22Ut6SAA:9 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=0mjqmhcZCS2Jpz0VgNUA:9 a=Uc1BC7z2z7GBOkqu:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
 a=FdTzh2GWekK77mhwV6Dw:22 a=TjNXssC_j7lpFel5tvFf:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: cEY3W1M-lgBExPvoC3gnlq9p5REtJ5y0
X-Proofpoint-ORIG-GUID: cEY3W1M-lgBExPvoC3gnlq9p5REtJ5y0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Oct 2025 04:31:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2308

--_000_BL3PR02MB8986181C0A920AE4066F9950E8E8ABL3PR02MB8986namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi @'Yi Zhao'<mailto:yi.zhao@windriver.com>,


There is one more issue, where yocto build system task "do_package_qa" stag=
e checks for host reference paths in the source files and flags it.

Yocto's "do_package_qa" task says "ERROR: QA Issue: File /etc/selinux/targe=
ted/contexts/files/file_contexts.homedirs in package refpolicy-targeted con=
tains reference to TMPDIR [buildpaths]".

This is a false positive and needs to be fixed somehow. I have work around =
which is to skip the "do_package_qa" stage with the change "do_package_qa[n=
oexec] =3D "1"

The content of "file_contexts.homedirs" will as follows which is as expecte=
d.

File_contexts.homedirs content:
/home/[^/]+/\.pki(/.*)?         user_u:object_r:user_cert_t:s0
/tmp/gconfd-[^/]+               -d      user_u:object_r:user_tmp_t:s0
/tmp/gconfd-[^/]+/.*            --      user_u:object_r:gconf_tmp_t:s0
/home/[^/]+/\.dbus(/.*)?                user_u:object_r:session_dbusd_home_=
t:s0
/home/[^/]+/\.java(/.*)?                user_u:object_r:java_home_t:s0
/home/[^/]+/\.kube(/.*)?                user_u:object_r:kubernetes_home_t:s=
0
/home/[^/]+/\.wine(/.*)?                user_u:object_r:wine_home_t:s0
/home/[^/]+/Music(/.*)?         user_u:object_r:xdg_music_t:s0
/run/sudo/ts/[^/]+              user_u:object_r:pam_runtime_t:s0
/home/[^/]+/\.xauth.*           --      user_u:object_r:xauth_home_t:s0
/home/[^/]+/\.gconf(/.*)?               user_u:object_r:gconf_home_t:s0
/home/[^/]+/\.gnome(/.*)?               user_u:object_r:gnome_home_t:s0
/home/[^/]+/\.gnupg(/.+)?               user_u:object_r:gpg_secret_t:s0
/home/[^/]+/\.irssi(/.*)?               user_u:object_r:irc_home_t:s0
/home/[^/]+/\.adobe(/.*)?               user_u:object_r:mozilla_plugin_home=
_t:s0
/home/[^/]+/\.gnash(/.*)?               user_u:object_r:mozilla_plugin_home=
_t:s0
/home/[^/]+/\.pulse(/.*)?               user_u:object_r:pulseaudio_home_t:s=
0
/home/[^/]+/\.pyzor(/.*)?               user_u:object_r:pyzor_home_t:s0
/home/[^/]+/\.razor(/.*)?               user_u:object_r:razor_home_t:s0
/home/[^/]+/\.spamd(/.*)?               user_u:object_r:spamd_home_t:s0
/home/[^/]+/vmware(/.*)?                user_u:object_r:vmware_file_t:s0
/home/[^/]+/\.cache(/.*)?               user_u:object_r:xdg_cache_t:s0
/home/[^/]+/\.local(/.*)?               user_u:object_r:xdg_data_t:s0
/home/[^/]+/Videos(/.*)?                user_u:object_r:xdg_videos_t:s0
/home/[^/]+/\.fonts(/.*)?               user_u:object_r:user_fonts_t:s0
/home/[^/]+/\.docker(/.*)?              user_u:object_r:container_conf_home=
_t:s0
/home/[^/]+/\.gconfd(/.*)?              user_u:object_r:gconf_home_t:s0
/home/[^/]+/\.gnome2(/.*)?              user_u:object_r:gnome_home_t:s0
/home/[^/]+/irclogs(/.*)?               user_u:object_r:irc_log_home_t:s0
/home/[^/]+/\.kismet(/.*)?              user_u:object_r:kismet_home_t:s0
/home/[^/]+/\.galeon(/.*)?              user_u:object_r:mozilla_home_t:s0
/home/[^/]+/\.spicec(/.*)?              user_u:object_r:mozilla_plugin_home=
_t:s0



Regards,
Sasi Kumar Maddineni,
Qualcomm Innovation Center.

From: Sasi Kumar Maddineni (QUIC)
Sent: Tuesday, October 14, 2025 7:31 PM
To: Sasi Kumar Maddineni (QUIC) <quic_sasikuma@quicinc.com>; 'Yi Zhao' <yi.=
zhao@windriver.com>; 'yocto-patches@lists.yoctoproject.org' <yocto-patches@=
lists.yoctoproject.org>; Ravi Kumar Siddojigari (QUIC) <quic_rsiddoji@quici=
nc.com>
Subject: RE: meta-selinux][PATCH - Do not look HLL files when POLICY_MONOLI=
THIC=3Dy is configured

Hi @'Yi Zhao'<mailto:yi.zhao@windriver.com>,

A minor corrections were did in 2nd and 3rd patches and re-sharing the patc=
hes. Apologies for the inconvenience.

Please review and provide your comments at the earliest as possible.

Regards,
Sasi Kumar Maddineni,
Qualcomm Innovation Center.

From: Sasi Kumar Maddineni (QUIC)
Sent: Tuesday, October 14, 2025 2:22 PM
To: 'Yi Zhao' <yi.zhao@windriver.com<mailto:yi.zhao@windriver.com>>; Sasi K=
umar Maddineni (QUIC) <quic_sasikuma@quicinc.com<mailto:quic_sasikuma@quici=
nc.com>>; 'yocto-patches@lists.yoctoproject.org' <yocto-patches@lists.yocto=
project.org<mailto:yocto-patches@lists.yoctoproject.org>>
Subject: RE: meta-selinux][PATCH - Do not look HLL files when POLICY_MONOLI=
THIC=3Dy is configured

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
To: 'Yi Zhao' <yi.zhao@windriver.com<mailto:yi.zhao@windriver.com>>; Sasi K=
umar Maddineni (QUIC) <quic_sasikuma@quicinc.com<mailto:quic_sasikuma@quici=
nc.com>>; yocto-patches@lists.yoctoproject.org<mailto:yocto-patches@lists.y=
octoproject.org>
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

--_000_BL3PR02MB8986181C0A920AE4066F9950E8E8ABL3PR02MB8986namp_
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
span.EmailStyle23
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
<p class=3D"MsoNormal">Hi <a id=3D"OWAAM2ADB39E2792B4DD5B665BA4F1F686F84" h=
ref=3D"mailto:yi.zhao@windriver.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@'Yi Zhao'</span></a>,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">There is one more issue, where yocto build system ta=
sk &#8220;<b><span style=3D"background:yellow;mso-highlight:yellow">do_pack=
age_qa</span></b>&#8221; stage checks for host reference paths in the sourc=
e files and flags it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yocto's &quot;do_package_qa&quot; task says &quot;<b=
>ERROR: QA Issue: File /etc/selinux/targeted/contexts/files/file_contexts.h=
omedirs in package refpolicy-targeted contains reference to TMPDIR [buildpa=
ths]</b>&quot;.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is a false positive and needs to be fixed someh=
ow. I have work around which is to skip the &#8220;<span style=3D"backgroun=
d:yellow;mso-highlight:yellow">do_package_qa</span>&#8221; stage with the c=
hange &#8220;<b>do_package_qa[noexec] =3D &quot;1&quot;
</b><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">The content of &#8220;file_contexts.homedirs&#8221; =
will as follows which is as expected.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><i><u>File_contexts.homedirs content:<o:p></o:p><=
/u></i></b></p>
<p class=3D"MsoNormal">/home/[^/]+/\.pki(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; user_u:object_r:user_cert_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/tmp/gconfd-[^/]+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -d&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; user_u:object_r:user_tmp_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/tmp/gconfd-[^/]+/.*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:=
object_r:gconf_tmp_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.dbus(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:objec=
t_r:session_dbusd_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.java(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:objec=
t_r:java_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.kube(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:objec=
t_r:kubernetes_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.wine(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:objec=
t_r:wine_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/Music(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; user_u:object_r:xdg_music_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/run/sudo/ts/[^/]+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:pam_runtime_t:=
s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.xauth.*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:objec=
t_r:xauth_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.gconf(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:g=
conf_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.gnome(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:g=
nome_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.gnupg(/.+)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:g=
pg_secret_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.irssi(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:i=
rc_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.adobe(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:m=
ozilla_plugin_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.gnash(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:m=
ozilla_plugin_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.pulse(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:p=
ulseaudio_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.pyzor(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:p=
yzor_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.razor(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:r=
azor_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.spamd(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:s=
pamd_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/vmware(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:objec=
t_r:vmware_file_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.cache(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:x=
dg_cache_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.local(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:x=
dg_data_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/Videos(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:objec=
t_r:xdg_videos_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.fonts(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:u=
ser_fonts_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.docker(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:contai=
ner_conf_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.gconfd(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:gconf_=
home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.gnome2(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:gnome_=
home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/irclogs(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:i=
rc_log_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.kismet(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:kismet=
_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.galeon(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:mozill=
a_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal">/home/[^/]+/\.spicec(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_u:object_r:mozill=
a_plugin_home_t:s0<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sasi Kumar Maddineni,<o:p></o:p></p>
<p class=3D"MsoNormal">Qualcomm Innovation Center.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatur=
es:none"> Sasi Kumar Maddineni (QUIC)
<br>
<b>Sent:</b> Tuesday, October 14, 2025 7:31 PM<br>
<b>To:</b> Sasi Kumar Maddineni (QUIC) &lt;quic_sasikuma@quicinc.com&gt;; '=
Yi Zhao' &lt;yi.zhao@windriver.com&gt;; 'yocto-patches@lists.yoctoproject.o=
rg' &lt;yocto-patches@lists.yoctoproject.org&gt;; Ravi Kumar Siddojigari (Q=
UIC) &lt;quic_rsiddoji@quicinc.com&gt;<br>
<b>Subject:</b> RE: meta-selinux][PATCH - Do not look HLL files when POLICY=
_MONOLITHIC=3Dy is configured<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi <a id=3D"OWAAM7A261387817A42238D5AD9DA114BDD5F" h=
ref=3D"mailto:yi.zhao@windriver.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@'Yi Zhao'</span></a>,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">A minor corrections were did in 2<sup>nd</sup> and 3=
<sup>rd</sup> patches and re-sharing the patches. Apologies for the inconve=
nience.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please review and provide your comments at the earli=
est as possible.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sasi Kumar Maddineni,<o:p></o:p></p>
<p class=3D"MsoNormal">Qualcomm Innovation Center.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatur=
es:none"> Sasi Kumar Maddineni (QUIC)
<br>
<b>Sent:</b> Tuesday, October 14, 2025 2:22 PM<br>
<b>To:</b> 'Yi Zhao' &lt;<a href=3D"mailto:yi.zhao@windriver.com">yi.zhao@w=
indriver.com</a>&gt;; Sasi Kumar Maddineni (QUIC) &lt;<a href=3D"mailto:qui=
c_sasikuma@quicinc.com">quic_sasikuma@quicinc.com</a>&gt;; 'yocto-patches@l=
ists.yoctoproject.org' &lt;<a href=3D"mailto:yocto-patches@lists.yoctoproje=
ct.org">yocto-patches@lists.yoctoproject.org</a>&gt;<br>
<b>Subject:</b> RE: meta-selinux][PATCH - Do not look HLL files when POLICY=
_MONOLITHIC=3Dy is configured<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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
<b>To:</b> 'Yi Zhao' &lt;<a href=3D"mailto:yi.zhao@windriver.com">yi.zhao@w=
indriver.com</a>&gt;; Sasi Kumar Maddineni (QUIC) &lt;<a href=3D"mailto:qui=
c_sasikuma@quicinc.com">quic_sasikuma@quicinc.com</a>&gt;;
<a href=3D"mailto:yocto-patches@lists.yoctoproject.org">yocto-patches@lists=
.yoctoproject.org</a><br>
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

--_000_BL3PR02MB8986181C0A920AE4066F9950E8E8ABL3PR02MB8986namp_--

