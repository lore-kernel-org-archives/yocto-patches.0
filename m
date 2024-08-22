Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE80C52D7C
	for <webhook@archiver.kernel.org>; Thu, 22 Aug 2024 11:37:32 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.143])
 by mx.groups.io with SMTP id smtpd.web10.11302.1724326642456008449
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Aug 2024 04:37:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@navimatix.de header.s=selector1 header.b=cXDPHbk+;
 spf=pass (domain: navimatix.de, ip: 52.101.70.143, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhm7fycVoRiLIRS0Ut4d92WaPt586yHKpjkqCGv+eA0MNTx2mpn5a7buSTZmxzYPGxI+ei6Ra7oCNLSta45AtJot36WXnlFfjjQWOuIkYZZj7TUCt1VgPtA3blWrxtVCmS91BNBfatG3fQuWfG9pce79FYoTN7j6nKq8hufJAR3TIjG7/rUAtASfzbhb1VuxM1sdAcLuBcdkEmxiTdY9Sy6jXB0xU9lR08wPHKT6A0thcMOYU6FuPQ5nkb/peFflFzLNdKGik50KjxTp4FcqkpoaIwSUrixMvE6NlUC7JNu1hiif+2E1JnHqwyfkUWrgaGnjVohyGNWV2SWhwmqdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAHi7BsffNpWR8ovrS29bFppGcsxwsO2LOBaCf8TF4U=;
 b=KTKV24sMAQB7yPxxinLQbQaSwbgKQzwh7R3qZxq1VYc+9snf/9UD7nBUjb/wQe29LsKBc+6qwJiEImP2sIXlcRWPjgYBXsGqxmR2+R8QjKyG/hptoZ+S1xh4xYaOmrNNucUdym5eV1IemWWvXbiWeDDC4j+XHXQX9/uc8/ctIMbVHFqDbMjrUdWvISkaFPPHUS0IBXZ9BZddmUJ9x5lyYfAUvqRN9LmECOJ9msqdZ/z+TXEPc0rArH88nfklGVdTK0AvXj2TPiUgiiX3XbrykXpqdOXCFSICj0yZDqle7pUs9iF5xwsIhCiSobTgwFIzBa+t8Sw/Cv2fqT3Emx//Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAHi7BsffNpWR8ovrS29bFppGcsxwsO2LOBaCf8TF4U=;
 b=cXDPHbk+WkY5S/eBu25ijVe5si/XEfN/u5j38J/4Rf9vb7luPjuMkydOZNw9TrtRe1jzpH8tnzEDBjKKLTfbvgxG4KML5WBlpK6W/kKiJwOWECX/jz/kjywwkb2zWAzz3YE78zXlMdTnZz2Z1KUTfxjDoDKCE7XCTe8CWjX8HGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2d4::5) by AS8PR01MB8714.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:44d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 11:37:18 +0000
Received: from DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 ([fe80::d520:1b9e:a30e:69a7]) by DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 ([fe80::d520:1b9e:a30e:69a7%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 11:37:18 +0000
Date: Thu, 22 Aug 2024 13:37:16 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: anibal@limonsoftware.com
Cc: yocto-patches@lists.yoctoproject.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [yocto-patches] [ptest-runner][PATCH] README: Update mailing
 list address for patches + add git command
Message-ID: <lylbqxoz7egejkh6nfkilnbzfivwwp52vkle4vtn3ga22p33m7@sl4qsaqglypv>
References: <23f3f3e4c8010e7f1b2322976ded709912863ca9.1724240133.git.joerg.sommer@navimatix.de>
 <cf10983b4b7efdd6125d2dc519d52fab9f4ec3ce.camel@linuxfoundation.org>
 <h4mbf77iqrtjho2p55b2beriufcf3b5i773onru6wignzjnxlu@v7ncwogo3k6y>
 <CAOU5ZMun=6eiVpSXNMz8Ca0kpdoD3gkEMDa+PXOgSVc8U=qwNQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha-256; boundary="l7w2t7ohqd3zhsbc"
Content-Disposition: inline
In-Reply-To: <CAOU5ZMun=6eiVpSXNMz8Ca0kpdoD3gkEMDa+PXOgSVc8U=qwNQ@mail.gmail.com>
X-ClientProxiedBy: BE1P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::11) To DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2d4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR01MB8293:EE_|AS8PR01MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 3441c4a7-efa4-4d79-59c0-08dcc29ec739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L3lxSlpOUHBqUjRwZkZ0cm5jTTlxL280QjZPMnUvT1g0RytkZUl2OEk2bXht?=
 =?utf-8?B?NUFtaDZNT1F0M1MzbCtUa1hsaXBQTHpFR09mUXEyempLV24zOXdEWUduQ1lL?=
 =?utf-8?B?eFZzVG1ES0dLZnp0akNoSkVya2ZRUW0vTFZveGI1YkV4bTRSNlpMRTgwM1Bi?=
 =?utf-8?B?MXBBOXVQeG40eWhxZVRvaGtaaGVLU0JRZ3hCeWJ2bHR2dnltQkI0M0NYSlZ0?=
 =?utf-8?B?ZXpXZ2RzVytBWHllOUMwWktJVWFMbk0wKzVac3VTTmNNNldUYzJXRmdLcTJZ?=
 =?utf-8?B?aWFNbXAvaDBTRSs0cXAwS1lEWHNTczhhWXFadzZDcWxjb0l1L1FPQnNSZUdJ?=
 =?utf-8?B?czFGQ05BSDN6RVNoUHlqZ1RvMldPV3o2dWFiM3JuZFpFQTB2bHRjbmVpTyt0?=
 =?utf-8?B?M0tmc1oyWjlsLytNWUl1WjgvakcvdFpLZWdrZXZEbHlyY1I3T0Jmd2FtNlVi?=
 =?utf-8?B?cUtrcVV0VlNrNS9La1p2QVV0aUo4ODZVTUMyMXJ4aHBsZ1FrQjNsdWVmb2ZB?=
 =?utf-8?B?dm52cG1rNFhEaFR3eDUrNFdhY2lKN2J6TWhJM3NZSC96YjF6SXNjeXpKNHRC?=
 =?utf-8?B?SjZBZy9kRmQxNXMyZzdqTXEyOFQvdzV6ZE5oRzhsZ2RXYVVEaG5qN3QvTXc0?=
 =?utf-8?B?ckZxMmpSbFoxNE84UERGanJGNWhoQ3RFcTc3R0lkWG1mSlRjbEFBQXJqV2Z0?=
 =?utf-8?B?eVBZTEMyQjZFcDUwMGgybjI0UnBMdlV2NHZmYTlwUTlHZWd4WUNEM0ZxSGJE?=
 =?utf-8?B?Y3hXaEQ4cHBHTXkwN1NhZzAwcmtkeVo1VjFYM3NyUjNzSVI5TEZ5RUJ2ZWVh?=
 =?utf-8?B?M1hDa1JVeXZtMUVxMkdiQkNRVlJZUHF1WVJXVVlzeFBIeXhSaXorRlBOVTBx?=
 =?utf-8?B?NjEzMEZmK0h2azF5TkpvQ3g4bTZWN1JzRUJOaGZnMzRuRXpOWjlOTmJvWGt6?=
 =?utf-8?B?UllGcXk4Z1JoRXNQUlZzdEtHaWV3VW9LaDVyN1NKYTR6R1A1SmRHcTZadDdq?=
 =?utf-8?B?NGJSUjArVk92aDVRM2IrZUM2WE9kSVNxMW8xV09CTFAxTDk4US91eFE3bHJ2?=
 =?utf-8?B?TFJvTnhDZkMydXVGOHl3QWY2Ny9pWjlYN2gzaHBwVURlVW1TcnBVY1ZZVVdS?=
 =?utf-8?B?Q0pBY0lrTGx4Rmc3QmlZS3MwSHZrRHBwWDBtcGM3VlhCTWp0KzJDdDZtc1pr?=
 =?utf-8?B?RWZ1ZS92TGNjWHhKZ291cXJhVVh0LzVseUJWV0Fxck9qRGx1a1dTdXBuT3pm?=
 =?utf-8?B?VEYzZmlNbitabFVSNTIxOXQ3SHBoTGhXQUkrSXNFc1VKLzJWZWhsR3VLLzJs?=
 =?utf-8?B?UURCOXR0L3dnY2ttaUo2VU9CS0hEQzIrVTBJNEpLWnNCa3NXU3JzN0dxQ1Mx?=
 =?utf-8?B?ZVM3YWZBMFhDcU5rNmJOSUJkeEhBYUNUMjN0d08wQUhmR2d6dW5pR3FFZ1pI?=
 =?utf-8?B?UjB3eFVQRy83WWs4NEYzV0ZXQm83Z0dWVXR5YnpCSnYzd25OaXEzc2ZwYjl4?=
 =?utf-8?B?UXdRbnBXQlNrZTlzYXVKdlBJQjUwNEI5blVOdDBwQkxaYkVPRU9yT0s4bnlR?=
 =?utf-8?B?cmZPcVA5TkxjN2hDYm5ocE5VQ2J4MEFMS2J4UHJYenJvZDQ3MXA1UmczaDBR?=
 =?utf-8?B?SzB3SmkxWXUzVm8vbGhsTS9rTWVTUFBjQ1ZhUVlRMkFJeUNVYkt1UmlOdlhD?=
 =?utf-8?B?QmxhZTVNVTcwOUJMWU9xdWZLRGJDMld2eFFKRXJCMnY4S1lVNzU5a2NDY08r?=
 =?utf-8?B?RkZacjE4WFRFOVlFQzBiS05MQkRxdlBrd0UyQjBJQ3lkeXloQzBKS2J1YUtK?=
 =?utf-8?B?d3YwT1ZyQm5NeGtabzlBQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR01MB8293.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eEdoZ0pOMVNhT2kzdE9rTzBnckdiR2VQT1hsZ1hmZGRET3VXTk8yNXh5cHhL?=
 =?utf-8?B?U2VHY1Q5MmFXbnllZXp6elpod0syZ0NjdnBtWUI0Qng3Y3pIRzFOMjVsUGxm?=
 =?utf-8?B?Uk1XZVdzNGR6RXhYVllRSFoyaDA0VnMrd281aFpoZC9FU1RCRWY0MEJVaWN5?=
 =?utf-8?B?VEFjSzhQdUdQZjhvcnluYXlvY3Vvc2dpb0d4Qm1XWmJ4NmpHMjFJK2xnb1Bt?=
 =?utf-8?B?bEpkWnY1MlJNemdFdFBnU1pHeTNCWFkxdjRUaExrbkRERlFCTTZsTk1Na3hn?=
 =?utf-8?B?Z25rMzBaU0drclN5WjNTcWlodS96UGZ2cXM2eTk3SVd6NUg2SjI0bXNkTkti?=
 =?utf-8?B?dnpQS1VuQnVGMmszd2tHV2tKa3NlMmlkQUpEakttNmtmcDZZR0dSOTRzeEhi?=
 =?utf-8?B?dlU5TlRmeVFJT2dvVUQ2c0tseWl0djRudUl2bWxyZWJ2bzE3ODU1ejdScDRX?=
 =?utf-8?B?blRUNkZyNm5JaFNVcG4zMHBJejZ3dTI5Y1h4Q0dFc25VaVkyYm1MK0RlOS9P?=
 =?utf-8?B?STBxbXN6alJjb3pETFVMUERCZUxTcFpJenpvamhmcStLU3ZkYXpqK3dqVnBq?=
 =?utf-8?B?SGFkOFRLQUFsckNUekorNVlGdWVxMFgrU1ZjWFhyOERPdEN3RGx6M1F5VTZY?=
 =?utf-8?B?VXoweEpSeDdCZllUTUFkOHB5cnpabnBPYURuOGJiNHREWlFialRkalUvSjhm?=
 =?utf-8?B?THFCQmpWSEM0WjVPcVdaNVRJdFZ4ZlY3VFRoSVpPcmFaS01raXc2eXY1U0Fo?=
 =?utf-8?B?NDcyZGhCNy9iK3ZwbFlRSkQwYUNsSWw5MGFDT00zT2hQeGhSNS9ITHFONXVF?=
 =?utf-8?B?MWMvc0x4Wjd5aDBsOGNsaDRaRGdGbkhaS0FCMTB4TXNGZmlaVEpBZXdsU3U5?=
 =?utf-8?B?TDhlQTdRSEd2bWpBVWpLbjc0ZE1UMDJOUy9UNVQ1YjA2V2lJZlp6UDV3cHhH?=
 =?utf-8?B?L1hOa20rSnJBazN5aDNERUpQTXJkZEkxMDZiMFhlY2FEZ0tnUy9XSmFHWHI2?=
 =?utf-8?B?TDR1SzdEZkI3Tm9NREhkOUpCZTNoR3RDSngxMHZGNSszSnpzZjV2V3FmZmUw?=
 =?utf-8?B?RmJLOTBDa3k0OTdsWTAxOEJNQ0RlcEVJUmV3STZMNlUxMGl4VmVCZUZMTDMr?=
 =?utf-8?B?ZHJSejRReWF3dlRRNlplaUpQK3MrYUtsenc5OWN1MTd0RnZ0S1N6NEVJZnZR?=
 =?utf-8?B?TEg1SGhFa0kxQUlRL3dOSmFRZWVqUWpmeitZRnlLSCtmNTRkbEp3RTlqMVpt?=
 =?utf-8?B?Q2VpamN1VHBDZEgyRjlXQjRNUkZObVM1QWVXQS9JNUNOR1ZJVi95VDIzb09h?=
 =?utf-8?B?R2xCUUdEbjFrWTJwUVpOcEdkSjFCMmh2ZWVNZkNqSHZ0TUtqSDhUYlV5a1Zt?=
 =?utf-8?B?M3VnOWVZQSt0Q3ZZYkoyUTc4Wk1HTE42dmR2WW5DOHJEZ0NIc3VaeUhiWEcr?=
 =?utf-8?B?TTZ5SUtrelViZ2YyOXhYekVzdjAyOWxCd3RrU0prY3NmNmwzQTNoVXJUQ2Zq?=
 =?utf-8?B?QVc5S0hvWTl4bG9Da2JNVjFtMkJVdXA4bnU5M0VOekthdDdwM08xbENGVVJy?=
 =?utf-8?B?N3haSjBlZ0R5TEdSY3ZrWXNkQXl6ZFJpTm9OMFBzeDVDaVFFYkxscWJUUjRJ?=
 =?utf-8?B?TzR5b3o2MzBNZWZGazRzd1lWS1J3RUk4VGdJbGFVYXN5akhIbVZNSzFqbVFm?=
 =?utf-8?B?YzY5RFlRaThvT0ZIQnlXZkdiNFNUeTZDRENxbzhTTnlPNjBoSjBEZWJITU9N?=
 =?utf-8?B?THlMUWF1WERDcWV0Uk42M05ycnlBTkJFc0FKcTJwMkFMSXBaWnNweng0UnF2?=
 =?utf-8?B?VnQvRkh0bzM2RVJzQmpOU0pyWGhHRUZzRmdLaStLKzZSU0UyRlAzYytoQ1JR?=
 =?utf-8?B?OUZsWWdRTjZCc3hUY21SemVMM3hQLytkbnRGY1dwZExTeW5vbFhOQ0tZMTRv?=
 =?utf-8?B?U1U5RzdPYnUrRUxxemZHTi9KSkFYaEZQUU9NWkpmQlpBbktObnliUTJmYksy?=
 =?utf-8?B?K0R4S3llY1ovNGJqa0ZTWkI5d2ZJSnhwQWlrS3pxbERKeGxTSWJYSEdYTU9V?=
 =?utf-8?B?VDNjSGUzZGE2Sm40M2N6V2ZBeWNWSnErYVpyUzAvTjhHZGhIcnpydGp6SDdu?=
 =?utf-8?B?QjMxNUN0bFRMQno5b082TkFyTG8zVy9RS1U4b0c3R1FLaC9uTG9NT0FVVjd1?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3441c4a7-efa4-4d79-59c0-08dcc29ec739
X-MS-Exchange-CrossTenant-AuthSource: DU2PR01MB8293.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 11:37:18.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqQFFDAZbehjTeeHUfzBUbeGBJwgnyB++Pgbou2L4cIszU5hp2PKvBQH0yboIP7Si5M9XNZJ0YB5llyKceGY4JcrxNsslb73Lyh8MD8K9aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB8714
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 22 Aug 2024 11:37:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/547

--l7w2t7ohqd3zhsbc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [yocto-patches] [ptest-runner][PATCH] README: Update mailing
 list address for patches + add git command
MIME-Version: 1.0

Anibal Limon via lists.yoctoproject.org schrieb am Mi 21. Aug, 10:47 (GMT):
> On Wed, Aug 21, 2024 at 10:34=E2=80=AFAM J=C3=B6rg Sommer <joerg.sommer@n=
avimatix.de>
> wrote:
>=20
> > Richard Purdie schrieb am Mi 21. Aug, 16:44 (GMT):
> > > On Wed, 2024-08-21 at 13:35 +0200, J=C3=B6rg Sommer via
> > lists.yoctoproject.org wrote:
> > > > From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> > > >
> > > > Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> > > > ---
> > > >  README.md | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/README.md b/README.md
> > > > index e6f548e..8afb161 100644
> > > > --- a/README.md
> > > > +++ b/README.md
> > > > @@ -48,8 +48,12 @@ $ mtrace ./ptest-runner $MALLOC_TRACE
> > > >
> > > >  ## Contributions
> > > >
> > > > -For contribute please send a patch with subject prefix
> > "[ptest-runner]" to
> > > > -yocto@lists.yoctoproject.org.
> > > > +For contribute please send a patch with subject prefix
> > "[ptest-runner]" to
> > > > +yocto-patches@lists.yoctoproject.org.
> > > > +
> > > > +```
> > > > +git send-email --to=3Dyocto-patches@lists.yoctoproject.org --subje=
ct-prefix=3D'ptest-runner][PATCH'
> > ...
> > > > +```
> > >
> > > This looks good but we might also want to cc: Anibal on these so note
> > > that in there as well?
> >
> > Would be `--cc=3Danibal@limonsoftware.com` okay?
> >
>=20
> Yes I will add that to your patch, Thanks!,

Did you forget to amend the patch?

--l7w2t7ohqd3zhsbc
Content-Type: application/pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIITyAYJKoZIhvcNAQcCoIITuTCCE7UCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgghDNMIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkqhkiG9w0BAQwFADCB
iDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBD
aXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVz
dCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMx
MjM1OTU5WjCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQ
MA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqSvysQTqoa
vIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEibivHbSuejQkq6uIgy
miqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHKRhBhVFHdJDfqB6Mfi/Wlda43
zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFbme/SoY9WAa39uJORHtbC0x7C7aYivTox
uIkEQXaumf05Vcf4RgHs+Yd+mwSTManRy6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHn
Kav7Azf+bAhudg7PkFOTuRMCAwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh
2JvAnfKyA2bLMB0GA1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMC
AYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRy
dXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEF
BQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1
c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0
LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAQUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9
FzGR87bjgrShfsbMIYdhqpFuSUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TE
oGg65FWM89YN5yFTvSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav
2VuQVHwpTf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn2FlIl7tP
bDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZGXq6F2nnBtN4t5jO3
ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMGquITn/2fORdsNmaV3z/sPKuI
n8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmdWC+XszE19GUi8K8plBNKcIvyg2omAdeb
rMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVn
LernF6pthJrGkNDPeUI05svqw1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggWB
MIIEaaADAgECAhA5ckQ6+SK3UdfTbBDdMTWVMA0GCSqGSIb3DQEBDAUAMHsxCzAJBgNVBAYT
AkdCMRswGQYDVQQIDBJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAY
BgNVBAoMEUNvbW9kbyBDQSBMaW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2Vy
dmljZXMwHhcNMTkwMzEyMDAwMDAwWhcNMjgxMjMxMjM1OTU5WjCBiDELMAkGA1UEBhMCVVMx
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
DgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsG
AQUFBwMCMFAGA1UdIARJMEcwOgYMKwYBBAGyMQECAQoBMCowKAYIKwYBBQUHAgEWHGh0dHBz
Oi8vc2VjdGlnby5jb20vU01JTUVDUFMwCQYHZ4EMAQUBAjBaBgNVHR8EUzBRME+gTaBLhklo
dHRwOi8vY3JsLnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFu
ZFNlY3VyZUVtYWlsQ0EuY3JsMIGKBggrBgEFBQcBAQR+MHwwVQYIKwYBBQUHMAKGSWh0dHA6
Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2Vj
dXJlRW1haWxDQS5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNlY3RpZ28uY29tMCQG
A1UdEQQdMBuBGWpvZXJnLnNvbW1lckBuYXZpbWF0aXguZGUwDQYJKoZIhvcNAQELBQADggEB
AANadCCx1OE0/PYv8CMHn1qrbn3u9yIQuut1yAVv1daof2ULxyGOm/M+XnSW1h+xcUukaNTB
qwJx6KTauuWjVL1LRXz9+sNvQfS1KdJF9yfgcCTiIMNjfKap+t/dD275tpVeLbRSWyJaQRhb
GVjarr8yry1mnaaiJqv1TERaHqjDNpEwU/Ex8XetmkdJK01qCP+ZOEHwRr/pEB/oEKYB08+P
CfWWWT0YVlwW3FdYpMi70zyynhyE0ZkxBuwh20CulXlafk9nzu1ly9HDU2MG6fnKLirJLOj1
+9s6RvytgsBtk1dB4lJEMe32RnTa4ABWg2VpdqmG7wjr2BlUCzLzuxUxggK/MIICuwIBATCB
rDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPzh908c
7MYmJwWouN4Q9n4wDQYJYIZIAWUDBAIBBQCggeQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjQwODIyMTEzNzE2WjAvBgkqhkiG9w0BCQQxIgQgFm0hV8nw
l6/rNS9SE7BvLnO5KFi/pC901CCgdS9UDF0weQYJKoZIhvcNAQkPMWwwajALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgIC
AIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEB
BQAEggEAbaNuLRTWgk56AF24JG98v8yDo0O1aghnFRhkZx9yekUWpXo0EEqfinfldmjiGFux
NbCbSokzkGBDUcbQLfz9GOIfu9WqL/ofG8gGnQv2jjuyBW+49msxOEXtZFaC4CPAzC42W41H
AKzR3YY5gLnqZvrdfY0IjUCN2WTBTB4XCtQiqvd9FQZ3ZL1cgco4584bE0iZG6folJu4hIcM
xVaYqkqzwOSFTrINlMj636lPvRc8KW/FYB7U+YaHwmpNE0/sb2boNQ+5bQqxdt1XT3LETowR
q5swODskQkIlaFGocsVhzvulCjtl8E1FfTZ8TfKnxnAj8RCtMAZjVqMdLFWX2A==

--l7w2t7ohqd3zhsbc--

