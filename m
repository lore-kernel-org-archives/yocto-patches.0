Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E75CC52D6F
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 16:34:28 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.137])
 by mx.groups.io with SMTP id smtpd.web11.192.1724258062845252375
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Aug 2024 09:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@navimatix.de header.s=selector1 header.b=aIkD+ojw;
 spf=pass (domain: navimatix.de, ip: 40.107.21.137, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4WMJzmbDQQxFfUMKE/iWYm/+O30W4Pd09+ANVg5fYlpRlOWN0H/8FYZNlpf/SxUFP1zCEhR8bzatU4ukUYrxGBnfq14g6h+Tb1hTVJflaZs+AsyQcO+t0UhR9Nz4JR4O/8Uw4RE6e+uqoguzqCYowkYigMRSXmMkpkcKCxEAMsk2I3mEshsCIPbJ4AwL5fScUAsIWAQV5azFQutoJRzhZgI5wVUlU+I5msC79CSoWUewjresrF+wQA8HPcT9oqduHivFvhElcIy+AnrojUr68mOtgNMU82FQDqgHzouf4ACGCgNOqn6E3ST3sBvKA/HN0+SV8xHYFNv42+TZpHtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsJ669ePmHX80UYF1tPogj4RNT5SNiD24N+dFUw4H0Q=;
 b=mzqyFoBw6cMIIzHpftnTIzqNFSXk5uQAJajdvfNsuEkuWnv9HbjmzUvv0gBBHbDKFbOgjPodLTrnQwRqUn070Zs6cDkByd53nUajp5vv4oqPy24vGeoq+QrDnRyGMMxqcJsJDAr9W411ZbNkLJFTw3joYEdpcsN5u3knAwbqoNd5j0yMh9Bnm3xYVnzxsdFzBXTSWF5b+FBgXbq864sUILrADsLxvOMX6fm5NKHSCgAZtZui5obpQ0k6iJbBIx5S4AyxBc/eob0ktmn6LcF5hfLZm2Gfsd1LL+sWS0itF8Gvg1auIlHD+Iw3dmbM9cAbCiZ883k8VEPCZ5XqoNHUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsJ669ePmHX80UYF1tPogj4RNT5SNiD24N+dFUw4H0Q=;
 b=aIkD+ojwu6UBju1GsQRGbbevAGQL4llTnBef/ivXbBb3VH2EyTA15r/WLZ00KRysuZWDV77nmIBbIGmCmQ5057/3e/LqlpfwEGaUaWbM0hNGrQvHxD3I/XuqNjrhPQdBYu8gaPg8kw9NVQaZJggAV1VNgNQch1h50P5jqEWumRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2d4::5) by PAXPR01MB9505.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:2c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 16:34:18 +0000
Received: from DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 ([fe80::d520:1b9e:a30e:69a7]) by DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 ([fe80::d520:1b9e:a30e:69a7%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 16:34:18 +0000
Date: Wed, 21 Aug 2024 18:34:14 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Anibal Limon <anibal@limonsoftware.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [ptest-runner][PATCH] README: Update mailing
 list address for patches + add git command
Message-ID: <h4mbf77iqrtjho2p55b2beriufcf3b5i773onru6wignzjnxlu@v7ncwogo3k6y>
References: <23f3f3e4c8010e7f1b2322976ded709912863ca9.1724240133.git.joerg.sommer@navimatix.de>
 <cf10983b4b7efdd6125d2dc519d52fab9f4ec3ce.camel@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha-256; boundary="aoe4r37hzr6ghzch"
Content-Disposition: inline
In-Reply-To: <cf10983b4b7efdd6125d2dc519d52fab9f4ec3ce.camel@linuxfoundation.org>
X-ClientProxiedBy: VI1P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::26) To DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2d4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR01MB8293:EE_|PAXPR01MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff5e675-99e1-4569-70c3-08dcc1ff1a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?iso-8859-1?Q?VGWohYVsM8zj+NRG7NU0l2Nn9+S1OHH6gLKzLOSB+GVBX5CJoQKc9PnOPR?=
 =?iso-8859-1?Q?QKEcfKGznWGqFsUPfr03ULOa5GTFbc85LGas69REE6y8VG53bDLfQpjyfr?=
 =?iso-8859-1?Q?vB2rhtmEOXIMOsiyOZew78eOYH7G67gXsIsqn5lVLamzkuUz5Hr0z1t23h?=
 =?iso-8859-1?Q?hlu0tnPXXE1tBenLS7dvxCmtzV4dG3NpXzABCL5pOa0pg2/9jX9QM0n4FB?=
 =?iso-8859-1?Q?o9nAIKz3B2SAB1F2La/VoUQ9I8WjR6GJPDgeR2o7zUalKsmJ+SZH82QBZz?=
 =?iso-8859-1?Q?laaOms/zc8jpZAponyWpnCQWMv0MPPO6LTl/DfoMVEhb1lXJHZ+2V8aQNn?=
 =?iso-8859-1?Q?FB8h/t/a+vv+kzf9Sbq/avs/fAnLLEuNyedrJaJbXoSbWGwAZ888RjhWOS?=
 =?iso-8859-1?Q?JHJYrCTjqoRrM+yMqKu+RMta+aWM9YwanMIhELAz9ZmyMwdgF0UnQNVqNz?=
 =?iso-8859-1?Q?cs9mqiMyd4JI8O6qH8e2JulbDYn0QYRnqiaufPjM9uaptVVNClSY7+6iPZ?=
 =?iso-8859-1?Q?7eRMvk8WQ3PO/g1F4uw3IGlNrY9r3h4zQMEnF8kJrg2GbaqAAs3tWZ/6M4?=
 =?iso-8859-1?Q?GzPb58OHOCCh7J4DJWg54AfbuMierrkMAZrG80l9NArPUFxTLD7tjdkHTR?=
 =?iso-8859-1?Q?9ZpX8lmCvX6HvSdN5X5p6uOhjqobH3puBVrPoZOTtPeTa+BIr4CYvSuSlK?=
 =?iso-8859-1?Q?rB6ErgironfOsPnee7gZgxTxxP7ITws5tPhhxXKPmZTzee910MCCDaMxtc?=
 =?iso-8859-1?Q?B0oWYNKCeGX9DsQNckP5QxokbuocsFCM0oWA36Z5eqpH+yiiOIN4RRwVCr?=
 =?iso-8859-1?Q?4HEdp2dsYMetmRNTkr2F4fuvAQb09v21ycHIeSbZaMRDPVzu6eY5bxoxzH?=
 =?iso-8859-1?Q?x2YLjo80mwhTs7wSS49GSQCEPeZ6ZpknTJYddO4R1tcfJILBhSWkkh0s9Y?=
 =?iso-8859-1?Q?2KVdJ8cldI4EAqY0VUczwhKrmw36ZeEO+rFI3Yy7udh1qlmYHBi09akIfY?=
 =?iso-8859-1?Q?FAldvKAWWIW/ut1osq4VtRO2szcfMIiqPSUAqdrq9Ojq6Z//td45VE6IsW?=
 =?iso-8859-1?Q?QXqyX7f6hwFLHrTPWtEccMSL597Q+GycHJoWRDmIFSzUQA6rlXqG3wc+hn?=
 =?iso-8859-1?Q?8iv3sKULNBUN1D63BHw20s2pjtCsCB9ZfRybHClUnTHKPKS3uRun4Ekr9Y?=
 =?iso-8859-1?Q?FJA/cx46ob7fP5LgoDikqX4C0emnfMFW811nSA/SHvONY33aETlMAuKLoY?=
 =?iso-8859-1?Q?m0DBxkwrLz79C3ngxdk953DlIr37ffd/jtrdTh3lJ95AcT5ai/7XR0TTSW?=
 =?iso-8859-1?Q?72Zma58MAsDoN/5zPDcdbWIrnxMV9fwaNOAhM8H24XFovCTy5f/LgktQ3p?=
 =?iso-8859-1?Q?fN4eayhb7QgmTtEYT2rna/6lKIMIFXiA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR01MB8293.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?4KNUNb13Uy/IWRwMd/y2u5qt5bPthTyiAkcqk8xqGQ5F6SvXq6QAL40eWp?=
 =?iso-8859-1?Q?+WgnXHVDLhj5uKsl/zFHX2eBxEcqvfVVDZS6NpMDJPw27E1xHus+AsHkIv?=
 =?iso-8859-1?Q?a6oldFxQ7LSc+j2ACFjow/ZPjI349H90KOVkml7oZJdFYuqyqBkWq7+6VM?=
 =?iso-8859-1?Q?QqaRjuFlZ+uXnVcUQIWpwsYOusa/5LNK6VV/ADJS3kFxkiaY12EASoXnbV?=
 =?iso-8859-1?Q?kh+ywriT0FifZr8+y7Hg43FZO/oUwNZUYpXv9SiP2jZLjGcY1MC23msvcR?=
 =?iso-8859-1?Q?xq7m97/vE9OYn+McrR4ma4rkTLDWMwbsL4v4Z40TecVDYcW8xnn3SwLQz4?=
 =?iso-8859-1?Q?Rww8LvLTO8LtiFF0681PdvPM2fXTE/WdvItpQu/hH5XM+V45LigjhlJTPX?=
 =?iso-8859-1?Q?Vxs6O4evALwBqMQQFSxZQdPktpIY8RRN8qvoyEpqhQeVGk4ASYMB2c8Lij?=
 =?iso-8859-1?Q?LM/uUCqHV3V50bGc7lrwAjhHbO8Vb9yvQh1kShkrDbyP6bHeC/FbZgNV1n?=
 =?iso-8859-1?Q?Om9j9+b/Oy9gI3EqpW4Nk6EBzIH0o8BcrEEyE7mE4RSbsJADEnE3oqnS+Y?=
 =?iso-8859-1?Q?+LUHV1P7LAiqmPfB4IFFyq1sGI+ldacz4mzSg6jzPCfaZ/Nfoqd2qD7DaD?=
 =?iso-8859-1?Q?Br1st2sblXNDBqx4U/pXFxfCAJZqQexeFcSplpeOC2Wmem0Q+WhxGPhC+e?=
 =?iso-8859-1?Q?PyG1cEjSEzjgzgdhcD/+/WG+BfErFKUMpdVKIFZ71FDIhB4tJHXeKldR72?=
 =?iso-8859-1?Q?BpfcIXvdM8F9QzoEaeFZLWpQaJN1p7hRbtxBEpIR2VV36VB2+8bMxkKQZj?=
 =?iso-8859-1?Q?kWgRjduBKtvgO5miOQYKa4AghlWmgYV4tmlVKocQAyp7BD4SAJu7274N3W?=
 =?iso-8859-1?Q?RhKZWo+KwgdjpubTnwRfnd4XM2MynmJpvQQ5pC+5G5BehZkm+/xpdkqNyl?=
 =?iso-8859-1?Q?wBAKlRW+2rtpRNYGyVgt2Jclo9uFdyV8T9r1xyLkRJWVg5ZV0o+U1vCq51?=
 =?iso-8859-1?Q?l9Yz5g1xi9Y222Mi/snPRkW41fIIqaXIpqX8w7dhPAQwbUF3uEBLUHU9tb?=
 =?iso-8859-1?Q?XWp0jMJMa2nTI06b+HVFAp7jRXvsQk8svk1EDgoXq+wJrlD6Vt6M6brmB+?=
 =?iso-8859-1?Q?N/DnIRt/B4ziFyGMnzNjmI+VKW9cAsPeoVa3EFoptJZMy2nPYpdwjQgbH8?=
 =?iso-8859-1?Q?W0geviWEzdXgqOZRdK+Lt/xHU2Zmz8tQqbKJPX9XqqEtK979qg8J4KaoFf?=
 =?iso-8859-1?Q?0s8ePbHZlxIKHXVGen4E2Rl4XkEHoKtZ76cFkC+k4/GeLgWFRVlbjW4CSP?=
 =?iso-8859-1?Q?exjq1UMKP3cqqHezQFkC2oqsUiLYKcAoxchy8XykIuzIDHWKy3UTW7y4Y9?=
 =?iso-8859-1?Q?7PefaQyrk3LOGj1OvwpGiKKOg5K6isCucBGmGkWtOQEvBtKMod735V5nqw?=
 =?iso-8859-1?Q?qjhB7QqX1RGpT+yn5Tjq4OpL5mvF4WgbIufk/aVAgrBKpOf9uauOucHuEp?=
 =?iso-8859-1?Q?6C5LFX7sSWUyIdeccGZ5FCou+guJsmaEuGhvFoCOK6h7IbUxAwSKKxg4bj?=
 =?iso-8859-1?Q?UBMU3cvjEGWxJoFEWq/4nMo0NcHdnlwTr/BTvjvToj1o1Rlm/xbEg5YviN?=
 =?iso-8859-1?Q?B0KtBO0HRCt6PU+jnp67w+9VJcA94620pA6IJQ2RDjiEHiFylurz8KnA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff5e675-99e1-4569-70c3-08dcc1ff1a51
X-MS-Exchange-CrossTenant-AuthSource: DU2PR01MB8293.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 16:34:18.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAquXFwIY79E0a8akp/1vd8ibaD3jBV3pTyDZ3mkxYL9LW7DQKz2QrR9Y9iG6PGgeacbez5Pn/kws2lXFXbQ3UMSbtY3MSzr6RGn6tvvoz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR01MB9505
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 16:34:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/544

--aoe4r37hzr6ghzch
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [yocto-patches] [ptest-runner][PATCH] README: Update mailing
 list address for patches + add git command
MIME-Version: 1.0

Richard Purdie schrieb am Mi 21. Aug, 16:44 (GMT):
> On Wed, 2024-08-21 at 13:35 +0200, J=F6rg Sommer via lists.yoctoproject.o=
rg wrote:
> > From: J=F6rg Sommer <joerg.sommer@navimatix.de>
> >=20
> > Signed-off-by: J=F6rg Sommer <joerg.sommer@navimatix.de>
> > ---
> > =A0README.md | 8 ++++++--
> > =A01 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/README.md b/README.md
> > index e6f548e..8afb161 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -48,8 +48,12 @@ $ mtrace ./ptest-runner $MALLOC_TRACE
> > =A0
> > =A0## Contributions
> > =A0
> > -For contribute please send a patch with subject prefix "[ptest-runner]=
" to=20
> > -yocto@lists.yoctoproject.org.
> > +For contribute please send a patch with subject prefix "[ptest-runner]=
" to
> > +yocto-patches@lists.yoctoproject.org.
> > +
> > +```
> > +git send-email --to=3Dyocto-patches@lists.yoctoproject.org=A0--subject=
-prefix=3D'ptest-runner][PATCH' ...
> > +```
>=20
> This looks good but we might also want to cc: Anibal on these so note
> that in there as well?

Would be `--cc=3Danibal@limonsoftware.com` okay?

--aoe4r37hzr6ghzch
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
ATAcBgkqhkiG9w0BCQUxDxcNMjQwODIxMTYzNDE0WjAvBgkqhkiG9w0BCQQxIgQgcG/zczoD
yWcRNMuGwyke9Q0HPFjaEY/H69ElcHXlz6cweQYJKoZIhvcNAQkPMWwwajALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgIC
AIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEB
BQAEggEANrUnPZxj1Dl6VWzWVirxnW4yeiZR0KPUZMEHcNbrQQaOMm89lQM0Xb/eWsui6MXC
mmZ7UJjgOzNaotGlynuwLeVhXKHhZVWj8/jrohD4zYp/dGhYhSxhwo0wB67MdGZIYCrYwRQY
CbCW0ZWKNve5vyAhNKfq6utjOnaNK7Y5B2n9S7Fh7BQYjBuF9FVrndFL/JOquxVklYFRNQUe
0tkjIlSlF8CxEoaTx4WaMSpk3q/Rjomh3QOj2qi549ne/doXH3DVnZQdrwsLYAJJi5rNsid/
pYp1bXUPr0lmP8oxA6n1gfFT+ixTsp3CLnLzgcQWjBd6saD+F2VOZlxy6JyU6Q==

--aoe4r37hzr6ghzch--

