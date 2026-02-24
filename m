Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BA0F3C995
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 15:11:54 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22401.1771945904729330270
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Feb 2026 07:11:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=V1px2Tqd;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=V1px2Tqd;
 spf=pass (domain: arm.com, ip: 52.101.65.28, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JBUq2Ak1O0+nQUoOhEFJDxebpLx5IxmaLwkpz1t1QvyfxLfRlJwDulANeuRyKuwfTHlKjwfGKjBWcBoQqwJQ6uY0CyB+zk45kiQSJbSByFcaSwEcqUDFG7lZ0G9PGIFjJSHTb8hQFcuRRVoj7bMOiSajCYz6ZZ0U6y14yXCmj5MV7yKb5rx3tm7aGJW3omWNHYyNF9UCN0JiBnOAkoah4eF/vjsaxN7WMT5vFX/yzmh/EC8YkH0GTM0vEjl4HCsXQ+Q+O7AuwHcPoh8BI5r8wcKwckyp9OA3TRyMPAn1vusHkMeq0q/Vg5u6LlaV6eamtR3aADHbKB+IDARgY0ph+g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvwbZkLwBSFR43qQqxJr1noI/WODUQrhA4nlA3FiSjA=;
 b=nUcerXO6O/PMmublshxxDDp7Kme7Fgz+9Rm5wssDO2AFTQ/xRVjZyMtmjcRieMlZ/bcPRn3XE+GiW2iQrZx7l748XR1yv1g/W5RJuEiPbwEFFZVF5qhJYc2XfdK66bg6LoWjEJpqVn8cC11e8cHbPZMAFkBodb5a3aKcAeFlmZGcbBm/e2RBaOMWqo333R7zQytg3L+bn9xw3Onm2q2gJLxdpI637QTWidjUoPGeBmmSCos2n7DrTJ7OCfHyRaTYdrKxqqYYGSDPYR9YXw1oFXCd5Zi8KZHcuZpZpxUNNZFAYuhk0SvuWvvRQOij32BkMDFXVaTLnU/x7O194skX9Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=siemens.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvwbZkLwBSFR43qQqxJr1noI/WODUQrhA4nlA3FiSjA=;
 b=V1px2TqdsCOHihjZi0+SGdziFB57iALt4ztKAqR5DrpkHvPb/+sv2XZr4DhGxy8h1wabmHA3FGIbmE6TWcWfoFYW4X7259PhEBsnWamGLAFLHk0nHxvWGlBn4Ylm4sQ5AYA3aUv4jGEthhQy9GpXuuavkEk5kJOYQM3E4ZEX5fE=
Received: from AS4PR09CA0019.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::10)
 by AM8PR08MB6516.eurprd08.prod.outlook.com (2603:10a6:20b:363::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:11:39 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::a1) by AS4PR09CA0019.outlook.office365.com
 (2603:10a6:20b:5d4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 15:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Tue, 24 Feb 2026 15:11:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b92pqjuI2Ewj8hc+aLfJ+yKRgZA+qHBeTUc2QRf2Ay9geDh5YR8GT5+2ZYejEIRRUL2RCzi3bZnCDLRJY/P32hkPT5NB1mCqmzdvdYjdOSyakxj/jTmoSufuz4uvPyFwMQ1Ge0T7CGl/8pwIvib9nLrRFihCjSqBkLyGt81C+32q//sVmV/0MfIM5fNldf2xWf6bbQ8doTJpdp/ZjkC20qSuEx2S8pOyY21l4VvCcl0a8AwXSjvRt+wMhQqjB2U+nkNGfu5mbAcjsVDKAq724BW17GofbYzST+wqZQkecA3xfH00SNB/JiSIW4dxtrZh0PuQUdBscqR8uL4WFX+onA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvwbZkLwBSFR43qQqxJr1noI/WODUQrhA4nlA3FiSjA=;
 b=sVL3vrEXw3r/57wuBNTdxFDYVOl3hza/pEInZ+ryuv4vx/DuiNeQetBRjyWq1qstuShTHZGI2tuDxafgs3mtFD7rE1/meSDtoS9T5ScS77WDObaexqPz9Ri8tn6Bz1H984HTmt/ZQ6ggq2TP0/P1D5MD2RE9l1Ig+viuItIdN7Z3xmqBYao4aq9XbYIsZ0mxKkMF1lyaXu2JdnL/w9Y7CNlBN5JiA98ARWtvfwInDmYf3lBmz2D6I0C/AjNgRNbWYMJbHPWJiAUDilXd6fH4qNL5pVNfYROOVCxH4yfn3fSUNd8F5UEzW9MMGPyQ0RCBlginLnyGGZinmFydnNC0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvwbZkLwBSFR43qQqxJr1noI/WODUQrhA4nlA3FiSjA=;
 b=V1px2TqdsCOHihjZi0+SGdziFB57iALt4ztKAqR5DrpkHvPb/+sv2XZr4DhGxy8h1wabmHA3FGIbmE6TWcWfoFYW4X7259PhEBsnWamGLAFLHk0nHxvWGlBn4Ylm4sQ5AYA3aUv4jGEthhQy9GpXuuavkEk5kJOYQM3E4ZEX5fE=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AM8PR08MB6401.eurprd08.prod.outlook.com (2603:10a6:20b:361::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:10:36 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50%6]) with mapi id 15.20.9632.010; Tue, 24 Feb 2026
 15:10:36 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "Marko, Peter" <Peter.Marko@siemens.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [yocto-metrics][PATCH] patch-status: add
 whinlatter
Thread-Topic: [yocto-patches] [yocto-metrics][PATCH] patch-status: add
 whinlatter
Thread-Index: AQHcjWuJMqLPjUq70Ei46CgC2WIC97VkSsyAgAh36ICAIo5sAIABe/OAgAFXfgA=
Date: Tue, 24 Feb 2026 15:10:36 +0000
Message-ID: <3AA57191-920A-4E51-A792-7E0B039E9B73@arm.com>
References: <20260124195614.1874743-1-peter.marko@siemens.com>
 <F7383EE9-2EE0-44C5-91CC-AF540D574E5C@arm.com>
 <AS1PR10MB569754E2254D487C56FCE53DFD9CA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
 <AS1PR10MB569788AB28F1B97586FEE355FD76A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
 <AS1PR10MB5697DFE8B76706E8B0444865FD77A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AS1PR10MB5697DFE8B76706E8B0444865FD77A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81.1.4)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AM8PR08MB6401:EE_|AM1PEPF000252DD:EE_|AM8PR08MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: 144df6d5-cd9e-435c-fe4f-08de73b7028d
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?ZzgwV3p1Zm0zMFpFTVVsL0ZwTnVNV1RBQWdhMmJURUoyc2wvU3Z0TEdWQnZo?=
 =?utf-8?B?OEFHSzErTW5IVkRFQVgyM01ucXg1UzNmUWRnN2JkTDMrYmdtT3VieHYvMUsv?=
 =?utf-8?B?d29yTC9oVitiMzE2dWRyanRkVG0vS2twaUlYRjJlQ3k3c2phNlBZaEtqS0Jn?=
 =?utf-8?B?cmI5Tk1lWUsyaGVmaXB2ckcybDFIV0tWUEVKZGVXT3l3RnlmcHU3L0VFUnpX?=
 =?utf-8?B?aDFtbmFLcGErbkxRMEFFMCtvTkpnUUpKalFiMzlKa3dFcmh4SVlYcm84VW1t?=
 =?utf-8?B?UTlLRU9FRWtySzdsT3praFZXVjkvQkdHSXZqTHZiRzhxNFhiOE5DMGZuZkJn?=
 =?utf-8?B?bmF6dzQrVVU3d1F1eDZSbStwVXpKckdNNW9UU2F3d3ZIMEZvTWZDWnBxNVQx?=
 =?utf-8?B?eHc1NmFRdTlxVmZ5MDB2bHdXYmZTR2haamQwVlFQcVN2QXVabDdpUS9ZTVRP?=
 =?utf-8?B?RkpaRnphUVlyVUw4WitVaU9qLzh2dUtYVEJkRFJIQWphUHcwREFTQThneFZj?=
 =?utf-8?B?eThxeTZmUk42N3cwWmZacXpmV3BqN256N2FNczB0L2pyeDVlaWZjelhMdkhs?=
 =?utf-8?B?QWhrYlNFb1FvbzVyVXo3d3hyaTQ3aEZuU00vY00rUkhKaVRvclZVNW5GM1Ew?=
 =?utf-8?B?WS9XbmlUbS8rYmNVcG1qTGVJNkhQNFJTS3g2UGVndXFBV0xmMkpCWXVFQ2RG?=
 =?utf-8?B?OUtGdWVZTXVmZHdvYWRlUmJYcjVSRzJZQUErY0ZTK3hFNWNuMmdrZXFGalpR?=
 =?utf-8?B?SmdQcEduVjFiMHAvWHFQdkx6dW1xNTNwN0JuSGptamQyemtjWFM5SU11RGUr?=
 =?utf-8?B?aVRreUlnRSt0TUtuQkZjNDBsTnRia053Y0NQSnEvUmx4akZIN2xnQlhsSTNq?=
 =?utf-8?B?by9tTTJ4SkpEY1dJUjNSSGJ6cUsydkw2cjdpcWV3QzhOT0JkcGprd1o4cmwx?=
 =?utf-8?B?SklOTFBMdjFmZnRsejlvWjcrWUdkcjZaQnpCVmJlRnRLc0w1NUh6eE5YU1dT?=
 =?utf-8?B?bEhFclhUblhidlAyQWV0R2RFM2JpbzhHUC9WbXdjT1ZZUCtCUTdKcHNGZnFD?=
 =?utf-8?B?UUdqeGE0RitRZjNYcnNnd3dqYmRuQlF6ODhPVG1hUkUrM0JPOHNhbkxlNGVv?=
 =?utf-8?B?SHJvU0lkaXRteUZjMFloSmRGVmlxNklVbFcyNFJhZTFNZlgxaG1nM0RFOXo4?=
 =?utf-8?B?anp5L0cxT2prRUMvKzZtdlVWZkJVamUzREppZHdkT2c1US9GV0V4UFJPN1JQ?=
 =?utf-8?B?bTBiUkdWdUhsUm5LQS91SkZrWFNtb29CVjlOOFl4RkVzemwzVlBWNVoyMnl3?=
 =?utf-8?B?bHlRbnhFaUpHQ1I0WmJyaXZjWXRrcjNlbHBYTnhtbWY4RlhBQnVMdW5WOFpt?=
 =?utf-8?B?MGFXSTFkdzZGWktFTjVIWVNRSFc1Q2k3Y2wrVzB2MlBMM1E3WnZRajdhOU1x?=
 =?utf-8?B?QWZyckZEMHJnZzk5ZjhHVEQ1WVFqcGVBTkpUWmxkbXZ0Rkc3dmlmcEtobWQ5?=
 =?utf-8?B?UVVWYitrTlpBRXFNcXhBRkJVb1JxOElxcWR0WDMrV0dTODU0NUpLcjNtVCtU?=
 =?utf-8?B?aExiQzQyY3RSWUxNZTBHZDRoTy9xSE5nZVo1VXgzNGtKd0hEUkRQM3FaZldw?=
 =?utf-8?B?TDJEQmdhUVZsYjgyOVRCUnNWTE5PS1RGNVJSZm5QeFZMdTU3dmxzakMzem1T?=
 =?utf-8?B?Tlp5dGgvUDdwZzkxQ29MTndPS2V1Z2dLeEhRd0xzZGNQNW9BeEh6Qmt4WWVs?=
 =?utf-8?B?N2J2NUFtY00vRzl6K2ZhS3g5akFsU0lVSm0zcWlqL3k0QUZGTmM3WE9Ed3ZE?=
 =?utf-8?B?MW1hWEl5ejhwR3JVZ21qRW5MZDYrRHpyOVBLZ05MY2pxcnlFVU1GODgzSmtX?=
 =?utf-8?B?UUFHNm16VGdjOXlQN1JvalA3Zzh1RnJ3T01OS3BMNFVacWJvUi9zbkF3RjE5?=
 =?utf-8?B?d3hWZ21CVEJRSytVZWlDOTM5d3h4aDlkZERjNVk0L2wrQzhXT2R6R3UyOGNx?=
 =?utf-8?B?bXpWM1FkN0hsMGFBUXk2L01wMmZ0ZlVMVC9Yc29VRHM3OUlpZG1uWlg0K2VT?=
 =?utf-8?B?RFJqVkgwVDEvV0VqYjVYRzRRZjhCZXMvZkp5S3pxY0tSU01oQUUwUUhhOE4v?=
 =?utf-8?B?WkpSRWFvMzhPNU1PclhtcXAyazlES3ZhTTdsSXR5RXFlMlhyeU5NaVF6N09m?=
 =?utf-8?Q?HPFz4F3P5hJOn66I0qrQ9jc=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A9A5A890CFD0D4686ACB40D0D71EF4D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6401
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	b155794c-6a6d-42e3-5396-08de73b6dd22
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|14060799003|35042699022|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ajkxQVp0N3Q1aUNwNFdyZUhsd2FXd0dWdGNNSVRuNmlvMVI3VWlTN3BVcUhP?=
 =?utf-8?B?OVgxcDhOK1BtRUhkczhweW9sT3RuY3ZoR2FHRUp3R1ZYYU9JRmRqRitFOFNH?=
 =?utf-8?B?YjcvK3E3MHdGaXpXbkxPa2tXWjRHMWNhcGtQTHJsVE11eTdWQnFkYTNBUlZ0?=
 =?utf-8?B?QnlacHJuK1JOMWtvWm1BL1hVSTN4Zjl4ZXdUcUFEZ0M0QkxEaFVGNjhWd3Z4?=
 =?utf-8?B?UHA4YWgrTi81cmQxWFVoeTllaUtwU0hJSVZQTm00MjVpREdYcmFQMENSTmxS?=
 =?utf-8?B?dTlzc3pCR1E5SHRsT0o2VUJEUXNCalRRdWttSFpWTDU4dGFGTXRsWHBjcmVZ?=
 =?utf-8?B?cFdpZHZyNEp6Z0FsQzdhdjhhNlpYU0UzRUxmVFFRelIxQU9MeUlRUHl1WEFJ?=
 =?utf-8?B?bG9aSkRoRS9rUStlQWdLaVRwT25ITWJqTkNOVUVNaUUwL0xOcGh6THdFeERZ?=
 =?utf-8?B?aHJtREhWU0xOb0tsektFRnpicjhLM2diTFZ6SC9JejhVaE9qTVlJOWE4RFpr?=
 =?utf-8?B?REdBOFhUcDA0YjJkYU1CdCtIVHpYNnJ0d0F6V3ZzTGZSYkg3VFFiNyt0V3dC?=
 =?utf-8?B?bnhNYU1XeVltNUxnT0ZaOGdsVGFHTDlLQU5ROVBudkJWRzF0L1ZwMlhnVVVK?=
 =?utf-8?B?Vk4xNHNueUs1QnY2Y0xlTmJ4S3cwS1diYkZuZmN0OUIySEJkVitSbXREMVVP?=
 =?utf-8?B?b0Q5NW9lcFdkaGwxa3BzRTNYUVBnNVBBVVIvK0RVVFNzNXdiQzBHSlhVNkpt?=
 =?utf-8?B?UGRjNGdjYncwbm1jbm01UEdkampFcVd2aUd2MHAyV0NjaHpFV0wxLy9IUFd4?=
 =?utf-8?B?MHdXTHpwdCs5aW1xanRwUmpWbzNtenREZTl0UE8vTnAwbVdHTWovc3RrSDN5?=
 =?utf-8?B?TjJSMzM5WkRVc1VsREwrNXF6b0RhRENyN0RBREF3a2hKQStadHN2aEFPSWxK?=
 =?utf-8?B?a21DRGJYTG9oQW5rTzZaMTE5OW5VMUdzY2xTcnJlT2dNYVpOODNIU2F2TlpF?=
 =?utf-8?B?dEIwVnE1UGVOV1JuRUtQb3hGcEVEQXJWT25oa3pva1poSzRkOEJvalF4WVFk?=
 =?utf-8?B?MjFqRjlaaUI0Mk9pM214K1N4SzZEaVYxYW1iTDQwR1BXNjVrVUtJdTEwYWVQ?=
 =?utf-8?B?aUxJVE00NEVYRUgrbUJKNjF3Z3YxdGkrOUhMMExUbWQ3MHpZb3RGRms5VjJh?=
 =?utf-8?B?OEVCVGYzV09yS3lPeUZsZWQ0YUxZYXpsbHZSeC9pWVRwSzNPOWVqVkdRWTFW?=
 =?utf-8?B?eE52WnVQcXpiQUVJZHJNcHdKU3NjRUZrUkJSL0NWTERRN0ZUMU9JNHQ0WC9L?=
 =?utf-8?B?ZnhnaHJ4My9BaG1VcmlvUlMxVGdGMWZnaFQwWXFHOUsxMlBNNzdkTWhwY2xO?=
 =?utf-8?B?R05TTGZYV3NCTk52K0ZxdXhaYW9ndW1CUUhycTFpOXFzNllPbjYxcVJCcmNs?=
 =?utf-8?B?eDNQK3laR1IwMHZiV3lzVU9tQXI4MjEwYjd1OGsxTUk3dFN0V0VOb3UzZWk0?=
 =?utf-8?B?VG1DaXA0VWFKay9STUJBa3FMVFo0SWFxaXZsYjdySThXbWxLSUZwVm5EQWUv?=
 =?utf-8?B?VDA1enNQcE5nRFpjSDJFYVcyV1lsYnNpaWZvZ3NXS2tFbm8yZGZaZjhxNDQz?=
 =?utf-8?B?YTZZR2VreUVRaHlMb3NHNEtWT0NlUXIzTTJsUDRUbFRLa0xkOGZ6UDR4U2JD?=
 =?utf-8?B?N2Y4MjVrd2RoSVg2c3BkMlVrSDVqQ0JSbGg3b05HWmVBOFlEQWJZcTZHL0dy?=
 =?utf-8?B?cDVMNGt6TGtEQzhZT2N5bEtHdEJhTlhsVTJPblV5bUVmTm5yeElPaDdKZktn?=
 =?utf-8?B?RGFzSTZTa1NxVDFsZ1dtaFhyeGh6MEt5bWJWQ3gycHBUTE1QaFZram5ZcnJD?=
 =?utf-8?B?M3RMd3Z2Q2diUDNpK2pOUmgxNDZrakNvb1Y2K2ZycmFQVExaa0xOMWV1Vm1S?=
 =?utf-8?B?WCtFSUF0NFUzck0rdHFLQUE0MVkrUkZnYTBEQmJUaFh6ZFlQZVg3UllwcCs5?=
 =?utf-8?B?UWkzUUhPZEVDMlQreTNmNW9GWmlhNEF2RWU4VVdkZEp0R1hyYU5YTGd1a0J0?=
 =?utf-8?B?Ui9HWW1kZkk4RGx5TGhYSzQwaFZpMWlYWHY2SU1KdkU0Z1JEV1VXYmtsbFlo?=
 =?utf-8?B?SDBFMFdvcGdmZVZHNE9sS2tOZXlCUjNUOGRoem1YYXpYSzYwTkZGT0NSUDhx?=
 =?utf-8?B?N3g5YmdsSXJvcDdOSGxGcEcyc0RUMWpuUzdoVzhuS1oxQlFkQVBpMXhWeFVy?=
 =?utf-8?B?YTlVZ0VTT0hIZEJtVDJJRnNRWWNnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(14060799003)(35042699022)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	SDre+5eTWxss2JTQCTL7gTvnGyxDMvVBF/IksjKynZTVghktlm17t32O374mHLtxwCNdK46ymQVis/8LHMBTshDULjphwXOd5IBjMjUazQsbx+Q61uLXj+Qa//T/nWvfXuPsIwTUEZQiIarcawDgtJ9bbJuQPG3z5Ir8NNplMfzMK7AJ2o18ZGzxGHPqIl+MUxGQgB5LnSGie4EFQJKzOf4mOQkW7xCyatX/ZInHCziz91smuQnwcb7WJDUhppBD7+it+X91tttwtP4cKKTB9ZXtWFkID9kpbVfB/2LVIpe8jlcsAmmg4ld48ejP/XeDqfPQ95yKoEfDckIaAKhXzm+NStot7X074YhZcDRCPfWHDWJVZPeTzlZqUb0YNNnQw54ywl4W94neKq6C66wWE6YH2B8WwRgEhCzMdd+hKcP6hCzkYL2xkGbmGwfhrfSl
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:11:39.1795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144df6d5-cd9e-435c-fe4f-08de73b7028d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6516
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 24 Feb 2026 15:11:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3273

T24gMjMgRmViIDIwMjYsIGF0IDE4OjQxLCBNYXJrbywgUGV0ZXIgPFBldGVyLk1hcmtvQHNpZW1l
bnMuY29tPiB3cm90ZToNCj4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgbWVyZ2luZy4NCj4gQ291
bGQgeW91IHBsZWFzZSBhbHNvIG1lcmdlIHRoZSBtZXRhLW9lIHBhdGNoZXM/DQo+DQo+IGh0dHBz
Oi8vcGF0Y2h3b3JrLnlvY3RvcHJvamVjdC5vcmcvcHJvamVjdC95b2N0by9wYXRjaC8yMDI2MDEy
NDE5NTYyNS4xODc0NzY1LTEtcGV0ZXIubWFya29Ac2llbWVucy5jb20vDQo+IGh0dHBzOi8vcGF0
Y2h3b3JrLnlvY3RvcHJvamVjdC5vcmcvcHJvamVjdC95b2N0by9wYXRjaC8yMDI2MDEyNDE5NTYy
NS4xODc0NzY1LTItcGV0ZXIubWFya29Ac2llbWVucy5jb20vDQoNCkRvbmUsIHRoYW5rcyBmb3Ig
dGhlIG51ZGdlLCBJIGZvcmdvdCB0aG9zZSB3ZXJlIHVubWVyZ2VkIHRvby4NCg0KQ2xlYXJseSB3
ZSBuZWVkIHRvIG1vdmUgdGhlIGh0bWwvbG9naWMgZnJvbSB0aGUgbWV0cmljcyByZXBvc2l0b3Jp
ZXMgYnV0IHRoYXTigJlzIHNvbWV0aGluZyBmb3IgYW5vdGhlciBkYXnigKYNCg0KUm9zcw0KSU1Q
T1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIg
aW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVy
IHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5m
b3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K

