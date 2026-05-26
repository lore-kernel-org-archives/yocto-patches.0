Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E320CD5BB1
	for <webhook@archiver.kernel.org>; Tue, 26 May 2026 18:17:08 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2815.1779819422323912307
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 May 2026 11:17:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ff+GI3su;
 spf=pass (domain: siemens.com, ip: 52.101.69.1, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBT+teWcTc5eLPwEdIJL5IoEA+52yLPMOh1Wy2LPMTLqSRq7c7LU6IYwEjlDKZmPTQA1LHxGmQibX0Lrt0RdZ06uRM84fZKWimM8VkYrwT94JpaTVAs1y+AcnlLj8I/dwhjIL30h4jyMegza+ExjSR2Idamb4LoGiWM0C4pMjTr3y4Ektep3Ao+uMm3N9mypU7bpx5hnNyykZHUTh1Msof6/BIg1RtkpzsevWE9+Mxi+JdgiQMrMcAb0vjUAEz5wFH7BW75vVGvg5l/eKXKfMwrOVIngbEiUr8pL4vAERN0Fs7Bk2IG3dBz+HvhvKyE/6bWd99AHg7bQwf4U0UgA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg6JjwvERnmQHViyo/CQg6QYBlFr7BdEqdiCsDzE350=;
 b=Ts8Zd/Dmfr+C37G9juxG8hPd6ZPGGN4rFIQo5XS7X3PEdLGNN4Ad9fYIh5ate4HLMy0kz18fjxKH8F1L+3wdmQ4r2N56XaEW5x1GbYbnUgflwLnV8/Zfe/xV5JW/HSjccjZT1736uBXvYD4tE0AjsUcTGUVUT9SgyURPYMmwA+V4gfsibzY2AUQkHIcV9gadstKF4mxwWMkhw7mKSSl5eS7Y+CMJdkW8JC5CUmIep3SpXemmY3wIH/yVtmsDaLnr5S8rEc4/sHLorhW4Qa0MP15m4LxmSZj/my81MHWrygVudbvSAbplFAGO0Z60UYf8qnReEGlzAUJHDY9rZ/xaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg6JjwvERnmQHViyo/CQg6QYBlFr7BdEqdiCsDzE350=;
 b=ff+GI3susL+eZnYFmEI8EfZCooSzBQHlBx4iJNJyNLAqZ2sqoRF18hiUtyQmYOEWBa3MseHDIACdp7YwU0tWCt33vkU9p/zdWePrhKS8+RZ89IRj/VtgPQNwezZ++ORoYK8vyFiPqHYQfTfF1Rv6yJAm2QCeQFZ7yQB45ntVI/dAmukrwfiYjryKtzHbm7hOi1uFArT/jxmrX3jA9xpN3msZUmhv0/nsTSO6HppNTJPRAF1LpnpMF0X0q//8metMrk550MqBLh3nVwNNQzSEJ9/s77S1z0UXYK5s7KWVotzZqfJz6kGvNwAMeMNZs36kTk8bRPw/vFswhaLt7Wqs4w==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by DU0PR10MB7141.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 18:16:58 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 18:16:58 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: Ross Burton <ross.burton@arm.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-metrics][PATCH] patch-status: add wrynose
Thread-Topic: [yocto-metrics][PATCH] patch-status: add wrynose
Thread-Index: AQHc4xMn8rhuvYIXWUCUPaP1IObESbYgsT/g
Date: Tue, 26 May 2026 18:16:58 +0000
Message-ID: 
 <AS8PR10MB50732B47BD4C0A473B2ADDC8FD0B2@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20260513195949.2474195-1-peter.marko@siemens.com>
In-Reply-To: <20260513195949.2474195-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=a5166893-9e7d-4fc8-9c0a-1bc4e91a0fe0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-05-26T18:15:57Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|DU0PR10MB7141:EE_
x-ms-office365-filtering-correlation-id: 55af42a0-2858-4d21-db45-08debb52f9aa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|56012099006|38070700021|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info: 
 xFIEas46tlqhvF6ok3w6AHLjjU9kGmNGgyRHxTCP2IpajH5tEAWiHkIb1qn/FMsoeDtx3cuMgXBDrZp8LmLRzh+DJsCLd8lbZcK0rbl1TJmdmVsW/PbMt1y8AH2xp/BBrhpvQlxMZfE43D1N8UoAkzZZGHj2B10qO5O9IxVs/Q5TUc9493JB7CF1PxkkJLTyxnYLqxCei0iUMCJy2fT3OcEcny3jIICjXnbDtaDcqFXs/AMF9zgt6vYp8xWQaSnnFxaGE6IgZH7y185ezX/umpw70Nd+K4m98x1VluJ2MPk2xbrTU6OY/QLlk5DZf/s4dpkknop0nwxZphy6u+VscsUNkEaa7RQepCEGSHfs9OeKuuAoH+nJ090ckEP4MklBS/R66XXPzuBnrwaemYkbe8M1s4jXAWu5HPx81nb8XpJGGl8tZc9g76JUPx3EyLFi+KTzdjPa0+icQGmkXuv/kC2BObFMM2AzQEJI73jmGOKdYBli4NuT3N/jaMldmTRW7ayhR5V6HTk5aiZbyM8NZBjdggnWQttpCSOv8vqWEqQVaYblHZrweAtja6GbsljvvTERQEVzt+bPS0YeXTwbOkc68qKcYxsfPJZk0+5d0kOYfgRgYg/9AnFPPjMLl3/9pu8+Rwyb6W57LTLMgPwvDF2W4D8r+ePY4qika9Qwj3LZb+W1OX8+O33hbhMdJUdFB0gqyeQdYbK0md1NUhWChmN1iuLAVgyphbFTrEFObAtpTwKjoMqZPHb5tmpecAWf
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(56012099006)(38070700021)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?gJO+pej7uCd1czqrin1LqruyYTS+gRZmMA6xzSF+bEw+yPzgnCo2zLPlUBbl?=
 =?us-ascii?Q?2V0Xrqx/IX/l/H4LaT+/4VfC8xa9HUU03/Uy4g8NW+YYNZRyjJ/V78na61Zz?=
 =?us-ascii?Q?1Mhbg30vQ6lpdA0MdIR92bpjPpapyJighcaK2V977uC/nG9J8tm25NoNU7X/?=
 =?us-ascii?Q?U0uvevXshfj2sax546SJajynXRPlzN9KadYxINvnhCAkYkVqCrxo1A9uqn8p?=
 =?us-ascii?Q?IkIjH9dDljkahuXnz99GsGqxUwzcVDS2EKAQfPFSAAiI61rBuhYuUMdXyqxH?=
 =?us-ascii?Q?dH7scDMakl84vAfV6zd1dFJhvF/HVh1b1Vtc1LtXEcKFLm4RnXMAvuGkI1Dg?=
 =?us-ascii?Q?PWjBAQqWwnNwKo9gIA2jl+gjlt5a0vjMtH62k3IY6jf4w+d7b1PZ1zQ5DmHz?=
 =?us-ascii?Q?1uWEXzkPoUH2FuqQU+Y+5TI17BJ519Pd74rCoKO9+MUXntw+WNTHPmK4A9an?=
 =?us-ascii?Q?JXdq3aYSmYIf/6ahbexE4itf6+OPSFRVIOrxXD1JuK0zTVGn9D8HBKYAH+tR?=
 =?us-ascii?Q?+zJ8NvNJVltPjQr/y60I9DBD5HEr3VUe6g57cXJSFXUvdn/kSPmqmIbqjDz+?=
 =?us-ascii?Q?kzewv46cLw57RlpRZwOyAkSZ1jlpIOklxsnvAgm8VZ3s+LXi1Ql2hCOGjiSL?=
 =?us-ascii?Q?WhQQ05svBH49r99b6iwWdB7PgaiBR2QPufbTKhZUVMXxLg3aLOMXs+rgxWz8?=
 =?us-ascii?Q?JGyiLo5bMh4QlvlK69RLRtMAD2IOEpje3kAyonw4Yq2sYLBder9IVs9DwMxV?=
 =?us-ascii?Q?P2Vg4uEjYVgg/dWFvRJH09C6cDWNEsi4flS/TkpSmCmvsXMPMAUdhszowohI?=
 =?us-ascii?Q?3ATC048r/dvNbMW3/DqY2A0SD8EzdTrgxfA33zcoiGvVwPdtN0QgyVpn/J93?=
 =?us-ascii?Q?9T3dr0oqnvGlsyf+vApxpE8K9rdd3+S7ASrKUgfyMQi+UHVioCupnCacGI4P?=
 =?us-ascii?Q?LjNb5fVOAyBYQID/HTR2bX0T3ppG32clcFiDqMmpG1y7/UgwYCcSD27/Xvr1?=
 =?us-ascii?Q?esIUU51qNGsSEVZp8MF0D0++Mc9zmb5+32wPa//9PZDpL24/l2vCp1u5R8eX?=
 =?us-ascii?Q?l/8awmmgRBib29o1IsmajES4R3z2lng5FSyaJRVMNWTAdSyWSd2StayY1cPH?=
 =?us-ascii?Q?/3grM5ZsrjPrdLyfLhiG9pcJ10/9LCbfjciZpZJ2G+Y9DjgBS+/Lnt3trq/C?=
 =?us-ascii?Q?+qww3zPXFMmtZegEIRZYc4dFfsa3dJggzXBg5x92qIzJbghDpPKkQdC3zXeq?=
 =?us-ascii?Q?cTPLFsn948lx9ZOr/stFX6vQ+/wmknoaeTI3CNzMYhOetmevXo1vj9CMf/5d?=
 =?us-ascii?Q?XlzTBLQxtDNWEa/JrXe7IsD1+YVCxaHCTmXL4yvlX0Mq9gsKF88Ny1pr96xg?=
 =?us-ascii?Q?kyEM2q4LqBybvNV33TzNyKOu8f9RQbjLy43pQ15e18TFJgkvSAKBBsWv8Uih?=
 =?us-ascii?Q?SQFvLRAd130ETDyHXZBR7flEsMq5Jn0s2g73qhaw59mTQhdoT7aT3aV3BhqP?=
 =?us-ascii?Q?VFkCvdIs2hHP5NcCt0WbrxORMDXGmSPEmI1xJYrrSlbzM4AfmCZvbiDe6MaN?=
 =?us-ascii?Q?cNCwXSCZZMPfH8xiCW+XAAhJ+v6hjr2xYjtOKOEA5pplQp6M4vRQQp5j8Re8?=
 =?us-ascii?Q?bgsSBkOTKSfEwO9S6G5U//yQkSctYR2rFkSFbP2DD71wF/YgDUFfFBpMggHa?=
 =?us-ascii?Q?pQQ5O9bzz5yh4uZwgrybGBR/yzamTgRlp3qcKXWbF2rqCtAWUouWiNoVyGD/?=
 =?us-ascii?Q?LbgwBkC4lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 55af42a0-2858-4d21-db45-08debb52f9aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 18:16:58.3021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O940KJ1l9ffazsdaUmGlX1+KA/pfwvsKCMUWbNat69Xew2zRxj70VYAqaf0HWDvC/Y04xHWEL2I+S7bT6LzF3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7141
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 May 2026 18:17:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4058

Hello,

Are there any plans to bring wrynose to metrics (core and meta-oe)?

Thanks,
  Peter

-----Original Message-----
From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>=20
Sent: Wednesday, May 13, 2026 10:00 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
Subject: [yocto-metrics][PATCH] patch-status: add wrynose

From: Peter Marko <peter.marko@siemens.com>

See https://lists.yoctoproject.org/g/yocto-announce/message/386

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html   | 12 +++++++++++-
 patch-status/releases.csv |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index dd407502..9d0ebac6 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -170,6 +170,10 @@ SPDX-License-Identifier: MIT
           <summary>master</summary>
           <div id=3D"cve_status_master"></div>
         </details>
+        <details>
+          <summary>wrynose</summary>
+          <div id=3D"cve_status_wrynose"></div>
+        </details>
         <details>
           <summary>whinlatter</summary>
           <div id=3D"cve_status_whinlatter"></div>
@@ -373,6 +377,12 @@ SPDX-License-Identifier: MIT
         createCVEList('cve_status_master', data);
       })
=20
+    fetch('cve-status-wrynose.txt')
+      .then(response =3D> response.text())
+      .then(data =3D> {
+        createCVEList('cve_status_wrynose', data);
+      })
+
     fetch('cve-status-whinlatter.txt')
       .then(response =3D> response.text())
       .then(data =3D> {
@@ -461,7 +471,7 @@ SPDX-License-Identifier: MIT
       upstream_status: 'Malformed Upstream-Status',
       inactive_upstream: 'Inactive-Upstream'
     };
-    const branches =3D ['master', 'whinlatter', 'walnascar', 'styhead', 's=
carthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', '=
hardknott', 'gatesgarth', 'dunfell']
+    const branches =3D ['master', 'wrynose', 'whinlatter', 'walnascar', 's=
tyhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'h=
onister', 'hardknott', 'gatesgarth', 'dunfell']
=20
     const general_options =3D {
       tooltip: {
diff --git a/patch-status/releases.csv b/patch-status/releases.csv
index 1e8d95f3..48368ed5 100644
--- a/patch-status/releases.csv
+++ b/patch-status/releases.csv
@@ -1,4 +1,5 @@
 Name,Date
+6.0 (Wrynose),2026-05-13
 5.3 (Whinlatter),2025-12-16
 5.2 (Walnascar),2025-05-08
 5.1 (Styhead),2024-10-17

