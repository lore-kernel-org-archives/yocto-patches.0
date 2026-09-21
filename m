Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B904C982E6
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 17:36:54 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com (PH7PR06CU001.outbound.protection.outlook.com [52.101.201.6])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1997.1790012206930461806
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Sep 2026 10:36:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=ClQHPlAZ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.201.6, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRCDPS0TvpzwjjASAVULGa3Ic5UL++D12TrbzpdJ6anCGt7eQutpzYUSCwRLAUaKB51lEDRG/pN44o6iIf4ilFUz/gYGQ0o2VbH4BZL2n3P4s63BAoR/zorngpc1DCQpgG7ftRXqAdyo1xbfWmbDsDO+hDnvtlCrLPcKGWjuh9F5CCs8wd2VINmyPf+odSHE/1bLyxGm8PStpZVR/srNGPZcWzipKV1PA4jBlGeI066C5/spIwC0UQSbGDw6V6bBIFsDghIBDjBIKHjMFhXZ9dJ1TJGYpyRXONDNWjqXm00ZLWm9q3rOPIAIosnfFnIGr2GDWXVni+VSFRNwNXMmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTVhmj19i4z0LMjLvzV1oKGHUcRCC40N8gByxT2seMk=;
 b=PKmil1h0O61zfmMlKK8m3FiONYF1KfrGjk/uAvEGMl5CbIIgOp8r4d9z+2AZqyTz92FHi+mRNXMCNLkzFwKr88WNyYxKlvQrfuZZpsFVyRo4ysZbGZOL+y3SifdextTLj+IFAYO2qhiEeVQ5dYjCkzGSwenrKwjcqJC6Bdt0JsLxGIntvUJgKhGB746NjSjbOWcnj5ZtBe0DN4bH4KaK1d0K/2MwyDnr401SKUdHabkCJAgCH+CmpO1y6wR9CiHADllVGJ/AblVn9owY/e2WdKfnFsNSChJb0na0t9Gw1seN82EEHa9WaX35ufEuWUUnzWR62/ZJCyUrNnvdIbNB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTVhmj19i4z0LMjLvzV1oKGHUcRCC40N8gByxT2seMk=;
 b=ClQHPlAZ0ga6irShLvknk1BAlv3zMuvIQXONhAhs/2ISawh9QeETQjriphFmkfbPgYHG/7lNyiwiVC6dQljuBI7RJ6Wolop8FLracusLb1ecgCT9DbX0R3qpOvJghb5vlqg6zI5HoRrsHmmKeUShumOShic5ynJXCKPV5KBnjAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7)
 by DSVPR12MB999286.namprd12.prod.outlook.com (2603:10b6:8:41a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:36:44 +0000
Received: from SA1PR12MB9004.namprd12.prod.outlook.com
 ([fe80::b08b:7d29:b1b2:1cc]) by SA1PR12MB9004.namprd12.prod.outlook.com
 ([fe80::b08b:7d29:b1b2:1cc%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 17:36:44 +0000
Message-ID: <6bf45fc7-d493-4a7a-b859-c84a60654dbd@amd.com>
Date: Mon, 21 Sep 2026 11:36:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches][meta-zephyr][master, wrynose][PATCH] meta-zephyr:
 Add SECURITY.md file
To: yocto-patches@lists.yoctoproject.org
Cc: chee.yang.lee@intel.com
References: <18D368C5C433899B.141540@lists.yoctoproject.org>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <18D368C5C433899B.141540@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:a03:255::30) To SA1PR12MB9004.namprd12.prod.outlook.com
 (2603:10b6:806:388::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB9004:EE_|DSVPR12MB999286:EE_
X-MS-Office365-Filtering-Correlation-Id: aff023c1-1c57-423d-bac0-08df1806e773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	AsawjGEe61FXqUzg0idIQd5lutVXE/e8N42eLOU9asrRBVACZR1DbkpCC20dS/LUAYnZXpL2xIeWvIw4csP0YiOjrkH9jICaWkDVEh3jCkXMR4bPoUGgVhYEzduTc3Ies1elTXsXHxRnqfAszwy71mhWgbPL3qNzIoEJxFHSZfpGshTDSmIb1i8siwFpJxOLBOu937gd3kV1gs49LpYID3ffQP80oAFiCMaMtVWlD5xNMU/f8otKQiE2sPXy2RZ4SEs7ULt3sgt8M9oVkiUBmTqIlqvmyisJlpXKnFhFWhZ/YqvG5vestY8ZcU4eJk5JqdCI3mkRMm93nD27Pw+Nn6ANd5HmEG7NUGU0cZQbko57+BM+lhwFgLdXVZBuLnwV8KWI0Iqs8B2UgjLaDcH6R0iai2yx/RPztZfvlJENnITE9H1iULa5vJ7wINUjBQ7KgSC4pC8QYTQAUBWs66E2sBG+UqRUkO3/JmcmAvNIkQgi5yfnu3oTuqyzC5uQ7o+VVZwEEgpFAay/in/Z9amAHQmrnzmeE7SaTWtOkqwmoCUzofQgE3iXzSzxS36itXWInoveHZQrFdcDuyipS2wlhj7tLB3c91tVlNSyfmLNqqE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB9004.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dGZhY0ozVWFDR0pJdFZmNk1oNDRUNmJtejNxM2ZBMUhDR2JIaXpoYzRRbGg4?=
 =?utf-8?B?OGoxM0IvL1E2SEF5R2l3b09ud3o3TlNzbE4wODdKQW5aeTZBeEhWLzAyQXhT?=
 =?utf-8?B?Y0hVYWVUbzR3WHJCRnRnMGFrSlhaUGxxcGRFclJyNStDOVRIUmgyYVhRUzBt?=
 =?utf-8?B?dTRtZGJjOVNWYmVwMFZ3YnN4SmtaQk05ejJ4enBLMERVd2szRUxpUjMxUjZI?=
 =?utf-8?B?dmUwVDA0Zk1QTHppMGhOd1Y5ZkUzMWlKbXBoY3dSZTlmREJnMnU5S0Y1QllX?=
 =?utf-8?B?NUZSWkREL1VuQ0tEck5XcDFqTWM0YWtGaUp3MGtRNkdlbXNtendZZXFYSEgr?=
 =?utf-8?B?bnV4aG5ncnZpdFNmalZJbmpJMEQ0c2RhTWhzQXdlampyaXk5MU1sNHpxNlNG?=
 =?utf-8?B?WXpGbis2YmlYMTFNNHZFUFBXN1lEa1lmY3pXVDRreXlDMjdubE0rR0d1a3RS?=
 =?utf-8?B?d2xOSEt5UVdSQklKUllGV1M1eWdTNTV5aXI5REx1ZzhBYnBpdEdrNXNkRjNQ?=
 =?utf-8?B?dC9kWVBBTW81anV6dyt5NEZtbG5LRnRENWFpR0ZEOVJnMGQ2OGVQdTloUlcz?=
 =?utf-8?B?QWw1cGk3WUt2NXY5VitqL1QvRzZwcUVDKy9hZ2NvNW5sTGZPcnNsVy9lNHph?=
 =?utf-8?B?d2VSRm9vV0UrWTVMT3ltVG5RTDBiUVZlZjl3VEpvbHpWNFc3V1pwbTVQYzJo?=
 =?utf-8?B?cnRmTlFtS0tWdTdGNnJldlpVQndORTVlajBISUNkbzNvall4ZHFycDdQWDll?=
 =?utf-8?B?cCtvUHdFZXdaSlFac3Y1c1RPYWZmTWFoYzdGNUNwOUtnM1cyODIvVlBkbkpW?=
 =?utf-8?B?cHhWVlJEdUwyY1dENUduRnllUmZiclJlL2ZmUW5pY1FSS3A1VmY4R3FMMlE5?=
 =?utf-8?B?RUttOEtLUWVwVjBiMEpIVGVCYnpXd1FTdkhHQ0tIamVRUFNmcUUzYll1eE5n?=
 =?utf-8?B?Y3pOWlA1TnFDUlplZ012YkdYU3B5ZnNQQkdHemxza2xyRVh4SDU4TWlORnU2?=
 =?utf-8?B?QmZVTGE1Uy9HVGd3THhqVStZczg3dmdhTU91VWVDU0VMZkp2SlpDdkZHV1VE?=
 =?utf-8?B?c1VIUTg2WHI2VkRnQVE2TlFUZGp3M1FLOFQ5U0pIMVl4a01uNUpjY0lYdFhQ?=
 =?utf-8?B?NG4wTStzbDdaTjBtb3Qva1Fyb1h5ODVlSzNseno4Zncza2NSRmdtc2p3QnIw?=
 =?utf-8?B?YkpxZTBKK3BsOGZOTEpwZ2c2R0Qyd3c1bXAxVHVoVUxkTllCMDdDS3c0RlNq?=
 =?utf-8?B?dmo3VkM2emJDYXZMM2U5L3M3RW5HT2twSkNBK1cwWXJ1RUVhZ1VuMExwbGs1?=
 =?utf-8?B?N3ZBTHd4ekVDcWpGT3JMb3pMWXNnODJzWWVqMU0ydUY4OTNzbEZiSTEyZ0N0?=
 =?utf-8?B?Y0dQZGd2djY5OWlvZnMzaVd3YjhEYllrM3VCSE1BdUR3dHFtQXVSdGJRTlBj?=
 =?utf-8?B?UU91L3JQaTFUY1lzallMUll6anpWaXBCeXlaOHlHU25HVXZNR2xkNktPS1Jn?=
 =?utf-8?B?bHF6cWw2dFg1OHVtd2VaelU2eTZkR2hSa2tDVnJ5SjhwbXJ0V2prSGhlYXFD?=
 =?utf-8?B?ejlrbUIwR0UvNFB1V1M4d0lOUzl6ZlBxTHN0WW5mZksyVTdDTkNtZ1ZuRFJK?=
 =?utf-8?B?RWl3SjY0SlFOSUROa2h2dk53ODhGdjNRdTZJa3VNK1cxL1cyRWFQSUpXcWJI?=
 =?utf-8?B?MTlnaE1UYmJxWll3dG53OXFsNUl2VGh6Y0hxYVhnSm5Sd3ZvSmlSQ1YxZ0pX?=
 =?utf-8?B?a0VVMWFaSmpkSkt6K3l0bE1KcVNKQ2ZPYk9QTkpYQU03NG9HVGM1b3dlTjRU?=
 =?utf-8?B?VVoxSDVnd3l1bXNFUEZFa2V4TGsyc1U3ZEtGV093aW1udXBWZS9VcERJTHh0?=
 =?utf-8?B?c296a1p5RmpQRzNndExyR2R3ZzNLOVpqckZ4TXp1QWRJT1QwQktRYWhZR1dz?=
 =?utf-8?B?YmdaYmt2WGUwNWttZFI5RnF5L09FemxNenJ6b1RWbkx2RkVQdm1FS3BiK3lW?=
 =?utf-8?B?NEhyRkYrTnBQMlNQamlpWnFPZEVHS2JMRGZuaXgvVFJFTCsxR09lam9RSFMv?=
 =?utf-8?B?c25vUFNYY0cwSzlvcFZGMS9qcEZSMDVMRUEyRWJqTGJ2eFdxaXBGdi9vZ3di?=
 =?utf-8?B?T0Z0a1VzNXNFWmhTaERkZnZaZ09GaVZrQWlBVmhFOS8zSDAxdHhNZXlQZzk2?=
 =?utf-8?B?Nk1RbGVWdTBIMFNBY05qdS9qRlVxL0lCdXB6SGJkbG4vM2xPNUpXQ2xmNEhn?=
 =?utf-8?B?a0MrU1JmOURGQkFLaGhObXArQVgvVy91bGc5dHdnRFRDbnlsMERvMGtjSHBK?=
 =?utf-8?B?ZE4vQjBBa0xvSTlRQUQ1N0M5eGcvcUYxckQrVTRzRmYxbko1ejFYdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff023c1-1c57-423d-bac0-08df1806e773
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:36:44.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BQbpXWAnp6cEnDYoOl0HWbBbu7Vtyk/GK3do2HZ96kM8Dbi1xaIVCgvJvTpBbco03Q3Foe+fNLD2UvVG3YcRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999286
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 17:36:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4924

Hi Chee Yang,

Please merge this patch to wrynose branch as well as this is bug fix 
when you run with yocto-check-layer suite.

Thanks,
Sandeep

On 9/8/2026 11:31 AM, Sandeep Gundlupet Raju via lists.yoctoproject.org 
wrote:
> To be compliant with the recent yocto project security
> processes, add a SECURITY.md for this layer.
>
> The file describes how to report public and embargoed security
> vulnerabilities, and points to Yocto stable/LTS and release
> maintenance information.
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>   SECURITY.md | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>   create mode 100644 SECURITY.md
>
> diff --git a/SECURITY.md b/SECURITY.md
> new file mode 100644
> index 0000000..320263c
> --- /dev/null
> +++ b/SECURITY.md
> @@ -0,0 +1,22 @@
> +# How to Report a Potential Vulnerability
> +
> +If you would like to report a public issue (for example, one with a released
> +CVE number), please report it using the mailing list as described in README.md
> +If you have a patch ready, submit it following the same procedure as any other
> +patch as described in the same file.
> +
> +If you are dealing with a not-yet released or urgent issue, please send a
> +message to the layer maintainers, including as many details as possible:
> +  - the layer or software module affected
> +  - the recipe and its version
> +  - any example code, if available
> +
> +## Branches maintained with security fixes
> +
> +See [https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS Stable release and LTS]
> +for detailed info regarding the policies and maintenance of Stable branches.
> +
> +The [https://wiki.yoctoproject.org/wiki/Releases Release page] contains a list of all
> +releases of the Yocto Project. Versions in grey are no longer actively maintained with
> +security patches, but well-tested patches may still be accepted for them for
> +significant issues.

