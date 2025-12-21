Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B26D68BD5
	for <webhook@archiver.kernel.org>; Sun, 21 Dec 2025 04:09:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.54149.1766290141653505896
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 20 Dec 2025 20:09:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=dvODGvzy;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: quicinc.com, ip: 205.220.180.131, mailfrom: quic_sasikuma@quicinc.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BKKtv9G754316;
	Sun, 21 Dec 2025 04:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n2K1WXIEV84fhewfvzPnSzVQ/LP6cad0gGjIHlqiBx4=; b=dvODGvzyX8dDVGyy
	TyZAsd8KRVH6+eXRjNS7/iYWxmqL/V5EMDf4UPCp4k9Gr+mXoYiYYEqchIKdoxzQ
	hGlCZoW9WhYDiR9WgLkVv2qXlL8ErZTwsxbopwRcoqSJB621NLoHddomn4klq05Q
	a3icd2ndPNIjsLB3HPFS/zaIuZkzxtDWD9HC83oKo2Sv/D/uZtvvjKNZ3qa0eMDr
	9WipZPqsH3nlEz4AGiy44YYSZgp8SuUBm8eAD9H8L18XgGxNEBKE2Xa67Vb8qupa
	qpaMC4e2eoeHga6G5wWbzmkTX2NNVQ2Zf45D3pIv6EzX/JoCqIilBXKPLut1pPAG
	as3v1A==
Received: from dm2pr04cu003.outbound.protection.outlook.com (mail-dm2pr04cu00303.outbound.protection.outlook.com [40.93.13.59])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mry1rd2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 21 Dec 2025 04:09:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3MeCwZSy13rO+g4mFoRnpR/74NoaI7+AYmapRjcm+RixeyWN5LV8dWjfDNbxs06HHAR+lMc+GkgsO+OjMcQLxP8/8GUX1jSPjk5OYWEfmHcPSgtd4tshNgzJIROSYGoLVEk6YHbrDPMNonU+9dXWYzwubVYpDThENz6tLdMyd5n04DuwL1oCiK73RD7NS3AoDi4k1QsWcE/322kFa0gYl4ONLl1iRMb79NIZEEceMyvfQbfOXk1xsvM4bWGvt2oM46hlZakliersLev/LN5o/yMTZYhstBvLIF6M0qlinuKw50JhhAw/8fh4NMTSYHPW9pkboqUMPK2pFX8HYCPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2K1WXIEV84fhewfvzPnSzVQ/LP6cad0gGjIHlqiBx4=;
 b=xY6zVB79N0qToxBlsCOCkGCAIm36o7/5gEFnCD56+zDlaNFBqa6Cw0nDoErt17U17SfnAdESXBHOBI4KOnf39516oPterxD7ZtZQz0y9KN0lI2wd2Dd2q+lCdezfMLQ/iWvxzk1Jv1eSWfaf6UCsWrJfv3ndvVAChiTvOW3VeuUiMBmUpAzPHywSFMnsDqikMx4KkcfJaSY6wZ6YnV9YsjAUyK3ETTgzTT3n+4V/EEvQh/9lampc+qPRQ3rkbDsCv2H4MQ6S2VrBHVj6qKspKCvDyYccrZ1aW1kSYZOLWWfAuVFIly2NP9e4UlDF4VpbzO/21S0HwmzkHiFmVlTjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL3PR02MB8986.namprd02.prod.outlook.com (2603:10b6:208:3b6::10)
 by IA1PR02MB9062.namprd02.prod.outlook.com (2603:10b6:208:41a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sun, 21 Dec
 2025 04:08:58 +0000
Received: from BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35]) by BL3PR02MB8986.namprd02.prod.outlook.com
 ([fe80::55fd:41af:45b2:fb35%7]) with mapi id 15.20.9434.001; Sun, 21 Dec 2025
 04:08:58 +0000
From: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>
To: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>,
        "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>,
        Yi Zhao <yi.zhao@windriver.com>
CC: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>
Subject: RE: [meta-selinux][PATCH] libsemanage: Update policy version in
 semanage.conf
Thread-Topic: [meta-selinux][PATCH] libsemanage: Update policy version in
 semanage.conf
Thread-Index: AQHcbbba3t5Ag9aVoEacFPIZ3dxOH7UrgU4ggAACRiA=
Date: Sun, 21 Dec 2025 04:08:58 +0000
Message-ID: 
 <BL3PR02MB8986949BE2DC2A45EE378120E8B7A@BL3PR02MB8986.namprd02.prod.outlook.com>
References: <20251215113321.3987394-1-quic_sasikuma@quicinc.com>
 <BL3PR02MB8986F0C118CB5296F30660A9E8B7A@BL3PR02MB8986.namprd02.prod.outlook.com>
In-Reply-To: 
 <BL3PR02MB8986F0C118CB5296F30660A9E8B7A@BL3PR02MB8986.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB8986:EE_|IA1PR02MB9062:EE_
x-ms-office365-filtering-correlation-id: 97ee1da1-2871-45cf-4b79-08de4046aa4f
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?NAiFRUF4517Y+6iBlYbo3I0ENb2P9ozLLkhx2x8o0vxBIOW0pcXr+aNECLvp?=
 =?us-ascii?Q?TCxQoUFa1fyENpmGkycFrMMEvzXeyeVY9xurts7/sAWFawD+9aMRDXGQN7eB?=
 =?us-ascii?Q?2PD1Z2JcOEhIbn6QqQeaw1ZwWpuCpyrCySY3ZuLp9h7IhaT9n6RT4oWi3HyO?=
 =?us-ascii?Q?n15C0JXAqOlKqyfVCqfEtLJhBaQWDWAUUx1H7Qxepk9tyoa+g4g7uHZSJh1i?=
 =?us-ascii?Q?yuUg6ADW3lYb/ydJE/9FHxrV5ktMZNCDimxKrDb7JfL++0fyQpgEQ3JdsWXl?=
 =?us-ascii?Q?xcBnu5vLKgJz0iqD2dY/Wl71YT8ZtfUO/dv24oVDkKTbrv2aVVMN8EUxxe5z?=
 =?us-ascii?Q?dM9fZ8RaFptNyOw7pLtzb2EDcYYq0PTAI7n4Aw/K+RHZZw8/zGIALHDpUl2Z?=
 =?us-ascii?Q?7/Gtkp/enxYAr4GYydHYGDJLrfTv9nPH16OOrwaRCZWlXKjDKYA+AZ2kaaeu?=
 =?us-ascii?Q?H7GApFMijUz3WhGTSux7eFbQ8TzWuV19f2UTrB88NOSdCrWcSjCNTe+b+MfO?=
 =?us-ascii?Q?a0ZoQpttWcOoMb2nPgBk/aSfJCXFSe0cce1FXoOixIjXuLTY/5H/E8SPH0iZ?=
 =?us-ascii?Q?tWYIin4TfviV7EszwcfWSL7yPIfS1ADKn7ZrYMqwHKIsXi5QMZBMFYT4mwQ1?=
 =?us-ascii?Q?/X4T3xLza7y0I5Z/B1YfEDUssneUj/5Gnsn+2XLkITgVoYrtxQE0torgstCU?=
 =?us-ascii?Q?gAZ8t+qHWjyr/xGJhqabr1HMJvguHSfZRYAYeO4qHzc48Td+GrCDQ6Hf6NBB?=
 =?us-ascii?Q?nagmn7wOSCH+uEK62/5LLYQNbI/NtevuyNXR8SqqWCZshGbG0jB2uR6uKICa?=
 =?us-ascii?Q?+dkKmSwznmtCkaqN9FJ6j6xI5zyApMm/a29wXW3fFoFSfQhY22vklurnrORF?=
 =?us-ascii?Q?1vJYBrHJCN811ZoiDlssGwUgTWtQKrVX7BM30oMbdqZCMsnRFv2oimoDfiKX?=
 =?us-ascii?Q?0XWVA+LDqbqALb4EvQlZtFKUbo1qSieliTdE47V88OTJo8FIvulZWkir51H5?=
 =?us-ascii?Q?G0iQVFOTE69nMRSETGtUNnpnZGRebITjE2t9GO8d+Tj96e3EkMZSl7/AftRh?=
 =?us-ascii?Q?OtO5Qva9UUaulZahGfGNCn85xsiPUUVHyVFddvT30DfxxbuhE+K1tK1QswxJ?=
 =?us-ascii?Q?sKyDB4qtqE3O3ESM4X0jaTuMKfFKq6wzwu2rHP6CwadSmO3MZlQdZFaD0RRx?=
 =?us-ascii?Q?mMt4QyAkAT9htJKoFqJ9+L+bi3/xqgFyTtj71LQ2afPddAjsGGWlkPT6mIwN?=
 =?us-ascii?Q?nC/TWosxWOkPfP4OiBptHOIa0RhWHyz/TDOJp/wN0V50C/hAbF2Zxs7NMkNW?=
 =?us-ascii?Q?y3wv1Z111j2PK4pYd6fJFOoLR1J9PHd3dcbqMylOZc/DQgW5mixC8ICduBTJ?=
 =?us-ascii?Q?LSP/H5OOR6BIXP7UtM7opoyZlj1jG4hbpXGe6oI1PdR6VuCIFg8Xh/7GudRW?=
 =?us-ascii?Q?pqXMFTp1lSKsznELyraKZDAkxXkhWFwTpx2V/cQw5+/oqvUBTTFMHZkbvH5y?=
 =?us-ascii?Q?UbXIZE0ktMkWu4fwl7t0hPYYmiF2Ka6e4YkU?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DehT1U0IFcLoPn6ZePk7eKpNCa0IUVeqBrrkN6GVPUJb+OH0tmb/UQmx8KEf?=
 =?us-ascii?Q?/eL9YbLno2Av0uWBYyD/Yl+0aZx/p4ivIx5oPwbFw+xx/ePYbu9mWvclga+Q?=
 =?us-ascii?Q?kF8GbXbi53v3y+tf04WzXwmzg5nP9lDQ24hQeNqtguR2NDn3SJ6xHIq7QNZX?=
 =?us-ascii?Q?4hOdgbp4SpIEar54hxtUM3qyc/Mibb0178i2QX3dqCj89mWfclSTm6BJ30PY?=
 =?us-ascii?Q?cJtT8ijaS2tEUzULT0gThMsD02f7dp2x6TYYtzookE9eWzDrCB8UEc2WNJWh?=
 =?us-ascii?Q?8e/k1ZYWkeDOuHPfv8V/+Oq2tX0wmZUp7LptShmoAZiYiY8GiKnrxytOUU+E?=
 =?us-ascii?Q?BcOSjmd+s+n2kVcjQ5GBX60cKodFjimhqtlEcmFqZUrjWufMy4G2PZpHrJlH?=
 =?us-ascii?Q?s7XaRb0xQ757+SwkNs+86A3GkMH/x+jeqT/SWBYSiQh7/evccaTJjwCEtx3B?=
 =?us-ascii?Q?Ealpws5Y5VSA6mhUbr7nAal8why87XmWLwYZM4yZk9FR+eaIzQkLV8/vlx5I?=
 =?us-ascii?Q?fJznaT0GMtYZNC+l+U+mYQvLze0ALxfL3pZ+d7BTXSGJiL9aJWBX3MHvqEIG?=
 =?us-ascii?Q?riuuyXZVFnJGPIUbV+bn3OWn5vHi1EHKvGARMQcow3RBa6C+gYQmPude0xO2?=
 =?us-ascii?Q?ub6Twjb2Ycg1WrzvRZryCX6nzMFNmt6FMBUDSPBWppvnHmFDiEd3MW5UPuaH?=
 =?us-ascii?Q?YfhwSn0fN0361wpwIDolE+aYhq1LmwCkV96vAJtDzfruoetYXV1bp0ohZyoO?=
 =?us-ascii?Q?ZAC9LZGQdFbNuujkjAZDtqSFsBIu2dvA/u2+rgQs4GOEIe8sp65vOMjf8pIv?=
 =?us-ascii?Q?ZS0QgTX+B28clzhgJr/TluGmNLFWa3ksH9GtXshyZQkfD0vrQb2lSVWRuUx3?=
 =?us-ascii?Q?P8PyFqJeLDi6TO53tO5Y7bYnv1eRjLYiUWGjJKnVRv6/T5o3zzPMW/qC2A3k?=
 =?us-ascii?Q?COgah43jpIpB4kC9zO69+il0x9/BuF4zzH/2o8ZuOsxl4m59/pNsRJR5eMMH?=
 =?us-ascii?Q?fdjsDrAaOUPGh5Asct6wVEvGw16WPr6//IS61egy0mf7BJRF+ldnzMjpGfY8?=
 =?us-ascii?Q?ss5p2AEoFEIU4WrwDz0wl1GbOmvpZU0Wak11Oeiy3s6iaL7nV/W4KvxZpruB?=
 =?us-ascii?Q?MD/sctau/k7sa8+GLxLyEDr3HD1iLL8VkqonaTW4hUQ20LQ9H6zd3LXZm6QE?=
 =?us-ascii?Q?39ckOEuSlGWu8qq5HK3NNu9R4DdLuuffonqBpsoPenVhFq+mZ2NZeqZ69pQP?=
 =?us-ascii?Q?ooYnjysUWcqkbGnDPvfr7xWpqButwo9fcYcSsUoNfotKvpm3vRl7EYgh6+xW?=
 =?us-ascii?Q?ZFFack+npbbZs0w8yhPVWJ6elVcL5m4tAhBR8iFeMs2nPF6h6Zxhz+zQ10cG?=
 =?us-ascii?Q?gV/p22Y8495B0rAaVlJqUwn6SJbRtx0ohc1i+yrkBT8Wi3/141LixdVwdBMt?=
 =?us-ascii?Q?umkQQSIXL/bs7vyBO1BJxvvFqKRLGl/PlarLZrDV+CElwfYyznQwqvwKP0oX?=
 =?us-ascii?Q?w+knix9IBFQilKIf+jWJJnraJNWjhqG8urlrgydm7P84a5kvPbfhZih3t1fs?=
 =?us-ascii?Q?tcGRAyD5lOoVfBT022uaoKhTS56n9zmffm9rW8jvR2yB5VXy+fO+OKVwiAHx?=
 =?us-ascii?Q?UXvb9HveRhdSu4r47Ec+1XUrXqxgvXi+Cs7s6cxnsMCmxjZkngSGJEXx29SO?=
 =?us-ascii?Q?fa2kIICXQKGpiXLgW0NlztNcsage8MXHtmikhtBFLBEMnPla1JF07MB8k9E3?=
 =?us-ascii?Q?hCfK9Y40pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	M02ERyVpU5m1wKbEyQEWv0YRY7raHXNmJFqelnu1yh4Pta+6sCQ6MFEC9kOZVZm3fp7/TRqkzasbZQgciwmOovPvJkRNZIS2pEwK7BuKmiUquc5BMAqeW/7I4S4UTeocCkYaAC+2lXOZUd7zUMPculh48xFHt2VieWQpztG4wujqPuL3R00jS+J5ONwqrdIRMUEAuQrXFzDGfcLhSqEJdxdnuAXJk7E539ek0Mgt1xcnn8Rh99ph8Lu4PdkaArVNm7bU0EEpECayPqQPRGUWRA7JdbfCmnImII6mFS3BWkt1hQsOXjxRRgFVGQeAXHo8ZRckhDsXUwi7apqKE9xTDBMFI2Z7GE/xOOSFRhZLvbb796ueiMifPimGdQOEDpnF1U0V+X6ltKDmVy9KoN75DGM004viSukZX8z7N6osGopjqs6fuY25Rd6pJzDxy8xoLLeJeaF7oCZb4W2Tx2pinxNNd5I0hcwjFJvnl0CPYFyONXpChPnrJvGhd28iqYieJvV8sfo4nXizTwR/BxnWSP4mtZfL0EQEA1LDbNYYsF2TcRqfX0MJ2czFuSVF75TE2vN08OO8BCKqCbtqrBIVjriJy7/JBBWjwP5lcIt+qgLqMfBGU4Jdi4vxgr3hlsGo
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ee1da1-2871-45cf-4b79-08de4046aa4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2025 04:08:58.2130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3azGCX2HHPDK1ryCHpVdBmxl2QPviiZcGjk1V9y+7N43T6bWuZB4CVCqQeJnvC1EKlLP4W386HInuCFepUA6BENdpodn7NT2ZeHdBcGF0v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9062
X-Authority-Analysis: v=2.4 cv=cbbfb3DM c=1 sm=1 tr=0 ts=694772dc cx=c_pps
 a=LFsqL2FGtdEdJ3QnM8h9+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=iGHA9ds3AAAA:8
 a=t7CeM3EgAAAA:8 a=uQ_sfJHIsSt3HWvwYWMA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDAzNCBTYWx0ZWRfX9IskUhlweQKb
 w1bmsUd6dEQSvfCMmc5P4ohrlSqXcs5pCpr1RbC9lROoVTna5KE+ck1RjvzeO0LPxlApNzariOd
 hhGgUu6Mj2CvbriC/szJ0FOCKzLBCqqhrNMiHWVK15OZzNTrSqeyThlevQFWYwDsIN/hCwpt+6/
 l5eoHq/6U8ewzqBMpAvM+kYfXRW6tvQ4MuNhuhn6fIzNW6jEmNDA/K3n1gBT6tDars1cWTPDFee
 WUM2XIiceBQNAJ4LMZbwez5m0oth+dENCXXlc/+Rkw5diOPnWDjSld7hBIeL7pG46LAeXB1Lb0A
 hsBl8eovWOf0STJcVumalRAd9Em+G08CzJXu6ojuOQGLAWCPMkCW7cXgBGRo9u8/4wZRLeDf5eP
 9J2Yy+N9klv7GDfYhvLcrqXcoLac7sZNrDcuVY3rriHwAKidpdGtc8CadVqEy2S/Yrwbe0oUr0D
 kAGi5CwHTPoqIiirIEQ==
X-Proofpoint-GUID: iZ0sLxGpRi3KdZqdFp6QbviQv0JAeH_0
X-Proofpoint-ORIG-GUID: iZ0sLxGpRi3KdZqdFp6QbviQv0JAeH_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_01,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512210034
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 21 Dec 2025 04:09:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2844



-----Original Message-----
From: Sasi Kumar Maddineni=20
Sent: Sunday, December 21, 2025 9:35 AM
To: 'Sasi Kumar Maddineni' <quic_sasikuma@quicinc.com>; yocto-patches@lists=
.yoctoproject.org; Yi Zhao <yi.zhao@windriver.com>
Cc: Sasi Kumar Maddineni (QUIC) <quic_sasikuma@quicinc.com>
Subject: RE: [meta-selinux][PATCH] libsemanage: Update policy version in se=
manage.conf

Hi @Yi Zhao,

FYI, this is one more change submitted to correct policy version in libsema=
nage.conf. This is the base gerrit for change  "[meta-selinux][PATCH/V5] re=
fpolicy: Add support to configure policy store root"


Regards,
Sasi.
-----Original Message-----
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>=20
Sent: Monday, December 15, 2025 5:03 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni (QUIC) <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH] libsemanage: Update policy version in semana=
ge.conf

Currently semanage.conf file is being updated with policy version 33.

Update semanage.conf file with policy version 35.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 recipes-security/selinux/libsemanage_3.9.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-security=
/selinux/libsemanage_3.9.bb
index 4d2568d..2425a2e 100644
--- a/recipes-security/selinux/libsemanage_3.9.bb
+++ b/recipes-security/selinux/libsemanage_3.9.bb
@@ -47,7 +47,7 @@ do_install:append() {
         PYTHONLIBDIR=3D'${PYTHON_SITEPACKAGES_DIR}'
=20
     # Update "policy-version" for semanage.conf
-    sed -i 's/^#\s*\(policy-version\s*=3D\).*$/\1 33/' \
+    sed -i 's/^#\s*\(policy-version\s*=3D\).*$/\1 35/' \
         ${D}/etc/selinux/semanage.conf
 }
=20
--
2.43.0


