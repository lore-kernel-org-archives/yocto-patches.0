Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA66C02194
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 15:19:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.49])
 by mx.groups.io with SMTP id smtpd.web11.14556.1738768788142084279
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Feb 2025 07:19:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=R8FQZ9z1;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.49, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/XF2BKOyIjg7gxXCyOTgztuYTAX/C7VZ0j6Ua+2+u86QI1ZNHR/gmjGWBkm9UV1FRoXFp22UMJDPlB132BkRMdXUnFGe4vhMPOEpxUf/+Gjgan0pJ9xAvOOekH2ihVAAp+4l35YhwyheLw/Hupfi9CuEOU+bAcKHkpTTwPU6TVBhUg5YMY0qTvgV5Ia8WLC1KAQAY7eEU//ahQuCkM98bq3xKyzwO7Qc1HqkWTSsmF3sBip8cqxW4IeeL4bkjANsiO/ioCGL9g88/0xTnGpJfjuKoJYu6/5hNTs3G6asUMTd+vZptlykOiIr+T4pSKBl0bawoib1AcsjQmi+TAsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRd/Low+cYkUE+o63vI2QE2fXmjBiEKwzRTXlX2G0Fs=;
 b=QrR9HdxdZWbGbG5ec95Y1JHCJM+nuJ2oFunphwDZyZKlqjBv+3gxMFSQmNRZ2VnPrTbc+U6EgbyDn9M3PqEsSUCEXAV/oBXTAujJiEqUrf61pba2GXb6GVdJ0d06Am/7yksGtTLKwyob/lxKJHBPUY5nYnsFmqRs6kPDNYPtD2JOsgvNo57qCZnN0E+JsuqO4HV8FFgxmMo/DTqfkbHtiijUs6ZJgR3DPC8meKuKi55FqY7zNWC1ecw8D1MgcT2xz/spxaPJpIURsD14TBc5XW4BtWo2D1pWADK9CdOP0K3RAJn0bqUz6hXYGHDSVIYxBfGu28YGB2N7UDqyuF2pgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRd/Low+cYkUE+o63vI2QE2fXmjBiEKwzRTXlX2G0Fs=;
 b=R8FQZ9z1nMQKjxvCTTmYPjeHfzG8T7dJDHj3jkBmSPjc2lAgjFm37UbrsoNNZ1o91jNvapYNdd3zGrFqHTltqXOf4888FeRuRPCzNRTPyooOZDXp2iZgjML0fYnN+3bbjmj6RrpD7oUqHpcOZbHyjvk0VJINb1Qo84JSlP2dak0t8hJRjjxmlVoYEsg/1fSdTPLyv7R6NAM8DIkKMdqn3iMz+/T6Mn5a0Udmo22jUHxEg8OCVOnprach2SZtz3gWwsuztYiyHgWLPFaToI9DgNSVCz41Qe0PDX3IH5DtXixGgolji2yhU2Ig9hl4Y7p83ILuLthmfe2cJLCnxTs8iA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.25; Wed, 5 Feb 2025 15:19:43 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%7]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 15:19:43 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-lts-mixins][scarthgap/rust] librsvg-native
 no longer building
Thread-Topic: [yocto-patches] [meta-lts-mixins][scarthgap/rust] librsvg-native
 no longer building
Thread-Index: Adt3MDLalTKk/EF8RTyQnnaEE3F7DAAsOucAAAAJLSA=
Date: Wed, 5 Feb 2025 15:19:43 +0000
Message-ID: 
 <DM8PR12MB5430582E9C4EC37963AD55528BF72@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB543001218B1E74EBFFE75B698BF42@DM8PR12MB5430.namprd12.prod.outlook.com>
 <12196.1738768670955878092@lists.yoctoproject.org>
In-Reply-To: <12196.1738768670955878092@lists.yoctoproject.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=b2f3b8ce-b19e-46af-ba8f-8df45b63c3e0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-02-05T15:18:51Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DM4PR12MB7765:EE_
x-ms-office365-filtering-correlation-id: 5ee11019-3627-46a8-6ac1-08dd45f88483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?e947a14JteJn1C4Em9RD6YZm+5ViQ9m946ftR9hmMNMcUx1ZdUcmBjz+Mzj/?=
 =?us-ascii?Q?ysWH2d25lQ+L7MHXJsZDVZjSuc7cr0KI5JhgF5Au6FBJIn/4immtekXP3a2A?=
 =?us-ascii?Q?x+PDh80lA95UMGyflApkIWUzqXCUBxCi4SuIuJ3uMnqgw/gtFrzI76B3Rvma?=
 =?us-ascii?Q?7gd1qy+kEgjdpP3eQ252CEnyXwdG51wN+zLdvS11ODH9jMA2r3/jBjg/PNI2?=
 =?us-ascii?Q?DLhIGulJPGyFR57FlpWMrhFMh6+1wSJJUFNsIs93a/fvfskpTIhLhpoo4zHA?=
 =?us-ascii?Q?7gbTEfHKnKIrBeT3wQjZh4aVoUb4L7cd4qOApCtpstsXBWJ9jmkJPlqlr068?=
 =?us-ascii?Q?LU9Ev8zcNQHuHFm4nWlbgJ89hBDCcqGbXPadd9StxQC4ogs3Y17Y3/HXoC39?=
 =?us-ascii?Q?gZG4j4zCVQRY7Iqrl3OxzUIOW+AEPdhrQTyOn7+rCdWEcYz3uRJJ8bVygrSC?=
 =?us-ascii?Q?h2ZkGptQ823zXVk9WvFT83iKMeFpNLo+5kPUvgPQXUVUbf8j9oChQIf8pAjs?=
 =?us-ascii?Q?VkCtSvz1G01VDJEvE/v0f/wHSi+aucWAZ1ZLONdP1VAzRxbtVezyON+QGI3v?=
 =?us-ascii?Q?U3RPeucD2xoqp/UeOyqGfTYOf+2Ylmq85zRRaMe0aPRbGgUlQwzIwNfDwnNR?=
 =?us-ascii?Q?UveqNxWDC19Zfex0mAE6rYpPKFwcMU9kPWrCHv4JlvXoOQA6s1caIeRuzlxM?=
 =?us-ascii?Q?Y0mVNIfh1ulmhuiaPyROROAv1vIiAR31rlueyRegKKNIW0fmgmdYgCjivZvV?=
 =?us-ascii?Q?a5xIa63uiVbUk6vFMyEM889PZHpK++PGoB3g4ILbXkxG1CI6BASsgV4YxWH2?=
 =?us-ascii?Q?ErkvuzUcOoRdYlu9/zJgjYIja3rPaX8Euo92/VhTemC4ILOaYF010mFqjGCv?=
 =?us-ascii?Q?V8J6F2zQiiT0ddHoL6ptTpjDM9UK/+qU+ihMp9AD2mb68RVWk2huW23SLYC0?=
 =?us-ascii?Q?pY2MDFn/Y811zjhYEnsMnuWaiOaVl9/Plx/thqQXUHdW9sX//KjZAF3tm6Uu?=
 =?us-ascii?Q?qCr/+Sx7TpkX9x4m4agMVrtCq51TTpa2giIWbMLOW2nsj3VTjsZS/TMovolx?=
 =?us-ascii?Q?x1O15sP8dHlCUXtUzWeqaP982Ig9T1eQNvsVusisD7KnTjh9aMQtP7n1YIdY?=
 =?us-ascii?Q?83mFll1C+5ezEn8LI2NpMR2dJmXYixWmY25DCXw4pdfoSgnT7tAXNHgCb9fM?=
 =?us-ascii?Q?rtOe1OPdzbqNMHhVF8zfZ6/aFMLMSxjbm9/QJyDbcY/dZwVVoN4xkaI1Vhhq?=
 =?us-ascii?Q?j6/Gb+80oEmYfSt6YYq62vzjLCQv2ISgVudFB40DGt6pW8BiwKpDmEZB9uO1?=
 =?us-ascii?Q?npV61XIP0nQAd5vn+6CO0RX8qQ27Nkn7LdjNRrQV8n4Z8OxJ6WDy1ObUTwgu?=
 =?us-ascii?Q?jh6/Z4RxoMdMSHSqVFyZFWcKnjHHsccmMMsGtNbOp9OtMlkXlg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?2NXC0r8Oj92sCug0DW7oFQ0YB8TmIw5sXoQM9JoS58EX0fFj0/I3TpRkNW68?=
 =?us-ascii?Q?3JK6outGvA6E58tbFdXE4WuAPILMphACFZjFlj20m3h21b+/lPA70Cr9UWTZ?=
 =?us-ascii?Q?HOpB+mi5kp7LkSm8alDdkQFgi749YsqyE5YDEbk6JDTSgC+Y6FJ5Sc4U6UwK?=
 =?us-ascii?Q?aklJSxpWYsABtAHO07AUT5RhnpOTd4GnMODBBqvjmFBD3+prsRDnqnVkavYL?=
 =?us-ascii?Q?qE2Bcn/vfozpnKZEF2ELMmsMEk3hoPOHx46v/d5vyVWYD3wlncN2X+Qu103+?=
 =?us-ascii?Q?aenk5J6J5z/L9M6iOVcPDUgi6pocAsEYABNlUyEkFX06H7FzC6YZcAaizOXd?=
 =?us-ascii?Q?fRFnsLZTxtCj2EipaPdhY558zPZzJyGPPcRjMoCMvMIw6iPAsC4MNji/CuGd?=
 =?us-ascii?Q?xauyGGy7CxHkDBGRDRCse+DaxW02QYmfK3OKsdE46yj/kpakoIGTjb9FWTPN?=
 =?us-ascii?Q?9AMaBBULdP57PQLBkQ6YleONdDah7dRypQZEsz2cS5wMD0bvkcEP6cZOc3lF?=
 =?us-ascii?Q?ceaJSTltvaazvkEPFCTOsCtnmSt1yxFqOQ0ywNchuYvYZ/ErcSUkRFwq/uOX?=
 =?us-ascii?Q?ADnyId74gA9cs6blPI/zQuzBmaH5tOLNy1tfjYjTf9FYc4gyxghEpY5D2rdK?=
 =?us-ascii?Q?UA72M+z0rWGWiQOBsv7J7nyxt7SbEZhqZoekZ0scPgs0D6BIKvlx/fMJ6SfO?=
 =?us-ascii?Q?9Omkm7vk6RC47/7rt3jt4W6GnEg9hQfXK3Dw7nJ1OX/Fj3iBquN13gz7+6iz?=
 =?us-ascii?Q?2YujHtCNK2vqOnsrxZhM2vQ3lmPUDnaCTTyyET4d3KZuNC1ri1kaZEi6M6eh?=
 =?us-ascii?Q?3OOJw1kb6altWQvAgQKN5gbqgLRCMMypmgrChW8WEFTeKGC9OvZkRF9v7nZH?=
 =?us-ascii?Q?E7sTZmtNo4wUo7d3OWLlZDUq+ws2nxZtXykzjW8iSsBsJkDxA9JYF4OOit46?=
 =?us-ascii?Q?WF+D//121mh+Bvkz5/8YkHhsdni9q2wkypC5xw1dtR2frdtlBpr7Nn3XTREj?=
 =?us-ascii?Q?DvUYqFNvNeze2Zd1t8w2C+MfpEALByXpBn6P8uxeUQLHblKwfHX7EppT0Edf?=
 =?us-ascii?Q?yLw3UWsI3UmaMqyUaPD36C/Bnexfyg6dx9MA4uT/HUaVbRifVprPhnvLsqcW?=
 =?us-ascii?Q?/P52MIAD/zq9+m5p5QtWvDi1/9tnj5ZijKL029HjSaGh4+kiXKfC71b3wny6?=
 =?us-ascii?Q?EsuZXIVFnyrPH0vPeV3YyIp4vkjuN0aZuKDz7nSrQTrG4tO7i7MdzQqSRXWM?=
 =?us-ascii?Q?irYrT4rsmJpOGUqKj9jklrqhqUeYAAE7meUgSbifRVZjcn/GuYLJLPMaXCG/?=
 =?us-ascii?Q?vYODE6KRquv6i+Kw7FgpQMcm7/kMMk+tBK8cMYYUHQ72i0xJ0l+iNMXfG9y3?=
 =?us-ascii?Q?rbuU5GWjZiJjUSCjlvGx8f+YrKJVvQBWhM5GP9vLsk6FQ9hJsNaiJXLghL4U?=
 =?us-ascii?Q?lNpqf5mGDi/QW0/vlaQzhYnBmhoK0WmaHDUN5DNyXvFjbLkoU8qE6bII40P0?=
 =?us-ascii?Q?5th0AcOZLtinK7HLWJAKnUGNQiUTXl1InIcFmGRLpgrvjDcvbjtOyphmlwEY?=
 =?us-ascii?Q?lrz4U9BEOrxjgzV7A2MocesjojNQ4xXuOsGGTDq+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee11019-3627-46a8-6ac1-08dd45f88483
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 15:19:43.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OaDImlYgKxvWdg6h0PuoETqmz5DfQCnTo2Cng6NMGx8m575H4z0WvHzsBXjqCvwL6125+ql+tkCYHCwMRUNQxJqUzcIsh7zO8FtpTTK9h7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Feb 2025 15:19:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1041


> External Sender - Use caution opening files, clicking links, or respondin=
g to
> requests.
>=20
> That did it, thanks!
>=20
> I will submit the backport to poky for scarthgap.
>=20
> Thanks,
> Chris

Sorry, I forgot to add the context in the web UI. The conversation is: http=
s://lists.yoctoproject.org/g/yocto-patches/topic/110997188?p=3DCreated,,,20=
,1,0,0

Thanks,
Chris

