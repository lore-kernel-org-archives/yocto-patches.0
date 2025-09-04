Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30848CA1015
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 11:55:40 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.37006.1756986932039385633
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 04:55:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=bV6eaDmV;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=1342b8cb3a=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5848nVws3644594;
	Thu, 4 Sep 2025 04:55:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=EV+9SOVKngenamlT7XsotX
	kap0IbAsu2Dax9dpA3KdU=; b=bV6eaDmVyRGPuFPD93im1TCujVqHTK/4xgGlYQ
	Tq3lqhVO8ssd+xFlqDe9AMSC82bRdoCP5kx50q2Cn2wRl4L8kk6t2oTL7hjD9eLQ
	elSTpFAwkNAT0BDuu/C3oaGjfL2fySrX6/ZPPrCGXc6NEMgC0qF125OQVLugWsqq
	gyDQ+5sOZHx3NbTrJwnYfNRLy0iapCHbKWhTgA5Z+XA5ADQ0VVy/t1MSsMJ9wg6z
	qJ/WzXmNcQazvLQthdZLl2GeB4+qOsZiGt5wjbiXD9n5yy+0tbsnADhCOOImFlvo
	61AWNiPbMsdSRLnMHsiQtqeKrFxni4qQadRXNZtbB11ZubsQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48y7kkg4m9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 04:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZqS3Txd92KAvZBIbJ80+YIFEltuoT5+PimMBcj1lejX1ZWHfPI6QK3tl9QW0A5AlLLEX/+qEGJyLDvaohSXBOEHBl4MGHpxZgehdlc/yM/7z4zUl3Di6uR47GUwbW6bMI+9Xep4S10+8A/LuKn4o4LpgGy//29YU3S6zAy98OS182z3oQ6DgoNvPfIvHVM4LVKBwC2bFHOm3ReNWGwC+QsAe/5yEZtXlws/MM01k3M14YBilHQpAdAe4BuJCnJrYvIxX35RRpHB+k8xy8UQeOtq1clgMRxoj5btLzULkpgQQwmeukpvs/sO2Lvdk7Ee7VcbWmR9afvWkW8PXJEAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EV+9SOVKngenamlT7XsotXkap0IbAsu2Dax9dpA3KdU=;
 b=LkqtgVGZ0eg6wO6A39C+HHnl+c4YtgZDPhjMszL6mhgkJL45MEr8XIOcHd3dbNcsRxFGPALYapQ/sQZLPY6SFCLAkkNpzHfwB1Iwvt4tmGTpsMpWr9JsL453SE17LSkmY1/9E5fe26/QBfPkICBe6SIQXKAiXxwKDXO98H0tzz1UZbcMa2N/eTMx0r+B6ZySBS+enuWYbH0o4srvKJ6ZK5H40H8QeERjff3kmqd69be6/e1ofpViH60kttN0hf4DkuhNFQD32RhfU0z1OwXQE3Kl42W51dcY2hmsLyKs5zipHWewaLFiZ60mTmhqEq6LAEDTGZrdgXf4tTcwB0nMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15)
 by PH7PR11MB8550.namprd11.prod.outlook.com (2603:10b6:510:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 11:55:27 +0000
Received: from CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a]) by CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a%4]) with mapi id 15.20.9094.018; Thu, 4 Sep 2025
 11:55:27 +0000
From: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
To: Scott Murray <scott.murray@konsulko.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        "MacLeod, Randy"
	<Randy.MacLeod@windriver.com>
Subject: Re: Insights from Integrating mixins rust into kirkstone-based
Thread-Topic: Insights from Integrating mixins rust into kirkstone-based
Thread-Index: AQHcGCUREa5GxjpiDEWeb+Itb15curSAZ+6AgAA69ICAAlIpqg==
Date: Thu, 4 Sep 2025 11:55:26 +0000
Message-ID: 
 <CY8PR11MB792179A09F2AA9979A5A8D9A8100A@CY8PR11MB7921.namprd11.prod.outlook.com>
References: 
 <CY8PR11MB7921AAF6CFDC45DD76C7B40B813BA@CY8PR11MB7921.namprd11.prod.outlook.com>
 <3f3df632-63bd-652b-dba6-4a4a3a6a0f93@konsulko.com>
 <271bcd7c-3047-4eac-8e34-13f5f42c7163@windriver.com>
In-Reply-To: <271bcd7c-3047-4eac-8e34-13f5f42c7163@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-09-04T11:54:45.281Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7921:EE_|PH7PR11MB8550:EE_
x-ms-office365-filtering-correlation-id: 42811fdd-956f-4392-5b2d-08ddeba9f045
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?UXkbfjcundo1evCivWP7kVVlR//8PpGTJmltJ79i6u3SbnbqEPQR5ReY?=
 =?Windows-1252?Q?glfxE2VgCi+tAGWX72DfH1izj56xQ5k+NINth21fCxpNuUMTGAprXaXc?=
 =?Windows-1252?Q?5IQUGkEEivfkRm4ebEbPZE5O/pu6bbXf9MNqhZ4AYzCB49mWj0gsbKM9?=
 =?Windows-1252?Q?HQgYPGFDrPPKaaC9OiE2HMMp6v2X4T6/rysfB6Z22DWuwLjJUA95XyDY?=
 =?Windows-1252?Q?j0qwF4QD2Nm6TIdCZyaeCUUTUM30vhOHo5ReVOes1e1VsacsQlFeAUk9?=
 =?Windows-1252?Q?jLKNrwttJhgtlALHzn0F09H1Ylte8xBMb5AQsMtIS3IAAYc0Mdoozh12?=
 =?Windows-1252?Q?8aV6H1rTYHL8uveG9tBYQ9lQPO/oSMR4KBAY/BR81/9pZk1ceRK+eSAU?=
 =?Windows-1252?Q?FlDi2Bx4XjZwA6hR86F08FfutBV79VU6AiZ37/eoFNfI9uggPEYROhPJ?=
 =?Windows-1252?Q?EUjE2EaHPki89h4WBBHonU6cFRpTPKecCBo5/vmWLDMGxwCRtGvQ97Fj?=
 =?Windows-1252?Q?u/mbk663Qi8El4V1MuEGqF8FGVhGlyJNyLDepdjKC6F4FbbTY6Q9i9vp?=
 =?Windows-1252?Q?uV3JNrEAJX8+4hwEXiUytTurK7tfKowonEnEGhm9oJZqI/8hdMudvlgW?=
 =?Windows-1252?Q?qLXjY6qYEXe3Rq9J83/SXafyKBLAnIU4M1yRKE2wM0QCy6PNbEWbjZfA?=
 =?Windows-1252?Q?Zvxy+tABQ9nglhxtHH/sRAN2KLM2GgG2COpuOThPqU88JzigRo1MdBWs?=
 =?Windows-1252?Q?baeae7gA37taho/ikFBeZ4C9GqTaxuQ0uil3LoFOQLsoUIQjprDdHK7r?=
 =?Windows-1252?Q?RAyMtukeXUmJbRRQ3RM5xg6y/0+SSnj/2biJ0EXOYnq1wnVWVWaMsWWg?=
 =?Windows-1252?Q?XFB1wMxL4N0GZ43BqR5U+aWEiLod1mG0XrdFRMV65KqwkuHX1v+tBH+I?=
 =?Windows-1252?Q?DCTiTkqoOvn3r4Tnt08o9w/MlOzKyudH48GPrQuUkG00yQw0+O0Vg5ei?=
 =?Windows-1252?Q?AmcXh6rk3tf0qVgSRg2S4SNh1D0lRBMeVPMAzWZgiyurITzC0wUm6KE0?=
 =?Windows-1252?Q?h60vBd76slU57SotNz9YKDmCJwDFrNtWMk0e1ttBPJRcBx72q3/2g3/x?=
 =?Windows-1252?Q?2riPGf+Sr6TBKsnFpMoG5n/BSkZgSwOQf/X9gzdlfdyQwM1LB74N/8we?=
 =?Windows-1252?Q?bS4TtrhEKmW/qK7kKpyUzhH+KlgkCSho6OmSQhKjrIXQPX74uNi6vVwS?=
 =?Windows-1252?Q?YHVQoE5FYXN+Nl/R4IyleUFK5DE5dt2VNJOjoNczGEg5RTYujXc/J2bE?=
 =?Windows-1252?Q?DN5YscEhon+3R6RUlrIDqM066wPKK6z+73z7Onq9I5AwdPK5chPb80Rq?=
 =?Windows-1252?Q?OaLgB/UiR+fAFvwjd7af79itU2CDNtA5Cl8kgL9OB322+foMbp6/qTJG?=
 =?Windows-1252?Q?p5Ml1p95MbHFmjMN3oA4sWfmICtMO3slKYzscNt0EwHJUmyZhsZBhOqp?=
 =?Windows-1252?Q?6fBm/l3DVKiLpKISftXpSmYzMoAtYwq9G+jLRCfjCEtsD/Pdet9iF9yz?=
 =?Windows-1252?Q?Lsdmbs2xjsxH5HFb16OnGu4UxEXiEKUc65CZvg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7921.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?SiB0BoDMqbKsn5hz1j/28Ev0yTR4dTvOpkgGQHRnhRoBm/kh2CwfmCob?=
 =?Windows-1252?Q?7gj0Rpp2ozJPVytVJM/e4Zm5PLomJA9qjgI5wm9QBLWwcHHLK+iWIggw?=
 =?Windows-1252?Q?SN/thOZNyZ2BoSYqFhejOE2zmEu8zWrp3WeuKh0aF7Zgk4elc5z/p45S?=
 =?Windows-1252?Q?q/GLwY4TNjt1esyQN0rv2NZZMOtfex8+UuYdPS7iaQ7QlitZaqe6yP+P?=
 =?Windows-1252?Q?lbhuWAeoCZobZ1/3FDM+Vrq3AgD0+9CKdhXkRkenyLyUPHekzkKVUrF4?=
 =?Windows-1252?Q?nZsH+BJEZ5Cv5W3B4hZEeUDMm4VxYBQeJnpmtjbxG83UydyXeFq3+7FB?=
 =?Windows-1252?Q?MJQEqhkxQjwYo/nDTv5DrUBCTPMVVCcmXi/dmSaYBy0zl6wI1PIqPxPp?=
 =?Windows-1252?Q?m27Q19aeoBgld42oxIrNZAEpS0a3O0Lv+FS76hbxja2aC/jR0/MNX7n4?=
 =?Windows-1252?Q?ohCABEtf8XcOI/ot0jlJLX4zo3ws5M6T41/CoMFgwIl0r6lWtTYPTMMH?=
 =?Windows-1252?Q?BuBTJ8TcqQt3IPspt2/dRRLzOGwqTTzfmJKjovU8r0RbY0PrILDPFUJ8?=
 =?Windows-1252?Q?CYKPI7yqNqkJUcZmBiEVou9EkNIiVkN52yJspS07c+eiA8O9YHDa4QcC?=
 =?Windows-1252?Q?gU1IIp25lFNFX7CLuefETB/vsXM4Rm4BxAPDnK34kfFaOH0Cx9O4kCgV?=
 =?Windows-1252?Q?WvBgCHTuD2OXnDxy2zFka2FkiGi6vOw955ruD1yhFiMjfB4TtnJW/IFd?=
 =?Windows-1252?Q?sd8tZA8yrSexFOZMO/q8/seDQ836wejTCjMu7eRKu5zv18hHVP3gD/oK?=
 =?Windows-1252?Q?5Pj/1uSoRggPdW0nms/KYXIalAnsmFR9/rQTNTHS9L3+AOzUHi9zmmvb?=
 =?Windows-1252?Q?bm3xViBMCbjUOUMgkTdDmiN1+tgdvMdVHKt5k7ZWRhCicELk3TXQCxl0?=
 =?Windows-1252?Q?jg+krzcFCK35ERVWJVAaedYZpwqx506RyieccqVvHFubP81FJnpnH0Nj?=
 =?Windows-1252?Q?eivQyVVJ8KRgEuGh8Cyb7mOgVclW3mUCRRJ8s7iFAwPrp/wXBE7XjQNT?=
 =?Windows-1252?Q?tvXP0M371iyf5dwuYQ/AOru+54cJ/vpJiJGuxDEO0z9PX2sqLQF/cdPl?=
 =?Windows-1252?Q?aD2QaSqGQeAQIGSdCQUR1yhqKRaoLANQg/EIlwEWwe7MbY7cYCQCmfsS?=
 =?Windows-1252?Q?p+LrL9HiR3D0fzKUxS9ZJMuh+WLTv/+fNKTVtLWnx+moJmherVM/Bvy/?=
 =?Windows-1252?Q?OJCTo6yBLtAh+3dVJhov22fAdqIdujxPBhBSFnmYHehhkizlHiuEA+js?=
 =?Windows-1252?Q?AS0gFJWgy9Cuy2Pofvzzuel6eQhfZNHPrw93x7v69vLzrZ1S2uMwxJO9?=
 =?Windows-1252?Q?ihBaSCYzJCJ1Zk4E1AMnyC1IioN/dvkClKovIFGir3HQ3SGRxb4zoO+X?=
 =?Windows-1252?Q?tPPTYTtr+mww2Z/sjBvCgqRD3AxIq5QbPAqv+gck0v7IDMnCAKA58lYn?=
 =?Windows-1252?Q?ScnLEPYspKJEonfKhCxhm1h+RWC6SFTL87nhz9J52ZFOtjN5GT2wTIp5?=
 =?Windows-1252?Q?+wJrAvg7pBseVA/KGWoDjsuR814b+57XeB36VWbOUxSkXdrqlw65lVlU?=
 =?Windows-1252?Q?Gcs83P1pZsweATNJqeNK45bS90xKbV+/SoTqeubN9Rhr505HRRSQ4dJw?=
 =?Windows-1252?Q?OLgZxcGThIiNTIr5xsXyfnfrAeagEmtm?=
Content-Type: multipart/alternative;
	boundary="_000_CY8PR11MB792179A09F2AA9979A5A8D9A8100ACY8PR11MB7921namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42811fdd-956f-4392-5b2d-08ddeba9f045
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 11:55:26.9446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rS1XJItMFJnFMVxqrhcFuNbmd/rhdhbVHftUPZ9S18SSOXeDZ/YHpfd0jMQ1URfA+GjVRaCy+YWfWOZ/ZQ+GUzJSbcbbEMRNG3viaaptAQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8550
X-Authority-Analysis: v=2.4 cv=bMAWIO+Z c=1 sm=1 tr=0 ts=68b97e32 cx=c_pps
 a=8NaFqKPAKsJckcyB3ROH5A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=t7CeM3EgAAAA:8 a=k-42gJp3AAAA:8 a=iGHA9ds3AAAA:8 a=7QqCpPCI2dWnluBhjJMA:9
 a=pILNOxqGKmIA:10 a=-tFoHYRcHnMT_DiyjiIA:9 a=-Sc9j2oBuhJFldZ0:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=uCSXFHLys93vLW5PjgO_:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: kNjBwwWjhTAXFtePK0cLWkVJfHu59-XW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDExOCBTYWx0ZWRfX55e9tQjqTvRY
 5H1K5SLDc7QHalRS0eXaW6xCtd3AONyJ8LjgVA4STEki6bd4FNy/oC2hThnY99xIPvPkRBjyJmO
 Jug72GBULuFqvHKcoiK0ltAzz3I6VOgno67N0CfN7+l7VRavBCAhTP1O3h2X6VIrQlwZLf2tD1m
 koDYCHNYyO1PAdYlcwRTa+J4vP3rHryCh6Ge8OPAOvVI1fIegVD19m86Z5bh/3Gl8cwe5l6beQ0
 ZH0ymfU3BQjItC97hjJDJNm+MAbEWNv+IFxwemZ/R9ki43KzoLy2IWlSww0vm2S8B4JAcCn8gq9
 IPUxb0vvo92Rp1Xy3xFNth6URUcAOujmAlkMoHI4ELyWEB+I6eBRLh/tfLUECk=
X-Proofpoint-ORIG-GUID: kNjBwwWjhTAXFtePK0cLWkVJfHu59-XW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 11:55:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2123

--_000_CY8PR11MB792179A09F2AA9979A5A8D9A8100ACY8PR11MB7921namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Scott,

Thanks for your clarification and patience on this. I realize I should have=
 responded more clearly on the world build point earlier =97 I=92ll make su=
re to be more explicit next time.

Regards,
Soumya

________________________________
From: MacLeod, Randy <Randy.MacLeod@windriver.com>
Sent: Wednesday, September 3, 2025 5:57 AM
To: Scott Murray <scott.murray@konsulko.com>; Sambu, Soumya <Soumya.Sambu@w=
indriver.com>
Cc: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>
Subject: Re: Insights from Integrating mixins rust into kirkstone-based

Hi Scott,


On 2025-09-02 4:56 p.m., Scott Murray wrote:

On Thu, 28 Aug 2025, Sambu, Soumya wrote:



Hi Scott and meta-lts-mixins/kirkstone/rust folks,

We (Randy and I and others at Wind River) wanted to share our
experience with integrating 'meta-lts-mixins/kirkstone/rust' into our
kirkstone-based setup to enable support for the latest Chromium version.

While the initial integration showed promise, we encountered several
build issues that led us to reconsider. Most of the challenges stemmed
from the major upgrade of python3-setuptools and the Rust toolchain,
which introduced incompatibilities with several packages in our
environment.

Here=92s a summary of the key issues we faced:

Setuptools-related failures:
- python3-strict-rfc3339 0.7-r0 =96 do_compile failure: ERROR: python3 setu=
p.py bdist_wheel' execution failed
- systemtap =96 do_configure failure due to autoconf-related QA errors
- python3-grpcio =96 do_compile failure: distutils.errors.CompileError
- python3-awscrt =96 do_compile failure: unsafe include path /usr/include/p=
ython3.10 for cross-compilation
- python3-azure-iot-device =96 do_compile failure: invalid specifier '!=3D3=
.3*'


I don't believe you ever replied to my question about whether these
failures are all that result from a world build with e.g. meta-python,
meta-aws, etc.

Yes, most of the problems we encountered were from world builds,
that involved this list of layers: (1)



If that is the case, to be honest, the fallout of the
setuptools backport doesn't seem that bad to me, and IMO worst case you
could always chose to handle them in a WR mixin layer for your customers.

Yes, there were many ways to deal with this, I asked Soumya to focus
on the collective good of getting things fixed in this mixin or other 'upst=
ream' layer.



I did forget to go back and look at systemtap, that's definitely on me,
and I'll take a poke at it this week.





Rust-related failures:
- Internal BSP: libstd-rs do_compile failure =96 Error loading target
specification: 'softfp' is not a valid value for llvm-floatabi
- mozjs78 and mozjs-91 =96 do_compile failures

Thanks to a variety of commits and your work, these issues were
resolved. However, we remain concerned about potential customer
regressions from introducing higher version packages into our
kirkstone-based setup. So, we=92ve decided to hold off on using
'meta-lts-mixins/kirkstone/rust' for now to avoid impacting our
customers.

We appreciate the effort that=92s gone into maintaining the mixins and
hope this feedback helps others in the community. We=92ll continue to
monitor developments and may make use of this work in customer-specific
projects.

Thanks again for your work and support.


Thanks, I guess?

We really do appreciate you working on this!!


I'm still somewhat disappointed that we've had to drop the effort since
I put quite a bit of time into chromium over the years.

Also, I wanted the rust mixin layer to just work, mostly to convince
myself and RP that Rust's crazy "bug fixes in the new release"
approach wasn't that crazy. From this work at least, the problems

we're NOT with Rust, they were with other packages and build tools.


I know you've a desire for me to slap your workarounds
for mozjs and the like into dynamic-layers, but as I reported previously
I can't reproduce the failures you're seeing with e.g. python3-grpcio,
and your tweaks for mozjs seem obsoleted by the last couple of Rust
updates.

No slapping of work-arounds is desired. We were aiming to do the
right thing and if we fell short, that's on me.


As others have mentioned, we're about 8 months away from
kirkstone EOL, so it's impossible for me to justify investing more of
my time into trying to hack up a frankenstein setuptools-rust that avoids
needing the setuptools backport.

I understand and agree with that call.

That said, I would merge a reasonable
looking implementation of that if WR is for some reason motivated to
invest in it, and am also willing to discuss handing over maintainership
of the kirkstone/rust mixin if WR plans to support kirkstone for its
customers past Q2 2026.

Thanks for the explanation and offer. We'll keep it in mind but
our goal was to enable chromium for our kirkstone-based product.
Since we don't have very many customers who are still using chromium from t=
hat release, or
chromium in general, really, we've EOLed support for that package. Therefor=
e, unless we find a paying
customer to work with our services team, we won't be doing anything else wi=
th

the meta-lts-mixin/rust/kirkstone layer.

Thanks Scott,

../Randy



Scott


1)

BSP and meta-layers used:

amd-x86
aptiv-s32g
axxiaarm
bcm-2xxx-rpi
intel-socfpga
intel-x86
local
marvell-cn106xx
marvell-cn10xxx
marvell-cn9xxx
meta-anaconda
meta-arm
meta-browser
meta-cgl
meta-clang
meta-cloud-services
meta-dpdk
meta-freescale
meta-freescale-distro
meta-gplv2
meta-imx
meta-intel
meta-intel-fpga
meta-intel-qat
meta-iot-cloud
meta-lat
meta-lts-mixins
meta-mingw
meta-openembedded
meta-qoriq
meta-qt6
meta-raspberrypi
meta-realtime
meta-secure-core
meta-security
meta-selinux
meta-tegra
meta-tensorflow
meta-ti
meta-virtualization
meta-xilinx
meta-xilinx-tools
meta-yocto
nvidia-orin
nxp-imx6
nxp-imx7
nxp-imx8
nxp-ls1028
nxp-ls1043
nxp-ls1046
nxp-lx2xxx
nxp-s32g
oe-core
ti-j72xx
ti-j7xxx
wrlinux
wr-ota
wr-sbom
wr-sbom-tools
wr-template
xilinx-versal
xilinx-zynq
xilinx-zynqmp


--
# Randy MacLeod
# Wind River Linux

--_000_CY8PR11MB792179A09F2AA9979A5A8D9A8100ACY8PR11MB7921namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Scott,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks for your clarification and patience on this. I realize I should have=
 responded more clearly on the world build point earlier =97 I=92ll make su=
re to be more explicit next time.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Soumya</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> MacLeod, Randy &lt;Ra=
ndy.MacLeod@windriver.com&gt;<br>
<b>Sent:</b> Wednesday, September 3, 2025 5:57 AM<br>
<b>To:</b> Scott Murray &lt;scott.murray@konsulko.com&gt;; Sambu, Soumya &l=
t;Soumya.Sambu@windriver.com&gt;<br>
<b>Cc:</b> yocto-patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoc=
toproject.org&gt;<br>
<b>Subject:</b> Re: Insights from Integrating mixins rust into kirkstone-ba=
sed</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"x_moz-cite-prefix">Hi Scott,</div>
<div class=3D"x_moz-cite-prefix"><br>
</div>
<div class=3D"x_moz-cite-prefix"><br>
</div>
<div class=3D"x_moz-cite-prefix">On 2025-09-02 4:56 p.m., Scott Murray wrot=
e:<br>
</div>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">On Thu, 28 Aug 2025, Sambu, Soumya wrote:

</pre>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">Hi Scott and meta-lts-mixins/kirkstone/rust =
folks,

We (Randy and I and others at Wind River) wanted to share our
experience with integrating 'meta-lts-mixins/kirkstone/rust' into our
kirkstone-based setup to enable support for the latest Chromium version.

While the initial integration showed promise, we encountered several
build issues that led us to reconsider. Most of the challenges stemmed
from the major upgrade of python3-setuptools and the Rust toolchain,
which introduced incompatibilities with several packages in our
environment.

Here=92s a summary of the key issues we faced:

Setuptools-related failures:
- python3-strict-rfc3339 0.7-r0 =96 do_compile failure: ERROR: python3 setu=
p.py bdist_wheel' execution failed
- systemtap =96 do_configure failure due to autoconf-related QA errors
- python3-grpcio =96 do_compile failure: distutils.errors.CompileError
- python3-awscrt =96 do_compile failure: unsafe include path /usr/include/p=
ython3.10 for cross-compilation
- python3-azure-iot-device =96 do_compile failure: invalid specifier '!=3D3=
.3*'
</pre>
</blockquote>
<pre class=3D"x_moz-quote-pre">I don't believe you ever replied to my quest=
ion about whether these
failures are all that result from a world build with e.g. meta-python,
meta-aws, etc.  </pre>
</blockquote>
Yes, most of the problems we encountered were from world builds, <br>
that involved this list of layers: (1)<br>
<br>
<br>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">If that is the case, to be honest, the fallo=
ut of the
setuptools backport doesn't seem that bad to me, and IMO worst case you
could always chose to handle them in a WR mixin layer for your customers.</=
pre>
</blockquote>
<p>Yes, there were many ways to deal with this, I asked Soumya to focus<br>
on the collective good of getting things fixed in this mixin or other 'upst=
ream' layer.<br>
</p>
<p><br>
</p>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">
I did forget to go back and look at systemtap, that's definitely on me,
and I'll take a poke at it this week.</pre>
</blockquote>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">

</pre>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">Rust-related failures:
- Internal BSP: libstd-rs do_compile failure =96 Error loading target
specification: 'softfp' is not a valid value for llvm-floatabi
- mozjs78 and mozjs-91 =96 do_compile failures

Thanks to a variety of commits and your work, these issues were
resolved. However, we remain concerned about potential customer
regressions from introducing higher version packages into our
kirkstone-based setup. So, we=92ve decided to hold off on using
'meta-lts-mixins/kirkstone/rust' for now to avoid impacting our
customers.

We appreciate the effort that=92s gone into maintaining the mixins and
hope this feedback helps others in the community. We=92ll continue to
monitor developments and may make use of this work in customer-specific
projects.

Thanks again for your work and support.
</pre>
</blockquote>
<pre class=3D"x_moz-quote-pre">Thanks, I guess?  </pre>
</blockquote>
We really do appreciate you working on this!! <br>
<p><br>
</p>
<p>I'm still somewhat disappointed that we've had to drop the effort since<=
br>
I put quite a bit of time into chromium over the years.<br>
</p>
Also, I wanted the rust mixin layer to just work, mostly to convince<br>
myself and RP that Rust's crazy &quot;bug fixes in the new release&quot; <b=
r>
approach wasn't that crazy. From this work at least, the problems<br>
<p>we're NOT with Rust, they were with other packages and build tools.</p>
<p><br>
</p>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">I know you've a desire for me to slap your w=
orkarounds
for mozjs and the like into dynamic-layers, but as I reported previously
I can't reproduce the failures you're seeing with e.g. python3-grpcio,
and your tweaks for mozjs seem obsoleted by the last couple of Rust
updates.  </pre>
</blockquote>
<p>No slapping of work-arounds is desired. We were aiming to do the<br>
right thing and if we fell short, that's on me.<br>
</p>
<p><br>
</p>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">As others have mentioned, we're about 8 mont=
hs away from
kirkstone EOL, so it's impossible for me to justify investing more of
my time into trying to hack up a frankenstein setuptools-rust that avoids
needing the setuptools backport.  </pre>
</blockquote>
I understand and agree with that call.<br>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">That said, I would merge a reasonable
looking implementation of that if WR is for some reason motivated to
invest in it, and am also willing to discuss handing over maintainership
of the kirkstone/rust mixin if WR plans to support kirkstone for its
customers past Q2 2026.</pre>
</blockquote>
Thanks for the explanation and offer. We'll keep it in mind but <br>
our goal was to enable chromium for our kirkstone-based product.<br>
Since we don't have very many customers who are still using chromium from t=
hat release, or
<br>
chromium in general, really, we've EOLed support for that package. Therefor=
e, unless we find a paying<br>
customer to work with our services team, we won't be doing anything else wi=
th<br>
<p>the meta-lts-mixin/rust/kirkstone layer. <br>
</p>
<p>Thanks Scott,<br>
</p>
<p>../Randy<br>
</p>
<blockquote type=3D"cite">
<pre class=3D"x_moz-quote-pre">

Scott</pre>
</blockquote>
<p><br>
</p>
<p>1)<br>
</p>
<p>BSP and meta-layers used:<br>
<br>
amd-x86&nbsp; &nbsp;<br>
aptiv-s32g<br>
axxiaarm<br>
bcm-2xxx-rpi<br>
intel-socfpga<br>
intel-x86<br>
local <br>
marvell-cn106xx<br>
marvell-cn10xxx<br>
marvell-cn9xxx<br>
meta-anaconda<br>
meta-arm&nbsp; &nbsp;<br>
meta-browser <br>
meta-cgl<br>
meta-clang&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<br>
meta-cloud-services<br>
meta-dpdk<br>
meta-freescale<br>
meta-freescale-distro<br>
meta-gplv2<br>
meta-imx<br>
meta-intel<br>
meta-intel-fpga<br>
meta-intel-qat<br>
meta-iot-cloud<br>
meta-lat<br>
meta-lts-mixins<br>
meta-mingw<br>
meta-openembedded<br>
meta-qoriq<br>
meta-qt6<br>
meta-raspberrypi<br>
meta-realtime<br>
meta-secure-core<br>
meta-security<br>
meta-selinux<br>
meta-tegra<br>
meta-tensorflow<br>
meta-ti<br>
meta-virtualization<br>
meta-xilinx<br>
meta-xilinx-tools<br>
meta-yocto<br>
nvidia-orin<br>
nxp-imx6<br>
nxp-imx7<br>
nxp-imx8<br>
nxp-ls1028<br>
nxp-ls1043<br>
nxp-ls1046<br>
nxp-lx2xxx<br>
nxp-s32g<br>
oe-core<br>
ti-j72xx<br>
ti-j7xxx<br>
wrlinux<br>
wr-ota<br>
wr-sbom<br>
wr-sbom-tools<br>
wr-template<br>
xilinx-versal<br>
xilinx-zynq<br>
xilinx-zynqmp<br>
<br>
</p>
<pre class=3D"x_moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
</div>
</body>
</html>

--_000_CY8PR11MB792179A09F2AA9979A5A8D9A8100ACY8PR11MB7921namp_--

