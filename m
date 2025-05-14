Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10470C3ABCC
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 15:38:31 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.105107.1747237105935259664
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 May 2025 08:38:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7229e69a19=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EClknX016650;
	Wed, 14 May 2025 15:38:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbcjs8ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 15:38:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hR5dxyaaPGfs+dungw8WPNgmSs2YrFQBOBV7Ej1DmT0BGGRnQmi5ZEtPZjjllj51rZtFLhCim/LvKursViHEN4/4q4PMbYcw2mUmxlruTKsPd8p2mF+wnJvKTSfHai3Z9Ddlq5UGe3YY+pmmH8tvthHjnjVwJgi/vC65+D/xjKmKS/iMo/rOzDacWoz7y0SepbNGQp5ORC8zLBQxEnPQUyn2jyAUPGg1Fthyv0VRD6UYSxTKXSLGL590p1+/nGNDeNH7+7IaC99NEjmV01dcf5fQWRbAwKm4tM9W7WyRkrP/7+pJKgKxROzWqRtOJTqHNbuelM4NqWAvgvzrqkOhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFBWBCoH8TrrpLEq+QbuGj5Dv7vWABl7iQI1ZXlReQg=;
 b=k91zd/z3n2Yw3gkYa/MQWRfIS9DcPosVCORfcQP61aagRdSr7DJJcHPDMUZgOU8FKJfmHcPUBXqq5GC/1Sd0Ar+4HlZZ/zBZ1HGlL7+VnUVV5X99PnA9HZG3k7H2iBZLHMNYVufjazKkQvuPA/lNSVbmogxGgpAErkX0bXvLDi1WXLnFNJWbt35L3iWb72GcraWJ83FHz+jcZrcqKBne0mNk4vlroL2z34aF86tmyw+1hCSACQaDXQN/twbC9OmV7Xxw2ew4bHy3FUTTa6XnKZjsZyfHdD7OpWVXtEzRq/l30O4cQivNDBkEa1m84BX9fY9UxiDG5X3qkY9AaODIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15)
 by SA2PR11MB5130.namprd11.prod.outlook.com (2603:10b6:806:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 15:38:18 +0000
Received: from CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a]) by CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a%4]) with mapi id 15.20.8699.012; Wed, 14 May 2025
 15:38:18 +0000
From: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
To: Scott Murray <scott.murray@konsulko.com>
CC: "MacLeod, Randy" <Randy.MacLeod@windriver.com>,
        "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH v2 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
Thread-Topic: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH v2 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
Thread-Index: AQHbvxbruJyEt72ECEad+fYsE1PlN7PSAyxfgABFcwCAAAUr2g==
Date: Wed, 14 May 2025 15:38:18 +0000
Message-ID: 
 <CY8PR11MB7921A61EF710E3FC91A88C388191A@CY8PR11MB7921.namprd11.prod.outlook.com>
References: <183D29E6670EA629.16348@lists.yoctoproject.org>
 <CY8PR11MB7921D1FEED911BA634CD53728191A@CY8PR11MB7921.namprd11.prod.outlook.com>
 <1b7ac862-bdba-8517-610b-d9ee17930901@konsulko.com>
In-Reply-To: <1b7ac862-bdba-8517-610b-d9ee17930901@konsulko.com>
Accept-Language: en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7921:EE_|SA2PR11MB5130:EE_
x-ms-office365-filtering-correlation-id: b7fe8f8e-8783-47e2-e028-08dd92fd5986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|4022899009|1800799024|10070799003|13003099007|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?scn9z6YyiXkJdYx8hXH42WE8uvKaYh8ECGzlH0LtI9Fjc5xy5P30Feqv9v6n?=
 =?us-ascii?Q?FeZ4e3a0CErXjlfa426x7sDwN2yAuFWPgtCXP9XvJmYEbBYvRoMcwQGcJ8qv?=
 =?us-ascii?Q?nL8gzMr/qXeL0r2A99+j7RNF3S9rXgs5vRavRIZX9JQ2y8kQtN9w7WIOdxSh?=
 =?us-ascii?Q?TXpH8C1tozVB0saaZC1hRSJ/4ozleIefOwIbu0BGWIE36LZ5PCiGxV40jyCx?=
 =?us-ascii?Q?5XhXg/UCUmTV+i+6gIB2zVARAjI80Ju2+ZutN6zrRPBlaLz3qTSUEJTGygA+?=
 =?us-ascii?Q?yX5qwHpDXVmwj/UkrIs36gzZmHqr2D5rDzQTFWihwM7LshR4AxsG0J4XAluh?=
 =?us-ascii?Q?+UwmIpBpfzhlbq8GcdK3r8yrP1x/eJ3zeqPzcUXqHfkM/+ltcdckNVt+yr9l?=
 =?us-ascii?Q?epcoKbq8VA1r1qr724XgYu9d574qx46jZpTfSN4g7AT2q/epcoYaAPPX9e4J?=
 =?us-ascii?Q?KHcE01q84wq+SUIjDSA9coDh1hDIpib39XFODsD8+Hd4XbCY437y8xipzP2H?=
 =?us-ascii?Q?LzJMZq3R1R+cWI0ttXkH4gCY6y3iunpBmK/Xve47LeHyUnxy4MPKmRglrVRh?=
 =?us-ascii?Q?IfY7eLzNvZJuAr4pfLW5HNT76YMb/Spa8odQSL0Di19F5mALS8kjVhpFMeDj?=
 =?us-ascii?Q?V985WH95riCz5WCYPmEk91uRvZYCpkkHaBxkDlFD6onBAGpXCU70NZrYk2Qc?=
 =?us-ascii?Q?vimx7YkV9p0zTZTDy0zL1uhWrDQKACwpLtxd4n1g9dwlylTgmEGOSSCluugI?=
 =?us-ascii?Q?yRz8Uw0EHCDyQeFGoUxPH7vN2udJOvGz8Mb2QeTeKHePc6xeVYqo+zlsrKE7?=
 =?us-ascii?Q?TM0D+RBVwucMDJMEJSp8tWBQHODjAfBE4mBcp2jA2n20I7a0QgBfhOmJyzNz?=
 =?us-ascii?Q?lEOh/6JO57POrLmI73yPvD8MgTFhcFle+o9hxNP6oebHW/VPzEgTroJiGqCH?=
 =?us-ascii?Q?sq/8yCGb+JfLNGCGXMvp2sI9sJ74jmA0g94x46zUFWNxUCmHmN4sSpxUluDx?=
 =?us-ascii?Q?6YBCHG1k9bUUjnm3tKQ5A3FwSFChxTFaP+PhdZYLGYcQ4as3H5JtmNWv6V3h?=
 =?us-ascii?Q?pztusv+eMIxXd7P99+x0OleopkVftvSRki4AL9ZL+ylGyBRvs01YraHWgb/1?=
 =?us-ascii?Q?HMurmErMu7UgkmI18zXwUQJ4s2epO324KJQw1D14T5OcHbgkgw0fdpIJIND+?=
 =?us-ascii?Q?p8wSPDfm8OmiiwmSHG4MLohuYGFIKwBv8RC423jcbbva/mvZdvxN73WRqsN+?=
 =?us-ascii?Q?IR4dlb3JVHSujTvAuhiWI49QmF5agvk2eW5Vv6xwCmKTpkuEJYJbB9JuTVdK?=
 =?us-ascii?Q?M8/xzz10OVDoJv4x3S171BHixZ1WWTT9p2SmA0VKdtvx8ZipQsGmkoiqI3BJ?=
 =?us-ascii?Q?F445rZ1P8+qwzj022erQAJ+cysd6EVX7NqQFNKUsnhyMC5Yjj0zKHTKg7F3m?=
 =?us-ascii?Q?eypcVz9rJKo=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7921.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(4022899009)(1800799024)(10070799003)(13003099007)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?1b/tC/K0dXR8YoLW+l1U9o38HlGJORcXdyF3UNDAa1BEl+GHmb/YquY/2x0L?=
 =?us-ascii?Q?Uvg4rWJnkZnCYTxzB8am3KokI8EzNuvZpV+Vhh/tdRtQ6tB2iFHwZ715nbwt?=
 =?us-ascii?Q?ePzDCUqlGSzBFuArym1QW9n3M+O65JulKXcKxPXVelz08ShMrHgezOxdOCNz?=
 =?us-ascii?Q?Oio9i2TCpLKmI2Z3/CKsd/lWFW/Eu8EzeEHMBP11bFOO0UOsqdDtGUobg+y4?=
 =?us-ascii?Q?2UWaxqjgEBPtRTNomZEvDK4qBgPLGdPcG1i3yyfbCFzNldQU+mtQBhP3KFxK?=
 =?us-ascii?Q?HoybKp36kuUECT9Z9VbmMEYm2gO3F5h5yXPqTLwGSBWOPSZTnMwr+OXgg/GL?=
 =?us-ascii?Q?DCSfXPPj7d+TIqhKjc51TqOucetaOxEpsJRSCeiud7PLo/8EH+58+s0nwFwk?=
 =?us-ascii?Q?GNK0XAHgAWxec0hSM14K9vjdbGzfms2zEvFLwsNnM7XuKgzbmWRI8r06lQ8y?=
 =?us-ascii?Q?gXWNE1je6b7BiFrA6q052uU5xEqikwo/Y5NZ1Ww5X2c2zfkYvb7Ui4BZMvGa?=
 =?us-ascii?Q?0kGfPEDaaWl3x9+Zw74t+wUo/uCFF4siN2IRTqxrOVVN2zlYC7AEKmo9QSQX?=
 =?us-ascii?Q?of67Cgu9PtCeJ4oariT2IKyoYAixLtVFDtqueOo3kvtY5pMJS7gK6/R1Sv6g?=
 =?us-ascii?Q?4qGl8B01WWuQ+2za3CYGw5OBbChTL9rd04IHsk73PFbizFRJRHdEuIsdrhl2?=
 =?us-ascii?Q?xdGRC2McQ5azU5YIm2cacyfLuAfheiSuZfZkjN6JU7BKvleJnhQ4KfmIkw2Y?=
 =?us-ascii?Q?A7wVS7FD5CQiargnAT7PQG7GMKLAnQLk0+9cWOWw1i3RaXd2oB1eNaNQg18e?=
 =?us-ascii?Q?g2Oted7WOoqMhFS6BESdksPEVe9Tfv6blsBdL29FsJS9hnvCFeQ4tpAbWCPl?=
 =?us-ascii?Q?5IZfPjxCBjCQPVwmQDwOkBzscijL95sseLGXeQDBsHTExqd6i/J/3axkIsg2?=
 =?us-ascii?Q?S387/wOvwpR+VQSVwkMXGJ7saNA62wNcHgzn0Gdb9s0Tc5IwAsIMNIus694k?=
 =?us-ascii?Q?8HW3LKsTZITRKjPwvwUQEvrw5bW2fQWZ9tw/j0fsVqJyY9XoZL4XEpoOwEeU?=
 =?us-ascii?Q?ZKworRbMN1xKAymiGRCdGpJsotXtaHgHOr6nLjxFZa5krZHNx35XOlTkLwO6?=
 =?us-ascii?Q?Q5uC7KHWLcKy2ENIogMJZWlDZUciOIMzeP81MxRS/vrnpiFRl9B568U4TDc4?=
 =?us-ascii?Q?7yMAIR87cELM89rxo/1GaCsA/h3sV5ymsKpqrQluYbiryd9fIG3QGY7PkdKw?=
 =?us-ascii?Q?pEz7sgmzJ/OXqtkZXNw7GgaFROP8BPDYOMB8zi7jNEuGqx9dDPGFFRYHLIXx?=
 =?us-ascii?Q?kcX8Tzg27R/cTDJePkeIe9j3acO/+daTY85fO7TYgp1CEF5yie0EJuO9kKfa?=
 =?us-ascii?Q?tVAfMZSATJ0gYCDMph6Guj6huyJ5SAWp7ERJCV/AjFDpOG8gRQ3fEyvB7Uvi?=
 =?us-ascii?Q?njmSlM/lZN32XV8R5BYxGkZekvhlZICA7PgL/oMYLRCqgpRRvvuYVt9Z/9E0?=
 =?us-ascii?Q?kmpoYJTyvVVqPc74bqs9tsDHtz6JDuDOtIynw24hH6FQO/VBJv0bs96K6Uub?=
 =?us-ascii?Q?ztmINp9kEFabQx+7HUTVNW1lMXP7j4CVYfLOt0KpmTuzhJoN46l5+yyBSfGy?=
 =?us-ascii?Q?iGtnXtIvGRn46Z5vGuG+PUenmOTYpdBHXSFMdKrHmy/EI0/GwDsGb8wGjO2c?=
 =?us-ascii?Q?WeAciaic/3oc9ZmrjysgenGwHso=3D?=
Content-Type: multipart/alternative;
	boundary="_000_CY8PR11MB7921A61EF710E3FC91A88C388191ACY8PR11MB7921namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fe8f8e-8783-47e2-e028-08dd92fd5986
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 15:38:18.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8lgFsCYZxY0NDZIPWqDGjzbb7KqhziZTpZfwor4gWFhiWKRAVV1GMKqzyhFeQQyqrNlEFhV2xfDjpe1cGxhWvKIQ1rDG199HB/RYSqZ2KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5130
X-Proofpoint-GUID: 5I4ohmcOSz6Y7CdQaBQ_CwvC0IAjPAeg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE0MCBTYWx0ZWRfX4zCBLtI9CRyb aQeASY+eZUy4OgmXrfq8TiJVR3asoY5D9QIu/j9/vzIVxquO02mtcGPYdedxkJ6H8qb5Oe7HDfd OSo5zh/KVsRvtksxHNhNvaniRGwul/JlFASZ2nrLzwYGodZbSoUPC4r+lHJnNisunOLCXnniwfd
 pHlwQIhweHNSYpPGCaKmAnKR4rDqRcY99P9suqNaVbhIxUBPaw3r2dJYOewN1N+KRPgaZYlJjyP uRZTc5HlmhRQfXBV6O98e+C5HNUr+HRXtDl+5M0MCjL9ON7dEOpVX1iD5zB+H2fQ0PTpuv9Cpys 2J7/YrN/Rcw5me/lFLIjKMet6IMJqvwXhDLaLXFLtyJZeKp1o3J+9pH2Z5wciYE+ik6IwlySA5W
 FkK9Ip/mXCaf23awihLp75CI9dC1VZVQmtnuhK+/zBQrW7D2OtqBhQYz48jCUqy2WRsGv8JA
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=6824b8ef cx=c_pps a=/1KN1z/xraQh0Fnb7pnMZA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=iGHA9ds3AAAA:8 a=k-42gJp3AAAA:8 a=t7CeM3EgAAAA:8 a=TGWRFvGZnzJx6LKCTUUA:9 a=CjuIK1q_8ugA:10 a=XT6E3G6PrLNZ6kvs:21 a=_W_S_7VecoQA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=uCSXFHLys93vLW5PjgO_:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 5I4ohmcOSz6Y7CdQaBQ_CwvC0IAjPAeg
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505140140
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 May 2025 15:38:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1557

--_000_CY8PR11MB7921A61EF710E3FC91A88C388191ACY8PR11MB7921namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Great, thanks for getting it in!

Regards,
Soumya
________________________________
From: Scott Murray <scott.murray@konsulko.com>
Sent: Wednesday, May 14, 2025 8:48 PM
To: Sambu, Soumya <Soumya.Sambu@windriver.com>
Cc: MacLeod, Randy <Randy.MacLeod@windriver.com>; yocto-patches@lists.yocto=
project.org <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH v2 1/1=
] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

On Wed, 14 May 2025, Sambu, Soumya wrote:

> Hi Scott,
>
> I have revised this patch according to the latest guidelines. Could you p=
lease let me know if any further work is needed?
>
> Regards,
> Soumya

Sorry for the delay, I have given it a quick test and merged it to
kirkstone/rust just now.

Scott


> ________________________________
> From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproj=
ect.org> on behalf of Soumya via lists.yoctoproject.org <soumya.sambu=3Dwin=
driver.com@lists.yoctoproject.org>
> Sent: Wednesday, May 7, 2025 11:41 AM
> To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoprojec=
t.org>
> Cc: MacLeod, Randy <Randy.MacLeod@windriver.com>
> Subject: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH v2 1/1] =
mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
>
> From: Soumya Sambu <soumya.sambu@windriver.com>
>
> The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=3D${H=
OST_SYS} and
> --target=3D${TARGET_SYS} respectively, which leads to an error when using=
 Rust from meta-lts-mixins:
>
> error: Error loading target specification: Could not find specification f=
or target "x86_64-poky-linux".
>
> Updated target configuration to resolve this.
>
> Additionally, `mozjs-78` encountered "linker 'cc' not found" error. This =
was fixed by explicitly
> defining the linker for Rust.
>
> Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
> ---
>  README.md                                          |  2 +-
>  conf/layer.conf                                    |  4 ++++
>  .../recipes-devtools/rust/rust_1.85.1.bbappend     |  7 +++++++
>  .../recipes-extended/mozjs/mozjs-78_%.bbappend     | 14 ++++++++++++++
>  .../recipes-extended/mozjs/mozjs-91_%.bbappend     | 13 +++++++++++++
>  5 files changed, 39 insertions(+), 1 deletion(-)
>  create mode 100644 dynamic-layers/meta-python/recipes-devtools/rust/rust=
_1.85.1.bbappend
>  create mode 100644 dynamic-layers/meta-python/recipes-extended/mozjs/moz=
js-78_%.bbappend
>  create mode 100644 dynamic-layers/openembedded-layer/recipes-extended/mo=
zjs/mozjs-91_%.bbappend
>
> diff --git a/README.md b/README.md
> index 482f0cd..f05accf 100644
> --- a/README.md
> +++ b/README.md
> @@ -132,4 +132,4 @@ Layer maintainers:
>  Scott Murray <scott.murray@konsulko.com>
>
>  Dynamic layer support maintainers:
> -TBD
> +Soumya Sambu <soumya.sambu@windriver.com>
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 281eeca..4fe4ec4 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -26,6 +26,10 @@ BBMASK:append =3D " meta/recipes-devtools/cargo/ meta/=
recipes-devtools/rust/ meta/
>  # the newer BBCLASSEXTEND version that we carry.
>  BBMASK:append =3D " meta/recipes-devtools/python/python3-setuptools-rust=
-native_%"
>
> +BBFILES_DYNAMIC +=3D " \
> +    meta-python:${LAYERDIR}/dynamic-layers/meta-python/recipes-*/*/*.bba=
ppend \
> +    openembedded-layer:${LAYERDIR}/dynamic-layers/openembedded-layer/rec=
ipes-*/*/*.bbappend"
> +
>  # These are in bitbake.conf in langdale and up, adding them here to make
>  # using the layer more turn-key seems reasonable.
>  BB_BASEHASH_IGNORE_VARS:append =3D " RUST_BUILD_SYS RUST_HOST_SYS RUST_T=
ARGET_SYS"
> diff --git a/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1=
.bbappend b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bb=
append
> new file mode 100644
> index 0000000..9b09f9e
> --- /dev/null
> +++ b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappe=
nd
> @@ -0,0 +1,7 @@
> +python do_configure:append() {
> +    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}"=
)))
> +
> +    with open("config.toml", "w") as f:
> +        f.write("change-id =3D 116881\n\n")
> +        config.write(f)
> +}
> diff --git a/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%=
.bbappend b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bb=
append
> new file mode 100644
> index 0000000..8e8c24a
> --- /dev/null
> +++ b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappe=
nd
> @@ -0,0 +1,14 @@
> +EXTRA_OECONF =3D " \
> +    --target=3D${RUST_TARGET_SYS} \
> +    --host=3D${BUILD_SYS} \
> +    --prefix=3D${prefix} \
> +    --libdir=3D${libdir} \
> +    --x-includes=3D${STAGING_INCDIR} \
> +    --x-libraries=3D${STAGING_LIBDIR} \
> +    --without-system-icu \
> +    --disable-tests --disable-strip --disable-optimize \
> +    --disable-jemalloc \
> +    --with-system-icu \
> +    ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', "--enable-gold=
", '--disable-gold', d)} \
> +    ${JIT} \
> +"
> diff --git a/dynamic-layers/openembedded-layer/recipes-extended/mozjs/moz=
js-91_%.bbappend b/dynamic-layers/openembedded-layer/recipes-extended/mozjs=
/mozjs-91_%.bbappend
> new file mode 100644
> index 0000000..c0214b0
> --- /dev/null
> +++ b/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%=
.bbappend
> @@ -0,0 +1,13 @@
> +do_configure() {
> +        cd ${B}
> +        python3 ${S}/configure.py \
> +        --enable-project=3Djs \
> +        --target=3D${RUST_HOST_SYS} \
> +        --host=3D${BUILD_SYS} \
> +        --prefix=3D${prefix} \
> +        --libdir=3D${libdir} \
> +        --disable-jemalloc \
> +        --disable-strip \
> +        ${JIT} \
> +        ${ICU}
> +}
> --
> 2.40.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1521): https://lists.yoctoproject.org/g/yocto-patches=
/message/1521
> Mute This Topic: https://lists.yoctoproject.org/mt/112663754/7320427
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1404374=
0/7320427/1891404428/xyzzy [soumya.sambu@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
> pLK@tY:ATbOf1"dW
>

--_000_CY8PR11MB7921A61EF710E3FC91A88C388191ACY8PR11MB7921namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"ltr">
<div>
<div dir=3D"ltr">Great, thanks for getting it in!</div>
</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Regards<span>,</span></div>
<div dir=3D"ltr"><span>Soumya</span></div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>From:</b> Scott Murray &lt;scott.murray@konsulko.com&gt;<br>
<b>Sent:</b> Wednesday, May 14, 2025 8:48 PM<br>
<b>To:</b> Sambu, Soumya &lt;Soumya.Sambu@windriver.com&gt;<br>
<b>Cc:</b> MacLeod, Randy &lt;Randy.MacLeod@windriver.com&gt;; yocto-patche=
s@lists.yoctoproject.org &lt;yocto-patches@lists.yoctoproject.org&gt;<br>
<b>Subject:</b> Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH=
 v2 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">CAUTION: This email comes from a non Wind River em=
ail account!<br>
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.<br>
<br>
On Wed, 14 May 2025, Sambu, Soumya wrote:<br>
<br>
&gt; Hi Scott,<br>
&gt;<br>
&gt; I have revised this patch according to the latest guidelines. Could yo=
u please let me know if any further work is needed?<br>
&gt;<br>
&gt; Regards,<br>
&gt; Soumya<br>
<br>
Sorry for the delay, I have given it a quick test and merged it to<br>
kirkstone/rust just now.<br>
<br>
Scott<br>
<br>
<br>
&gt; ________________________________<br>
&gt; From: yocto-patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoc=
toproject.org&gt; on behalf of Soumya via lists.yoctoproject.org &lt;soumya=
.sambu=3Dwindriver.com@lists.yoctoproject.org&gt;<br>
&gt; Sent: Wednesday, May 7, 2025 11:41 AM<br>
&gt; To: yocto-patches@lists.yoctoproject.org &lt;yocto-patches@lists.yocto=
project.org&gt;<br>
&gt; Cc: MacLeod, Randy &lt;Randy.MacLeod@windriver.com&gt;<br>
&gt; Subject: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH v2 1/=
1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS<br>
&gt;<br>
&gt; From: Soumya Sambu &lt;soumya.sambu@windriver.com&gt;<br>
&gt;<br>
&gt; The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=3D=
${HOST_SYS} and<br>
&gt; --target=3D${TARGET_SYS} respectively, which leads to an error when us=
ing Rust from meta-lts-mixins:<br>
&gt;<br>
&gt; error: Error loading target specification: Could not find specificatio=
n for target &quot;x86_64-poky-linux&quot;.<br>
&gt;<br>
&gt; Updated target configuration to resolve this.<br>
&gt;<br>
&gt; Additionally, `mozjs-78` encountered &quot;linker 'cc' not found&quot;=
 error. This was fixed by explicitly<br>
&gt; defining the linker for Rust.<br>
&gt;<br>
&gt; Signed-off-by: Soumya Sambu &lt;soumya.sambu@windriver.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; README.md&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&gt;&nbsp; conf/layer.conf&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 ++++<br>
&gt;&nbsp; .../recipes-devtools/rust/rust_1.85.1.bbappend&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 7 +++++++<br>
&gt;&nbsp; .../recipes-extended/mozjs/mozjs-78_%.bbappend&nbsp;&nbsp;&nbsp;=
&nbsp; | 14 ++++++++++++++<br>
&gt;&nbsp; .../recipes-extended/mozjs/mozjs-91_%.bbappend&nbsp;&nbsp;&nbsp;=
&nbsp; | 13 +++++++++++++<br>
&gt;&nbsp; 5 files changed, 39 insertions(+), 1 deletion(-)<br>
&gt;&nbsp; create mode 100644 dynamic-layers/meta-python/recipes-devtools/r=
ust/rust_1.85.1.bbappend<br>
&gt;&nbsp; create mode 100644 dynamic-layers/meta-python/recipes-extended/m=
ozjs/mozjs-78_%.bbappend<br>
&gt;&nbsp; create mode 100644 dynamic-layers/openembedded-layer/recipes-ext=
ended/mozjs/mozjs-91_%.bbappend<br>
&gt;<br>
&gt; diff --git a/README.md b/README.md<br>
&gt; index 482f0cd..f05accf 100644<br>
&gt; --- a/README.md<br>
&gt; +++ b/README.md<br>
&gt; @@ -132,4 +132,4 @@ Layer maintainers:<br>
&gt;&nbsp; Scott Murray &lt;scott.murray@konsulko.com&gt;<br>
&gt;<br>
&gt;&nbsp; Dynamic layer support maintainers:<br>
&gt; -TBD<br>
&gt; +Soumya Sambu &lt;soumya.sambu@windriver.com&gt;<br>
&gt; diff --git a/conf/layer.conf b/conf/layer.conf<br>
&gt; index 281eeca..4fe4ec4 100644<br>
&gt; --- a/conf/layer.conf<br>
&gt; +++ b/conf/layer.conf<br>
&gt; @@ -26,6 +26,10 @@ BBMASK:append =3D &quot; meta/recipes-devtools/carg=
o/ meta/recipes-devtools/rust/ meta/<br>
&gt;&nbsp; # the newer BBCLASSEXTEND version that we carry.<br>
&gt;&nbsp; BBMASK:append =3D &quot; meta/recipes-devtools/python/python3-se=
tuptools-rust-native_%&quot;<br>
&gt;<br>
&gt; +BBFILES_DYNAMIC +=3D &quot; \<br>
&gt; +&nbsp;&nbsp;&nbsp; meta-python:${LAYERDIR}/dynamic-layers/meta-python=
/recipes-*/*/*.bbappend \<br>
&gt; +&nbsp;&nbsp;&nbsp; openembedded-layer:${LAYERDIR}/dynamic-layers/open=
embedded-layer/recipes-*/*/*.bbappend&quot;<br>
&gt; +<br>
&gt;&nbsp; # These are in bitbake.conf in langdale and up, adding them here=
 to make<br>
&gt;&nbsp; # using the layer more turn-key seems reasonable.<br>
&gt;&nbsp; BB_BASEHASH_IGNORE_VARS:append =3D &quot; RUST_BUILD_SYS RUST_HO=
ST_SYS RUST_TARGET_SYS&quot;<br>
&gt; diff --git a/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.8=
5.1.bbappend b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1=
.bbappend<br>
&gt; new file mode 100644<br>
&gt; index 0000000..9b09f9e<br>
&gt; --- /dev/null<br>
&gt; +++ b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bba=
ppend<br>
&gt; @@ -0,0 +1,7 @@<br>
&gt; +python do_configure:append() {<br>
&gt; +&nbsp;&nbsp;&nbsp; config.set(&quot;rust&quot;, &quot;default-linker&=
quot;, e(d.expand(&quot;${RUST_BUILD_CCLD}&quot;)))<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; with open(&quot;config.toml&quot;, &quot;w&quot;) =
as f:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f.write(&quot;change-id =
=3D 116881\n\n&quot;)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config.write(f)<br>
&gt; +}<br>
&gt; diff --git a/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-7=
8_%.bbappend b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%=
.bbappend<br>
&gt; new file mode 100644<br>
&gt; index 0000000..8e8c24a<br>
&gt; --- /dev/null<br>
&gt; +++ b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bba=
ppend<br>
&gt; @@ -0,0 +1,14 @@<br>
&gt; +EXTRA_OECONF =3D &quot; \<br>
&gt; +&nbsp;&nbsp;&nbsp; --target=3D${RUST_TARGET_SYS} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --host=3D${BUILD_SYS} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --prefix=3D${prefix} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --libdir=3D${libdir} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --x-includes=3D${STAGING_INCDIR} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --x-libraries=3D${STAGING_LIBDIR} \<br>
&gt; +&nbsp;&nbsp;&nbsp; --without-system-icu \<br>
&gt; +&nbsp;&nbsp;&nbsp; --disable-tests --disable-strip --disable-optimize=
 \<br>
&gt; +&nbsp;&nbsp;&nbsp; --disable-jemalloc \<br>
&gt; +&nbsp;&nbsp;&nbsp; --with-system-icu \<br>
&gt; +&nbsp;&nbsp;&nbsp; ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gol=
d', &quot;--enable-gold&quot;, '--disable-gold', d)} \<br>
&gt; +&nbsp;&nbsp;&nbsp; ${JIT} \<br>
&gt; +&quot;<br>
&gt; diff --git a/dynamic-layers/openembedded-layer/recipes-extended/mozjs/=
mozjs-91_%.bbappend b/dynamic-layers/openembedded-layer/recipes-extended/mo=
zjs/mozjs-91_%.bbappend<br>
&gt; new file mode 100644<br>
&gt; index 0000000..c0214b0<br>
&gt; --- /dev/null<br>
&gt; +++ b/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-9=
1_%.bbappend<br>
&gt; @@ -0,0 +1,13 @@<br>
&gt; +do_configure() {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cd ${B}<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; python3 ${S}/configure.py =
\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --enable-project=3Djs \<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --target=3D${RUST_HOST_SYS=
} \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --host=3D${BUILD_SYS} \<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --prefix=3D${prefix} \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --libdir=3D${libdir} \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --disable-jemalloc \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --disable-strip \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${JIT} \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${ICU}<br>
&gt; +}<br>
&gt; --<br>
&gt; 2.40.0<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#1521): <a href=3D"https://lists.yoctoproject.org/g=
/yocto-patches/message/1521">
https://lists.yoctoproject.org/g/yocto-patches/message/1521</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/11266375=
4/7320427">
https://lists.yoctoproject.org/mt/112663754/7320427</a><br>
&gt; Group Owner: yocto-patches+owner@lists.yoctoproject.org<br>
&gt; Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches=
/leave/14043740/7320427/1891404428/xyzzy">
https://lists.yoctoproject.org/g/yocto-patches/leave/14043740/7320427/18914=
04428/xyzzy</a> [soumya.sambu@windriver.com]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;<br>
&gt;<br>
&gt; pLK@tY:ATbOf1&quot;dW<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY8PR11MB7921A61EF710E3FC91A88C388191ACY8PR11MB7921namp_--

