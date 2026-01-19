Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9BAC98315
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 05:19:58 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29762.1768799991598388387
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Jan 2026 21:19:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=MZW3wdh5;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=54795483eb=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J5JeMe1195463;
	Sun, 18 Jan 2026 21:19:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=IhdwTQy2uyQ7WUoygM20J4LS3O3zD239zRSxem97lEQ=; b=
	MZW3wdh55kCik6fGnWKoYilNqp+OFWgMsSw60fxqPotlSdFhWh6037b00XPe2QpV
	kdvtOp8v3X3muhMaVNC638Rs0VLfkr8AxA88MirDbqJvKptAwwJSzNLKO9U9hqtH
	xrZX0/Iaq9zrYLIrH5eKNUlFPTydOHxehDPTr574VkG0H9VoFrVM5GiUWOV76WTi
	9GVusloao3udt/8AUrvknwIQ2wH5Hi7npiN4cORGWJCUoyEBQVClStPnZ6dC3rZi
	tQ3IL46SMTZmftK3t+YwJ++zmANzxE1aJbGEr0p2gK+216pCVnddxphfhD46on1y
	bJ6ZGqys6S6WF6cCIHh+dA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bratgs3gr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 21:19:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQiZru40MhIcYFDg19QbTnbnBU9T9+8rtrFJDpK2QO9WExJmzJxzqEHY3AJmiaMi14T/LAwj5kVu4MXGaH5E6Ww0+L6OXOuHvxLjS7Q2Jsgfy1P8p1UfsscU2XYqhYwhwii4xlKx41LzIpEddlHIhdHODpy1iSMiv0XtN0trnUUo6wFMMiLm1mdL2UWDpCQNzxDv0Ld2BaLkcYOL7YEnRDYItlFNkZOzoCh30UST3jbbd+z22dkvKR4ZFsS9Z9ldSq2GZxuMTuZhrr5d028CowgJyEDxiDRXgg6e9+nRwa5AyZ8wQrVKXW5J68FOmAjQLe6BVi2Xk0tpnneygWeiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhdwTQy2uyQ7WUoygM20J4LS3O3zD239zRSxem97lEQ=;
 b=dHLMN6yPDMhhKMmiyXijbTc1UGTLIlRUlkkum9JBcpgHiFbZcKHJyEMBv9km5dQR9IJ3SBUbTd2eKlO+HRMgDYKVjuB4BTvwIqOsIGpI1a6fg/gvbdKtG5XiYF3c665V2wZUjaqtowA1NPwxG0saLwXUVO/su9YWi31gRmhzNUji/mYiqzBsC4XbE4g7cZ+2AqcsdDfQQncHiXhKaC91VeX6EFAMvzvkkxHvs8OGiZc3S1JsnL7i89RD71SQm5OR6KB7MVPrJsespa9aOT398t4YvK+OVB5T2ww7Fd22mUzriIRSo8KCx6DgmUs/0FdZZwtBzGZYJg+fZT4H1HA1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by SJ5PPFED9C9AC99.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::85d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 05:19:46 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::ecf9:dbb:16bf:5b2d]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::ecf9:dbb:16bf:5b2d%6]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 05:19:45 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Joshua Watt <jpewhacker@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-mingw][PATCH] mingw_sdk_handle_symlink.bbclass: avoid using
 non-posix -d option for read
Thread-Topic: [meta-mingw][PATCH] mingw_sdk_handle_symlink.bbclass: avoid
 using non-posix -d option for read
Thread-Index: AQHchwVsvl9y1+rKt0aG+uqIHckHQbVY9L/Q
Date: Mon, 19 Jan 2026 05:19:45 +0000
Message-ID: 
 <PH0PR11MB561108F3C3E0F7D413D66CC4ED88A@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20260116050512.3751871-1-Qi.Chen@windriver.com>
 <CAJdd5GZzFkiDvUFkNCeMxa+L=Mn9YthqOwRJF2JrowjkKawp+w@mail.gmail.com>
In-Reply-To: 
 <CAJdd5GZzFkiDvUFkNCeMxa+L=Mn9YthqOwRJF2JrowjkKawp+w@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=41a8bee4-c1ff-4a99-b1e9-7d09b745d642;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-01-19T05:06:39Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|SJ5PPFED9C9AC99:EE_
x-ms-office365-filtering-correlation-id: 225dff6d-6e9f-4cf8-fffd-08de571a5bd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bi9vbWpvYnRpVUtkNTZmVFl1VU82VVBmeEN5cjQvem96SThqREhST25MS2xq?=
 =?utf-8?B?Q01mYzdSc3RqUHhuZWZ6Ym94ZTdTMWR0YWJJMFpkeGlLZ0hnRXpJY0xEdmJn?=
 =?utf-8?B?aFFodGM3anhWQWo1SnU0czNrc1pCazZLV2hqUXU2aFozV1R0UGdFcnVhOWhM?=
 =?utf-8?B?bWFGMDhxYXNGdlVkaXBNWTM2bjhPc29ncUo2eElCVVdGVXNUMlVwMmFzSGRy?=
 =?utf-8?B?SHR3MEYza1BwRlhLTnNoSi9menJWQUZINjcwaVZMWjZwSVFRREgrRi92U3oz?=
 =?utf-8?B?b2cxaWJMNWNnNHpUNVJoZDRldHZaVUJ2N0pGS0I5eUlrdmU3bWttTkZiZVhE?=
 =?utf-8?B?TWE4SFlvQ0p2K09vVW0yUllVdGFZZGZzWWI1eUgyamUwa2dDRzVSOW5uMGZl?=
 =?utf-8?B?bG9vb1ZnQi80bXB5N2VpTnBBSGdPVGxrNEEvaVQ3M2J1QjdWUVZybEZVQ1RQ?=
 =?utf-8?B?SU5VcElsa1dBM2ZZWlJtOFcvWTVoclJwVU1VM0IxRHVRNU5BU2lIMlRHSUxX?=
 =?utf-8?B?Kzl1N0NRcmFxemZERTl4OWgwNUt0Ykp5TFBkZkFmbGJ3YjhvQjM0TG9qTzZt?=
 =?utf-8?B?YlZWekIwU0c4NEx2bjdOK3NJMEUvVDZkRWt3ZzhvUlpWSWNCMEFrNTgxa2F5?=
 =?utf-8?B?R0xybi9nTmF0YTNHajRHRUJicUNrMTFBbWE2SWRTYSsyZDRUVVpKbkc1MEI1?=
 =?utf-8?B?VzZUYWNuRzdOdlhrUGR2dEtiMGYyZk10ZkMzenNpZ1I3cXZPdTVHRmxnWVh3?=
 =?utf-8?B?SllwdktKeFRxL2IrT0U5a0NlZmlTK2FvdU9pZERZYmN6NGozS3RJckpiWGMr?=
 =?utf-8?B?blBESklpdytXZEM3dTcyd1RVUHR5NFlTOThmMWxmZkpQSUpCTForNzEzSTA0?=
 =?utf-8?B?dTl3SmNyRGNUekpaM05YNS82NUxpVTB0cVNUMHkwU0NadWUzZDlsV1IrTTlw?=
 =?utf-8?B?RHFKb1JpdTUrR3NZM3hMT2pRY2t4K28xUC9DU01LRHpVL0tETWh3UVFlTUVE?=
 =?utf-8?B?S3IxclNybDFhOWp0QlBSaEduZmlNd3pkeW1hd2R6K1dKZUd1N1NCQ0NpcE43?=
 =?utf-8?B?TUpDSDBHcFBNKzJMWldxeFN5MllDWERCWkVFNnR1SmtWcUtkdlJFQWVDQWpD?=
 =?utf-8?B?UUdjQnpUdnU2dDBDMS9SMmJRSU1vWWVjaCtDSWVjdW9RdmlqKzhzVjdPUmw4?=
 =?utf-8?B?dGgxU0oydFN3Mi9adTB0NTJzRUtkMVM1enRJRTU1VUVzbi9xVmE5SmRiUStD?=
 =?utf-8?B?b3lPWXdKNlR1VkViTGs2OEpwaXNnS0JPeUp1WEVlakp1QmlzbHdXZy9lVUgx?=
 =?utf-8?B?MXdHNDlnSzdCMmhXMFV1M2hNdzVQSlF2RlBpaGF5Ujh2ejJqRVVteWk3djFs?=
 =?utf-8?B?Y0c5SE1DWjBjbnZjMWxlblJOZzRCczNaY1hEYXNtQTlYU2JZUlV3UDMzMlAz?=
 =?utf-8?B?cDEzcllDWXdRbzJwMUlFK0xlOXRpNG8rK3hZa2h3MFZFNTY5OEF4cHhJMjlW?=
 =?utf-8?B?WEk4MFBaaTEvNjFEZ24vYzNoZWJEb1RiaEF1WHptZzJ6ZlVjekhXZTRYOEd5?=
 =?utf-8?B?Z2djVjJSOEdrYUYyOS9MbWlCR1p3aE9SbEhuRU5IVlp1aWtXWHlLY0ExSExZ?=
 =?utf-8?B?ZklQSHprOElVVzY5QU8xUUE4R2VkOFFNdHlGR3E3VzAyVnNZZEppbHZZdEFJ?=
 =?utf-8?B?VzJ5KzhEZ2N5SjJQZkQweEkwQmp6N3N0UU1HMWZxNXhLaVZUc2YvMzNiek10?=
 =?utf-8?B?cUJZcTVXWmpPUzhrT2JObElpd3AwYmdlcnBDaXZzMmRIdnJCZXY0MmpkaFNp?=
 =?utf-8?B?aHQyMjdSWVR6WWJxTmZkbGNOYXVjb01DcnE3TjFXbWVHSVVKdldLeGM0UGxx?=
 =?utf-8?B?TXdET01rOWZaWXUwWFdDZnpkZWt0VjJHUk1IQU1uVkJ2TndZSU1xWHg4ckZQ?=
 =?utf-8?B?WG5JSXZsbytJaE1FZnMwbzdoTEFvdW43akRSWGFIUWFqOFN0dURlaU1zSmdl?=
 =?utf-8?B?MTJhZDdiODVRZ0k4SERQbWdkTWNXcEpKTEFqQ0Zmd2JLbDkwM3VwNnF2N25h?=
 =?utf-8?B?a3hpUFc1NVR2Mi9JMklPTk1oYzRPeTg2TVFTOWR4NVZlalBqZnpsa0hoMTYr?=
 =?utf-8?B?UzRXOGJtMDhrSVFGT2JDTHhnY0ZVbDRGZE9XRzl6Z1hsRzUwZFUwOXA5czR1?=
 =?utf-8?Q?1mSdM7lV8JKakhfb6zpRFxw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QkdVdTcwcldERUJlTDhBZEpLMEdkbDErdzFFZkhXM3RFanFmSWxvV1Z1L1Yy?=
 =?utf-8?B?RnJQMU5wNW8yTk0xNzBDVXdrMmVZVk5vaERzM3cvcXNsc3RRK0xuY2ZNcWlj?=
 =?utf-8?B?R3FaajRlUW5tTXdNZTc0K3dqUk51ZmlWQUZHeEdYR0hyV3Foc1gvN2pGN0JV?=
 =?utf-8?B?M0RoZkY0WDIxcTlHS1BRM1VZeEZ6THZ5Ym0zTzFHWjdrOEE3NmFqSHRWdU12?=
 =?utf-8?B?eEhMY2hqU0k5Rk9TRVNRUHpRUCt2QmRkWlIwWjNONEhpV1BDdDc5bnVxamVL?=
 =?utf-8?B?RTdzazEyRUtGWGlycFM1dGNCS2QvY09qMkFMTWZxclJSMkx1TGg4cE9aUjVa?=
 =?utf-8?B?MkpSL3pZRHRaSEtRZzkvcnU4TWtXRWhnRTZOaUpzQW5NTFE5Sk4ybFlWVjJy?=
 =?utf-8?B?OWtuS0dZT3lUWUwvNFZrbVBuTytyS1A2MTRMWVBLNHFPcGRVdDZhbUV2UWpP?=
 =?utf-8?B?NXJuczZDakdVTVJob0VZVzhVVkt6V0xmMy9BZDdkeVJYVW4xbmdjdytZdUVx?=
 =?utf-8?B?RTFKZTFPODc3N0djaW5tMWJzRjhhSkZXeG9vQXVaVDVFZytNQnJySDFXY1pB?=
 =?utf-8?B?dkwyV0c5VjVvMk5Fa2krd1BTSUhDWThVNjhKTEFISkVneGlBVlBtK1NIK2FN?=
 =?utf-8?B?TnVYN2VENnRxb0J5aUpuQmJrSFdPaEZnd0haR1RwQXhRZGIxUjZsempvYS8z?=
 =?utf-8?B?YlFWQ1VwMUZoSWFhSDhaMFEwc3hQVGhjTlZFVmpycko0Y2IzaWhmaVFON0ZP?=
 =?utf-8?B?Q0V4T3FBem14T05HZ2R0MGxoaE9PdXp0S0FFdU5IRXBob1dyZ0Qxc0VMbVh1?=
 =?utf-8?B?OXgwci9GSmR1eDdhRjNtU3pBb3hHWEZKYXhZemV0YkJpVEFtQWEvbmJha3c3?=
 =?utf-8?B?UERhV0dja0V3TExzUGk4cWpUN2xhUFFlOWFDWjFXc2Y1TUd2NnlDbkxYaCsx?=
 =?utf-8?B?TFFCRkRZTzJyRkdtamE3UWoxZ2grbllYTUFoRHRSTk9oSHczQUh1bElTYjlQ?=
 =?utf-8?B?b1o3czhMSGxJU1RtK2ovUFBwN2hBck93QkFsNFZPcEpJTE9OR2tGMk5IcGs5?=
 =?utf-8?B?MVN5WHdrRGJhWkR3dmZkdk1qdDRrUkZaUTFDY2MzdlJ6TUtBbnhkYXRxUnlx?=
 =?utf-8?B?MUFvR1h4Sk85Y2F5SUNGTVk3RWlDcXVWZ3U0azVTYXNLMFhGaXZjZkswbzVX?=
 =?utf-8?B?NGVqUm8rQk8xbnA4YWJoanpSN1U3UG1DZzFCekxac2I2NC9qakYzRzFGakUx?=
 =?utf-8?B?ZlBDbVZlcWJ5RlVWWlk1cE44cXAzbGREN1gwRFc0SE42NkZ1WW1KUDIyRmxP?=
 =?utf-8?B?Um5jbEhQUkZqVGlzd0lnTWVnUGFrSTQ4emhIRE5lZ0diNnlMTGFsTkJoSk1R?=
 =?utf-8?B?b3ZPYWkySnI2S0JvRi8ybTJ6ZEpKc0VHSmZWS01IQ2lxYzZHdFBLUHdpY3E4?=
 =?utf-8?B?TGNWRXUrSDNwcFFNTU9DVTJtRkZRZHl0eWpydEdHL2FDYTJqSnQ3UEczSEhY?=
 =?utf-8?B?UmQ3SHR4aTJJcjdnbTg2a2NhRkpUSUhKZmRvUFJpQWNISldWd0RpTnhnblU2?=
 =?utf-8?B?MjdpSkRSNmY0ZHhQYmh1OHdiZllRQ2FwQTYyWFpObHhoeTBaazhCVEtZaVRL?=
 =?utf-8?B?WHRiZCtWeFZTclZsc08wVzkveldZeWVIR0ZMOVdMdGltSTcweEpvOFRkcjBn?=
 =?utf-8?B?Skd6d0Jjcm1GMXJhaXhHMlV5REc3Tm5rbGhLREk1aFhQN3p1eGFuQlk1aFEv?=
 =?utf-8?B?ZUUwT2FUNytlRW95UHdaK0lvWXVwL0JvVGdkbDhwaTNhSHB5T2RNVWxjZWZB?=
 =?utf-8?B?QlQ4SE9rN0xBKzdZRFEyK2piTFNCOVdxMHVYSDJiZzFQeTVxendMdXphOE5h?=
 =?utf-8?B?eXRlZkIrTXY4eGNqWE5XOGRZWEJwN29SNk4weFg4Sy9jZFdSeTNPWEJLUisy?=
 =?utf-8?B?NG9LNndRSEM0Q2xvRk0ralNlaE8vWXpQNFduTlhBOXFxZ2l3TllxaC9aRWVD?=
 =?utf-8?B?NVBKeDV6QWduVW81SzZaRjEyeHNzTHpZTXhHemVlQitWUEhBdW1VZmVncnBr?=
 =?utf-8?B?TzFmQkcrQ0JWdDFLVWhoa2VhRjVCQThDZ1p4MnNBenJBUE96ZlArTkl6L3hr?=
 =?utf-8?B?Q0hRa0plQWtaeDREZnhwWG5yNWd2Vlg0d0U1NE5NQ20zZUl6Z3ZOV0s1WGdN?=
 =?utf-8?B?OW9jLzdORE11VGJiS3VocEhGR3VWclJVZ3o0L0Z4V25pbWtEeWgwL1QrS2RP?=
 =?utf-8?B?eEhOQXVxQ202UkNHYUZ2bkE5dE5PUnhoL3BhMVpNajNJdWpGYVlxU256VUhR?=
 =?utf-8?B?akNpTmxrT05nQWQ1MHlUVmk3dGlqaG8ycmZuN1VOTlJxSDZrNTFtUm1QSjhp?=
 =?utf-8?Q?exnM4qZlRsYvmY6xYjhbKC4cG/Pg3hYLtlvvut6dK4Edn?=
x-ms-exchange-antispam-messagedata-1: uiPlQrVFsyxSZA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225dff6d-6e9f-4cf8-fffd-08de571a5bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 05:19:45.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ec8QI3SKa9al/Sk5ag+3vg18DhvI301iTgRowCBuAyptW/6JuYgOZ+jezAF6C+R49wGePxvVGL81ZA31ryUtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFED9C9AC99
X-Proofpoint-GUID: 1fnkFgEEVSLAcvNY8p3Xv-6-WQExBO_H
X-Proofpoint-ORIG-GUID: 1fnkFgEEVSLAcvNY8p3Xv-6-WQExBO_H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA0MSBTYWx0ZWRfX2ixi0+ewC6Cc
 i5GBm4U1WvXCW57mz2ym0QezuNH+fwN/EQcjR7/nMqi8Uu089B0gh4PU9SIrHiZzo1Ybzj5d2Gb
 9EPGO+UYX9hYz4bgtwLjROa/o9Jg/50pSmD8jNGo0M+A12FiKsClhtwIvHUh/Ieg7d3hd7O7HtE
 kBoY7U/fq1YIrDPSpn/hGq57QlGLPNjAGHlIRrgaqecgWm9zh81+pHEKjELmg+KWrUN/n1smhPP
 RIvsM+MjM/OzcpbKeO6Shi2vRU6W9uNWmjheq8pS9cJv5xI+MazUo8EYlf877bGDcipg1PpCdje
 yiw7SQM4O4k8enGFdHF9gdhDEKftNkKZttODtOuTN/JUFFfEvDKMkZtDmTIqiNPd0nGb9WqrLmU
 FCVr1MgqDnGI5aPseha5TF36NaeOnPMBheqv1zt7v1Q4lp2pk6Lne/L53MCdUjk9dTu5yjDtzGY
 rsZ/Ks0EfjDiqUzbGDA==
X-Authority-Analysis: v=2.4 cv=DY4aa/tW c=1 sm=1 tr=0 ts=696dbef6 cx=c_pps
 a=8tq6Qs2DEm6oQ1m+I15oQA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8
 a=iGHA9ds3AAAA:8 a=ZWEt5nTRY_cYMjHj3PMA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190041
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 05:19:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3006

SGkgSm9zaHVhLA0KDQpJIGhhZCB0aGUgc2FtZSBjb25jZXJuIHdpdGggeW91LCBzbyBJIHVzZWQg
Jy1wcmludDAnIHdpdGhvdXQgZG9pbmcgbW9yZSB0ZXN0LiBNeSBpbnN0aW5jdCB3YXMgdGhhdCBz
cGFjZSBpcyB1c2VkIGFzIHRoZSBzZXBhcmF0b3IgYnkgZGVmYXVsdC4NCkJ1dCB3aGVuIEkgZml4
ZWQgdGhpcyAnLWQnIGlzc3VlLCBJIHRlc3RlZCBpdC4gVGhlICdyZWFkJyBjb21tYW5kIGNhbiBo
YW5kbGUgdGhlIHNwYWNlIGJ5IGRlZmF1bHQuIEl0IGFjdHVhbGx5IHVzZXMgbmV3bGluZSBhcyB0
aGUgc2VwYXJhdG9yIGJ5IGRlZmF1bHQuDQoNCkJlbG93IGlzIGFuIGV4YW1wbGU6DQokIGZpbmQg
Lg0KLg0KLi9kaXJfd2l0aG91dF9zcGFjZQ0KLi9kaXJfd2l0aG91dF9zcGFjZS9maWxlMiB3aXRo
IHNwYWNlDQouL2Rpcl93aXRob3V0X3NwYWNlL2ZpbGUyX3dpdGhvdXRfc3BhY2UNCi4vZGlyIHdp
dGggc3BhY2UNCi4vZGlyIHdpdGggc3BhY2UvZmlsZSB3aXRoIHNwYWNlDQouL2RpciB3aXRoIHNw
YWNlL2ZpbGVfd2l0aG91dF9zcGFjZQ0KDQokIGZpbmQgLiB8IHdoaWxlIHJlYWQgLXIgdmFyOyBk
byBlY2hvICJ2YXI6ICR2YXIiOyBkb25lDQp2YXI6IC4NCnZhcjogLi9kaXJfd2l0aG91dF9zcGFj
ZQ0KdmFyOiAuL2Rpcl93aXRob3V0X3NwYWNlL2ZpbGUyIHdpdGggc3BhY2UNCnZhcjogLi9kaXJf
d2l0aG91dF9zcGFjZS9maWxlMl93aXRob3V0X3NwYWNlDQp2YXI6IC4vZGlyIHdpdGggc3BhY2UN
CnZhcjogLi9kaXIgd2l0aCBzcGFjZS9maWxlIHdpdGggc3BhY2UNCnZhcjogLi9kaXIgd2l0aCBz
cGFjZS9maWxlX3dpdGhvdXRfc3BhY2UNCg0KUmVnYXJkcywNClFpDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBKb3NodWEgV2F0dCA8anBld2hhY2tlckBnbWFpbC5jb20+IA0K
U2VudDogU2F0dXJkYXksIEphbnVhcnkgMTcsIDIwMjYgMTI6MzAgQU0NClRvOiBDaGVuLCBRaSA8
UWkuQ2hlbkB3aW5kcml2ZXIuY29tPg0KQ2M6IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9q
ZWN0Lm9yZw0KU3ViamVjdDogUmU6IFttZXRhLW1pbmd3XVtQQVRDSF0gbWluZ3dfc2RrX2hhbmRs
ZV9zeW1saW5rLmJiY2xhc3M6IGF2b2lkIHVzaW5nIG5vbi1wb3NpeCAtZCBvcHRpb24gZm9yIHJl
YWQNCg0KT24gVGh1LCBKYW4gMTUsIDIwMjYgYXQgMTA6MDXigK9QTSA8UWkuQ2hlbkB3aW5kcml2
ZXIuY29tPiB3cm90ZToNCj4NCj4gRnJvbTogQ2hlbiBRaSA8UWkuQ2hlbkB3aW5kcml2ZXIuY29t
Pg0KPg0KPiBUaGUgJy1kJyBvcHRpb24gZm9yIHJlYWQgaXMgYmFzaCBzcGVjaWZpYyBleHRlbnNp
b24uIFdlIG5lZWQgdG8gYXZvaWQgDQo+IHVzaW5nIGl0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBD
aGVuIFFpIDxRaS5DaGVuQHdpbmRyaXZlci5jb20+DQo+IC0tLQ0KPiAgY2xhc3Nlcy9taW5nd19z
ZGtfaGFuZGxlX3N5bWxpbmsuYmJjbGFzcyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvY2xhc3Nlcy9taW5n
d19zZGtfaGFuZGxlX3N5bWxpbmsuYmJjbGFzcyANCj4gYi9jbGFzc2VzL21pbmd3X3Nka19oYW5k
bGVfc3ltbGluay5iYmNsYXNzDQo+IGluZGV4IDJmNmRiZTYuLmUxNThkMTQgMTAwNjQ0DQo+IC0t
LSBhL2NsYXNzZXMvbWluZ3dfc2RrX2hhbmRsZV9zeW1saW5rLmJiY2xhc3MNCj4gKysrIGIvY2xh
c3Nlcy9taW5nd19zZGtfaGFuZGxlX3N5bWxpbmsuYmJjbGFzcw0KPiBAQCAtMyw3ICszLDcgQEAg
V0lOU0RLX05PX1NZTUxJTksgPz0gIjAiDQo+ICBhcmNoaXZlX3NkazpwcmVwZW5kOnNka21pbmd3
MzIgKCkgew0KPiAgICAgICAgIGlmIFsgIiR7V0lOU0RLX05PX1NZTUxJTkt9IiA9ICIxIiBdOyB0
aGVuDQo+ICAgICAgICAgICAgICAgICBmb3IgcGFyc2VfdHlwZSBpbiAiZmlsZSIgImRpcmVjdG9y
eSI7IGRvDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGZpbmQgIiR7U0RLX09VVFBVVH0vJHtT
REtQQVRIfSIgLXR5cGUgbCAtcHJpbnQwIHwgd2hpbGUgSUZTPSByZWFkIC1yIC1kICcnIHN5bWxp
bms7IGRvDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGZpbmQgIiR7U0RLX09VVFBVVH0vJHtT
REtQQVRIfSIgLXR5cGUgbCAtcHJpbnQgDQo+ICsgfCB3aGlsZSByZWFkIC1yIHN5bWxpbms7IGRv
DQoNClRoaXMgd291bGQgbm93IGJyZWFrIG9uIGZpbGUgbmFtZXMgd2l0aCBzcGFjZXMgaW4gdGhl
bTsgQXMgbXVjaCBhcyBJIHdvdWxkIGxpa2UgdG8gc2F5ICJkb24ndCBkbyB0aGF0IiwgaXMgdGhl
cmUgc29tZSB3ZSB3ZSBjYW4gcHJlc2VydmUgdGhlIGJlaGF2aW9yIG9mIHVzaW5nIC1wcmludDAg
dG8gYWxsb3cgdGhhdCB0byBrZWVwIHdvcmtpbmc/DQoNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB0YXJnZXQ9JChyZWFkbGluayAtZiAiJHN5bWxpbmsiIHx8IGVjaG8gIk5PVFZB
TElEIikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiBbICIkdGFyZ2V0IiA9
ICJOT1RWQUxJRCIgXTsgdGhlbg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29udGludWUNCj4gLS0NCj4gMi40My4wDQo+DQo=

