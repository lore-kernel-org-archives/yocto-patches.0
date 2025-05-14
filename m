Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB263C3ABD9
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 11:18:09 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.99605.1747221484831429176
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 May 2025 04:18:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7229e69a19=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAYdaM001885;
	Wed, 14 May 2025 11:18:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbc8rxas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:18:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFS9MmUWGo7c00/BCgdKaJXyVtB1z2k0D7SpuGEJbefDSUlUnh/k3H4D5yXLrPz/alIWkslH5N0Fc0e5BTdfgRTXL6Gm6tPZAAXjuRajaIGI5+5s4sw33A7/2T1FCIquWO5Jgf8UomfI67lORI7iLyNJwE2t4qh5AXabFWucuYR3q2swFST0v9OR3wltgXrDI6TY7/NB9ZYk4Hc6GQ3YiuHzj7C+LOiNI05B4ZVmEVota/9YjtiUtXesK47vB3Y5neGip1ubOxIc0noKNEeHP2jYUD9engo6qC1ufsV1+/Ri8dmmdHwjA876Mx0nZAIt4GvKlmYfMmsYxtQN5Kbqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGArfcTwgaNzppGvYjQpYnKMkcpsu8XfE1Cw6ahLGw4=;
 b=mz5RTP4nhTkAbwxUJARhjfwgqJxEOSVggibRcSGGxJS6D4mmq9usSKd2r6JMKyJcwVdjTrLrVwdf8wRLcOVcKQuwkaA+D3ZrLUQaYHVdhgUxKajM4JRcJI1zb8BKkehW6Oc7/SSmc4YlzBsIRAu4PeXOCVEjaCR8IwDOq1/UsKFtuaPfAR3VwanhjuZD6RmJWmBAIEfdM8rns3/mcsZTgB/wKxaeiJfi+lz4plExWOVDnT0CgV0etbNsFYt5Q6SHlSDsgXquKUOKn/868vUCr1M913Bw08rHR4+l/7OrpPiQ/uKTXZMkzUcUOo5TznSCdugoI8QY41pJlYrpAkBb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 11:17:59 +0000
Received: from CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a]) by CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a%4]) with mapi id 15.20.8699.012; Wed, 14 May 2025
 11:17:59 +0000
From: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
To: Scott Murray <scott.murray@konsulko.com>
CC: "MacLeod, Randy" <Randy.MacLeod@windriver.com>,
        "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH v2 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
Thread-Topic: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH v2 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
Thread-Index: AQHbvxbruJyEt72ECEad+fYsE1PlN7PSAyxf
Date: Wed, 14 May 2025 11:17:58 +0000
Message-ID: 
 <CY8PR11MB7921D1FEED911BA634CD53728191A@CY8PR11MB7921.namprd11.prod.outlook.com>
References: <183D29E6670EA629.16348@lists.yoctoproject.org>
In-Reply-To: <183D29E6670EA629.16348@lists.yoctoproject.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7921:EE_|MN2PR11MB4533:EE_
x-ms-office365-filtering-correlation-id: 72f22d06-b025-4919-62a2-08dd92d8fbb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|4022899009|8096899003|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?DEJGukW3d0XJanqRI6uXKOhbDbsnxpS57rNrXMfUsmUk2apwuK/IoqPztY?=
 =?iso-8859-1?Q?fiNtOUeo7dmE9VZhwa2pR4CroFjn4NT7frp9s2syHZi7bsPoezoIDW3ukx?=
 =?iso-8859-1?Q?pBDRmKohwQlzm+/f1Mlnfa2Nf+nNkYeG81oyhVM+elrruYq0eZfDVL1CFL?=
 =?iso-8859-1?Q?uh0euVtTzJFREIB6F+2es+GO6A0H2a18Xoj+f1BgW08XMJWxCstcFe/Ig0?=
 =?iso-8859-1?Q?jLiDmtYqf3bLQqbXoH7/luDwz2GHvBp8nJKHV5KVYrKHhuqShrHYytuXT+?=
 =?iso-8859-1?Q?jNQ5X9AHiFHqUUoo8W+stA1NpA9KYTlVUuENRs8etQAFYUj7IPag7j7phG?=
 =?iso-8859-1?Q?q+iAEB4j4Bs5pwWdYohkA+vcd9sENkdMngsrcfzFjHY9l59AJ3j4w4NQE4?=
 =?iso-8859-1?Q?KXFwNG8EvkMNsWm1ArgRcc/f5PvLzn39MCSktjG23nSkePOcAnRQ0GR0fk?=
 =?iso-8859-1?Q?OCJtmkFmc2eEcEvuvlFtVs3896n19Rq6Ased43RHnwNSDoD+KQoVkcV3+S?=
 =?iso-8859-1?Q?Ewn3QPMvlTFVqgNtx5PpsafZD1H7PZY9Ch3t8qBVZ0h3EQrrQ8N2wki7dH?=
 =?iso-8859-1?Q?H3YdaGR39WKsdCFBlb/Vt6xu46bkbf4b+evaRMLUyANO0OWRwqNqPtzBWc?=
 =?iso-8859-1?Q?rK2RLpTSQRyBwVp7xAUwTpl0MR2c/XpGIf7dO+c+fXWui0EFYpgaCJ19fD?=
 =?iso-8859-1?Q?L3mIObqLf66s9siK6FJYfrcCP5xCKo+QONVnLYSXKitTF1uCY4DV8zM+um?=
 =?iso-8859-1?Q?04R43mAqTtHP6JA0dO7z0JFmwtJtAdq7n1Rw0A3A76gq7nu75ukt3/ltZx?=
 =?iso-8859-1?Q?vmvxs0dv5sUJkLEJ25Gp/vgVujR+DGEmWRj5aThMuqL6CUcCfEkp7rGPDi?=
 =?iso-8859-1?Q?yPy7JDTRecD5nQrswJSCs2kcnjwFjKdgsz1AsrNjd8RU1A32SSXHR/8URh?=
 =?iso-8859-1?Q?J97SxR4UUlix7hI+wKyhYkdMeSBFo3NSzrsq0L+hEwHoQ5hQn05HQkiKfi?=
 =?iso-8859-1?Q?FIRUpOjv/P3bM6iGcdhuC0fOMRgNcSwqhf54Kxir9Wnv11O6aE+2Me0QxR?=
 =?iso-8859-1?Q?5lW7XcvlP5HwKXnzIgvyG/dUbHJ4fDcmYQ0xvauXz5JsCiBXvG+g0ub7GH?=
 =?iso-8859-1?Q?huscH5z2dVzNsXp5yZx+JdcwlCTjxgabzMl3y9TMwwdg1UheNjIl2PPl2K?=
 =?iso-8859-1?Q?vaXpCTnvMdFfXuzc+Y9BBZDa0eKGD5lfqgyXWD6ywia/Dn3asO441IYrLk?=
 =?iso-8859-1?Q?W1jJzj1QDgSRAT8LzGKLhs8rP+9tRrvEIrR/7a30db9UnfhHfRHDvo8I5Y?=
 =?iso-8859-1?Q?IS18Tjg6+tB/Y3/h5Kj3B4yAcGJ19k+gr9ngCHjbwKSOkKIalA7UwYwcGg?=
 =?iso-8859-1?Q?0s25ZpiPe5SQQBjpZKHjm+hmF6W7OLIiXSSIbMEtigpz/4rGNBgeRHq+Dv?=
 =?iso-8859-1?Q?ciyOWMcPzoizqjdau3K/ZP51NGjWjZgcqG7fvM9Vx/IpE34CoOTcTzRxfx?=
 =?iso-8859-1?Q?FiyCAorsjt1FjAq+kwtO+E?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7921.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4022899009)(8096899003)(13003099007)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?BG/DPm+aHiUEeykQAamI7Nx0qlpacEmSagJ8ozBnQCr1iTBumCZ9zsGSo0?=
 =?iso-8859-1?Q?L7i/BpIK3khQn3Cq+IGFRPc4r2qBnPmncMekahlGlOXo/BvsKDg/is1DnY?=
 =?iso-8859-1?Q?96pZW4RvgE4T7pHzPeG5ztSojwKvzjx0d18RCarbGtr6gGHD9PR2bi3VKg?=
 =?iso-8859-1?Q?pbmFV9HRafvJq5jeHxf1U28r4EwUT+kn739bdQL3TzJ8gpVDAlYShyKVx8?=
 =?iso-8859-1?Q?13vgoTjwJ12z7PY3J5/+ZqzaShRWmFY8kQzcr+new/aPyGrvE58swBjnhd?=
 =?iso-8859-1?Q?GlrSuWbNNBLPkUoVC2L2ujMJSJXM35lKk0O46lnmAd4IVtVUedRZmb0Flx?=
 =?iso-8859-1?Q?YDqcBbqZhYIbBQ7HQv/nDCRDS95VcEiDAfwsRF6M/ody/aBTusph9Mi3UA?=
 =?iso-8859-1?Q?8RyVMDYHthjhwvz4DZCOQKgAFL4HljUg6qL2B8FrxmIlf2oUwyD+RQvrd5?=
 =?iso-8859-1?Q?g8yqvsmSdZAhKbsS5g+7CH4lTqeAjVImIO/lIYX3zGOsl7HkKne2BSRQiX?=
 =?iso-8859-1?Q?ODpbIxtpSXSBNGopFIlXJ9bAqajt5ax9NIKYGJHpk3uJxUTkrrTgEiN+Kd?=
 =?iso-8859-1?Q?7hUDl7b+g+pJriPn/7C2ZsCVAJahJHnjEaDhZeIiLvNS0fGl9yodAhgCwQ?=
 =?iso-8859-1?Q?1qElg3SQv+A+xxvlRrFsH4VjkzQu729y+xGpOEVzk8wBAo/mCKQ8sH0DtS?=
 =?iso-8859-1?Q?qJL9jW/Knf0LsnBJqTqcJPxQRAOEkXLmERYugg28LVVWLWzNm98fPR6DpI?=
 =?iso-8859-1?Q?Grx7bGRaGRgfldUcrAJ4FjaAV45QH+52U5UeU1JpOjKI3TcRV79M2n481M?=
 =?iso-8859-1?Q?mjlxxtYt62APmqWWjBi3YT/8/LidIr2o7vCn63/Y/PTgZTPLqLFIBjM/k1?=
 =?iso-8859-1?Q?EVSi0MTIdKdK3X7wjVI5K5nXQQ2pygSUydK0lVNAIR4DH49LgDyfHpw7Rg?=
 =?iso-8859-1?Q?1ay8URdVUXUK5BzLZfz+51Pc7Q4Ee1ewBQXwMoFzmQjIiub7u9DKs2gQ6n?=
 =?iso-8859-1?Q?KutLU0RGvFmK6DIEVchHBg44S+BEOzTLccLJ8wYuW+tT/DEkxzVsaa2mLL?=
 =?iso-8859-1?Q?wR2QvNp1Ag/ikX/0q5O1BUPTAFWr9baPBcsLQqmQkV2Qkbzx+5K2NckfDI?=
 =?iso-8859-1?Q?QDQHaSzpgQvVcoGW35RUPYNk8rT6pH1vO8+vWjUKzDjUtdQFBqxp2dt9Xs?=
 =?iso-8859-1?Q?LJ/8m2FLeLewm7cLjGArJ1quDOmkfGs9/mnl2UXdLFsczVQklGXVM8XXQ3?=
 =?iso-8859-1?Q?J1BcKUvs3a85k7T/ccGVzBhATiQdx/hGNHh6NnyNCb75hvOSMBuu9bdjUU?=
 =?iso-8859-1?Q?XDsmYfJPZCHuNJ95KtgFZl1jSaz3Htnwd0WNVmd7gc9p8MWo/T25IRMR6C?=
 =?iso-8859-1?Q?6Ay8844pge3F1I3rNn9ZI6WzZOdlThgQPsYwgvrYz0hJmcQo70H3DDJHJ9?=
 =?iso-8859-1?Q?v42TezLqHsV0uFYH/LuzVE9Gnm81uVfpxm16Gecrf4t3ijvuAxwINGHXmA?=
 =?iso-8859-1?Q?S5S6r+S1GAzGGQvgfr5ylf7ZiaVnBdSuYMt2c3aC9Efh1LfJjRGylypUTt?=
 =?iso-8859-1?Q?sNXg+D+Cfdy0JoilCZJ7ZgL23ONQYbxNiKjdxp53Q7Y2o1PY38G6yoUQDS?=
 =?iso-8859-1?Q?IE5wM0vT81TcDxmbNBawKqkQx5ugr9bROzwkWEYeM2e6Xwqf0Fe72fQg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_CY8PR11MB7921D1FEED911BA634CD53728191ACY8PR11MB7921namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f22d06-b025-4919-62a2-08dd92d8fbb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 11:17:58.9482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fO5x9SdjFXPMo/fWKiwQ2Zl5ZcWnAp4U5rTdQ+3lUN6w/nvZ6aWPac5MjUq6QnbelFK1mLo4vKSpI5xSp57q45Jm+vmUBi/S+QlirxkDAUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
X-Proofpoint-GUID: BstX4SY5Mlu68vSbgw6lT5SqU56cwqyX
X-Proofpoint-ORIG-GUID: BstX4SY5Mlu68vSbgw6lT5SqU56cwqyX
X-Authority-Analysis: v=2.4 cv=IIACChvG c=1 sm=1 tr=0 ts=68247bea cx=c_pps a=VLWBoSTBoww685Dj7+Q0uQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=k-42gJp3AAAA:8 a=dIK-v1wesC00SM4Sl00A:9 a=wPNLvfGTeEIA:10 a=pX6AzZYwyLOt6I9t1kIA:9 a=Owdhzu84botv8gq1:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA5OSBTYWx0ZWRfX3+An6WhXOuCt 97IdozX3CMfESNzTDuULLLsJULGmKyFemSgrVVWIZWvwxmS18avGXkpWp4AW4a/b1jLJw2QfZ0m 71E6bPMQ5tASPScxcyTZXBxY3OAlooSl0KgoufF8nlyfbAry4S8+BD0D+S/Yse6Ygwz0Y3KfIox
 WeyF9N9HoYGuOIB7oKox00D+xa5YIY8QZ0ebjQslqOI6MOPc0BKvCKDaIonD3D38cT1XynHuJg1 NpbfvWujyLRidAj7H1FtQg3rYLas4njbAmXoUcIb6dBVVq/Fe6lrdRaWwmTKe5mvYPWRUUhdMQg 6BBE4q/kRpwwiGy6UXYD7Gd+VQC0t4nXuNqYmHjGODgo/+zLgmtXOvk3V65bJstHFyf+Y/UqLXF
 0c5BJKppgkmp1MaTAagVMdYRPEj+ThhNP76u9cUf8HJGROKHQNbpwvk2G3FK5osxFtsFNWpO
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505140099
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 May 2025 11:18:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1554

--_000_CY8PR11MB7921D1FEED911BA634CD53728191ACY8PR11MB7921namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Scott,

I have revised this patch according to the latest guidelines. Could you ple=
ase let me know if any further work is needed?

Regards,
Soumya
________________________________
From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoprojec=
t.org> on behalf of Soumya via lists.yoctoproject.org <soumya.sambu=3Dwindr=
iver.com@lists.yoctoproject.org>
Sent: Wednesday, May 7, 2025 11:41 AM
To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>
Cc: MacLeod, Randy <Randy.MacLeod@windriver.com>
Subject: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH v2 1/1] mo=
zjs: Use RUST_HOST_SYS and RUST_TARGET_SYS

From: Soumya Sambu <soumya.sambu@windriver.com>

The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=3D${HOS=
T_SYS} and
--target=3D${TARGET_SYS} respectively, which leads to an error when using R=
ust from meta-lts-mixins:

error: Error loading target specification: Could not find specification for=
 target "x86_64-poky-linux".

Updated target configuration to resolve this.

Additionally, `mozjs-78` encountered "linker 'cc' not found" error. This wa=
s fixed by explicitly
defining the linker for Rust.

Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
---
 README.md                                          |  2 +-
 conf/layer.conf                                    |  4 ++++
 .../recipes-devtools/rust/rust_1.85.1.bbappend     |  7 +++++++
 .../recipes-extended/mozjs/mozjs-78_%.bbappend     | 14 ++++++++++++++
 .../recipes-extended/mozjs/mozjs-91_%.bbappend     | 13 +++++++++++++
 5 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 dynamic-layers/meta-python/recipes-devtools/rust/rust_1=
.85.1.bbappend
 create mode 100644 dynamic-layers/meta-python/recipes-extended/mozjs/mozjs=
-78_%.bbappend
 create mode 100644 dynamic-layers/openembedded-layer/recipes-extended/mozj=
s/mozjs-91_%.bbappend

diff --git a/README.md b/README.md
index 482f0cd..f05accf 100644
--- a/README.md
+++ b/README.md
@@ -132,4 +132,4 @@ Layer maintainers:
 Scott Murray <scott.murray@konsulko.com>

 Dynamic layer support maintainers:
-TBD
+Soumya Sambu <soumya.sambu@windriver.com>
diff --git a/conf/layer.conf b/conf/layer.conf
index 281eeca..4fe4ec4 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -26,6 +26,10 @@ BBMASK:append =3D " meta/recipes-devtools/cargo/ meta/re=
cipes-devtools/rust/ meta/
 # the newer BBCLASSEXTEND version that we carry.
 BBMASK:append =3D " meta/recipes-devtools/python/python3-setuptools-rust-n=
ative_%"

+BBFILES_DYNAMIC +=3D " \
+    meta-python:${LAYERDIR}/dynamic-layers/meta-python/recipes-*/*/*.bbapp=
end \
+    openembedded-layer:${LAYERDIR}/dynamic-layers/openembedded-layer/recip=
es-*/*/*.bbappend"
+
 # These are in bitbake.conf in langdale and up, adding them here to make
 # using the layer more turn-key seems reasonable.
 BB_BASEHASH_IGNORE_VARS:append =3D " RUST_BUILD_SYS RUST_HOST_SYS RUST_TAR=
GET_SYS"
diff --git a/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.b=
bappend b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbap=
pend
new file mode 100644
index 0000000..9b09f9e
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend
@@ -0,0 +1,7 @@
+python do_configure:append() {
+    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}"))=
)
+
+    with open("config.toml", "w") as f:
+        f.write("change-id =3D 116881\n\n")
+        config.write(f)
+}
diff --git a/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.b=
bappend b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbap=
pend
new file mode 100644
index 0000000..8e8c24a
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend
@@ -0,0 +1,14 @@
+EXTRA_OECONF =3D " \
+    --target=3D${RUST_TARGET_SYS} \
+    --host=3D${BUILD_SYS} \
+    --prefix=3D${prefix} \
+    --libdir=3D${libdir} \
+    --x-includes=3D${STAGING_INCDIR} \
+    --x-libraries=3D${STAGING_LIBDIR} \
+    --without-system-icu \
+    --disable-tests --disable-strip --disable-optimize \
+    --disable-jemalloc \
+    --with-system-icu \
+    ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', "--enable-gold",=
 '--disable-gold', d)} \
+    ${JIT} \
+"
diff --git a/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs=
-91_%.bbappend b/dynamic-layers/openembedded-layer/recipes-extended/mozjs/m=
ozjs-91_%.bbappend
new file mode 100644
index 0000000..c0214b0
--- /dev/null
+++ b/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.b=
bappend
@@ -0,0 +1,13 @@
+do_configure() {
+        cd ${B}
+        python3 ${S}/configure.py \
+        --enable-project=3Djs \
+        --target=3D${RUST_HOST_SYS} \
+        --host=3D${BUILD_SYS} \
+        --prefix=3D${prefix} \
+        --libdir=3D${libdir} \
+        --disable-jemalloc \
+        --disable-strip \
+        ${JIT} \
+        ${ICU}
+}
--
2.40.0



-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#1521): https://lists.yoctoproject.org/g/yocto-patches/m=
essage/1521
Mute This Topic: https://lists.yoctoproject.org/mt/112663754/7320427
Group Owner: yocto-patches+owner@lists.yoctoproject.org
Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14043740/=
7320427/1891404428/xyzzy [soumya.sambu@windriver.com]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


pLK@tY:ATbOf1"dW

--_000_CY8PR11MB7921D1FEED911BA634CD53728191ACY8PR11MB7921namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Scott,<br>
<br>
I have revised this patch according to the latest guidelines. Could you ple=
ase let me know if any further work is needed?<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Soumya</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;yocto-=
patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoctoproject.org&gt;=
 on behalf of Soumya via lists.yoctoproject.org &lt;soumya.sambu=3Dwindrive=
r.com@lists.yoctoproject.org&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, May 7, 2025 11:41 AM<br>
<b>To:</b>&nbsp;yocto-patches@lists.yoctoproject.org &lt;yocto-patches@list=
s.yoctoproject.org&gt;<br>
<b>Cc:</b>&nbsp;MacLeod, Randy &lt;Randy.MacLeod@windriver.com&gt;<br>
<b>Subject:</b>&nbsp;[yocto-patches] [meta-lts-mixins][kirkstone/rust][PATC=
H v2 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">From: Soumya Sambu &lt;soumya.sambu@windriv=
er.com&gt;<br>
<br>
The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=3D${HOS=
T_SYS} and<br>
--target=3D${TARGET_SYS} respectively, which leads to an error when using R=
ust from meta-lts-mixins:<br>
<br>
error: Error loading target specification: Could not find specification for=
 target &quot;x86_64-poky-linux&quot;.<br>
<br>
Updated target configuration to resolve this.<br>
<br>
Additionally, `mozjs-78` encountered &quot;linker 'cc' not found&quot; erro=
r. This was fixed by explicitly<br>
defining the linker for Rust.<br>
<br>
Signed-off-by: Soumya Sambu &lt;soumya.sambu@windriver.com&gt;<br>
---<br>
&nbsp;README.md&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;conf/layer.conf&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 4 ++++<br>
&nbsp;.../recipes-devtools/rust/rust_1.85.1.bbappend&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 7 +++++++<br>
&nbsp;.../recipes-extended/mozjs/mozjs-78_%.bbappend&nbsp;&nbsp;&nbsp;&nbsp=
; | 14 ++++++++++++++<br>
&nbsp;.../recipes-extended/mozjs/mozjs-91_%.bbappend&nbsp;&nbsp;&nbsp;&nbsp=
; | 13 +++++++++++++<br>
&nbsp;5 files changed, 39 insertions(+), 1 deletion(-)<br>
&nbsp;create mode 100644 dynamic-layers/meta-python/recipes-devtools/rust/r=
ust_1.85.1.bbappend<br>
&nbsp;create mode 100644 dynamic-layers/meta-python/recipes-extended/mozjs/=
mozjs-78_%.bbappend<br>
&nbsp;create mode 100644 dynamic-layers/openembedded-layer/recipes-extended=
/mozjs/mozjs-91_%.bbappend<br>
<br>
diff --git a/README.md b/README.md<br>
index 482f0cd..f05accf 100644<br>
--- a/README.md<br>
+++ b/README.md<br>
@@ -132,4 +132,4 @@ Layer maintainers:<br>
&nbsp;Scott Murray &lt;scott.murray@konsulko.com&gt;<br>
<br>
&nbsp;Dynamic layer support maintainers:<br>
-TBD<br>
+Soumya Sambu &lt;soumya.sambu@windriver.com&gt;<br>
diff --git a/conf/layer.conf b/conf/layer.conf<br>
index 281eeca..4fe4ec4 100644<br>
--- a/conf/layer.conf<br>
+++ b/conf/layer.conf<br>
@@ -26,6 +26,10 @@ BBMASK:append =3D &quot; meta/recipes-devtools/cargo/ me=
ta/recipes-devtools/rust/ meta/<br>
&nbsp;# the newer BBCLASSEXTEND version that we carry.<br>
&nbsp;BBMASK:append =3D &quot; meta/recipes-devtools/python/python3-setupto=
ols-rust-native_%&quot;<br>
<br>
+BBFILES_DYNAMIC +=3D &quot; \<br>
+&nbsp;&nbsp;&nbsp; meta-python:${LAYERDIR}/dynamic-layers/meta-python/reci=
pes-*/*/*.bbappend \<br>
+&nbsp;&nbsp;&nbsp; openembedded-layer:${LAYERDIR}/dynamic-layers/openembed=
ded-layer/recipes-*/*/*.bbappend&quot;<br>
+<br>
&nbsp;# These are in bitbake.conf in langdale and up, adding them here to m=
ake<br>
&nbsp;# using the layer more turn-key seems reasonable.<br>
&nbsp;BB_BASEHASH_IGNORE_VARS:append =3D &quot; RUST_BUILD_SYS RUST_HOST_SY=
S RUST_TARGET_SYS&quot;<br>
diff --git a/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.b=
bappend b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbap=
pend<br>
new file mode 100644<br>
index 0000000..9b09f9e<br>
--- /dev/null<br>
+++ b/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend=
<br>
@@ -0,0 +1,7 @@<br>
+python do_configure:append() {<br>
+&nbsp;&nbsp;&nbsp; config.set(&quot;rust&quot;, &quot;default-linker&quot;=
, e(d.expand(&quot;${RUST_BUILD_CCLD}&quot;)))<br>
+<br>
+&nbsp;&nbsp;&nbsp; with open(&quot;config.toml&quot;, &quot;w&quot;) as f:=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f.write(&quot;change-id =3D 116=
881\n\n&quot;)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config.write(f)<br>
+}<br>
diff --git a/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.b=
bappend b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbap=
pend<br>
new file mode 100644<br>
index 0000000..8e8c24a<br>
--- /dev/null<br>
+++ b/dynamic-layers/meta-python/recipes-extended/mozjs/mozjs-78_%.bbappend=
<br>
@@ -0,0 +1,14 @@<br>
+EXTRA_OECONF =3D &quot; \<br>
+&nbsp;&nbsp;&nbsp; --target=3D${RUST_TARGET_SYS} \<br>
+&nbsp;&nbsp;&nbsp; --host=3D${BUILD_SYS} \<br>
+&nbsp;&nbsp;&nbsp; --prefix=3D${prefix} \<br>
+&nbsp;&nbsp;&nbsp; --libdir=3D${libdir} \<br>
+&nbsp;&nbsp;&nbsp; --x-includes=3D${STAGING_INCDIR} \<br>
+&nbsp;&nbsp;&nbsp; --x-libraries=3D${STAGING_LIBDIR} \<br>
+&nbsp;&nbsp;&nbsp; --without-system-icu \<br>
+&nbsp;&nbsp;&nbsp; --disable-tests --disable-strip --disable-optimize \<br=
>
+&nbsp;&nbsp;&nbsp; --disable-jemalloc \<br>
+&nbsp;&nbsp;&nbsp; --with-system-icu \<br>
+&nbsp;&nbsp;&nbsp; ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', &=
quot;--enable-gold&quot;, '--disable-gold', d)} \<br>
+&nbsp;&nbsp;&nbsp; ${JIT} \<br>
+&quot;<br>
diff --git a/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs=
-91_%.bbappend b/dynamic-layers/openembedded-layer/recipes-extended/mozjs/m=
ozjs-91_%.bbappend<br>
new file mode 100644<br>
index 0000000..c0214b0<br>
--- /dev/null<br>
+++ b/dynamic-layers/openembedded-layer/recipes-extended/mozjs/mozjs-91_%.b=
bappend<br>
@@ -0,0 +1,13 @@<br>
+do_configure() {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cd ${B}<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; python3 ${S}/configure.py \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --enable-project=3Djs \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --target=3D${RUST_HOST_SYS} \<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --host=3D${BUILD_SYS} \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --prefix=3D${prefix} \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --libdir=3D${libdir} \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --disable-jemalloc \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --disable-strip \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${JIT} \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${ICU}<br>
+}<br>
--<br>
2.40.0<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#1521): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/1521" id=3D"OWAe71bef87-eb25-4113-25c3-b60a30541f39" clas=
s=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://lists.yoctoproject.org/g/yocto-patches/message/1521</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/112663754/732=
0427" id=3D"OWA8c77fdc5-3079-5681-cc79-c8a581558441" class=3D"OWAAutoLink" =
data-auth=3D"NotApplicable">
https://lists.yoctoproject.org/mt/112663754/7320427</a><br>
Group Owner: yocto-patches+owner@lists.yoctoproject.org<br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/14043740/7320427/1891404428/xyzzy" id=3D"OWA2e530639-d79c-5283-ba07-92bbd=
96489c6" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://lists.yoctoproject.org/g/yocto-patches/leave/14043740/7320427/18914=
04428/xyzzy</a>&nbsp;[soumya.sambu@windriver.com]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
pLK@tY:ATbOf1&quot;dW</div>
</body>
</html>

--_000_CY8PR11MB7921D1FEED911BA634CD53728191ACY8PR11MB7921namp_--

