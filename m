Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83DAC02193
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 08:54:27 +0000 (UTC)
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
 by mx.groups.io with SMTP id smtpd.web11.80377.1738554322156165191
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 02 Feb 2025 19:45:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport header.b=I66+OH9P;
 spf=pass (domain: cisco.com, ip: 173.37.142.88, mailfrom: madmarri@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6247; q=dns/txt; s=iport;
  t=1738554322; x=1739763922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=UBHeoQZjrLkrpAy1e/NPWpZXISMmCoZOrxREVcnKtx0=;
  b=I66+OH9Pck1o0Q+WjZHz4A/mW0sbn6dhk1bCkIZkjDfQcKG8SmxO3QI8
   CDDtpZQRGzTr3LTVs4zYxaBtMQVFRnt49cS5ZHTyxuVuvP69Ua8A+mQ96
   TWN5Jv4Fv+PK04IXxlJgWLieI+XLDT9Cy/6oNKMwDbL9GBSd10zyhbjqP
   s=;
X-CSE-ConnectionGUID: ry7WetteTqC5RVVxLI2QKg==
X-CSE-MsgGUID: 4xNble4nRpOKxYEwnCYucw==
X-IPAS-Result: =?us-ascii?q?A0ATAADBOqBnj5AQJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEaBwEBCwGBQDFSewKBChJIiCEDhE5fiHQDl0GGVYElA1YPAQEBDQIuAQwJB?=
 =?us-ascii?q?AEBhQcCinwCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFF?=
 =?us-ascii?q?AEBAQEBATkFSYV7AQyGWgEBAQEDARFnEAIBCBEEAQEeEScKHQgCBA4FCBqCY?=
 =?us-ascii?q?AGCHA07AwEQpX4BgUACiit4gTSBAYNoAkPbbgYYgTABiE0BKoEyhA+EdycbG?=
 =?us-ascii?q?4FygVd5gW8+gQWBXAEDGIEdK4QTgi8Egi9KeDCDP4ZUEocVgQ+IP4sHUnUiA?=
 =?us-ascii?q?yYzLAFVExcLBwWBKUgDKjYxI4EmBTUKNzkBgg1pSToCDQI1gh4kWIIrgiGCO?=
 =?us-ascii?q?4RDXy8DAwMDgzaFXYISgV8DAxYRgyV4HIM2HUADC209NxQbBQSBNQWcNQcDE?=
 =?us-ascii?q?FsBPIQOPVEsTwuBORmTIFKPAoF7oXAKKINzjBiNOIgsF4QEjQaZSZh8IoI2i?=
 =?us-ascii?q?yybAAIEAgQFAg8BAQaBZzqBSQsHcBU7gmdSGQ+OOoVggxTDGXgCOgIHCwEBA?=
 =?us-ascii?q?wmQI4F9AQE?=
IronPort-PHdr: A9a23:EZhAVxwTpWypjYvXCzPsngc9DxPP8539OgoTr50/hK0LKOKo/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHPGI=
IronPort-Data: A9a23:OFV3Hq3MbHMeQbSoavbD5cVxkn2cJEfYwER7XKvMYLTBsI5bp2BVy
 TRLC2uDMvuPMWKhe9ElPYi0oEpVu8fWmNUxTVNl3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmE4E/watANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU4
 rsen+WFYAX4g2QsaTpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGFlBpAoAE5utLGEoTz
 8ImOBQsNCmgiLfjqF67YrEEasULJc3vOsYb/3pn1zycValgSpHYSKKM7thdtNsyrpkRRrCFO
 YxAN3w2MEiojx5nYj/7DLo7leutj2PlchVTqUmeouw85G27IAlZjOO1aoeKI4XWLSlTthqIg
 GjC8jj/OAk9F8yu5CWD2UOxjfCayEsXX6pJSeXnraQ16LGJ/UQCDxYKUh6jqOWyikOlc9ZeM
 FAPvDspprQ17FasTNT2Q1u/unHsg/IHc9NUF+t/7ESGzbDZpl7GQGMFVTVGLtchsafaWADGy
 HeTjozWCCBzvYGMYi+nyImEiRLoAAsaeDpqiTA/cSMJ5NzqoYcWhx3JT8p+HKPdsjETMW+uq
 9xthHZk74j/nfI2O7OHEUcrag9AR6QlrCZoum07vUr8smuVgbJJgaTysjA3Ct4bd+6koqGp5
 iRspiRnxLlm4WuxvCKMWv4RO7qi+uyINjbR6XY2QMJxqm70oi7yId4PiN2bGKuPGphYEdMOS
 BKD0T69GLcKYhNGkIcuOdvoVZh6pUQePY60BqyMBjaxXnSBXFTapH41PxH4M5HFm0k3mqZ3I
 oaAbcupFj4bD68hpAdatM9DuYLHMhsWnDuJLbiilkzP+ePHNBa9F+xfWHPQNb9R0U9xiFmOm
 zqpH5fRk00HOAA/CwGLmbMuwacidyhrWcyr95UOLIZu4GNOQQkcNhMY+pt4E6RNlKVOneCO9
 Xa4MnK0AnKm7ZEbAW1mskxeVY4=
IronPort-HdrOrdr: A9a23:d5C+7qMbRIvrrMBcT4f255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UgssREb9expOMG7MBXhHO1OkPgs1NaZLUfbUQSTXftfBOfZslnd8mjFh5FgPM
 RbAulD4b/LfCVHZK/BiWHSfadDsby6GeKT9JvjJhxWPHhXgtRbnnxE43GgYzVLrWd9dP0E/b
 Onl7l6jgvlU046Ku68AX4IVfXCodrkqLLKCCRtOzcXrCO1oXeN8rDVLzi0ty1yb9pI+9gf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi+AOQw+cyTqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1mx3wwAPtuQxeqUMKiGXoxEcLk/aJAw7SOPAxw76xtSGpsnbIiesMlJ
 6jGVjp76a/QymwxxgVrOK4Jy2C3nDE00bK19Rjz0C2leAlGeJsRUt1xjIOLH8NcRiKnbwPAa
 1gCtrR6+1Rdk7fZ3fFvnN3yNjpRXgrGAyaK3Jy9/B9/gIm10yR9XFojvA3jzMF7tYwWpNE7+
 PLPuBhk6xPVNYfaeZ4CP0aScW6B2TRSVaUWVjibmjPBeUCITbAupT36LI66KWjf4EJ1oI7nN
 DEXElDvWA/dkryAYmF3YFN8BrKXGKhNA6dhv129tx8oPnxVbDrOSqMRBQnlNahuewWBonBV/
 O6KPttcrfexKvVaM90NiHFKu9vwCMlIbkoU/4AKiWznv4=
X-Talos-CUID: 9a23:9+TimGwQVhZmuCG0cDVtBgUOC58af2HBwUvJCBKCN1h5bJzPcHyfrfY=
X-Talos-MUID: 9a23:kWG4tgaTK3WpXuBT6y/KjjVvaMFS+4ONGHEgjpMtitSPKnkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-07.cisco.com ([173.36.16.144])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Feb 2025 03:45:21 +0000
Received: from alln-opgw-2.cisco.com (alln-opgw-2.cisco.com [173.37.147.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-07.cisco.com (Postfix) with ESMTPS id 0A41A180001D7
	for <yocto-patches@lists.yoctoproject.org>; Mon,  3 Feb 2025 03:45:21 +0000 (GMT)
X-CSE-ConnectionGUID: vu/pD6knSKecQRs5uixw8Q==
X-CSE-MsgGUID: EBgswA2GRWua9zDI3Eb9Eg==
Authentication-Results: alln-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.13,255,1732579200"; 
   d="scan'208,217";a="17845653"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by alln-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Feb 2025 03:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crNxTqqJWVwZbW0H+k1gnYia1pc77WQJz0la3OgPUBoofM5QwH+QfPjDD0tyxmSgm8USk5OtxApoWHIinwb8hl32TB5a/2yDpbGymwRCL4llYyN4leus3+sopJEhPJv9LX+IuwsvIA4XebgqJsU9Hw065vPMrRj3oTElfTzPLiU/FwqsOAGSJIUS/GRm87lKIv90tBHyqNa1HbvPQ+q40zTbpXg6Yvt7QBv08ilYZnwL3tVhDOmrL8WkSfXa7qVKdBdhocfkYGvvrHqlMDPm43wdPUxPsGhpd8hojCDIRQpGfiymw50mtbhS7SxT9IZt4HiriJqMUQza41ev3LzUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBHeoQZjrLkrpAy1e/NPWpZXISMmCoZOrxREVcnKtx0=;
 b=U9o5AenUtHWLZp27WsOtAE1LM/kp9Y5CEqf0NLBC3tNXpBSxw8WxQTnJWP1mU9ziCiEOIFQKzcdFSSmxDSVweXAeXD1hFXNN1yC2DeUGvySgQ6A4Pg6ZoT9h/qyJSnX3JHqw1vGMVF1wm1ALmMXOyqkE4kvlUzctvikdBF5C/u8mS7nNBu8dBe3b4i+U+Ie0gMwJlqbYoB3Mpsnn6ufCgE9vzedL7taCLxx1IXCkwxfMpEOEYiZ1dqNY7FhwOAHad6WBlQuxSjkhXLbTaL6nnZ6LE+7P17hn1MspvHQjSceXgJVh9rVULmjmQ0gk8bjMVcTSu1CXpS4lF30LY0K6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22)
 by LV2PR11MB6021.namprd11.prod.outlook.com (2603:10b6:408:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 03:45:18 +0000
Received: from SJ0PR11MB5677.namprd11.prod.outlook.com
 ([fe80::d83d:c581:8bef:dbd0]) by SJ0PR11MB5677.namprd11.prod.outlook.com
 ([fe80::d83d:c581:8bef:dbd0%4]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 03:45:18 +0000
From: "Madhu Marri" <madmarri@cisco.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2020-10751 as Patched
Thread-Topic: [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2020-10751
 as Patched
Thread-Index: AQHbavsGVdFVIpXR8E+jn1C/0tRT8LMteMgb
Date: Mon, 3 Feb 2025 03:45:18 +0000
Message-ID: 
 <SJ0PR11MB5677B53A0FB2297F53F094E5CDEE2@SJ0PR11MB5677.namprd11.prod.outlook.com>
References: <20250120052019.2945142-1-madmarri@cisco.com>
In-Reply-To: <20250120052019.2945142-1-madmarri@cisco.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5677:EE_|LV2PR11MB6021:EE_
x-ms-office365-filtering-correlation-id: 4324b326-88c8-43eb-695e-08dd44052d45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018|7053199007|13003099007|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?yhBpbeNYp/MKzh+4kyTY49PatdGxEdncKf6zKdlBZ/Q40l2L9k5eaYUbwS?=
 =?iso-8859-1?Q?Jk3enK6njFdqt9fb08Ko+FWMib8e9oRZ4PqxjE/OB7nxoqyRbNfOmAZvVu?=
 =?iso-8859-1?Q?mydu9S8kosECoh2sD93pNJLF0ar5JaGD8WPLfwyb9F5NpBq9jnoyzanZE0?=
 =?iso-8859-1?Q?OROxG3C/bdqwA8/PoSuY3m/p/C0dRGjPt5O091NtkLBKiWAWKqoJTz3/RF?=
 =?iso-8859-1?Q?dprp4Oo5QP5JFOWruZxk4B1FYYcFzimA90/C13k5BGyFtnAjN9kXAUoSsw?=
 =?iso-8859-1?Q?CVBI6cCw65bDoYj9cPqjvKRTsRTpqU0WkJYZDckHExokbCmKaCPwCWB9Mh?=
 =?iso-8859-1?Q?UwTjuHuhQB1UXu4Kak1VlAHQ+ZiQSXS3ruzupYbFpke7hROb+LDf/08OqH?=
 =?iso-8859-1?Q?wrhXvSfYn0/N7ee0IaLDyYn9XR+SZp09OBHHHvG3rQoPaZ4MSl4Luyy3Vp?=
 =?iso-8859-1?Q?s6gKP8f8zpCCPsI6i+TFpvN2AuHJrAVpOnZ45iFmJ0HUCbZe6PuZU6YcB4?=
 =?iso-8859-1?Q?DfNtn/OPQQOye6Nnqr6onHSewIG90nicLctRo8+GfbvwAWDbMHJdDlkaDZ?=
 =?iso-8859-1?Q?elbUfDXAHhRhnsJNOyCBrYQoe6EBNHj3exVC3zLDBFowlYkONFx3uDg9wg?=
 =?iso-8859-1?Q?aPTQnlfzBISrax2SGjAZKc2JoDOQ84LutBUjMps+4c2xXbsK49sLB65lF/?=
 =?iso-8859-1?Q?8HuJDOtWlDgXoS4XtxpvfHqNuLOBvzR3Ne3xPafODfADG+cGSjQkb79/WF?=
 =?iso-8859-1?Q?B/8sHfAv2Nev/8Or8YTn6wd4Wzdr++y+J4NdH4CjvN7/E+PkoOvTJjkcWz?=
 =?iso-8859-1?Q?sL/on3gZaclTu35m7TnI2PisDF9uGgKfiLLYVHAbNiQrZjzRG9th62TX8y?=
 =?iso-8859-1?Q?2OgyXHORJpnOt05Dvz9IxJzzFCe8zgU1SvKqAyxBL3zi5RBgLhPJhgY4a8?=
 =?iso-8859-1?Q?7sywqprA8ZVkBN6RDA+l7gomW6gYXSzxQwzK7DCj4oLjLgn6GRORBzmNmT?=
 =?iso-8859-1?Q?0wjZhe3hgOlADJWMwoJt0NTThBg9VXai+m6tY/yCTIZGbsDqadnd2D3ino?=
 =?iso-8859-1?Q?RjHtYa5DTPjuT4FASBdIl7BlVMjeuHidqbQkyKUNz6o/gnqCk4u5HEMRPl?=
 =?iso-8859-1?Q?81QEc1r+Z1S+u9xMoB1xy3AKOWKyhP8FK3F+cEjKoPH0zxR6LbGnC84esV?=
 =?iso-8859-1?Q?w2aotXFK1yXZqQ6JzWyr7eVDT4OCwUGQmhUR5fPu3hlnkiOD29/l4dVK8u?=
 =?iso-8859-1?Q?9e0/YzRPZSxFmxXaXmg5Sdstf2h3odlnpmY1old7e+FR9UFRFs6zLsElrF?=
 =?iso-8859-1?Q?0CA3cb1VoaBPZxKRTwp2P5x/SMBgzNxQwyWAXf7zOyDIKqQsnaDSL6OUhD?=
 =?iso-8859-1?Q?f3N+HZlzw7FYarQWrUYwPXan2N3QED2c5FYjwnCoA53GFneYhyW+DUxVn4?=
 =?iso-8859-1?Q?cMBTjE6hvw8Wf/ghdJTxa3ZNK/tJfVldtT2L9g=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5677.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018)(7053199007)(13003099007)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?cgsZBuNZqNYKFtVQwp00j1EI71tTOIoDlHTvFtqTrjDTQ+28G4hV+yUDMc?=
 =?iso-8859-1?Q?Di/n8ppqoxfeP9mQq92AQQH9rM5f2yuA1Z0qHQn295CDpf9uykKh4ziD6F?=
 =?iso-8859-1?Q?QfbpBXK7zytO6Wi1NoaaX3K/nFnaPsfhEg68FG8JrUh2bP/4kYtYVwsmTA?=
 =?iso-8859-1?Q?pZETsmz5JelP43H9nQHHDrOaHjVE+XhakF6+ULZcRSyB5Ds6xnEiYEzhOT?=
 =?iso-8859-1?Q?CgwUjjbbLwaF7Idhib8LJPUmDQdkZm318+bp3iF1tPbMpItYE3saXtp5PF?=
 =?iso-8859-1?Q?syjcswNpHxN42jKjiSGjN+DnjqniZuIcJ29hx4dM7+Jk4RiE4/5s5BnC1k?=
 =?iso-8859-1?Q?/ZBWc6ZO2qbf/vJqc6+elERTPUbZtiw5ft9COvDcdz2pcnkw4h3FCHySLu?=
 =?iso-8859-1?Q?fwS2Sp8GBsjceQWpU14IQ98GxlRgIZQtF8X5ZtMNftp5a1DuQ1SyeTBT4/?=
 =?iso-8859-1?Q?hocGzMe5u4r5UnxBZes9FtR/qk9MY8MbUk0JOV7E7HhVJl30tUX0+wQRKa?=
 =?iso-8859-1?Q?tsTWaNSCelNsiXmMj9926TXzSTgwc+NH6ghxKsKEhZp+NwPH6JaRZyNtLy?=
 =?iso-8859-1?Q?MNGhv0E9/I2nGT3Tt+UOm4X0LDsFY+XcmPgIEzblX/gU4bJ8giEisYtqoP?=
 =?iso-8859-1?Q?sXr1iDkAvy3LxeN0FbLW3c45oCjxZSGHsT1gzgKu4F0O5DDsjrFMT8MrdA?=
 =?iso-8859-1?Q?wvNrI+Tq20JBY0M9mErC0bBr88BkK2kSS8+lWJSpP5xnkqzpNBW/IW7cQk?=
 =?iso-8859-1?Q?Oh7wvykO+OlWvgHby+kwOZ1Px7WAIuOmZ5Hk+/s0XOlYpEqdbEH20tUcVm?=
 =?iso-8859-1?Q?FYRiLwpz2VoD/ToWkqhpzfJImPteAvD/Feyh+Bj5CrK+SRMv34wlsVzBtk?=
 =?iso-8859-1?Q?hv/eL6UfygVT7gaJGA/pSfrFcpW7I2LoF9BnebcilFLrKKpYm+Izta+I84?=
 =?iso-8859-1?Q?RCQ2f5Yv7B1NgTKWMWjVNRqFRWO8ta6vA+tt9krsOAND4Yol9ZcpaZaWoH?=
 =?iso-8859-1?Q?HAkm1Wj6AEtDpRj9AXHA5S9nKklB4I0+mNVvEC/eS53vvC2pHK1U6ktELC?=
 =?iso-8859-1?Q?N07e5EDKOME5PUMehJ4TzsmjpULv1n1lzfYvZN5Lftj6PVheuszUkfEVe4?=
 =?iso-8859-1?Q?5ZbIxvG9CHXOiyF66rGLK1JJRIukC84wQLnYV6TZ9iPFHL+fhByLL6xGhJ?=
 =?iso-8859-1?Q?bjMiRULoJzMDnnJuQV+AJQ50gqQRnDq6LU9Jei4Gy/OJnIwGa//1It0gjQ?=
 =?iso-8859-1?Q?/nc18GLCMxlPpEM1MKrhB7hJJN2JSuZFD/FFcI27PJ3a/agnRxclJAUzaE?=
 =?iso-8859-1?Q?C+8MEIeDLJ9MGSsKQgQ2k0+kzvxEIisNO2NqUlTiNLyu7Pri061VBEwb4t?=
 =?iso-8859-1?Q?2VCIrP8JQFYXZIStFbX7IchpduVEo6jP8xfZb4KbHK/KozVh2rm7RB6cGA?=
 =?iso-8859-1?Q?nEbUSNzf9huN53H4ZBilky5B+Ojmhd6EQIH2uhUXxzOZGIiuIam10LP2R4?=
 =?iso-8859-1?Q?u0c579phjE9+4dRWPI4f13fuke1gggzMxLRmpDdLuhUhg0yGCi49984Hmb?=
 =?iso-8859-1?Q?oUgrf+AfpCfC3wJkwwpaugUGC17WWaUickQ9q7cLGmVHbVH15EcBkWVZ6/?=
 =?iso-8859-1?Q?KmJYP/52YjTQMzRAG7kSBEGwcMQy1UlFutP/DQyLpSIPP6ziwR+zpHYvtI?=
 =?iso-8859-1?Q?KuboJHht7+4d1V+7ST4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5677.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4324b326-88c8-43eb-695e-08dd44052d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 03:45:18.0922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jskpiQcbM1KS2YolZ87lG34yHycFDtae3dr0vk5Mr4ktslX+OX2ZDtXuZ3MTEMpIeVCu0O4Xd/oeqEPkYS+Tbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6021
X-Outbound-SMTP-Client: 173.37.147.250, alln-opgw-2.cisco.com
X-Outbound-Node: alln-l-core-07.cisco.com
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SJ0PR11MB5677B53A0FB2297F53F094E5CDEE2SJ0PR11MB5677namp_"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 03 Feb 2025 08:54:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1026

--_000_SJ0PR11MB5677B53A0FB2297F53F094E5CDEE2SJ0PR11MB5677namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Team,

Could you please update on this patchset review.

Thanks
Madhu

________________________________
From: Madhu Marri <madmarri@cisco.com>
Sent: Monday, January 20, 2025 10:50 AM
To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>
Cc: xe-linux-external(mailer list) <xe-linux-external@cisco.com>; Madhu Mar=
ri -X (madmarri - E INFOCHIPS PRIVATE LIMITED at Cisco) <madmarri@cisco.com=
>
Subject: [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2020-10751 as=
 Patched

Bug Details: https://nvd.nist.gov/vuln/detail/CVE-2020-10751
Type: Security Advisory
CVE: CVE-2020-10751
Score: 6.1
Patch: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Dfb73974172ff

Analysis:
- This is a selinux cve which is addressed in kernel.
- The fix is available at [1].
- Hence, marking the CVE as patched.

Reference:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dfb73974172ff

Signed-off-by: Madhu Marri <madmarri@cisco.com>
---
 recipes-security/selinux/selinux_common.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security=
/selinux/selinux_common.inc
index cecb0b5..d8c91ac 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -19,3 +19,5 @@ do_install() {
 }

 CVE_PRODUCT ?=3D "kernel:selinux"
+
+CVE_STATUS[CVE-2020-10751] =3D "fixed-version: Fix is present in the curre=
nt kernel version."
--
2.44.1


--_000_SJ0PR11MB5677B53A0FB2297F53F094E5CDEE2SJ0PR11MB5677namp_
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
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
Hi Team,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">
Could you please update on this patchset review.&nbsp;</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">
Thanks</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">
Madhu</div>
<div id=3D"x_appendonsend"></div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"x_divRplyFwdMsg"><span style=3D"font-family: Calibri=
, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Madh=
u Marri &lt;madmarri@cisco.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, January 20, 2025 10:50 AM<br>
<b>To:</b>&nbsp;yocto-patches@lists.yoctoproject.org &lt;yocto-patches@list=
s.yoctoproject.org&gt;<br>
<b>Cc:</b>&nbsp;xe-linux-external(mailer list) &lt;xe-linux-external@cisco.=
com&gt;; Madhu Marri -X (madmarri - E INFOCHIPS PRIVATE LIMITED at Cisco) &=
lt;madmarri@cisco.com&gt;<br>
<b>Subject:</b>&nbsp;[meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2=
020-10751 as Patched</span>
<div>&nbsp;</div>
</div>
<div style=3D"direction: ltr; font-size: 11pt;">Bug Details: <a href=3D"htt=
ps://nvd.nist.gov/vuln/detail/CVE-2020-10751" id=3D"OWAfe63b8fa-bf09-8c45-3=
b00-0f99283c4e42" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://nvd.nist.gov/vuln/detail/CVE-2020-10751</a><br>
Type: Security Advisory<br>
CVE: CVE-2020-10751<br>
Score: 6.1<br>
Patch: <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3Dfb73974172ff" id=3D"OWA4554957d-5e47-260d-47e7-43505=
896bf6a" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dfb73974172ff</a><br>
<br>
Analysis:<br>
- This is a selinux cve which is addressed in kernel.<br>
- The fix is available at [1].<br>
- Hence, marking the CVE as patched.<br>
<br>
Reference:<br>
[1] <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/commit/?id=3Dfb73974172ff" id=3D"OWA751a8d58-7be3-19f4-4107-67584dba=
94ae" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dfb73974172ff</a><br>
<br>
Signed-off-by: Madhu Marri &lt;madmarri@cisco.com&gt;<br>
---<br>
&nbsp;recipes-security/selinux/selinux_common.inc | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security=
/selinux/selinux_common.inc<br>
index cecb0b5..d8c91ac 100644<br>
--- a/recipes-security/selinux/selinux_common.inc<br>
+++ b/recipes-security/selinux/selinux_common.inc<br>
@@ -19,3 +19,5 @@ do_install() {<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;CVE_PRODUCT ?=3D &quot;kernel:selinux&quot;<br>
+<br>
+CVE_STATUS[CVE-2020-10751] =3D &quot;fixed-version: Fix is present in the =
current kernel version.&quot;<br>
--<br>
2.44.1<br>
<br>
</div>
</body>
</html>

--_000_SJ0PR11MB5677B53A0FB2297F53F094E5CDEE2SJ0PR11MB5677namp_--

