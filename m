Return-Path: <gmisra@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5326BCC6B00
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 07:01:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10248.1775113308921209856
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 00:01:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=OvXZpWiE;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: gmisra@qti.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6325Vfx3091589
	for <yocto-patches@lists.yoctoproject.org>; Thu, 2 Apr 2026 07:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=ciKuWIsXkmIoXJXYQzC+u080anumU8X0jZb1jSzvuNo=; b=Ov
	XZpWiE02TnSeNLp7KL9UQQDj9RTqc6tZbJ/kDLwSKXowtTeIIwyiI0UF6Rt7IUGt
	AMwDiu7BNOgMgjIJWAmZtO4vzjhCz9ybszZR7W00HNeEvJ4wpmyEqkaYFS52HsQo
	9HlHEZ2A3tj11FO5qI1VdMo5FxrVyDlNKXWaVhVHfBbdQiUtAEVE8ITrht4qnQ6f
	lk5ee1Pe0F5pcmwqereVGCWO8mW6inp7x2QQMEnbSaI1B2yLySMcuzrlc3jBw7HA
	nab/x8yq/n7SVGu+63z4z7yqadLVww9RBlKJrynNUEvHTMiPX/lgRxFaIi2Nm1Pw
	ltOV7bfdNMmJZl/9f8MQ==
Received: from bn1pr07cu003.outbound.protection.outlook.com (mail-bn1pr07cu00306.outbound.protection.outlook.com [40.93.12.6])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9jcu8bjh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 07:01:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj1zecFEylf0sF1XLFoe9BEULfa5wNOIwRX/Z8du3C9AgGbmvs17b5Gyq1zqH1Iwpu1mrFurCwH7rW9oCzmUCphQkAXHoJrEo6KPVF4v6W6ZfA1o3Sjs3llMeVXaK8iKW0kkWR0VyOf+93FnWqxii+N5tF4hRWWBubieTIPTkLHoEQAddC/XT8eViVtSbYamK6NBBq+8uKL0wkQl+9KPFc6iXVk8eQjPd6bRK4Xw6cPk0D/l8zr4yONOK90XUWQlPEG6t+0a26lfDGId3T7Nqd6ErOWdlz0yhZmp+E5cbiWwhASim8UsCkCd2IafybQVOJL85jK4FNGMrcVjpUWUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciKuWIsXkmIoXJXYQzC+u080anumU8X0jZb1jSzvuNo=;
 b=hV3rYAT8L2vTE/KY28W2QdYm8rrOrKDWyU37etc8CUdRaZn29Og0+2ZZOcMr+EEn4PdPfTIcaOs8kTkMlhhYaAvGNfnltPjfIMmhANQ0K/AaAXpf2Il6lYoXduS6lAv9uLiJ4vF6FEPTUK4CzqthahjqRgvL5QZ+BXIcriU/dphs3xPDPnuo9u6uGf0K6tlDA/DvIu6vYzjd/fGxdBE2//4uHqf3sxTJQic0TdHRdF5T0RyAHDg43hjQc2hWCzQxzEOATmSUZPMtQNWq2IeUYQiasQObhuWgk0PUT2WK8fBJkUfEaG8w7cSd5wMgfJ2VQrmABzVlwmOy3Gb8oq3KAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA3PR02MB11199.namprd02.prod.outlook.com
 (2603:10b6:208:542::12) by MW6PR02MB9878.namprd02.prod.outlook.com
 (2603:10b6:303:239::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 2 Apr
 2026 07:01:40 +0000
Received: from IA3PR02MB11199.namprd02.prod.outlook.com
 ([fe80::d20f:d3d6:cceb:337d]) by IA3PR02MB11199.namprd02.prod.outlook.com
 ([fe80::d20f:d3d6:cceb:337d%6]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 07:01:39 +0000
From: Gargi Misra <gmisra@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: [meta-selinux][PATCH 3/5] refpolicy: Added policy for
 systemd_user_runtime_dir_t to read tmp_t directory
Thread-Topic: [meta-selinux][PATCH 3/5] refpolicy: Added policy for
 systemd_user_runtime_dir_t to read tmp_t directory
Thread-Index: AdzCbnCoSpcItYpqRni/fnDCOK5Clg==
Date: Thu, 2 Apr 2026 07:01:39 +0000
Message-ID: 
 <IA3PR02MB111994BF0095DFFC47F0BD816F151A@IA3PR02MB11199.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR02MB11199:EE_|MW6PR02MB9878:EE_
x-ms-office365-filtering-correlation-id: 526bfe91-ba5b-4a13-21b4-08de9085b06f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 TAOgA5SY+8AWr4YTYg2hAfKC1stvTXJbSkyRcHHdE3g32gaqQFSgvES2XMfvCrelMQHyP2Y2DcHkBimbRGWkhjYLToivg3MWx7v7opfhcca7ypJfV0I01yYnC1CaVQkefwUysGRwVdpeHdP2Nip9+lvK0NZAop5r8S6MRFCN5TLNaEhz6Sw4rsw1z2AyX1hT/2rMkimTXPF7L43bnaFfJjY3is9en997XNbGWWhqGV8gjR07JRWggqypKshKTj+CMawImW9MOW6fm9WSVvQZAwTvMSLAFUPyeUUy6DOax/1YcbqIc5uZAibTpFNdDP0RiRQJ+mMNWipBtQFSHbfCd/feiNHJRb9kKxhCByQIjeZaZV4tBHao56rv5rt1gB/AZvIzQJzKniMW6Huk4OwwjwwMCngAk9q5YpYlUHpVUNRN5cFjGMjNyiiujb4F2Eun8srQ4r0bTKYV9ru6/CGTiKqG/5mgHh9S0L3jjCmSo3A7keP69dyE36pI7JZCjTKWuFgun4uWzNy//o5KmNpQAhTtFWj/Spcat7RN1eb+TeJG8gPEqGo0YtzuEF0I69F8EcQ8ayVKqNeMfu6o/r8pG1uLMCq4bEzqNyagl7woW+fwurXyqOkxJE1XHAsbb9V8YpDIvQtRgaKCkiE986l+90yZbatc197vbieR0NFSPf+lRgV5MZ06FgbDk85nSzQZCFjAHL15QDHRNXZzPEaTNlUNMTJOc4A1JryOn2uVnXuKCWmu56BWoAuBaQNFYtHc
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR02MB11199.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/gPE/nuwVdybG1XcHFZrvGmCn3b9DtFLm3KdrZjCPsDNLlVDlwSt3dpZ1JFv?=
 =?us-ascii?Q?sWXk6UzoRZD0UCmbR8MOpnvAKzBnLH0Jg5f8LI0E3ZG8UlljHtWateqhX95q?=
 =?us-ascii?Q?a13RnkLJUrYUBLMDsLiEMcWiAZen35vivHbBRxbv2b42l1BuGJySnaK7MD9u?=
 =?us-ascii?Q?q31CJNWVx1oQcl+RNqkSicWjMgrkDqaUcGUNCtu+/KClxbifgNfLkz66wOvZ?=
 =?us-ascii?Q?9U3uZ6OC/lJ9tUWKAYv4xAysZZZq7z0syUPL/B2pCvhOspDwoM6nO+RbVp7V?=
 =?us-ascii?Q?PJXIW+JD7j5jPvphuhs12VCjTLliBQok2NychR2wFjqo2ukbxCsg2XeLe20y?=
 =?us-ascii?Q?Xbi2qNWXy+p6f1MAHKLhbwJpVUjB8zZM5/fHF9RkmfabYIhKk5JUFmbtHHi6?=
 =?us-ascii?Q?gpxf0ytzsmsFdl5aPGsK8UbGtyBYzkovFbo+G35m4TtCPV+knm+H5pX7ofz/?=
 =?us-ascii?Q?542FTrhLEbzYUPYU2BtQkFqJXcVWuk5bKdlbclYEdLNuwCwrxgPIN79jcn9j?=
 =?us-ascii?Q?ziKh2IeKksrsxi8k63dcF63mvQtpfALVVDYftYL/IcBb4GC84SpLjDCZ7vHy?=
 =?us-ascii?Q?oZuOGEl/GOeQ/WMCQAVcGuZfL+BVzn/rHfZ+gMWnFAvl/TSehywwNgio6h9p?=
 =?us-ascii?Q?oP90xe7hmv0eWfr0T/vxkGDlZyccDYL6sQbOCmokkuAEvQqVJcO0Xu9sLJ0D?=
 =?us-ascii?Q?zumAfL5gfPkraUuguzvQSCf/nkAxFTJdL19cG++Vllu3oyIeqHrLb//Z9K5o?=
 =?us-ascii?Q?BnW/cwrPX2Jl65AudHzKboDlgeB0j77kjwSeb06mcfkEJSxTn1u+tPHD+Rsv?=
 =?us-ascii?Q?Qnm653N6rkadvdcv8z10OQUP4szo4nCXbpCqVEaxJZmCOtJhuHGJYkG+ddV1?=
 =?us-ascii?Q?r09x3aeWFDmXKZ4zjOFs4Q7Q1fOd2KjZtRxp3I6Sq2Vqq+4sedUWoq5FgtUN?=
 =?us-ascii?Q?UeOkYyvfnXigzh2uDU/azgMMpAvGJDEicoJbblWppElVJKSiKMDNYsHdZYKq?=
 =?us-ascii?Q?XhucfWSUO4bz1ZuuUqZ1zc9WZ/raX2bXEjCjaCU33Uv8xOWA7H6bjk6aNYkT?=
 =?us-ascii?Q?S19uZTrV+YcE1Lf062mT+N709vEJIGkmlW63D+VHSWjIJu9DRDy9XASP1rW4?=
 =?us-ascii?Q?84sIVZavReIICjMa30gOrrvAmAzcsjzzDgxvCA3sisTYlswsJCq8mm9p8mS3?=
 =?us-ascii?Q?g2G4T4gVdj750MJJ7KHwFSeAqv0w6ViM5rRv5VoqRHzGKnFJDAC2U+Y8k4N/?=
 =?us-ascii?Q?0hS4KMYtdFNeG9nZhgM5eTMvB/MRVUxH3StG9D8y5Me5L+pz/J8IIwqWL3qm?=
 =?us-ascii?Q?6ZMx5nHeqkiwHpC65uobgtD8bmjWBl7A6qR7jqiLzuOExnPGJCtsnJIVxcO4?=
 =?us-ascii?Q?GjVFog2l2VDV19tO73SWmXGIAx6TIlvP/7h1gyETHs3veMrGtlxWv5CbdBsQ?=
 =?us-ascii?Q?xRjCt3uF4Z1YNw4TMyi47HwFLa9W9QamzAwkPOFrSr7EqXpXOgrtguZh8i0h?=
 =?us-ascii?Q?sz6c+rO9mlNCvyOKSZi75ljadZ47qHDQndq3z4n55zYIMXLxZj3ojSOEF///?=
 =?us-ascii?Q?Eq6mSACbqwiY1Vc1GAJgjfudPgWWGsSCLfu7ntEkuwFq12hoaG5ZOczWaZ5x?=
 =?us-ascii?Q?qhq4OKdxcqytcyXlQnmos4fy/lyzzbI8SBmXqS0+eYALi0FHu5FbqlRzTSmq?=
 =?us-ascii?Q?3/scKjl+OTu3pe4ana99vIoE33GOLw+t5nQlo9lwck2INpjSvje4q9XvvdWQ?=
 =?us-ascii?Q?6EC/wXZZDg=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_IA3PR02MB111994BF0095DFFC47F0BD816F151AIA3PR02MB11199na_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	OrwYCjRdf7c5T3C8XadcKhHIfTSaL84Gwv6H237+RJ+OkOAHSo3UZ/3MFJf9KpD7JDvQfkxt4iprA4gVbkWNTBef5WsmkHOa2FKcyu/exMC+OCc8oMkYOsESAhO9vKRws+C1FkIkYGwKQraDnmQEWP5Lzu153GzLGq/Hn7MnqX+6jXFHhSMLyBHq0+CleiYeN5U2PiEGoGsO7blPfWTQBvGrGJC/Qh2IRaRycgl71sQ2rT1niZitPqc9vPgUX5AFSDr4vp1pyyrEFlNaLTgqpBNI3d3iD7LrbqbYsxX8OnFzqsdMMiBMm13Inmw/1nrfVVOiSIlg0s3WKJO9Dtxaiw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/XnHPJHEGIZPQG77Y+u6N9KfwXzbq9jPba5OD9fdvCnwqnHxkvamZ9CQCBZmgNIexw9vgha2Jg4zOr8kIwNDOtH6ivcGT0YwEb8fXIpNLZFt5dNBWGFHOQzprnnXZ+w7zj4hwvm32rqaJW3dvviiFc8dAsG1H2fI0VBl9n29V8FgYq3I02QGTZ3Ehi7fs0UGLlZ6NH682RO5s4nLER9Jqgpv2kEW/duX0mQYRQ3p5W8P2RSi2CVylsn2G2tVFFaxyVR9MjqiBir4efy/Yg9Vo0+9tscmX2Gbi1LN9kkG0VUZXUBQllwMrjoJugSjKaZY6dQvSwQ+a2Ky+FFVKpH1bWW+Fo44ar+6R3UW9EvJxkt6Ca89/6K0cEJeaVRmg6SZdkpsdgMVw6TMWfwrUe6WjkZYqhLbQA8yOf88GJs5gXtm72xiAIiNqI4q2b8f2vT5HRpDEAGb2fcQgztuzIYkUoFrMKW+ufMjXgiAcExhxK5B+Ih6f5xuxzNGs1q6v6ysa857yNX8zrac/CG3BbvNBArSG/6vuvCtE94C/8Ikox9M42fX3doOu0Fd6JeSu1UuCXKd1ao93gUHYCDF2KX1Es2iXRnh6pMFWADXro3znDEFW1nsOA8X0tBExB5PGBh3
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR02MB11199.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526bfe91-ba5b-4a13-21b4-08de9085b06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 07:01:39.7798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUq5ZEATZEAx38IhrUfO9wlx+6blGQXxPCtutkB66m8R/k1hMIhCSP/BszzvxHGT/ClPONJR/JxkaRn9YlvXEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9878
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2MSBTYWx0ZWRfXw2JjXVY16UlB
 0OwBZ2v3f3s41/cB0KWxo5YexCD3rHN6FL8rifq1dPi5b3jAPTTt2j9YKlQR8b+JhMwkDGF7jGF
 cv/KCl8AJNwYmRdjKB27VsMbDSh28zOOVVekT/AIWwrlDkb7uK2zyKxFo4WC+woS2M9hsvGiqo4
 b3i7ElgJ/1Jw60MTZy+CY437DxVKpkwf1/7mGzVXfNPgiQrCf+Ks+Y7CAWdAJn2C2fVD88wSmdw
 SKeMBjqZhpMDhZ60GqnQF88yuSsnC746PLk3mNvfwClvoMeCv22DuCfbnXSJ7msx8cVm8PyQ7bJ
 vZV+wifCLYQTpw8UzvCoL/HVqlGltlzi6SwNuEjKL6hw7B4yxI+5BrJ6/2nt/fLC4IBvF0Fz8/t
 7tve/h72XtB1ldfwh0aEtlveapq1WxWaIMnOa2T4GLKTBeC9u6kogzflWpjH/ngeGF8JkMQb1oB
 Ab+pExnGHd3mciUglSg==
X-Proofpoint-GUID: KyNwgctswCcfff9j5kTNtZ2QglzjJyPC
X-Authority-Analysis: v=2.4 cv=eYYwvrEH c=1 sm=1 tr=0 ts=69ce145b cx=c_pps
 a=vyniI6In/5XBr/U1JZq+ag==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=OM8fqfX2V_RMQ9N6vYQA:9 a=CjuIK1q_8ugA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=MFkjKvwAb_bD772jJ4QA:9
 a=i99sqPLXTsBX12wG:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
X-Proofpoint-ORIG-GUID: KyNwgctswCcfff9j5kTNtZ2QglzjJyPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020061
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 07:01:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3606

--_000_IA3PR02MB111994BF0095DFFC47F0BD816F151AIA3PR02MB11199na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

refpolicy: Added policy for systemd_user_runtime_dir_t to read tmp_t direct=
ory

avc:  denied  { read } for  pid=3D1201 comm=3D"systemd-user-ru" name=3D"/" =
dev=3D"tmpfs" ino=3D1 scontext=3Dsystem_u:system_r:systemd_user_runtime_dir=
_t:s0 tcontext=3Dsystem_u:object_r:tmp_t:s0 tclass=3Ddir permissive=3D1

Upstream-Status: Backport [refpolicy: Added policy for systemd_user_runtime=
_dir_t to read tmp_t ... * SELinuxProject/refpolicy@eef80d4<https://github.=
com/SELinuxProject/refpolicy/commit/eef80d415802915a577584ccfe473bb2ad8e3fc=
6>]

Signed-off-by: Gargi Misra <gmisra@qti.qualcomm.com>
---
policy/modules/system/systemd.te | 1 +
1 file changed, 1 insertion(+)

diff --git a/policy/modules/system/systemd.te b/policy/modules/system/syste=
md.te
index 2cbb6a3628..63b105663c 100644
--- a/policy/modules/system/systemd.te
+++ b/policy/modules/system/systemd.te
@@ -2450,6 +2450,7 @@ systemd_stream_connect_userdb(systemd_user_runtime_di=
r_t)
files_read_etc_files(systemd_user_runtime_dir_t)
# read /etc/machine-id
files_read_etc_runtime_files(systemd_user_runtime_dir_t)
+files_list_tmp(systemd_user_runtime_dir_t)
 fs_mount_tmpfs(systemd_user_runtime_dir_t)
fs_getattr_tmpfs(systemd_user_runtime_dir_t)


--_000_IA3PR02MB111994BF0095DFFC47F0BD816F151AIA3PR02MB11199na_
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
licy for systemd_user_runtime_dir_t to read tmp_t directory<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">avc:&nbsp; denied&n=
bsp; { read } for&nbsp; pid=3D1201 comm=3D&quot;systemd-user-ru&quot; name=
=3D&quot;/&quot; dev=3D&quot;tmpfs&quot; ino=3D1 scontext=3Dsystem_u:system=
_r:systemd_user_runtime_dir_t:s0 tcontext=3Dsystem_u:object_r:tmp_t:s0 tcla=
ss=3Ddir permissive=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Upstream-Status: Ba=
ckport [<a href=3D"https://github.com/SELinuxProject/refpolicy/commit/eef80=
d415802915a577584ccfe473bb2ad8e3fc6">refpolicy: Added policy for systemd_us=
er_runtime_dir_t to read tmp_t &#8230; &middot; SELinuxProject/refpolicy@ee=
f80d4</a>]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Signed-off-by: Garg=
i Misra &lt;gmisra@qti.qualcomm.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">---<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">policy/modules/syst=
em/systemd.te | 1 +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">1 file changed, 1 i=
nsertion(+)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">diff --git a/policy=
/modules/system/systemd.te b/policy/modules/system/systemd.te<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">index 2cbb6a3628..6=
3b105663c 100644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">--- a/policy/module=
s/system/systemd.te<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+++ b/policy/module=
s/system/systemd.te<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">@@ -2450,6 +2450,7 =
@@ systemd_stream_connect_userdb(systemd_user_runtime_dir_t)<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">files_read_etc_file=
s(systemd_user_runtime_dir_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"># read /etc/machine=
-id<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">files_read_etc_runt=
ime_files(systemd_user_runtime_dir_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">+files_list_tmp(sys=
temd_user_runtime_dir_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;fs_mount_tmpf=
s(systemd_user_runtime_dir_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">fs_getattr_tmpfs(sy=
stemd_user_runtime_dir_t)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
</body>
</html>

--_000_IA3PR02MB111994BF0095DFFC47F0BD816F151AIA3PR02MB11199na_--

