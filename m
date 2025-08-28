Return-Path: <soumya.sambu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4911C8303F
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 14:29:35 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.22400.1756391367440684525
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Aug 2025 07:29:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=dexlfF2F;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1335d77c5c=soumya.sambu@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57SA2JQm2433240;
	Thu, 28 Aug 2025 14:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:message-id:mime-version:subject:to;
	 s=PPS06212021; bh=hDwJOMX/Vy4kGE1oVRBHsIjgQbtLr75wQxdG/wKvEuI=; b=
	dexlfF2FDAyfbLKg3ClDHnoo2usZq2JKYwFwevunhkacWzoKgrVNwTt/krqLY+e4
	Y4IAQfC33DSySeSBqNT3PvUj2fqkyVYWMcji8s9EtYKdxlKSBtMYtcgx5H0RN3jT
	ij9OgNld4nTIV80Pg8qNMzYrK5awnzW9zSUwmbZsX3DYWR5has7imazEN9oMx7dK
	DHmu5jAHUfBldLZwEe/QFnBMr1E+xTsH7WJ7K0NCetzeeMpgQw8/pFPQee+inPwr
	YeSndPSZo6yF6Pc5peWoSxJP+b9vBSuT8STGRrb+qgvfcRkwEm+aMKgRhYtf7Myq
	ET+PQ5TDz7ArqiJLyBmeQQ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48q4m3wxm8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 14:29:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bpx0/Vz0u8m2p4287+XeC4WYsCMcELjmzhcE5E6RHyoa6bu3bYgDOJTjNwYnIx6C/rJvPpAvIVkvriThMVR/hK6S+JXTG4x+zIpYT/GtxVSvBGxiwHLAIePZQ+QUp5bImam3y6NBGDKpZHp0nu+mnlD8xxkara49wegphW2FWVTFsegI9vr1m705Q5VMAAOaIenCX+l/jQYzjykcsfx2VuDkmsPQPYwebCmfc6zzn/p6hbyGXJdsbki6b4mojZu+TQSqLdyFf24Coaplk8TM6A9Sag1eY6zSmZlQFXJQTrML4Tw4Hce2iJVF488cQq7y7SZX15f7k099+eq9iY/LIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDwJOMX/Vy4kGE1oVRBHsIjgQbtLr75wQxdG/wKvEuI=;
 b=Zns0BLOi7ThUwcyNfUYaTzMz0ahbyCiTpjpKS1UfkYVpHZRxKxW+N+r7R2b0ErLSrfyArarYbfivVB8xnh/WQWJf4t83WMhzPKDQ+Q7r1HmNfqyiH2QvU+PQUm3d0nhjRuXtVOBFFowKXgYy+K9DT/D6JfyjY1ltp3IJZQwPlchRv3NRRpTDuXnBD7iXHjIPTUhfKlZGdlS8PvzpUGaP4Y2R8wpdtWxPehaPdeAgNmDUpE8BDeM0gIlfsWjm7XzkJEpOg62YJCCJQ4KktoWHhCt7BTozioPwATkzyEdl1UYcfNEj3rfgbBnayIiwvU5kdVaiVFkYEtx4NQK3HWTOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15)
 by PH7PR11MB6356.namprd11.prod.outlook.com (2603:10b6:510:1fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 14:29:18 +0000
Received: from CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a]) by CY8PR11MB7921.namprd11.prod.outlook.com
 ([fe80::9050:ad4d:49e1:e11a%4]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 14:29:18 +0000
From: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        Scott Murray
	<scott.murray@konsulko.com>
CC: "MacLeod, Randy" <Randy.MacLeod@windriver.com>
Subject: Insights from Integrating mixins rust into kirkstone-based
Thread-Topic: Insights from Integrating mixins rust into kirkstone-based
Thread-Index: AQHcGCUREa5GxjpiDEWeb+Itb15cug==
Date: Thu, 28 Aug 2025 14:29:18 +0000
Message-ID: 
 <CY8PR11MB7921AAF6CFDC45DD76C7B40B813BA@CY8PR11MB7921.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-08-28T14:28:47.458Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7921:EE_|PH7PR11MB6356:EE_
x-ms-office365-filtering-correlation-id: bb85bb87-29d1-42ee-76d1-08dde63f45e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?M7hGYi6sxfX2LF9HJ+UAc8pVaHED28KQIX02DVHvN72k2BUoXJFxpyqt?=
 =?Windows-1252?Q?v1IQy4NddIeuaHgv/Zxsj4EK3mcF1CAoGt9mXymyc9bM2huN/UvR4eez?=
 =?Windows-1252?Q?ovkkP5ANYOfz0RjX/ID6ZHyIqmBNUOXdr+0EkIa8ip+7nQMyinKEb+9a?=
 =?Windows-1252?Q?k8NBdWX6JviXkf4A0GnLyoUbzFUSkRSgr93ikBs8F0sjeooMqXR+dEgF?=
 =?Windows-1252?Q?9bWTC8MDKD0WhKTdkTQA0Vxw5eQZJA3xZpNfVWvC/NOLO5mMAqEWAtxK?=
 =?Windows-1252?Q?+BTTTuWSulu9BIRsYgjQ35PFLB64FyyJjJlCNrPUgPFWNIGTteGiqeDM?=
 =?Windows-1252?Q?zB7aOCAPDBTKU0tONSacfUIKLmXNCxUyGLAUnxEoRwuDI6CDasGKsh02?=
 =?Windows-1252?Q?I/036YumtHt/himvIpjy2glz/I3yA/F7fz/h0mRq6J38bMv/04O/Q48r?=
 =?Windows-1252?Q?R+AXOnJOUFk5MW8o1x7a/fwksYLdQcQtVMwdNrEEwevyoxw0I5lPvkaY?=
 =?Windows-1252?Q?AxXNa6rx/w+Jukvzerb/rpEoBP2Ucd8bnjKSmCpwymawRabnmAAM7eT4?=
 =?Windows-1252?Q?LZ5ZYEtvFq0wI0+IE2qAVN5E5pKXmyeRWheVfSOzGP133gojqt5UmdDd?=
 =?Windows-1252?Q?joOem5qxj/+HTT1XqYAtRtnSlFLbcXlWCegdkX918dpu7aYNYfzk/rBw?=
 =?Windows-1252?Q?lgVyi2/kY84aj4eGbeAf++oMaaOaBboPppE80BsbaZPt9YDAB7vrrpIQ?=
 =?Windows-1252?Q?3gH5y3a3eUFhJAg+lnbAyN2ok0Pqv1Y4iIuorifz6dCe9qWA1qvdVKj4?=
 =?Windows-1252?Q?jZ719CWwXB8m/S0qSmTe348yGSBj1h0Khfl7dMvp0hb6xOu+k2bry2dE?=
 =?Windows-1252?Q?YQx5P5ChJEtxGtWMHPCNffqM/GfBocr43T26E37r24r5HusjamWJU876?=
 =?Windows-1252?Q?nuDrNBW+zHBdAPoDj3fuLa9wHXVYiUyGoX4xZeEc8otVXpJGiHbtouox?=
 =?Windows-1252?Q?AIOIuYsiSQCOct0HK9hLIgOl0wMuNQ0roRqgNx8/K36Qt3CZ46ehk7Ll?=
 =?Windows-1252?Q?Oe9V+JTq7C5tMVvPOBXPpSfXpxbo1LIGLnhvGPw/SHk18/c9aQPnzGqY?=
 =?Windows-1252?Q?sNrktiQ2II9rruM0joCJ3BhzYnr4cdY2sfTtxEpe1EDwcg0Z2RPpn6Tt?=
 =?Windows-1252?Q?F+ZStGpfwLGl+3kmui7tIbKrvTru2ntnnOlf9cvw/zuhViAWOqdVwu0A?=
 =?Windows-1252?Q?2QmYguY6uH/1ZXyWA9CDjiEWVBEYV8N8dzAn49LNbnMlfN31zBVkuaC4?=
 =?Windows-1252?Q?Re40KI8X59+aS2sW+nXqpILUzxNkDpayId6VnfGm2FzS5Cf2Wm9bbOM6?=
 =?Windows-1252?Q?1p4Bysw+UBa4+uNruqKhqKPk5pb0SgiVw22bLqKk168CMxbFsJ/3R+32?=
 =?Windows-1252?Q?hBRgBKubzGAIEYu4ambYTAL0XcXRjtVOzI1/v4WrGVxFe7ARewxInq5b?=
 =?Windows-1252?Q?s5q//8CzvuWLO5xbnEkfE/IneD6t3uAPqbYUPkvW0jITV2hBGPWcLUZn?=
 =?Windows-1252?Q?t0EZViA2lF9xUafM7hGi8eT/9Dz/iQCF3JehToMrisjWuG+PI72tjonV?=
 =?Windows-1252?Q?Na8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7921.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?AjN207KfwZR/j5UT0tal3SLT/n3q8tIj+3/CRNZPi31slpA4iqozrxYD?=
 =?Windows-1252?Q?kfV60uCcNdh7a95ROPWrN7KjZ/4lyWU7lVt50DJXlUN8NP9lVPJAV06N?=
 =?Windows-1252?Q?8uPbZRCtoBKH3yxfFFhSdimg/9PwJ1nHxrr9w7sudeumr30YoTdZtSNC?=
 =?Windows-1252?Q?sW3EmlSd+ueIK0pa7JATPal5Smf5Bytrk4Ia0tmG23tG4hJFUC5oqT4y?=
 =?Windows-1252?Q?zRY5Kt0j258qIQStCLF5GE3QOwjzFoR+ptz1/ijPpYHnppCkxxSzm+kK?=
 =?Windows-1252?Q?D4BU/XJHpNcnCxl8RP+lyZxQ8mgZP+2YSjudGpZBAi6PE26gfcmuSz39?=
 =?Windows-1252?Q?sUb92gj98D7DRvsFAluOz+wH2C3nTVtG9RsDuOYOvVGPYCcaHeX2e/Wu?=
 =?Windows-1252?Q?Y0oBfOK8UCtOMa0PSvoggf70+k4Ky/SjUSfr/WVyuNyxGJjvoAEQJL5W?=
 =?Windows-1252?Q?pDLdUvLvMCgSHYWf5l39+5hZwHeLckuO2tuVb+lRDoc8xB5ztCyOB33z?=
 =?Windows-1252?Q?nK/noehFhc1DMlcopvKjXaBvL/RnkKzDamHMPeUPDtXs7jjxkqJ1+9nF?=
 =?Windows-1252?Q?v+q3qN3McbNY3MGqbzriVdE1dQ96SqAU6a2/LJpUupUm4EYMOR5lqpyY?=
 =?Windows-1252?Q?U5BVFn3Fe+ir46km1w2Jv7Nd+4MhazuyomLPeUb6pfFM02o3FjGnvPp1?=
 =?Windows-1252?Q?CGGFIfCWMD6X+JlRyctTlsDtFrSHvUslx9307mnIPXXCwgv/3vur9XWC?=
 =?Windows-1252?Q?epBq7Nc6L4qCLSLg3F9Ym5dGtbxY0EQ66JFR/Z82Jp05mBWyKLGaScz/?=
 =?Windows-1252?Q?620c10SBD+6n9DPevr1mGi8U18YyG7j0QkaxJ0RvgT+bYBurc8i9cdJm?=
 =?Windows-1252?Q?ZjO1Bdy0qqZcDTT1KuVn3+mwT4w7gpI6u8JEGPG0gSyk1y6HpsFef/pr?=
 =?Windows-1252?Q?TJooTqrh4Ugf1P5S+1wLIBVAYpZAV4DeRGL0EsQlTg3DKamzdjH6czV7?=
 =?Windows-1252?Q?L2Fgl7eyZ5Dagvp2gtryW5KUxLGzJyfxTMl5nMKk0NcuWnUpO/0UliFO?=
 =?Windows-1252?Q?mTRm6ku1QtsQExecbCshhJY+yBLBgkM4BzD2IjBgUVZcjW/p46QYoDvK?=
 =?Windows-1252?Q?9zqo6v3pCF6eiWw/PWUaYb6EQrzi+C38sotDPn6HAD16WfFCXG5yVeT5?=
 =?Windows-1252?Q?BIZMZjrRSGMCtfbuOR7jI7TkCvcdMcJYpXJS1X1sEDZPecuE8EEnhpNK?=
 =?Windows-1252?Q?M/c5RmbHdQeQ5dwI86d3cGaK50rRHf5wU0oRNggNFUZsfHfu06WuHM/+?=
 =?Windows-1252?Q?KEOsTqx3xaNpbiGn++e9NFSJpKY2Ee4x9eToI5VXyC67rbNWydGc93jM?=
 =?Windows-1252?Q?y6Jb5Xxf26KN74a21EPOUFrc230UD8gbLqzSiBQr2Y5XLtazZvr1bIaO?=
 =?Windows-1252?Q?i1FKr6nmc+ZZi/Vp9qKuA9g4SD/nMLIiZLYJrB9xnKXJehVl2xXQ0h2r?=
 =?Windows-1252?Q?SolXp91iuS5Se1Fi55w/wwII0Pvud6a9IQpUOVswrNQOAJnrjRI+AjYM?=
 =?Windows-1252?Q?YiWmlOYHkcN6DYZsRNCBSvmw7dAd5JA9jzrTAHhpLspVlF6S6abo6IAp?=
 =?Windows-1252?Q?yAHtKfAPF8624X3m9DTmQDlxmMmjH0CCT6Gq3ffRx/TRGmWilvtBcx6Q?=
 =?Windows-1252?Q?ZRk5XFD0T/chu2b2icpDjkFy66ShJ/iI?=
Content-Type: multipart/alternative;
	boundary="_000_CY8PR11MB7921AAF6CFDC45DD76C7B40B813BACY8PR11MB7921namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb85bb87-29d1-42ee-76d1-08dde63f45e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 14:29:18.6445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 663g6AoT8QMSAyh8FKlWYjsv9ULGa7F9VUldyIru/hPXdRiWPevLka67ej+YLCcOyxLrfZ7w4pLjMwaJjTZxqbpoTqnYhYoaSPy9hr4bZz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6356
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDEyMiBTYWx0ZWRfX++wx4ZA6teUp
 risTp4wl0UOblmFidxnGIYUZkJQlfj1LaZLXLYVU1KzxEbjaeDrNT6Qd5ilS1VHqKtjPkWbge2R
 c4+4V+A5PQJgnPLos2tT/D267/+OrOiBT07cyEVUmcn48mE8pYjAlCMbcq7As0EP3NMVU7q0bec
 rJb1zy0o1+7Y2nHDb+KBJGUWUStxZGWNgV/tV57xIHuvDI+Papwma6x3z3VUinamrwyaGvFaXNU
 8saRtu9Q5BndIUDVw31wD/5IcF0q96VHL70fy1iwon3Pvj6apwChvo9PL1kD6/JDCHpF33QVvcT
 a4AMeTnPhTwq7gT0Jt4WR4LB3MynjzvPFyhBwj8m78U1EHDQFsYkZlbjFu2MCs=
X-Proofpoint-ORIG-GUID: jwDGv9IqTbYQisT18EblVWfNhQnWCoF2
X-Proofpoint-GUID: jwDGv9IqTbYQisT18EblVWfNhQnWCoF2
X-Authority-Analysis: v=2.4 cv=CcwI5Krl c=1 sm=1 tr=0 ts=68b067c5 cx=c_pps
 a=NB3Td43k1Dtgf8/5lZavww==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=9Y8yS8yG05o8Z0Ws0vcA:9 a=pILNOxqGKmIA:10 a=ddtP9U9vbBYNzCN2-CcA:9
 a=uBGjHexnS3Ky5Tpl:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Aug 2025 14:29:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2088

--_000_CY8PR11MB7921AAF6CFDC45DD76C7B40B813BACY8PR11MB7921namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Scott and meta-lts-mixins/kirkstone/rust folks,

We (Randy and I and others at Wind River) wanted to share our experience wi=
th integrating 'meta-lts-mixins/kirkstone/rust' into our kirkstone-based se=
tup to enable support for the latest Chromium version.

While the initial integration showed promise, we encountered several build =
issues that led us to reconsider. Most of the challenges stemmed from the m=
ajor upgrade of python3-setuptools and the Rust toolchain, which introduced=
 incompatibilities with several packages in our environment.

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

Rust-related failures:
- Internal BSP: libstd-rs do_compile failure =96 Error loading target speci=
fication: 'softfp' is not a valid value for llvm-floatabi
- mozjs78 and mozjs-91 =96 do_compile failures

Thanks to a variety of commits and your work, these issues were resolved. H=
owever, we remain concerned about potential customer regressions from intro=
ducing higher version packages into our kirkstone-based setup. So, we=92ve =
decided to hold off on using 'meta-lts-mixins/kirkstone/rust' for now to av=
oid impacting our customers.

We appreciate the effort that=92s gone into maintaining the mixins and hope=
 this feedback helps others in the community. We=92ll continue to monitor d=
evelopments and may make use of this work in customer-specific projects.

Thanks again for your work and support.

Regards,
Soumya

--_000_CY8PR11MB7921AAF6CFDC45DD76C7B40B813BACY8PR11MB7921namp_
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
Hi Scott and meta-lts-mixins/kirkstone/rust folks,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
We (Randy and I and others at Wind River) wanted to share our experience wi=
th integrating 'meta-lts-mixins/kirkstone/rust' into our kirkstone-based se=
tup to enable support for the latest Chromium version.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
While the initial integration showed promise, we encountered several build =
issues that led us to reconsider. Most of the challenges stemmed from the m=
ajor upgrade of python3-setuptools and the Rust toolchain, which introduced=
 incompatibilities with several
 packages in our environment.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Here=92s a summary of the key issues we faced:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<b>Setuptools-related failures:</b></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- python3-strict-rfc3339 0.7-r0 =96 do_compile failure: ERROR: python3 setu=
p.py bdist_wheel' execution failed</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- systemtap =96 do_configure failure due to autoconf-related QA errors</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- python3-grpcio =96 do_compile failure: distutils.errors.CompileError</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- python3-awscrt =96 do_compile failure: unsafe include path /usr/include/p=
ython3.10 for cross-compilation</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- python3-azure-iot-device =96 do_compile failure: invalid specifier '!=3D3=
.3*'</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<b>Rust-related failures:</b></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- Internal BSP: libstd-rs do_compile failure =96 Error loading target speci=
fication: 'softfp' is not a valid value for llvm-floatabi</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- mozjs78 and mozjs-91 =96 do_compile failures</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks to a variety of commits and your work, these issues were resolved. H=
owever, we remain concerned about potential customer regressions from intro=
ducing higher version packages into our kirkstone-based setup. So, we=92ve =
decided to hold off on using 'meta-lts-mixins/kirkstone/rust'
 for now to avoid impacting our customers.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
We appreciate the effort that=92s gone into maintaining the mixins and hope=
 this feedback helps others in the community. We=92ll continue to monitor d=
evelopments and may make use of this work in customer-specific projects.</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks again for your work and support.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards, &nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Soumya</div>
</body>
</html>

--_000_CY8PR11MB7921AAF6CFDC45DD76C7B40B813BACY8PR11MB7921namp_--

