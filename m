Return-Path: <wenwfu@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06F1C98302
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 06:57:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1539.1790146657293235669
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Sep 2026 23:57:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=D/O4xdLb;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.168.131, mailfrom: wenwfu@qti.qualcomm.com)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3iIcK3250334;
	Wed, 23 Sep 2026 06:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SgzlORZq8BcaSCls3wNSxeub
	AR0/sfHa2UTPrv+3o0s=; b=D/O4xdLbqXObwfRXu3SHmy2oi+fSA6XhdKX6WrL1
	7Wny3lLgibaA6J5MopWYBG4YJh9SGmxAAhDj4Mq+YwQT5nm2wqR/g9vGACmGGDK/
	d1vASS7cURBLarZkh6JXGRnxiuX8FVCLL+hvbdv7f8Fc6iMhK69jflnZzELhVzj+
	2kOGX1VsnpjB3RCD4O7fyrtBBRHGN3yvni4ZpOxQw0Km2BpALeQWrofAT9KZqRMg
	it981QygAraY7dMStNhHLAiorScI+gHyauNiszS6ZhV5t7A2T0BnqGjMI+wWx2hl
	MUEetYc19QZvKB5Eu8Y/hMOZeMT3VV35rp+DDhHTkEsQdQ==
Received: from dm2pr04cu003.outbound.protection.outlook.com (mail-dm2pr04cu00304.outbound.protection.outlook.com [40.93.13.60])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux8c2y2s-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 06:57:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eF8GNGIoZJAFYIQSawKvLR5774N/rrRzXBeQGl90ItMMpDBcvu7r/M1hCT+pk1FppmH0C1FzPui4wOLxyNwD/Z3xC5yaRLHsbSSqauSa3mkntuhh2b93ddM3XuthVRhl06diHGv3scId0EgYWaG5boA8+fBG7q6v5XzodPOPEqHP5gXshygTJEMHjQGuDqMDr/krXLQrw1Sy7TJryNwqdh/3Cm2Orgre/dHq5ouyJ5JNuEUjnRWoBfg4H03l2CnXBMaHdSbFuxvzH5bQh4LOFJpwwyr1Fm7Nn/fmi7Q7FdC2kJ3K3ka/qS8h5CRY9ifCzOrELjqe1dS1Vu8JIV1Q3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgzlORZq8BcaSCls3wNSxeubAR0/sfHa2UTPrv+3o0s=;
 b=dlsLFku91vfwDq76+kX0fe/+ARyunXN8VQ72hox/DmQb/jPglJlysbN2U6pmCEzA6JdWUqF8Yb1aH10gvD4MKg4BsmKpIdE2TDedV9ApNhiO+q/Mj4lkbDaLpeKvjI0HD44vDYck8KwEFTEhcgY2+guvb8IHMnTZWbjpWDPyXLVbwI23HbV5F6fDcVU3wPr25b+5vpESC8toHOomsA/I7NcHH/3tNHhz+Gf67UKAFgesX0uFSWT0vFHewqFUzqNvqm+bcaYDsRJ1Bed7Nus2Cdr5tQA7cbWXDF/8RgKIOcOZoaye1x4/F0SWqjM3GqMSc9bsRKmgCNd0bJbQRlBJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DS0PR02MB9197.namprd02.prod.outlook.com (2603:10b6:8:13e::9) by
 CH3PR02MB10010.namprd02.prod.outlook.com (2603:10b6:610:19a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 06:57:32 +0000
Received: from DS0PR02MB9197.namprd02.prod.outlook.com
 ([fe80::d5b6:c39c:5293:54f8]) by DS0PR02MB9197.namprd02.prod.outlook.com
 ([fe80::d5b6:c39c:5293:54f8%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 06:57:32 +0000
From: Wenwen Fu <wenwfu@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "joe.macdonald@siemens.com" <joe.macdonald@siemens.com>,
        "yi.zhao@windriver.com" <yi.zhao@windriver.com>
Subject: Re: [meta-selinux][PATCH] refpolicy: allow configuring policy
 booleans
Thread-Topic: [meta-selinux][PATCH] refpolicy: allow configuring policy
 booleans
Thread-Index: AQHdNRcr/HhESJ8q1k6o0dEL70iDXrbb5v0E
Date: Wed, 23 Sep 2026 06:57:31 +0000
Message-ID: 
 <DS0PR02MB9197F027D1010EA2C046C233EA822@DS0PR02MB9197.namprd02.prod.outlook.com>
References: <20260826045540.1390035-1-wenwfu@qti.qualcomm.com>
In-Reply-To: <20260826045540.1390035-1-wenwfu@qti.qualcomm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB9197:EE_|CH3PR02MB10010:EE_
x-ms-office365-filtering-correlation-id: f07d6d79-d4aa-4ffc-3308-08df193ff093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|10067099003|56012099006|22082099003|18002099003|8096899003|13003099007|38070700021;
x-microsoft-antispam-message-info: 
 anxJLhaQG5dBy0IIO3eb9HeKWQDiGXjFNEYAFucYgijPSIHzGI39mGKchEUJr9YUYr6BRag84WT/cy+da0edAA1INlNi3ORRmHl9Qc8KcJ3itbv202IsSxjle4zEZxr4Uuks7tOrMw8L+VKG60zn03MFmV+uuvR8Q443mklxvOL2rC2sPcROdDT7RdFRMqGej/1nqtd+pbOmf/37EULPx6ldGcTXkJEo4Ghmo13kNmO4iTXUw1BWKgXi86M6lSXi0VdNseQgaKNr19H/fpSAgLcmB8+xPuD7W/n8U1nNmifjfkPgcqKLbXnFcXpJZOeBXz0sZnNLj3PXv4uu71TmnRZQm5r/0wthMtFOfG6KrWNCqkkbIyYIy9CnGKeU07Nb8OfRI1J9aY/+TzIoG1hpgTJdPMNQW2cKHMbPaEJDGlKGpzmzeUQdKqeXwkHay/bI3DY4xF/xPs9h3zDxVQPfPDWosDYkRnPDgW8ofB9hXqiKYpV7SoiYLmm6J8IB5lF0omXVLewUUfSt8UnkZblLPpU/Lg/TXMuVyUIwLQyis5+9iCrCdZ9pSFoX1SgPqQZKhgVW7oTW4wsR/6lLIrBuQtFEBbwfzItgodZYQqAV6F73U5mRZqaEHwkVQOf+5hton8szI+4ToODJxsTy/HH3ETf5grkVVCePzSMN/c89yyQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR02MB9197.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(8096899003)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?33a/m12Xh17jrMuRdk/moFLUEq49ZJT933zcu9ULILIITetyQ5mjBmDyJOeN?=
 =?us-ascii?Q?Fx6/t/JrH6FAISaHfybBBDtV+Yb9g/YRSIicWiJvN3bFBdv4PGpMB1UZAK2i?=
 =?us-ascii?Q?4o5EyUVQY/3qykmTwn/fZx09WKa7s+hzAM68cRdD/tenEiOV4n/BxSbIeP69?=
 =?us-ascii?Q?CSg6obV27C0rB/VzUAle7Nf74CJQ7+RJP8PdENEbWGc4eZPW5Z0QIK2dapYe?=
 =?us-ascii?Q?7z0FsyDDJkY+o8Zbb6uj42LpLBAtAwH2emy9s4sUZXm18skrts7kIr7NTlm/?=
 =?us-ascii?Q?SBjKgxlss0cVWjmy/l0f4HOHUIlIwSAKDHVdJjjV7Dg2Flh1M7h49nVd4IWH?=
 =?us-ascii?Q?E+6fczh8XgWYae9z79pHnhVRrmogdFx7OUI1LOzHjvXUbi2Pp4vgq8rNx6o5?=
 =?us-ascii?Q?j5ugx+PRV9CkH1TPkIDYLY8wh4tSNJ637fyJZI2s8bserS3Nad1Hs26YjxoO?=
 =?us-ascii?Q?xk7qNuKa224y4EHJM8pTw0JFFJs5HTGckZn+9dcqn71BWhfDgpLhNBXtcIrj?=
 =?us-ascii?Q?pC+G983Q3MzkzudASD42bwDHUAPCEFAhcldMBi6Tk/YRnF3kibbfXJWhhrYs?=
 =?us-ascii?Q?aZyyi8yHte/VxyRX/5f0K17yPKMCV8vLBniIFGbjF6JK3/gMqiD5E4WvtBf6?=
 =?us-ascii?Q?eGoPbmASWtyUWO+pDsQbTsqRAzK+f8IDItlWWPNmBjUJ19nFToeXdd8G/C8e?=
 =?us-ascii?Q?XmBElBfglvYpDoSvNNv5/w9dnZS8Fd1T2dJdpB8ZY7ybX5X6mMpRhcwBbxXi?=
 =?us-ascii?Q?evzjWxsAcMWmZldwyKIGSo94IkgGxaYpf9/dqndebRWNet33d14IRvF9UPm2?=
 =?us-ascii?Q?kNAtMFAB31U1kINXFZw9d9vGXW/Q+yxEz2LQOdot6ZMbB1m0pCZ5AhmstBLk?=
 =?us-ascii?Q?kROcZkwVlgNhai1SNwi/5+sDVVGap7Ty2RMaWJ65dFZ4+YsxbwfyXFNpAMeY?=
 =?us-ascii?Q?xO7XbYAW9J359S3Ai+BK5o2F5MaZC540xl/1mI/Aezd19a1x5n/oHQThpZRe?=
 =?us-ascii?Q?lJAxevhTgwhlX/BAkQptbNRkBFHsLMP4f7QC0p+dLsjIjq1FTEEsk2SA7Dlx?=
 =?us-ascii?Q?CeuBAEWPkP22YjOkQZwOUwt0d/8H+ZjNjoRS/BFvd16lrDlZNQe/gUarYfv+?=
 =?us-ascii?Q?uXVb9mGyRkMG0EAiV2+SbB4UIEqqxv8xM0EDGkhppHQT7Mkg6UoWiyhugbJy?=
 =?us-ascii?Q?zeiNh4qZrpF3eigX4asj+KKtLEjW6Ve1EHCT6NXpEmn6zSV+vSnpL38nqYxW?=
 =?us-ascii?Q?qhejqMTgmT3LP7PCVt8Hyfpx/KPjuUjv4FNaTBFWwVXLqiakhbE0Gy3Rr6ya?=
 =?us-ascii?Q?COXM2TXToXcsExl2jS+m1nz79JOtfUMuOCSlugTgiMDos3kZaUJgLx00N468?=
 =?us-ascii?Q?vFgZBr78YyMOW7+uS61v5G4psD7fnc32TlW971UHTjbSTisG32tfC+D0+PQi?=
 =?us-ascii?Q?JPLle6lEOXBf2fZHpSh3ym29tCywxAYvBbarTy/BnX9esQE70ykGWct1ZFad?=
 =?us-ascii?Q?ZKxJS48O2sKE7Pyapu1L2K4p2ilm0PhGft+dyZh41Xd3PSG5Kl+ZGX976lzv?=
 =?us-ascii?Q?GUBFW8qrq4mvnTrhpqnFjqAqGo/7d4oiS7BriVM72CZzJKReIvuEfx+DUntt?=
 =?us-ascii?Q?L4hpsIbJh+W0cdgzwQBQN9VtNH5oRkWBsbPHltZdwqLtHOhImNRQllT2kkBh?=
 =?us-ascii?Q?5LE8dYZJJXHlV1CnE344X+0puojGJKI2MXNfwtnQbpUyG5p5htbv7G3my3rR?=
 =?us-ascii?Q?guE1TsWKTQ=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DS0PR02MB9197F027D1010EA2C046C233EA822DS0PR02MB9197namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	vvFTqbr3V10t+Tzc9LGSltf5GPr3/g9KBHx+URgp8cdxs7Pvh/7gtRBLm6vLzy0YwuKWjDAFgfAijhNduIUwdtINYVKj+I/N4JCBEPNrMiQWMC9NY1Eitki512do38HJU0gq2VJ730dFm9VqmzsZ1SeVL53rT8CauZlL+U9HmNtrvvNJvKPVylvuZ9giF/Ml/HgjdxDISnACdNFGWoTCFv9F3JT3/on6O3o4mp7oWgaSJLlUZd4L8BLTXt9pjEi3Dp+29ArZxFJAKByrQyjMl9KzbdaQ1PT23i6J0+geUy3Piz8NTjUTd+auoD0v93OlhyBcYS5353OmRSKWDQLD9Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	olaIx4ThxAf9gyxAY+Fa6wYYDG7RYP+CLUMsmMFii17g7hcZNZNBB7Z7VB3gK2ildqwyjYtfmkVDgb5cRYwcbZ0LJYJBuTqajFhDAFmiRy5N2/01+rwk1vx6Vg7IL0N0IpUYxZhd2CsYk9zUsF4uHZFhVMmtyZ7OsYv+pxFBzP+N8CXzTk+W2gOuuNg0mvixZcsDudLCdCOahW9ci+66bG/VT+v5afDJuu1ZYYfVIbKim3zWr1v1IAcGD6/WPv4mpcqStvng2hH1VNggq+Vjtz9GloEFnGC3IGTy3fYA49bFP94QMxaihK8NE7VNnF4WaPwN08MDNqrxpbn8DxkXA7Jqv2lV+vkge6uop1hIqtFF4jvZHGtRjMthMqBB6AFHsWqAUS9TxNMegYgwHRCpZtrd+JHCDkpQdub2bqUyea7rH5YTpqRpSpliV++d8eXkWaFTFx5nSckL8QCQJtcv8q2qaCqBZhiqBWeC3TEjoxsX4SGypx3nblJGSFBk3Nx0r+88Owo1m5FdCoVmjPY76AZb7f+8fK0q3c0Rho9WmjkLSDCYwED5uJ+iIC3BicuN5RHXmPHvheb5MflHjbmZg/50x3gr2o1X9Oouk0UgdkSS53qcnrInBbxtpyXrAuHn
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB9197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07d6d79-d4aa-4ffc-3308-08df193ff093
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 06:57:31.9380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nyfEryBi9bzzsmT3U1uiMPem/E8BFTtPY4aCYzk9PEUlgU0qYpZ6LjKPVYfcRd5QHDu6nh1ZHpYYnmLTfM0oXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10010
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyNyBTYWx0ZWRfX/EZCVYZNgtzH
 vJ0gNa8E+y4/ryz6mmH3JllRqaqHitNuqrsc4kqHAYLO5sSy46S4jBRfAE3qn5Zp8uGnGCrpxe2
 lU9yeY/HzeyMrb8oR6INTbvOXmLr8VVgBOqiWBwxNgqtNa6JiI8gc+0KAIknsBijQidzhrd9Abj
 glYILA5SdUw/lE+i67VRKluKSL3pr8MoJKyXkC5sZBMj9KEjtM7EdbWdYmqDcLHLMA6EAqOUnb9
 7DC5EqTvMH8bNPrjVVOntaZH8W0n5DTlzuuziSsGjuFNUH7Dcn35fPMHtmsrVSOh3CGZo1lcqtz
 4E3Tg3lp4oe8qqoxgsueQ428GehOSNtv2AY1xV0PrpeOhPKLVCAxlyD+EqSnnLyHDrHTnoW+J5+
 PbVA1bWES5Ty6tFxXID92hfn+MEV83Rz90c8GBrDZCCXhP2dAxYv4HTZ7ai2nlHxgWClArCjomK
 DbxR1cmIMintfDtKjvg==
X-Authority-Analysis: v=2.4 cv=P9evFSAu c=1 sm=1 tr=0 ts=6ab37860 cx=c_pps
 a=uRVskSteZEZgYXEASZgzIg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8 a=a_U1oVfrAAAA:8 a=t7CeM3EgAAAA:8
 a=wZr6MccYu0cVsI8dGnYA:9 a=CjuIK1q_8ugA:10 a=0FWVrUBJk8-LKWBM:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: bel3MMldjKxKbROYtjiDtHQcIXUo_nTQ
X-Proofpoint-GUID: bel3MMldjKxKbROYtjiDtHQcIXUo_nTQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyNyBTYWx0ZWRfX+8T7VaBgVAvn
 9MIMtGxrvBODTT7wh/XCXVoanbD542KBJBohdxiJgRyaC6bhXwYhTZsP9mnej/nuxwdguWIYwEv
 Z06ZKAdWujMAZpuVCivBBWCf/LwQfLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 06:57:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4934

--_000_DS0PR02MB9197F027D1010EA2C046C233EA822DS0PR02MB9197namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on the patch below, submitted on August 26:

https://patchwork.yoctoproject.org/project/yocto/patch/20260826045540.13900=
35-1-wenwfu@qti.qualcomm.com/

It adds POLICY_BOOLEANS to allow layers to configure refpolicy boolean
and tunable defaults at build time.
Please let me know if you have any feedback, or if you would prefer a v2.

Thanks
Wenwen


________________________________
From: Wenwen Fu <wenwfu@qti.qualcomm.com>
Sent: Wednesday, August 26, 2026 12:55
To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>
Cc: joe.macdonald@siemens.com <joe.macdonald@siemens.com>; yi.zhao@windrive=
r.com <yi.zhao@windriver.com>; Wenwen Fu <wenwfu@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] refpolicy: allow configuring policy booleans

Changing boolean or tunable defaults currently requires layers to patch
refpolicy sources. This does not scale when a distribution maintains
several policy-specific settings.

Add POLICY_BOOLEANS as a space-separated list of name=3Dvalue settings.
Apply the settings after generating booleans.conf and fail the build for
invalid entries or names not provided by the selected policy.

Document the new variable in the layer README.

Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
---
 README                                        | 12 ++++++
 .../refpolicy/refpolicy_common.inc            | 37 +++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/README b/README
index ae011f3..4a13669 100644
--- a/README
+++ b/README
@@ -47,6 +47,18 @@ to be tailored for your environment.
 e.g. PREFERRED_PROVIDER_virtual/refpolicy ?=3D "refpolicy-mls"


+Configuring policy booleans and tunables
+----------------------------------------
+Policy boolean and tunable defaults can be changed at build time with the
+POLICY_BOOLEANS variable.  Entries use a space-separated name=3Dvalue form=
at,
+and values must be either true or false.  For example:
+
+POLICY_BOOLEANS =3D "secure_mode=3Dtrue allow_execmem=3Dfalse"
+
+The refpolicy build fails if an entry has an invalid format or names a boo=
lean
+or tunable that is not provided by the selected policy.
+
+
 Using different init manager
 ----------------------------
 By default selinux enabled images coming up with "sysvinit" as init manage=
r,
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-secu=
rity/refpolicy/refpolicy_common.inc
index d241343..f9a55bc 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -117,6 +117,10 @@ POLICY_MLS_SENS ?=3D "16"
 POLICY_MLS_CATS ?=3D "1024"
 POLICY_MCS_CATS ?=3D "1024"

+# Space-separated policy boolean/tunable settings in name=3Dvalue format.
+# Values must be either true or false.
+POLICY_BOOLEANS ?=3D ""
+
 EXTRA_OEMAKE =3D "NAME=3D${POLICY_NAME} \
     TYPE=3D${POLICY_TYPE} \
     DISTRO=3D${POLICY_DISTRO} \
@@ -153,11 +157,44 @@ disable_policy_modules() {
     done
 }

+set_policy_booleans() {
+    for setting in ${POLICY_BOOLEANS}; do
+        name=3D"${setting%%=3D*}"
+        value=3D"${setting#*=3D}"
+
+        if [ "${name}" =3D "${setting}" ]; then
+            bbfatal "Invalid POLICY_BOOLEANS entry: ${setting}"
+        fi
+
+        case "${name}" in
+            ""|*[!A-Za-z0-9_]*)
+                bbfatal "Invalid policy boolean name: ${name}"
+                ;;
+        esac
+
+        case "${value}" in
+            true|false) ;;
+            *)
+                bbfatal "Invalid value for ${name}: ${value}"
+                ;;
+        esac
+
+        if ! grep -q "^${name}[[:space:]]*=3D" \
+                "${S}/policy/booleans.conf"; then
+            bbfatal "Unknown policy boolean or tunable: ${name}"
+        fi
+
+        sed -i "s/^\(${name}[[:space:]]*=3D[[:space:]]*\).*/\1${value}/" \
+            "${S}/policy/booleans.conf"
+    done
+}
+
 do_compile() {
     if [ -f "${WORKDIR}/modules.conf" ] ; then
         cp -f ${WORKDIR}/modules.conf ${S}/policy/modules.conf
     fi
     oe_runmake conf
+    set_policy_booleans
     disable_policy_modules
     oe_runmake policy
 }
--
2.43.0


--_000_DS0PR02MB9197F027D1010EA2C046C233EA822DS0PR02MB9197namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi,&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Gentle ping on the patch below, submitted on August 26:&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<a href=3D"https://patchwork.yoctoproject.org/project/yocto/patch/202608260=
45540.1390035-1-wenwfu@qti.qualcomm.com/">https://patchwork.yoctoproject.or=
g/project/yocto/patch/20260826045540.1390035-1-wenwfu@qti.qualcomm.com/</a>=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
It adds POLICY_BOOLEANS to allow layers to configure refpolicy boolean</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
and tunable defaults at build time.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Please let me know if you have any feedback, or if you would prefer a v2.</=
div>
<pre class=3D"elementToProof"><div class=3D"elementToProof"><div class=3D"e=
lementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFon=
tService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0,=
 0);">Thanks</div><div class=3D"elementToProof" style=3D"font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: rgb(0, 0, 0);">Wenwen</div><div class=3D"elementToP=
roof" style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br=
></div></div></pre>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wenwen Fu &lt;wenwfu@=
qti.qualcomm.com&gt;<br>
<b>Sent:</b> Wednesday, August 26, 2026 12:55<br>
<b>To:</b> yocto-patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoc=
toproject.org&gt;<br>
<b>Cc:</b> joe.macdonald@siemens.com &lt;joe.macdonald@siemens.com&gt;; yi.=
zhao@windriver.com &lt;yi.zhao@windriver.com&gt;; Wenwen Fu &lt;wenwfu@qti.=
qualcomm.com&gt;<br>
<b>Subject:</b> [meta-selinux][PATCH] refpolicy: allow configuring policy b=
ooleans</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Changing boolean or tunable defaults currently req=
uires layers to patch<br>
refpolicy sources. This does not scale when a distribution maintains<br>
several policy-specific settings.<br>
<br>
Add POLICY_BOOLEANS as a space-separated list of name=3Dvalue settings.<br>
Apply the settings after generating booleans.conf and fail the build for<br=
>
invalid entries or names not provided by the selected policy.<br>
<br>
Document the new variable in the layer README.<br>
<br>
Signed-off-by: Wenwen Fu &lt;wenwfu@qti.qualcomm.com&gt;<br>
---<br>
&nbsp;README&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 12 ++++++<br>
&nbsp;.../refpolicy/refpolicy_common.inc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 37 +++++++++++++++++++<br>
&nbsp;2 files changed, 49 insertions(+)<br>
<br>
diff --git a/README b/README<br>
index ae011f3..4a13669 100644<br>
--- a/README<br>
+++ b/README<br>
@@ -47,6 +47,18 @@ to be tailored for your environment.<br>
&nbsp;e.g. PREFERRED_PROVIDER_virtual/refpolicy ?=3D &quot;refpolicy-mls&qu=
ot;<br>
&nbsp;<br>
&nbsp;<br>
+Configuring policy booleans and tunables<br>
+----------------------------------------<br>
+Policy boolean and tunable defaults can be changed at build time with the<=
br>
+POLICY_BOOLEANS variable.&nbsp; Entries use a space-separated name=3Dvalue=
 format,<br>
+and values must be either true or false.&nbsp; For example:<br>
+<br>
+POLICY_BOOLEANS =3D &quot;secure_mode=3Dtrue allow_execmem=3Dfalse&quot;<b=
r>
+<br>
+The refpolicy build fails if an entry has an invalid format or names a boo=
lean<br>
+or tunable that is not provided by the selected policy.<br>
+<br>
+<br>
&nbsp;Using different init manager<br>
&nbsp;----------------------------<br>
&nbsp;By default selinux enabled images coming up with &quot;sysvinit&quot;=
 as init manager,<br>
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-secu=
rity/refpolicy/refpolicy_common.inc<br>
index d241343..f9a55bc 100644<br>
--- a/recipes-security/refpolicy/refpolicy_common.inc<br>
+++ b/recipes-security/refpolicy/refpolicy_common.inc<br>
@@ -117,6 +117,10 @@ POLICY_MLS_SENS ?=3D &quot;16&quot;<br>
&nbsp;POLICY_MLS_CATS ?=3D &quot;1024&quot;<br>
&nbsp;POLICY_MCS_CATS ?=3D &quot;1024&quot;<br>
&nbsp;<br>
+# Space-separated policy boolean/tunable settings in name=3Dvalue format.<=
br>
+# Values must be either true or false.<br>
+POLICY_BOOLEANS ?=3D &quot;&quot;<br>
+<br>
&nbsp;EXTRA_OEMAKE =3D &quot;NAME=3D${POLICY_NAME} \<br>
&nbsp;&nbsp;&nbsp;&nbsp; TYPE=3D${POLICY_TYPE} \<br>
&nbsp;&nbsp;&nbsp;&nbsp; DISTRO=3D${POLICY_DISTRO} \<br>
@@ -153,11 +157,44 @@ disable_policy_modules() {<br>
&nbsp;&nbsp;&nbsp;&nbsp; done<br>
&nbsp;}<br>
&nbsp;<br>
+set_policy_booleans() {<br>
+&nbsp;&nbsp;&nbsp; for setting in ${POLICY_BOOLEANS}; do<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name=3D&quot;${setting%%=3D*}&q=
uot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value=3D&quot;${setting#*=3D}&q=
uot;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ &quot;${name}&quot; =3D &q=
uot;${setting}&quot; ]; then<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bbfatal=
 &quot;Invalid POLICY_BOOLEANS entry: ${setting}&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case &quot;${name}&quot; in<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&=
quot;|*[!A-Za-z0-9_]*)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bbfatal &quot;Invalid policy boolean name: ${name}&quot;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; esac<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case &quot;${value}&quot; in<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true|fa=
lse) ;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bbfatal &quot;Invalid value for ${name}: ${value}&quot;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; esac<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ! grep -q &quot;^${name}[[:s=
pace:]]*=3D&quot; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &quot;${S}/policy/booleans.conf&quot;; then<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bbfatal=
 &quot;Unknown policy boolean or tunable: ${name}&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sed -i &quot;s/^\(${name}[[:spa=
ce:]]*=3D[[:space:]]*\).*/\1${value}/&quot; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;$=
{S}/policy/booleans.conf&quot;<br>
+&nbsp;&nbsp;&nbsp; done<br>
+}<br>
+<br>
&nbsp;do_compile() {<br>
&nbsp;&nbsp;&nbsp;&nbsp; if [ -f &quot;${WORKDIR}/modules.conf&quot; ] ; th=
en<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp -f ${WORKDIR}/modules.c=
onf ${S}/policy/modules.conf<br>
&nbsp;&nbsp;&nbsp;&nbsp; fi<br>
&nbsp;&nbsp;&nbsp;&nbsp; oe_runmake conf<br>
+&nbsp;&nbsp;&nbsp; set_policy_booleans<br>
&nbsp;&nbsp;&nbsp;&nbsp; disable_policy_modules<br>
&nbsp;&nbsp;&nbsp;&nbsp; oe_runmake policy<br>
&nbsp;}<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR02MB9197F027D1010EA2C046C233EA822DS0PR02MB9197namp_--

