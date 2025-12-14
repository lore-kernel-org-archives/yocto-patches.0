Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD8ED5B16D
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 18:47:09 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30998.1765738026647254474
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 14 Dec 2025 10:47:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BHA7kkxs;
 spf=pass (domain: siemens.com, ip: 52.101.69.47, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXUlTPrEvMKWuMf1aNVG1o7Uls4GepxsWdQZQUSJZJ9wijU1hNo/3d9WZ0ute2HLUPtMpzWNMrbYGJOnE1h5JNibttGdmQRCeVrnm98jerfQMIdZG5TaNDXIB0ycyhrW2nlZzuL9dbe0qIsnX/FxGsHCfFQwMIjbBCfU0vcQ+odd9D9J5hhgHfcvvLyuGza4ELWgUOkHsJNQ/KmqFxYS+M9lXfBeDRVnFANqe0ESPR6xxvprrF7JD3dga/zeyiqbr1KbJl/S7k/g89JosSwRXki0k/ft/Se5MeXdMIXcD7uuJANkzPDok3BI8LP7gOJfX0QaBhoWCvvxQADWkh6IxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z2NFFvS2rais8AOGFFiP/dINHWeT2quJuwSu0szEF4=;
 b=u1w2iah3MSinkz1evgXzzSYy1w9O8JqYjLRfMS4ietQMB+E/wfPbYs6OALYv3DHBm9yBYMG1TfhdfeHuQJECCaUcmBV65LaD101FiW5yJD0kHTc+9+jYxcbv0Mm8+bBtpFSrwyTTyEQaBooBM3c8KK15FCefrzwPy5cUFsnBWqnWiPLDiRHmmaIqbQqbpbLx5wGmw6GJQKzX0qOZpBkV5RTbcSXXZK4Dp/9nCBgC7lHmz+loaxsrcAXMYU19k2EBy+ZbB/B4udeJomuRDHIKfL/UyrvH99EUL8uXyu6hFVrU/zdViSn6w/gnvYL01DWxTJbu8On6SwL/4Gy/HulMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z2NFFvS2rais8AOGFFiP/dINHWeT2quJuwSu0szEF4=;
 b=BHA7kkxsxQXHa7ArKwcA0Q4ojxYSnowVrozLCZvk1fEMP+B67Y9MSV71tsWcIsdixf9HKa1Cv4a4M3gOxsSgL8om/LwuC+TsNGHuoudwPaXbQChDxizVzVdHr+nahU4rPbM2ydSeUmTLfvG7+SyjCmsogaY79sgK66QErB+YXCujhHhCpZ1Y03JnLza7o0/+o5cfGU+5gsSl191T9xcZq6ZSRIznkcjiahvSB7OzT2JCDRpbM7it4TLzUlhXmUlSNodTK/YAjPIp4hvsQ88xPisTh6rdzxtrEMVnAfXC2CRp2Jkm1SkmEJ6zTPk9teaN9JHd3mleStXCLy1CxRNUjw==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by AS4PR10MB6039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:576::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sun, 14 Dec
 2025 18:47:05 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9412.011; Sun, 14 Dec 2025
 18:47:05 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.25.4 ->
 1.25.5
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.25.4 ->
 1.25.5
Thread-Index: AQHcahVUHy1wtxrUXEKQ+/rgwCcUlbUhf9IQ
Date: Sun, 14 Dec 2025 18:47:05 +0000
Message-ID: 
 <AS1PR10MB5697F2A74C754A3A2051D4D5FDACA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20251210204113.10115-1-peter.marko@siemens.com>
In-Reply-To: <20251210204113.10115-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=98d26c1b-71fc-4d18-af78-55d5a7c79a5c;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-12-14T18:46:44Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|AS4PR10MB6039:EE_
x-ms-office365-filtering-correlation-id: bcbb4bdc-ec7b-4b39-4271-08de3b412d48
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?KgoIBjVZ6nuk4cR2WH2mL3jYIv0caqZyhQyzp2JxjNTMgK65SyQLGUUyALKH?=
 =?us-ascii?Q?pVlBsbXEa84dAOM0WnVa6rXph/BpMbD/YQvEY2a2D7LwnebKMbrCEt4uBmFd?=
 =?us-ascii?Q?H8VGSIb82ZyRjHvr/mmvYyt5E2TVsqHlwjytOkls31vv8HSDlkJq5dBiyV4X?=
 =?us-ascii?Q?RGfdAVn274ADOt6HPlbwKwyaDZ5hQ4MxLS2recfSKG2hcv2/mmyrSvt7RANG?=
 =?us-ascii?Q?WaCqffi+rxX0M+YpKpnNXWZjKsDbEyBeNdkzGBjoRwsKuFwNlcTWDHZIFhLp?=
 =?us-ascii?Q?z7aciW65D34YSvhLUo6F0Ncn1su+pBGF1b8MiTc3WpNyonLjkAnIy9ONfYjB?=
 =?us-ascii?Q?KuZu8Ewms1+1xjS/3P7nmQc3hMgRM1s4GJirOIt3IeYw+pcM3JgO1MVQM0ch?=
 =?us-ascii?Q?O/fTIzpmZ7H0CZ1zj4EwrlNkreQcUiBs2uw3IhtaL3zbYiBZmD5AnjU7JJnx?=
 =?us-ascii?Q?WUwl5oajkj8PupKLWDdmWNEI6j6EPN581xzXwtb1ppF+U32pxask7bTXEDJJ?=
 =?us-ascii?Q?My6BStt4v5S+Gsrjmw3ewTkqu/a7e9SqzmjftImx7YFi0D9clnsQgFXQ/3My?=
 =?us-ascii?Q?pCL9c0PkC2sdbA2ndtNr7Lsgcdj7kw4OewcCyZhbV//jrhBIXS3KPXizs6VD?=
 =?us-ascii?Q?pOj0XtQKsyJC7XVcKi/FGEsks9w64OTCZZH4l6cgonJn9FOUFWk8nK/2YSsD?=
 =?us-ascii?Q?08yXtOS63uxS8vXq2CEda+9pszzYWyN35ch3Zx9DeGK9WjS+wtrtGaGgB5+s?=
 =?us-ascii?Q?vZ7JECFrVyPopyYU801HGSj1BKv5nVUIEouwGxCTU2hwh/siGSBeTXgspwdc?=
 =?us-ascii?Q?N6mscV02YK6EZI4ZNNsG97vfZl0dA2t6IMSKi/qvdbNUIvQI9bc0CCz2Hs5y?=
 =?us-ascii?Q?jmZdfZBYO1a64pXd1CVAT+Og3UhgOan4gV1wfZh++epyBGblOfdM5b+IOHLf?=
 =?us-ascii?Q?eIAAZLwQOLt8G22LEKZxthvMHfcol2o+0ORPM94VKE9Cz6IfqzzkxCBv41o/?=
 =?us-ascii?Q?izMfIjAn0YNq1lbNqgMI7UyzDD+bolS666iB7OaMbBtCJ/D6joTmCRzVht1G?=
 =?us-ascii?Q?aTO4aH8vryIBH1wqTYanUVFLGA5KiGa1zvNrCxXKP9FkiKZuRXp/qKkUkOt2?=
 =?us-ascii?Q?Ogkh8YNKhzWnEuiQzAg3cGu2aezw6mee0fsZzW84akwN+hsjRBEWnjRGiWrk?=
 =?us-ascii?Q?6gBfCEEtvNeZx+MIRv7ERKxVWw7W+1bN5d+JGuXM+uXd9Ri6MfHkqBUFm376?=
 =?us-ascii?Q?r518QRpzvHQmO2g3sZAzK4ZpCLOOamvK6ShPmwD5bgiGecsUi3MtUw7xdDJR?=
 =?us-ascii?Q?/iA+1LLouyzp4MWom0MhtO1Ge0xGdfGII81F7FMl+lj8WNbBLga0o6TPMjP6?=
 =?us-ascii?Q?fFvJ5YOEOlMuEALhxQtLTreIpA0eQ7gFbK6Gj/oW1a9NMctdOxJC7CqcaMRW?=
 =?us-ascii?Q?DjKStJfAqm2z9N7ASnkjqOaetfF25NgD6TmzAL1IgczKrg4qQt7vsxQLbZmL?=
 =?us-ascii?Q?bHhFn7cmNoDB801CNiKCpM6+t1KH2umWD+y8?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?twf3ocS8HnvgaVIquipw0sDZU3jxyvv9S1xpe3uaizWOJpaG4e5Q6wYr7kgr?=
 =?us-ascii?Q?A+nxf8pSuk6MDn8uxFJge0wIgbvYP0OucW0HRWBLYA6ETt6CkWYZIsh6cUpT?=
 =?us-ascii?Q?2PBG7fwVw4IMkfNO3Ityyiod+/D2/af4vRJBL1XoAHUo5BucxyYo0Ahqm7oo?=
 =?us-ascii?Q?I3CIcapBevy58VLq2Ov6TzGQ50xDzSlcpEbp3FxO+/pF3F4Rh0h5pQSoY0yf?=
 =?us-ascii?Q?XNbsQ4J5eUKn57DR8OzYrbkNUoGnl+31XRTOIa7/TjARBdpYDOv6JMGJIan+?=
 =?us-ascii?Q?0kTRlPFkPy8rFiocFZD9uPucMNxA6JYqbqj1zI+7Ux0xbVSRTIuzja+DhiXH?=
 =?us-ascii?Q?uA9bZaF5HFUm5KJKHql9r5Txi7d+PZ3M1UH4O5iorJG1nDlRg3YIZZnWHDNd?=
 =?us-ascii?Q?hfPTSzDQWsl6bitU/W4/vc2rHglhv0hk/9PxT3lMxAt1Bp3ffua+ApnsF/s1?=
 =?us-ascii?Q?iqdzoFPFx5gz8GXhXhhufmTwLbvasUscQQGV19L50P6Q+GuJ1xuik42qvVjC?=
 =?us-ascii?Q?zx9OudV4j0V07C/sdRx+nhwdE14/xh2cCFu/N5sr92MeW3DgS8Iy+G2ZxPfA?=
 =?us-ascii?Q?aqVXB6WEx+siLygK0rQzMvEi1cWRwKH572TaaDQCvToc0usikHGF8oLwfDRf?=
 =?us-ascii?Q?8m/EQaJXdpK+IbsJn+ZwRDsQa1yFEIVbjIKYrO7/zIkY0THZYT5eJaA1BWNW?=
 =?us-ascii?Q?cXZqQbd76O+9Wml2p/PdUBObNPNoaI2SIJtpJchWxsJ2si2yonh+kdbyaZGQ?=
 =?us-ascii?Q?aGhwpQ0GrgJYbcWZQOAUZ0jpNm5d2ipXaG2IHdXZEK2dPBIxO2LXJVeyg+5U?=
 =?us-ascii?Q?0R8WHp/NImIgjRwgjZZ94ptOgr+hu7lqwXrBifcfVo2WaMIOKdBkeJJsGcUy?=
 =?us-ascii?Q?PXr0x7ajyh6W6yoWbCIU2xLBLeel93LxQ9+zNuKCeJFJ8+ZZlygdBU/SQ43f?=
 =?us-ascii?Q?l5Kt2DEZQpTNc2ljICtMJGJWcWA6aNN8qWDFFMJwu3HVtjb+jtnNMvA2f55l?=
 =?us-ascii?Q?IAh3mPAzrJig0vnS7eBL48Y95n3N6xeN1u8Bfm3j/5TiHWu1Z6R41Fe0YRbC?=
 =?us-ascii?Q?SJl2eYVZ963M1qh44L6LRFxSFVfLTE8fZNycYF3rUPS9ZfJYoQAxyljWOmBf?=
 =?us-ascii?Q?exzLL6coD8/B7cQG6ovOUDyDjc9DwZ2oCWMOo9SiNxB0y4d6cvgYkmsvYz+o?=
 =?us-ascii?Q?5Gj74CHKmzL4hfyt7Xz3qHvzzc4Qs7WN45svb61spSiYEkeu+XVy/d4gzDzV?=
 =?us-ascii?Q?8Kq70M/wT1JnmzSuGVMD6IcbW9qgkR447uLufX9ADSZuzfDlmXV4E4WvI9Ju?=
 =?us-ascii?Q?WvUZy1uTckByXtRU6VaoPd8JXxQWnv8OsPig8xE6wrVN/F/fKwO/QMLRVCm6?=
 =?us-ascii?Q?N0XwSG9VS87oPWZnuJVGa7RXn/wNY7mdd3EOHh0JOr331AKyi7uNCOK7Q8sB?=
 =?us-ascii?Q?5gR96wbm99I6LwSJQOUtz0x2qNlIHxcSrnPcOhF3vg66UrpCfoYnB/kOapB8?=
 =?us-ascii?Q?TwdKH0Muk2qqgFMPyHHQo7506vP7uRPVW87h2xExUMCj6Um0Dn8DDwC2VQnw?=
 =?us-ascii?Q?A6pHZJ63B8VS/INfZAnGeoqt9S6gXDOpg4iTtHH2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbb4bdc-ec7b-4b39-4271-08de3b412d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2025 18:47:05.1265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofezRYioj8cFRAZhOb3KX+d1pqcIo6i7WmM6AVFJ8CqaP/zSI0qFzeIcv5Bsl4awvoWKTAzFEuLkX7/uvm+viQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6039
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 14 Dec 2025 18:47:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2783

merged

-----Original Message-----
From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>=20
Sent: Wednesday, December 10, 2025 21:41
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1) <Peter.Marko=
@siemens.com>
Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.25.4 -> 1.25.=
5

From: Peter Marko <peter.marko@siemens.com>

Upgrade to latest 1.25.x release [1]:

$ git --no-pager log --oneline go1.25.4..go1.25.5
fefb02adf4 (tag: go1.25.5) [release-branch.go1.25] go1.25.5
f7bce4bd6f [release-branch.go1.25] crypto/x509: prevent HostnameError.Error=
() from consuming excessive resource
287017aceb [release-branch.go1.25] crypto/x509: excluded subdomain constrai=
nts preclude wildcard SANs
e1ce1bfa7f [release-branch.go1.25] mime: parse media types that contain bra=
ces
433c01e94e [release-branch.go1.25] internal/syscall/windows: fix ReOpenFile=
 sentinel error value

Fixes CVE-2025-61729 and CVE-2025-61727.

Release information: [2]

[1] https://github.com/golang/go/compare/go1.25.4...go1.25.5
[2] https://groups.google.com/g/golang-announce/c/8FJoBkPddm4

(From OE-Core rev: 91c007b0f5fff728cc7803a56a4df8438f20bdea)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-devtools/go/{go-1.25.4.inc =3D> go-1.25.5.inc}        | 2 +-
 ...o-binary-native_1.25.4.bb =3D> go-binary-native_1.25.5.bb} | 6 +++---
 ...cross-canadian_1.25.4.bb =3D> go-cross-canadian_1.25.5.bb} | 0
 .../go/{go-cross_1.25.4.bb =3D> go-cross_1.25.5.bb}           | 0
 .../go/{go-crosssdk_1.25.4.bb =3D> go-crosssdk_1.25.5.bb}     | 0
 .../go/{go-runtime_1.25.4.bb =3D> go-runtime_1.25.5.bb}       | 0
 recipes-devtools/go/{go_1.25.4.bb =3D> go_1.25.5.bb}          | 0
 7 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-devtools/go/{go-1.25.4.inc =3D> go-1.25.5.inc} (91%)
 rename recipes-devtools/go/{go-binary-native_1.25.4.bb =3D> go-binary-nati=
ve_1.25.5.bb} (79%)
 rename recipes-devtools/go/{go-cross-canadian_1.25.4.bb =3D> go-cross-cana=
dian_1.25.5.bb} (100%)
 rename recipes-devtools/go/{go-cross_1.25.4.bb =3D> go-cross_1.25.5.bb} (1=
00%)
 rename recipes-devtools/go/{go-crosssdk_1.25.4.bb =3D> go-crosssdk_1.25.5.=
bb} (100%)
 rename recipes-devtools/go/{go-runtime_1.25.4.bb =3D> go-runtime_1.25.5.bb=
} (100%)
 rename recipes-devtools/go/{go_1.25.4.bb =3D> go_1.25.5.bb} (100%)

diff --git a/recipes-devtools/go/go-1.25.4.inc b/recipes-devtools/go/go-1.2=
5.5.inc
similarity index 91%
rename from recipes-devtools/go/go-1.25.4.inc
rename to recipes-devtools/go/go-1.25.5.inc
index f88d7fe..47d5c39 100644
--- a/recipes-devtools/go/go-1.25.4.inc
+++ b/recipes-devtools/go/go-1.25.5.inc
@@ -18,4 +18,4 @@ SRC_URI +=3D "\
     file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.patch=
 \
     file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.patch=
 \
 "
-SRC_URI[main.sha256sum] =3D "160043b7f17b6d60b50369436917fda8d5034640ba39a=
e2431c6b95a889cc98c"
+SRC_URI[main.sha256sum] =3D "22a5fd0a91efcd28a1b0537106b9959b2804b61f59c37=
58b51e8e5429c1a954f"
diff --git a/recipes-devtools/go/go-binary-native_1.25.4.bb b/recipes-devto=
ols/go/go-binary-native_1.25.5.bb
similarity index 79%
rename from recipes-devtools/go/go-binary-native_1.25.4.bb
rename to recipes-devtools/go/go-binary-native_1.25.5.bb
index cf94e8e..868cb20 100644
--- a/recipes-devtools/go/go-binary-native_1.25.4.bb
+++ b/recipes-devtools/go/go-binary-native_1.25.5.bb
@@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
=20
 # Checksums available at https://go.dev/dl/
 SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH=
}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
-SRC_URI[go_linux_amd64.sha256sum] =3D "9fa5ffeda4170de60f67f3aa0f824e42642=
1ba724c21e133c1e35d6159ca1bec"
-SRC_URI[go_linux_arm64.sha256sum] =3D "a68e86d4b72c2c2fecf7dfed667680b6c2a=
071221bbdb6913cf83ce3f80d9ff0"
-SRC_URI[go_linux_ppc64le.sha256sum] =3D "38c8ac8463537c99fbc1ef368f243b626=
144446c09db71b1d20634a4237c966d"
+SRC_URI[go_linux_amd64.sha256sum] =3D "9e9b755d63b36acf30c12a9a3fc37924371=
4c1c6d3dd72861da637f336ebb35b"
+SRC_URI[go_linux_arm64.sha256sum] =3D "b00b694903d126c588c378e72d354554993=
5d3982635ba3f7a964c9fa23fe3b9"
+SRC_URI[go_linux_ppc64le.sha256sum] =3D "f0904b647b5b8561efc5d48bb59a34f2b=
7996afab83ccd41c93b1aeb2c0067e4"
=20
 UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
 UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
diff --git a/recipes-devtools/go/go-cross-canadian_1.25.4.bb b/recipes-devt=
ools/go/go-cross-canadian_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-cross-canadian_1.25.4.bb
rename to recipes-devtools/go/go-cross-canadian_1.25.5.bb
diff --git a/recipes-devtools/go/go-cross_1.25.4.bb b/recipes-devtools/go/g=
o-cross_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-cross_1.25.4.bb
rename to recipes-devtools/go/go-cross_1.25.5.bb
diff --git a/recipes-devtools/go/go-crosssdk_1.25.4.bb b/recipes-devtools/g=
o/go-crosssdk_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-crosssdk_1.25.4.bb
rename to recipes-devtools/go/go-crosssdk_1.25.5.bb
diff --git a/recipes-devtools/go/go-runtime_1.25.4.bb b/recipes-devtools/go=
/go-runtime_1.25.5.bb
similarity index 100%
rename from recipes-devtools/go/go-runtime_1.25.4.bb
rename to recipes-devtools/go/go-runtime_1.25.5.bb
diff --git a/recipes-devtools/go/go_1.25.4.bb b/recipes-devtools/go/go_1.25=
.5.bb
similarity index 100%
rename from recipes-devtools/go/go_1.25.4.bb
rename to recipes-devtools/go/go_1.25.5.bb

