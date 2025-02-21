Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF79DC021B2
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 03:09:50 +0000 (UTC)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
 by mx.groups.io with SMTP id smtpd.web10.15167.1740107381505855177
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 19:09:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=xCFhhgUs;
 spf=neutral (domain: fujitsu.com, ip: 68.232.152.245, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740107382; x=1771643382;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=iVhvSgiRqJpoD+NL0GQp9TQD/wC4U53lcDW+HR2ixXk=;
  b=xCFhhgUsRqa1msSJqeer2s0YIkkLmtIK8rceYEUzKj2WLTrn0kYd7HcY
   xzBfawtNSKHrYK93sTOacxADotghx/3hqQhSgeS9+dzZlr/okuBbunM28
   mnjurJo6haQqgCH3b0QjXGewTDeRswVy56xd31P8DrAhMCm+PqTSFtZZX
   Onl5SGcyTircPJgMawGs9D6f5rhJO/8+zpu/turRzPCtop9ryU1N2jJ1Y
   m5aBU9OTOCLhiplVj6aCC25yndomCUeiIx+tXI5A2ivMvX3zlFPnIxAGC
   BvM8Z297+5tNNfdXdmVU4Si9pe9RltVcwo0jnUHt/a2bNXKvbrGJsGK9I
   w==;
X-CSE-ConnectionGUID: iT5vQXpbQ3OE1/uT+6WomQ==
X-CSE-MsgGUID: XIbi4lzYT86T6iUo2PL47A==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="58235522"
X-IronPort-AV: E=Sophos;i="6.13,303,1732546800"; 
   d="scan'208";a="58235522"
Received: from mail-japanwestazlp17010000.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 12:09:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPNK0z9bVB1SH63qhobYqpvSQ3VCkk7bcBAZ9YDRzDwAdSUz+pffaPwubuw0cJAs/V2NZIWjV29WK5IxZjsWIJbhTATN0cNdg+6xMi93+SfwRSiKambC0MMDEhhBqDOUcKnElzKi5WsGjckqWqk0EmjxLyZxqP+h9ZXdic71FG/ihLkJSS7L9mL8pQyipXAlpaCIZlLNL81TL3f6xZcx5ZCkuaURho9deE+lMMxXJLN430apDtb7+j0WTb/V7IJEhV9kLRI/qgdhHiBZnurbXVcCAZ5EUGToafQdpZzUIoRfhPBI/aOMIu4Jhz2ozsE7wchpmz7k5MkO85K+23yz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVhvSgiRqJpoD+NL0GQp9TQD/wC4U53lcDW+HR2ixXk=;
 b=suzeH/2XPIPbmxD5oRyzPeuPeniV5/ybzWVBCkWOGROVvCYWlANICWh36knOg/DVfBfFeLdgT0w6i7Z039iZZXBvJgJZQO3mz57LgCsS5Fmdyke5OWqxeHMNOtQN5Vb3d4WWBHVYfbOMG6p+CxCzK9JBaXehOTD+Zlz+x/4FEHzLIBlK46uF5a6c4+eFKUl+Q9P2dDv8RHs0n4V6O2frTcLKADMEmnP/aVMrsVWWI94ncyWnrv2yuD5ukvIEV/mEK1WvWrbLB/ZFW9XirRZUwhxCrJjGvAbzxLJpfGXPJdvN3VaqBowvqtweb8hbm/Lhhk6TWvUPE+9+CHQPzcL5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 (2603:1096:400:3fb::13) by TY4PR01MB14107.jpnprd01.prod.outlook.com
 (2603:1096:405:208::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 03:09:35 +0000
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342]) by TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 03:09:35 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: [yocto-patches] [meta-java] issue for icedtea7-native
Thread-Topic: [yocto-patches] [meta-java] issue for icedtea7-native
Thread-Index: AduEDbg5224KG8ljSquniZx/2s3vug==
Date: Fri, 21 Feb 2025 03:09:34 +0000
Message-ID: 
 <TYWPR01MB118618F87C87B76AE28BAAFC3DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=5447f5ad-b9c9-4c60-b08a-41aad841ce0c;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-02-21T03:07:57Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11861:EE_|TY4PR01MB14107:EE_
x-ms-office365-filtering-correlation-id: 50cb56ba-de93-4433-1f7a-08dd52252b1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|27032699015|1580799027;
x-microsoft-antispam-message-info: 
 =?gb2312?B?aWtwZ2o1eXBIVzJ6bmhMN09paGQzN2ZvZXNicE9sUERPb2U3bEpUaS9ycVIr?=
 =?gb2312?B?R2kzSVNydklIa1R1TjlIZXdnT1Q2WUZsQ3A2T3g1T3U1VTNNR052Tk1PdVds?=
 =?gb2312?B?WE4rempxdzE1WTRDS05Zb2xkS0J0OFZ0VnRvZ3cyWEFxeFppOTBQNytoN01U?=
 =?gb2312?B?MWVPeVhPeUcyQ05YZXFVSjN3c2VFQVlpNTJrOTVLZHBQZ3NIOEQrS2RZVDVm?=
 =?gb2312?B?TmZ5Z1FwVTkwL2hvQzZPYjlJd0FYUytlbG9lWkZFUjdkTnFCVk9RRGxpcUow?=
 =?gb2312?B?c3VUWExhV3VEZXlGeURNSmZOdHh3Q3RMN3dSTHpPMjQ3cW96MGJ6RHY0NmEy?=
 =?gb2312?B?YlZuajhSZkZPZE0xWUdoQXp1eFlycWtHMHl6WHRRZ0MrSmc3NFFJZXlESlZX?=
 =?gb2312?B?dGRkYnN3K1oycVRWVi9DaEZmQkJtODc1TWJtSXRyTjlsd2ZHRlZqZHBuTFRo?=
 =?gb2312?B?TWRNMG54dUoyS1RxRDVMK0toWG5HYXpjbHQ0OVRKam12ZmRrNnNBM0JlME96?=
 =?gb2312?B?UXN4WFM1ZFpUcXRDOGg1eGRUM0JqdlNOa3hEaGZXMC9maFFjcWxxSlEvY2Z1?=
 =?gb2312?B?TW03U0ZyaUl4a2QyWHpNZlM2bm16RUhlTTg0YlgvTzZPaGVZYzdHcHVSc01o?=
 =?gb2312?B?eWZMdUIzbFdpTVZiYkVjVWNTVjZ0S0Y1dHJFQmFXZE5wYTBDdy9GRmM3dFR2?=
 =?gb2312?B?ejdlYkNYVVB2MlNSaUJoZGpsRGlSM2RzNVVKZzIxQmIveERMNXNzbG0rYWhO?=
 =?gb2312?B?K3g1bStCdnh0anY0OVovclg2VEFSKzM4MndpUk0yY1J2RVNPanZTSWhJRTZs?=
 =?gb2312?B?bXlsOWxmSDFPaUk5RUlnbi9lWitqOEFtYkdONUxscUtlWWpnR0hvOW1OQTlP?=
 =?gb2312?B?Y2dJT0FrNmJiUm02TEFiSVlTcXl0L1N4Tkd3d3NUWlY4ckVyZFp5K1hST29X?=
 =?gb2312?B?RitlNXRLdHJDSHFXc1oxdDd2REpZeGo1M25SbjFJZjd1OWx1ZzRPTWdZV1BR?=
 =?gb2312?B?Qks5QUJDOW5LNWEwblluOHpCcDBqbUtnVTJXZjhreTZrbHkwZndpQklrV21T?=
 =?gb2312?B?VEV6SXZKZGhpTlVhS1pSSXNzMHJ2YjhvVzc0aDZIYkJMOGNnUVlJcVlBeVVw?=
 =?gb2312?B?K0dzcFhZSDhtT2ZMNW5Cd0xPMTdYVmRLVCtzMkUwaTQ3WjlWYWFxU3ozVWFm?=
 =?gb2312?B?SU1Mc0VWb21MZjF5TndBTmJTWU12YktJR3RrN0hNRDZidWl4Vy9DVkUwb1Vu?=
 =?gb2312?B?TlRha1JpcUxLeFRHS0VlQ1RWSVY4UmlWY3p1K08xQVRMZEpuSnJEWDRpaDhx?=
 =?gb2312?B?U0lTVkgxQkgzWVdLM0ltSDJZY3FPaEZFSnhsSUdUTEZMTmlLM1EwZEZaK1M1?=
 =?gb2312?B?YWFmbmlSSGRJRzc4VjhHbnpEOUxGdTdSNjFPLzRNNTJnak8yVzFHbGFFaE9l?=
 =?gb2312?B?d0dqUHMxaDE2S0RWNnU5TjVPWWw4SEIzTzU5cHM2SW1VZG90UGd3SDVBM1Uw?=
 =?gb2312?B?aW1qVkF1OXdZVHdPMndMNEh0N0RIWGRFSXh3ZVVCZ3FoOVVaTUNxK3pVWS9k?=
 =?gb2312?B?Z2dWSElnZWtraDJpbG9NOTY5QXc1b0RzWUlydzdRbGxRRVdpZXI2OVZrS0dK?=
 =?gb2312?B?K2xJd3ZWdm9xNVJnRkNvSVVqUk5EQ282RTlEMmxOV0JNRldxaTZNUENQQzg4?=
 =?gb2312?B?ZWZaRDVzRjIvWG1KUTFHVXluSWVFZFQ3ajduUE5zQW9NdUx6SjZDVC84d1ov?=
 =?gb2312?B?SWRCUHhYMFc5a2R3Y1dodTJSdWlrZGJIMkxXZmdiSE9PcUlwZFZKdkpWZFlO?=
 =?gb2312?B?L09LVkRDU3RiM0JKT3dybWltMW5NSnNyT1cxYXRnbk1yc2hIVVZYWnorSSt2?=
 =?gb2312?B?aGtmSXEzZTJKUVd3akdmT2VwY3Rvb1hHa1NQQnZ1b2FDdG5KNmVpbEk4d2p5?=
 =?gb2312?B?MVVrVStzVEhwbTQ2R2hyMjd2eE9HN0c4M3I1VjJ3NVVDRmxUVktGQ29VR0FE?=
 =?gb2312?Q?lhVebbEF9UirqQgriVGZwZzn/Nw9D0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11861.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(27032699015)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?dVdhd0laT0NudldwRkk0YU8zemZoM0dHbDNGQlR0bDZSUWxpczR6VHNSejBU?=
 =?gb2312?B?RGpOSFVGanpQVnR0QktpWXRvVkZpeUY4TFQ5bDJCWUF6Rm9BZ1B3Zm9hUFRq?=
 =?gb2312?B?MjRnTGNoTmR4VmlCU1FVVzg0MGFvOGVRU0dFblN3U0NOWEJ1NnJvZ3Y3L3hl?=
 =?gb2312?B?c0JtcW13SmNiZ011cHBLSHhuT0NsN0hUSzVFSGIrQ1R1NzRoS0dVYmZQUWx2?=
 =?gb2312?B?WThHcXAvNzA2S1JkaUJLRSs2VnpSRUhRMG1tYTJyaSt5VUhQU3BIbHBlbHFI?=
 =?gb2312?B?dXFSMVN6am85U2ptOVFSdVVSNkE5RGp5Y3h3ZXhFODdIUGVvUG1SNStBcTdY?=
 =?gb2312?B?cjkra3M2Q09lQXdkYlV2QjQrWjA1UVZnUGxhdkM1dDRLTnBSNThPWHdOMlNC?=
 =?gb2312?B?dHJKZit3K212NUc2L0tJenZYWU9lNnp4RERVc09kbldDNGlaR0lLbTIvRFJE?=
 =?gb2312?B?Umh0d2VqSlNxMzNKc0VaZ3QxVXF4cmxBaEdIb0hRUWN2SVR5OXVad1VqNkR4?=
 =?gb2312?B?UDhGekViT3JwOGdLSGVwZkJlYWZvZktFVHVrc3BqcEtFTy9JL2xMRWRiTnBE?=
 =?gb2312?B?RmNoTUlRNFIzenNqVndGRFRMTFBXd0dISFJsWFpuSU0vOU51WkIydGhKNFcw?=
 =?gb2312?B?Y0xPcC9WWUJwV2kwZHVlZ1R1bXd2Sy9CTXhtNGhDWVo0YTZjU0JvWFdRb3ov?=
 =?gb2312?B?NzdzK3VpT1hZVjFaM1hzYXJ4Zm1XSlN6UHF5c2xUdnl5b2hUbnYxa3FDYk5X?=
 =?gb2312?B?NVMzNTRhMTd4dzhOOXN0YXdYUExZU1lEZkU2UlY4WXJFRFp4MitrbEtvMnVH?=
 =?gb2312?B?czlHNDRPWWNNeFduOWd4ejd1WHcwME5DSGVNNUI2ZlJzRVZzSCtVSGhudzB1?=
 =?gb2312?B?UHd5aVR3VElNeVJhK01qWTlWY3JTa1ByYVk0Q3ZGVFRuNlBidEFRZVVkN2Np?=
 =?gb2312?B?MGw4VkRMS3U4bFNOdWxDRjFkejFFdG5MMCtRd3dEMjd6UVlrK09UczB5YTBT?=
 =?gb2312?B?a3ByRENOdmViMVdVdE54MWpLdGptT3ZnZ2ZjMjZyT3p2TGc2V3YzdDFISTdi?=
 =?gb2312?B?TVZOUE5Fb2JySUR6MDl4bEdpeWxrSjM2a1M3RDlmUnU0ZmhTcktBdE5FQVUx?=
 =?gb2312?B?TTZtYXNua0kzaERZYlpydnlzakFFRjZJVzcrT3ZWRlE1UjhFQ2VmakNmSVFF?=
 =?gb2312?B?RnAwLzEwWjdTWjNSMVB5RHV5dmFUZERyUm42S1lmK2x3ZU9NdGhrQUk4WWYy?=
 =?gb2312?B?MlEyeTFsQjFWOWdUR09KWlZIbWxFQytvRkxMUW15QkpLMFFSdEhuM0hobEhZ?=
 =?gb2312?B?Q0Y2K0V2ekVQUHdHaEhDZDBHWjBaQ0xLZUN4OFA4Qm5XNzNUWktBVkxDSW5p?=
 =?gb2312?B?YWxydFgwZElPQlhORmt3NElFb1dkQkRTRXlWS3BrWU5obUtQaTdKZW5jam1h?=
 =?gb2312?B?bkc2YWJiNjE4UEd4U0RHbG53ZFFnaFh4eWdlNGpjdnlXajE2SGdXUjJrWThX?=
 =?gb2312?B?Q1grNXFYSkRBUXBQYVpFNHVwNEJJWUFBSFlSdTVPdDJWak55VjByMk1yak9B?=
 =?gb2312?B?ZDdXZjd4czNST29XSEozODNiSUZSRjNsSEI5d2lqcGg2MDQ0UnVNY2hZMDJK?=
 =?gb2312?B?emVZWEtUdDNHNHl6ZkZyQUZ3Y09BN1J3R2VQL1E3YnNIdEJaYkN5L1FQNEd4?=
 =?gb2312?B?cmtMbk1qd3k1djhWNWppVzRSY01LZmJaM0FMNGZDTVphL3NCd05zR1ljQ2Fy?=
 =?gb2312?B?R1dQYnBqR3UyaWdnR0ZHRFFNbmhZNStaUFJOcTRRNkVMRU12bFk3VGZub1lu?=
 =?gb2312?B?d1pEejdxaXREdlZoV080Q3lYcWtEWG5sMUVOa3VsdlRZNjE0aTRiRDhsZVNG?=
 =?gb2312?B?YlovczcvSE1WSTRWTndEZ2ZrY05SQXZ3S0hTYkVHOTZYSDhxeEN0RVpLTzF0?=
 =?gb2312?B?VjdETk4vdTk1T3VSL1lXbUJkMFRBdTBpeTJsQVdVd0htN2tmNWZLdW00UHc5?=
 =?gb2312?B?RlRrQXFnakd0aktIcnhtN1dsUFRsaEZyb3ZSRkxlYWtObVl2M0drVmUra2pI?=
 =?gb2312?B?dzZYRnJUU1N6TUpLUGRRMGt3VHVzQy9JbHJCWjljRi9XZXh5REc3ckI0a01a?=
 =?gb2312?Q?yEWxNTEgE1OPCOShECSJ/QdMi?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DXr1hA9wYWkeOmzFNEPjbZUMGEEY6w4ZjjAwQ3lLRlfEf4eqlomkGqc7B8b7BYhOLW7PBsRnZ6gK9jgpbQ3UB3DQk5Yj0WysvfdzoxJi1EKkAP2Pyqj+8eZTW8+5TxoMmNC6Fe0h/mEbKXStxKcbQBQpgNbeuLzfKnAUWutkUeSxMh0umSucSVnzbtbHEmgutooJh48WcQ3Wsf/eBqrjXKMsI5imLnbVW09NQOzE4gevrznKvqioycULJPzLFQrkFRQhy+U/hkcThwgflPfhkYhoXtcpF67o88Xq0JICo0rL3xHg2nlanUnEMDDABLj6sgwFcPheKEQJKwaZIo7s77rOpDMKg4Ple44T9Cvxt5uyUyzO12cQAWIzwL1iwicepgd3EMGthQczovpzcpJewAKWANf1kQPdc4m5fvbVH9WIK3unM6U4FJ9hbQKDXMAAt9b2MGBCnuxBwMIccJjJLMhoXEfW2vu8Vk9ac5HdLt/YFAO7hOTlwzRu1EKC3+jqgs6RHDs95yKmX+sIjZDXjAPWxBC6JmX0ldtwGYAwflsCfnAX7Lu/pwh3wcUUOzPxxRcOdYhnJKKKfV+Fru2hP92IipE6/qUgg5bZmD18U4/hR6YEkuvxQuq+QRLMW6nL
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11861.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cb56ba-de93-4433-1f7a-08dd52252b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 03:09:34.6576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nTYUYXvssiibEZ+CsBU4yL3GxLIsQA3E1ANmnKJXkrIn17yYYypdoW5MBGWKSHouE8uF6SfdzWW2LRz5paP9PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14107
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 03:09:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1107

V2hlbiBiaXRiYWtlIG9wZW5qa2QtOCwgdGhlIGZvbGxvd2luZyBlcnJvciBvY2N1cnJlZC4NCg0K
SXMgdGhlcmUgYW55IHNvbHV0aW9uIHRvIGRlYWwgd2l0aCB0aGlzIGVycm9yPw0KDQp8IGVycm9y
OiBqYXZheC54bWwuZGF0YXR5cGUuRHVyYXRpb246IGJhZCBjbGFzcyBmaWxlOi9hcm12OC90bXAv
d29yay94ODZfNjQtbGludXgvaWNlZHRlYTctbmF0aXZlLzIuMS4zL2ljZWR0ZWEtMi4xLjMvYnVp
bGQvb3Blbmpkay5idWlsZC90bXAvcnQtb3JpZy5qYXIoamF2YXgveG1sL2RhdGF0eXBlL0R1cmF0
aW9uLmNsYXNzKQ0KfCAgIGNsYXNzIGZpbGUgY29udGFpbnMgd3JvbmcgY2xhc3M6IGphdmF4Lnht
bC5kYXRhdHlwZS5EYXRhdHlwZUZhY3RvcnkNCnwgICBQbGVhc2UgcmVtb3ZlIG9yIG1ha2Ugc3Vy
ZSBpdCBhcHBlYXJzIGluIHRoZSBjb3JyZWN0IHN1YmRpcmVjdG9yeSBvZiB0aGUgY2xhc3NwYXRo
Lg0KfCBlcnJvcjogYmFkIGNsYXNzIGZpbGU6IC9hcm12OC90bXAvd29yay94ODZfNjQtbGludXgv
aWNlZHRlYTctbmF0aXZlLzIuMS4zL2ljZWR0ZWEtMi4xLjMvYnVpbGQvb3Blbmpkay5idWlsZC90
bXAvcnQtb3JpZy5qYXIoamF2YXgveG1sL2RhdGF0eXBlL0R1cmF0aW9uLmNsYXNzKQ0KfCAgICAg
Y2xhc3MgZmlsZSBjb250YWlucyB3cm9uZyBjbGFzczogamF2YXgueG1sLmRhdGF0eXBlLkRhdGF0
eXBlRmFjdG9yeQ0KfCAgICAgUGxlYXNlIHJlbW92ZSBvciBtYWtlIHN1cmUgaXQgYXBwZWFycyBp
biB0aGUgY29ycmVjdCBzdWJkaXJlY3Rvcnkgb2YgdGhlIGNsYXNzcGF0aC4NCnwgMSBlcnJvcg0K
fCAxIHdhcm5pbmcNCg0KICAtLQ0KQmVzdCBSZWdhcmRzDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCldhbmcgTWluZ3l1DQpGVUpJVFNVIE5BTkpJ
TkcgU09GVFdBUkUgVEVDSE5PTE9HWSBDTy4sIExURC4gKEZOU1QpDQpOby42IFdlbnpodSBSb2Fk
LCBOYW5qaW5nLCAyMTAwMTIsIENoaW5hDQpURUyjuis4NisyNS04NjYzMDU2Ni0tODU2OA0KQ09J
TlM6IDc5OTg4NTQ4DQpGQVg6ICs4NisyNS04MzMxNzY4NQ0KTUFJTDogd2FuZ215QGZ1aml0c3Uu
Y29tDQoNCg==

