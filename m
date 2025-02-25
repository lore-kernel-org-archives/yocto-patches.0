Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF1EC021A4
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 00:08:02 +0000 (UTC)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
 by mx.groups.io with SMTP id smtpd.web11.94.1740442074493871289
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Feb 2025 16:07:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=HGbT+vod;
 spf=neutral (domain: fujitsu.com, ip: 216.71.156.121, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740442074; x=1771978074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bMX78e8jXgzTpbGF30Gjx40iKdVuD24BydJDnxozRoc=;
  b=HGbT+vodm9q5CiSLnlyqJKcKWopojSpzibidHNCeagKR4UzJ20Wn59os
   DQD7yKOElrWsZnfhN1aFj3EfYOHNWHzOwQB6GHoxU+f08GcNWy4cvYbyW
   NJr9OzFq8aPJFdRy9l6gY3f6qxwAx7R94xLCggIqsOaopk7EHZlEPnOXS
   zIcc3NvHl4eB2/5ECw8V2csrLbTOTtDLtawE8RuB+pAIu/bpvuNgI7T5z
   kzqYtJmc/RQFKMjXUB90WltmsrC/egrztDs4pdzLdxj6K6QsHIsLW4aLx
   wgPyXffIxse9jOFWBP/ZWQM7A32FOoyQPNcOgSQIZAdNaUCI+Xyzy75R6
   A==;
X-CSE-ConnectionGUID: L4syk6CfQKeaNxgGlR/bUw==
X-CSE-MsgGUID: Gt/1RsqYRguVRKR0GecGHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="148272727"
X-IronPort-AV: E=Sophos;i="6.13,312,1732546800"; 
   d="scan'208";a="148272727"
Received: from mail-japaneastazlp17010004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:07:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4TAx/PIw1Iz4a30rg0Pd57DVQ+qSzsa0MmSBlbsfU6HpGo/8ZHMuuaQ9F7Yqjw2XfG6ey9DrX+2Qa4BYRstU4B1P4f3dZqPnc1hdMEPHYw7ZhIII2T8OzW4WEmQSjd/IQKoTCrsrNtN25pQ88T3yW9YXVQ+hPNLDBqR6qCF23MQdd0v4GkbWsH0jN1WooH/fj6Pw4d+vzcgxDMk7i+cSidzRa0LK1v3cyRa7PVEwF4RbGwolTFsAJcvivK0i4NXh4iqW5FKw15hoLPhuY9xgaODiHT1dFlDnxZtkDolNqMKQEJSkDzm7OdBjId+5mvtjlT8DgekTnwLY5zXBPcyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMX78e8jXgzTpbGF30Gjx40iKdVuD24BydJDnxozRoc=;
 b=UL2tycpzKDEmklg+iNUU3cUcbQCK4kZw7UIDVCDX71E74Cuy1yrapF42KeBAEKxQCBFz3eIfkxVRngHidfX8g35UUEbZtA/YBWbvhlSjTdk3xqx7bjQzdURDJSC3lRMFC3y6mLPHkJrdsWVLFA7Q4isUNG0HciPdN17R9SNMSY+Iqd/x/HzG7vvF7UE1LLe7tofrMd4d5KbXqwMzOnIp9uG8QPt1sl3volpuPg3T9+dOiitB+v0aQGk3kPGgDoFvkyBC1Z3NhY32HOQJzxGmTLjmt4+nWMI7Wpsyhlud0aKfQ/M/QdTvUNpzVfaqYr2J1wffJ+dUrTAZzcbt+HlOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 (2603:1096:400:3fb::13) by OS9PR01MB12511.jpnprd01.prod.outlook.com
 (2603:1096:604:2f7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 00:07:47 +0000
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342]) by TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 00:07:47 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "douglas.royds=taitcommunications.com@lists.yoctoproject.org"
	<douglas.royds=taitcommunications.com@lists.yoctoproject.org>
Subject: FW: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status in
 patch
Thread-Topic: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status in
 patch
Thread-Index: AduEDy+sEghkbMChQESqJcifNyWPJgAAxogAAAnxstAAAafPAAAASvSAALWo+0A=
Date: Tue, 25 Feb 2025 00:07:46 +0000
Message-ID: 
 <TYWPR01MB1186165529189A686A024207ADCC32@TYWPR01MB11861.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <CAMKF1sqJ3MS8gnN8gv1AMLNNZt=UEXtzXyQim-5TA+H9funFUw@mail.gmail.com>
 <TYWPR01MB11861B276559403A8AA76A8EFDCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <49dec7e116d95938712d10e4d76b78ed2df01ca9.camel@linuxfoundation.org>
 <CANNYZj-RPuuU+Ub5d0VBz7gmqg-LEB-yKN9dkJL8Qp-2UY2K1A@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-RPuuU+Ub5d0VBz7gmqg-LEB-yKN9dkJL8Qp-2UY2K1A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=6cb49864-0a6d-4502-b64f-5e6c396f7c1f;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-02-25T00:02:08Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11861:EE_|OS9PR01MB12511:EE_
x-ms-office365-filtering-correlation-id: 00ff3ad1-c654-4346-da4c-08dd55306f4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|4022899009|376014|1800799024|366016|1580799027|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?gb2312?B?OVI0Wjh3RUV3QXU1bm1sNWdheHlVVHRPdndGRDcvTmdLWWtFM3V0bzA1OXha?=
 =?gb2312?B?UUhZKzVmRkFWSkpidEdZTlAwU2ZjZkcyT0kxR0w3MjFMYmhyaUVSZ09FY3Zw?=
 =?gb2312?B?cklvbG0zU1AzSzlpTkMvTng5eXJsY2Z4cGpBQkhmOWVKMmhZWnluSEIwdEpJ?=
 =?gb2312?B?TDhleVM2a0RmRVVvWEZ2NTdVdDFFYkxZVW9pckZoREFnTHZhR3cvTDR1UWpa?=
 =?gb2312?B?MElOVkoxSTVCcDlJanAxd3JacTZnVC9yL3dDT2VHcjU1bnhDY3cxbjU4Z0h3?=
 =?gb2312?B?dUNjaUpHaTNmTjdSam9XS1UraEtOTFpZc2pmSTR3anlBTGZJWEt2OHNOK25B?=
 =?gb2312?B?VjBrRVdDWlVIY0pwK1JZdERNaU44c2ZWa0dxUWNJSytsS3hHSjhRdktuSnFD?=
 =?gb2312?B?bkxHZ2lXQ2lQdm51eEpPM2FSSzRBRElneTQvbWJaSHJ3UldDRXFLNWdoaTRp?=
 =?gb2312?B?VWxtdTRjbDB5M2JrdDdJSUp1ZzVYcUszZ09xMVlWTm5xQTdMNkNoOHcyM2N6?=
 =?gb2312?B?OG9iSjVhU2xZNXZFMkpacWltS3BnVHFRbXZmdHB5SnJ6ckprRk5nYzNScHFU?=
 =?gb2312?B?QkJtQ0Rlb21mSGg1THJjdUNwV0ZXWVdHT0wwbnA2bmNMY1FvRE1Tb2xKdGR5?=
 =?gb2312?B?bHNlSTg4NU82bUZjTmh0eS95cFgxZHVwTm1iU0dUNWJjWDVJUWcwRWhtcjdt?=
 =?gb2312?B?OHJaLzhITFUySVJKWlRSQ2RveGRmWjJJS2RzSmdBNDgweVlGRm80TTRPSDVW?=
 =?gb2312?B?dCtIWldjMnhjWk1FcVFRbWFQQnZDZ3cyZEx3b3dzRzJ3TEVCc2tibi9LTXYz?=
 =?gb2312?B?TlgwYjlxTjB6ZmxNaWw2NjVIL05sMW1oMWtXaHMxTWMxaUZsdG9PVEtWazdw?=
 =?gb2312?B?RTFrUVdNaWdMVVFYbE13T29QMzBlM1FVS2Q3VFZkcS9PQUlMK1RQOTFBMmhH?=
 =?gb2312?B?d2tZR2hCNlJyelI1Vmc1aFM4TzBMamxucDQrN2JHVVU5eHlXc09Zci9ybnZY?=
 =?gb2312?B?NVRpS1l5ZDluSngva1V2ellDeGFFWHRRSmtZMzVQNmV6UCtqTDFyYzdldmRY?=
 =?gb2312?B?NzVHbzVkYmZ1d3BZV2lRZUNmcFJxRXl5V21NekppWFZXQTF6b2hiZWljNUli?=
 =?gb2312?B?UENGcGRSQ2p1d3N4Lzlvam9pWndvZE5VTm1NRGdNN1BSNmJOWk5BMWp0NDZB?=
 =?gb2312?B?b2FVVDdVVVZCY1Y1N2xnVkc5RHNINXFpQW9IWXR0RHZpWGdWL0xOcUdLOXRj?=
 =?gb2312?B?akNFdUJUQllFWUxKWk9Qayt0czI2cVZJK1RUVXNFU3R2Q0ZlUU8xeXM1cmFX?=
 =?gb2312?B?RHlVckUzZDFVL2V6ekFaR1VKZnZIeDIvT3FKWG5pd2swWlJOeU9wVVo5cU45?=
 =?gb2312?B?KzB2VUpCbkFaTXNxcFV6RXczWGZXMTFkUktVYmNDM2hvWk1qQkZ2S2twTmJG?=
 =?gb2312?B?aWQrSE9leGxKVVZBU3RLdGErQXJTamlveDZ6RGtsVEkyd2NDMzZxTjJUZzFU?=
 =?gb2312?B?dlRHV2N1SHQ4WHh5aytaYkdHYldHQmNsWGtPUUFoeW81bVhnUzdmRktMNkJ6?=
 =?gb2312?B?QlZEMmV1RUNWVi9yU0ZwVUdyQng0ODUzQi85NzdDSkhMSlRPRFdyS2NLK3Ax?=
 =?gb2312?B?SkpScG9NNFNYcE5WSmtmQ0w3R0hBemtlZHcwdTlaZmYrak9hSzN1SGJwK1NJ?=
 =?gb2312?B?bkF2RWpKNUxDTEhVZjNwNnR4MGNVVTRCYi9zSGtreHpZNzZOMnhXNm8zbi9U?=
 =?gb2312?B?eHZkeXN6b2VmeUVXK1lwTTY2amJWR3ZjcWkxK2IxRXpkV3FtcDVFQUZHdFN4?=
 =?gb2312?B?WW4vVE5RK0tkNkV2ZVdpQjRaa1NvOWsvUDQ2ZDYrdnBmV3RybHVCakVnYVhp?=
 =?gb2312?B?TjU0QzFRcnNmQ2hKSDZrMFowT3NCb1VFQ1hYaFBQbEhHZmRtNlhiKzA2V1Vw?=
 =?gb2312?Q?IL1+/UgQGEI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11861.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016)(1580799027)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?Zk9teFFNNW14eXgrK0dHajRadVY3eWpXY1djbWhEYU1zYWxXMm14Z2Vnc0lX?=
 =?gb2312?B?QlpRc1Nuc0VhenN5NzB5cVkrT2pkR2cxMHpweWtkQ1o4YjZzVFlVbDJSUUEr?=
 =?gb2312?B?YUl6YXYvY0lOcEFTUnNra0t3SHZXSUo2Zjc3TE9RbS9xb2U0czRnQy9iem1F?=
 =?gb2312?B?ZFpUSlkrR2Y2MEFvcHR6NDM2SXMrb1BtK3F6dmtCVkJIZkxCaEpJWXdMY01q?=
 =?gb2312?B?UXBPQUJkUzF3OHV6a3R6em9sYW5ueG4zcXlmUTJzVFJFRnVpSHB2ZVhqUGYw?=
 =?gb2312?B?SVA2VFpXNW9qQ0luS0hYVE9Ia2t3ZjQ4c3pGeFgva21QdTZrL0hHbVJDb3JT?=
 =?gb2312?B?aG1NUFdwNnIxajVvWjZRS21oQ3doSWx0a0NDc1FyYWpGQ2ZiQ1luc3JFS3Fz?=
 =?gb2312?B?SWNnV3RTR0MyWWk2UkNRTFc0OXE1bHlpZldOaTc0SW5aMEVndnIxMlpoMmVU?=
 =?gb2312?B?aTBUZzh2M1I5TS9IcnNLRERBa0JmS0xhSG9paXhYbWFvWUdCKzh4VjVRd0pZ?=
 =?gb2312?B?RndUVmhnclI2OEc3V1k1L2tKc2hpbU5kaXo4L0k5TTNqNjFHdEhwa1dyK0tC?=
 =?gb2312?B?OUI0TWNuc05LNzdpUWo4M0dMaDRFTWRadVBjN3ZtK2x2cE53b2tMVDBIcWp1?=
 =?gb2312?B?ODRZSTk3TlkzL1EvclVQL2t2aFgxWWNrSXZxZ1BhUENzaWtyNVJkTjRMQk9U?=
 =?gb2312?B?N0xJRjZtbG5RblJZSW04Z015Q21mekFZWnpLNllqWTVrL1VsOGZrTVR1VmR6?=
 =?gb2312?B?QXRrb2lNR0c2VjR3WFNqSkIzV2VGMlYzakZ2eVRjTHJnaTZLY1pQZjNOYk9L?=
 =?gb2312?B?TW1WVFYxR2pGemF1WWVNdXRzaGxmTVFOVFppVmRWUFRPYXY0WmVFQlU4S2xt?=
 =?gb2312?B?UTRnWWc1Rk9yeVhOOWhCMWtDVnd1elM4aDZVSFpUNk5XdWhxN0xCNzhOWm5P?=
 =?gb2312?B?ZDJwYmIwQ2NEWkpCM1huZnA3a0xYaFZTRGdJbzY2MVkwRTVTakxacUs1cGxM?=
 =?gb2312?B?ZzA3MWJpRnl6cFNkL2k2Y0UwYVVFVzhiMmduS1p4UlJxU01rY3l2eWYzV0hB?=
 =?gb2312?B?UmIvS1lDMUpBZy8zMEJ2L3hqSGF3QmJmbXdRR1V2Z0hnS25oWUh3bkNUVTIy?=
 =?gb2312?B?SVB1K2F4S1pjaTVDWkxvUXJIb212RkFYUVNQQkRKYlV0T1RpamJPeXE4cHd1?=
 =?gb2312?B?STU0YkpOTTRJR08rNkVsZGtyR0dsM2RqTjZaNnlsTzA5a1ZnRDg3cXFEWUcr?=
 =?gb2312?B?NDBxeDlLblBvSWw2Sk9MZ0x3MTUvUVRsNFNGMEk2TEJRUHMyNzhwaUJLVlVF?=
 =?gb2312?B?WHVFVmlSLzFMK3lzYUdNU2xjdXFNMU9pSCttcVV1RHZkNnNJSGgvWnU3VDQ3?=
 =?gb2312?B?bXVoV1U0REk2WkhLTVBHMGRYYzRKTS9qM21JTUc3SDZXQlUxTlVPYVhUay8y?=
 =?gb2312?B?UjluSk91MEZqbEpzTUZVNXdYVjRUdHF5T1lMWldyYUVJYWRGZFFUc1FTdTBs?=
 =?gb2312?B?TEYwRm1YMjhxTGtjcFIxQ0VsRVFJUmx2MU5lbVlJUkNHWk1kVVRGWU1YQmNq?=
 =?gb2312?B?dGNKQ3hzWG01eWczVFFSWENub2o3OG43NXliQVYrRm9ra0VDTm5SRURjbE9S?=
 =?gb2312?B?VSszL0t2VGRwWE1td2NuMnNwdXNKQytOOXlTK1BuUUhZTnoxYVozMjlsUnBH?=
 =?gb2312?B?Y3hlOWxERUhzMkEwQ2trOTdCemlTM1FkNitZZ3lEVll6cG1uSVE1N2JMeGxr?=
 =?gb2312?B?dlFwVnJOdUttNVU3VHNhVnY4bTZIUzdiSVZ0bm5TVzlQNzlxMHZJcmtGTXdN?=
 =?gb2312?B?eG85ekNvSTZ5RnJ2VEJqVHA1UTJTeERMNHdNYmpaU3ErWHhMd0ZaOWpTYmJ5?=
 =?gb2312?B?Q2hIbDk4REdxc0wxZ3dISThOY0sxQ1g3U2pRMXB4OWxUS2xsUy90NUVwd3Y4?=
 =?gb2312?B?U2VWRE1pZ3U2WmQ4cnNodW5qeXJ5NDlja3ZNalFrV3lWOFV0a1poT0FRMmJM?=
 =?gb2312?B?SngzcHBpaExyQjZCcllnY1Vsa3BtZFJxdE1UTTNQbkp6b1VTRVpsY21GQmJk?=
 =?gb2312?B?K1k3Z1N5R3JLWmlaSEE4NDNrUCszdGZHQm5hSGJPanpocmdKV1VGUU9lOWpR?=
 =?gb2312?Q?UjWY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	txk02CIa9uhu2WsVN2jtKHJSKcGlsF9aG9SND26c5MENIMknr05EwKsyHEWpKZeokzrXgw1C7oDKGD73z6oWsFOA0IXaJ2RUbiWVDIUEUT+ZcNXg6X0isnAAJsSMJ88hgnC9rXNMcsy86z7hJNx+ot86PGloThaWWBimlLHI7bNP+/ElUcf4dLy+KSyVmWjiR56mtL3KDAcY7Xs8RPLpvvz1iX+iIIzb0qy8Rsk0aZeQIFcnIIfLuM6BErgFjJqqye9S6Fsypzdtuaugx8Cs/0v4Asx538xk7VO4cTnMV2I2qN8+mqB7OnlmanuzfORLHWWwZ8b4KWAkfZD+1jH8PlYQ20h1rG83xVSYMbwuOyX/oWvgNRZH0jl+K+xTVUO5JfwXGRoZcvMu7quRA18nXL4djwR6gUV+jh0kfqLO0g/Ilqg2TuTQTpAlZOBWUL2WQWkbJqe498Im6uMTSpB3v2ZeZ+VDgwySevmFcp2cWHW3V9KWcCY/DDzPqvyun9YkJ/3GWAp95B1ixud7GNme1RQS3kzQ9CrK6W0ewpt/KeRsWxNIdxfYvGrhFWwRNnl3I491SXeMnp/0Xvtfr0DXdPd5uhLjK45jbrtGU6iKnWiNfzUZBikuNYB01r3SEcTt
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11861.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ff3ad1-c654-4346-da4c-08dd55306f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 00:07:47.0122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zj/+gRmm2OHUPbEfm/JU+t7TON6luRg/KY4Zo55I8s4o02i2tsSv5OewRFcssDVhdklNavYNRKV5tmk0WksAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12511
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Feb 2025 00:08:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1125

VGhlcmUncmUgbWFueSBwYXRjaGVzIHRoYXQgaGF2ZSB0aGUgZm9sbG93aW5nIGVycm9yIHdoZW4g
YnVpbGQgdGhlbToNCmRvX3BhdGNoOiBRQSBJc3N1ZTogTWlzc2luZyBVcHN0cmVhbS1TdGF0dXMg
aW4gcGF0Y2gNCg0KRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIHJlZ2FyZGluZyB0aGUgVXBz
dHJlYW0tU3RhdHVzIGVycm9yPw0KU2hvdWxkIEkgZml4IHRoZW0gYnkgYWRkaW5nICJVcHN0cmVt
LVN0YXR1cyIgdG8gdGhlIHBhdGNoIGZpbGUsIG9yIGFkZCAiIEVSUk9SX1FBOnJlbW92ZSA9ICJw
YXRjaC1zdGF0dXMiICIgdG8gY29uZi9sYXllci5jb25mIHRvIGlnbm9yZSB0aGUgZXJyb3IuDQpP
ZiBjb3Vyc2UsIHRoZSBsYXR0ZXIgcmVxdWlyZXMgYSBsb3Qgb2YgdGltZSB0byBmaWd1cmUgb3V0
IHRoZSByZWFzb25zIGZvciB0aGUgZXhpc3RlbmNlIG9mIHRoZXNlIHBhdGNoZXMgYW5kIHRoZWly
IGxhdGVzdCBzdGF0dXMsIGFuZCBwcm9ncmVzcyBtYXkgYmUgc2xvdw0KDQogIC0tDQpCZXN0IFJl
Z2FyZHMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KV2FuZyBNaW5neXUNCkZVSklUU1UgTkFOSklORyBTT0ZUV0FSRSBURUNITk9MT0dZIENPLiwg
TFRELiAoRk5TVCkNCk5vLjYgV2Vuemh1IFJvYWQsIE5hbmppbmcsIDIxMDAxMiwgQ2hpbmENClRF
TKO6Kzg2KzI1LTg2NjMwNTY2LS04NTY4DQpDT0lOUzogNzk5ODg1NDgNCkZBWDogKzg2KzI1LTgz
MzE3Njg1DQpNQUlMOiB3YW5nbXlAZnVqaXRzdS5jb20NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZyA8eW9jdG8t
cGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YgQWxleGFuZGVyIEth
bmF2aW4gdmlhIGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNClNlbnQ6IEZyaWRheSwgRmVicnVhcnkg
MjEsIDIwMjUgNToyMSBQTQ0KVG86IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9y
ZzsgV2FuZywgTWluZ3l1L831IMP56KQgPHdhbmdteUBmdWppdHN1LmNvbT4NClN1YmplY3Q6IFJl
OiBbeW9jdG8tcGF0Y2hlc10gW21ldGEtamF2YV0gUUEgSXNzdWU6IE1pc3NpbmcgVXBzdHJlYW0t
U3RhdHVzIGluIHBhdGNoDQoNCk9uIEZyaSwgMjEgRmViIDIwMjUgYXQgMTA6MTIsIFJpY2hhcmQg
UHVyZGllIHZpYSBsaXN0cy55b2N0b3Byb2plY3Qub3JnIDxyaWNoYXJkLnB1cmRpZT1saW51eGZv
dW5kYXRpb24ub3JnQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IHdyb3RlOg0KPiA+IEl0J3MgZGVm
aW5pdGVseSB0aGUgYmVzdCB0aGluZyB0byBiZSBhYmxlIHRvIGRvIHRoaXMNCj4gPg0KPiA+IEJ1
dCB0aGVyZSBhcmUgbWFueSBwYXRjaGVzIHdpdGggdGhpcyBwcm9ibGVtLCBhbmQgaXQgaXMgdW5j
ZXJ0YWluIA0KPiA+IHdoYXQgdGhlIHB1cnBvc2Ugb2YgdGhlIHBhdGNoIHdhcyBhdCB0aGF0IHRp
bWUgKG1hbnkgcGF0Y2hlcyBkbyBub3QgDQo+ID4gaGF2ZSBjb21taXQgaW5mb3JtYXRpb24pLg0K
PiA+IEluIGFkZGl0aW9uLCBtb3N0IHVwc3RyZWFtIGhhdmUgbm90IGJlZW4gbWFpbnRhaW5lZCBv
ciB1cGRhdGVkIGZvciBhIA0KPiA+IGxvbmcgdGltZSwgc28gdGhlIGZlYXNpYmlsaXR5IG9mIG1v
ZGlmeWluZyB0aGVtIGFsbCBzZWVtcyBub3QgdmVyeSANCj4gPiBoaWdoLg0KPiA+DQo+ID4gSXQg
aXMgYmVzdCBmb3IgdGhlIGF1dGhvciBvZiB0aGUgcGF0Y2ggdG8gbWFrZSB0aGUgbW9kaWZpY2F0
aW9ucy4NCj4NCj4gVGhhdCBsYXllciBpcyBzdHJ1Z2dsaW5nIGZvciBtYWludGFpbmVyIHRpbWUg
YW5kIHRoZSBhdXRob3JzIG9mIHRoZSANCj4gcGF0Y2hlcyBoYXZlIG1vdmVkIG9uIHRvIG90aGVy
IHRoaW5ncyBhIGxvbmcgdGltZSBhZ28uIEkgdGhlcmVmb3JlIA0KPiBkb24ndCB0aGluayBpdCB3
aWxsIGhhcHBlbiBieSB0aGUgYXV0aG9yIG9yIHRoZSBsYXllciBtYWludGFpbmVyLg0KPg0KPiBX
ZSBkbyByZWFsbHkgbmVlZCB0byB3b3JrIG91dCB0aGF0IGluZm9ybWF0aW9uIGJ1dCBpdCBpc24n
dCBhbiBlYXN5IA0KPiBqb2IuIFRoaXMgaXMgd2h5IHdlIG5vdyByZXF1aXJlIGl0IGJ1dCB0aGVz
ZSBwYXRjaGVzIGRhdGUgZnJvbSBiZWZvcmUgDQo+IHdlIGRpZCB0aGF0LiBJdCB3aWxsIG5lZWQg
c29tZW9uZSB0byBzcGVuZCB0aW1lIG9uIGl0Lg0KDQpUaGlzIGlzIHRoZSBzaXR1YXRpb24gd2l0
aCBtZXRhLWphdmE6DQpodHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvZy9vcGVuZW1iZWRk
ZWQtZGV2ZWwvbWVzc2FnZS8xMTQ5NTgNCg0KSSdkIHNheSB5b3UgV2FuZyBuZWVkIHRvIGNvbW1p
dCB0byBtYWludGFpbmluZyB0aGF0IGxheWVyIGlmIHlvdSB3YW50IHRvIGtlZXAgaXQgaW4gc29t
ZSBraW5kIG9mIHdvcmtpbmcgc3RhdGUuIFRoZXJlJ3MganVzdCBubyBvbmUgZWxzZSB3aG8gaGFz
IGFuIGludGVyZXN0IGluIGl0IGFueW1vcmUuDQoNCkFsZXgNCg0KDQotPS09LT0tPS09LT0tPS09
LT0tPS09LQ0KTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBzZW50IHRvIHRoaXMgZ3Jv
dXAuDQpWaWV3L1JlcGx5IE9ubGluZSAoIzExMTMpOiBodHRwczovL2xpc3RzLnlvY3RvcHJvamVj
dC5vcmcvZy95b2N0by1wYXRjaGVzL21lc3NhZ2UvMTExMw0KTXV0ZSBUaGlzIFRvcGljOiBodHRw
czovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvbXQvMTExMzAyNzE1LzU5NzQ5NDYNCkdyb3VwIE93
bmVyOiB5b2N0by1wYXRjaGVzK293bmVyQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNClVuc3Vic2Ny
aWJlOiBodHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvZy95b2N0by1wYXRjaGVzL2xlYXZl
LzEzNjE0MjcxLzU5NzQ5NDYvMTkwMjgzMTA2Ni94eXp6eSBbd2FuZ215QGZ1aml0c3UuY29tXQ0K
LT0tPS09LT0tPS09LT0tPS09LT0tPS0NCg0KDQo=

