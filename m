Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A87C369A2
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 07:15:35 +0000 (UTC)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
 by mx.groups.io with SMTP id smtpd.web10.9731.1727248525273062857
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Sep 2024 00:15:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=h8sPIP/8;
 spf=neutral (domain: fujitsu.com, ip: 68.232.159.83, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1727248525; x=1758784525;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=2aKVulhJxFtZUvB9w7OaPFgL0yBy7xtYxHnboUbLJdo=;
  b=h8sPIP/8xrSbZKH8qr/yaXxA687aldXzWx2skPEUXFQ8L0E73lFtuXbh
   /zEJnwiJaYWe4OLdNvL7EaqIya4mXq2qtiMYVOlhvVgJ2HQywpw0pdIJF
   OHYgWDRTmcBoXH4nEAMs+/rVzNSrzwl/Mc0BtVMrqnpGSywhn9zFfZy29
   OYEoWjCJn48aKO7IThI+dmxOTSi63QNiH63PW/M1/aRAaWuTh6Ip1tgSs
   F+5SmS74BVFAMmSn70rYJQNIHki6Ngx8G/0Gujw9JN0Ky1N4HvCvws5mv
   gwSwvQtlKFv2wU3nSyTTziqxDptW/PX0tngJoCMFHO93389ds/jOV2XWT
   Q==;
X-CSE-ConnectionGUID: oH6KnWnVSASGJq+9pWBWmQ==
X-CSE-MsgGUID: xb13NYITSAiUaymVEsjqFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="131770785"
X-IronPort-AV: E=Sophos;i="6.10,256,1719846000"; 
   d="scan'208";a="131770785"
Received: from mail-japaneastazlp17010007.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 16:15:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHCGHAYxwtVp136ww6VB8LBjbT//Y5D/ZZwpjXzn2PKpZJlhCGRZLPdXLkEx2sakykkjP2uI0KDc8RseB5AALcd4yEN2POcDzIED042rm8blxWvysDnIopa/YwYOebO1d6aa4oK5u4EDpM/hPBImSlb1GfWBLLZmWkS8vhJPeRVNwRacL1A50Mtv984xBvJhLcjEAbcKHNdcQ/w92CgJjl+0HQUc8lBKTOnxD9m8shIZurP8zUvwt6/2IbTL+1SGN02E+gd5EFHllK8EISI6aITN9zuoWVfUWLm+npwHGLvVvhqKL3O3+WA8968brO9p/VstY53+Htwjp9YBjDu1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aKVulhJxFtZUvB9w7OaPFgL0yBy7xtYxHnboUbLJdo=;
 b=Bl7b8WHDkt6sk6uPdBiEViV3RdSlJlKcJH8xHm7ZQth3+iAyd2WgipTN7cQa1N4W/033DZGcmeiqKoUJKyP1ijyJZtnTWYzjpnsbZQ7983xdRgAqQLWAoS9opjknvUTbDZ1P++ghR5J73d+CoZRmbgEOn5c+pp2i318UeWuDGL6QvhQMbMrW/fnrYECGfbSRcOFqWtgGLbIv6FO+M6qNt4EtSK65D9WvyFouFdtHnpYjuzQtHN0agyrcszPs+pDRp01BC4RzEsQiaSxp0vFyd3jOdqPFdkb8OV+CXD9W34QbBXZ1bkNZLS4mGLYjafDoLOufB+Vw7tqlunHJmWfefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 (2603:1096:400:3fb::13) by OSOPR01MB12137.jpnprd01.prod.outlook.com
 (2603:1096:604:2da::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 07:15:19 +0000
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342]) by TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 07:15:19 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, Jeremy Puhlman <jpuhlman@mvista.com>
Subject: RE: [yocto-patches] [meta-cgl] [PATCH] layer.conf: Add styhead
Thread-Topic: [yocto-patches] [meta-cgl] [PATCH] layer.conf: Add styhead
Thread-Index: AQHbCmLLji4n08phi0CioH+S76p7E7JoIIRQ
Date: Wed, 25 Sep 2024 07:15:19 +0000
Message-ID: 
 <TYWPR01MB118613471977D200F431EA0C3DC692@TYWPR01MB11861.jpnprd01.prod.outlook.com>
References: <1726729681-15869-1-git-send-email-wangmy@fujitsu.com>
 <17F69383CC12E486.22254@lists.yoctoproject.org>
In-Reply-To: <17F69383CC12E486.22254@lists.yoctoproject.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=1584443c-b87f-4f7c-b15a-2b152a97afc9;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-09-25T07:15:05Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11861:EE_|OSOPR01MB12137:EE_
x-ms-office365-filtering-correlation-id: 9338f543-b481-4eaf-b110-08dcdd31d018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|4022899009|38070700018|1580799027;
x-microsoft-antispam-message-info: 
 =?gb2312?B?ZitlQTJuRmZ2Q3ZlZVVwc213U3RPSEhsemRzQ3pxUVNlWmYxUnJGcjBwYjFJ?=
 =?gb2312?B?MXFCUmZWOTArbEpOaUh4alE4RVhZd1M0MlZwdzVaMlhtYktSNnU5YW5WU1Vo?=
 =?gb2312?B?RUE4ek1HUDNNMTdDT3hkKzdqd01sQUJ5UXhVTldyT0xBVy9sM3NtK21rZHhu?=
 =?gb2312?B?a0RrWERjOExyWkdGNjBOcXVJRG1sUUY0Z3Q0N2w2dzJyL3ZzRjZ4a2oyeFNV?=
 =?gb2312?B?QVRsckQ3eTVKUFlvczhjaCtLMHZRejJBMEREOWNqc1Z3ZEpJVG9xSzRuazQ1?=
 =?gb2312?B?SE5LT3ZYeWltWnVSanpnSDRwUHhlWGNvRjBBZnAvY3lMTUpnd2FzcWhFdnVm?=
 =?gb2312?B?THJvMEhyTU04dEJMRGRpQ3RSaGdFdHhjWkhEenBJWUdHNkZReGNYQy92bXNO?=
 =?gb2312?B?ajBoRzNVQmNhQU5wL1Q5UldobEpiMDJEaVFPUkNFSFNORi80djFrMThHYVNq?=
 =?gb2312?B?eEovNGhoc0cwTllsc3FCYWEwZEdkdGxVc2RsbjZkNmJkeWFPRjRVVXV1NlI0?=
 =?gb2312?B?TFpqakZTZFVUNllpUHpHelBnbUdmUkErTGJKSkZoSnBibGNOVEY4ckg2MXpK?=
 =?gb2312?B?c0tubHczV0JDL2lDRjhZUkJDZXZoS0hhcGRVc3pXZFk4bDhpRmFLUzhXeXNt?=
 =?gb2312?B?YjkyeEQrWU5ESXQvSWNZVExmaGYySTZkWWZHaUxrSERLQnRaaTlhdm52cEUw?=
 =?gb2312?B?bTF5WC9SekFoV1d6NGJOZVY3QnErR29STEJjOExHODBLOHdvY3hXM2k0ZTRs?=
 =?gb2312?B?cW9iczZxUCtCbzB0cmxRaDRQdEhNM3BLaWt6VEZuTlN3VkkrWi81MlpENFZy?=
 =?gb2312?B?dVhrZjNZSXBjUjUxaU1GUnRSdUNIdFdzSitEVEVwUXM0K2pmWEVYeWZneFFF?=
 =?gb2312?B?SHo3cENEMklOL01GOFlsR0hnWXg3T0RkTm1PU1RDWURudVVHWUZSd0hFU2Zw?=
 =?gb2312?B?aSt5OE1YM3VRVGtiT3F1M1JwaU5jU0tzRUJyY3VkU1dzbWsrTUlkbzkwU1Zm?=
 =?gb2312?B?ZFhpMzVhNmQ2TjNBVTVKUTRFVW45Tmx1Q0w2SkViL0hyMUc1WGg2akFxREZK?=
 =?gb2312?B?azJDSS8xT2Z5UFc5K285REREeC9HalhmYVBqVk1sbEVKQ3c4RnpqeTNRNC9V?=
 =?gb2312?B?L09FWFJUYzhnZzNyeGg5MnpNdkg1bUt2WUI5WlplMGVhcVdicldtRXdBdnlQ?=
 =?gb2312?B?L2llK05zWjcwV1prdGtpTWxka2Zqak9OREgyNE5TREh5U2NjdUR3SkxBK2Nk?=
 =?gb2312?B?SUtoYW1DTFE4clc2enhMNjhlaS80Q1lkbks2SDBwait1bktKZ2dNM3BFTGJR?=
 =?gb2312?B?ZlNhSlVtQjdGZFNCUTQ4a3ZzbVc2dzdYV050M2FJVXdGOG5QZGordzZUUkV1?=
 =?gb2312?B?R05JMFJDTndvdXZmaGNUcCtnUThBOWdpYVBnTHFHY0JvTEVYVytBbWNqb0I5?=
 =?gb2312?B?Q3VsWWx0L09Nd1QrMjhydlpTd3FoZmhQVmFXaVc3cy9UOGFneHcxMTFCVFpG?=
 =?gb2312?B?d2UwZDYyeisvbURwbmg1WFdiSGNSOGptWWltK2JESUsvSFMyeXBWUlZiVklS?=
 =?gb2312?B?ZzlEaTNjRDdNSkU3S0crcmVSV1hkdVpJZXl0Y2RpQ3M5UmJONVl1VlBsei9E?=
 =?gb2312?B?ckViODh1bDhsQzIxd25yWVdwa3dGalFReGRTR0thZlRNOXVDN25tTE53VVlh?=
 =?gb2312?B?ZGQ3dFBQYjBtSDdHQWRkeDk4VXd0amRoTWhMVXRrZ2xPd00yYXJsbHhuNW9Y?=
 =?gb2312?Q?Akr9vVz/XlNRb+Y1UCbsQFJJmm72PU6l5o9Sbx7?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11861.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4022899009)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?S1l1QVNwSkxqa0ViSUJDZjMrQ1FFREYvWHdlUnQxRVFnNlQzMWFVRURsa2lh?=
 =?gb2312?B?eS85aThucmZOemt6TkFjOWNIZTh5ZThCRHhNU1dRVDdjMVRWU2k3K0NZeFFn?=
 =?gb2312?B?Rk15MTAxNURFZGxEM1dqM0tqd2R6MmR4eGd0RTFFQkFjekVsZFhBRzA0MU5i?=
 =?gb2312?B?QmN1WERyY2dFZ2U4T2EweXNEWFZoRlJKeTFSMHVkN2h0dDRsc3dNNXRzeFVz?=
 =?gb2312?B?NVZCMi92a0UvcXBsUURKTncrQjJqbjFOU3Q0YTBBNkF2Z2ZjVkh6QU9FdzhP?=
 =?gb2312?B?blh2Y1hxbzhHNnMyb0tZc0tCb1FIaWhMbG9vU2s5SUpCcU5HdXVKai9pQlB1?=
 =?gb2312?B?RkRxd0hCT0JacXEva3dDMGpoaXAvbmVkUWlYcmd3VTU5NmkvU3IrdmFBY0VO?=
 =?gb2312?B?MkV3WnhGdWdzV2M1QUQ3QTRreFd6KzJEZ0wwMXBkaTlHZzZQWXR6Um1BNENN?=
 =?gb2312?B?TnMvL25ESmhORmdTd21YTW5BS21qeDh1V3Q1WHBMc0pnQ3psaDdUL2VYRkFD?=
 =?gb2312?B?bTBUQUYvd1hBL0tOUUZGSzBRczF4NXdUYml4TzM3QlJGTGhGUW15ODBwTFVn?=
 =?gb2312?B?OGtDczlBMVJSMjRLYW1hbFphVkFqMU1vSWcrSGs1SVdWbEZHMTBBckhLamhw?=
 =?gb2312?B?R0hDZ0JhdjcwTllVV3dGMEtaMjJoT2IwSjZpa0o3VUlLYzFzc2VTSkdhU3Mz?=
 =?gb2312?B?OWZxUm8xbkZ5MzdWWmIvODdkTUozZmwxWW5obEM0bmxpbmZQQWN0amxDSGFw?=
 =?gb2312?B?WGFIdXU2K0w1TkVaWjBidUFyekxEblVDU2hManJqandtVDlpTUJvVmpjcXlO?=
 =?gb2312?B?OUk3ZWtjVXFSN2RSdEhkUDBDRjNOaTFielY0UnUzcG40SExrVi9LaU9KeURT?=
 =?gb2312?B?VnBWMU1Md1ZpMTRObThWbUt2QkpDNXdJbm9IbXMwMW1VVUIrMVV1SkJNTWNp?=
 =?gb2312?B?cXdzeHdNanNWektVSWh4eEdqZzBWREdMaWlvTW5XUVZRM3gzT0tPNHRBZEMv?=
 =?gb2312?B?R0RWbC9jQ2Z3WmhkR0kvRWl4OGhoQjBqZEFoMVdQbkc5bkR1VmtUUXVRWWNB?=
 =?gb2312?B?YXFjMVo0TXM0VXA1S253UnZwcm4rTVpHa2R5UHczZDJZcnhndVdwRTZhNU5D?=
 =?gb2312?B?MVVLRVlQemZMb3ZINkIvbytUa29tcEhxK2phVjhEYmwzTHdKMHBHVFNWOTFE?=
 =?gb2312?B?RjBldWl2Yk9xc0xNaGVDRWRpV3NGdHd6ZnUyOWx2VkZ4YWtMY1JvdmFrSjJR?=
 =?gb2312?B?MkRKTElmZXJtVDgyZ3dENnpWWjBsYWg2b3UxU0RaeUZzSld3SXpFV29VY2Vj?=
 =?gb2312?B?RDBYYlVibXZUSytjT2NKWU85ZGI2Qy9OK05INmdrMEpiYk9BVmIzZlZ1N0VD?=
 =?gb2312?B?WUNVYm1JSFh2ZUkvMThUNmszdnZMdUQxQldRVENBVFptbUdzQUlRMVVINTUv?=
 =?gb2312?B?L09oSE9LcVhseVhHeHZzQ0VWd21VM1owT3Zjc2djQnRtZjBGNW1OTjVRNjVO?=
 =?gb2312?B?TDlBN3h0TVRNb0lmditQbm5DTjNmV1JKVldodnRiU2l5b2xKcW1SSFVtS0FW?=
 =?gb2312?B?NUg1NFBGenhWWFdoRDU0VWE0bkFLQlFIZ0UzeUJnOXg2WGx3dTlWSlFUWkN0?=
 =?gb2312?B?bTdtelJFU2VVVjdEMHprMzdYQno2RnFjbUd6YmNXbTVaVEp5Wml2VExVMmUx?=
 =?gb2312?B?clpFUnRGM0pDL2pJM0xYY1ZuUnBhdStKaFZxQTQzeGhjYjlYME9kWDEvVktO?=
 =?gb2312?B?U0RHRVVFR291M25nd1Jyc2JHeFY5aStiWW9jY1AzY3ZONEJxL3g0UWRxS3Y5?=
 =?gb2312?B?Nys5T2NreUtGaEhjdUlLTHpwQW5LbkFMUE9OV2RMVzUxQnBKU1NHNDlUcW1z?=
 =?gb2312?B?MUNBYnFEdlAxdk1hQmN3UFUxZUpxclFuSlJXL0xzQ0ZZd2hDOGdCWVNteFA1?=
 =?gb2312?B?V1ZodlkrS0tYWXU1eXVnRlJ6bXkzS2JaRHVGTkU5RVkvRnJYSFE4U2RTd3pO?=
 =?gb2312?B?cmplNVIwYStIckVCbVVYRkp2NzlaeHNrZFkzUEFVS1Y4U0NZanRQYXJNS1Mr?=
 =?gb2312?B?RitwZ1pCRDVwZjdGZlZuZUM4ZHl6Rk1xNFAzVmRiRW9VN3cwSWFtSTR1dUNO?=
 =?gb2312?Q?2D9I=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	glxBzJt+MV0I1OXVNkxyJz1cNLdtIvNp2QbtNHLg8mdpURnOcz+q4QUcuEMBgrJQJyqH9CZ+vhj5Kxi1+casEROxdmXAQaD6b73hoqjAFGV6zeI7zpJt8hRQcOakWyKTdacvXsQmcn5eWnhqi0nAhgaRRQQu/FfqCH68AIncUFgO+PbziQJTHaAYp+bFsn4P+cLmA38mBaVSEU690ZZOtVW0bHY9vf9cAF0Z0JJKQwV2vQDABYDSa9tg1gCVzbHG4fFbWbiLecNBj9Uqat82mnoDeu/lDf6Zf8yMGKbIXOBI+qla+YLvtuZCz6jLDJHXegxscmrwj88tZccILvS4bwBK9k66eNaeo9By19npw7JJ99/4U9QbaTt7w8YrWRs9GSoUhVvF6PmZyAQX+cQAGiRyHT+MUt2j0eCCewfT6LonMtgao6yEEpercJ3yZtVDkX46w0oHXhnOeHJ+ReuHna8xNcQnSPWfooTb0haCZF1Zb5MZydn3PM75ZBmPk9lXgyvSeSALrw3MIh6/YUrDY793dMnjFSY5qVMYjYqBCJKGYCtvnNg3Czmq5mZvAmjIqGz3XXV3MiNkoldzqsyTSywLbWbie7kjF5PMlshrq8G6hTnQfUQ2SnOnP7Islg+g
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11861.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9338f543-b481-4eaf-b110-08dcdd31d018
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 07:15:19.4109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgakvKIJa1KloFIiqJfVDDKRuYPZXRkzj41YU/v+q3p/9xEaKL2PQtGkP7AUy9WSCl6P4H+/eh1i3hsG56IsjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12137
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Sep 2024 07:15:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/665

DQpwaW5nDQogIC0tDQpCZXN0IFJlZ2FyZHMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KV2FuZyBNaW5neXUNCkZVSklUU1UgTkFOSklORyBTT0ZU
V0FSRSBURUNITk9MT0dZIENPLiwgTFRELiAoRk5TVCkNCk5vLjYgV2Vuemh1IFJvYWQsIE5hbmpp
bmcsIDIxMDAxMiwgQ2hpbmENClRFTKO6Kzg2KzI1LTg2NjMwNTY2LS04NTY4DQpDT0lOUzogNzk5
ODg1NDgNCkZBWDogKzg2KzI1LTgzMzE3Njg1DQpNQUlMOiB3YW5nbXlAZnVqaXRzdS5jb20NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiB5b2N0by1wYXRjaGVzQGxpc3Rz
LnlvY3RvcHJvamVjdC5vcmcNCj4gPHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9y
Zz4gT24gQmVoYWxmIE9mIHdhbmdteSB2aWENCj4gbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBT
ZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDE5LCAyMDI0IDM6MDggUE0NCj4gVG86IHlvY3RvLXBh
dGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBDYzogV2FuZywgTWluZ3l1L831IMP56KQg
PHdhbmdteUBmdWppdHN1LmNvbT4NCj4gU3ViamVjdDogW3lvY3RvLXBhdGNoZXNdIFttZXRhLWNn
bF0gW1BBVENIXSBsYXllci5jb25mOiBBZGQgc3R5aGVhZA0KPiANCj4gRnJvbTogV2FuZyBNaW5n
eXUgPHdhbmdteUBmdWppdHN1LmNvbT4NCj4gDQo+IExBWUVSU0VSSUVTX0NPTVBBVDogYWRkIHN0
eWhlYWQgZm9yIFlvY3RvIDUuMQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2FuZyBNaW5neXUgPHdh
bmdteUBmdWppdHN1LmNvbT4NCj4gLS0tDQo+ICBtZXRhLWNnbC1jb21tb24vY29uZi9sYXllci5j
b25mIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWV0YS1jZ2wtY29tbW9uL2NvbmYvbGF5ZXIuY29uZg0K
PiBiL21ldGEtY2dsLWNvbW1vbi9jb25mL2xheWVyLmNvbmYgaW5kZXggZjFmMTFkYy4uMjkxMmRk
OSAxMDA2NDQNCj4gLS0tIGEvbWV0YS1jZ2wtY29tbW9uL2NvbmYvbGF5ZXIuY29uZg0KPiArKysg
Yi9tZXRhLWNnbC1jb21tb24vY29uZi9sYXllci5jb25mDQo+IEBAIC0xMSw2ICsxMSw2IEBAIEJC
RklMRV9QUklPUklUWV9jZ2wtY29tbW9uID0gIjciDQo+IA0KPiAgTEFZRVJERVBFTkRTX2NnbC1j
b21tb24gPSAiY29yZSBvcGVuZW1iZWRkZWQtbGF5ZXIgbmV0d29ya2luZy1sYXllcg0KPiBwZXJs
LWxheWVyIGZpbGVzeXN0ZW1zLWxheWVyIHNlY3VyaXR5IHNlbGludXggeW9jdG8iDQo+IA0KPiAt
TEFZRVJTRVJJRVNfQ09NUEFUX2NnbC1jb21tb24gPSAiaG9uaXN0ZXIga2lya3N0b25lIGxhbmdk
YWxlIG1pY2tsZWRvcmUNCj4gbmFuYmllbGQgc2NhcnRoZ2FwIg0KPiArTEFZRVJTRVJJRVNfQ09N
UEFUX2NnbC1jb21tb24gPSAiaG9uaXN0ZXIga2lya3N0b25lIGxhbmdkYWxlIG1pY2tsZWRvcmUN
Cj4gbmFuYmllbGQgc2NhcnRoZ2FwIHN0eWhlYWQiDQo+IA0KPiAgcmVxdWlyZSBjb25mL2Rpc3Ry
by9pbmNsdWRlL2NnbF9jb21tb25fc2VjdXJpdHlfZmxhZ3MuaW5jDQo+IC0tDQo+IDIuMzQuMQ0K
PiANCj4gDQo+IA0KPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0KPiBMaW5rczogWW91IHJlY2Vp
dmUgYWxsIG1lc3NhZ2VzIHNlbnQgdG8gdGhpcyBncm91cC4NCj4gVmlldy9SZXBseSBPbmxpbmUg
KCM2NjEpOg0KPiBodHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvZy95b2N0by1wYXRjaGVz
L21lc3NhZ2UvNjYxDQo+IE11dGUgVGhpcyBUb3BpYzogaHR0cHM6Ly9saXN0cy55b2N0b3Byb2pl
Y3Qub3JnL210LzEwODUzNTQ3Ny81OTc0OTQ2DQo+IEdyb3VwIE93bmVyOiB5b2N0by1wYXRjaGVz
K293bmVyQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4gVW5zdWJzY3JpYmU6DQo+IGh0dHBzOi8v
bGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLXBhdGNoZXMvbGVhdmUvMTM2MTQyNzEvNTk3
NDk0Ni8xOTAyOA0KPiAzMTA2Ni94eXp6eSBbd2FuZ215QGZ1aml0c3UuY29tXQ0KPiAtPS09LT0t
PS09LT0tPS09LT0tPS09LQ0KPiANCg0K

