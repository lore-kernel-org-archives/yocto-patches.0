Return-Path: <rchiluka@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C8C98304
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 03:35:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.121.1790220903504560317
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 20:35:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=avxRik8f;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: rchiluka@qti.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O36hNA1574243;
	Thu, 24 Sep 2026 03:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XX9xlE/fruRS5nQh2z0oYzr1
	NiY0Iyyalz9aUtgyJ58=; b=avxRik8f/ATtcU20/CPrvnFbO0LetxcZ46VGnyD7
	wISzOBNvNUZ0AkXXGc7isrQ+Hv1KmkiaZB5Hr1P0hRdnqLSTEhaHY+HIRpUNV/U1
	o9PACye0aNGvvndACt4rwdGh95pNBpphaD/wYr1XSO9O4JQ5h6tTpYmIPKHe7Ejf
	ZUU9pY7+9FUeraUlaC+qNqtWIEjGeR64D8therz3H0dZPY/OHdiP5vxHknQkNaJS
	z4+8zsEu+NzFZvrERWFZJfl5cJlJfJjEMP3j5MNRu1Z/IRrd719xb+PpdPKxGLAa
	oN9COL5bIdFiXfBDHEpY+UUMgzPAmYHT1xuvCj+SyGu1bg==
Received: from dm2pr04cu003.outbound.protection.outlook.com (mail-dm2pr04cu00304.outbound.protection.outlook.com [40.93.13.60])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvdb63npc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 03:35:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ap8dSxcbUk+pxI29/1ZqOmB69lK4sj2oTX6Mr1U3miVpGAyylcTYjsykYmAktCfnyrObCAl2dQXtYRAL0tYIsqGs9O3mq/2tFHmJl41mB2An7PnMGG8EB1cOKzBEJ0/yBWO8mnnA525DcaaKWIZktt2JLahGHR2g5e0l7w9US/cHlnKxfYEyeobXizAbu6udQ0vTRRbP3m6cN+EacxI9Op1dNHBp2c6L6/+1NOaiiyG7dkLeWGx0Ukr3qnm+fKuF31mHEj0miokDymfxtXr35PKPxkX/l6IJJo84uXhmX/ZsJuMlDXibi8R9AnraLgv4tbzKRGgQ/bagCKAsjbih1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX9xlE/fruRS5nQh2z0oYzr1NiY0Iyyalz9aUtgyJ58=;
 b=P3uDjkaW1Ztb34oPVy4pN+kZKtFhRoQUpl5zqhTSvYV233APmfpj37YXJXSzpNzJKiM5cxa+EzOvKMqc2KbNP/jczqq4qlUH1X8wldgvsnz//a4T7JOqX6z9q+Sc36tJmoulyD2snF/VpJ2i8/igYdqsvEPlD9d7leW2EJL2UodndBpuELabGssho6I/dVcV2oIUdAr1W20vBR8MfIpNAu4O73X83ZTkNuJ2dunGfCQYRLyNo7BkVUzlPLq6/iyCZcbCgHm+y6tvA1phzeJdAO799i7mHHrJs1jDBNS1WD+nWt7BPaV8mKdQtoolGYH2dhHbbTUrAiGTuqNYEukb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ0PR02MB7821.namprd02.prod.outlook.com (2603:10b6:a03:32e::5)
 by EAYPR02MB11604.namprd02.prod.outlook.com (2603:10b6:303:2cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 03:34:57 +0000
Received: from SJ0PR02MB7821.namprd02.prod.outlook.com
 ([fe80::fb73:7e6:d2dd:1863]) by SJ0PR02MB7821.namprd02.prod.outlook.com
 ([fe80::fb73:7e6:d2dd:1863%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 03:34:57 +0000
From: Rohith Chiluka <rchiluka@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "joe.macdonald@siemens.com" <joe.macdonald@siemens.com>,
        "yi.zhao@windriver.com" <yi.zhao@windriver.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] refpolicy_common: strip
 POLICY_CUSTOM_BUILDOPT before passing to make
Thread-Topic: [yocto-patches] [meta-selinux][PATCH] refpolicy_common: strip
 POLICY_CUSTOM_BUILDOPT before passing to make
Thread-Index: AQHdKh/1xmlxj7NpcEeRwHYQYO5nFbbdVcd+
Date: Thu, 24 Sep 2026 03:34:57 +0000
Message-ID: 
 <SJ0PR02MB782167ECD2C832784779793FF1812@SJ0PR02MB7821.namprd02.prod.outlook.com>
References: <18CAF96EA9316A30.2512403@lists.yoctoproject.org>
In-Reply-To: <18CAF96EA9316A30.2512403@lists.yoctoproject.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB7821:EE_|EAYPR02MB11604:EE_
x-ms-office365-filtering-correlation-id: 99f0a8bb-de1b-4e95-ca40-08df19ecce6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|4022899009|23010399003|376014|1800799024|366016|10067099003|11063799006|8096899003|22082099003|18002099003|56012099006|13003099007|38070700021;
x-microsoft-antispam-message-info: 
 9vAUQJc3+SQ7zNiVT6KndSfV6196sEucSDQ/t4IrWnl1m9fNNExUhAkm/c+lxq4fimxvInU/Jfv22o7cAD1nx2e6WM++/ULrk/EJge3/PmXpFRoPZMdZYUN4faKNif/HpgsdvCPi9/TGmc/aSfxC4fM0fJUo0u2gA963GVhJbST/kaBNNAiYUtFOLlValA9iudKp5fE8SyeVWDhTRcRZWEG78Zgq3iD+3jQcvUD7iXx7xcDGeRIPEFjr7R5LIM/67KY9OHvBzjQRAZ8P0KvS62s5GavKeGxO+ZEQt1lzjXJFvYp0ffE3VKvo6429KHsVdr9vlYMc7FARJBciBZIRjE12OH1rk3tWeFGAkMXEETxe2+HgB2bNqL+g51EMm4W0zHa/x8AJpFd++/ml/8ObXuQKzcGG/jEjosGCGVTWP+8RtUzZsCk1WSr2PwoQ5iqeTq0jSmIci8B4osfrMGZZhw8Et9k2THq8QftO64erFWF8dxUVz81M6l3NMZ06CdKIqwDjrEiBkLuQzdcdz+4DO7IgWlxQcMhBof3xxUiysqeBvpWzME82cxNiW9u7vBzxudHKYGYZLjcq13uVtsClG8R8geMj5zj+5lOOM9iA0A+j+NIWPLFE4AVaBHcHijRve6Y96hH7Y4fEl0s3cNyFh6nnXg3o1naaHM75jg72cOs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB7821.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(8096899003)(22082099003)(18002099003)(56012099006)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?n11TQSGF+wxo7EAkZC2l7D8cU52Zk0lGHKqR/V99HXhtT/Rr+cJnHttODfq7?=
 =?us-ascii?Q?fnDtKPY8ic0+6zwnx94qkahghfwRjAGiEv34buZOd5Y11jg4Or2ObTrntYTB?=
 =?us-ascii?Q?2vTTQZhtvLiY9tXj7wbDJ77zl28iEgNshAtccntLiTPAIfXVb1rhIeYxGhc1?=
 =?us-ascii?Q?bmP3Lv3ZRENFt8Tqp9+fThMovVxBwCNqwIj6C77keP8FIOXzqMBmCfMZy8+W?=
 =?us-ascii?Q?/uDyqFpo9FfoewhnCNq75yhjzo61sm6wyhObDV0KEVUQi9pJPWqq0jFJzOrf?=
 =?us-ascii?Q?QCTnPID+50vxTA01cH+E0K/k8nYKxMhNK1aH5pogI4ow5WyBjtyOBKnkTNaz?=
 =?us-ascii?Q?wd/Se53pSf047WZ7sFA0mRJRkdPGos80qDMfvw+AjMZOcgVjh0rozwApJa++?=
 =?us-ascii?Q?0gQKeva3epBfoFLdFR4UmGmicptDh2soH3kmzDwWcvqV5zXwDD2agm5hkc7V?=
 =?us-ascii?Q?zoAVfhXjnv4jQuat7MhEDHgZ+qNVSYkwRFALz/VF6DcLdz6uLuYGkMVRcpxt?=
 =?us-ascii?Q?bTK/rw8KPGo6aPPXhOo8ikE4nglWRxAb86Rgfyjp/hXHParSa/0+m3w3pdf1?=
 =?us-ascii?Q?UZh7dBspUEYsEhD1qRDVhvQYVytrKt46DNaHs/w41g1S/tIb0pG3nVrFxWgZ?=
 =?us-ascii?Q?C5icjWFrWAwbvn6QDlhHWkVinn8m6EFHj6661ERjrKMbacMHdxC58mGDzMnA?=
 =?us-ascii?Q?hiDtTZrSTxuz4bH9CtCxF76e3HeAaZNHVvdbg3AzAoN1ifr6kcd/e9I2y2DX?=
 =?us-ascii?Q?Y/Yu6cY02sAY/SQ8FJ89d9pPsJma/GkmSEwyvgtOCUzLghjtcHAonxEFGhEW?=
 =?us-ascii?Q?unTSehoNEZ5cd8DDJ9CAtphWdGnCBeMnAamULEALdFirEOc5r/wtBIvbuuf0?=
 =?us-ascii?Q?wyRhx9vkLcTTMO6On15KLE4T9puvUh1G+u96fK2EeIz4nMGLlct5qgZLctxX?=
 =?us-ascii?Q?O/gnGbhzjrchnhXKZNUveJSNV1+5loDTQk8OTpAS28TE9dol2hiK9y6z/9/5?=
 =?us-ascii?Q?45zO2q6yu1w8OdnZnW7EgVDHTZjKU37Q+2raBbbDuN7nkE51BoZUDECQrVTG?=
 =?us-ascii?Q?NG9P9oyW9buDEoGXfYEsCrN547KAu3zICgVZTfNtWdHAw7TTDKzAVlVPkSfp?=
 =?us-ascii?Q?hOK5mvC+4qhjeaIqbmMnOHuHIAiUCAqpgs5swq1Wthiz2s36b87rR4JvCxJs?=
 =?us-ascii?Q?H8OjVNvSZZLzfd5cbJ5xKXqOWi7BjaAhyAWVVOFzS8zDpSP++poWyNsjwtKN?=
 =?us-ascii?Q?sv1PDIEfGrdMYPqg2rkMTkPC2LGFT7y9OczSF81XtWakf5DgP3CPSkccLaTk?=
 =?us-ascii?Q?I7TVsbacm5pNV+4/vT/jqHlGtVDjwcHm89c6dtcVHTIR4xcVFL7kpYv9w1pO?=
 =?us-ascii?Q?SbgMiI7LEBiUYDoK6ZbcqYHcB3SwIZb9Tinkz7xcw58XVyD+tapInh6cL1kt?=
 =?us-ascii?Q?vvlAL4RqePLpbCsC1cSPJsYwn0LOWRlZe3rsfP/IkMCr+0Y88OiWmKQwG02G?=
 =?us-ascii?Q?I+bG5JmHhjJx5Vauh345hWwnMHBZkWGmvbeDNdYk8DzT5x8lu5SNtRmYkXRU?=
 =?us-ascii?Q?qXTc9/uj5DzK47BVb2VshgrALd9w0g2j3C5GGKIb4tATe+e/hQu0j3TSgEqb?=
 =?us-ascii?Q?CZPT06pNeji9/bfPEaNjLbq0U2qX6m8kwdBsPyYBy3x4NgXVrCsHs45pVwI2?=
 =?us-ascii?Q?hl/1MJOh2wswPIO/sdCKVF9NwMCUCjTeATk7T7mbvt4IkRNb04wwOc9dmv4y?=
 =?us-ascii?Q?0++Vf9gBez7gjNoQCYdYQA9lohMP5DI=3D?=
Content-Type: multipart/alternative;
	boundary="_000_SJ0PR02MB782167ECD2C832784779793FF1812SJ0PR02MB7821namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	kHRbluwatMCFj2loCfwYttNzHIT2VZY2Xm72pb9+vHUq6hOzXZWObUvwo1KLn4tTe+PNN/BGbjPkpQY9fdpwLjaj00lmakZcavTQo00Uj5ESh9ruql3jq5Kg0FcBbhKiE8/a/bja8+p3NTXAdje9qkJBDA7fLfjXNNeTY4GBPQfytpAQpnua3d9zfGpFz95eFYTUtQXvzAnUkCA+QDMZI1+Bf/CC+amVJVRBjJAp5ljoOQivWMTkwc3jaQfrQBXVFxo+eDTlFhYRRaDMyPOnC3nVAIOp6i2ZsQXo3pcCOSGJ7R4DDMqiYmXEEQDvFF8jGSVq0Tt8svgU4n3k5Dcvxg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zRdvoEizevKp1I2/4+VdJ9vTEAGiM1GaFNHQbO4zcQX6uXi4YFrRdacwfWLT2+TeXkwjPupX1A7jwH6XoI1oEu8JxeEn1KRrj0R7qrXPRhjn2GvQLFy1IbqqU6Eab+PlY77N3KDUGNsRIA7/jcDqjia/2PqYby9QRCOrXkqVeomiaYtIMQiuWboy3jAiXAEFUQeD/9WoAre1bt7qTpxYc1f7TMGWeqKs6ovUBSnshccd5zm59nUSYNfXaffE01FTwCCltnz+VIOcCNagf526tu0nB8ihF/tO3dMzS5ti7kbTiu9+RU69OaYT3z3PbM3mjhK8xMzkQgTInByg3mkZraafspUJRSI/NTqKb9yke9eyJwjFj9fQ0+/VFNn1YgU2VpP/Uu/gx7CRwsigYtmGKeOCyGufi1gPderGIELx9n4CJjRd9YLv4JbywXoJ4A12f37DFXUzSQNLRWx0g9Ee6pLCV/opvieFLy13jEE8qNmGFvKD+FnsAGytprVr7OF9cDxuNEV6UbYV0FN+ooA1PQUVtxRFeHYm7x/ZB0PcCuIzau6HUwMMD3DlMqSINgklAM1MZHL/KO0K01X144mGCVDkPqcxB6A0ZtIKQXzPf91Tll6Ir137+dMDgdGQgNdk
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7821.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f0a8bb-de1b-4e95-ca40-08df19ecce6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 03:34:57.5712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prwF8qKBLP7ndVaojHkXQmc9bteH+PnE/6d7+RJwJRztxSehgzYqBzTSXpJwcECIkj7+eOnPtLhZZCsjJ6TovcQwpIA7tiWCLF4AtXAFbjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR02MB11604
X-Proofpoint-GUID: 6N-dGt2B86B4dUArbXZLDM66X16BQIWu
X-Proofpoint-ORIG-GUID: 6N-dGt2B86B4dUArbXZLDM66X16BQIWu
X-Authority-Analysis: v=2.4 cv=QeXzLcbv c=1 sm=1 tr=0 ts=6ab49a66 cx=c_pps
 a=uRVskSteZEZgYXEASZgzIg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=a_U1oVfrAAAA:8 a=t7CeM3EgAAAA:8
 a=EUspDBNiAAAA:8 a=qVHhWA6n2XqJXT2KpucA:9 a=CjuIK1q_8ugA:10
 a=-sqE0KazafgBaBMec1wA:9 a=HrOaO9685kreGuLj:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxNiBTYWx0ZWRfX9xrV6/kGbz3h
 truhbIqbCh3ujK6yqS+rRM7FZy0vOLBFUQGP3IPNM0WWPtfRgavWHhvOej+mFkmih8YIhLR3FJZ
 Kt94wdEaiEiD01UQEgOhyQqIO7f+ro4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxNiBTYWx0ZWRfX2AJlrd3boeq4
 lDiv0atmf1bTO8Vargf5qfCtQb1nv0jugZmB8IzBN5yww/KystRAqlONpN8Eo1hxV/HDBH8qUUh
 Gn/FtZgLrnI2ZvrZz+RE5HsQFv/d/0zn2qOq6gE/s2mt5kgT0sDYZHJLPswZaBHRbHCk9xgzVR1
 10iib9ECEcSqTmF1Z2yeLMCAqixgUdEMBCDUgfM51bPiBAfxbIbvb7Uw3i0B+4AYK/9CHlXgerM
 crlLvmmQDwPrn0v1OX7Xq4PfDnf+ZBO8am131UFPd0HQsdee8A6xRTiGP7R0BBUPUXed0wfCbuA
 wqRu+z1KKqbgUA2MUUZsMuS+JJNRy+FcyVGO40xzYfrnRMu4H+6iDcNL8QMEuGdcdMHXlD4oMwH
 wA4ae68lN3LsgrnIm7G3gZiFCLYfOvG2XYoi9sJXBsu9uWscZEWKszqHj92F6RhRDq4xDh/QBcI
 533iMexV2QGlh7ocg8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240016
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Sep 2026 03:35:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4949

--_000_SJ0PR02MB782167ECD2C832784779793FF1812SJ0PR02MB7821namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Gentle ping on this patch submitted on Aug 12.

To summarize the discussion so far: Chen Qi suggested using shell quoting a=
s an alternative, but that does not resolve the issue. oe_runmake passes EX=
TRA_OEMAKE unquoted to the shell, so quotes are treated as literal characte=
rs rather than grouping operators. The .strip() approach is the correct fix=
 as it removes only the leading/trailing whitespace introduced by BitBake's=
 :append operator.

  This patch is blocking a downstream layer integration:
  https://github.com/qualcomm-linux/meta-qcom-distro/pull/383

  Could a maintainer please review and provide a decision? Happy to respin =
if there are any further cocerns.

Regards
Rohith Chiluka
________________________________
From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoprojec=
t.org> on behalf of Rohith Chiluka via lists.yoctoproject.org <rchiluka=3Dq=
ti.qualcomm.com@lists.yoctoproject.org>
Sent: 12 August 2026 11:30
To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>
Cc: joe.macdonald@siemens.com <joe.macdonald@siemens.com>; yi.zhao@windrive=
r.com <yi.zhao@windriver.com>; Rohith Chiluka <rchiluka@qti.qualcomm.com>
Subject: [yocto-patches] [meta-selinux][PATCH] refpolicy_common: strip POLI=
CY_CUSTOM_BUILDOPT before passing to make

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

POLICY_CUSTOM_BUILDOPT is passed directly to the refpolicy make command
as CUSTOM_BUILDOPT. When layers use ':append' to extend this variable
(e.g. POLICY_CUSTOM_BUILDOPT:append:distro =3D " option"), BitBake
introduces a leading space. Passing that raw value to make causes:

  make: *** No rule to make target 'option'.  Stop.

Signed-off-by: Chiluka Rohith <rchiluka@qti.qualcomm.com>
---
 recipes-security/refpolicy/refpolicy_common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-secu=
rity/refpolicy/refpolicy_common.inc
index 014714c..1566591 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -126,7 +126,7 @@ EXTRA_OEMAKE =3D "NAME=3D${POLICY_NAME} \
     DIRECT_INITRC=3D${POLICY_DIRECT_INITRC} \
     SYSTEMD=3D${POLICY_SYSTEMD} \
     MONOLITHIC=3D${POLICY_MONOLITHIC} \
-    CUSTOM_BUILDOPT=3D${POLICY_CUSTOM_BUILDOPT} \
+    CUSTOM_BUILDOPT=3D${@d.getVar('POLICY_CUSTOM_BUILDOPT').strip()} \
     QUIET=3D${POLICY_QUIET} \
     MLS_SENS=3D${POLICY_MLS_SENS} \
     MLS_CATS=3D${POLICY_MLS_CATS} \
--
2.34.1


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#4658): https://lists.yoctoproject.org/g/yocto-patches/m=
essage/4658
Mute This Topic: https://lists.yoctoproject.org/mt/120714231/10516532
Group Owner: yocto-patches+owner@lists.yoctoproject.org
Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/15256622/=
10516532/2082203986/xyzzy [rchiluka@qti.qualcomm.com]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-



--_000_SJ0PR02MB782167ECD2C832784779793FF1812SJ0PR02MB7821namp_
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
Hi,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Gentle ping on this patch submitted on Aug 12.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
To summarize the discussion so far: Chen Qi&nbsp;suggested using shell quot=
ing as an alternative, but that does not resolve the issue. oe_runmake pass=
es EXTRA_OEMAKE unquoted to the shell, so quotes are treated as literal cha=
racters rather than grouping operators.
 The .strip() approach is the correct fix as it removes only the leading/tr=
ailing whitespace introduced by BitBake's :append operator.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; This patch is <b>blocking </b>a <b>downstream layer integration</b>:=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<u>&nbsp; </u><a href=3D"https://github.com/qualcomm-linux/meta-qcom-distro=
/pull/383"><u>https://github.com/qualcomm-linux/meta-qcom-distro/pull/383</=
u></a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<u><br>
</u></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; Could a maintainer please review and provide a decision? Happy to re=
spin if there are any further cocerns.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Rohith Chiluka</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> yocto-patches@lists.y=
octoproject.org &lt;yocto-patches@lists.yoctoproject.org&gt; on behalf of R=
ohith Chiluka via lists.yoctoproject.org &lt;rchiluka=3Dqti.qualcomm.com@li=
sts.yoctoproject.org&gt;<br>
<b>Sent:</b> 12 August 2026 11:30<br>
<b>To:</b> yocto-patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoc=
toproject.org&gt;<br>
<b>Cc:</b> joe.macdonald@siemens.com &lt;joe.macdonald@siemens.com&gt;; yi.=
zhao@windriver.com &lt;yi.zhao@windriver.com&gt;; Rohith Chiluka &lt;rchilu=
ka@qti.qualcomm.com&gt;<br>
<b>Subject:</b> [yocto-patches] [meta-selinux][PATCH] refpolicy_common: str=
ip POLICY_CUSTOM_BUILDOPT before passing to make</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">WARNING: This email originated from outside of Qua=
lcomm. Please be wary of any links or attachments, and do not enable macros=
.<br>
<br>
POLICY_CUSTOM_BUILDOPT is passed directly to the refpolicy make command<br>
as CUSTOM_BUILDOPT. When layers use ':append' to extend this variable<br>
(e.g. POLICY_CUSTOM_BUILDOPT:append:distro =3D &quot; option&quot;), BitBak=
e<br>
introduces a leading space. Passing that raw value to make causes:<br>
<br>
&nbsp; make: *** No rule to make target 'option'.&nbsp; Stop.<br>
<br>
Signed-off-by: Chiluka Rohith &lt;rchiluka@qti.qualcomm.com&gt;<br>
---<br>
&nbsp;recipes-security/refpolicy/refpolicy_common.inc | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-secu=
rity/refpolicy/refpolicy_common.inc<br>
index 014714c..1566591 100644<br>
--- a/recipes-security/refpolicy/refpolicy_common.inc<br>
+++ b/recipes-security/refpolicy/refpolicy_common.inc<br>
@@ -126,7 +126,7 @@ EXTRA_OEMAKE =3D &quot;NAME=3D${POLICY_NAME} \<br>
&nbsp;&nbsp;&nbsp;&nbsp; DIRECT_INITRC=3D${POLICY_DIRECT_INITRC} \<br>
&nbsp;&nbsp;&nbsp;&nbsp; SYSTEMD=3D${POLICY_SYSTEMD} \<br>
&nbsp;&nbsp;&nbsp;&nbsp; MONOLITHIC=3D${POLICY_MONOLITHIC} \<br>
-&nbsp;&nbsp;&nbsp; CUSTOM_BUILDOPT=3D${POLICY_CUSTOM_BUILDOPT} \<br>
+&nbsp;&nbsp;&nbsp; CUSTOM_BUILDOPT=3D${@d.getVar('POLICY_CUSTOM_BUILDOPT')=
.strip()} \<br>
&nbsp;&nbsp;&nbsp;&nbsp; QUIET=3D${POLICY_QUIET} \<br>
&nbsp;&nbsp;&nbsp;&nbsp; MLS_SENS=3D${POLICY_MLS_SENS} \<br>
&nbsp;&nbsp;&nbsp;&nbsp; MLS_CATS=3D${POLICY_MLS_CATS} \<br>
--<br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#4658): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/4658">
https://lists.yoctoproject.org/g/yocto-patches/message/4658</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/120714231/105=
16532">https://lists.yoctoproject.org/mt/120714231/10516532</a><br>
Group Owner: yocto-patches+owner@lists.yoctoproject.org<br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/15256622/10516532/2082203986/xyzzy">
https://lists.yoctoproject.org/g/yocto-patches/leave/15256622/10516532/2082=
203986/xyzzy</a> [rchiluka@qti.qualcomm.com]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR02MB782167ECD2C832784779793FF1812SJ0PR02MB7821namp_--

