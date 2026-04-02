Return-Path: <gmisra@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C41CC6B03
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 07:03:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10315.1775113428681450847
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 00:03:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=GWOU5L4E;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: gmisra@qti.qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6326mD6c2798761
	for <yocto-patches@lists.yoctoproject.org>; Thu, 2 Apr 2026 07:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=nMV2hbsq8iQ8S9qto9alPtDOp36f6AYDGEdL0rnL25E=; b=GW
	OU5L4EBuFL5TjA3fX4yNZsgidXb+lGPpzfRAAC5DvCTBBavAaWs9YNQM1tbcuT7d
	dmpftUUU1I+c42t8RQ99W5yXkZP0L/Sr9jKSoBOazg43U3CvbSfdiKKV6lkKoQou
	cCg0s8hTLF68mXCbkTyggQbj886CHMOKiOrTCj7iaqSAtpVNeftT+z2l0vyFSK9v
	jCtrPTi4O8z1mAt9M8jXp/nFCxJNBtqa77eJJVpS/77CdaYWDlw5+76HtrR8mAQy
	i9G+32qvg4WwlA6qIYAPDlsK3zuXUSwMNQ95CtG9G+VvL4LcBOR7GFrcRuvRUnnk
	6zQrZeCP6rEDl25IizTQ==
Received: from dm2pr04cu003.outbound.protection.outlook.com (mail-dm2pr04cu00301.outbound.protection.outlook.com [40.93.13.57])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d96hk2sgh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 07:03:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz/GNuwlQZXMFGzAvgOIXhu5Yl7+PzJeIhT11z1iGVJn7/2Z25lyVPc53xarBHsHBo2/AA7I35tANl1qmftwOkvcWFw8aM157P4nnCkF1T9d4YfdPDAyfEryr+QEKTreD8m6FdGZZLanyt9tRKIJaieND19omxwmODnUvjmT82A/g5C8tqjvIj5OlNkNKxJQw+JXsiAUL7t1J09F4f/7bKT/507UjxWth2GoPf4atMRIFEx3gvo+tApfpcTs1b0Mn6uOC4ItvYOBZ/mBS5widBaoouvZMeuHd7/Vd6hVMPCITEj8FHnqw+TxoaYAtEDrDYMjxt6oL5F8+jmjaLlPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMV2hbsq8iQ8S9qto9alPtDOp36f6AYDGEdL0rnL25E=;
 b=tI0oWOj0dSnkPZKdJ5KDXBecM5Rz6jPmsDa4ZSidm/Jq4FIbMzYyAcNfH9lwq+W6gQugd5tn607Reas/tdFlSeQk2s9TW7QPfDDsBjIpRxMVzyClRWdZz2Cth+agZON3JwXSTHmsigZKiNfuylvwZAOaKlTQ4PRFrs+f1GMDbhS0qqKLizj13beFLBhYBI8h0xzC1gEyaLsHoRtTcR7D2DqkWc3k8M7w46XsEPyK5gAPjcZGmHT7FTOmZzhmk9du/fAg225AGOvKME78XHRdVn55MFhj7qrBM9iiW9hsi7KiV99jKPxumLdKzmISr8EYw8Ts/HNjqEehklKyceTfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA3PR02MB11199.namprd02.prod.outlook.com
 (2603:10b6:208:542::12) by PH0PR02MB11318.namprd02.prod.outlook.com
 (2603:10b6:510:38f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 07:03:44 +0000
Received: from IA3PR02MB11199.namprd02.prod.outlook.com
 ([fe80::d20f:d3d6:cceb:337d]) by IA3PR02MB11199.namprd02.prod.outlook.com
 ([fe80::d20f:d3d6:cceb:337d%6]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 07:03:44 +0000
From: Gargi Misra <gmisra@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: [meta-selinux][PATCH 4/5] refpolicy: Added policy for modprob to read
 blacklist-video.conf lnk_file
Thread-Topic: [meta-selinux][PATCH 4/5] refpolicy: Added policy for modprob to
 read blacklist-video.conf lnk_file
Thread-Index: AdzCbsJH+/vXbT5JQdyjwFlA1F8gxg==
Date: Thu, 2 Apr 2026 07:03:44 +0000
Message-ID: 
 <IA3PR02MB11199A73D31A8C41023F0CC25F151A@IA3PR02MB11199.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR02MB11199:EE_|PH0PR02MB11318:EE_
x-ms-office365-filtering-correlation-id: 9df6d9fa-9cfc-41c5-3176-08de9085fab8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|8096899003|56012099003|18002099003;
x-microsoft-antispam-message-info: 
 O560LODjPY3EaHGcF4Tm1FB/hK+VZq/HGJy9LD9ueQJLLeId8pGByHNhVzEwfnET/FVukDAVAB3l9eexTvpS6iaglRFbV1grAXLfMsTUAj1U/Ctn31uFt7SNGfT7e+Ef0BsraQtFPgg7gPdpISC2Lt0HybcueaOMIs85u1glM1t+t0MoShVGZvKd97IJ7srNOqW3nJQLEVic6dWiCxMcH6uFV1BP+C+7OJgPmFuvRp+6UG43cismoSnFUcaOa9wsqdWdYIEc3kAXvTXBY47JiEsmhQx8Ou9JrxGTr4OkQFtXoUVpAiQVubE1tKoS5Di9m86FOI/amEc7RmZvU6Nn+BJXNRLcWcHOTvxjdc6BiQ2cAL051H9QPT6LpaYzoTDEZ/esr2fRNLJOT6AiUYcatZhgNDfe3qt4JdBfdtPpsHnDhisB21Kr1UCYeFtIhxB3HKxVpHde7sdh56keOKWEISOLPa9BjFCWTGs+gurX21aGL0cEnlOM++SEdWIIHXuiWII0bJ6i2hePkzirLcGrRebDoBHPUpRQHH82kN8opLS5gKmuuzlIBjlBFCAARtMctFp+tnGkQ2eZJ2rj1qqrG/0D3jtJccaaRvY7sevUHhlTEclPFhGJ3XvY7VaHnDySBAwuBGh7NjgkInCXjEZemVEo4IdXsugEoLUIuDNzZfUNTvP84nZiXdBtL5weWjVlRRNdBTG9NmKa35aEPQXYHZprKXgsGrIGHNhE2n9Wdr+hUitcAaGN/HE2V6XKtXjC
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR02MB11199.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?AnTUbfYn6HFc2wB3Qbr32RPsapwKrNrsFYATaF+JbAZYBWY0T1f5GaDfWBT+?=
 =?us-ascii?Q?IoYW9emVAQR0Fpm7e3vAZhsrBH2EtC/SDZ29FiyBX4/Q/L4F7KDnGIYzBcx1?=
 =?us-ascii?Q?Rgur7hdAekWpbwvhwuPCSvBHGOlkSW8kCYg36JAyfL26f27bzY1edRBT90Dq?=
 =?us-ascii?Q?kQGuudaXMwkMP0JlRN9EAEsjs/mxTeOGe1Q4tik3CshjiVY/LcOuCU7rHNsQ?=
 =?us-ascii?Q?0xP/arcSgvmg4dFPrp0+wiV9pJCSzI5x+52pXst6IyUuCIfZ3hRNF0EXrlOL?=
 =?us-ascii?Q?OJ/pLZyo+hbZ+39ioWqnVBdCvV7XUHOLxEPE1gZkT4/lBQ3/WQaZXmAFovvJ?=
 =?us-ascii?Q?fruAVirEJa8wp+TUc/Bjpje6pozneoEI4aBUZyptuhgTiA918jPMDQIbD+cD?=
 =?us-ascii?Q?HDSj56xlpXBfgFw+mtWmPpfq2yJshoeTb4T9eTG+NtTDu2kpCNOCDMWFDX4n?=
 =?us-ascii?Q?DblYJ7STaxetaX/j046sFpieONuvM4bYgcIpMbYjbYTimpuwYD/U63rX+6xc?=
 =?us-ascii?Q?mdsxMznEw37PjAwmZEcIAq8ymWHOlEJGCoJT+KaysRjwzS+awAEBMhkS8MZD?=
 =?us-ascii?Q?WHfuPw/2LKOfiA+10Pd6w9ADdIEsrH0V+XK9DvhMTP3ApbM4qc3XkDOmLIzo?=
 =?us-ascii?Q?fSANzyQTOMGT9EuQ2n3ktzYvdol0MqrvgHWVqAddwVZVKsvgHSgvQTveXs4I?=
 =?us-ascii?Q?bcrxwMSa+9M6c3EjsK/VUVarICmR03YW9MRP1Z8/rWGplWLw+ZPMnt+4F6ox?=
 =?us-ascii?Q?DYq+trQ+LQQTbjjyUdEW8sOdtNPqHmTkI2LOsOgo72MXEIV9jC+23eSjnlIM?=
 =?us-ascii?Q?MwMP65hf2kKLxfJipOkxqZ6V+3YmKevh9NK+9ak4OmtlavUTum0ZBGNVXgzu?=
 =?us-ascii?Q?j+elte1q1c+Z8nQ3H9ZS0TVjFxGlA0qzqEjZJJiwCh+JT4hZ2LQilIphnlm+?=
 =?us-ascii?Q?yVelQ+aQ99hTb2pV/PHlAA2s8B3u2jEpJr4c9TV1ZcA3jPxHskxzXFjRZyZs?=
 =?us-ascii?Q?NLsQnf9FpCpOzGPxEXLwH6zfEsrJqTR9MtLQPZnGHypnrzd2/rdIq1A15k3o?=
 =?us-ascii?Q?bdLBmbGllaXQUCwIlr7wIRphS6t1RD0NdpQ6GRRrt06pS6eWbR8c3bj1wCXM?=
 =?us-ascii?Q?/qhJJoQ3pds8rGAvAYh5jvHm6iP+X+u4S43dq5TyOwC9TvroafmXhB7VjPQg?=
 =?us-ascii?Q?h+28UhjujwoZe3A9v0E/5nFb9N/PCPgguMKzIn9U+45JPmZhjbjeO/2lLO0K?=
 =?us-ascii?Q?lzhtdd2fWG7QEyvN5HkRlPfUUw4I8aSIMaON/u7SyZIffpRBC2iYzTZONqWv?=
 =?us-ascii?Q?3PNtjxXXCi+QLoAvGYoQbcq+3V+zCtU7/mM0x684yAKkEMaHiVEYZncWAazZ?=
 =?us-ascii?Q?x/Lc7ve//uLptmUDDRf5tcZhrbXVgzGenhICz1j25IV6nzwvnWlIxjoi+KmZ?=
 =?us-ascii?Q?UMH8IjsjS1X4ykIu+43nEvDbovRFigClct3iqq4FsLeBtB1TuEdKO6Lh0CMb?=
 =?us-ascii?Q?XoXvQScUNKQvhB7cI1+zCAx7XjB95mb2lrSwkw0tl+pZxrYJm32mGGvmelvg?=
 =?us-ascii?Q?nipS8GgVsYGsoDPnsEjDXkUvD8lwyQGoTStmJhl3YE/F6dVU8O67zcehfWon?=
 =?us-ascii?Q?SfkbwuftRTtgSmHCeiLguBoVc2TQx3GgVIYuOEinEZn6oCAdUNE8wkO8YRIR?=
 =?us-ascii?Q?JqvSS0juJKOWNjmzezJOFwzjc5gPX3/lzHpag2bzkAiQusFS4iwnsITLgjb4?=
 =?us-ascii?Q?+MYJSC/Hpw=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_IA3PR02MB11199A73D31A8C41023F0CC25F151AIA3PR02MB11199na_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Pb1qWk/KkF7qGUUnx5I6joJ2VY1yi4eVHo5w67u3tphLuIwa0K5+ScD6O0DBx9ZKAIQ8mqcipvjXLHQ8lnKdR3V6cX/RhLZhLZAOTqzVCSBVS3ximFGt1eLqHJSQ8urEMNb6iqKnOCUM76Suufqd9x5dqv4ywOv8EPdpS8Cvpb57Jloiym3pXq6ELx6iuBdVKxHy6KeWgKyhnKqbfINIKgnoqhHcUGxY6HWb2Fv2pi1/a0Ka3ULDZyCDiUzLtI9zDt/AqbefENIp+7LnalhWI5gVU32kJB1cyPrjSMFQi4LpeIDS2siFeCTsD2iIcsXBseIcL6NZCYIcphopYYcaKA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vd/HyDBl+FBLr7FqJGE9SMruRPJtp0iHw+MSEPpfBYcj1BLLw8OOsTOgFILEHl61tmGy68+puR6bthn+TKthIPI+c/y4Sx8AHcly6F95NWTWsrX8apcAGS7o9zcudJeOZrd+CMIBujLBJp25vifF0mbN7BhCWyD7AgbAGjWCA0ZclAkP7rOJdJXWeu2yg3uPyixZQoEQEkCGhuys7SSzi9vkbMQJaejdWMzwCFdDKwWURNh5f/RSvUsDNi/DA9bbfXPZ8aOUfGEX0tGCcC0NS8qIPUk2/z3UFnhKmhjdinUldSEEwQGRpTaBFt6yfMqTKTd0a0RK6lhefflgtMSjQ9RRFz2yI5xO4rKN2Jz+ipjBgdHssPpRpIL9FIK6C9FybCuyeR0wrOV9pOdbE6bV2tUK60c33kY6SUJUzK4BJUHzRNiP1OfrhzfzAsxlYjeXx3wUfgsRk1iNw7v4gjgMO6KAJJV4AtrtSa6G9KqCvdWyRa2gt5uFjh1QrXx8uDjMQe0z/ekDCzdAvigH7TSGMfLalDBS5c8+oN/GqX4eHY6NuOWoypx3W1B9lYxF6wTe2e98t/PXehInYhnW3j1sIi1bgsMHWYxiPuAHEIxrtjeqxlkDKVGsrBVeSJ2E0YJU
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR02MB11199.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df6d9fa-9cfc-41c5-3176-08de9085fab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 07:03:44.4166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AeITOQ/hZbHpUqevttiySIwYpz6RxwJo8pSy0R0jFt5DtZWN7EvdTCxsO3WXAF+r3cMwy+r6K3SPH85qBifcZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB11318
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2MSBTYWx0ZWRfX8kx6CsDcuqqg
 DX0IsiLL/4k7/5DW8NIIsHwKYQNUglgSBd+AQTs9vm5mbgCYP5beFvJRiR+4K7qPhmnZkm8ycWt
 3lUn/iPhPgD2ky1AR7+whmYcamnC046HXHan5HSnY5MU3+qGGPlQLspMnPCaZi6XIKZ/3mWxLkr
 ETpyks2cr4gjUxM8c5UWIanZLvLDRbeZA7osjZ53vy9Sxy8c9UdgPmOVXcEHauebzWm1wZKLmK1
 nv1z78ToXB3NrsU8V3ppD9xjqCC98kra++V8GRChw7OF2hjKsh7mRsAJLllBLHIV1QGB9E+LJrG
 0OtP9IY+j8f3u+nArwfoWDEW8skSo4VwzBPQaEzIOGBUSEFYPRX+PigErDAD35bCvgWp+b1lUao
 Qka4WAsNFvWEvwQWPdqnrhHYqN58URT/cVuNDpKHsVjJ9PmeY1KNYW7P4YkEHSps46gTEGJxtN8
 R/mJWY2sc+GiM11Oogg==
X-Proofpoint-GUID: 0Un5oISU79c0TIaIfy4wMvdkUD303-4X
X-Proofpoint-ORIG-GUID: 0Un5oISU79c0TIaIfy4wMvdkUD303-4X
X-Authority-Analysis: v=2.4 cv=e9ULiKp/ c=1 sm=1 tr=0 ts=69ce14d3 cx=c_pps
 a=y3Q9mg33rxtftU4vhVNh8Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=oK2_imTTR0HNk6CiXMEA:9 a=CjuIK1q_8ugA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=n6xKDSJxxDTCZPJOP1AA:9
 a=JkReuXt4R72UMrVb:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020061
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 07:03:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3608

--_000_IA3PR02MB11199A73D31A8C41023F0CC25F151AIA3PR02MB11199na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

refpolicy: Added policy for modprob to read blacklist-video.conf lnk_file

avc:  denied  { read } for  pid=3D774 comm=3D"modprobe" name=3D"blacklist-v=
ideo.conf" dev=3D"sda2" ino=3D342 scontext=3Dsystem_u:system_r:kmod_t:s0 tc=
ontext=3Dsystem_u:object_r:modules_conf_t:s0 tclass=3Dlnk_file permissive=
=3D1

Upstream-Status: Backport [refpolicy: Added policy for modprob to read blac=
klist-video.conf lnk_... * SELinuxProject/refpolicy@aa35084<https://github.=
com/SELinuxProject/refpolicy/commit/aa350841e9dcaa525c0f8716c2854ca9dd72896=
1>]

Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
---
policy/modules/system/modutils.te | 1 +
1 file changed, 1 insertion(+)

diff --git a/policy/modules/system/modutils.te b/policy/modules/system/modu=
tils.te
index 7355255e0d..fa06e9ec37 100644
--- a/policy/modules/system/modutils.te
+++ b/policy/modules/system/modutils.te
@@ -45,6 +45,7 @@ allow kmod_t self:key write;
# Read module config and dependency information
list_dirs_pattern(kmod_t, modules_conf_t, modules_conf_t)
read_files_pattern(kmod_t, modules_conf_t, modules_conf_t)
+read_lnk_files_pattern(kmod_t, modules_conf_t, modules_conf_t)
allow kmod_t modules_dep_t:file map;
list_dirs_pattern(kmod_t, modules_dep_t, modules_dep_t)
manage_files_pattern(kmod_t, modules_dep_t, modules_dep_t)


--_000_IA3PR02MB11199A73D31A8C41023F0CC25F151AIA3PR02MB11199na_
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
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">refpolicy: Added po=
licy for modprob to read blacklist-video.conf lnk_file<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">avc:&nbsp; denied&n=
bsp; { read } for&nbsp; pid=3D774 comm=3D&quot;modprobe&quot; name=3D&quot;=
blacklist-video.conf&quot; dev=3D&quot;sda2&quot; ino=3D342 scontext=3Dsyst=
em_u:system_r:kmod_t:s0 tcontext=3Dsystem_u:object_r:modules_conf_t:s0 tcla=
ss=3Dlnk_file permissive=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Upstream-Status: Ba=
ckport [<a href=3D"https://github.com/SELinuxProject/refpolicy/commit/aa350=
841e9dcaa525c0f8716c2854ca9dd728961">refpolicy: Added policy for modprob to=
 read blacklist-video.conf lnk_&#8230; &middot; SELinuxProject/refpolicy@aa=
35084</a>]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Signed-off-by: Garg=
i Misra &lt;gmisra@qti.qualcomm.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">---<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">policy/modules/syst=
em/modutils.te | 1 +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">1 file changed, 1 i=
nsertion(+)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/policy=
/modules/system/modutils.te b/policy/modules/system/modutils.te<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 7355255e0d..f=
a06e9ec37 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/policy/module=
s/system/modutils.te<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/policy/module=
s/system/modutils.te<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -45,6 +45,7 @@ a=
llow kmod_t self:key write;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"># Read module confi=
g and dependency information<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">list_dirs_pattern(k=
mod_t, modules_conf_t, modules_conf_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">read_files_pattern(=
kmod_t, modules_conf_t, modules_conf_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+read_lnk_files_pat=
tern(kmod_t, modules_conf_t, modules_conf_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">allow kmod_t module=
s_dep_t:file map;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">list_dirs_pattern(k=
mod_t, modules_dep_t, modules_dep_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">manage_files_patter=
n(kmod_t, modules_dep_t, modules_dep_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
</body>
</html>

--_000_IA3PR02MB11199A73D31A8C41023F0CC25F151AIA3PR02MB11199na_--

