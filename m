Return-Path: <rchiluka@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCEBC43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 07:47:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3611.1783496862187918142
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Jul 2026 00:47:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=eOsmd/aM;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qti.qualcomm.com, ip: 205.220.180.131, mailfrom: rchiluka@qti.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842JWD1656668;
	Wed, 8 Jul 2026 07:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=JqYSOVuHsvf00pU48V3OafunLK+a4LQ/x3nFDqZdAcY=; b=eO
	smd/aMy3YY1z8wVaHZm5NKomoShcSUBV0S1mlyZ3OEycSrE0gcqk3hsqnxqrCvZ3
	k+J17Qb14jSeRtpf2Qk0fyuxAAFd1Mf6xgteRN0yz1UaIjrEzRmpm48wYUnqXlr5
	EU1uO+vzdNJs/fWOemB05OlaluqPq5fBei5erVqg5zUmOvewxYoinzVmXTj2ZVjQ
	/BAzeT3RAo+1oRSjln1oWozZk4aFxb0/UW75aHYx37m/zLSxawZKku/sDCqvNUat
	mucHn4kaETLQ7q0A86V+YOzpoIufA/gKubDWGp1bRRHb+CRphW/oT/GN4URjQGz1
	QWqNK+KW0WygJaE6zIRg==
Received: from byapr08cu003.outbound.protection.outlook.com (mail-byapr08cu00302.outbound.protection.outlook.com [40.93.1.106])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9csssbbt-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 07:47:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R97BeMytwLUKaFjh/3uEdnGYKeuEt8f999f+ATq2zw08K2J3ePbWqD8a0pc14N1D+SJsL+j6Tzc80yzDIComX6nHv/DpjkiydpwD+AM/mzSa0h8y+ZY9zV92Pgts718WmkNyn7qYEzC3Le2IH8XM16dd4bgyp9egVA8H3SpJyr60LhxLn6K1rTamT9nWjCujGj9eC+zDJOBDq0ynkGjYy74/B7n6zGmDo+oCpPgfSqDBR0coz4gtm+fKFNVzJr3cxTKaaUZ/9RQspQ/cMTPafssT66G9IuxMmYIUej8AtbNCvN2eqB5KViwvftwccXthlTRQvmxYxGZIYSaMV2YR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqYSOVuHsvf00pU48V3OafunLK+a4LQ/x3nFDqZdAcY=;
 b=I2INuKgQIrh4Ed1G9gNiNVi+ZCL5pT0UsP/Jyfzn0Vi+IshDnlZ/Z7Lg7Pv1Si/JSouuVdrjRFRrYTv9AyQ5aqDfl/B+B92wp/ru+OygAO+pRFnaUNAwWjwfpnCcgEHrEpDk0V+iuHMHzByiPQjq7K+5TLTXTCCACsM7yfzPey1wymnRpPDiLgZn34XLQEZw6AHSVZi48b+y5fQPUzlZ2k2Kv/QSeoqIxwaKSIKnbqGB7f8YW1LxJtTL/6TrBWfAtXxEu072BohZT5VaELxYMEzAlUQ0dMfNWU+DITJX3eE6gp5rTbZj4AUHzn6utTAf5f/C8f+hd0jgjSx/3Tp6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ0PR02MB7821.namprd02.prod.outlook.com (2603:10b6:a03:32e::5)
 by MW6PR02MB9816.namprd02.prod.outlook.com (2603:10b6:303:23a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 07:47:35 +0000
Received: from SJ0PR02MB7821.namprd02.prod.outlook.com
 ([fe80::fb73:7e6:d2dd:1863]) by SJ0PR02MB7821.namprd02.prod.outlook.com
 ([fe80::fb73:7e6:d2dd:1863%4]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 07:47:35 +0000
From: Rohith Chiluka <rchiluka@qti.qualcomm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "joe.macdonald@siemens.com" <joe.macdonald@siemens.com>,
        "yi.zhao@windriver.com" <yi.zhao@windriver.com>
Subject: [meta-selinux][PATCH] refpolicy_common: strip POLICY_CUSTOM_BUILDOPT
 before passing to make
Thread-Topic: [meta-selinux][PATCH] refpolicy_common: strip
 POLICY_CUSTOM_BUILDOPT before passing to make
Thread-Index: AQHdDqwVps+iqIfqYUmIpW4aildetw==
Date: Wed, 8 Jul 2026 07:47:35 +0000
Message-ID: 
 <SJ0PR02MB7821AE63AAB7FA8A268F99ADF1FF2@SJ0PR02MB7821.namprd02.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB7821:EE_|MW6PR02MB9816:EE_
x-ms-office365-filtering-correlation-id: 3145cbca-09a6-48b0-e3d6-08dedcc52d30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|6049299003|366016|4053099003|38070700021|18002099003|8096899003|56012099006|11063799006;
x-microsoft-antispam-message-info: 
 q2GIf03Bj4tNFe5cLUjp3nI3pfh7X05BWwWvskCt34lcVmUkTv+2UY5fRZ1PbVn2kIwTux+RmDgBL5Faee/l51Ooe5mKPKTChD139w5ysTf6w9G6uSgXjFhDxJlZ502Jw40s2MlKD1uMLlq/nTxvjjuhDoRD+aVDWahTuYtuOhsY4Xchc/JKiZw3wnuhBYAy2jdlS0MgoKbE5+kWnvDhP/kWO83YJ0nvdPQrpgNcBj8isTQvVdL+GkjgaIdqj+ffkJNkW+dXbQQUYiMCj3/FwZqRsNafuebat28mWr9DI2rmGOlaNYfmuF+Ryk5Md6Qx+bHq+oyLbFqNzm/jZ3t05aI7Bas8rpaAIHb4uhz32VG6Wee1l7LNUkFDac9iNs3LzPBwEm9DHGX0J5VWFpARgJZYxSMZWr1cxrXsjdaiZnj43oNMRbw6r1xq6V/GQ5Q2EDGh99rj79fV+jMF17RH2RebYYaz8KADVz2bie3cOR79LH96+jelibvfD0iI9Yt4x5Ol/T/3O7pZAHYZDCuuhiIYiBcs/FpbAHaNBBkYjZpO3Y5Z2xsl/r+t7JC1cDKGD/+0fi8rXI9jmTwyowGkwkKWrxzhnATylyTjqZqTqR6NUvSJZvJFVQ3H45dX7sXHiWaZYv6SoVheWZCOyMY2Q3crEWr1t4sFTFpB8lyweH3jTIze/RGCKr5+aZ43DnG0ltrjh69L585FLXr7TtsMWxuNnBTMVHHrjK/E78NbxlU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB7821.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(6049299003)(366016)(4053099003)(38070700021)(18002099003)(8096899003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?JlnGfH7yqUQ9ASqApd43rzRXk95w0nkyw9zkq/oj/QrlAN76p1nmjqbs/K?=
 =?iso-8859-1?Q?el1UFwmROK5Ause7QYWDCrE3ke9oT7ZTyefS/Z/GsIT5Pu6uayTEuGG9b3?=
 =?iso-8859-1?Q?x2b5cNPDySBH5td0ms15LcTC6uYTpofyCK+pO+s+xn62nIQ1a997kfKdnq?=
 =?iso-8859-1?Q?zeG5aop0Y3XUQ9zIXAd3v1G3TJsyFjHEDC0Ej3949jwwXVZ0JWCSrZNTtA?=
 =?iso-8859-1?Q?+fFqk+EJH73FRjz+mdVYUVySNJpxHL9uT+VPR80fziIX3P1sWa+HLHj7Up?=
 =?iso-8859-1?Q?OZWwisDeyBc10n0JlLQIXiy9hnOjDQMz80MRj1kPnlAbHdaC2qJRi560Fl?=
 =?iso-8859-1?Q?aYPTPU0F0P6LyYw+5g9fWKVIp7dBEAZmM6J1e9BHMvrEOO0WJSZx0kIONT?=
 =?iso-8859-1?Q?PE7Of9gEIFEPOB4hWa3cMs/EILgoiB0iUsXqIrTcdPEp6cvSrP0sNOTs/u?=
 =?iso-8859-1?Q?qIPKb39aj0eY1dQk7Kgu7vQfvaT5FnY8JelE+R/YvVwo6ZLF3JV6uPB2se?=
 =?iso-8859-1?Q?MlVrIjGdZjnSridpO2EurZugCy27LBWR7T9fyG7MQTuGxMCvSErrrYEzU4?=
 =?iso-8859-1?Q?EnnQwvKh2/0brQyGthVqJCihOUIuEq7bJjjGJHERIChhQKdE6TYWDliMYX?=
 =?iso-8859-1?Q?j22JnLMDl0rDedHLuje61U1MTSVaMqvcJDN+xHEZgcEmjDRJWFpVIZLQai?=
 =?iso-8859-1?Q?ZArFaQNxtYZb87vrvcFcQy4nZmx+lNA1raegppn/HoQf3fK2bfrTPMTksG?=
 =?iso-8859-1?Q?ike1xpfIVB2RXNhOgnuDY+Z2aN1MJH1pI3FiatQQarPveg15HGb/sNFq/y?=
 =?iso-8859-1?Q?AnkNNtjB1whop+33XCaZWZopxZkA587/m4uTCZdHZzr49AkTMW+fwK0gxp?=
 =?iso-8859-1?Q?qgeQgCliCDL1QUoEfy5xSVkL/4QrHxjEDxdZKnAXHxKjDXNJRstctquvn1?=
 =?iso-8859-1?Q?VxqjRmUWt9VP2lCsV5wiuPD6xJgsKxG9lYW8d6jsP5obivnnzFx69UdpNl?=
 =?iso-8859-1?Q?PkO24IpYkMHV4yhdq+dElvVwOA0w/8zd9OR13Vebuj8MiTSYFXsRCHOsZ2?=
 =?iso-8859-1?Q?6y93VTF/PWxiEi4igtW9hGMfwcVFeBHPVHI7nLscXpVx+BVjaLVJkXaBv8?=
 =?iso-8859-1?Q?B8iAY11JM8cpz5ycO2GQjYYPSHdpFqNw8WQ09SXaFiJCjWoP3dMlA91HLy?=
 =?iso-8859-1?Q?squF1Wf521DqleGVytdUPHD2WabNwY0JiNqbeS/q8vone9MTL2d/59m89D?=
 =?iso-8859-1?Q?3xYtiNw3RaiCNoikm/jx1GO91kLFIR2z1EFyCATRWGLL2a2noHH1yPqUjV?=
 =?iso-8859-1?Q?1T3pKwq9fEv8Cb6+llCUQkLKe3iLebvja6Tze+FtSkBE2ymjnqFuSauy2S?=
 =?iso-8859-1?Q?2iBj2/fjwcxeBVVOpINeDgACzIEyPHWnpzWCXdMbfoK7QhGJh8WDiKGtzK?=
 =?iso-8859-1?Q?xEX8GzZj3IqkZyXCkglE5/4OyPo0jfRSOnMFCZuKXN13NEUlsxOWB0VyAd?=
 =?iso-8859-1?Q?pO5G49hYyoFHfEvL/WtAwFLgVI0DXIEcJJH8vShTnnpXKlOi+uF9wfX0xM?=
 =?iso-8859-1?Q?WSYL0HQal7xT0qJhKuJgr86m2Aio9JQrplHjd/QlaqDV4Ryl4cRMSlephc?=
 =?iso-8859-1?Q?J+Pd9dwhDgEAKatMaUQFNpUbm3egz690rMJ1F+1TqagI9u3W0fJqLw5Git?=
 =?iso-8859-1?Q?18ZdJAab28aJClzBy0+qPmZqPIqAvxXymZxbMkVvWSe8O6nBhZGQwHXTKM?=
 =?iso-8859-1?Q?QgMCLq3OWcVCGktzprucEkLUopxCSZTibjAAf8+jmgIoCs+TZZlQV4xOLC?=
 =?iso-8859-1?Q?spVSpwZLuA=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_004_SJ0PR02MB7821AE63AAB7FA8A268F99ADF1FF2SJ0PR02MB7821namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	QoYbWrHH/gP6bbQuxiLK7n1gAAovgQpxGau6d5fhHlhMXnWrw5RExEWTZuOUvP1LP0opnSU8+Zq1U343khHb2UngO/J1QnzaAr1giwrp4rP0Mz9A2chFJOH+clLp/Rn0KSxJ/qfsxKaAqBUp9bo2sD7f97J3ZLiBkf/ryYRWaGR7V181tCVfRVTZX6aXskqjLRs37key5n4ZW4zGDgSUtNYklTRm4soRYKUc48GSFGYybS0si/+8tUC7X45eeZlJqb6/VE5wsD4S2UQF0cCFn5GhMBC6Mvmrrg2E90bQcZZ7stXp9uRH1L9krGMRz1HJajFE01IH2OiZiYlaDD7skQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GrOGGFBZzkCFEto6V0TGBQwwGJ4HqBcsusJUJ2ECO2PQ3Xm0fTwBLPJhwVaNn3PNzIp/Y42nxWp52ncOnKQ4cp6qn8Fth7RAT5Gv7GZ1HpSPNhs/8QRkAaV3teiGoBD/7H8ZC2TSkoT6D3TS9/E7S16VmTYslgDYT0ivLPH56lwcP/WMiRGk4jf7VnWSq0OjhfiV4I7IPExeRymx2g+ZqiBbc7LIb7GRDV/BhDKOJv3vt/fPZIR1SKShqsGmQNlwTt19AzlaJbzZBf8U3ZXc+d1eNCZB2yrun+N9saV7sgmTJk4QghTRAsTcITNrqi8aOWs5aXR6LYmLwu3WzRy4tKfdYXN80nyXCgdGscAEggpvUlje8X+JGUrZNtBUBoBqGJIX7XF2HYqaTpvplXzGrJ+1FllNL4HgovnUD14w9S/kNu5A7IfhAX6IPvPQ73dP5eRebmj1SHQsEnCqtIok2XFSae5iX0TpoiuS3Wq5CVm9Kq69ZxRTB+mEZzTk/NBZl+lkiHV/3ZFbpe226JR3DV8hBIRTYsZcfLBP8kFNipgrIaA4s8CREQxbsIhyJ1wheVPN9g8hGjz8pKHfqB8VrpY5PsSPMPgNlRnwz5C2qQFWnz3dr/HgXGJ9yC49K1qL
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7821.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3145cbca-09a6-48b0-e3d6-08dedcc52d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 07:47:35.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prWPaOKk/v0h+fK/9QRGcozooVyv9UgjIvVzRYI1xy+n8zizqkkGIN6i0AnnFei8SE2N+WekPvYHPaGV5+gAPGUH5RI4mFf9nrQIjZiXssQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9816
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4e009b cx=c_pps
 a=3CRHu18DflYqj82tS/m+pw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ODj8oAt0KyTlCUJcyBwA:9 a=wPNLvfGTeEIA:10
 a=YiUiQvwFPB3HWbwCeEwA:9 a=islKDBKu__pYnCpS:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=u4Ef-fn88yQwT9K9ZQ0A:9 a=B2y7HmGcmWMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA3MyBTYWx0ZWRfX89DcVhgEY20O
 zqtSMslYdf+HfJuJmirxaJDFfrKwSBVMAHxm+W/YdLGY0NrpRxtGdoDF6WVcagswI3tnK+G+mFf
 o4FRMyFlAITChpyMPhRTgzZzGWNS/H94KhnWOOGyKNnUqQJnW+EVzptKjIffhbTqmm0/K/U+OEL
 h3fDapoPctSdZ3GrQhD6lPF0q4ukhkuzoTlOChvXEudPwzQ4oGx1w+g3FDwjKy5bF2YiRYxuNtY
 TGL7n3JeslwgEgpuKEg0mKlFa9mjJ02o5UWlFUh8pt1qa6RcWyrx2jjLpsJqzuFkLsHuHxxxFpV
 enwWo2nf/5C3co6Eo8S4UglcH+kB8WjCqW7IzDnOpDrrSFPkNACIZFfMfc6DyuzY5UV4PeJsskT
 f3xJRsRoP+X9G+Icx8fkbxWNVoJqbIiHbwotP083YW4QfvKCFaHMU4BlFgusD9y0e2g1Z4qJtrg
 +oXDAd3E4VFnUXQ/q3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA3MyBTYWx0ZWRfXzdMP8wkdTxqL
 ZkimmBsNKMc6oADxH9LnIplVYdSElnlJ5dPyfuTbXFLRrWUjv0DrArYf1TXp0uM8mx/oYrcJg1i
 sHiJ1GVKWGqOSSGeMEuaRik+jfK2eh8=
X-Proofpoint-GUID: Hvz_0Qed2ix930xmu0OEZZEAGb9R1HwI
X-Proofpoint-ORIG-GUID: Hvz_0Qed2ix930xmu0OEZZEAGb9R1HwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080073
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Jul 2026 07:47:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4452

--_004_SJ0PR02MB7821AE63AAB7FA8A268F99ADF1FF2SJ0PR02MB7821namp_
Content-Type: multipart/alternative;
	boundary="_000_SJ0PR02MB7821AE63AAB7FA8A268F99ADF1FF2SJ0PR02MB7821namp_"

--_000_SJ0PR02MB7821AE63AAB7FA8A268F99ADF1FF2SJ0PR02MB7821namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

  Please review the attached meta-selinux patch.

This fixes a refpolicy build failure when POLICY_CUSTOM_BUILDOPT is extende=
d using :append from another layer. The appended value includes a leading s=
pace and the current refpolicy_common.inc passes it directly to make, causi=
ng the appended option to be interpreted as a make target.

Signed-off-by: Chiluka Rohith <rchiluka@qti.qualcomm.com>


--_000_SJ0PR02MB7821AE63AAB7FA8A268F99ADF1FF2SJ0PR02MB7821namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; Please review the attached meta-selinux patch.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This fixes a refpolicy build failure when POLICY_CUSTOM_BUILDOPT is extende=
d using :append from another layer. The appended value includes a leading s=
pace and the current refpolicy_common.inc passes it directly to make, causi=
ng the appended option to be interpreted
 as a make target.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Signed-off-by: Chiluka Rohith &lt;rchiluka@qti.qualcomm.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_SJ0PR02MB7821AE63AAB7FA8A268F99ADF1FF2SJ0PR02MB7821namp_--

--_004_SJ0PR02MB7821AE63AAB7FA8A268F99ADF1FF2SJ0PR02MB7821namp_
Content-Type: application/octet-stream;
	name="0059-refpolicy_common-strip-POLICY_CUSTOM_BUILDOPT-before.patch"
Content-Description: 
 0059-refpolicy_common-strip-POLICY_CUSTOM_BUILDOPT-before.patch
Content-Disposition: attachment;
	filename="0059-refpolicy_common-strip-POLICY_CUSTOM_BUILDOPT-before.patch";
	size=1349; creation-date="Wed, 08 Jul 2026 07:46:57 GMT";
	modification-date="Wed, 08 Jul 2026 07:47:29 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlMzcxZDE2YWJiZTAzYTljYjEwMmY2YjViZDZiNDBiMzNjMzA1NTdiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaGlsdWthIFJvaGl0aCA8cmNoaWx1a2FAcXRpLnF1YWxjb21t
LmNvbT4KRGF0ZTogVHVlLCA3IEp1bCAyMDI2IDE1OjQyOjEzICswNTMwClN1YmplY3Q6IFttZXRh
LXNlbGludXhdW1BBVENIXSByZWZwb2xpY3lfY29tbW9uOiBzdHJpcCBQT0xJQ1lfQ1VTVE9NX0JV
SUxET1BUCiBiZWZvcmUgcGFzc2luZyB0byBtYWtlCgpQT0xJQ1lfQ1VTVE9NX0JVSUxET1BUIGlz
IHBhc3NlZCBkaXJlY3RseSB0byB0aGUgcmVmcG9saWN5IG1ha2UgY29tbWFuZAphcyBDVVNUT01f
QlVJTERPUFQuIFdoZW4gbGF5ZXJzIHVzZSAnOmFwcGVuZCcgdG8gZXh0ZW5kIHRoaXMgdmFyaWFi
bGUKKGUuZy4gUE9MSUNZX0NVU1RPTV9CVUlMRE9QVDphcHBlbmQ6ZGlzdHJvID0gIiBvcHRpb24i
KSwgQml0QmFrZQppbnRyb2R1Y2VzIGEgbGVhZGluZyBzcGFjZS4gUGFzc2luZyB0aGF0IHJhdyB2
YWx1ZSB0byBtYWtlIGNhdXNlczoKCiAgbWFrZTogKioqIE5vIHJ1bGUgdG8gbWFrZSB0YXJnZXQg
J29wdGlvbicuICBTdG9wLgotLS0KIHJlY2lwZXMtc2VjdXJpdHkvcmVmcG9saWN5L3JlZnBvbGlj
eV9jb21tb24uaW5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvcmVjaXBlcy1zZWN1cml0eS9yZWZwb2xpY3kvcmVmcG9s
aWN5X2NvbW1vbi5pbmMgYi9yZWNpcGVzLXNlY3VyaXR5L3JlZnBvbGljeS9yZWZwb2xpY3lfY29t
bW9uLmluYwppbmRleCAwMTQ3MTRjLi4xNTY2NTkxIDEwMDY0NAotLS0gYS9yZWNpcGVzLXNlY3Vy
aXR5L3JlZnBvbGljeS9yZWZwb2xpY3lfY29tbW9uLmluYworKysgYi9yZWNpcGVzLXNlY3VyaXR5
L3JlZnBvbGljeS9yZWZwb2xpY3lfY29tbW9uLmluYwpAQCAtMTI2LDcgKzEyNiw3IEBAIEVYVFJB
X09FTUFLRSA9ICJOQU1FPSR7UE9MSUNZX05BTUV9IFwKICAgICBESVJFQ1RfSU5JVFJDPSR7UE9M
SUNZX0RJUkVDVF9JTklUUkN9IFwKICAgICBTWVNURU1EPSR7UE9MSUNZX1NZU1RFTUR9IFwKICAg
ICBNT05PTElUSElDPSR7UE9MSUNZX01PTk9MSVRISUN9IFwKLSAgICBDVVNUT01fQlVJTERPUFQ9
JHtQT0xJQ1lfQ1VTVE9NX0JVSUxET1BUfSBcCisgICAgQ1VTVE9NX0JVSUxET1BUPSR7QGQuZ2V0
VmFyKCdQT0xJQ1lfQ1VTVE9NX0JVSUxET1BUJykuc3RyaXAoKX0gXAogICAgIFFVSUVUPSR7UE9M
SUNZX1FVSUVUfSBcCiAgICAgTUxTX1NFTlM9JHtQT0xJQ1lfTUxTX1NFTlN9IFwKICAgICBNTFNf
Q0FUUz0ke1BPTElDWV9NTFNfQ0FUU30gXAotLSAKMi4zNC4xCgo=

--_004_SJ0PR02MB7821AE63AAB7FA8A268F99ADF1FF2SJ0PR02MB7821namp_--

