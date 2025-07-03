Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9878C77B7C
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 18:06:37 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.119])
 by mx.groups.io with SMTP id smtpd.web11.29418.1751565987366414312
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Jul 2025 11:06:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@navimatix.de header.s=selector1 header.b=q/lYcNJK;
 spf=pass (domain: navimatix.de, ip: 52.101.69.119, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUSA+M6Ajnzv3M5wzVpkY+x1FbkBqCJYBLBgwXENgCksZjXwh7laCJfDqAK6+bNC7PdkicbpDfN8oFQboY1tCC3Bsr5GA2aPe2DfWGELkkzSOQ1COeGOk4A/1bene2Luel0d2EdsJzQRhyOtvlJxQgsAcQLsca7/mUVknwNYuGaVuoUOLarMQGOtRZ4H3NQqvoOFAn5Xxl1031fWzJn/M6SIhwxXd9r2B5XZbyDIaXnsqVda49yUYK4+JiF4G40KkjmWK7hkz+bayw1MLHNB6h1mZDmifVY/26v76blzq+5jnZrEMZ2yPXVDs3ylfHizw14ZWuDVNf7+NR9oxMpSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIsXecoDWNIrLC8y0vLWTQxtyCI9pIOhT3bkZKQnh+0=;
 b=UpYTLV6Z2Q18WcIgUuZmM9vKoDRB4gHmUNOkx6wUpWOwDdoIgAxX9QcYl/04G+zU9jog1NzWj7zrLuyeU0ulRaddf/hnn8epR6Cu38/KzjqQ1+snCZc4l2OH3Am3XVlYc//FG334FMMiOMad/75JLT3bX4RQE78MhzVTCPsZMq4oFWkGCeEJYQoiLnRhQoxltGo53H80u9ZVWR79EWr43HbjIi9bYd3axfbBqI5ITHUgPRAy3sYlMNC73UUBeXf+Tiw3+OX4ffr/CgrNj0mSZEY8JomuHt6x6LlKxaQRviPuL8vatYcFbcd69ql4+Znf0USkirAsmgAbONxuqdaOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIsXecoDWNIrLC8y0vLWTQxtyCI9pIOhT3bkZKQnh+0=;
 b=q/lYcNJKUXfF4fFWQa7LC4wIkFM35IXO3nTw0tLg++nrJefwhLQdXMWf1Q5NqeXiL+gikZi1HTIltkAvAOmiLok2idjK203FLulm573FIBULhzjgvoGFPxomyHEjAEV5sGDZycYIRU23nuN9TJqqDKIc9U6cllpfCHHFRHKMykE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:cb::18) by GVX0PFEC7F10FC1.eurprd01.prod.exchangelabs.com
 (2603:10a6:158:401::86d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.14; Thu, 3 Jul
 2025 18:06:20 +0000
Received: from PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 ([fe80::412e:7f2b:cbfe:3d07]) by PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 ([fe80::412e:7f2b:cbfe:3d07%5]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 18:06:20 +0000
Date: Thu, 3 Jul 2025 20:06:18 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: Anibal Limon <anibal@limonsoftware.com>
Cc: yocto-patches@lists.yoctoproject.org, nata.dobrick@gmail.com
Subject: Re: [ptest-runner][PATCH] main.print_usage: Remove unused argument
 list of -l
Message-ID: <vqjtvgauj7og2w372gcvv6km4fi524m34yjnmcv3aw7a4v5i7r@lmqw4atqmrty>
References: <036b0e6d97c28f21acc8a3fa855240b24e2d850c.1751552135.git.joerg.sommer@navimatix.de>
 <CAOU5ZMuv9eUJ+cB8ewmtfecLc7Y3Ri-CCS7RigEy=Nwx_JeSeQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=sha256;
	protocol="application/pkcs7-signature"; boundary="2rqtogaeaxxyr4qo"
Content-Disposition: inline
In-Reply-To: <CAOU5ZMuv9eUJ+cB8ewmtfecLc7Y3Ri-CCS7RigEy=Nwx_JeSeQ@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0314.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::10) To PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:cb::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR01MB7726:EE_|GVX0PFEC7F10FC1:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ee366f-99ad-4ff9-c8e4-08ddba5c5038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?iso-8859-1?Q?GPSXZllj3O13OALH3V138gmHKyaR6nxjUKScbKV+laudSmzFuUcb8rTyr1?=
 =?iso-8859-1?Q?i77yq9mymNtOeRRVsgk+5KTvXwXig2OtpbnGBeGA6xgvKK4o4ch8gUvJts?=
 =?iso-8859-1?Q?ML4v6IBzEjbPqsYXVofkY+pzUYo/8bUirGx0mnyJXvBxiezvbriZiEAn48?=
 =?iso-8859-1?Q?Fyz8wl9giyQrq9hr6hcYKkqcWpm939XtmvvdsiM4LcViSF3swxP9BhKRVl?=
 =?iso-8859-1?Q?YZ6FHwIPKIqyawvf4ye45vthkNtGUxA8OJRrOu0DyIIxMtnf8jP7LuHBIM?=
 =?iso-8859-1?Q?CK2tJX9QmhQPgNvmI0FbxNaf0t/iPyyoEY5kecRFslb3cRKtTsVi+Z3b37?=
 =?iso-8859-1?Q?0B9R9EjA48Ke0fpNfhLoJTHIFIOtwZqNOXODwefDMtJmG9p4aALK+QtIJ7?=
 =?iso-8859-1?Q?dRp8i52yGtDKI3Vkf2qu6DH352fS301V4nCMb7qUUNtXGf2PkKBjptNze6?=
 =?iso-8859-1?Q?ArPgA25QmAydQ6FWhmn0SYuhVDtGG88bqQEHTxGKinYe5POS2um6Ivozzg?=
 =?iso-8859-1?Q?f9rOVpP1FvFASrdNt8ID+kwC4SXXcMlhxRoytrlUrFrLUbQ1oujirozqI2?=
 =?iso-8859-1?Q?3tEg9057wOH93OvoYLWDHJmasBXvZzKxbV06PXaVVtK+GPAOxC7KHQ1UyA?=
 =?iso-8859-1?Q?qvU935swI50GClNvQMi8TA0ZciCZZcZhcLQv92X6hkbE//d4uC0TNz+nV5?=
 =?iso-8859-1?Q?plHT1MO8JmNipKOmwXr1RJjZwDSvhVftKP3+XvIXQ2vTnOVrKsQ5J+eEuH?=
 =?iso-8859-1?Q?HX4roPC4uWai3bdixw6dTnqM+joAhMS0DGpe+6ue/Ri0sycBitpCra+nCr?=
 =?iso-8859-1?Q?xMsyRVkS+ra9FpYqFGfWleQodb9XNcyFNLuE1i/2SV2dJritXcNSu4dE0d?=
 =?iso-8859-1?Q?hrkFH/827gjR348Tjg6oPagO1nk6X6kL/z2RnCPShRGtTxIaR6k5n7s6LS?=
 =?iso-8859-1?Q?7rW+Uafq+E7hev8YRdY6j5LhetpswiIwwBTrH0y0+ix1JjwKsxXN7GtGWq?=
 =?iso-8859-1?Q?Q02f5uG2RkKWLWi2DP3VSGa6bJOJ0HI2v057Tf2HFZCFO3BU+mjXtu5eUQ?=
 =?iso-8859-1?Q?51K6x9C3Zy8yixczWN98+t6WD+8btox6Hm2EpiZk8g5mNhFATmikAsYbw1?=
 =?iso-8859-1?Q?SiPwlhO2OM3HwA6tsnQYB0TAAIbmxw7swaiWxfoyur/5MNZ3CcdXWF6qvq?=
 =?iso-8859-1?Q?5AhfNIb0o6Xsqd/SpuevVfrkdNALNbXeExSe7FnSQXGRWpGdxtsSt3wP6/?=
 =?iso-8859-1?Q?kLRWBfyPFILX5vi5RAjW5s9hTfayjS+T0vBbbdq+hD87dBG4kVyrmTOEG+?=
 =?iso-8859-1?Q?2tm0tWRId5a+To4tHf4F0HY3RJ+GE3u5xjIL2ks97XCLVeCBmlp2RRU1qg?=
 =?iso-8859-1?Q?mmK6ZWGr5m+urbT+VIBRlHiT5YwFp8ws1uYt20eAAAYvm6VZXAxEQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR01MB7726.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?OO2x7q4p17JnSUI56+WxQgqhWNzcYcV3EQxinEuPGscuWTBAl8PNbcMzkt?=
 =?iso-8859-1?Q?Ikb0arT2gwdsEEd7n3LEi2/QuAacQa+4hkeL5ulGYabEqhPSqr436YKSMk?=
 =?iso-8859-1?Q?UbH6YGo5RImIyrfZAQtnwIyFMTXPIn9Ix6B/XRxl50vuHERKPvGwqczKYM?=
 =?iso-8859-1?Q?AgJjbai77ijdMLJaMfhVKC3XrVQj/aK7YT+HNAmtseFZa8tRt+aW6k60GK?=
 =?iso-8859-1?Q?kvkLTb/XnbjAPGc8BtNHbxE3ML3qeiynScASX5dFM96s5erTUTM42yqusd?=
 =?iso-8859-1?Q?ENzKHPKMS2pSmRtFa5aOqcyLVSkC7i0WdHS0vSRyFPp5ZTDdifo/UMeznV?=
 =?iso-8859-1?Q?dHUANZDEuRtPuRVsGJQ/exRTW85mYsiib7lms99nOnp2QXNnPijuKj/DVo?=
 =?iso-8859-1?Q?3T6qnNSENV0h8aS4dhSnsuuCU8o3ysI1Dk9f9GTHwZgK+HCOQlRaXlE9x7?=
 =?iso-8859-1?Q?4bavLY9jCj+WWWHZC5H1INgIP4xoqN7i2vYW29L4VNpkr4vdKauKsTUOuI?=
 =?iso-8859-1?Q?ECNtv/FdMoQSpFpH6N6MieKgPQndq5Mc+P7Oqj5xhrghiWk/KUCf4YxcJJ?=
 =?iso-8859-1?Q?6Ymm1UTnSzVY/a6BB7dMaQ60OR45Ul97Zf/kwdU6CWdTFoiy9jSIj45IBg?=
 =?iso-8859-1?Q?NNu8LJiGIDSgKU5VJPH5aFJt8LHeNkaGmxw3DwIZHFmwHxasAFZXVLVuRK?=
 =?iso-8859-1?Q?vpi4v0YpQPenLg0waif6clnhZThyaaqvmIIUOlfLz10f+vj0Mmom6IUq75?=
 =?iso-8859-1?Q?32lr07yma1CpFAdftDQiMIJdXdQthiVrl68KBfkZFQs6GgopVAE4Ptwr6t?=
 =?iso-8859-1?Q?8WMjWhFVArrP+OeGO11NlGNMjtl7x77SfnCUoYIue18vhp8uFzIsgOYPxD?=
 =?iso-8859-1?Q?uwDfZ6PIdgz5PBq3jqseUlRclpBkCf6yD8Q1IVqJmSQPiqayUZEQpWRZ1k?=
 =?iso-8859-1?Q?nvslfNVJmtvZiafysknBepJXulYqHP6HCXQecz68J/V8jTrltdwLg8+Az+?=
 =?iso-8859-1?Q?Ciex3yQgxYeDdGPE+2Y7QIdCtdI39RCR166a7Tr1I6uPvoVIcs0K9hyaJd?=
 =?iso-8859-1?Q?GdJv9eR3PfNrdcYHsPyzG0aB5B7ZD/QPTl+4zI05o7pH0mMLa5+Sxg0sIE?=
 =?iso-8859-1?Q?YW2VYg39AI5J9tvBywweIvncx2CuNSxeSIQgBFOBshUA5SA7Gp4ICVVxWb?=
 =?iso-8859-1?Q?g3k9bkFptFONruEUVwaswTZB7uqoYm/9rEDeaqWwUR0qn2uJqJk9eu4Rgw?=
 =?iso-8859-1?Q?X1hh9RZTliMGRfLtOFVGUmnPlPec1RruzURWRnOcYlluk/0StlQVBnrrbl?=
 =?iso-8859-1?Q?PYweAxkJrPqifmssTIJipE+95fsXWivcihQH/oMX2d8U1aESIiJy7UTCWk?=
 =?iso-8859-1?Q?INZVe7TS/AfABuq5quKXuX/HaNJnpEvUdzT4C0NX72VIchAnuotS7VVGJL?=
 =?iso-8859-1?Q?xsMIdEl8Hs8MX2nhehHVvDkdLnBqg2p+JZBuvZhd8mjYjwiI/ME1brL+vB?=
 =?iso-8859-1?Q?cHS925uYMerBt/nP4nwGhavi7iuz0r1GJwWUT5y4lpdmDFks0ObKJ8ja0D?=
 =?iso-8859-1?Q?kdU3291qoRLaWFetfP/NWYSmyiHAusZLtSaLEuAve80/4uucvU/xZlcugy?=
 =?iso-8859-1?Q?7NyFcV2Hatdb2fKHecCWKsdy6qpUlQmY96kuNFdUcnpNChWhbDM2o1og?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ee366f-99ad-4ff9-c8e4-08ddba5c5038
X-MS-Exchange-CrossTenant-AuthSource: PA4PR01MB7726.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:06:20.5284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcuEnqas5cZPyNIVk0H3iNIhxKxrEGtX/DM13um7MnmHaoPbjMthgwdpCVhBUz5kpAUULLwIdEssY1Ry8VOubpE8wHilFbE73RPkRFAb/pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PFEC7F10FC1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Jul 2025 18:06:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1747

--2rqtogaeaxxyr4qo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [ptest-runner][PATCH] main.print_usage: Remove unused argument
 list of -l
MIME-Version: 1.0

Anibal Limon schrieb am Do 03. Jul, 09:17 (-0600):
> Hi J=F6rg,
>=20
> I will apply this patch!,

Hi Anibal,

thank you. How do you think about a full help message with -h to describe
each option? Would this be useful?

And a different issue: currently, ptest-runner fails, if no tests are
installed or left after exclusion (of expensive tests). Would it be okay to
add an option to successfully exit in this case? We run ptests in a
build/test pipeline and don't know in advance, if there are (useful) ptests
in the image.


Regards, J=F6rg

--=20
Navimatix GmbH           T: 03641 - 327 99 0
Tatzendpromenade 2       F: 03641 - 526 306
07745 Jena               www.navimatix.de

Gesch=E4ftsf=FChrer: Steffen Sp=E4the, Jan Rommeley
Registergericht: Amtsgericht Jena, HRB 501480

--2rqtogaeaxxyr4qo
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIThAYJKoZIhvcNAQcCoIITdTCCE3ECAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgghDNMIIFgTCCBGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7
MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdT
YWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRp
ZmljYXRlIFNlcnZpY2VzMB4XDTE5MDMxMjAwMDAwMFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJ
BgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEe
MBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNB
IENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKC
AgEAgBJlFzYOw9sIs9CsVw127c0n00ytUINh4qogTQktZAnczomfzD2p7PbPwdzx07HWezco
EStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i6HTJGLSR1GJk23+jBvGIGGqQ
Ijy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1RjjWmp2bIcmfbIWax1Jt4
A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0tyA9yn8iNK5+O2hm
AUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97Exwzf4TKuzJM7UXiVZ4vuPVb+
DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkTrNN9N6frXTpsNVzbQdcS
2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LTTLPt
W//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAf
V1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrW
X1Uu6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAWgBSg
EQojPpbxB+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYD
VR0PAQH/BAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEMGA1Ud
HwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2Vy
dmljZXMuY3JsMDQGCCsGAQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29t
b2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJv
m3WOnnL+5Nb+qh+cli3vA0p+rvSNb3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+
3ri0ivCRlv79Q2R+/czSAaF9ffgZGclCKxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHx
W/BBC5gACiIDEOUMsfnNkjcZ7Tvx5Dq2+UUTJnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1F
zZOFli9d31kWTz9RvdVFGD/tSo7oBmF0Ixa1DVBzJ0RHfxBdiSprhTEUxOipakyAvGp4z7h/
jnZymQyd/teRCBaho1+VMIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkqhkiG
9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcT
C0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMT
JVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTgxMTAyMDAwMDAw
WhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4w
PAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY7
5tqSvysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEibivHb
SuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHKRhBhVFHdJDfq
B6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFbme/SoY9WAa39uJORHtbC
0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManRy6XcCFJE6k/LHt3ndD3sA3If/JBz
6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMCAwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5
v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNV
HQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYI
KwYBBQUHAwQwEQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9j
cmwudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNy
bDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNv
bS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3Au
dXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAQUR1AKs5whX13o6VbTJxaIwA3RfX
ehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFuSUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2
f102qxxvM3TEoGg65FWM89YN5yFTvSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGW
MeK1w+vnKhav2VuQVHwpTf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF
8Co2AOlVEf32VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bw
c/Tn2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZGXq6F
2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMGquITn/2fORds
NmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmdWC+XszE19GUi8K8plBNK
cIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4hYbDOO6qHcfzy/uY0fO5ssebmHQR
EJJA3PpSgdVnLernF6pthJrGkNDPeUI05svqw1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVv
JsmzNicwggUwMIIEGKADAgECAhEA/OH3TxzsxiYnBai43hD2fjANBgkqhkiG9w0BAQsFADCB
ljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMH
U2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0yNDA2MDQw
MDAwMDBaFw0yNjA3MDMyMzU5NTlaMCoxKDAmBgkqhkiG9w0BCQEWGWpvZXJnLnNvbW1lckBu
YXZpbWF0aXguZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDNxFyhl/UuZdUp
uQiuqZBMSU/pN5SMIj4lkvTlrtp2jl4Q77wbv4vXdXIFWqKd3qtut55G0ptK4nXs1ARrh3AH
QAYwB0vW+PHVNPLs9yombnTeMgnEv/RQDFkH+DxoKdY5+DRUmcVO/tYl6ExMEBj6oh6b/63w
hIkC61WRETH3FpRCRbyNBD73OWt0KzxoKzW9xmdqfhNtylLcIFMzuv9C1WAqJ3mLbFHYaW4N
EMMckPZJWWYzvA2nwCCryerE3J9z4ZbSK0OK6DDRN9gW/H7+/4pHSIhdooGfQEdgLj+Z4ZPh
vLMF5DncBD8k5DOK8mlDxCKp4GsrLLuBfLQdxilvAgMBAAGjggHiMIIB3jAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQU3lTOaS6cJRsIzzEjdtC4j6GPtWIw
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
+9s6RvytgsBtk1dB4lJEMe32RnTa4ABWg2VpdqmG7wjr2BlUCzLzuxUxggJ7MIICdwIBATCB
rDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPzh908c
7MYmJwWouN4Q9n4wDQYJYIZIAWUDBAIBBQCggaAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjUwNzAzMTgwNjE3WjAvBgkqhkiG9w0BCQQxIgQgagTB+CvO
zgonHVJmVQvWx6/X8OkWUUqEhAJOf6rsDGIwNQYJKoZIhvcNAQkPMSgwJjALBglghkgBZQME
ASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAH9sgf0wDKAY
5c1NNNfGqwTPnEABCsYRmf/HB2GieJ8k8nkVzajbgt2af4b6+IUImJQMjX/Zogeyf9np6Xej
EH0l98HeJp0p072o8v1RmWtRhBSJDaM4dxW92vpb9JnnStyAi4IrZD5KcxlCvupGWctMQOCf
aw7jK+ytPG1jHHLlFyCqhOAmPvvWwISYaU0eoTvWeiEgUg6rsTWI+DsQMxfDEBbGpa5HRRs1
4Zt9i+BkPz8v2fbEVzup6cdmnues67qE2k0+nsj265E3ajZSjsaC9oecyGmirweaBKOsEdQN
0TtRFX3tsa5JlS3gko6ShVnVRTQ/yn9to2jcFA2xNKg=

--2rqtogaeaxxyr4qo--

