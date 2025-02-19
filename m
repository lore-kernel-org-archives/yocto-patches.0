Return-Path: <douglas.royds@taitcommunications.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F99C021AA
	for <webhook@archiver.kernel.org>; Wed, 19 Feb 2025 01:26:29 +0000 (UTC)
Received: from SY8PR01CU002.outbound.protection.outlook.com (SY8PR01CU002.outbound.protection.outlook.com [52.101.150.78])
 by mx.groups.io with SMTP id smtpd.web11.12615.1739928387304719082
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Feb 2025 17:26:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@taitcommunications.com header.s=selector1 header.b=FMRrTA0O;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: taitcommunications.com, ip: 52.101.150.78, mailfrom: douglas.royds@taitcommunications.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJjMF0nd8I/2Ki8A2Ib/Qkw82uFxn3EewcTah702ur90s/OUFkwXWDehZSUK7m86pjIMZE5VWhQxiq8IR/ivw2N8Ndm596yhtYWvmCFQlL/+jpuwxcWZTqn64030cpSyv26F4sIGWiVu8LiARvqgPlOWeY9X2MElJn4WzO6z/g3kyzH9P43YJfWSSN7xZbHYwQVyQXjZGbuUKPeDgLyRxxgTcSqAMcGopfjzLmlTm3aCjxULytCkVzPm82iXGglYM/RJK4z7b48e9j7r38rs+RwaHDneYBzgPA5iWHgGpb3kgdHpssfSNEXuIZ8i8kfa1LXmnQfn3CWfXjUWwm8lAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k24txb5XUPtrFTRNeUTdfsLBlhBtu7V99EbqivBwJGw=;
 b=VGNijCmLmiBuvbjAAy7DUgMYE1uIKAuJ8319fZGbHxsHqKya0n3GXK0dKzkXnKDO3GvoUJ+fj9jUPFA7D/T8fz4qARICEbI7H0KRNJwnTa6rKKGESTxmPP9wmAAiK9jdb2lLLS4TEz8d/3HXl+mjigVfL2CuVs1HJIiOaDGDy74Knna86i4lk5fnEN+fOsALsyAtheVN7nqrOqCLQCpFjQgl1Ms3i+FcRtIxoFzG0fiqNaIqaUHmvvsOij/6Ejq/mkmyIYFq0VieL/HS9TFUH1TpL0n2OdQnJfNWlgwIFvJbvoQ/AilMP+6b89oxqDUMQFOEKu+DsC+TPx1DHcvHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=taitcommunications.com; dmarc=pass action=none
 header.from=taitcommunications.com; dkim=pass
 header.d=taitcommunications.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=taitcommunications.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k24txb5XUPtrFTRNeUTdfsLBlhBtu7V99EbqivBwJGw=;
 b=FMRrTA0Ouoo4kFBPJUArH/jCr9+b3DG1iQBS6FpkWPFQx4JBxmaMkK0xUIwuxflHl9YT1vqTJ0Q/fXQynJMHe5nivJX4o3Lvzynw6z3xjg5hYoPE7rbtXOS10hRyn5qqnOo2niWZtiVb94f7MDYAS/frRqby/8usLonekTtYkCa4uAlRvKkKnIKIQc87lxsAkHvslgu7CCtE+HOy/xhE046jUL7/ME3geBs/ZF7q76tIAoDIgtKDveJejEUkipUm/0ZgUM0IcF7B2yDk5cxks85zaMXxl69qQaPkuylSLuQecrZz9Xy05JuGJAFFX6W5S0oU+sm2jMw7nWahGFoLiQ==
Received: from ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:10c::10)
 by SY4P282MB1931.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 01:26:21 +0000
Received: from ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4854:ef86:5be5:d20b]) by ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4854:ef86:5be5:d20b%7]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 01:26:21 +0000
From: Douglas Royds <douglas.royds@taitcommunications.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-java] Issue of cacao
Thread-Topic: [yocto-patches] [meta-java] Issue of cacao
Thread-Index: AduCZ6VoCCyyKLONQkmHYtLFdNLtLwABSX1V
Date: Wed, 19 Feb 2025 01:26:21 +0000
Message-ID: 
 <ME3P282MB2531E2579509BA59013A585E94C52@ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM>
References: 
 <TYWPR01MB118615E9B023329FEAEB33BB4DCC52@TYWPR01MB11861.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB118615E9B023329FEAEB33BB4DCC52@TYWPR01MB11861.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=taitcommunications.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME3P282MB2531:EE_|SY4P282MB1931:EE_
x-ms-office365-filtering-correlation-id: 1ebe7591-c7f6-4edb-e0ca-08dd50846aa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Y1FsY1NMb3ZzZG11TTdOWTJ5UThUSmtEcUd1djM2L0lLOWZ2THhpZWs5?=
 =?iso-2022-jp?B?TmptTS8zUlYvN2FLTTQ4VHZkSWR0WVVUcUpmK1lPV09RMEVKVVZDaldh?=
 =?iso-2022-jp?B?VHpHNzJOKzRjS0sybFBmYW01MGd0Z0dJR2dSOHQ4R2tCRXEyTmg1NUtJ?=
 =?iso-2022-jp?B?cHlpMTVRTndRcVFrZlhTWmIrb0ZLbVR4SFRROWgvdjVzNGFHcmxaVDN5?=
 =?iso-2022-jp?B?cFZWakFOZTZBUTNuNTB6eXhYemdlT2VaaHpIYVU0L3ltUzR5TW5WOGN2?=
 =?iso-2022-jp?B?ejJKQkhzRlRFdVRPbk03ZTlJSGNKdVgxNGpSbndINWtPL0RCcFpaOFVO?=
 =?iso-2022-jp?B?TVlIc3BSK0hLa2pUZ1JKcmI5STAvNGNxNk5rb2VWYThobzQwME5zczVI?=
 =?iso-2022-jp?B?OExNYW5RM1dlanZZakRGcTFrY1dJSm4zNFhVd2MwRmpESnFwMno3TUIw?=
 =?iso-2022-jp?B?ZzlhejRXdStSR294RGF5d3dxWXJCeGYzVGNQV0dqNzM0ZXh3cmZ3YjlF?=
 =?iso-2022-jp?B?QWUwb0o5ZktERHRORTIzbEJrcXpZbWl3K2hnZ3IzamFEU3o4SjBOeHI3?=
 =?iso-2022-jp?B?ZzNYT24vbkZqSjR4bVN4Zzl0Nmc5S3BhZ2JIOTluWDB6K1hzRDRpbm11?=
 =?iso-2022-jp?B?QUQvZTZuQWRKSXZiMzhud1FuRC9PS3VpOFN5d1crVlVMVC9tUWRYZmZR?=
 =?iso-2022-jp?B?U0pManJpSDJ1S1ZUYnQ1WXRHTnZLeThSVmhYeSsyTEMvVnlqT1JzMm5v?=
 =?iso-2022-jp?B?emE5YWN1NWhyM0poL1pvR2l0L0JZeTFYL2hBN1d2eEZtcEFsTTk3Yzls?=
 =?iso-2022-jp?B?ZUdqQ3RySHdkZXArUVlubHNCSDEzNmxpTnFNTkpFTHROVk16T25jN3VG?=
 =?iso-2022-jp?B?Z0M4czYwVnlkT1FGUFRSVDdqOTIzYmNQMVllZEJneE5jMjc5NzhWQjlM?=
 =?iso-2022-jp?B?K3NFc05QbDFld0hvSHAwcmo0WThrZ1R2ZTRBQjJ1OXNrcVk2ZzhBSTN3?=
 =?iso-2022-jp?B?YldMamltbGdFZTRIRU9idFRua0FLcXdiNytzMDZESmhMVDVjZUNtam93?=
 =?iso-2022-jp?B?bml6dFRSU1FxWnNlRzZrVUwxNkVWVGV3L1IwVDVQN1YzRUxiTGVaMUxn?=
 =?iso-2022-jp?B?dHdNc2N2RlF6ekNRbTllaVVrckJNdHRhdGQxQmZLSGZqaTk2VmE4Umdv?=
 =?iso-2022-jp?B?dFY1dWQyUGdaWjFmekErcGtWMEkvanl4c29MWkZFNVE2dXBYcDQyL1V0?=
 =?iso-2022-jp?B?SzV1KzVoTEpZOGFXSEtrMDNQS1NGTVFXZVFVdHNFZlFOTVpmbFc2anVY?=
 =?iso-2022-jp?B?aitkNlJ4ODRlcWxYckhHSit4UnE3TkFtVmFydVkwYmhXenRVLzRUdUJQ?=
 =?iso-2022-jp?B?dDF4S2s1bDArWnpZWG9aVWhWN3dkSm1waFluZjZFZUlYd0E5WE5uY1R0?=
 =?iso-2022-jp?B?OGZGeUhsTnhnd2k0bWxOanhQOXFSSTRLclVtSFlwTUs1bDVnYjZUY1ZH?=
 =?iso-2022-jp?B?ellFUWFOc0w1ZTVxTG8rekhaSE1hZzg4ODBqc1lYOWxvMExjenhxN3hQ?=
 =?iso-2022-jp?B?cUNRVDZjQTJxM2hNTDFwamFlbGNlNm85KzVpWG5TMnlSV05ZdE9xUllI?=
 =?iso-2022-jp?B?cWxsOEl3Qm05WnpqYzVJZFh5ZmswNWx0Q09pamlYVlRCd1BFSzltYU9R?=
 =?iso-2022-jp?B?T0VLQXI2WHAxenNrOUtVeGpUazltUmNzNGFKdmgwa1R1NldkOXVDQkkz?=
 =?iso-2022-jp?B?VzVlYUdOZTM2aXhGNFo3T0phRXhFaVRzOG5CSlFjT0dEZVJpampSTGJo?=
 =?iso-2022-jp?B?M2hGYms1TWVOVm1Ca3pidWU1YlZWYW01Z3pRYWRXaXFteDdYd3BLN00v?=
 =?iso-2022-jp?B?bVREa3l5WmJBclRyaGxQbDRpZ29sNWVVTFA1TFBQSW11TGJacklyZmMr?=
 =?iso-2022-jp?B?QlZRZnh4U1pYalpCRlVOZmZFejZiM0lSMm5idGk5VS9rc1pXTU1Va3ZN?=
 =?iso-2022-jp?B?QWJYY2cwdW81U0dQblpuZE9xbytOOFBJaTF0Q2l1a3RlZ0xPd0k4dzN1?=
 =?iso-2022-jp?B?MStlalhmMVNsMGR0ZmtQZG5mK3dndHBkUnRhVzB1RHJ0UjhSS2NBU3hQ?=
 =?iso-2022-jp?B?THE=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RXdIeUVjMk9ybXRPWE9qS1JZVUkzcDExS0RjNDFwRkt3QWR5MzNqQkdT?=
 =?iso-2022-jp?B?ckN2OUtZNXp0YnJKRDlQc29hN0RranF5ZUdYdTRvY2ZwK2ZDZEdTN3pk?=
 =?iso-2022-jp?B?RVk3ODhCZDc5M1ZXeGlTQjkxM1FDeTdnMCt0Q0FTdDZqVlNqRitqVytG?=
 =?iso-2022-jp?B?eitqL2RjNEhVaGwrMWpNYStvNG51V00yMFBIRDZFM3VObVVWS3NxanlR?=
 =?iso-2022-jp?B?S0JtTmVFZW1GTnBmY2xadVk0V01oWlpzWHVzLzFOOHN6UExubEZaOTdL?=
 =?iso-2022-jp?B?anhLMExSRkVIZjU5VklOQjI0L3ZHemdvUWJ0WW91MDUxWkJzUXIzdk9W?=
 =?iso-2022-jp?B?QmZjUWN1RjhJN1NOakluQWE5ZFFuT0gxVldkWGFIL2ZyRVZIdkE0WWIx?=
 =?iso-2022-jp?B?Rmd2OWdFUUtwb1V5a0t0VlkrZDdwbGhQcW5kUC9XNFY1czFPcEdtdnZZ?=
 =?iso-2022-jp?B?RVo3dWczdXE3MlZDaEpPVC9pZlpLV2kyTnJqWDVnUm56cGp0aEw1MzRI?=
 =?iso-2022-jp?B?SmQwZ1ZYMW1pT3NmdHkzOU9jSkdPZ1JBbzBwZFR1azBZbjFzeGJESWZk?=
 =?iso-2022-jp?B?c1VCMHk4Q1AxOFNUSm9rUVZCODVjVlJnRmtqTDJnWXNpUGgzU2JFRHlv?=
 =?iso-2022-jp?B?N2tocTlIbFNOWlJJY0pTbTlKbE55eTJXcExRRzFXWHZLV0w0WXc0MG4w?=
 =?iso-2022-jp?B?MG1nUFZDK3UwMk5WNUZEWkc5d2JoWWdIQkU1UnJkVHFzeTNDTExQd3Yw?=
 =?iso-2022-jp?B?c2g1cHdqa05xRm5vNnhRbTBCWUlYc1dveXA2NGx5cHBTMjR2Y0FxeTMw?=
 =?iso-2022-jp?B?Y1I5MUtJMlhXU2NNeSsxd2dBRjVFTlNTUGtrMitKTSt0OFNpdnlUcGlr?=
 =?iso-2022-jp?B?L2tCRHBEREhxRUxKaUx6ajdueVVKQ3RYNko1bklqczJTOFNZcVNUL0xQ?=
 =?iso-2022-jp?B?UTNTU2k1SXhFVmpTT1ZmWXd0QVo0bjZZRFVqa2RHOGZMSUE4b0NxcjVw?=
 =?iso-2022-jp?B?dnpQRm9TWm5sY3c1Z0xhMGwybWpPclpmOW1pbVNhVk96SGFhSEMyQzZI?=
 =?iso-2022-jp?B?ZHd6Q204M3ZuZDNSejZsVTgvT0pGOVh3RVFWK01MejlPeUl6ckdxMjNS?=
 =?iso-2022-jp?B?MS9FdGZlbVhnd29ZY0JQNko0NU1iaDJBdzYrUytBS1VncjZNWkRiWUxv?=
 =?iso-2022-jp?B?aU9hRUd0VkNMTy9YMjh4MUFaZHhabFVRY1QySDB1RUo3L0RDMXVlRkdj?=
 =?iso-2022-jp?B?TW03M1dhOE1NNnYzaHJGTVpCeFJvVExqa1R2V1BxTTJYRjdrSitRUFEy?=
 =?iso-2022-jp?B?NkQyeUJvalo3cnhrTnRjaExnVGZkZzd1blF4cGF3VmlvZXZSajZSTCs2?=
 =?iso-2022-jp?B?R2xJbGtUMVVodUsvZzdkOHdZNjNUWUdvbWRRTUlITjluRlFsWVM4MWd3?=
 =?iso-2022-jp?B?cnlLV0E5ZUphVjdhbHFlZC95eVJ2OFlHZERRYUxIMktGTGFwbkl3aWFj?=
 =?iso-2022-jp?B?SkJkc2pIMXNmM0xZRm5OSUJtMyttMm81Tm9NdTJaSXc3SUFTSVBZd2R1?=
 =?iso-2022-jp?B?alVqOTRhamNpY0ZhR0h6SkRJS2lhYWplZnhrNnAwUWU4SWx3b3VNN09Y?=
 =?iso-2022-jp?B?SnRDNGRHR1QyL1duN3RSVWxydFBQeVN5Um94UTBjN09HcVpnaVNOUTR0?=
 =?iso-2022-jp?B?YklsNWdVa0lMdWhoV04rOEk4RVFjNEhVYWE0RkFmUmNhUDRjU1hWKzND?=
 =?iso-2022-jp?B?VmNYTXUwaTlyMktnV2xQeDg0ZUFSWUswWjIxT1lDTTNJNVZ2NWZuZEdT?=
 =?iso-2022-jp?B?aERybzVlQVpZYUtVT2hWZGpONlAwRzBBcWxTUHdoaTIvbzZzZHdEWkFE?=
 =?iso-2022-jp?B?RFZQQVROeWlnQm0vSXM0VUx2RW8yUDhPVVptWDJvcW55bW13b2hKSXdP?=
 =?iso-2022-jp?B?SWVVSWFKOW95OVlSVy9sTlVhZDhrYmpnTmFCd2UvYmFxaWVEVXlXYmZh?=
 =?iso-2022-jp?B?NmFFajlsbldjRXdJTVZ6eURoanhqUjRnUER1UmQ2TC83cVZ2ZnZUeUdF?=
 =?iso-2022-jp?B?V0ZiMkk2RTRveUZHRS9UNzVWMC96UDlsRFVzTU40bUl1dmlxdml2VW1I?=
 =?iso-2022-jp?B?N2hFTklQUnhuVXhGaFkvaTVHajhwSEozNzRyNk5zK3ZpU0dSV2dtVmNN?=
 =?iso-2022-jp?B?RUgvV1BYYVBnOGtpQThkSDZ2TVdKclRsRXF5WStrZXJmdHphQnNEMTUr?=
 =?iso-2022-jp?B?U3lQODJlUVZRVWFleHJqMEFJUmFSRjdQTlFWYk9SQUNtYVQ3Z0pkQ0Vo?=
 =?iso-2022-jp?B?eHRvSCtIcm93eUZiMTl4WkVrV3FLM2ZYOVE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_ME3P282MB2531E2579509BA59013A585E94C52ME3P282MB2531AUSP_"
MIME-Version: 1.0
X-OriginatorOrg: taitcommunications.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebe7591-c7f6-4edb-e0ca-08dd50846aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 01:26:21.1367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b9ac1691-179e-406f-90a3-6d5b9a817466
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUdnJsY5yT819KeVIFXOVNLOgBR5BLYDnal8ZfXyH0qLLbj66ZKpdOe8QauNgAOszBqgD9xTBv2L3BpQDVgj+/Cx6HCx/juE1Ty5HK4B6yM+BkWJko5WNNGh8HrhCSVk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1931
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Feb 2025 01:26:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1091

--_000_ME3P282MB2531E2579509BA59013A585E94C52ME3P282MB2531AUSP_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Yes, you will need this patch, which hasn't found its way into meta-java ye=
t:

  [PATCH 2/2] cacao-native: patch to be buildable with gcc13<https://lists.=
openembedded.org/g/openembedded-devel/message/113906>


________________________________
From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoprojec=
t.org> on behalf of wangmy via lists.yoctoproject.org <wangmy=3Dfujitsu.com=
@lists.yoctoproject.org>
Sent: 19 February 2025 13:46
To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>
Subject: [yocto-patches] [meta-java] Issue of cacao

When executing the command bitbake openjdk-8, cacao encountered the followi=
ng error:

/usr/include/c++/13/bits/stl_list.h:2031:37: error: no match for =1B$B!F=1B=
(Boperator!=3D=1B$B!G=1B(B (operand types are =1B$B!F=1B(Bstd::__cxx11::_Li=
st_base<branch_label_ref_t*, DumpMemoryAllocator<branch_label_ref_t*>

::_Node_alloc_type=1B$B!G=1B(B {aka =1B$B!F=1B(Bstd::allocator_traits<DumpM=
emoryAllocator<branch_label_ref_t*> >::rebind_alloc<std::_List_node<branch_=
label_ref_t*> >=1B$B!G=1B(B} and =1B$B!F=1B(Bconst std::__cxx11::_List_base=
<br
anch_label_ref_t*, DumpMemoryAllocator<branch_label_ref_t*> >::_Node_alloc_=
type=1B$B!G=1B(B {aka =1B$B!F=1B(Bstd::allocator_traits<DumpMemoryAllocator=
<branch_label_ref_t*> >::rebind_alloc<std::_List_node<bra
nch_label_ref_t*> >=1B$B!G=1B(B})

This issue occurred after upgrading the compilation environment to Ubuntu 2=
4.04.
The upstream of cacao has not been maintained for a long time (the last tim=
e was in 2020).
Are there any plans to make modifications to cacao that are compatible with=
 Ubuntu 24.04 in the future?

  --
Best Regards
---------------------------------------------------
Wang Mingyu
FUJITSU NANJING SOFTWARE TECHNOLOGY CO., LTD. (FNST)
No.6 Wenzhu Road, Nanjing, 210012, China
TEL=1B$B!'=1B(B+86+25-86630566--8568
COINS: 79988548
FAX: +86+25-83317685
MAIL: wangmy@fujitsu.com

--_000_ME3P282MB2531E2579509BA59013A585E94C52ME3P282MB2531AUSP_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Yes, you will need this patch, which hasn't found its way into meta-java ye=
t:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; <a href=3D"https://lists.openembedded.org/g/openembedded-devel/messa=
ge/113906" id=3D"LPlnk504558" title=3D"https://lists.openembedded.org/g/ope=
nembedded-devel/message/113906">
[PATCH 2/2] cacao-native: patch to be buildable with gcc13</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;yocto-=
patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoctoproject.org&gt;=
 on behalf of wangmy via lists.yoctoproject.org &lt;wangmy=3Dfujitsu.com@li=
sts.yoctoproject.org&gt;<br>
<b>Sent:</b>&nbsp;19 February 2025 13:46<br>
<b>To:</b>&nbsp;yocto-patches@lists.yoctoproject.org &lt;yocto-patches@list=
s.yoctoproject.org&gt;<br>
<b>Subject:</b>&nbsp;[yocto-patches] [meta-java] Issue of cacao</span>
<div>&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">When executing the=
 command bitbake openjdk-8, cacao encountered the following error:</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
/usr/include/c++/13/bits/stl_list.h:2031:37: error: no match for =1B$B!F=1B=
(Boperator!=3D=1B$B!G=1B(B (operand types are =1B$B!F=1B(Bstd::__cxx11::_Li=
st_base&lt;branch_label_ref_t*, DumpMemoryAllocator&lt;branch_label_ref_t*&=
gt;<br>
<br>
::_Node_alloc_type=1B$B!G=1B(B {aka =1B$B!F=1B(Bstd::allocator_traits&lt;Du=
mpMemoryAllocator&lt;branch_label_ref_t*&gt; &gt;::rebind_alloc&lt;std::_Li=
st_node&lt;branch_label_ref_t*&gt; &gt;=1B$B!G=1B(B} and =1B$B!F=1B(Bconst =
std::__cxx11::_List_base&lt;br<br>
anch_label_ref_t*, DumpMemoryAllocator&lt;branch_label_ref_t*&gt; &gt;::_No=
de_alloc_type=1B$B!G=1B(B {aka =1B$B!F=1B(Bstd::allocator_traits&lt;DumpMem=
oryAllocator&lt;branch_label_ref_t*&gt; &gt;::rebind_alloc&lt;std::_List_no=
de&lt;bra<br>
nch_label_ref_t*&gt; &gt;=1B$B!G=1B(B})<br>
<br>
This issue occurred after upgrading the compilation environment to Ubuntu 2=
4.04.<br>
The upstream of cacao has not been maintained for a long time (the last tim=
e was in 2020).<br>
Are there any plans to make modifications to cacao that are compatible with=
 Ubuntu 24.04 in the future?<br>
<br>
&nbsp; --<br>
Best Regards<br>
---------------------------------------------------<br>
Wang Mingyu<br>
FUJITSU NANJING SOFTWARE TECHNOLOGY CO., LTD. (FNST)<br>
No.6 Wenzhu Road, Nanjing, 210012, China<br>
TEL=1B$B!'=1B(B+86+25-86630566--8568<br>
COINS: 79988548<br>
FAX: +86+25-83317685<br>
MAIL: wangmy@fujitsu.com</div>
</body>
</html>

--_000_ME3P282MB2531E2579509BA59013A585E94C52ME3P282MB2531AUSP_--

