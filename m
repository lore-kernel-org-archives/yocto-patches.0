Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B126C36008
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 15:15:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.25170.1743002144441838793
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 08:15:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5180e37404=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q6AToj013132;
	Wed, 26 Mar 2025 08:15:39 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hrg44nq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 08:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWGBnorR400GBK31ueWH/kzYZy7Xh7/J6uI5zMus88Fj/MDOCO0FEFcweDqjBFnzmpPk4zyGfobkr0WWppizUvgcfpqzI3xp3L/Iume9oCP2lMob6Dnif1VwI14K9HkGMZgWkp3QkUaFxTLiOLAZ/HFL3J63RPbKGrWob905IhzTe4KolV/LOpbhI+HbwguZbvRZmqUxvEXllbj85cpGBdkzxVBLh+zNtZ018EWEC+4bXcqyNAJY4WuQgwbVL6OEGqaijMheFXaYipNhlATorJRBFNdg9n1HWEFQimGD1q6NgLnakqh9qaamWO2xQLtNCWNxy1w/4Y8qXFo2e2ug4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elqip5NvYWPoklSZGpdNtkVKi5oJ2cXfjqfD76AG8nQ=;
 b=hYjpCEC5PCOFdEsYwTOAsXlnNnaTbRwnAMRarzI6A3Gx/At/SbAjc3wbIG+ZNsDy3A1H7CtBFUgggRUOSZQTTBgYnuBuxdFhg1kJ7wekutGOQ1fofOZJVXAPScq+y4SV4QFVsDZUYif78/Ut1X93TtGZ9uKWGKyl3FWRFMtgNC7R9FgdDpblCY8FNsoEIrpUyVtW5QrZ0QAzVL179ATCM3MlN3fd9WJfmNoLPNHyWcbM7B8mzwQ2DT1lyhipTuL/Fj90zfDH1FZC7jvBiuY1qgA/k6Y6P+Ctt5zjApTZFRKtoTsT1pKdzpWN/UjchXP0kk/0q8QoIvf9SUyz07JjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15)
 by CH3PR11MB7369.namprd11.prod.outlook.com (2603:10b6:610:14d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 15:15:36 +0000
Received: from CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a]) by CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 15:15:36 +0000
From: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
To: Scott Murray <scott.murray@konsulko.com>,
        "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
CC: "MacLeod, Randy" <Randy.MacLeod@windriver.com>,
        "akuster@mvista.com"
	<akuster@mvista.com>,
        "raj.khem@gmail.com" <raj.khem@gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
Thread-Topic: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
Thread-Index: AQHbl7SpLOOrZsFz+k2pVuA77y9NnbODA3QAgAKLCTI=
Date: Wed, 26 Mar 2025 15:15:36 +0000
Message-ID: 
 <CY8PR11MB7921603720483CCF392BC06C81A62@CY8PR11MB7921.namprd11.prod.outlook.com>
References: <20250318032001.2031160-1-soumya.sambu@windriver.com>
 <d8e7feba-e083-300f-a82f-c483162da8e0@konsulko.com>
In-Reply-To: <d8e7feba-e083-300f-a82f-c483162da8e0@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: raj.khem@gmail.com,akuster@mvista.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7921:EE_|CH3PR11MB7369:EE_
x-ms-office365-filtering-correlation-id: 5dd99d02-e448-4262-7320-08dd6c790f7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?Rncr9M1BIe9vMvGD+Lzr0lRNA37EPtGyBI7FugqLLeR0MRcO3Q0HZmsHwu?=
 =?iso-8859-1?Q?gEWifqjQ+kfpBXVOnQYF2ZqZ/DDADRrwPb/pTxsZaDspxF31ZF7gTai09v?=
 =?iso-8859-1?Q?6OWJKEdkDSRl+aMZN2U087RUFIGmgSlJ9zL/pzotnDopfQTWmrsnujfszH?=
 =?iso-8859-1?Q?sQoRInQnc1PSh/3YIZdBaRXGPlO/Isbqq90R9FGP5k67qtPVVHHIcL4Hic?=
 =?iso-8859-1?Q?gvZ/CkhHaQSmQTdZ7ja0lw2Iyvp3YhUdCZd39DasEKxjFuPnhyAbtjbgZO?=
 =?iso-8859-1?Q?qS+K1mNLIK7vK6lsEdukaFiwt8guMvr86BaYXJDBHt7dhNlt7gQLNpiK8L?=
 =?iso-8859-1?Q?4E5/x+Q1lpNO+W5nBt98+NfWOmm05qzi0+p9Tm5AbORJVExM4wBVjxmE/2?=
 =?iso-8859-1?Q?h/9Eb79JwCA3bbNLxUMvrO7T3iTfKchsAm+FSuX/iqeF0IhOWYbl0Bnojr?=
 =?iso-8859-1?Q?PinJa1NnbiMXhWLeFPw8fmr5rfnNrIgvTVYm0G3TTqVYpAc/KEAzccWWBd?=
 =?iso-8859-1?Q?QkuXMGFu3FV2CjrhGK5K5JAe4lEI1IlKnJcTJxvgEvBFouWVYL6iT4IVPI?=
 =?iso-8859-1?Q?qvajt6GLMYbwGxWIYdKy2Wl7+xYXG2+Z4pcl0zX4vcu14uHhIhy/Xc1mb8?=
 =?iso-8859-1?Q?1JTMKJ/F1Zgujn0JAkKJYXvlKzYsfxru0J2jnSSL2a61GwG0yU8ImhsZnM?=
 =?iso-8859-1?Q?9IKPboEaUHPLNidNIsgeK4RKd86N+1b6HUu2+wnsHxxSI8I5lkkYOySXv1?=
 =?iso-8859-1?Q?yIBGgZTBiuyDzD4goXVO8Pwd1LSkv81rqGHkYAuLH9DZkPxvdr9E0Md+j7?=
 =?iso-8859-1?Q?LNVpzrebNbcAnUpzYQfYkRiADFsna6kko08ZOk/PqyBmulOwUSjuhX+iBR?=
 =?iso-8859-1?Q?Db8tzYGRSXOFYpZY6t+ny8mrU3srGwPb4kLpqEnzBL4pumtNhbWdT0bsUc?=
 =?iso-8859-1?Q?4noZxSyBgH4jKnIsQ7gS+SnIC/bISyD8DLtbf6ngV5xJwsOulztCjImDHr?=
 =?iso-8859-1?Q?HR1gVq3z7ShiTD6cJL3OrKMSi4pP38gWX8Fi4+CJ1d5x5lHphBh0KNTKO5?=
 =?iso-8859-1?Q?Cyyx55W55Xba4JkiA+VSnC4yLOKGGzPf0kTtlzHWQdNuhYUsM7OspAo1q6?=
 =?iso-8859-1?Q?v/GVlVm0L3z2Q3Y0Zu6xfK56yo6BLMQADB7+G0r2vaNKsgpxCUL6UFgVMc?=
 =?iso-8859-1?Q?WzAlqxrXi+0PKANBiDbZC1ywV1XBVsFJLSozaWo5bqdhFY+IhzKf2V++Vo?=
 =?iso-8859-1?Q?BuSCXnVuUIIF3Iy41ar0gUAgsCW5DpYqRg+U1Mv+ldvFcSA6oWQsNrQ7T6?=
 =?iso-8859-1?Q?Vib+ZMLq6Mc7q6VKyc5w59bE595gaP3DYV+cOClzwylYzh2V0JaBlwZrjf?=
 =?iso-8859-1?Q?YsKonyrCmjYvtoP8af97aWTc1zKF87Hh+cRW3/PV5Lopj1QN0a8D8SzVAQ?=
 =?iso-8859-1?Q?jkyOuFBy3mciPsZpQP081ovEDPsn/aJt1jmpo+A21CfAf8j4xjy7fFBwl4?=
 =?iso-8859-1?Q?AgCHWkzwE77tVfGYHYcNfV?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7921.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?pijjA/ofYDVqQ6YDjxQC+VBYOXmkYQ9yjyZE4ND/tfjO+248NLx0b9HWzn?=
 =?iso-8859-1?Q?iMt6F38QadoOrCTSFHxCzpScYi+vo0vn9I9iwjvKitwlyd2VQBWvIBhDe1?=
 =?iso-8859-1?Q?BnmMNS3v5fJOlIPK4ksctT3D5NYmCHd3OCNYqI2jZ3PRfazLpKmkhBPusY?=
 =?iso-8859-1?Q?oRL62pr700ew1M1NtBxrL/vLh5hMXf41314Nw3tTJf+6SrrwKg66hYRVAO?=
 =?iso-8859-1?Q?KjHInli0Uw+YbFbU2G8bf3uLui9xjS91egR6Fpb5zDVlpkOg6FfHBl7XgV?=
 =?iso-8859-1?Q?bqSgDXGfCknfHRLey8qXLZbBQcmayYvcWxFQv8hkhnm6QdMnOg+dvs4Cr5?=
 =?iso-8859-1?Q?e8k8mlyjM2IJbZXreInKauzNDqmM9pVbSduMtpEP8JXPIOB2sKHUB+wjFf?=
 =?iso-8859-1?Q?c2atMtO0nS5Q0kulT+7PrQ6AyQesbSLYHnBoouxqSK8MqV/o3Mqf8c+KJ1?=
 =?iso-8859-1?Q?1jEWsWyQjlQAWvO8ThVh/DnPIPnWP3bdXqe+OV8XgBQPJltepZN0Jso3WW?=
 =?iso-8859-1?Q?oufpMQzjCiFDmVYSTuAceLCsFImgjDOmtgAU5gmNNTys1quKWJTWKDLdQl?=
 =?iso-8859-1?Q?5F25R1rvoPOIA+/29Xo5SULViWfqApur8AKyD2RdkUJ0aJIHf7X/2t61ia?=
 =?iso-8859-1?Q?xKlRKf6iiy7mJ5b4ZPes72VVDamnMbUACDUevtGUjsG/8ry8qQdrt+xRtX?=
 =?iso-8859-1?Q?vnC4ytIPftviyT+QgNoUMm0g5hDVouhBQcWpy11Gl8GbyVtRcM4GJU5wUx?=
 =?iso-8859-1?Q?ofnS5nho64xVCummfZVF3x2DyVu34em1lW4gspS2xzS31PCdd+E8xFIhqa?=
 =?iso-8859-1?Q?EFQshZow1oQyGAPvwZZMO/yccmg8NnDugcxJ18ChD3FsHPh/HVQR2uBj6P?=
 =?iso-8859-1?Q?LVIQK6e5tKeloVHC30zMRrGeLgZdn+X+KUxP3aQSMtv3KQjCwdlZIJ+rWT?=
 =?iso-8859-1?Q?j59x2it8Mp1lbQrJKtfLGph6Qwjkp55QaZ9DM0lstg2nAl3cUVH1ndsFnw?=
 =?iso-8859-1?Q?YSUW4ku9ySGf/td0+nMM4o3cGfB9gmQYRaqo0Py7nJR6Yb3ihjz7UJvrHe?=
 =?iso-8859-1?Q?UfJRxYNk2QjzatxKoIE66N1bAvZvIVNyKxZun/XACVgGyIKpuw9OH4d73Q?=
 =?iso-8859-1?Q?sq5AXSFsNjE8M/gd7o99qsYdVIT51NGG5Ra1DEfiMvZr3iW3FiWO+u3e3n?=
 =?iso-8859-1?Q?SPYhmn936t9u99/BndNiMigphqw8+hIn7LdfeKYgjimObpGgpYXdVVe1DU?=
 =?iso-8859-1?Q?R0UiLDr2T7xc8yfaPr9u4aB/vYKmibAqJ+MSr7oYNpBh+L62GE3YBRIdxB?=
 =?iso-8859-1?Q?I5aPneWenGdZUCEPrr9dqkKLS2HqJ/+6QlcwFCDKCFkm6PoKkqZfrNa62/?=
 =?iso-8859-1?Q?oizeW1htwDswv6fVayxiPpX+sP5p7iRmT7K/LuVIXERIUA+RfZ3RfajhXr?=
 =?iso-8859-1?Q?r0uc0UpxviNEGKLrF/Di/umud229fe4NWl9Hlfr7S1TFYhZxqUxooloD6D?=
 =?iso-8859-1?Q?wwN60fymHWnyDchIQYkTEPk1xaC56TF+fJCz2FezJpBZylwcBtauo/+/qA?=
 =?iso-8859-1?Q?wQyWRwlwPwyf3AQRPv/RXPFqPt5Ut4JKd8OPbNl50AOax5NC1Pxp8aDrD8?=
 =?iso-8859-1?Q?JzXTA1OMaVyc+eFdlWFHjsUIywIPlO4fSmnBtnbT09kOTI6y4RHLJDX796?=
 =?iso-8859-1?Q?GqntPSJb1r9yBk2MMs7WYyGN0CyP264cbfuiAmYNRWofmxTzJveqXsGJXN?=
 =?iso-8859-1?Q?I9BA=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_CY8PR11MB7921603720483CCF392BC06C81A62CY8PR11MB7921namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd99d02-e448-4262-7320-08dd6c790f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:15:36.3224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gVWAz/GS96stenlSoNr6gLjngVuY2kzCGtgnRNXt2GEfaKop7LaX10wJFQ1OjTj+omas0I3ELwnL9ICsV/pcT1w2sfRNMg95QQLdPgz4Vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7369
X-Authority-Analysis: v=2.4 cv=HZwUTjE8 c=1 sm=1 tr=0 ts=67e41a1a cx=c_pps a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=pGLkceISAAAA:8 a=fk1lIlRQAAAA:8 a=k-42gJp3AAAA:8 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=UBFVfQAFWYhimOpKR3UA:9 a=wPNLvfGTeEIA:10 a=XqVqj5OBoILfwuAq:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=U75ogvRika4pmaD_UPO0:22
 a=uCSXFHLys93vLW5PjgO_:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 9qEUDjzL4aek4zBSjHKFfkvCDAuKEaB9
X-Proofpoint-ORIG-GUID: 9qEUDjzL4aek4zBSjHKFfkvCDAuKEaB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503260092
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 15:15:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1256

--_000_CY8PR11MB7921603720483CCF392BC06C81A62CY8PR11MB7921namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

That makes sense.
Should we create a mixins layer for meta-openembedded?
So far, we only have mozjs, that needs a bbappend.
@<mailto:raj.khem@gmail.com>Khem Raj, @Armin Kuster<mailto:akuster@mvista.c=
om> - Does that make sense to you?
Regards,
Soumya

________________________________
From: Scott Murray <scott.murray@konsulko.com>
Sent: Tuesday, March 25, 2025 5:34 AM
To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>
Cc: Sambu, Soumya <Soumya.Sambu@windriver.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1] m=
ozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

On Tue, 18 Mar 2025, Soumya via lists.yoctoproject.org wrote:

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

I'm not planning to take this, since carrying bbappends for recipes
outside of oe-core is outside of what I had planned to support with
the mixin.  If I take it, I will be signing up to test building those
recipes on every Rust update for at least the next year, and it would
somewhat open the door for people advocating doing the same for
scarthgap/rust, which has 3 more years to go.

Scott


> ---
>  recipes-devtools/rust/rust_1.81.0.bb       |  3 +++
>  recipes-extended/mozjs/mozjs-78_%.bbappend | 14 ++++++++++++++
>  recipes-extended/mozjs/mozjs-91_%.bbappend | 13 +++++++++++++
>  3 files changed, 30 insertions(+)
>  create mode 100644 recipes-extended/mozjs/mozjs-78_%.bbappend
>  create mode 100644 recipes-extended/mozjs/mozjs-91_%.bbappend
>
> diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust=
/rust_1.81.0.bb
> index cc00053..2d91d68 100644
> --- a/recipes-devtools/rust/rust_1.81.0.bb
> +++ b/recipes-devtools/rust/rust_1.81.0.bb
> @@ -146,6 +146,9 @@ python do_configure() {
>      # harness are debuggable just from logfiles
>      config.set("rust", "verbose-tests", e(True))
>
> +    # Override default linker cc.
> +    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}"=
)))
> +
>      # [build]
>      config.add_section("build")
>      config.set("build", "submodules", e(False))
> diff --git a/recipes-extended/mozjs/mozjs-78_%.bbappend b/recipes-extende=
d/mozjs/mozjs-78_%.bbappend
> new file mode 100644
> index 0000000..8e8c24a
> --- /dev/null
> +++ b/recipes-extended/mozjs/mozjs-78_%.bbappend
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
> diff --git a/recipes-extended/mozjs/mozjs-91_%.bbappend b/recipes-extende=
d/mozjs/mozjs-91_%.bbappend
> new file mode 100644
> index 0000000..c0214b0
> --- /dev/null
> +++ b/recipes-extended/mozjs/mozjs-91_%.bbappend
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
>

--_000_CY8PR11MB7921603720483CCF392BC06C81A62CY8PR11MB7921namp_
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
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
That makes sense.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Should we create a mixins layer for meta-openembedded?<br>
So far, we only have mozjs, that needs a bbappend.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<a href=3D"mailto:raj.khem@gmail.com" id=3D"OWAAM301067" class=3D"tWKOu men=
tion ms-bgc-nlr ms-fcl-b elementToProof" style=3D"margin: 0px; padding-righ=
t: 1px; padding-left: 1px; border-radius: 2px; text-align: left;">@</a>Khem=
 Raj,
<a href=3D"mailto:akuster@mvista.com" id=3D"LPlnkOWAAM576038" class=3D"tWKO=
u mention ms-bgc-nlr ms-fcl-b elementToProof OWAAutoLink" style=3D"margin: =
0px; padding-right: 1px; padding-left: 1px; border-radius: 2px; text-align:=
 left;">
@Armin Kuster</a>&nbsp;- Does that make sense to you?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Soumya</div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Scott =
Murray &lt;scott.murray@konsulko.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, March 25, 2025 5:34 AM<br>
<b>To:</b>&nbsp;yocto-patches@lists.yoctoproject.org &lt;yocto-patches@list=
s.yoctoproject.org&gt;<br>
<b>Cc:</b>&nbsp;Sambu, Soumya &lt;Soumya.Sambu@windriver.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][=
PATCH 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">CAUTION: This email comes from a non Wind R=
iver email account!<br>
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.<br>
<br>
On Tue, 18 Mar 2025, Soumya via lists.yoctoproject.org wrote:<br>
<br>
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
<br>
I'm not planning to take this, since carrying bbappends for recipes<br>
outside of oe-core is outside of what I had planned to support with<br>
the mixin.&nbsp; If I take it, I will be signing up to test building those<=
br>
recipes on every Rust update for at least the next year, and it would<br>
somewhat open the door for people advocating doing the same for<br>
scarthgap/rust, which has 3 more years to go.<br>
<br>
Scott<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp; recipes-devtools/rust/rust_1.81.0.bb&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 3 +++<br>
&gt;&nbsp; recipes-extended/mozjs/mozjs-78_%.bbappend | 14 ++++++++++++++<b=
r>
&gt;&nbsp; recipes-extended/mozjs/mozjs-91_%.bbappend | 13 +++++++++++++<br=
>
&gt;&nbsp; 3 files changed, 30 insertions(+)<br>
&gt;&nbsp; create mode 100644 recipes-extended/mozjs/mozjs-78_%.bbappend<br=
>
&gt;&nbsp; create mode 100644 recipes-extended/mozjs/mozjs-91_%.bbappend<br=
>
&gt;<br>
&gt; diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/r=
ust/rust_1.81.0.bb<br>
&gt; index cc00053..2d91d68 100644<br>
&gt; --- a/recipes-devtools/rust/rust_1.81.0.bb<br>
&gt; +++ b/recipes-devtools/rust/rust_1.81.0.bb<br>
&gt; @@ -146,6 +146,9 @@ python do_configure() {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # harness are debuggable just from logfi=
les<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config.set(&quot;rust&quot;, &quot;verbo=
se-tests&quot;, e(True))<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp; # Override default linker cc.<br>
&gt; +&nbsp;&nbsp;&nbsp; config.set(&quot;rust&quot;, &quot;default-linker&=
quot;, e(d.expand(&quot;${RUST_BUILD_CCLD}&quot;)))<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # [build]<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config.add_section(&quot;build&quot;)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config.set(&quot;build&quot;, &quot;subm=
odules&quot;, e(False))<br>
&gt; diff --git a/recipes-extended/mozjs/mozjs-78_%.bbappend b/recipes-exte=
nded/mozjs/mozjs-78_%.bbappend<br>
&gt; new file mode 100644<br>
&gt; index 0000000..8e8c24a<br>
&gt; --- /dev/null<br>
&gt; +++ b/recipes-extended/mozjs/mozjs-78_%.bbappend<br>
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
&gt; diff --git a/recipes-extended/mozjs/mozjs-91_%.bbappend b/recipes-exte=
nded/mozjs/mozjs-91_%.bbappend<br>
&gt; new file mode 100644<br>
&gt; index 0000000..c0214b0<br>
&gt; --- /dev/null<br>
&gt; +++ b/recipes-extended/mozjs/mozjs-91_%.bbappend<br>
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
&gt;</div>
</body>
</html>

--_000_CY8PR11MB7921603720483CCF392BC06C81A62CY8PR11MB7921namp_--

