Return-Path: <fangwu@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3793C5DF80
	for <webhook@archiver.kernel.org>; Tue, 18 Aug 2026 09:45:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5358.1787046300831271037
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Aug 2026 02:45:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=U8RenNRr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: fangwu@qti.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I8BEnm747606;
	Tue, 18 Aug 2026 09:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=D/FYcc5r5YSCnibPwfMZaY
	GF+Is2DbhEr5PZASjwklc=; b=U8RenNRrI7OBNxzWKQYNGsigae18O5ByxrOPzi
	0q0oQdaelZgddX3orhRq/KmHwcmmpfEeKV45JsUMlbWD9+W18ErChRxj2dERWr3q
	ti8W8NoB5XW0sM1Qyzmg+dubJ+NQ7kXD3Rm0xOyvVbf+EES6QUqed+cG1jQk6OM7
	XQQk749abMl3tOdIIoRyKE5sE+FzDcm14E260wxTv+hJxi6xWbYiSQNUHNpjygMr
	WABWJBFmGhFZz0IiCoCPLXrczlXFLZSUZj+bE558qY7Mug6LBmra1Zwyai0a+yhp
	t+/BIgBguLAtIlv3nLr08W5ADeGLzhMGo5pa3ECNHCMJOVwQ==
Received: from dm5pr08cu004.outbound.protection.outlook.com (mail-dm5pr08cu00403.outbound.protection.outlook.com [40.93.13.99])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g48q0u1tf-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 09:44:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3oBH4GOio2jz2nybjqujJnX5c8GcIFkqEfRBlW/79V2VhwK6LGhEowsMh4evbdoOhEx1AHE2B+baiHneYpz1fMO4BTiHRx1ovg7KzZkOsUe/a+OB7juNNvWUVBCSJE4cbippEtmlkNATauZyiobbv+LVnSUbIYGIO4pzC5MOCaFORIAY/Sq9vPYbSZAoe6UsSihnW4LNsdFxQw7JuLFBQL1zDyRTWNZQw+Yf82yw7WsSOlaK7bza4PouHFTrBAlR4VM5wKxNeYaURmHbUlit7QaQ+BdE9SFFOaqLMoYS2CS+rU9n5KqdB3iQenx6iVUum6FPvjW+GmAj/Wvgz8joQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/FYcc5r5YSCnibPwfMZaYGF+Is2DbhEr5PZASjwklc=;
 b=PRJ2l1sSnMiE6E7Dk+yWoC1dvJQxkVft0osRqJAya758qXeD5Lifk5awal+glItkrLZLb5Py0ensZIj0W33Nabur6Jw+sGFxZbViT8F/F4rE89dozw5DX6Te8UGVpvzckHI+DNvRk1pyIZ8tK/JDHU8Tsk2tBnmKH/EeASegWhvE6qJOLa6ASU1ic123fKIXLT4eJKeQULBev6O3FeJrxJMQ3Pb0Z0TBMD+d5ZwSz4NCJXa41kH+0Qadt6I4AvfwD5L8MKKV+W4r2JKCr7ZDGQesIrcL2rhgQD2CodScktTQmdhtW4/jcm5xv/U2IIPro4IEDpI2W83SFrSTvqK/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from PH8PR02MB11449.namprd02.prod.outlook.com
 (2603:10b6:510:3a5::22) by DSVPR02MB11916.namprd02.prod.outlook.com
 (2603:10b6:8:41e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:44:54 +0000
Received: from PH8PR02MB11449.namprd02.prod.outlook.com
 ([fe80::5204:5da:739:4ae4]) by PH8PR02MB11449.namprd02.prod.outlook.com
 ([fe80::5204:5da:739:4ae4%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:44:49 +0000
From: Fang Wu <fangwu@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "joe.macdonald@siemens.com" <joe.macdonald@siemens.com>,
        "yi.zhao@windriver.com" <yi.zhao@windriver.com>
Subject: [meta-selinux][PATCH] refpolicy: upgrade to 20260729+git
Thread-Topic: [meta-selinux][PATCH] refpolicy: upgrade to 20260729+git
Thread-Index: Ad0fHGs0GV2rXVf/TRmVLwRmxvIXQA==
Date: Tue, 18 Aug 2026 09:44:49 +0000
Message-ID: 
 <PH8PR02MB114498D2471C4BEAB5F5A2770FEA62@PH8PR02MB11449.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR02MB11449:EE_|DSVPR02MB11916:EE_
x-ms-office365-filtering-correlation-id: ecc25521-1e25-4601-ab0d-08defd0d585b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|11063799006|10067099003|56012099006|38070700021|3023799007|18002099003;
x-microsoft-antispam-message-info: 
 BtBOqp9BzOE5Ljbl3UmPVrWOwzlGYk7x74dQ+szzmV85TjfWpY5p61XVWonba0op4dTZ35Zvau4fM9A9qwQ433w41QIXeZtY9CrEYLqaZOC6N+Tg5SElHlray0vaxK8cVNFJK2m1RZXubGCDXlgR7+T7MDrWghoBO/fz6nishWBauEM/rNx7qHdJVosHga/alpPbJjIY504sVZYgiNCcrt6kEKiczJoWSyl1uVYaCr/ZCSNJPe/MohV2etl0XSrUveHiecIvCuzKaO1ke9n99e7GsGBu5PcHMtO8+H1U3f+ZRLaPn0JBOvvYh1204usF3ny2on/4kwi3WCLnsMJrLrXP+Kn90XVli5DOuUghbiZi3oHl+CnT1q+LcXwbuBxYjkzjGZmg/NRQpK13Erw4nK3Nrc4+LEjU5RRdGEkFZ/lav6C9ZtaobEj0TEQBpUjJxzq3JXyr/En7HYE1l+b3hqc18CyODSJvrtobWeRIBAZLd8YwN914ZSs2uyshroO6nCVXh2zIaiJlt5iFCD8xlWNKxzUQao/0Z99a0cQQPz/i/jh3siTGtOavr5rPIbtlbzRtZTEveiCZmXQSqmLJv36NoNBAG3H26gTWZZo5cXlRAlnC5Zr0JZ2tCmhQ+w6OVYoHtBi48fZ+KN4Y9pt/IuOXJJ7JwDIG+16l+DP2fwAbL5jAXitD7/t0yqodhnWScItIm7dG5ylzGRjDud0Y5MdUJ+uSumDFKCEtghhqYI0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR02MB11449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(10067099003)(56012099006)(38070700021)(3023799007)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?go4m4hqg8zRAXxjL73bYemLRPjn3yPgsE3XVMJ4486mvcWBSIE52w4qA/15T?=
 =?us-ascii?Q?S53UvqZCPmuIWMfe1OQCLUBXXLTWJ8i2SFmTZSIekeCPtO3sefX8GawruW58?=
 =?us-ascii?Q?tEVMgOl5W19ACoO1xF1EMiYG1Qzvdpv0DAviwezjvlF4MhEsr3EQBExoG9jV?=
 =?us-ascii?Q?HQoYTxoWAeIHmPCO0UHem8r2EOA56O5LKOZrTKr6/QN1YUFp1uA/FfbiRFcO?=
 =?us-ascii?Q?xYB+Cvltq6oRTIfJe5NHGJhPtz508enjCCV9n6LqNHyT3RK8KTa/B63qiNjQ?=
 =?us-ascii?Q?sAO8YinZkYQh4mpGT9kmXbcPicBWlzjTEIkj0UEHm1v3uBhMedZIQiSeClwl?=
 =?us-ascii?Q?u2gutubvkj9SNyWUo/aQEgUF0SQQQYGGpSn+qQsmwonkjfj32STfiCBlOkAn?=
 =?us-ascii?Q?MC3ZefwR9nVV4pzGSLm0NAunclsdAD3/xLkiH4TebdK+/fkNsrrXgKvtNY3m?=
 =?us-ascii?Q?ED+n4gE6c7FGnYbD3512e1kfKHYozMqyrJYt9xakEN9mVvMxYK1zIh6B0Fac?=
 =?us-ascii?Q?FPlNxwxw+llLxldug7psy7QEwuNpwY+LF73rVTyH0Anqnb6u9DtjVngC9rST?=
 =?us-ascii?Q?g8eHDjPdDfXWrvfUQFAq5HKC/sFHD/pEHF8qEovcYuHQnVWFbQkiCqAsFo5y?=
 =?us-ascii?Q?yYTuIdl7ZuqX5VgFEtIOBQgvw6amhvtJZ3rnZ9bkXXrtI2JtNpykkYRyjs83?=
 =?us-ascii?Q?3KNGXdIIHOEKjJAwddIM8oZsVZUaUCjoAJ67Zg5134IITnKkjOrvHYITyOPH?=
 =?us-ascii?Q?QNxXt6KRt6nYYapp40/GQ96KwhLgyAtjKuBMPR7wLM0DAAnSsoEN9D2IB6U/?=
 =?us-ascii?Q?mi8zHweAMgekwTtO8TU22mE1aEGTzst6FQyJPY6CcH2+cF/ONTZcfaTNAU+S?=
 =?us-ascii?Q?J3oPQ2co0PRLQnfpNdBa/oE8Y3XSbu/QscxqMO0+XqO3Lqpn3+UFA0ClKtzu?=
 =?us-ascii?Q?D0i+5ENzaP95FFCmMuOaFZJ3C/3gzjtCWQ4GA11Eo7brnoTCrFtzCCPa4QTb?=
 =?us-ascii?Q?rlCVKLgEFi//KWpHj1io7Tyu9xHuMUjtassSF5KFWX7dZfvV6rqOZHn2FOV/?=
 =?us-ascii?Q?xkyA1p+cA3u5QPAmmtMfJH+sHVFYVnnjYAtSrzComtWlaHKvS26EYkfT6xur?=
 =?us-ascii?Q?zQk0MiucicJXebqpPaurNKJhKXElTK2tpIl6OuKSatLoztDIXxxOTo23u2Vd?=
 =?us-ascii?Q?DHW+X+corMNSXAplj9y6zal26IBhL4iCpZm73FFHuqpHwOq8Gs3SHWWCu7SG?=
 =?us-ascii?Q?NY7wXsoL7c7QHzfalZ3PmR4Y4Cg5h7VSgbyyNNGLi7nxmqsoQu2HubXffPZC?=
 =?us-ascii?Q?BbMVYn7gEd02munNVfLkKgBY94Dw3w1FEMVCDf+FvFZiGj2uib2VcLSLO/T0?=
 =?us-ascii?Q?kicKcy9JAYThBaKP+KHndFIZhV5Ce2KuoY0JqriHX47Lb9IxB1+ITJLoFzRc?=
 =?us-ascii?Q?ipZojZKtjUBbxCIMf6/3/8MMikQHtaUsW0kjOAlENjRAGva5ZVhm0AP91pYW?=
 =?us-ascii?Q?A6k8HZp2Dlvjr40E/JoJGbRL4yjNx48IE6w4pKI+ZQrF5hnWqRI0FfjkOjlM?=
 =?us-ascii?Q?ERwJSnaE4DMFUySDUEHqAGALKaDXwK8wyDS7bpZ9WkY0lDqXrsQlizWxNhJQ?=
 =?us-ascii?Q?uyKkuD1bu5GjW/xnnV5t5HlYk6vRT6y1wJHIvMiNBK9xpg+8rsmGgqoCv/Rm?=
 =?us-ascii?Q?ZhiAMiWZuU0zc1abkuhbD8nEmJ/s4YwmI1GaRMtVI1bg2koi4KLVec1NLGRG?=
 =?us-ascii?Q?WD/Ar1TIsA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	kSqRP7MkOZohQzGzyryyj/ssHfnvNH4nCG/ol/4mXJ9PeJ32ZVp5PnMLkaAM+45ZPC+OYSb+6QWOTZgycoTw4tq6HrbKtpFKFmpRT3J+/BXk0QqR4fIYcY8tCkWwV4pTnupXLMTOMHR1jn7L9BfsDLCPFeox0calTIlcczr+m4IPgbOS2uaA2YICKMPjHn4P8YVoWuBYQSdBUKHUPPDNSZ9YWLy9eHWHBmipaAAIjsTG+ONsh8oxJ/EpdYI1/v/D7NZuYnW7BHE3o+SiT/si5yJJdZqYhcDzZx5yhP0F6+2dC6OCnh7YEoBZcO8kgxiCl/jk9aiyFTfi1RVc7j9qfA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	itYARQynknv5jdkRYqQU0kd1+iXFZAS2CTyXnhMau0su3AsXd6+Qo5Nzx+5EodwGUuURmrLjPYseRr1oNxx9XRX750O2zar+c1UYqXmdWpeBcwL85r6FDz1F0LjSmSHcKf9leRHKXUjHXsarU7xRGPtqWLpXl3r/rDqWYR/2lNKdn7P64ljXCHDbYp2HOoeYXCEDzPvVmVVPX90SmJSR2WeHESQ0eqY0nZFMlZTk+0f8Ha4UZN/A05wRrnL+FrWzBTyUSteSDm8oR2vu9RNqne+53Pwx4WiuYBfSlfa55OfTYsARYhQXJ3ic0xjaYjJYyCeobP8Ab/UdO2q46tDV5YNauJicO1BR27tgCy+nWRLBTC+wlg6qEB1xcSBPt8mRZhBzDYvfdpAT6/5ktMyN0Lvfmzx8bzNkRFoq5avYUfo6CRENyUehn0T+fT49oocuy9fD/NyEGupnRqrK/24nBUChsP0NWcu5eQzF670mhQKky9DUPw69t0wqm93oIOHL8XjHNvmvwBXvLXajZzkqPO3m97DHgpoMGUKuf7TXu/G/IiELVe4em7K0dOdckGzU8QGegKo65/idRu8bVuR+ezrJ0YCLQnWukuhKdVw+lN4HaDCbTOVpWOSyZybSkqOt
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR02MB11449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc25521-1e25-4601-ab0d-08defd0d585b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:44:49.1664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FlVe/YqIJEQSU+M+Zv4GN/EO6QAe20qOFSZci52WK+NMHm2jpxw6OC8Ji7ic7mcwkclJmuZjmyT749qk0XHPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11916
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3MSBTYWx0ZWRfX0+VtvuJG16Rx
 0su/M4/zK/rGYAx3V+Vuc3b1VykIQl6ck6dwj4sUH2ToDKiLpNNyEQia+vgg8fbTYgWSma9pZpr
 aRSAp4HTjdb7mLtXY/hVTbFKFUFmzhA=
X-Authority-Analysis: v=2.4 cv=VuITxe2n c=1 sm=1 tr=0 ts=6a84299b cx=c_pps
 a=lnBElVBKEKT3wjluJUCtwQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=PuXHDeuyIxIEfjUnmKIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: sqAQkuaV3bXAFiix-79pSCSjeJKIfAH-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3MSBTYWx0ZWRfX5oA8HDP1GDxi
 Q4C6HVHP9tQTywraU7/cOcLS09Q9xAX5IKnmQcqDxvUsi/H99qZDcYQwMCta4Hy67YV3yM13blI
 h57ttuWICDn3MIxRPe+lLItVaMSzBGyPpAunnU8Ex9lBf4v+VCCGas69gpFN4JJa4V1vkesAMbR
 rQaUS6PzIpdgupMAflEMcXXTMDa1sNWZl9R1HRjLJdz8I5SID6SX9zQlhj/5Jee5YnLJcGfZkXj
 lQM1LhrRExPQyvBLYTme0PXjSsstPxyLqygznu3+d2St9Y7nFI5QGLS9qWqeXiMxN2C0hMyVe5w
 fMwUdIB/nKwH2v8W4bJu56CaIjC+AzZYSploX09KqRplRV1we2LRfMulD6316hsnAqKQU3yrAjv
 zKk2BIAP3SUZoQ/29MX9eJs00SvTHlzAgAeR0f/e1iHQXyLJq0Jd8jnuAfSD6dLqmv4eJY1A/5y
 MWSaAKkkcPXbvt4wtlA==
X-Proofpoint-ORIG-GUID: sqAQkuaV3bXAFiix-79pSCSjeJKIfAH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180071
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Aug 2026 09:45:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4670

Update SRCREV to pick up the latest commits from the SELinuxProject
refpolicy upstream, including:

* a7e7df1b seatd: allow self fifo_file read/write for signal handling
* a1a878c2 adb: add SELinux policy for adbd and adb shell support
* fdea2b8d wireplumber: add SELinux policy module
* 0e8bfe52 tpm2: fix tpm2-abrmd D-Bus communication under enforcing mode
* d3e82b72 lvm: label dmeventd on all distros, not only gentoo
* 74cdfe59 pipewire: add policy for PipeWire multimedia daemon
* d4a85ae3 wayland: Label sockets under /run with wayland_runtime_t
* 5352d9c1 Fix file_contexts for systemd runtime generator output directori=
es
* 9417c19a rauc: new module for the RAUC embedded update framework
* f9578765 Allow net_admin to the nfsd_t domain
* 66a1682f rasdaemon: optionally permit access to ipmitool
* cc59e75f Remove mptctl_device_t type, alias to fixed_disk_device_t
* (and more)

Full list at:
https://github.com/SELinuxProject/refpolicy/compare/30d3cf5abd18...a7e7df1b=
5bb6

Signed-off-by: fangwu <fangwu@qti.qualcomm.com>
---
 recipes-security/refpolicy/refpolicy_git.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-securit=
y/refpolicy/refpolicy_git.inc
index 4d207a2..a3742e4 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -1,8 +1,8 @@
-PV =3D 2.20260616+git
+PV =3D 2.20260729+git
=20
 SRC_URI =3D git://github.com/SELinuxProject/refpolicy.git;protocol=3Dhttps=
;branch=3Dmain;name=3Drefpolicy;destsuffix=3Drefpolicy
=20
-SRCREV_refpolicy =3D 30d3cf5abd1872d3da5dd44de37de4251674f736
+SRCREV_refpolicy =3D a7e7df1b5bb6b98297c3306bc5b1832a5d86a47a
=20
 UPSTREAM_CHECK_GITTAGREGEX =3D RELEASE_(?P<pver>\d+_\d+)
=20
--=20
2.43.0

