Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4885EFCD9A
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 11:04:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9359.1773044444918554380
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 01:20:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=mrHrlvLI;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: sasikuma@qti.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6295Vmja3564772;
	Mon, 9 Mar 2026 08:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mtz21rCi/vHwfBslyFbYPTv9ECh17O7LBqAuVnurEcg=; b=mrHrlvLInj8aFHDr
	P4Le3qcbJdSkX0v/HUe1SMppgwtyNR5+z/vvSXv2EWkE+GuUfj3HAanfEdKTjFRO
	QhyDHFgMDJcdaJUC87jq6U5X+A6tBYLGM9QdzRGLfBI9VLEUT0iQk/JRUqttIVzZ
	DTUGtdZEuZ2O6CIYLE9rB9MgdIcp1Xt3yfX7xPGUyh1LHKnntcv3Gw3v7knwq4lv
	nwRX3Baaovht2jEDZpVZgFDCNKKOp7B+d2Hzs/XMSKVUsVY67LZ1z98ivgDkWT5L
	VtJPqgzE3t6UgvrTBOSn9Zmt308ouRU72AbXAOygZZXJSqYiL/dMPmW3SGBUK50/
	njxiNg==
Received: from ds2pr08cu001.outbound.protection.outlook.com (mail-ds2pr08cu00101.outbound.protection.outlook.com [40.93.13.49])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crb14vn0t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 08:20:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3lyEFPsDiTdbN2CANMYtV3jBJEntDw4A/Bg4cbRjIac5tCbVxWZTqJyTAL0X5N9272A/otfY3/q0BWAVQF8QFiJjF4fHI9wR+4fFKko+4+Q1UQSVloItI5sjO3SQm5cboN4h/lygV6qdDzGiryGiCS80qyWOV+y8ADwUa5UkHn1XZwP5QQJNpalEgSECJ7x1FrA2F5BvKprCVLlJ/bTwFCeyKRcYoqliJIFk2CW84N/f3DJFIs5j05+h5Hq8AQtopuwYjiflAm/mwkqQ6Zf2vR02VSxzrRhuJ81flRW+UJv+kihNqYDFgov9a31oybb7iLAznDaiTCZhXQKPtZ7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mtz21rCi/vHwfBslyFbYPTv9ECh17O7LBqAuVnurEcg=;
 b=sx4sc144yuz9NhTtutiJBvpaPDKRPCoFigWWTCALDY5TwPSGnUPwQjq1hxw+4ZRzs7limWQWwZ/RqA+QYWAXX6uQM/MGO8S/CxW5ivqAq6AmypT8U9+JBXpmUKo9KE/zqMIjDdOcTw4yxD0IQmqzpCdgBbnxgWT7Gds88IjHz+5wfdxFUFFlDBr/Y1Bgd8lGEvo1r2zk+XuVdDkv9Px7XPVMw5v3btHTZZrEXdgn/LTBpx4CV30nwULOkMvSVTqxQ9xSpR6XRCGmp+nxp80346amt5LQjXpTJ7Y3n7EkKHmFZ1WBDYDWOIdBXyN6O0HNQdgYs3FCZis6Qo8kgG85/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BL3PR02MB8986.namprd02.prod.outlook.com (2603:10b6:208:3b6::10)
 by DS7PR02MB9457.namprd02.prod.outlook.com (2603:10b6:8:e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 08:20:40 +0000
Received: from BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35]) by BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35%7]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 08:20:40 +0000
From: "Sasi Kumar Maddineni" <sasikuma@qti.qualcomm.com>
To: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>,
        "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        Yi Zhao <yi.zhao@windriver.com>
CC: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>
Subject: Re: [meta-selinux][PATCH] kmod: add net_admin capability to kmod_t
Thread-Topic: [meta-selinux][PATCH] kmod: add net_admin capability to kmod_t
Thread-Index: AQHcrTPSuYLrsSP/Ck+4HEW5yBgtg7Wl4KXg
Date: Mon, 9 Mar 2026 08:20:40 +0000
Message-ID: 
 <BL3PR02MB89867F757D28421B8DFB1495E879A@BL3PR02MB8986.namprd02.prod.outlook.com>
References: <20260306063810.3838975-1-quic_sasikuma@quicinc.com>
In-Reply-To: <20260306063810.3838975-1-quic_sasikuma@quicinc.com>
Accept-Language: en-US
X-Mentions: yi.zhao@windriver.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB8986:EE_|DS7PR02MB9457:EE_
x-ms-office365-filtering-correlation-id: 6cb84a40-1e09-4c8e-b8dd-08de7db4bff6
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 uPRmElErQm09ebj6HhvEVixA7EvrmD/c0YGSSAd9hnlXesNzMVd+Ozu4aQy/A4cEpKO2GsTTgXVJ+W1hTPpwbLskh/5008JW3D0pPojccTW741zefaP9gkZ3c6dS2bNqOZiJawCWCAzzld6olPV/S4F6KH3xWR4r/NOorMJYCcXe1bzJadcA4ui8KTPVPlP/hGHow14PE7/ISBpLDCTgQnmSBNWZCmzoiGHTY24LE7shUNT9wBe/daA50AIrAje8RNlNBLEUbJnn0WxWDgZ/xJi4nJxiHgQun5OYYOAsTM2iwtsNd5XieAKczm/tqHZl+g+JhUr/jSDqYa5yhrHd5LR2h6KeGIi6kF6Gi6TO5vgUnv5H6LHH1mD+5TxDt/Qu/b1et6g+AMmGLAT38CN/dU7soj6oYl0FSaHW4a7ImcHdYaLYEjPy1yrBZejQuth8G0fHzgSoeqLAhKB4lrpVEsuMxkSyB1hccEMw3COj3u1OJygy9PELr0Dd2F7cVIaboxTlFmnrvG0DYXGKRuf4iJEpe7vnxUG3mXxoPe16Pb/cfeeruu9UOFC0pDTbUuxCJoLTNbWS62qPz2Z+meQK8ZH5PG4QinvIwWUZvockxR6QLSfqwJOEypMC1lpEgeTPgeb1+sBbBBx0UzoxvZIkDuNVH1/xL1Vo2IGMyto+Y/w7mUQAYtp38NtnS04PHGbaPgiS7N8e58Tm2bT4St1OTgZzzFGZ7N9f//jFnm8pLjlbpOWKCFa+nXsvCOnm0jOu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?pfVIbE1xvpnEwLX8yVdSpNPhV+SFUcFhAlHKY1OhF6LoaXCmy3/4PocT7u3y?=
 =?us-ascii?Q?ZGeRo4vNDgUmz2v5IJwPiPddJ+i8ZOZf0EvgxRoaUti+4M9d4e/yePTxT20A?=
 =?us-ascii?Q?xZi7rB0RAdhpWT73F9rcBWqbzDx+FymAdWp5ZKYbeP3+st2sbZv/HZgdqeqA?=
 =?us-ascii?Q?CVaHsLro50PajXXWLINNUF6TyBmRoqhjs1u9EGmnbsewEsOmg/lWh/8Hb7Rn?=
 =?us-ascii?Q?tIoImY0yKa9a74hhZ8V/c+SRI2KrfrMCYsdsvb9rIWYWK30m0MweQWDjqs9d?=
 =?us-ascii?Q?boL+B9cqpgC0cE29WuUuWYjcL0iHc8vc2GqaTra0s61ut9LJrsCZrs7N/zhv?=
 =?us-ascii?Q?DVqNEASQHGspcG6F+rQ4U9KU5DTnrx9WiEHhfCdpqnWeqY7Iw4gqpKCj2Pa6?=
 =?us-ascii?Q?ZEZkHjcccmZkB8BzEoNxYVSOydzkoSQOsJK28yHaxP+EmLJrCJz0Qm2/yuEV?=
 =?us-ascii?Q?KEcY0JX7IruN4fZyCSqzV0KpsegSeHOurOP3vo9+MsLfQ7BUff80YTULQduJ?=
 =?us-ascii?Q?wpxFdqYb3qu9IsKXYgxYpiYE6M1f8ybY8lihejizYCac3GF/vfbNbaSFLLqy?=
 =?us-ascii?Q?L/VKrje+PH85d7akwsnB8CcCk1x3uBsoFru4N0YimuuXP0Jm/jBiZ6M8qUvZ?=
 =?us-ascii?Q?SWrBDL1jofxvbgSCL+FAy9R5CC+YdwRztfaHMIdGhuW477vHDfpF3YDDNGPz?=
 =?us-ascii?Q?XCsMdz9tJpxelC4DfoLJLlW83FbKZwvw3W5I2pAfzyQtojUSIFQXTPld3fMb?=
 =?us-ascii?Q?h1Q1yp5ehWSsNwu33ISM37SzckLX7uu6TLcDT2t0tXh76sS2nhAFZqpkIMBJ?=
 =?us-ascii?Q?xM+N6026+7sU2C4JsO+I8lOdXJRVOcwakPE5XQ8n2YgNMg9huPdi1AAl6jgd?=
 =?us-ascii?Q?QyuEpU5UuNAMcnU9ngBYpPCiCDX97aM/OZLVUPoManTTjmKBrVAR6e/oqV7W?=
 =?us-ascii?Q?8Ludg95WxlaDPjYwYbpLCsv4JXK9WdnNxSC3z+uHi5lMGaxhfSDD/NF+WwvF?=
 =?us-ascii?Q?NFlXBKjDYcxGVlJ2KWsVow5Pz4qUZMsw3afypDoZAp5NFrxkAfi3gKlDPBte?=
 =?us-ascii?Q?aRJFlePenOzd7IjdfWHlTxmsp3xYM13ruvBBVdQTW39JxSM4DjghngK4qHkW?=
 =?us-ascii?Q?ItcFrp8JXJOMZUr8/9PagEXa3Hdif+4w4gO5AxuOrY0bc2XEKEBCfH/iDgTy?=
 =?us-ascii?Q?vtiJKlPg61014ICZwnJI94YgmF5paT8BZAdXDHHK0Zgmd9P1cg7t+nojchFV?=
 =?us-ascii?Q?V13A6M0oknLudBA4JOHKlJHdvy3izHjLy2G86StXwCGfCwx5ey9IO5GmPQi1?=
 =?us-ascii?Q?pgIYfRBDpx8WBJIvd7ZbZMgvRcIawWA+423dorfRF1qjO+kJYuYGBlVzYtit?=
 =?us-ascii?Q?tpPBVu4PzHJTmtOZL8wFQBoFaFMBJVz1ATc3tMqNPxff64fHCUsSFyPyMgQ0?=
 =?us-ascii?Q?6dBsasOUjmk3WZrfYB4U4ghd4OoZHdwU5doUjk5Hcg8BfUz091pnYNzpElh+?=
 =?us-ascii?Q?PCeaHY0oupxe5EwrHieUbUeT0OBNudrq9XpAc7nRW7WAexRRPG9aYxjEnV2k?=
 =?us-ascii?Q?hqrG865ijqq6pjgWIRJcVIzEF7c+BaHUjZNMK4eduHFNewjf+VSAbvwV+uAg?=
 =?us-ascii?Q?vG+rKB1gn8/6G04pVrjSBCwyGZf2vAP241E/e9qCk7D85NLbr6cUX/Du+lj3?=
 =?us-ascii?Q?bmB3NECa+V1NBhObsM3STvigNgNYq9OtK5eM42Te+h5qLcMvWuwPFLBIyTee?=
 =?us-ascii?Q?gj/4RY/03w=3D=3D?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	o91xJyn/adCF3HdcJxDeqsnje9khOzyCqkxwLI4LxLLG6HXr2qrSJ0QyeLBcHl7kTuaiPtMRtHsUUX8suM2n7CKUysYZObqK0vQLVjE+hGeQo1Gs3lXWFh0rdn43eSOcyJX2KxpUnS0TbBcXSTUiCrHVxlWgbCQg00yWI8V0Asmbro4ebZHUpHtuL3uJn6gWTWFLRkrBiVWziiAn+0T71E9wnEO0oxrz+TsyUdcBbBoBf0UaaaCvCGFUZSHoy6BeGCv8WmoeXLoOZad+xPpxRDrU8HPXwCM8rXrsN12b8II2YtUwXKmsFlHY5eMqWINWPvxvXMzmlN5vee45yqw7Aw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xDMvJXbrgFVIu00cHfzDVy63Yd/BqCsPVX1NmzPd0qZjVKrZmIxV2K4aArxurljk4xZ38YsZNrRXrwWkGhhtz76MNc3iesRUkEgkSSeqEu7t1iON+S5BnsGoyf8OWufSK4ZZxfiMAw26IaSiw7T3PBwtFgxtLHxkZjamCDoyUaTPTcT86qjX+1w0oAY8lWgVq90iXacK7Io4uP7N/SS4Dklh0KhX2qreT2EgppJ28fti5uDsKOjc+WC6Sykl82SG9m08PJvjBSr5KsEEYST/SNAeJ99e4Ke3UxKQit3f14OfERv9vWjzyiJ8zqEXj5DjXyxiWmscNJFfS0KNstr039kngKqaVLu5+LYoLoUXTMbAU43H9s35VFk9UC9Cq2FZ8pfHh/C33HOkMWFwWXCx2R8LyYnYw85wz9Ej+qVY6WMXETAU7OUcURE47Jz9nw/+WYEiQ8pezcYBdmkVGhMOLfwMK6B5Xg8shopJWgZYfvICqlQz2klWIU7xjpnFJgqxfbh3AJVd5uesgOfwNf7AAdP0Cd6Ogpmsr9rRiJDPXPTE6deRVzHQR9qlWVbD6GUS7ofYVRZHS+w/BiO8PDnB1TW/C1J+vX4F82V1KMPg4+I7uIE0R7PXaVK31HiFr5Py
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb84a40-1e09-4c8e-b8dd-08de7db4bff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 08:20:40.1162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIjxe8lFiog6XhjvXjofWAr7c2LgeAYckGtqwI8OGnybJmnqrII1cvOOW5lpUAkyd9hQUepMb2k/Zqk8sXCGVs7dT/UlColtRrMnbDTuxBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9457
X-Authority-Analysis: v=2.4 cv=IYSKmGqa c=1 sm=1 tr=0 ts=69ae82db cx=c_pps
 a=YD5s6rRJccchaDw55xO6ew==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8 a=iGHA9ds3AAAA:8
 a=EUspDBNiAAAA:8 a=vKhQHdimMFFoemRjgckA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: jTFYjmoDYT-cswRyvHykQ-2w_d1J5AsT
X-Proofpoint-ORIG-GUID: jTFYjmoDYT-cswRyvHykQ-2w_d1J5AsT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA3NCBTYWx0ZWRfX01itk7ZUR361
 dLBW+gkcH9jjYiOxapU9p1JIZaX2e6lX4zLY82E94CwHp/6v/YYzT/wqdxsLQAgjmccY8fwVhxO
 PYWiEF/e56Zrcj7pfNuHH7l0PajivqlTzu6+ezjQ8AiiCd2kTJN8cnkaLdq2DlzVEfGCFywv0aF
 GbjaK0uF8Yx8nmw3QwtPTorWUns/nLN6wIG8j4yAg9JBDWyIlZp5dpf1ZHlImdlsaWuWSwDXFmT
 hdkiW8QHH2AKpHSTtmP2NR0DbUxpnWwUKQCVx8MAlXDZ44GuP/J3w/WjJSYphF29oQtAdgT5Miw
 nQGneknWptBI8AykzzMWofaBpVPfb8Ij6MZNNojho1L4rLjjIB6ro7RlrsU43SE3juoi89yUtgu
 /EeKdeSembsvQo1nUgjGspWWQNcloPx0Of4gxuGvHlPj5p52QT/1giWUH5uwuYByWlNqiLAFC+a
 /xqqHryYvNxHelruYvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090074
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 11:04:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3382

@Yi Zhao=20

FYI


Regards,
Sasi.
-----Original Message-----
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>=20
Sent: Friday, March 6, 2026 12:08 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>; Sasi Kumar Maddineni =
(QUIC) <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] kmod: add net_admin capability to kmod_t

From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>

The kmod_t domain attempted network administration operations resulting in =
SELinux denials.

Adding net_admin to the capability set resolves the issue.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 ...d-add-net_admin-capability-to-kmod_t.patch | 34 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  3 +-
 2 files changed, 36 insertions(+), 1 deletion(-)  create mode 100644 recip=
es-security/refpolicy/refpolicy/0060-kmod-add-net_admin-capability-to-kmod_=
t.patch

diff --git a/recipes-security/refpolicy/refpolicy/0060-kmod-add-net_admin-c=
apability-to-kmod_t.patch b/recipes-security/refpolicy/refpolicy/0060-kmod-=
add-net_admin-capability-to-kmod_t.patch
new file mode 100644
index 0000000..ebc0d98
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0060-kmod-add-net_admin-capab
+++ ility-to-kmod_t.patch
@@ -0,0 +1,34 @@
+From 89379c0b2430e80d345e6552c8b8b151c12dc24d Mon Sep 17 00:00:00 2001
+From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
+Date: Thu, 26 Feb 2026 11:46:19 +0530
+Subject: [PATCH] kmod: add net_admin capability to kmod_t
+
+The kmod_t domain attempted network administration operations resulting=20
+in SELinux denials.
+
+Adding net_admin to the capability set resolves the issue.
+
+Upstream-Status: Backport=20
+[https://github.com/SELinuxProject/refpolicy/commit/89379c0b2430e80d345
+e6552c8b8b151c12dc24d]
+
+Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
+---
+ policy/modules/system/modutils.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/modutils.te=20
+b/policy/modules/system/modutils.te
+index 271cdb1d4..7355255e0 100644
+--- a/policy/modules/system/modutils.te
++++ b/policy/modules/system/modutils.te
+@@ -33,7 +33,7 @@ ifdef(`init_systemd',`  # insmod local policy  #
+=20
+-allow kmod_t self:capability { dac_override dac_read_search net_raw=20
+sys_nice sys_tty_config };
++allow kmod_t self:capability { dac_override dac_read_search net_raw=20
++net_admin sys_nice sys_tty_config };
+ allow kmod_t self:process { execmem sigchld sigkill signal signull=20
+sigstop };  # for the radeon/amdgpu modules  dontaudit kmod_t=20
+self:capability sys_admin;
+--
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-secu=
rity/refpolicy/refpolicy_common.inc
index 2e1a929..3bd43cb 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,7 +74,8 @@ SRC_URI +=3D " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.p=
atch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.p=
atch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.p=
atch \
-        "
+        file://0060-kmod-add-net_admin-capability-to-kmod_t.patch \
+       "
=20
 S =3D "${UNPACKDIR}/refpolicy"
=20
--
2.43.0


