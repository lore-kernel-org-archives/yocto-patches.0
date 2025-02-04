Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D55C02193
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 18:27:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.61])
 by mx.groups.io with SMTP id smtpd.web10.124083.1738693659253114980
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Feb 2025 10:27:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=JvkuzhNj;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.61, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsqqggwc+hEW2X8vrwHB6xDpmZrFXn/0VIDJHlzP0nTP1JAha+Jjz3eh4c7A3iZfiEIvx3S1R7d1rdhjZngBBvXYBn+HbBaztQt0AE+uYzS5wQXPXz78BWkuu47PgdreeSZt1W6Vr0wHHGAUo0RayMBkCGTX/cVQ4qHnxNw6Qs1CoZlgfTEFK06DhEwRm70uJKXbVBQBh94CU15cuShBfJ4N04PCveFeLHwHb0S091XGFuuB8kATw9w2e8U+riwh2LP/eYyzxuKPV4i0xmZaWX1D+x75J+/O8GAl0ncpGMpLKqLdSbkHfoTsb2Ski3vI/BX18zhgozhkbPZP3vfcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swfGye0FAeixZ2duC5S7AHV4zWQwzLeis2VcM4gGFTk=;
 b=T3xaXkW/d+KRCdfvQ5Q5qyF7kr+g0h1iqRFPJkdwQGPGZqjSFkJql1rreUqweibvsnjRsAgpXGfRTBm5z7kwqSkrlwoSleIYrb8Q1oufypNdyMnLzq0H/p91ENny58vp0rr6nnW5Wpm3T46Tuc8cpG2wA3usx6hb6AQG/yAS4tiiKQRIQplI2wg9FIPyNTv+h0pTqxn5TAUoeMRyRGyAIHK0UewUgH26dug31x1szat4SRB2YWsHpm8Op1sYf+xERGJZt1uFoCy401Gs3VpC23PM3H3MK8s7i4JNdRGE2S4ND09uHZz8D65dr2JyWgtYu2iMGf0CiJHu+XsmzMyPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swfGye0FAeixZ2duC5S7AHV4zWQwzLeis2VcM4gGFTk=;
 b=JvkuzhNjoLKyKMr03opgi2kOc5Xgsw8wmEF6//lt70zCq7yTL6QtX5iRJujL30AaIxv52CFpQckEpLz7NzXVlvdzfG0ZfUHvI5R7hA5AAwujDOX1eUmAbyyx7gH7lMm5sm5diVJBvkIwRg7Bsn9SZlekLBHuy8IUGRfK9Y8wsgLGNW6e+XgXk51kj6XL/VVsTIa1y030Uf4E+GrqlzD0w/J4AwqizYaY6ecJ26L/oZafXccwQuOLcnhmZuGoVaeKShFbG43kDWSmKHmnBDfYUSET9ApZFQWxYyUZz/VdT30evAE6M53hORgOJ5a7SLWIH5Ibh7Fir6UXpX4zqyGu8A==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Tue, 4 Feb
 2025 18:27:34 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%7]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 18:27:34 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: [meta-lts-mixins][scarthgap/rust] librsvg-native no longer building
Thread-Topic: [meta-lts-mixins][scarthgap/rust] librsvg-native no longer
 building
Thread-Index: Adt3MDLalTKk/EF8RTyQnnaEE3F7DA==
Date: Tue, 4 Feb 2025 18:27:34 +0000
Message-ID: 
 <DM8PR12MB543001218B1E74EBFFE75B698BF42@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=33624eff-9356-4680-b198-7e2b2cb042a5;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-02-04T18:11:16Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|PH7PR12MB7116:EE_
x-ms-office365-filtering-correlation-id: 414c707a-ea99-42a3-3fb9-08dd4549983d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?1yxxUnvuBtuKD38yuP7KgpuPHLSOh5BUNOVmOWcwPmbwtRURQBObiARDYQSE?=
 =?us-ascii?Q?nCaLWJ9aHsbcTCb0c8werXa/04HDMOb04j18m/C/IYsCquVFQ8SmW2z7XdhR?=
 =?us-ascii?Q?bE3SU+LF3AKb29KNwzww5v4ldeRzNQYZKh9ZL+dVd/TnHrAb8eiOAqDS7swB?=
 =?us-ascii?Q?ta3L1jJ22V8cbZj92asa5G5THCwvIilVM24BQp0qHzKt2W0b5JgmWiPsa5Nk?=
 =?us-ascii?Q?8UWKWP+hgBYNJ6PZLChxR6ch9m28+6XOuOoa71Hlw5Z7QgsSCiYxprjCLYPp?=
 =?us-ascii?Q?tvrHVhYZWRohFp1LCcI7UlNrx1TjccdVnd+s0uJQVSkVBIgtY5OHdMEvOuQ9?=
 =?us-ascii?Q?XqiJILV3/dt+XW67+pJJcL30afkZDxm7ekUNNvA6pWauMWsPA5Zyd04TFuyv?=
 =?us-ascii?Q?P47lJLSRws+g4l09C8a/SoXAwlOpD937Bnq9Ehj8hlMaTaPehjpDdAqsfIHw?=
 =?us-ascii?Q?OEjhkOFjGK3OZkbrEtN5+fyhChq+MZipTJl3EWGWIphe4ubU3st9U+s8W4xh?=
 =?us-ascii?Q?GyUmQItnuRcVChQAHnzv753eVzYvf5jcYM25fzXxGf53OAPT12ULWRyJQEEY?=
 =?us-ascii?Q?joKwEOdki3a4v2aLeBCIUVstoxpdisTinkrbkwER8Ii3xAk+/b121/pI7e6n?=
 =?us-ascii?Q?kTMsvu0K5K7W6svevXKM2dJXVvdPqNGrtXADZAz5ylcgmurUNHUalOXz6GmM?=
 =?us-ascii?Q?9yYfZ69RBqfLCL+33anAnWFvM1g7sd8IWtZYy7FOJR+/Wxnmtx7y7DUW8qYl?=
 =?us-ascii?Q?uZiOd+wpQ9rIxHCo7IwvWeu3hwG71+kDKx5KKJx4PbV5Z9erLczGUzS/ong1?=
 =?us-ascii?Q?uzR8Zag5NxECMtLE80x86bSKudNyIsjm90tdXaKkjjDgEnVEVYq3k+a6LhUn?=
 =?us-ascii?Q?wlrunzMiLar0vuoOoYyt4ps/TbJSpg2dej67+o7MB4ekzFfyTBlBslMCVEbG?=
 =?us-ascii?Q?2czlEX1Lin9t9ELQTtRxIXOZYN6GprezNyRqIrCFJ65Cr6SXAXZz+a7Kt1VZ?=
 =?us-ascii?Q?tRrzIGafiDASDdJHBzApbCkSg2HVI1u1Y8htjT/au01JExeWcjCqBAjpGb2l?=
 =?us-ascii?Q?/vnR9VrMbv4PfAw2e7hibLPhS9uZBeN8cfalrF3gRUwPP90GRwJGQylxIvBp?=
 =?us-ascii?Q?NmBOjO4SR+CAuthEg28kIKViOINkjEoK/2FiJ8mGbxIv8+Qa4K2gP+Z67s5u?=
 =?us-ascii?Q?yBBS5N2XlSUbiPXdoA5adf0KE5trvWSrR9t+uVT27n3AWjavCN0r65kUJxPp?=
 =?us-ascii?Q?JzBRUdU9SoLPYnktUFCOa7v1kpacOLF7XjcTCNhaSLAQsEqBvq6OpkoWZcIV?=
 =?us-ascii?Q?AnU2qHb40bK8qgzIpgwCJpE+KunMvMuTXLQwQax5Jo7a7b9WdI/aMr7ufOMk?=
 =?us-ascii?Q?wwFacTqwKmg0mrwPXc1P1iKQyfKB8PjMb9wtx4zR31rvD49t/3F6CBdkg0NB?=
 =?us-ascii?Q?3lxneM2sgOuIe2MQxyiDB6Gj14UeTyiD?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DFxXPqw/AOHiTCO3rlCZOxEOdh+qlO/tmHM8jjitWgRK9n3ivuqyE2EmfWpo?=
 =?us-ascii?Q?BkgYN0xa9EB2cicIptauCNO+8F/fF9E08OHmWvx4IvHb0iUOYN0MI9N4TU6I?=
 =?us-ascii?Q?ZqasCyiIg8aAG9rqv6YRD6P2ivuMW2nb+KgVIwpdsV/HEX7LvInTwDZAX1+V?=
 =?us-ascii?Q?T/x0MHeiJzYi42ZFLAvktgqF0Q+LblFEfAz75tTOoHDWuCsYx3BuJwltw/s+?=
 =?us-ascii?Q?S9Q2fbnEiD7OJ2sOed8W4kEp5AdOFmsKVIHZZS22XTEeVMGoUZqXECGN1kwE?=
 =?us-ascii?Q?vSwKZ5hw43pGblvrYR/iTZfUHEvccoKqP6VDKJR8fiZB2+CnmXqNvcgTHIXA?=
 =?us-ascii?Q?q0rxDyS+ftc8JXnajhf78ihoklsHMY7KHDk76pVC8rNricip69D92opAnKRK?=
 =?us-ascii?Q?CW+PbzCsXubeWeaPlPPF2PzzNEHP2bHDKPtlVBO1eoCrcyGtJIQtYIxlvWi0?=
 =?us-ascii?Q?AtPsnEqCUMn+ICVIBt771kZrxchptqhVfWTkv44O5yS7HaAzR96U59ai0AaP?=
 =?us-ascii?Q?18kHszFB9qb6JtOkaoZV9xIU5Q8pQOzzoiY3XxblWeLKuiu4DQ8WS05bNQrG?=
 =?us-ascii?Q?LetPVGTwBGaeb2frkC6LFkjBtd/bq8L922E4ALBDieC5QMf87RdF8ixB5oVb?=
 =?us-ascii?Q?vpk4FzGukocu1b7Vf147xw2i/mWoPmPkWK2zxS8+xzAB8sySb7oINhZQTJvz?=
 =?us-ascii?Q?XIPpEnLu9JGs2DdgdjBczkqc6Sm20Yrb0ywydDHVO1X6jmMkjn2DoEExDAFE?=
 =?us-ascii?Q?xbFhwtT7r742q9ae1zCDJrsgENyoNOs8h3c6mdoefSb2IMnii2kvsHHyihzN?=
 =?us-ascii?Q?O0axxmuL8gMqznJCkD3FoKTDtW6QDv6tRVVUmSrxVE5FGnwGcDVsczhK8qkf?=
 =?us-ascii?Q?4GqOpnw0OommD3pmplm1kVa2Gm+si8Hm0lL2YK7Y3gh4/l+pWHSlfR9Ts6VL?=
 =?us-ascii?Q?nIa7N91FEttQ3OXdhwBcf0FeiJ7X7zNZgSs0TFfuBy79WqWpUu2y97YZhyhq?=
 =?us-ascii?Q?qKLZCX6x5yn0Du4/+8DeFNPe6VVXl0LRokxIt6M3w9/idQw8enRX9N+tw89m?=
 =?us-ascii?Q?qmKqPMvXSMvp2SM427d4apbIpl39Yz1oM0thndYB8TDm8DNwdG2DGFfN+Dac?=
 =?us-ascii?Q?ZshDCTlFLYIm9CLimS4073B2SSTSpeUnZxQUZL8rattx/LICVBv3UCjVtxFZ?=
 =?us-ascii?Q?MgeFo7pjv9uFiQQkG5Y18lRPz5FYA0ypKq+nrZi1Cr3wZdZdCFNv63mI+XWd?=
 =?us-ascii?Q?wpRdOtla87LBzqcse9diP4iVAm+WcnGDsNn6jDQ5J2usTtcbojcm3M3PKM37?=
 =?us-ascii?Q?HB7YxhS+OSWiRY+mpHX+KOnQq96Uiyjl9GL488G+SEiGxgibrPKv89m1ikg9?=
 =?us-ascii?Q?Dr8I+D8Wl8J0eKhfGA2qyb5e7LeVHrdi8I4lBLEVErErMzSA5YjZGzzmH/cI?=
 =?us-ascii?Q?c2ByAQOYV7EwNdjz1R6VAi3kJ0lqZJ3YHVOrN7dM3f1Eyrk17y0IScFnMiYD?=
 =?us-ascii?Q?PnTBvfkUwzr6GF/ToDwCdDRf5KWscSS4CWrSOXSG8zvYSbMEHplfTF49gzTj?=
 =?us-ascii?Q?UnsNh3nlxHhH1fMqhEG0LDvDUMumleAxjyUxxvmz?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB543001218B1E74EBFFE75B698BF42DM8PR12MB5430namp_"
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414c707a-ea99-42a3-3fb9-08dd4549983d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 18:27:34.5168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hvcCHwzIx44rdmFdNLXK7U9b6lJ7H0EvsDnVQYly/950y8Zs18AR5EmJuV6K+TcI60+juLAXXWqzKe3IWIt+FwFIVUICgOrDSvT/49M/Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Feb 2025 18:27:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1030

--_000_DM8PR12MB543001218B1E74EBFFE75B698BF42DM8PR12MB5430namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Unfortunately it seems that librsvg-native doesn't build anymore since the =
upgrade + move to meson (834e12521bd93e14ba305462c39ba5ebd96710f5). The 'pk=
g-config-native' wrapper makes it impossible to pass through the EXTRA_NATI=
VE_PKGCONFIG_PATH variable, so the '.pc' is not found.

|   The system library `librsvg-2.0-uninstalled` required by crate `pixbufl=
oader-svg` was not found.
|   The file `librsvg-2.0-uninstalled.pc` needs to be installed and the PKG=
_CONFIG_PATH environment variable must contain its parent directory.
|   PKG_CONFIG_PATH contains the following:
|       - /home/laplante/main_yocto/build/tmp/work/x86_64-linux/librsvg-nat=
ive/2.59.2/build/meson-uninstalled
|       - /home/laplante/main_yocto/build/tmp/work/x86_64-linux/librsvg-nat=
ive/2.59.2/recipe-sysroot-native/usr/lib/pkgconfig
|       - /home/laplante/main_yocto/build/tmp/work/x86_64-linux/librsvg-nat=
ive/2.59.2/recipe-sysroot-native/usr/share/pkgconfig/home/laplante/main_yoc=
to/build/tmp/work/x86_64-linux/librsvg-native/2.59.2/build/meson-uninstalle=
d


[One ultimately irrelevant issue I also noticed is that EXTRA_NATIVE_PKGCON=
FIG_PATH is being used with the colon as a suffix, but it should be as a pr=
efix since it is 'post-dotted' onto PKG_CONFIG_PATH. That doesn't fix anyth=
ing though - 'build/meson-installed' is already injected by meson/cargo_wra=
pper.py.]

I'm happy to help implementing and testing a patch to fix this, but I'm not=
 really sure what the right approach is here.

Thanks,
Chris







--_000_DM8PR12MB543001218B1E74EBFFE75B698BF42DM8PR12MB5430namp_
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
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
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
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Unfortunately it seems that librsvg-native doesn&#82=
17;t build anymore since the upgrade + move to meson (834e12521bd93e14ba305=
462c39ba5ebd96710f5). The &#8216;pkg-config-native&#8217; wrapper makes it =
impossible to pass through the EXTRA_NATIVE_PKGCONFIG_PATH
 variable, so the &#8216;.pc&#8217; is not found.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">|&nbsp;&nbsp; The system library `librsvg-2.0-uninst=
alled` required by crate `pixbufloader-svg` was not found.<o:p></o:p></p>
<p class=3D"MsoNormal">|&nbsp;&nbsp; The file `librsvg-2.0-uninstalled.pc` =
needs to be installed and the PKG_CONFIG_PATH environment variable must con=
tain its parent directory.<o:p></o:p></p>
<p class=3D"MsoNormal">|&nbsp;&nbsp; PKG_CONFIG_PATH contains the following=
:<o:p></o:p></p>
<p class=3D"MsoNormal">|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - /home/laplan=
te/main_yocto/build/tmp/work/x86_64-linux/librsvg-native/2.59.2/build/meson=
-uninstalled<o:p></o:p></p>
<p class=3D"MsoNormal">|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - /home/laplan=
te/main_yocto/build/tmp/work/x86_64-linux/librsvg-native/2.59.2/recipe-sysr=
oot-native/usr/lib/pkgconfig<o:p></o:p></p>
<p class=3D"MsoNormal">|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - /home/laplan=
te/main_yocto/build/tmp/work/x86_64-linux/librsvg-native/2.59.2/recipe-sysr=
oot-native/usr/share/pkgconfig/home/laplante/main_yocto/build/tmp/work/x86_=
64-linux/librsvg-native/2.59.2/build/meson-uninstalled<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[One ultimately irrelevant issue I also noticed is t=
hat EXTRA_NATIVE_PKGCONFIG_PATH is being used with the colon as a suffix, b=
ut it should be as a prefix since it is &#8216;post-dotted&#8217; onto PKG_=
CONFIG_PATH. That doesn&#8217;t fix anything though
 &#8211; &#8216;build/meson-installed&#8217; is already injected by meson/c=
argo_wrapper.py.]<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m happy to help implementing and testing a p=
atch to fix this, but I&#8217;m not really sure what the right approach is =
here.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chris<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM8PR12MB543001218B1E74EBFFE75B698BF42DM8PR12MB5430namp_--

