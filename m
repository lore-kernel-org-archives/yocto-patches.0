Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F06C021AA
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 01:34:38 +0000 (UTC)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
 by mx.groups.io with SMTP id smtpd.web10.39841.1740015271214965193
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Feb 2025 17:34:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=h14BqhU5;
 spf=neutral (domain: fujitsu.com, ip: 216.71.158.62, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740015272; x=1771551272;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version;
  bh=2l16EF+7GUtupr7yG3GUzFXspteDvwj18BXq7AylJyM=;
  b=h14BqhU5+JE9lvHZcSbJ8qv39zTTY8L1nXkQpaDI3HOCeyV/CWzxGs+g
   P/ERRNEf8oklt2hO2LymiyKzhzrW8MQ10UAkXtquv1GGjWr3F5WDLxRDj
   taSJsdZFyjEYNonli1lSHDX5gqILWkabD0evvB1xNX+mmNiYw25acBrUb
   Y6gxcDBl63ua1jHRdgZYA9LfK3OZ00A/yvtgKt8Y8Ik+gszhHpBQdkSJI
   hDYkaGzohq1nnvlfRA021ukusxu5fkwfE0Y65QlecASvaLCOFqJg8Bgfz
   VnQj0cIg39wNtOO6hhvxmAK8MLLML6mO7mxn+Y/xca1FSjkXaJ/JkeV0I
   Q==;
X-CSE-ConnectionGUID: eP3+DZdeTg+x/N4Hvmm3wA==
X-CSE-MsgGUID: WNRUhKkmSZC024phiAE2/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="146436156"
X-IronPort-AV: E=Sophos;i="6.13,300,1732546800"; 
   d="scan'208,217";a="146436156"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:34:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQwE2kHFK9FJEKhZGAQ9QRtvxWLhFbZmFOoN1pjpXWVCYS6j0Toac+Rr88Slk+/qWYvtrePJjVOFHgRGK1GAxHzWyelq/JqZuGDIJcAwR61oalwSL/CH5uiCxF2iN589pVFZLA17nbCOFn1feJ2j7MxBflyoy5CnLJ0nHGbi9HYAzffER4IlW3OZlz0ZL8W2+v/vBAqVmQ7uEEybwbfSoDzEYpQtIxRqscjBQfWHiFvhfBNsADx7T+dFl80lqXz3TW25LDvhs01Wrc9zFnsYZMpRd8PZfgJsQQQwnfE59JUmevRq0xM7BbFF/kbYjYcbSaekT58qiYUCKLLAy2RMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrK4y1u17kgc6gApFJuNoUSoQG+qPbUK/+84CfPOFW8=;
 b=ANwOGJEAt3FN55PytQkAP+4dagWR050a7Xh6bf9imJlbtQJeBFEywIxI3u7kxs5+n/RuxWIqUHS/tD+ptIje25gV5lxSp/HRZPZf2EzK9x5CznZaJa+4Lh9R984ZvByYQkT4K+gj0Cwrif4Th9hhTFPo8c/8wNhKq/VlPd7LM+T4tnE8SlY4+Mn2WR6oSHx/VzrxELHbpXER8lt+VFmYoc5ekFN1MhzRp/YxeqfFq8t6zwxtgZqijZiBOdIlFCUAStnfk+G8Kd6eqssHZoNQ4vnOXnNIT7dFi4b6GmmeAONgDKPtL0mnL81QujwU5+mHnaCdv4nBCpGmwLy7cvcz9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB11866.jpnprd01.prod.outlook.com (2603:1096:400:3e2::9)
 by OSCPR01MB13197.jpnprd01.prod.outlook.com (2603:1096:604:351::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 01:34:25 +0000
Received: from TYCPR01MB11866.jpnprd01.prod.outlook.com
 ([fe80::f4d1:30d2:5ee6:b340]) by TYCPR01MB11866.jpnprd01.prod.outlook.com
 ([fe80::f4d1:30d2:5ee6:b340%2]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 01:34:24 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-java] Issue of cacao
Thread-Topic: [yocto-patches] [meta-java] Issue of cacao
Thread-Index: AduCZ6VoCCyyKLONQkmHYtLFdNLtLwABSX1VADIzU8A=
Date: Thu, 20 Feb 2025 01:34:24 +0000
Message-ID: 
 <TYCPR01MB11866300AB8ED4CC1ABF35A33DCC42@TYCPR01MB11866.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB118615E9B023329FEAEB33BB4DCC52@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <ME3P282MB2531E2579509BA59013A585E94C52@ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: 
 <ME3P282MB2531E2579509BA59013A585E94C52@ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=76b55954-76f3-455e-bd5f-98deff22e0a0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-02-20T01:20:19Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11866:EE_|OSCPR01MB13197:EE_
x-ms-office365-filtering-correlation-id: 0ae83e34-701c-40e5-99d7-08dd514eb53c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|4022899009|376014|1800799024|366016|1580799027|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?gb2312?B?eUxncWFQZVE3Mk9PM1c0ZzFZMlBIZDdVa1B6U2l5U1paR3k3QjRjcGxkU2hY?=
 =?gb2312?B?UjQzdkhCb1FPLzRISjhZNWQ0NnlzMS9ZdHdwYjNFeEFHc1FRY2JMRUd3cU1q?=
 =?gb2312?B?ek1vWWFpdURtTXJQc0RkU29pNnFTV0x4ZlJvZ1A2dll2azJhK0hid05NUW1t?=
 =?gb2312?B?RVhMSmU2MTdTQm1Ec2ZsdUhUSU9JL1RNNEZ3VGpLUkxQY3liaU1xeGpjOWhB?=
 =?gb2312?B?Z3N1SHNiYzVzNjd5a2FjMmxMZkdDTVZHcEtsNXhqNkVETFAxaWdVaG5LN0ZV?=
 =?gb2312?B?LzFvYUR6eUtoUllieGR1aG95Y29HWnNiTkozTTRUMVhUUGlScnN4bmVPUEhG?=
 =?gb2312?B?VCtubFNoY2tTbWtGTG5vbm5BY2Y5eUxuSEpVSS83eWFkNVNzUFN4TmhDSkRL?=
 =?gb2312?B?MUNFOUZPQlFjMXZXK0hzTm01ZGhnK0RoQlhhTFc3SjFQak10a3FXcnY0Y09B?=
 =?gb2312?B?aTJ4MmRVTDBFSUVyc3luYzNaSGk5cE5JS21KelJTZGVaNjhPb1ZWTzZVT1Bn?=
 =?gb2312?B?L3FhMFVHS1V2THNqVGVhL051Vy8vMUhTd09hQUJ2cHljcGpMYkg2c3YvcVlW?=
 =?gb2312?B?ZW9DdTZ5SzJXYnlsS2pMczZhUEhTQUpwS1VvUGdPQUxOMnJUUWRCM1JxN0pz?=
 =?gb2312?B?SEloWS9wcHNnWkswNEU4enljZG1UQ1Z4bjZGYW0xZFlqMVVwWnNlNGZ6a3dH?=
 =?gb2312?B?SC9veEtRbisxMXZPTys1alRzSi9Jby9tNmVUdGxpRkVMY3k0YkVPNWJFVmdh?=
 =?gb2312?B?Q20vbm5WZU1xQkxMQXY1S05oZmFsMmozUDdqblBGWm0waFVqOWdoNUc5bnpm?=
 =?gb2312?B?YWlYZ0s5dWY3dHBpZkVXY3ZZSi95ajY3T3V0d0RDcUJyTU1waXRkcytSVDZm?=
 =?gb2312?B?TGMxcmxuQUFPR2pZSVhBMkl1N1duMW04VUZFV3JWSnBNV0ZqMGVTaE0zNFlY?=
 =?gb2312?B?UjExNjdCWTVwL05GTDdCRnRsWG9RQzd0RHVEQXU5TFRickF2dDB4UEpFUnht?=
 =?gb2312?B?d3pxbm5tSnJScm4vV1orZHRyQ0kybjNmS3ptK0c1ZFVNVE1sWlNKTzNmejY1?=
 =?gb2312?B?L3k3VXNyZ29vbGh6bHFMSC9wU1NqVkFnVlEvQzVNV3F2VTUrVGVTNEZ5dkZU?=
 =?gb2312?B?ZzEwZmxZWm5iYnBYa2x6ZDNramR3RWZ3aHVMaFVKdzJyZ3Znd3dRWlRyZWl2?=
 =?gb2312?B?VWRCYWxOeVlnNUpoRXMvbnMvVUl1TWVUWkpVYmtpTHJPTE1uQ2locnErQ054?=
 =?gb2312?B?VTVyaDZyLzdWRVFod2V6cU9qSGtwc1JhUHJrY1NtZUtEdy9iZVc4a1M3NU50?=
 =?gb2312?B?RVV2d3lXSEhCWUFrbmJLeENjVDFnQUVLaXhWRWhqWFAxZlV1NURzMWFzV0dK?=
 =?gb2312?B?VXk3K21hN1pRN3UvdU5aeWh5WHE4NHlDZmt2akJzS2dBUGNGM0R1UnFhd0sw?=
 =?gb2312?B?R01IMzg4aldud01WS3FwUUZoMmg4RkZaMHY1T2IvQzl1VXM1a3BRSXJrRGpo?=
 =?gb2312?B?TmpFWjRaSDhycjFkY0VvZ2o5WDgxZ2J0YWMvNXRJQXI4d0ZRZmJwN0Z1cEZn?=
 =?gb2312?B?WlA2eTIwQm02R3lybzJVL2dRNXpuL1A5NnpQSG8vMXJoL0dvd3l4YnFTTkQ2?=
 =?gb2312?B?RkxGelZPSFRJSDhNdU9QK1d5c1dxU0NrdTZGcGlSQk10REFrR2Z3bDJ6RmIw?=
 =?gb2312?B?aTFtMnNRQWlOT2t6bm5kdnpFUkFzRjFuM1d1enBCZnU3UW5NNFo5WUVMSWNv?=
 =?gb2312?B?QlU3QVhmRUdVWVdKcHJ2SDhHOXRVZS9FOFdmcWFUSS9zcVI5RUVBUlRwZkR0?=
 =?gb2312?B?eGVwLzdxcURlQ04xVzBDMDBXeVlCKzA3T2o1MVVBZ2hCR2pRaEtWTXZwVmow?=
 =?gb2312?B?c1pyMDYxMGNXN0ZrNXFQN2JZV01BQVdiVzZKaEhqNTNJSlE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11866.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016)(1580799027)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?c0hRRTM5Uk5mRHpreWpuMDd6MUR0OU53SGNnc05HRzdiSHlEQlhYai9RbkhV?=
 =?gb2312?B?RjViSG9BWVBxbEtjeFoxcjhkVkZTcFlMSUZUbE1ndVppdnl5Z0ZQUDVoVkhS?=
 =?gb2312?B?ZlJ6bnl0Z1FlQjZncFhnUzlpZVJTSEhMdUg3VGRlTmxUNnhHcmpaKzdrSWZ1?=
 =?gb2312?B?TFJvNHpMN0dMeTlZZjd4b2ROZ1VVKzhIV3kzc2Rqb3dmZU1OVVE2K01lZ2ln?=
 =?gb2312?B?RDFITlE3ZHNxazlqeGVZOTlWOXlLVS9nNjBjVkNoZEtsb1IyUnJaZ09GSGR1?=
 =?gb2312?B?QTIyTERxNmJHSmYxWEFPR1RHMWpMbXFndTVvZjJpNlNaVnRtZjE4aEkrNjBO?=
 =?gb2312?B?QU1yZnpnaDlPUjJyWnd2MlpoTVRudnNqZjRuYWlVa0k2UURINjR2S1I4aXdv?=
 =?gb2312?B?bXRZbkNudGVrRUFSMmNuYWJYUjFuS2lUOENqQzB4RWxBdi9iSU53YU91SXAr?=
 =?gb2312?B?NGlCaldoY2RtMEplZzdQaW85TVFVOWo0YmxyYVFZMTJ2QkYyb1JTeDlsQm5F?=
 =?gb2312?B?S3gwQTM1R2V3bWxiZk9qNjYwSllHZy9RdXVJVGJZbDFkVEJZM3JhUjRjcWdh?=
 =?gb2312?B?Mm40SFZXVHBBVDl4MTVKVE5YOW1mb3RFeXdUU04zaVlHb3RLSHZTaUkyUlpa?=
 =?gb2312?B?aWt5ZnhJUmtSaEtCZVhac1dXeGQwcm4rUDErNm9MZlNpYWcwSkxIVDQxWnd5?=
 =?gb2312?B?TlhTVk9tb3kvYk0zc2lPYm9qdWtQWXlxaVNZOE9renZCSXdSdEJtRlNEZHh5?=
 =?gb2312?B?SGw0bjJRWDRXNldSZkxuS0JJZmR0bWtlV3lBMmJzRFdZUnlFQXQycDZqSDg3?=
 =?gb2312?B?SzRNcG04WVM0ZUpHVmUvNHlhQlVDRkJYNklIRmVMb0djLzFlQzQ4S1NzUGdL?=
 =?gb2312?B?UUtkRkNuOW1Yd0J2RjAvbUg0K3IrdXo0cDlNQk16Q3BTUzBpTkt6MnVSU25t?=
 =?gb2312?B?Wkt0UWN6Zk5lcmN5NWFqa1M3QkIvOWl4MC9udVBFcU9jVGt4c0VzbDIzRnhS?=
 =?gb2312?B?Vm1QZUs5b0EzdFlFRGx0L1FPQjZCL1hlbTFFWXJPNEc5R0xRR212ejRUdWM5?=
 =?gb2312?B?Q1grMVh5WlRaNnErakRGeGU4WVA4R2xyUFBJWFBDOWJacmdoNjMvUzdYbW1x?=
 =?gb2312?B?dXh5VXJUNk1EVlZwQUhiZFY1MXRRN3V2WWZMcStTOVllanI4MXdkUExKV3dm?=
 =?gb2312?B?SXh5QU5uT09IN0pCTUVqK3B1YmFNRUZaWDFYQ1p3eG9uc2psZ0tjU1U4SmVQ?=
 =?gb2312?B?QkJKWUhxTE01MFE4YjZ5Q2hObGEybkxGSXc0aU4zdDZWaHVBSUlqZzZ0cXZB?=
 =?gb2312?B?VTJKWEVrMlFSYnhMaWdnSEJLamtkK1RRTzhtMGlLejhCOGRYNFY5NmJlaTQ3?=
 =?gb2312?B?bHRBVUtZeFBPRmtxaXRERUhxcmN6ck1DeVd4Z0E0MzdKYk5TQTZGT1dpZlU3?=
 =?gb2312?B?RmZ6am1BRi85NU1qMVpxOEhKV1RzMEc0blR2QStRRkM4eTVnVTZyTWtsTWxT?=
 =?gb2312?B?VUl6WENRNkRreVBTbjZPaHQzcEpTa3ozbDhNRzhCVXBDTmJWTEZiNmdZQU5k?=
 =?gb2312?B?U0lweVV5amplY3ZTdnFRV3B5MlpWTkJycW9NTzZlc3hmb21jSXlGanlSNnJ2?=
 =?gb2312?B?djRSei9Zb2YvRGZrbmZ0WDdEWXFZcUl0Qmdma01hc1dvMTF2S0tRU01tSlk4?=
 =?gb2312?B?eVgrMTRTalJkeFRPU3JCOHliV0JNdXZKdjNMTUR0U1FScGdEbW1mSU96clFG?=
 =?gb2312?B?Rkl3ckVZU2ExTEFUUUVqcm1RRXlsT2xuQWtKNnk2T1pjYXQxQStwNWtyYVBD?=
 =?gb2312?B?Q3BxdklNcnAzY292NnY5SDFZakhwekc4RGZFMlFrTUVGVTRsaEZKZU12UWlI?=
 =?gb2312?B?eXgxbHkzeFBvZFo0Q1ZldW5xSjJMWGhJWk1EdmhjLzRDNGtBeFk1OGtTZjlJ?=
 =?gb2312?B?K3V3SXVVUFcvQ1dPdkk1S0szeFpMZFBDbUpGbysvb0NZeDRnTVZGbXYwaTBO?=
 =?gb2312?B?K0RQNGlwV3dFcmEzT2VhUm14TzFLbEJ5eHBJQjloeFdTaE9CK0VCajdoclAr?=
 =?gb2312?B?dStyeEc2Yml3U1pPS1dzZVMveENsUzhSbTJ1UHQ2Nm82a0k2c0xBb1ZTM3FM?=
 =?gb2312?Q?kSOPafmblEMOIKEXiHK/fDVmC?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB11866300AB8ED4CC1ABF35A33DCC42TYCPR01MB11866jp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V8IkcaH8U53r4pgyVL/6pEANhRhm+xw3335vAoTk19S5vy6YgTu2E1HJAmlsA9YSRfUqEuq4mgUUFCyfnA1CzvOzL/wUN8Xj698JWoXMLQkipI6rUsvyXKHASH58jdQV8MxIFcNoCL+qXcx0pkf+/0U02YKTwg0bqNM1SJHjyB3Vqshd/RORFM1P57fVzOd3Y9U2tyjtbpv/NtNXHLFOjEEqvttIAj12/O3LHFUD7jpBXbpDC3Z8ICDVwIhZxeqw63gyhSZ6ARAm1VhIgh5tcHRb9bCG0jB+Nb3/uw8kkd7elsAzVLkK8Ji0zgzPzic+ZW9abUr6sdPg4ppxBpqTZDQz29LEEzVhIsFWNz7QK42A/8bLdFfrSMpKmcqI/vnqFJYatXqsQyVMxr0NBbtMbz8LpRXjYSpZZ+LpL/DobzauE2UEqAonQKjE00k27GGsi+6Uk3QG5nRgjU0T1vfQdCM+vd9AaqzvalWgTGHyDcc3jkcF7xBhuh20Q4Gzwj5j2zdOCGroV7cgZotiXwTACWpTu8hET1fCi/xUjfCGRuxj2ovr1npyOvu0NH+7rKr7o+wcLvP2xah+qYlreLSd3JCz7PzxG8NCrOBm4ULyNXTMbvGCIdaAoRALRdybQFnc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11866.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae83e34-701c-40e5-99d7-08dd514eb53c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 01:34:24.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ur5DCy6SZAkfikmC84NmBaJRHjPCY1uleqcPe6mztk28koZCtDCK3Mvy2GoVmCGq0FuFzy5Z+zMJitKVmbbprA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13197
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 01:34:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1095

--_000_TYCPR01MB11866300AB8ED4CC1ABF35A33DCC42TYCPR01MB11866jp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

VGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgcHJvdmlkaW5nIHRoaXMgcGF0Y2guIENhY2FvIGlzIG5v
dyBmaW5lLiBIb3dldmVyLCB0aGVyZSB3YXMgYW4gaXNzdWUgd2l0aCB0aGUgYnVpbGQgb2YgQXZh
bG9uLWZyYW1ld29yay1uYXRpdmUuDQoNCk1heSBJIGFzayBpZiB0aGVyZSBpcyBjdXJyZW50bHkg
YSBzb2x1dGlvbiB0byB0aGlzIGlzc3VlPw0KDQpUaGUgc3BlY2lmaWMgaW5mb3JtYXRpb24gaXMg
YXMgZm9sbG93czoNCnwgVGhlIHNlcmlhbGl6YWJsZSBjbGFzcyBQYXJhbWV0ZXJFeGNlcHRpb24g
ZG9lcyBub3QgZGVjbGFyZSBhIHN0YXRpYyBmaW5hbCBzZXJpYWxWZXJzaW9uVUlEIGZpZWxkIG9m
IHR5cGUgbG9uZw0KfCAtLS0tLS0tLS0tDQp8IC0tLS0tLS0tLS0NCnwgMTIuIEVSUk9SIGluIHNy
Yy9qYXZhL29yZy9hcGFjaGUvYXZhbG9uL2ZyYW1ld29yay9sb2dnZXIvTG9nZ2FibGUuamF2YSAo
YXQgbGluZSAzNCkNCnwgdm9pZCBzZXRMb2dnZXIoIG9yZy5hcGFjaGUubG9nLkxvZ2dlciBsb2dn
ZXIgKTsNCnwgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eDQp8IG9yZy5hcGFjaGUubG9n
IGNhbm5vdCBiZSByZXNvbHZlZCB0byBhIHR5cGUNCg0KIC0tDQpCZXN0IFJlZ2FyZHMNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KV2FuZyBNaW5n
eXUNCkZVSklUU1UgTkFOSklORyBTT0ZUV0FSRSBURUNITk9MT0dZIENPLiwgTFRELiAoRk5TVCkN
Ck5vLjYgV2Vuemh1IFJvYWQsIE5hbmppbmcsIDIxMDAxMiwgQ2hpbmENClRFTKO6Kzg2KzI1LTg2
NjMwNTY2LS04NTY4DQpDT0lOUzogNzk5ODg1NDgNCkZBWDogKzg2KzI1LTgzMzE3Njg1DQpNQUlM
OiB3YW5nbXlAZnVqaXRzdS5jb208bWFpbHRvOndhbmdteUBmdWppdHN1LmNvbT4NCg0KRnJvbTog
eW9jdG8tcGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnIDx5b2N0by1wYXRjaGVzQGxpc3Rz
LnlvY3RvcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBEb3VnbGFzIFJveWRzIHZpYSBsaXN0cy55
b2N0b3Byb2plY3Qub3JnDQpTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDE5LCAyMDI1IDk6MjYg
QU0NClRvOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNClN1YmplY3Q6IFJl
OiBbeW9jdG8tcGF0Y2hlc10gW21ldGEtamF2YV0gSXNzdWUgb2YgY2FjYW8NCg0KWWVzLCB5b3Ug
d2lsbCBuZWVkIHRoaXMgcGF0Y2gsIHdoaWNoIGhhc24ndCBmb3VuZCBpdHMgd2F5IGludG8gbWV0
YS1qYXZhIHlldDoNCg0KICBbUEFUQ0ggMi8yXSBjYWNhby1uYXRpdmU6IHBhdGNoIHRvIGJlIGJ1
aWxkYWJsZSB3aXRoIGdjYzEzPGh0dHBzOi8vbGlzdHMub3BlbmVtYmVkZGVkLm9yZy9nL29wZW5l
bWJlZGRlZC1kZXZlbC9tZXNzYWdlLzExMzkwNj4NCg0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KRnJvbTogeW9jdG8tcGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnPG1h
aWx0bzp5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IDx5b2N0by1wYXRjaGVz
QGxpc3RzLnlvY3RvcHJvamVjdC5vcmc8bWFpbHRvOnlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9w
cm9qZWN0Lm9yZz4+IG9uIGJlaGFsZiBvZiB3YW5nbXkgdmlhIGxpc3RzLnlvY3RvcHJvamVjdC5v
cmcgPHdhbmdteT1mdWppdHN1LmNvbUBsaXN0cy55b2N0b3Byb2plY3Qub3JnPG1haWx0bzp3YW5n
bXk9ZnVqaXRzdS5jb21AbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4+DQpTZW50OiAxOSBGZWJydWFy
eSAyMDI1IDEzOjQ2DQpUbzogeW9jdG8tcGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnPG1h
aWx0bzp5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IDx5b2N0by1wYXRjaGVz
QGxpc3RzLnlvY3RvcHJvamVjdC5vcmc8bWFpbHRvOnlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9w
cm9qZWN0Lm9yZz4+DQpTdWJqZWN0OiBbeW9jdG8tcGF0Y2hlc10gW21ldGEtamF2YV0gSXNzdWUg
b2YgY2FjYW8NCg0KV2hlbiBleGVjdXRpbmcgdGhlIGNvbW1hbmQgYml0YmFrZSBvcGVuamRrLTgs
IGNhY2FvIGVuY291bnRlcmVkIHRoZSBmb2xsb3dpbmcgZXJyb3I6DQoNCi91c3IvaW5jbHVkZS9j
KysvMTMvYml0cy9zdGxfbGlzdC5oOjIwMzE6Mzc6IGVycm9yOiBubyBtYXRjaCBmb3IgJEIhRihC
b3BlcmF0b3IhPSRCIUcoQiAob3BlcmFuZCB0eXBlcyBhcmUgJEIhRihCc3RkOjpfX2N4eDExOjpf
TGlzdF9iYXNlPGJyYW5jaF9sYWJlbF9yZWZfdCosIER1bXBNZW1vcnlBbGxvY2F0b3I8YnJhbmNo
X2xhYmVsX3JlZl90Kj4NCg0KOjpfTm9kZV9hbGxvY190eXBlJEIhRyhCIHtha2EgJEIhRihCc3Rk
OjphbGxvY2F0b3JfdHJhaXRzPER1bXBNZW1vcnlBbGxvY2F0b3I8YnJhbmNoX2xhYmVsX3JlZl90
Kj4gPjo6cmViaW5kX2FsbG9jPHN0ZDo6X0xpc3Rfbm9kZTxicmFuY2hfbGFiZWxfcmVmX3QqPiA+
JEIhRyhCfSBhbmQgJEIhRihCY29uc3Qgc3RkOjpfX2N4eDExOjpfTGlzdF9iYXNlPGJyDQphbmNo
X2xhYmVsX3JlZl90KiwgRHVtcE1lbW9yeUFsbG9jYXRvcjxicmFuY2hfbGFiZWxfcmVmX3QqPiA+
OjpfTm9kZV9hbGxvY190eXBlJEIhRyhCIHtha2EgJEIhRihCc3RkOjphbGxvY2F0b3JfdHJhaXRz
PER1bXBNZW1vcnlBbGxvY2F0b3I8YnJhbmNoX2xhYmVsX3JlZl90Kj4gPjo6cmViaW5kX2FsbG9j
PHN0ZDo6X0xpc3Rfbm9kZTxicmENCm5jaF9sYWJlbF9yZWZfdCo+ID4kQiFHKEJ9KQ0KDQpUaGlz
IGlzc3VlIG9jY3VycmVkIGFmdGVyIHVwZ3JhZGluZyB0aGUgY29tcGlsYXRpb24gZW52aXJvbm1l
bnQgdG8gVWJ1bnR1IDI0LjA0Lg0KVGhlIHVwc3RyZWFtIG9mIGNhY2FvIGhhcyBub3QgYmVlbiBt
YWludGFpbmVkIGZvciBhIGxvbmcgdGltZSAodGhlIGxhc3QgdGltZSB3YXMgaW4gMjAyMCkuDQpB
cmUgdGhlcmUgYW55IHBsYW5zIHRvIG1ha2UgbW9kaWZpY2F0aW9ucyB0byBjYWNhbyB0aGF0IGFy
ZSBjb21wYXRpYmxlIHdpdGggVWJ1bnR1IDI0LjA0IGluIHRoZSBmdXR1cmU/DQoNCiAgLS0NCkJl
c3QgUmVnYXJkcw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQpXYW5nIE1pbmd5dQ0KRlVKSVRTVSBOQU5KSU5HIFNPRlRXQVJFIFRFQ0hOT0xPR1kg
Q08uLCBMVEQuIChGTlNUKQ0KTm8uNiBXZW56aHUgUm9hZCwgTmFuamluZywgMjEwMDEyLCBDaGlu
YQ0KVEVMJEIhJyhCKzg2KzI1LTg2NjMwNTY2LS04NTY4DQpDT0lOUzogNzk5ODg1NDgNCkZBWDog
Kzg2KzI1LTgzMzE3Njg1DQpNQUlMOiB3YW5nbXlAZnVqaXRzdS5jb208bWFpbHRvOndhbmdteUBm
dWppdHN1LmNvbT4NCl8uXyxfLl8sXw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
CkxpbmtzOg0KDQpZb3UgcmVjZWl2ZSBhbGwgbWVzc2FnZXMgc2VudCB0byB0aGlzIGdyb3VwLg0K
DQpWaWV3L1JlcGx5IE9ubGluZSAoIzEwOTEpPGh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9y
Zy9nL3lvY3RvLXBhdGNoZXMvbWVzc2FnZS8xMDkxPiB8IFJlcGx5IHRvIEdyb3VwPG1haWx0bzp5
b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc/c3ViamVjdD1SZTolMjBSZSUzQSUy
MCU1QnlvY3RvLXBhdGNoZXMlNUQlMjAlNUJtZXRhLWphdmElNUQlMjBJc3N1ZSUyMG9mJTIwY2Fj
YW8+IHwgUmVwbHkgdG8gU2VuZGVyPG1haWx0bzpkb3VnbGFzLnJveWRzQHRhaXRjb21tdW5pY2F0
aW9ucy5jb20/c3ViamVjdD1Qcml2YXRlOiUyMFJlOiUyMFJlJTNBJTIwJTVCeW9jdG8tcGF0Y2hl
cyU1RCUyMCU1Qm1ldGEtamF2YSU1RCUyMElzc3VlJTIwb2YlMjBjYWNhbz4gfCBNdXRlIFRoaXMg
VG9waWM8aHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL210LzExMTI2MjI4My81OTc0OTQ2
PiB8IE5ldyBUb3BpYzxodHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvZy95b2N0by1wYXRj
aGVzL3Bvc3Q+DQpZb3VyIFN1YnNjcmlwdGlvbjxodHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5v
cmcvZy95b2N0by1wYXRjaGVzL2VkaXRzdWIvNTk3NDk0Nj4gfCBDb250YWN0IEdyb3VwIE93bmVy
PG1haWx0bzp5b2N0by1wYXRjaGVzK293bmVyQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IHwgVW5z
dWJzY3JpYmU8aHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9s
ZWF2ZS8xMzYxNDI3MS81OTc0OTQ2LzE5MDI4MzEwNjYveHl6enk+IFt3YW5nbXlAZnVqaXRzdS5j
b21dDQpfLl8sXy5fLF8NCg==

--_000_TYCPR01MB11866300AB8ED4CC1ABF35A33DCC42TYCPR01MB11866jp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF">Thank you very much for providing this patch. Cacao is=
 now fine. However, there was an issue with the build of Avalon-framework-n=
ative.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF">May I ask if there is currently a solution to this iss=
ue?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF">The specific information is as follows:<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF">| The serializable class ParameterException does not d=
eclare a static final serialVersionUID field of type long<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF">| ----------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF">| ----------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF">| 12. ERROR in src/java/org/apache/avalon/framework/lo=
gger/Loggable.java (at line 34)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF">| void setLogger( org.apache.log.Logger logger );<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF">|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^^^^^^<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF">| org.apache.log cannot be resolved to a type<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"text-align:justify;text-justify:inter-ideog=
raph"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;MS M=
incho&quot;;mso-ligatures:standardcontextual">&nbsp;--<o:p></o:p></span></p=
>
<p class=3D"MsoNormal" style=3D"text-align:justify;text-justify:inter-ideog=
raph"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;MS M=
incho&quot;;mso-ligatures:standardcontextual">Best Regards<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-align:justify;text-justify:inter-ideog=
raph"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;MS M=
incho&quot;;mso-ligatures:standardcontextual">-----------------------------=
----------------------<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-align:justify;text-justify:inter-ideog=
raph"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;MS M=
incho&quot;;mso-ligatures:standardcontextual">Wang Mingyu<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-align:justify;text-justify:inter-ideog=
raph"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;MS M=
incho&quot;;mso-ligatures:standardcontextual">FUJITSU NANJING SOFTWARE TECH=
NOLOGY CO., LTD. (FNST)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-align:justify;text-justify:inter-ideog=
raph"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;MS M=
incho&quot;;mso-ligatures:standardcontextual">No.6 Wenzhu Road, Nanjing, 21=
0012, China<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-align:justify;text-justify:inter-ideog=
raph"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;MS M=
incho&quot;;mso-ligatures:standardcontextual">TEL</span><span style=3D"font=
-size:10.5pt;font-family:&quot;MS Mincho&quot;;mso-ligatures:standardcontex=
tual">=A3=BA<span lang=3D"EN-US">+86+25-86630566--8568<o:p></o:p></span></s=
pan></p>
<p class=3D"MsoNormal" style=3D"text-align:justify;text-justify:inter-ideog=
raph"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;MS M=
incho&quot;;mso-ligatures:standardcontextual">COINS: 79988548<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"text-align:justify;text-justify:inter-ideog=
raph"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;MS M=
incho&quot;;mso-ligatures:standardcontextual">FAX: +86+25-83317685<o:p></o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"text-align:justify;text-justify:inter-ideog=
raph"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;MS M=
incho&quot;;mso-ligatures:standardcontextual">MAIL:
<a href=3D"mailto:wangmy@fujitsu.com"><span style=3D"color:#0563C1">wangmy@=
fujitsu.com</span></a><o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:=B5=C8=CF=DF"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"EN-=
US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> =
yocto-patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoctoproject.o=
rg&gt;
<b>On Behalf Of </b>Douglas Royds via lists.yoctoproject.org<br>
<b>Sent:</b> Wednesday, February 19, 2025 9:26 AM<br>
<b>To:</b> yocto-patches@lists.yoctoproject.org<br>
<b>Subject:</b> Re: [yocto-patches] [meta-java] Issue of cacao<o:p></o:p></=
span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black">Yes, you will need this patch, which hasn't=
 found its way into meta-java yet:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black">&nbsp;
<a href=3D"https://lists.openembedded.org/g/openembedded-devel/message/1139=
06" title=3D"https://lists.openembedded.org/g/openembedded-devel/message/11=
3906">
[PATCH 2/2] cacao-native: patch to be buildable with gcc13</a><o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 lang=3D"EN-US">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif;color:black">From:</span></b><span=
 lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">&nbsp;<a href=3D"mailto:yocto-patches@lists.yoctopro=
ject.org">yocto-patches@lists.yoctoproject.org</a>
 &lt;<a href=3D"mailto:yocto-patches@lists.yoctoproject.org">yocto-patches@=
lists.yoctoproject.org</a>&gt; on behalf of wangmy via lists.yoctoproject.o=
rg &lt;<a href=3D"mailto:wangmy=3Dfujitsu.com@lists.yoctoproject.org">wangm=
y=3Dfujitsu.com@lists.yoctoproject.org</a>&gt;<br>
<b>Sent:</b>&nbsp;19 February 2025 13:46<br>
<b>To:</b>&nbsp;<a href=3D"mailto:yocto-patches@lists.yoctoproject.org">yoc=
to-patches@lists.yoctoproject.org</a> &lt;<a href=3D"mailto:yocto-patches@l=
ists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</a>&gt;<br>
<b>Subject:</b>&nbsp;[yocto-patches] [meta-java] Issue of cacao</span><span=
 lang=3D"EN-US">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">When=
 executing the command bitbake openjdk-8, cacao encountered the following e=
rror:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><br>
/usr/include/c++/13/bits/stl_list.h:2031:37: error: no match for $B!F(Boper=
ator!=3D$B!G(B (operand types are $B!F(Bstd::__cxx11::_List_base&lt;branch_=
label_ref_t*, DumpMemoryAllocator&lt;branch_label_ref_t*&gt;<br>
<br>
::_Node_alloc_type$B!G(B {aka $B!F(Bstd::allocator_traits&lt;DumpMemoryAllo=
cator&lt;branch_label_ref_t*&gt; &gt;::rebind_alloc&lt;std::_List_node&lt;b=
ranch_label_ref_t*&gt; &gt;$B!G(B} and $B!F(Bconst std::__cxx11::_List_base=
&lt;br<br>
anch_label_ref_t*, DumpMemoryAllocator&lt;branch_label_ref_t*&gt; &gt;::_No=
de_alloc_type$B!G(B {aka $B!F(Bstd::allocator_traits&lt;DumpMemoryAllocator=
&lt;branch_label_ref_t*&gt; &gt;::rebind_alloc&lt;std::_List_node&lt;bra<br=
>
nch_label_ref_t*&gt; &gt;$B!G(B})<br>
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
TEL$B!'(B+86+25-86630566--8568<br>
COINS: 79988548<br>
FAX: +86+25-83317685<br>
MAIL: <a href=3D"mailto:wangmy@fujitsu.com">wangmy@fujitsu.com</a><o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:white">_._,_._,_=
<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 lang=3D"EN-US">
<hr size=3D"2" width=3D"100%" align=3D"center">
</span></div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Links:<o:p></o:p></span></p>
<p><span lang=3D"EN-US">You receive all messages sent to this group. <o:p><=
/o:p></span></p>
<p><span lang=3D"EN-US"><a href=3D"https://lists.yoctoproject.org/g/yocto-p=
atches/message/1091" target=3D"_blank">View/Reply Online (#1091)</a> |
<a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3=
A%20%5Byocto-patches%5D%20%5Bmeta-java%5D%20Issue%20of%20cacao" target=3D"_=
blank">
Reply to Group</a> | <a href=3D"mailto:douglas.royds@taitcommunications.com=
?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-java%5D%2=
0Issue%20of%20cacao" target=3D"_blank">
Reply to Sender</a> | <a href=3D"https://lists.yoctoproject.org/mt/11126228=
3/5974946" target=3D"_blank">
Mute This Topic</a> | <a href=3D"https://lists.yoctoproject.org/g/yocto-pat=
ches/post">
New Topic</a> <br>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/5974946">=
Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org">Contact Group=
 Owner</a> |
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13614271/59=
74946/1902831066/xyzzy">
Unsubscribe</a> [wangmy@fujitsu.com]<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:white">_._,_._,_=
<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_TYCPR01MB11866300AB8ED4CC1ABF35A33DCC42TYCPR01MB11866jp_--

