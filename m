Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3B6C87FCA
	for <webhook@archiver.kernel.org>; Fri, 25 Jul 2025 12:29:45 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.18293.1753446583454151622
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Jul 2025 05:29:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=9301d14655=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56PCT8dW3372623;
	Fri, 25 Jul 2025 12:29:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4849y1r01e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 12:29:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV8R++e/+hyUMaJ1Vaa9UdjdQooQ3cVwcJLGykIgBHsT9Ur2VefknzGQkNwFZf0VhsUEL1V0TtAsNMdeNb/0boN8xCSqUhdoPUjGvHFl1zGRORyqJ7WAVeMLOwGmfD/VJw6HvbdfcaXdSnogG6DJ+oo7T/sv3vJVNc3z8DUCJ7WsKbyaC+7gQi7qtwOgGirqmP5Ako3OJE11bFxL8UXtJSzPd3maHbjWSa46qKnMMeH7qmksXjPk32KoThyP6C9Ganf5uhf9HCJYXNNK/SgNoyTawxE05YqEP5C8PfEkWg/BTYnaRP/cpk0IV4eQbsO4+Uf2K59HhnDc583GPDrwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFXGRJ+nHVlPqSs4IqzueRqES3oqvfFsegS+Sg5yT54=;
 b=Ny+0f6+on2MuntwoCjLlW72vnjCBXaO3wYSnOy6k/Rlygvx3nSfO6lBdUJwjAY04QLwhQkKNM75acC77TUcFn+Thh3tzvUgZrZZQPMsXLElaQsousc2suDRhqQoUDUeWOPnA0l7wLYBSsdgLC8gcxPSeMRfg4U39fMVsoK5n/r5y3nOGDdesspfBNsxcjtZsh/MM34vIUByOzN5ESrZQJat3I4/tGrd4kNsWjxq6d3Yp60CBYYzkARULbzcEBJmUyOjzkQT2TfXkB7HuBUaXoxMueVw8EnpTfhRlre4tW3LtZnL+EsIwJqyiHUiswu9fWT7k3iRBcZ5cEBT4T9vphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15)
 by PH8PR11MB6755.namprd11.prod.outlook.com (2603:10b6:510:1ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:29:38 +0000
Received: from CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a]) by CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a%5]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 12:29:38 +0000
From: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
To: Scott Murray <scott.murray@konsulko.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        "MacLeod, Randy"
	<Randy.MacLeod@windriver.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/2]
 python3-awscrt: fix unsafe include path error during cross-compilation
Thread-Topic: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/2]
 python3-awscrt: fix unsafe include path error during cross-compilation
Thread-Index: AQHb/AakehC6R0bk1ECJn4fNmov/O7RCx1J5
Date: Fri, 25 Jul 2025 12:29:38 +0000
Message-ID: 
 <CY8PR11MB79213B6FDAFEC4365BCB9EA08159A@CY8PR11MB7921.namprd11.prod.outlook.com>
References: <20250618132937.4119240-1-soumya.sambu@windriver.com>
 <0474554e-aa75-a6bc-244c-931a4ffa8b61@konsulko.com>
In-Reply-To: <0474554e-aa75-a6bc-244c-931a4ffa8b61@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-07-25T12:28:36.337Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7921:EE_|PH8PR11MB6755:EE_
x-ms-office365-filtering-correlation-id: 85c8a297-f6eb-4e84-69c6-08ddcb76ec11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|13003099007|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?U8bJ4E+fhS7K0d9ViPXumeiSYBG+bwra0D7yNSlA4paC0ceceLQZTEY6?=
 =?Windows-1252?Q?OvYQIcQvNc5iycwyWcxFgJoqk705i9g89BZE8mZ6q0/5MZmKrPmS2qHJ?=
 =?Windows-1252?Q?xhYniQlgks4xqvpEQABewB26cFa2Vu1V/KmhY77vsBJC/2pbx0n9DYXR?=
 =?Windows-1252?Q?4uiKZq67vc6GX4p0fHQo7oYREfhRJpBj0BxNqyBuQzmWilWUBgc4v6jm?=
 =?Windows-1252?Q?Rkhcy9gZ1c4X8TdfWT0ovVckv/faBdsNVbUQAaosz4wm809spBaKoOqy?=
 =?Windows-1252?Q?LK99urIsVDOEq0+UlzMg6vckBGTlgn7dK1K+IRDf6S8jC3+bZRnoqc/P?=
 =?Windows-1252?Q?7HZzqGs1HwRZRTGVThvypEmUD4zYUUJdH6VWPxPju2LZMxLL3bBhcHrC?=
 =?Windows-1252?Q?9qP6qJO2RIZIk09f23pyumhTkCm1Ywq6MWD0YriP91oGfnOfZf+4zkoy?=
 =?Windows-1252?Q?+ALyJUURCYfbE9PBaJ5wALYzc4HbO1gsbR2TdzWFVrc7RJSKJJ92GFb0?=
 =?Windows-1252?Q?9+9QYnh49Jm/rfmiq3DO7+kHWyB6q3geEOqFpCr+65kVjTrPTIcbazcP?=
 =?Windows-1252?Q?mERpekQ6LMzN1ETRCTyxVTVzM29AOkGDzrgcYbJ34dNQ6O0njpF9Vp2e?=
 =?Windows-1252?Q?6tlGyTW9qiW+G+eCFWyxlx6a+b7BojW3iYCEZuZncHQbY9YZHDye6aUG?=
 =?Windows-1252?Q?VPp0jUA/V41H4vhbeo2sOnhEpTYtuce3gh1hHGtdlRVuW3CtMa7yCaD1?=
 =?Windows-1252?Q?tvULubYQ7phRhWFmupB0NxqT3PFuU3yB3Is464Izin6Z8LBLhs7ZFuuH?=
 =?Windows-1252?Q?rvGibCVtOG1lWfZzCWrGExZ1FFwrjoBwFa7xHo6xxH7pM2Nz0G1QYTgu?=
 =?Windows-1252?Q?e6QoQt8k4yq9p7cIhmqx0R1p36eHVxVf5J78apO0HqoYbrJ/fQvZ/zb/?=
 =?Windows-1252?Q?YZgvlrtDSuM9xNNWKax/S7BIAsUVjPpvFH0b/dEUJlGmVtl0n99CA+WG?=
 =?Windows-1252?Q?mHCDAZ0BVecZ1SszgMX6a43BujLY58c6hOP2FtFjEOu6b8Zzd91XDMm+?=
 =?Windows-1252?Q?wLivOuiAPSqIBDg7MiB3K8issDxwqad5OF/1ej8cMk2ECukwjmitMryw?=
 =?Windows-1252?Q?4Mn3JicUhNPejdlGuioV5j6l3DJg65Ne3m0n3c9HF3vyxo8GaYjIc0MW?=
 =?Windows-1252?Q?IaOxmenk46Nw8n4PQcbH/9Gu3JKvTz7QdGwaTxxV5zv9fIK3MHyLZjwg?=
 =?Windows-1252?Q?rDkRTJryhK/ptkB5gGfWY356pgbRnDXU7nZI8YrcYtr+cl5XmW15gxw3?=
 =?Windows-1252?Q?KwJNUMCJrutZ1A9/YqWc/XeeND5bCmU/KjzrbUJJe49daVzznfsq1Jzw?=
 =?Windows-1252?Q?AYbbQIQDvY2vjU/xdLTdV2jkECp0JfjyfHQzgl5iEzKhalYaw1n/XMB7?=
 =?Windows-1252?Q?ypDvBZHL+xeSvVF85B1VnrXVHLF4Ch9gh+hqy4j5mHChRzOBFZrOlRX0?=
 =?Windows-1252?Q?8GeljYm8jVEbgnxDUybnLE4+o6MeecYiu6uXPzddC4u43OegNAlvtGIZ?=
 =?Windows-1252?Q?+Tt7qHgpMrgeGByw+F/bYhRrPHDF77yXVpAAl3/BUeydmt35vttQzCdy?=
 =?Windows-1252?Q?KEg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7921.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?wyHgWDULwf5JPAvlMRd13fbn0iLmVWMacy9SEdQuLMeiZN/CSikyLR40?=
 =?Windows-1252?Q?GI9b5ZhBwn6Xo6ad0wfPOCxuT6PnNOzMSk3nCbjyShAv+4eZGGyHkZhT?=
 =?Windows-1252?Q?+XlM94Pe6AAImb38vu1p4W2xYa7OUtfN0H4E3H2UPYPAW05vMJcSHuCa?=
 =?Windows-1252?Q?Jx8P5WWIqhLWigwtLVEuLZKPjC7pRrj2zAZ68Haq0B833IGDzdHwfge6?=
 =?Windows-1252?Q?24N8zlHbwZ1bsU9iL349M7ne+FCnmShjlUO79j7r6f9qOCRglrvch9im?=
 =?Windows-1252?Q?1DwYmS/WvAh1kJOiQJJIJGzFHxXrjx2kKSoH9svN4cOSEkxEHiHzK9qD?=
 =?Windows-1252?Q?Jlx1UjoVz9W4sdCmj/bqsvGbCZlWWbKzeBwuFWoQR9K7h1EanDJGfeMZ?=
 =?Windows-1252?Q?8ksWisJXt3Pn8Pw1iJ+pUhF5jqrcF0RlWeboHe6HIi9cRM8AFYakYfOs?=
 =?Windows-1252?Q?EhGbGplQNmAoH8vzA9e2I5jpPnT1+rz0aivFbEC8YHmnoGmc5mdmqt7L?=
 =?Windows-1252?Q?HAMJWMarqAGyH0CQfId0a4aOfT07GkTfLHicrFTheZtuZTeBt+3Cr2Us?=
 =?Windows-1252?Q?tWvvTzC3WhvvzvCxZhaPZ6DfOGYfjPvnmnOxj8pXDf6Z/bhTlbjLas2B?=
 =?Windows-1252?Q?8HXuf2Uubf5zldBTIth4e+y0CpAChEndl3s7JRmc5toC5UuCXopFnz6n?=
 =?Windows-1252?Q?sqtFmbItSsas5O3YgirCmM1hJxlQZVzozp00YSQ5WqX6VIOXHdPHhLh2?=
 =?Windows-1252?Q?QyXR+s5qDldJbk1b+VfUieWO3PEvPjAEWHuOEy2rS+FhPv/GX4fauKCO?=
 =?Windows-1252?Q?RLuAQnOGsDSq9SkSt5iG9I8pDgwfxW/9krS3kgwylpiQDH5ZtofMr8gf?=
 =?Windows-1252?Q?rXOmya502cHZKFgMggOJGTFPNBSbFVumRoFSGBrWjzJjmIOmvg8lHue8?=
 =?Windows-1252?Q?sZPjaJSRGAJGRRvmOaFm5zibI93qMD9pyuir83hKgki2v0wqejOFCCk8?=
 =?Windows-1252?Q?4Ux2fNhy7VMr7toZU2+c3GTeOFzyzGO/EWhI5Hrybrwes15gxX5UN0OM?=
 =?Windows-1252?Q?n0kf2GXxRcGzzVKdvIVCOPJk5EmyDPhO4ypvkq97UkC9X6Ps3278SxqQ?=
 =?Windows-1252?Q?kj9ySx2XhwPZr2XjXLAol3e3qAaWiebCmVVnDqzfRwtWH2EhFszjJEd1?=
 =?Windows-1252?Q?v+rh3yp1xni41dHI4ORLA434+rVxTPW8d3hNbDUpCdxUnRIg4TCjS+4s?=
 =?Windows-1252?Q?u2XL3bAIZm9ko5Bx89ae+wPOlZmPbNgwy1WFbDPLYbOw5bIm4lq4qB7X?=
 =?Windows-1252?Q?7lUhechT2dbaktCz75GUhsJtDvUzqZvmYesk+IWMk0owGFSjtqQoGBmA?=
 =?Windows-1252?Q?UHMGgf0uJEzGrQ3kyOAEWhaR5FVytyReIobputiibpeLm+c04tpMDO5M?=
 =?Windows-1252?Q?MYf6hHY42hSg5vGvHg2aRTtFEpyjs3ERPbf35NWiUXV57R8CeaMmlhso?=
 =?Windows-1252?Q?D/+0qJEB6U7cgd/CjShWES8LJP1HftQlBo3pcTyY/tx7Tqrw7otFnmoy?=
 =?Windows-1252?Q?Z08rTzvXQSRAEF2aFI/u168qXIq4Hyd15nEU79os+ApqRK+hskfOUoMo?=
 =?Windows-1252?Q?D9F2WUnlZ+sxp10ntox6lih+Xrhkh1TlPcuUPVfQn9YA6esytwo3QQ7a?=
 =?Windows-1252?Q?ixc5euJf+RyISMJtkBlCPSy/5KhU9d7p?=
Content-Type: multipart/alternative;
	boundary="_000_CY8PR11MB79213B6FDAFEC4365BCB9EA08159ACY8PR11MB7921namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c8a297-f6eb-4e84-69c6-08ddcb76ec11
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 12:29:38.3577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69yriDCAdtm22xNWzkvtEWcoJYjXz4IvFpmcXyPnFKWtkkgW5xzy9pKJFA8LtBTztXDDfQBYAiabl8cyY1amZkNW7TLqzZtbpaevF6vKkh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6755
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEwNiBTYWx0ZWRfX0ALx79L4piKn
 u2LGC0lOrSPY4qqiTr93fFXZcNd7WZ/ltcjZdsM20aI360Uf/BoNbdGvLx4u0MTa9w82bd4WX78
 tu13gOG7w2pWLhKIm4wdrtbTuLr4Fkzm4bpvuk+BzoVxvPGwlRbj57rkuVwOcFhMhLfb0XQwHCX
 hFOlm46bgw/DYqVCRsGZjfER2ZT4QkWMMKUTL2dkrZ8MESj6I7ZEUSk9+LlUlDy9KGEA8LXRp42
 BdFD+X6YW6X8s/zPIW3bfkUpmRkbO6+oj+nkTtm4G0Be93omUBKVJr86qzq0AFT2WdcTgQZqOv3
 P9bD0WkH7CWYS8OTZ7iVECqFRrrJ60jz6oJgnWRfEi/JL70651yct4BuHwPlYt6Oxhd+SKrtu5s
 GH/G39EP
X-Proofpoint-ORIG-GUID: gxxzpo8w1YvyEd51LqGUPARenlAH-Otk
X-Authority-Analysis: v=2.4 cv=IJsCChvG c=1 sm=1 tr=0 ts=688378b5 cx=c_pps
 a=pfCY2Ats7XXgTBCGz+4jpg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=k-42gJp3AAAA:8
 a=t7CeM3EgAAAA:8 a=iGHA9ds3AAAA:8 a=UBFVfQAFWYhimOpKR3UA:9 a=pILNOxqGKmIA:10
 a=CVtr6vgN2qOkzd3N:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=uCSXFHLys93vLW5PjgO_:22 a=FdTzh2GWekK77mhwV6Dw:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: gxxzpo8w1YvyEd51LqGUPARenlAH-Otk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1011 phishscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507210000 definitions=main-2507250106
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Jul 2025 12:29:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1871

--_000_CY8PR11MB79213B6FDAFEC4365BCB9EA08159ACY8PR11MB7921namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Thanks for the update =97 and apologies for missing your earlier message; I=
 was occupied with other tasks.
Regarding the previous question, I suspect "restoring local distutils as de=
fault" caused the issue - https://github.com/pypa/setuptools/commit/b6fcbbd=
00cb6d5607c9272dec452a50457bdb292

I attempted to rebuild python3-grpcio, python3-awscrt, and python3-strict-r=
fc3339 using the following setup:

Layers:
poky: kirkstone [f4219fb3e291eaffbb475b91ad4a8c4772a9c7d3]
meta-openembedded: kirkstone [06fc0278f10d630838d703dde707bbf0e2999873]
meta-lts-mixins: kirkstone/rust [dcc60f3115a8133c4013ce36cb6fe0969c07d6f5]
meta-iot-cloud: kirkstone [e381dc2067c1500eb417bc1ce3009b3ff4125c69]

Host details:
OS: Ubuntu 22.04.2 LTS
Kernel: 5.15.0-122-generic

I'm still seeing the same build failures with python3-grpcio, python3-awscr=
t, and python3-strict-rfc3339 with above setup.

Let me know if any more details are needed.

I will also look into the mozjs comments and provide an update shortly.

Best regards,
Soumya

________________________________
From: Scott Murray <scott.murray@konsulko.com>
Sent: Thursday, July 24, 2025 12:48 AM
To: Sambu, Soumya <Soumya.Sambu@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>; MacLeod, Randy <Randy.MacLeod@windriver.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/2] p=
ython3-awscrt: fix unsafe include path error during cross-compilation

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

On Wed, 18 Jun 2025, Soumya via lists.yoctoproject.org wrote:

> From: Soumya Sambu <soumya.sambu@windriver.com>
>
> After meta-lts-mixins introduced a newer setuptools, python3-awscrt is fa=
iling
> to build due to unsafe include path
>
> cc1: error: include location "/usr/include/python3.10" is unsafe for cros=
s-compilation [-Werror=3Dpoison-system-directories]
>
> The issue is resolved by explicitly forcing setuptools to use distutils
>
> Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>

I tested building python3-awscrt and python-grpcio without these fixes,
and they built fine for me (iirc, even with Rust 1.85.1, but definitely
with the 1.86/1.87 updates I just posted).  Can you perhaps try to
reproduce the failures with them and python3-strict-rfc3339 again to see
if they still happen for you, and if so please provide specific setup
information for reproduction (i.e. build host and specific layers and
commits used)?  Also, please see my comments about the mozjs-* dynamic
layer bbappends in my kirkstone/rust update cover letter, they are
issues there that need investigation.

Thanks,

Scott


> ---
>  conf/layer.conf                                                | 3 ++-
>  .../iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend     | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>  create mode 100644 dynamic-layers/iot-cloud/recipes-aws/python/python3-a=
wscrt_%.bbappend
>
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 4fe4ec4..280393d 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -28,7 +28,8 @@ BBMASK:append =3D " meta/recipes-devtools/python/python=
3-setuptools-rust-native_%"
>
>  BBFILES_DYNAMIC +=3D " \
>      meta-python:${LAYERDIR}/dynamic-layers/meta-python/recipes-*/*/*.bba=
ppend \
> -    openembedded-layer:${LAYERDIR}/dynamic-layers/openembedded-layer/rec=
ipes-*/*/*.bbappend"
> +    openembedded-layer:${LAYERDIR}/dynamic-layers/openembedded-layer/rec=
ipes-*/*/*.bbappend \
> +    iot-cloud:${LAYERDIR}/dynamic-layers/iot-cloud/recipes-*/*/*.bbappen=
d"
>
>  # These are in bitbake.conf in langdale and up, adding them here to make
>  # using the layer more turn-key seems reasonable.
> diff --git a/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%=
.bbappend b/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%.bb=
append
> new file mode 100644
> index 0000000..bd0b910
> --- /dev/null
> +++ b/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%.bbappe=
nd
> @@ -0,0 +1,3 @@
> +do_compile:prepend() {
> +    export SETUPTOOLS_USE_DISTUTILS=3Dstdlib
> +}
>

--_000_CY8PR11MB79213B6FDAFEC4365BCB9EA08159ACY8PR11MB7921namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks for the update =97 and apologies for missing your earlier message; I=
 was occupied with other tasks.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regarding the previous question, I suspect &quot;restoring local distutils =
as default&quot; caused the issue -
<a class=3D"OWAAutoLink" id=3D"OWA7d09db76-8862-cfb1-01a9-490b0388d3d7" hre=
f=3D"https://github.com/pypa/setuptools/commit/b6fcbbd00cb6d5607c9272dec452=
a50457bdb292">
https://github.com/pypa/setuptools/commit/b6fcbbd00cb6d5607c9272dec452a5045=
7bdb292</a></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I attempted to rebuild python3-grpcio, python3-awscrt, and python3-strict-r=
fc3339&nbsp;using the following setup:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Layers:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
poky:&nbsp;kirkstone [f4219fb3e291eaffbb475b91ad4a8c4772a9c7d3]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
meta-openembedded:&nbsp;kirkstone [06fc0278f10d630838d703dde707bbf0e2999873=
]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
meta-lts-mixins:&nbsp;kirkstone/rust [dcc60f3115a8133c4013ce36cb6fe0969c07d=
6f5]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
meta-iot-cloud:&nbsp;kirkstone [e381dc2067c1500eb417bc1ce3009b3ff4125c69]</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Host details:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
OS:&nbsp;Ubuntu 22.04.2 LTS</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Kernel:&nbsp;5.15.0-122-generic</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I'm still seeing the same build failures with python3-grpcio, python3-awscr=
t, and python3-strict-rfc3339 with above setup.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Let me know if any more details are needed.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I will also look into the mozjs comments and provide an update shortly.</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Best regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Soumya</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Scott Murray &lt;scot=
t.murray@konsulko.com&gt;<br>
<b>Sent:</b> Thursday, July 24, 2025 12:48 AM<br>
<b>To:</b> Sambu, Soumya &lt;Soumya.Sambu@windriver.com&gt;<br>
<b>Cc:</b> yocto-patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoc=
toproject.org&gt;; MacLeod, Randy &lt;Randy.MacLeod@windriver.com&gt;<br>
<b>Subject:</b> Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH=
 1/2] python3-awscrt: fix unsafe include path error during cross-compilatio=
n</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">CAUTION: This email comes from a non Wind River em=
ail account!<br>
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.<br>
<br>
On Wed, 18 Jun 2025, Soumya via lists.yoctoproject.org wrote:<br>
<br>
&gt; From: Soumya Sambu &lt;soumya.sambu@windriver.com&gt;<br>
&gt;<br>
&gt; After meta-lts-mixins introduced a newer setuptools, python3-awscrt is=
 failing<br>
&gt; to build due to unsafe include path<br>
&gt;<br>
&gt; cc1: error: include location &quot;/usr/include/python3.10&quot; is un=
safe for cross-compilation [-Werror=3Dpoison-system-directories]<br>
&gt;<br>
&gt; The issue is resolved by explicitly forcing setuptools to use distutil=
s<br>
&gt;<br>
&gt; Signed-off-by: Soumya Sambu &lt;soumya.sambu@windriver.com&gt;<br>
<br>
I tested building python3-awscrt and python-grpcio without these fixes,<br>
and they built fine for me (iirc, even with Rust 1.85.1, but definitely<br>
with the 1.86/1.87 updates I just posted).&nbsp; Can you perhaps try to<br>
reproduce the failures with them and python3-strict-rfc3339 again to see<br=
>
if they still happen for you, and if so please provide specific setup<br>
information for reproduction (i.e. build host and specific layers and<br>
commits used)?&nbsp; Also, please see my comments about the mozjs-* dynamic=
<br>
layer bbappends in my kirkstone/rust update cover letter, they are<br>
issues there that need investigation.<br>
<br>
Thanks,<br>
<br>
Scott<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp; conf/layer.conf&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; | 3 ++-<br>
&gt;&nbsp; .../iot-cloud/recipes-aws/python/python3-awscrt_%.bbappend&nbsp;=
&nbsp;&nbsp;&nbsp; | 3 +++<br>
&gt;&nbsp; 2 files changed, 5 insertions(+), 1 deletion(-)<br>
&gt;&nbsp; create mode 100644 dynamic-layers/iot-cloud/recipes-aws/python/p=
ython3-awscrt_%.bbappend<br>
&gt;<br>
&gt; diff --git a/conf/layer.conf b/conf/layer.conf<br>
&gt; index 4fe4ec4..280393d 100644<br>
&gt; --- a/conf/layer.conf<br>
&gt; +++ b/conf/layer.conf<br>
&gt; @@ -28,7 +28,8 @@ BBMASK:append =3D &quot; meta/recipes-devtools/pytho=
n/python3-setuptools-rust-native_%&quot;<br>
&gt;<br>
&gt;&nbsp; BBFILES_DYNAMIC +=3D &quot; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; meta-python:${LAYERDIR}/dynamic-layers/m=
eta-python/recipes-*/*/*.bbappend \<br>
&gt; -&nbsp;&nbsp;&nbsp; openembedded-layer:${LAYERDIR}/dynamic-layers/open=
embedded-layer/recipes-*/*/*.bbappend&quot;<br>
&gt; +&nbsp;&nbsp;&nbsp; openembedded-layer:${LAYERDIR}/dynamic-layers/open=
embedded-layer/recipes-*/*/*.bbappend \<br>
&gt; +&nbsp;&nbsp;&nbsp; iot-cloud:${LAYERDIR}/dynamic-layers/iot-cloud/rec=
ipes-*/*/*.bbappend&quot;<br>
&gt;<br>
&gt;&nbsp; # These are in bitbake.conf in langdale and up, adding them here=
 to make<br>
&gt;&nbsp; # using the layer more turn-key seems reasonable.<br>
&gt; diff --git a/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscr=
t_%.bbappend b/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%=
.bbappend<br>
&gt; new file mode 100644<br>
&gt; index 0000000..bd0b910<br>
&gt; --- /dev/null<br>
&gt; +++ b/dynamic-layers/iot-cloud/recipes-aws/python/python3-awscrt_%.bba=
ppend<br>
&gt; @@ -0,0 +1,3 @@<br>
&gt; +do_compile:prepend() {<br>
&gt; +&nbsp;&nbsp;&nbsp; export SETUPTOOLS_USE_DISTUTILS=3Dstdlib<br>
&gt; +}<br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY8PR11MB79213B6FDAFEC4365BCB9EA08159ACY8PR11MB7921namp_--

