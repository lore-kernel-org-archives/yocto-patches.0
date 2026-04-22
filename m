Return-Path: <Jiaying.Song.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A368F94CBC
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 01:48:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.62076.1776822507323968202
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Apr 2026 18:48:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=RctWV00A;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85727c45e6=jiaying.song.cn@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M0ZCJ1424428
	for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 01:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=ERbus6dBRAK+siNgKjskLGqmfH80v56Oqp8cODzXbKc=; b=RctWV00AwbbC
	roMXh+UO0FuSJg67EzC1vIBE96zRIJLfLeWTbSjYyZvBXKdqCWOPPNQWfGvb3fhK
	g9gygOaIpc2srMSLLZNyLGq7BR5TxFpZMEKChg3DU+LleeF4estLEPGAbo7JF8K2
	kFcnZFBUe+ddya7is7CVwG3X54PzmaYYWBKe+YGmpkAaAAcvz9wJGXWsnnVxsvzc
	RVK2GG4e9P1Djiz2hshGnLfjyT6F2I6TuKolNRDn9/DaYGmMEwku9wYKoX1dZR91
	R55fdDPyWlFvHa+QZhr+RTxzBrrJRSCytQf0G0XQm+fuu6hqe/5u3av6keLaoWbD
	bSZYZUxFAA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013004.outbound.protection.outlook.com [40.93.196.4])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dpenv8b1f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 01:48:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvNcUPYpLiJ9pzkH4XbnpLGj201DhSdT8gQ0+R8tGvVuNkmQ0sY7HnbGcsrl+6EuiV3WsZpkjvWFPEU/PYa44CIAil6WFS/9d3XrlVJ0WRLIQ4/nzccFXQI62yFOWLQ+/jpOF+YHJCWs+4TThZTZEsZ2jhSI2iCsCBkfrh0yXJHTGs1DbqY30jWAWEfYzPi3fFOtTlDojy9AY0lOCqF0D/iYtjMeGK1m38OSUgxPDTwDpCTVoTqFrkkaL4jc8ApfwUzJONpbHgdnQv9VBtYFiaCil/gkMmI+OEhVJ+urpTqKjxQjAdLQBVHZpyqG/dW5UiQIvZ3YtysVVd8tZZB8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERbus6dBRAK+siNgKjskLGqmfH80v56Oqp8cODzXbKc=;
 b=lJtUd32E22HugVqdq2AhoLQYMHOefLxbTCO1juhuGC5b6Y78siWGnwfC2JIqOWUkrWKq4AnTkqeLLV83JBXbyzmpVUZcWpgHdM8BOyJF8wJxdp4vmZSbxmJFKJhwDWfEns6Dw5Rh7o+ZjAIfrabfr81bliZ2bXRJlzzgnGJamgvl1Gv5QBQknRq206bkVtN6px/OctMJCoho+CTV6Iq9EGj7shw+F4yfui8fZhF6M4hdexZvOIdl5iqpN9qLFLx4y2OUR+ukixWPZ0Xkioi2ODrvO+Q4tEM3TZ0HglNI984anKdpF6Ko33GO0psVEyiZBBfnuS74QtscTZL0fynbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA4PR11MB9420.namprd11.prod.outlook.com (2603:10b6:208:563::13)
 by DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 01:48:21 +0000
Received: from IA4PR11MB9420.namprd11.prod.outlook.com
 ([fe80::e716:bbea:7a00:2c30]) by IA4PR11MB9420.namprd11.prod.outlook.com
 ([fe80::e716:bbea:7a00:2c30%5]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 01:48:21 +0000
From: "Song, Jiaying (CN)" <Jiaying.Song.CN@windriver.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-security][PATCH] crowdsec: Fix recipe to
 match upstream source layout
Thread-Topic: [yocto-patches] [meta-security][PATCH] crowdsec: Fix recipe to
 match upstream source layout
Thread-Index: AQHczKSMMY/wNMOd6U6zo+c44dRDa7XqWsGg
Date: Wed, 22 Apr 2026 01:48:21 +0000
Message-ID: 
 <IA4PR11MB94205D035B1B00B9B862B221B82D2@IA4PR11MB9420.namprd11.prod.outlook.com>
References: <18A675399E9F3E23.1455959@lists.yoctoproject.org>
In-Reply-To: <18A675399E9F3E23.1455959@lists.yoctoproject.org>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=0c81aa93-0e64-479f-abde-2026855e269c;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-04-22T01:47:47Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9420:EE_|DS0PR11MB8018:EE_
x-ms-office365-filtering-correlation-id: eaf74ac9-59d2-4ede-9458-08dea0113bf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|4022899009|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 
 TUxyGXgYuX4boXqlA3JmMw3Ac7qbzC5ov3EOVsK4qOu/3iDwzKBf/pDGOgCd5+IrKAp6Yw6yt+mB2/lC5W4RJ5y6v61F1mWk9ymDI2ZXTh6VoTW/W302ieuQdr2rP6VbscPuuRMXVKaw0gM5fsjXy/OOp0KdZdSncXmJ3AMi4Par+hioIelR3XZknZZr/c0m/qN+50C/z+DdgR9NqmNGsxDOThg69Aa3t4HQ8y855SDmhn/lmc4myBl5pr+ooIxsGGxOcEpTcpVMgzUSPgOPAbawvhClArfC2D/+joJ+hzAXDDiXVqR7yG+LL1GBR5fKdThSp7mwSf5o2DAYD85CchdwQciTo+vff9cO89VtW8wDdLLQk/Ku0RioWniUp9oJlzDSA5+oHSLa+Vx+1HrQI62IdRpaO2/qiO6iU3fUaxRN9DCbaHbgXnhOf7WaAHSMXwz1kr/veqba8md3FmUnQ0nupR25dlV9IdaRuKevLE0wcHnUY9NUQag9gOYB/icsMztIFbPtFRlHRnlS8mL+MvfB3g8AgGInker2ZxCjYDRXWiHMK1U3Ts6C4wNm6X+gEz61516WTb2Ckeo6JIuwCjDwkoOAyP9pDN3UEtfhCLtYhMyRQT0OVmxFXPhOuVysWbF3x0kmnmjQ0fEsQd4/7DbFCxlyDeLv0qghEVFUNYWahpOgMFBt8aHb1wrbqZpUQbwouoPZ0hgB2RR4+DhfYsRKxrLulpcWnjOKLGNxVx9uzn2deMjalzK5qDnky0ZH
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR11MB9420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?m3oCvsl4RvH9fSHj8p3FM5D9f5lWMYalLxH5VnfLQ8Rovh5MyyX0znqocyw7?=
 =?us-ascii?Q?Ho0y4QO6ge+n5HiuP8Jn7MESscLrrlc7MQVoRKan/yOWFQ1EBfvzYKPq4Q/l?=
 =?us-ascii?Q?lZ9rMDVk1o5EF/1eO1NgQsBF2q5c5kkltqHiBKzONwg9V8B7MLVGJk6IyyjO?=
 =?us-ascii?Q?rdZ1goTjOVuni1aICYXbjmQMyQOtWAj87GdfJlUD4yymb0n1aVfZjVrTz5XM?=
 =?us-ascii?Q?ylp3m8pRRHyoDSO4hFfbT+AwVWCyNgjOo1Fu3alV8bdjlQozK17OaXqm5zND?=
 =?us-ascii?Q?I6o2TiIiuWWBReQTyNwe9R872Oj2bStBkNPkuIgBq4ph8pHA81SmAj5+Uy8P?=
 =?us-ascii?Q?XI/DbBy5UdFPk0jigEDo5eck79s9KWUgA2jGWoDWc+A6jFyhC5IZNM+ys+rj?=
 =?us-ascii?Q?3NrpSIVDZjHYmrZxSOwcksdXzwGU0f4GD/gT0EJVYYF5Ad/HF7qJIlSorqyk?=
 =?us-ascii?Q?bkJKDsM5AMFKF6/JvB5m+0xLWlEuhxWkVOdEW6l32QQ0eE48vLDvI+FV83C2?=
 =?us-ascii?Q?JqZX2Z2o7gVx/HnEcE9XcBvpN/K9ffZaTxjmclVDyfqI5h+8iq5MJnRCFByZ?=
 =?us-ascii?Q?8aGcUmZGLwSZ5E0h7wmD9M3Rp2sR9/V2uiQfrcQ64h5Kwz6AX77i0jV7r5bH?=
 =?us-ascii?Q?NYazWtU4aKBVGPblOfQyIVKcR/mBFElX3kVXe7GzXHotj8pWmcZbzmWV7Q/7?=
 =?us-ascii?Q?bXF/VraJhrekYWgETqWy2gbgt+gfCODk+pyLu+1tGcjNMmI/wsDLYfukbTc0?=
 =?us-ascii?Q?Onmoqna7ra0hD3ZPRfZEtyzBbztidZgqUpTfX7ZJrv8nMBTVtro8dhLR4vqO?=
 =?us-ascii?Q?s7j8JTuGZ9zfcCuDm3yYho3RdMVXDOOb45mcQaL3MS//8+RxM+M1vgSj+WvZ?=
 =?us-ascii?Q?3CRL6ks1xPJIcGIZtNzNq6YoMKJekFSUd37U4GIgKe2LzNkE/XuxymFp59iF?=
 =?us-ascii?Q?mzEOyr+/eaY1Xor2Uacw7dmJ7Mqm1CPFwr361GxxzZUqeSfAC3tmMYmkX0fr?=
 =?us-ascii?Q?5oJT+qvrqkwcl+J86YeOy1KysMiVKx/h6VGcYEyQ37CFOOl2hWGBkZygg9kR?=
 =?us-ascii?Q?pSo50ozhq1UsTL48SmNtCCH9o1ohAUvXYaACjsvhJrues4JISfbmzKqHEGNZ?=
 =?us-ascii?Q?/iAFGIMpbafQjbRysZy57boEQGQXEyh1Q6Xk227+NVNCzhpbAXUDWjO0CHyR?=
 =?us-ascii?Q?ScHoAt8sjCxLTyS9EEDXG143g6dSVlljv/fKKnZNoKTitUpARuu/tGM4glh3?=
 =?us-ascii?Q?ocjcuWB4wtDRbCffhFbCN/9K9K7i7qEibQDlLVliraMWZZbfNE+edoSyhlwm?=
 =?us-ascii?Q?XmKFCZnSDToadCYaLVlLrym8tDIuT6/WIUvreB6BS8RP5r3Bvo88P/bMdL4i?=
 =?us-ascii?Q?nTARO4wjcgAGvph5ZOW0pHomhoeQ+BTkC2ARq65lPEiSKkc6yrq/V2yDym1q?=
 =?us-ascii?Q?/xvsTcj1jdK2Mpc8I/2JNe7BnmFsgJexAv3AvN/EgkkindKaZvYnO+xFiBIP?=
 =?us-ascii?Q?J7l1Jt4cLdvhfeMxJ1wQ6wnkUfcu84hbvd4CsY1Vvk1+9/dmSfF2q7wVKm1f?=
 =?us-ascii?Q?VM+gxf+FT/2XoBgV9gGUxp0S4/DTqBG9kSDE0O0PRFHeEzrVUxA+ZEgvuMSq?=
 =?us-ascii?Q?Vslg/jDDokwY0zCI86KyRcD0hFZwmvpyvCJR2zHMBxgl3S6vsy6UWY3aZnnz?=
 =?us-ascii?Q?LYwlyPL8uEAyXBrMLvr0zRBIbzp8uTVCbpDRagGtpm/Rpf+fxH5ICnYaYRhC?=
 =?us-ascii?Q?vPH3aH8W/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	NuwsrSV47RwUZMBF8N2RywN5q2c03TbDgPFHWvSCSG0ZRCoBeZx8YHbTDqgT5BXkdrFf39Ysq+fTnh8ZWGldOxMw9eglHAY1q3MRvvlp5LaR5rhm10RLKkCoPKLmdEelAr4Tjq7nNWcPCIHwbjc5NNV85lx2897CLUIvOYEBVxf7wKsmqNL0IlFfySkI+zL6fFX2HzHvzTuA+MXQ6kvlJQB90EV+dVKRvcfr8Ufk7SNThATmxAWiOKk/NQoB0iHiyCr816HwhdgO+k6xX+niPVc+Kv5NNepQCXDP6GF/IVazE6O/pvwEfN2V/nceCscbMuU3t+tG8m6ra0R46cS9XQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf74ac9-59d2-4ede-9458-08dea0113bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 01:48:21.3709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItDJ6cmUfUA+T085uAOSOpVuXJw1q03f3v6b6p4Yx75fRG0l+EJMHkmg3hyXiODgJtzEBnan2Sr4727dBJHI9kRA1e7P3hkIBLY2OOv78R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8018
X-Proofpoint-ORIG-GUID: bgRvc-n-JjpNSefnsZFhTaQWb4o8YAqP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxNiBTYWx0ZWRfX4E2OaqtjV4gM
 mnTloS28LeFlxz5cs1D5vi4AmkOXb+xHCnskh9TkrOoFT9fFHNorXuYu2aBC9BWMcSxP9NnZztd
 N2fFqW07mxtRoMGtMtHaboO4Nboi88/4s1V2q/QYaFLg0YvVu+Uq7wnF9GztLu9yxIb6qKzit29
 fiXnvR/dfLlvwfg+PTVbE4/s/EBFWL0pYF0t7FYsXrsMiHpGRdlL2cCTTNCWkxwdZnBzOn0VS0C
 2mSQv3OB5v3icgQyX8b2FvHqA9Xch+Lbe5UM+9T/2Ny97u2JiRNRPoKk4pN01818tqFPtAqyile
 wNCzd9Yy0JZbLXCi+AGY0sumQqE6zPt2yzRvyN8nGg3bgieNHYN6pnuZPQKouqTjl/1DDB2ji3n
 9nHxhKTqinAXnFglwtW8uV+FsXArYJtxZ4G1o6LgjqNv9GDsO+RGrL9SzUxVsUDyPaoahy/xKsd
 84Y/H84iLRY99Ntyc9Q==
X-Authority-Analysis: v=2.4 cv=B9yJFutM c=1 sm=1 tr=0 ts=69e828ea cx=c_pps
 a=pKtxidU6TXaQx3FGc3VI+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8
 a=0NLdXv5Yzz-IUIJSWqgA:9 a=CjuIK1q_8ugA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: bgRvc-n-JjpNSefnsZFhTaQWb4o8YAqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220016
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 01:48:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3756

Kindly ping
-----Original Message-----
From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoprojec=
t.org> On Behalf Of Song, Jiaying (CN) via lists.yoctoproject.org
Sent: Wednesday, April 15, 2026 2:53 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Song, Jiaying (CN) <Jiaying.Song.CN@windriver.com>
Subject: [yocto-patches] [meta-security][PATCH] crowdsec: Fix recipe to mat=
ch upstream source layout

The LICENSE file is in the repository root, not src/import/.
The Makefile is also in the root, so do_compile should cd to ${S}.
Fix do_install_ typo to do_install so the task actually runs.

Signed-off-by: Jiaying Song <Jiaying.Song.CN@windriver.com>
---
 recipes-ids/crowdsec/crowdsec_1.1.1.bb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-ids/crowdsec/crowdsec_1.1.1.bb b/recipes-ids/crowdsec/=
crowdsec_1.1.1.bb
index fa13e9d..c7fe3dd 100644
--- a/recipes-ids/crowdsec/crowdsec_1.1.1.bb
+++ b/recipes-ids/crowdsec/crowdsec_1.1.1.bb
@@ -1,7 +1,7 @@
 SUMMARY =3D "CrowdSec is a free, modern & collaborative behavior detection=
 engine, coupled with a global IP reputation network."
=20
 LICENSE =3D "MIT"
-LIC_FILES_CHKSUM =3D "file://src/import/LICENSE;md5=3D105e75b680b2ab82fa57=
18661b41f3bf"
+LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D105e75b680b2ab82fa5718661b41f3b=
f"
=20
 SRC_URI =3D "git://github.com/crowdsecurity/crowdsec.git;branch=3Dmaster;p=
rotocol=3Dhttps"
 SRCREV =3D "73e0bbaf93070f4a640eb5a22212b5dcf26699de"
@@ -24,11 +24,11 @@ do_compile() {
     export CGO_CFLAGS=3D"${BUILDSDK_CFLAGS} --sysroot=3D${STAGING_DIR_TARG=
ET}"
     export CGO_LDFLAGS=3D"${BUILDSDK_LDFLAGS} --sysroot=3D${STAGING_DIR_TA=
RGET}"
=20
-    cd ${S}/src/import
+    cd ${S}
     oe_runmake release
 }
=20
-do_install_ () {
+do_install () {
    chmod +x -R --silent ${B}/pkg
 }
=20
--=20
2.49.0



-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#3705): https://lists.yoctoproject.org/g/yocto-patches/m=
essage/3705
Mute This Topic: https://lists.yoctoproject.org/mt/118836664/8575670
Group Owner: yocto-patches+owner@lists.yoctoproject.org
Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13352517/=
8575670/2112398787/xyzzy [Jiaying.Song.CN@windriver.com]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-



