Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83297CCD184
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 14:01:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.web10.17179.1760450484889965816
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Oct 2025 07:01:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=C/0SCUN4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: quicinc.com, ip: 205.220.180.131, mailfrom: quic_sasikuma@quicinc.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87IoK001480;
	Tue, 14 Oct 2025 14:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Db63Ol7f7DV8FPG9XN93vFMM
	CUJocvgS9pg/6q0KwlI=; b=C/0SCUN4O9Yr7TEfdH5ryXs2KGoFqoDYN0OyXDFD
	HKxqXY9DKEcBdJYuFMIyoStaXkW8B1nFQ1lNTcqRHMgZ5UwzjWlNYQZHc9L8Rcg1
	b4V8dO4IMT2XeA+FCfFPScLlvXPWqH/oO72Gy266hi3yCDg+SUrRAsPYiFxIzqgU
	3yJTNA6VdxqRsszZpcqQW0hwAuLbY8pgkOmkA1aY90G0xpLnoYqO33FJ1jiV2NaU
	zXBtU3ztZykoeMTm4Nnzf0xdAsAdiSOvKCNk5Qm6QDelYnIltF4BLs4rHbZkvpwx
	NwGHNEFKJvEZXEA2xdBpFHRazmwEjSs39CjqDkunyY5VMQ==
Received: from ds2pr08cu001.outbound.protection.outlook.com (mail-ds2pr08cu00105.outbound.protection.outlook.com [40.93.13.53])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa88r79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:01:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGcqEb2sYaz6u37A3B2D2eqlKp0ifIiB0XpY/TblHX/1xdeZmH7uEgID5EvTc54Sb3cGcfoL7JITFWbB/0p51VdGZmKynLp0oH43r5IvNMIthxE89gmzsOQxwljaCH2OjdYaZK5XKydVu5xEmGAI0iS30tExRx2DOWuexHcQZrnChWk/A5m4Uyy2UBEqvWEJq4Vx4z3idKZ8kdg+QiRl5FYD+Znl9FMtxO2fjcbnK0PNqTu6V+1/Y70KDlTMZwdPJ3wJalrxVeWs3Dn+WEE0Lst0lcvzkzBSgpXU0Bl1cSjJrQPITfPtQsyFAfci+ZRSXW2kkG/3yuFs5p1mtL52pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Db63Ol7f7DV8FPG9XN93vFMMCUJocvgS9pg/6q0KwlI=;
 b=ZFcjVNqywjzNUZOg5zGRosivPcUZGZ7HXyrbTBvS2OD/eLgaFxrd/eH18Wq8KcV5Cu0PJgxyB0CIJOzKMK5+6uwyNtSMZ4fg/F75UW8QKCoqcDaqV1cJB1unyyT/inm25gUrbylUOx/YcwhzoBzrexOhPAVmElqXWt/C5Re947RVMwR4RX+SKsu0XAUCpHl0E69iUbPubNJ4pPEcWyLp+MPLOQX+V8MfgIfzKBj8B2XXrXDUsRCQmtOqnCgj/IpfDUBUqHNL1u1n9ogyoBSj1diUIwIlcCD5i+7C+iEjwb1xEWiPWhdgvka3d9jzsfYXpEsPoveNBeYuurOZs/ZFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL3PR02MB8986.namprd02.prod.outlook.com (2603:10b6:208:3b6::10)
 by LV3PR02MB10303.namprd02.prod.outlook.com (2603:10b6:408:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 14:01:17 +0000
Received: from BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35]) by BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:01:16 +0000
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
Thread-Index: Adw8L9X3DxEoxiLUTsiBneUmKF6KlQAtOdMAAAAIIRAAAGfAsAALB2tA
Date: Tue, 14 Oct 2025 14:01:16 +0000
Message-ID: 
 <BL3PR02MB8986CD337ABA02BE9D5C7265E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
References: 
 <BL3PR02MB89865DB6BD360CBD532D749AE8EAA@BL3PR02MB8986.namprd02.prod.outlook.com>
 <a5ad7b6e-3a31-4fa5-83f8-918744c6c32e@windriver.com>
 <BL3PR02MB89860445FD4D9D47B7135FB6E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
 <BL3PR02MB898682DC436D91B19BA8D1D7E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
In-Reply-To: 
 <BL3PR02MB898682DC436D91B19BA8D1D7E8EBA@BL3PR02MB8986.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: yi.zhao@windriver.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB8986:EE_|LV3PR02MB10303:EE_
x-ms-office365-filtering-correlation-id: b4b25bb3-b449-474e-b320-08de0b2a24a9
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|7053199007|4013099003|4053099003|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?cDgXB/uWzEw0q7z7wzZVYeJJjlRjxmg0c2zkF036G03R5gmrvvm3XHB3irLG?=
 =?us-ascii?Q?vEBdP3+Nv7yYFOCfDySSRBgeDC68dtT7yODrxZr8Zy3p5PUifUMrJ3Tz9dUK?=
 =?us-ascii?Q?O7yTECD+7hS4E8r57K0czb29d32CWHyefUajPnikCQWu892jNbe/fL5WINst?=
 =?us-ascii?Q?cAxPfp52MCaGnEEN0hfIZ8cOeLcxd5zxF3PW5Ek3ofUpLg9CqCe2usdbFv9D?=
 =?us-ascii?Q?jGOs8Dn61kIvY7QEQiwXNKjFuZlrYpBn6co+zF+MUzZUpMmWSncyaZumZ9P/?=
 =?us-ascii?Q?0IVh14EZZl9q/gWkvz9rdjP3de4+LvwebSfgmarPX3vCiLs0wmV2znlBP5uN?=
 =?us-ascii?Q?fPq2yg8DtsJmO/cNnRNK3b81vwvF6Mk52okf/zIQFT0sV8eRdVQ2+06ljotA?=
 =?us-ascii?Q?cDd8HyTtxeO9+EQKyrw20pBUJOmfHZX9SS9lt2Ap7MbuoEe+DI0gQoW1hHLr?=
 =?us-ascii?Q?QPS1FNLig6RlJmyPUbu1zCiQ8lm7/0U4KA72RMc3PVzB89zGS/yMdl439eb2?=
 =?us-ascii?Q?0N9ddFNErAapVebQEA1NGw+PVC46jUFEmqb7FDGey9YQmF07vCOtSKQSBudF?=
 =?us-ascii?Q?GEQ663KaDFKhlsQMQ9mZndbYirW8+fOvfaJ7Jb+tKt7+eWg3Dy6hzFbHUNU5?=
 =?us-ascii?Q?YLH7nKd5LUnixO16zXFN+KSkOLc+TgztQM0ZrG7Zau9IdpSAUk8DUloDTzEm?=
 =?us-ascii?Q?6Grn176Xf94t7s7vzLtvG+QFBK36z+8xnDc0ZiGk70kvNpiRgY1GUfWB/Jss?=
 =?us-ascii?Q?pZgeyhv/tuujUJBwIYT2UDStid/x7j48BbLw1nZQ+sHf0e2FLcV/arH17a9y?=
 =?us-ascii?Q?vkEltVvmnXbGTrMdHlB64Ahp+u24qipygkBelW3P1cZF3ez4hggMZ05zigC3?=
 =?us-ascii?Q?QuYjaOmXUSg1gg2yQbEJ+sfsntX4SNYxTpb3HEpLEnU4Qtdhjf+ou/5FwoAj?=
 =?us-ascii?Q?2PxCg2Vjl02apRSFT7SL0FpolUrej7laiew+GgC3Hv3gm8iLqzvgTFCsSPyy?=
 =?us-ascii?Q?mqKcBDYCLWeXojPQBlr6VXFu4DKKS6YPhI/xHPDVNDgxRK87ObF4xSDniBDK?=
 =?us-ascii?Q?umtmwqqrKu9abvD91VXNDNIUZuzmjaFxT5TMKQ/AWa2wwOzDflKxtcfKzZS9?=
 =?us-ascii?Q?OdOlUuS4Lf+/+EI5+RYObdyZ3NUDAASpMP2A+FjkbT6vdc3FvYL4TG7DGZcY?=
 =?us-ascii?Q?BOPtkFh8h+G+F0C9tytbPuRn8iPuAxlr1/BxMIxox7fh5UlT8WjQr2cZz05n?=
 =?us-ascii?Q?gxZ1P9QcN4jOSjJoDRNsrSchFXBQz2RUMFqB41GEGJMhScOudeCCdQuFv07c?=
 =?us-ascii?Q?ePCQRMLwZ3Km7GtP7VJw54yZW9QG2xcCKi54DGFJiD6+m43ZvlwP6n4zXOCi?=
 =?us-ascii?Q?fNDSyN454rvXtYI/EsUU/rDekENS2EYnexxMNoB/t6iPqOXlaSKHPEw5dJ33?=
 =?us-ascii?Q?Ut8GfcwGW1wCGiEEM9QNwnVGs5MIfkjo1kdqtef/y+3Y9o55/orearvks5Rb?=
 =?us-ascii?Q?kojx4mzBF3qLPF9tFX5aZ4wB9HocEw5XHRRJ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(4013099003)(4053099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?BgdIWLbZetp6HSceHEZXMs1QwQ3e7zJ/L7BVpX9GHUQ6oOOPBQt49TZfpaqo?=
 =?us-ascii?Q?EWzF+lWDo7Vd6UnaXR1Qk10zJ5qGQhsSbYxBJDQZG4jkvP+sRYMJN/mhtDrk?=
 =?us-ascii?Q?n5Kn02HY9pSxSdC8OGEtvXwnjNTqDngDBZ2kL7mw1cB1R9uyt8O/8ucWbgtk?=
 =?us-ascii?Q?miMWfVLwMdO+m4O0ER2vEX8xXYRcsvs++M3p5ryoEwu4KigPxQw0eN2sssqV?=
 =?us-ascii?Q?7/pJA8W7t7ApB9rrnukxjC7V+WhVE3f3JmBgyJlhpYvPH3ChsQtItPS4+efa?=
 =?us-ascii?Q?mlKUs0ZVwOSVNsolmWqvF4zaZ6WJ4QiiIWk5H0eESFHatgFUZHpf5VPCL7E8?=
 =?us-ascii?Q?tXdarXcaiFBbpbM+iH/gh4Ys+mWZVaSqmT8k4qQBW+k8fTdDeWvHThP6ZqmR?=
 =?us-ascii?Q?4x6Hpiw7UpGIMgHfFiRzY8+MPvvqhTpeQUK1gLwkEUKY5J/WEq3S2fElW+8j?=
 =?us-ascii?Q?r9hovTVwu9zOEHPo8o3I490wPImwUQ4uJLAKAisN9Qb2S8RHSncC5a7+V3hy?=
 =?us-ascii?Q?96k1+I3APJV721EahnPdO/ReBPzLIMoIIqSP/olzuWqCpdF540muKSWC06Vd?=
 =?us-ascii?Q?iWkwcQsbfqGH/qT+yGb+aeIeWQP1DkD+Q0Sti95TW1UCm8pQVa1TJT7JawUS?=
 =?us-ascii?Q?1lbI+/Y3V5j4DNNdeJptvjKqNOMf6BuO5XhyzCMGAjOsnG5EJV9Q5Yhp3blW?=
 =?us-ascii?Q?LsXhxrf8xZ2NdCG44CpjW86NRhQGtQbKpgb7fRW1ehE8JmiMLzz0lC1L9CzV?=
 =?us-ascii?Q?RQsQ3jm1+prpesA7gVXs5dLfFZafptc35qiC3ndago4sxynod+qO4NLhOGOp?=
 =?us-ascii?Q?7sx87DrrYuypCQxXMZjQMAftMnC1uD/Oy18arsHxOh9pNn58Y1ezneTerirr?=
 =?us-ascii?Q?z1w+bGrWSW0Too0XOo1v2zcI5vIKzua2NLHaPZQr8YazE4IZB1Z2lSv3IOzi?=
 =?us-ascii?Q?j9ioUPDiVKsDpBf1qAeWtiidBodanRvtozcT5KXkqh2q72d+5Yj3zt2SB263?=
 =?us-ascii?Q?DCi0JbhkU7Zam5UuY3BlX32rp3aKQ81ByCRJ4VHRWZiEJMRFA9rvDsNn3p1A?=
 =?us-ascii?Q?GkQdipS4L66CIN6l+94SnBlVyY9coROmPkIzCcF4FqYqbVW+nXsp5EBLVhgU?=
 =?us-ascii?Q?atLkh8Tqs1qefFgwKDKDRO2CIEiFEVc7Rt7JuQEEzm4JT4XwCWU3/CfiK3Ox?=
 =?us-ascii?Q?9WZayO5ZxWJmF6b6vLznjcBnYAgNW/c3sA1h8H+dEbbC7DDjjG1y8g23K0UM?=
 =?us-ascii?Q?TK1YO1prFjN+R1CB4ZHjWvqKCTPJ8DEia4eYU3kxpJOuFsDLC5MLU7qS/Tb2?=
 =?us-ascii?Q?B8BZjVdhlRrY7M1s/fhQ9misdCilKd+DLRumMvjtffOa82qGQARbNvtuXgFs?=
 =?us-ascii?Q?uP1a3H4cpuDpcsM3DEznpSheivyzdXn8iplzkcEzPCufnGQ+T3IyQVC/qzGr?=
 =?us-ascii?Q?6rY0ogskr2ohmMmjCyps1wDb7Hro/tChQ8RNezaHDK+QFL5VP+zKP8jYVEIR?=
 =?us-ascii?Q?/YYtJT8xW1GeKniUckW8IhlwavAS4BO8QMq3ksGoSJOOzIKxuGivwHXBasz5?=
 =?us-ascii?Q?MpKjL0pxXMvtsnLsDe+pY9MRr+yPDldCCvJJu5el?=
Content-Type: multipart/mixed;
	boundary="_005_BL3PR02MB8986CD337ABA02BE9D5C7265E8EBABL3PR02MB8986namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gmlV5sv65vIlXSwAoqvsK4o4oVERKm4uLZ0QrZU683G+SpfjE+8RXPLEZqU/ruK9tIaQ1yWG2N163UdJ/7MH8NBickAhSbIu1sykryOWkuQGeQKt6Cwwmit+MD1ho7x8uB99NNzgjfusjZxdHU3AY0iXOHba61WFg6E//ItNAhcnsQrG1ziXtSzI1zidpkv5TcEN8dv/MDyMAIqZqlGfo+oA6R1h4YFtJS2ozdM9G/QcyY2cBSNvcKtzkbsqeg3sybD8Y8bf+0T3aI63gCL9EnHM1dbk6wK5+X9cV6/QcdNEVYAefNeHUnCtrTiw3t3JvInziUPizqT9Lu80d9g33/TEWvBIGLuH5SPH/OnXwWCxM+Xg5psZVqJ8xWp+dSn1VhB52s3K22dP0JwhjnV8nJpxpkWIpNtpFGlNTAVs3+rRgbwUhbuL0BlWF6zfTd/zG3RajlxmRWRJfuOhIkqcDkM7WTQlwhyR892ZDSll5qatmNW1T9BYeenZ2bvESkBqx3cWSr0Sz7aBDsBNVh1s7b/qdolrObEeBZ5XybXUXzOSlFsGkPfUWQuhM8De78D4JWbRWO0dBL6r5EpubH/qOweIXB9H0vSZRdnPnWnBZafCruN7ZjKd6c8VRwbvQSZr
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b25bb3-b449-474e-b320-08de0b2a24a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 14:01:16.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEVv7Xz96pn5Gpxjf1/WBccXKNBeNtRmxEeG+9lm7KMaXk+dhwR0NU0G6QXg3xz1ODOw4Lwhlmj5ckmzQhqQO23GGF6u3Q6ZQ6QfpusRT4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10303
X-Proofpoint-GUID: mFF1fh-vuDVyGG_FRTdu8oGcQzDXBa-y
X-Proofpoint-ORIG-GUID: mFF1fh-vuDVyGG_FRTdu8oGcQzDXBa-y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX3k6DjXRtyiVu
 U8imkzvlM/garwKJrcw2j8jiuAASiZT58R7eKyCn5OqYdeR87S8BYgYMBRjyunu30WVEZjpY9jP
 EeUL2LI1zSkIfJ9V2gKn4OY7MGFRgGXSUSYMsPWewsgYqebU63/Pvi7rj+j0uSURLszMU9Pzl8b
 5UDewYqVm6CUQYrKZ9KprENxiQ6Mgq2zU3Dmsf9JMo4fAexR6dsx3nyAQGya7Oc+yTUGVxJqdL0
 K8vqf/4j9zoA2jOd2cCMq2vwIgP45LDnw+XtgNp5CGKXSih1oUnter4uw+UPt4p92ztV3J0rpsE
 ljOjKtG3nDLTaridQPCocUHnkiTOqDZfwbVIySutBVd/UrYJqMlah18T7VeCg8u+tw6LbXavj9S
 1VLevzF80Jxa+nlypRsDJNMQDMiJjA==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68ee57b3 cx=c_pps
 a=WdL/Y+pz+8WMwjgej5it6w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=COk6AnOGAAAA:8 a=iGHA9ds3AAAA:8
 a=XPdvsbld2Hrphyn94GUA:9 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=qODO415F75pXo8RfmBAA:9 a=Xi7FUXwNDW2EkctY:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
 a=owfOQfebTelCMGAwzRwA:9 a=B2y7HmGcmWMA:10 a=wcK8E-EXuXw0cGcjavMA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=TjNXssC_j7lpFel5tvFf:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 14:01:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2302

--_005_BL3PR02MB8986CD337ABA02BE9D5C7265E8EBABL3PR02MB8986namp_
Content-Type: multipart/alternative;
	boundary="_000_BL3PR02MB8986CD337ABA02BE9D5C7265E8EBABL3PR02MB8986namp_"

--_000_BL3PR02MB8986CD337ABA02BE9D5C7265E8EBABL3PR02MB8986namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi @'Yi Zhao'<mailto:yi.zhao@windriver.com>,

A minor corrections were did in 2nd and 3rd patches and re-sharing the patc=
hes. Apologies for the inconvenience.

Please review and provide your comments at the earliest as possible.

Regards,
Sasi Kumar Maddineni,
Qualcomm Innovation Center.

From: Sasi Kumar Maddineni (QUIC)
Sent: Tuesday, October 14, 2025 2:22 PM
To: 'Yi Zhao' <yi.zhao@windriver.com>; Sasi Kumar Maddineni (QUIC) <quic_sa=
sikuma@quicinc.com>; 'yocto-patches@lists.yoctoproject.org' <yocto-patches@=
lists.yoctoproject.org>
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

--_000_BL3PR02MB8986CD337ABA02BE9D5C7265E8EBABL3PR02MB8986namp_
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
<b>To:</b> 'Yi Zhao' &lt;yi.zhao@windriver.com&gt;; Sasi Kumar Maddineni (Q=
UIC) &lt;quic_sasikuma@quicinc.com&gt;; 'yocto-patches@lists.yoctoproject.o=
rg' &lt;yocto-patches@lists.yoctoproject.org&gt;<br>
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

--_000_BL3PR02MB8986CD337ABA02BE9D5C7265E8EBABL3PR02MB8986namp_--

--_005_BL3PR02MB8986CD337ABA02BE9D5C7265E8EBABL3PR02MB8986namp_
Content-Type: application/octet-stream;
	name="0002-refpolicy_common-use-selinux-tools-from-recipe-sysro.patch"
Content-Description: 
 0002-refpolicy_common-use-selinux-tools-from-recipe-sysro.patch
Content-Disposition: attachment;
	filename="0002-refpolicy_common-use-selinux-tools-from-recipe-sysro.patch";
	size=1735; creation-date="Tue, 14 Oct 2025 13:51:07 GMT";
	modification-date="Tue, 14 Oct 2025 14:01:14 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyM2RkYzE5MmE1YzNkZGM3YjMyYjE3ZWExYjkwMjQxMDBhZDRhMWFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYXNpIEt1bWFyIE1hZGRpbmVuaSA8cXVpY19zYXNpa3VtYUBx
dWljaW5jLmNvbT4KRGF0ZTogVHVlLCAxNCBPY3QgMjAyNSAxOToxMjozNCArMDUzMApTdWJqZWN0
OiBbbWV0YS1zZWxpbnV4XVtQQVRDSF0gcmVmcG9saWN5X2NvbW1vbjogdXNlIHNlbGludXggdG9v
bHMgZnJvbQogcmVjaXBlLXN5c3Jvb3QgcGF0aAoKVGhlIGZvbGxvd2luZyBjb2RlIHNuaXBwZXQg
ZnJvbSByZWZwb2xpY3kgc2hvd3MgdGhhdCB0aGUgaG9zdCBtYWNoaW5lJ3MKL3NiaW4sIC91c3Iv
YmluLCAvdXNyL3NiaW4gcGF0aHMgd2VyZSBjb25maWd1cmVkIHRvIHVzZSBzZWxpbnV4IHRvb2xz
LAppbnN0ZWFkIGZyb20geW9jdG8gYnVpbGQgcmVjaXBlLXN5c3Jvb3QgcGF0aHMuCgpyZWZwb2xp
Y3kvTWFrZWZpbGU6NDc6QklORElSID89IC91c3IvYmluCnJlZnBvbGljeS9NYWtlZmlsZTo0ODpT
QklORElSID89IC91c3Ivc2JpbgpyZWZwb2xpY3kvTWFrZWZpbGU6NjM6dGNfdXNyYmluZGlyIDo9
ICQoQklORElSKQpyZWZwb2xpY3kvTWFrZWZpbGU6NjQ6dGNfdXNyc2JpbmRpciA6PSAkKFNCSU5E
SVIpCnJlZnBvbGljeS9NYWtlZmlsZTo2NTp0Y19zYmluZGlyIDo9IC9zYmluCgpGaXg6IENvbmZp
Z3VyZWQgJ3RjX3VzcnNiaW5kaXInIGFuZCAndGNfc2JpbmRpcicgd2l0aCB5b2N0byBidWlsZApy
ZWNpcGUtc3lzcm9vdCBwYXRocy4gJ3RjX3VzcmJpbmRpcicgYWxyZWFkeSBjb25maWd1cmVkIGFz
CnBlciByZWNpcGUtc3lzcm9vdCBwYXRocy4KClNpZ25lZC1vZmYtYnk6IFNhc2kgS3VtYXIgTWFk
ZGluZW5pIDxxdWljX3Nhc2lrdW1hQHF1aWNpbmMuY29tPgotLS0KIHJlY2lwZXMtc2VjdXJpdHkv
cmVmcG9saWN5L3JlZnBvbGljeV9jb21tb24uaW5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3JlY2lwZXMtc2VjdXJpdHkvcmVmcG9saWN5L3Jl
ZnBvbGljeV9jb21tb24uaW5jIGIvcmVjaXBlcy1zZWN1cml0eS9yZWZwb2xpY3kvcmVmcG9saWN5
X2NvbW1vbi5pbmMKaW5kZXggMjdhYWM0NC4uMTIzNDM3MCAxMDA2NDQKLS0tIGEvcmVjaXBlcy1z
ZWN1cml0eS9yZWZwb2xpY3kvcmVmcG9saWN5X2NvbW1vbi5pbmMKKysrIGIvcmVjaXBlcy1zZWN1
cml0eS9yZWZwb2xpY3kvcmVmcG9saWN5X2NvbW1vbi5pbmMKQEAgLTEzMCw2ICsxMzAsOCBAQCBF
WFRSQV9PRU1BS0UgPSAiTkFNRT0ke1BPTElDWV9OQU1FfSBcCiAgICAgTUxTX0NBVFM9JHtQT0xJ
Q1lfTUxTX0NBVFN9IFwKICAgICBNQ1NfQ0FUUz0ke1BPTElDWV9NQ1NfQ0FUU30iCiAKK0VYVFJB
X09FTUFLRSArPSAidGNfdXNyc2JpbmRpcj0ke1NUQUdJTkdfU0JJTkRJUl9OQVRJVkV9IgorRVhU
UkFfT0VNQUtFICs9ICJ0Y19zYmluZGlyPSR7U1RBR0lOR19ESVJfTkFUSVZFfSR7YmFzZV9zYmlu
ZGlyX25hdGl2ZX0iCiBFWFRSQV9PRU1BS0UgKz0gInRjX3VzcmJpbmRpcj0ke1NUQUdJTkdfQklO
RElSX05BVElWRX0iCiBFWFRSQV9PRU1BS0UgKz0gIk9VVFBVVF9QT0xJQ1k9YCR7U1RBR0lOR19C
SU5ESVJfTkFUSVZFfS9jaGVja3BvbGljeSAtViB8IGN1dCAtZCcgJyAtZjFgIgogRVhUUkFfT0VN
QUtFICs9ICJDQz0nJHtCVUlMRF9DQ30nIENGTEFHUz0nJHtCVUlMRF9DRkxBR1N9JyBQWVRIT049
JyR7UFlUSE9OfSciCi0tIAoyLjM0LjEKCg==

--_005_BL3PR02MB8986CD337ABA02BE9D5C7265E8EBABL3PR02MB8986namp_
Content-Type: application/octet-stream;
	name="0003-refpolicy_common-Correct-policy-version-in-semanage..patch"
Content-Description: 
 0003-refpolicy_common-Correct-policy-version-in-semanage..patch
Content-Disposition: attachment;
	filename="0003-refpolicy_common-Correct-policy-version-in-semanage..patch";
	size=1122; creation-date="Tue, 14 Oct 2025 13:57:29 GMT";
	modification-date="Tue, 14 Oct 2025 14:01:15 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0OWRkY2JhNzliMjJmNTIyMDVkYTVlMjRlMjU4YzlkZjZiYjVhZTMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYXNpIEt1bWFyIE1hZGRpbmVuaSA8cXVpY19zYXNpa3VtYUBx
dWljaW5jLmNvbT4KRGF0ZTogVHVlLCAxNCBPY3QgMjAyNSAxOToyNToyOCArMDUzMApTdWJqZWN0
OiBbbWV0YS1zZWxpbnV4XVtQQVRDSF0gcmVmcG9saWN5X2NvbW1vbjogQ29ycmVjdCBwb2xpY3kg
dmVyc2lvbiBpbgogc2VtYW5hZ2UuY29uZiBhcyBwZXIgY2hlY2twb2xpY3kKClRoZSBjb2RlICJP
VVRQVVRfUE9MSUNZPWAke1NUQUdJTkdfQklORElSX05BVElWRX0vY2hlY2twb2xpY3kgLVYgfCBj
dXQgLWQnICcgLWYxYCIKYXNzaWducyBPVVRQVVRfUE9MSUNZIHdpdGggMzUgYW5kIHBvbGljeS4z
NSBpcyBnZXR0aW5nIGdlbmVyYXRlZC4KClNvLCBjb3JyZWN0aW5nIHRoZSBwb2xpY3kgdmVyc2lv
biBpbiBzZW1hbmFnZS5jb25mIGZpbGUgdG9vLgoKU2lnbmVkLW9mZi1ieTogU2FzaSBLdW1hciBN
YWRkaW5lbmkgPHF1aWNfc2FzaWt1bWFAcXVpY2luYy5jb20+Ci0tLQogcmVjaXBlcy1zZWN1cml0
eS9yZWZwb2xpY3kvcmVmcG9saWN5X2NvbW1vbi5pbmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9yZWNpcGVzLXNlY3Vy
aXR5L3JlZnBvbGljeS9yZWZwb2xpY3lfY29tbW9uLmluYyBiL3JlY2lwZXMtc2VjdXJpdHkvcmVm
cG9saWN5L3JlZnBvbGljeV9jb21tb24uaW5jCmluZGV4IDEyMzQzNzAuLmNmMzI3MjMgMTAwNjQ0
Ci0tLSBhL3JlY2lwZXMtc2VjdXJpdHkvcmVmcG9saWN5L3JlZnBvbGljeV9jb21tb24uaW5jCisr
KyBiL3JlY2lwZXMtc2VjdXJpdHkvcmVmcG9saWN5L3JlZnBvbGljeV9jb21tb24uaW5jCkBAIC0y
MDYsNyArMjA2LDcgQEAgcGF0aCA9ICR7U1RBR0lOR19ESVJfTkFUSVZFfSR7c2JpbmRpcl9uYXRp
dmV9L3NlZmNvbnRleHRfY29tcGlsZQogYXJncyA9IFwkQAogW2VuZF0KIAotcG9saWN5LXZlcnNp
b24gPSAzMworcG9saWN5LXZlcnNpb24gPSAzNQogRU9GCiAKICAgICAjIENyZWF0ZSBwb2xpY3kg
c3RvcmUgYW5kIGJ1aWxkIHRoZSBwb2xpY3kKLS0gCjIuMzQuMQoK

--_005_BL3PR02MB8986CD337ABA02BE9D5C7265E8EBABL3PR02MB8986namp_--

