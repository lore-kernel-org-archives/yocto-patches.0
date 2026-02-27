Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0953FD7F8E
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 10:19:00 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.92530.1772187537653223735
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Feb 2026 02:18:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=GEf/RzuF;
 spf=pass (domain: cherry.de, ip: 40.107.162.16, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANvRF7c/B8zbztz7YqLy0jkkGnM8yrzR3tmzf0miRg4S5ASqhXyRlDQZBkl913L6Uto6TaXyJqERMqksQR5SVBeT7ijmpx5ft4fosRbfWLodDymlauvjPQFU9QbsXkDXYXzCktgeapndzJrdfQ8nwlLj6uesLBs+4sMAoJQLdF5f06a78ppIL18apB2wWPHZ46JF2hzObIG9JJiJs07HICI5OXIRTq5BwxXGkJElfCXvJ/3TCigrJ6lS3PBvbMLbImRqIHVpFwX44y13v9mxOc1M6BG0PbZpu0IRVag7UNbO4RdFibaeMY/5L2NnvBXyTGfkquKn+RtwC0DPJI7igA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLI28fguAnc1puBNVNf40/xkhA7ajwAwT+RKm7CWT58=;
 b=S0nTk7WWEGMISI3C+HgMma07t2IP5Edkojg42MLP1egzJc/FsaI4tMp5Ocj2GZ4PfcvHo4HNioBShkqEtPh4A9Xfc9Vx3fjjD/5GO5et8ppeM9Zk9wFV4eXm6sFIHcamIsbXchfpmFr9PeoM5V5mWj/yvGtMmMVntnDNlSKRGzxjjmwDvoYCk6XAK3HnRyzlM0fBKJNjbFhg1an85njGMeUYBubPuuDuOHh6KpGQFGIo7/VbvD3cSVcI5h9mNHRCIZJmiwiF+uarGq3Oa9a000Pi6PZ77LCzmKr9/Fksh4u01pULqYAulkWr1kNMk+k3TCd6oXJmzrmuCOFUPeNmGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLI28fguAnc1puBNVNf40/xkhA7ajwAwT+RKm7CWT58=;
 b=GEf/RzuFZtWZF1SI/TP6lGtc+YZvYvxeMlYAtL4Neqzfm1dyjKHPOT2Cf3jOv5NVuz64FPS5S1SWPforxRy10Kq4INufZfCvKroGWCMbm15M0zHaKaPKzl7WB0Xa/dKpFmEThrPGHukay4PslXhx/3xf/JRl89nkpzOImMRQMHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB10438.eurprd04.prod.outlook.com (2603:10a6:800:21b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 10:18:52 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 10:18:52 +0000
Message-ID: <1c4b5c0e-f432-4868-aee2-9c6831024f9e@cherry.de>
Date: Fri, 27 Feb 2026 11:18:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-autobuilder-helper][PATCH 1/2] scripts/release-parser.py:
 sort tags based on semantic versioning
To: Antonin Godard <antonin.godard@bootlin.com>,
 yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260226-release-parser-improvements-v1-0-3cc1c9842a87@bootlin.com>
 <20260226-release-parser-improvements-v1-1-3cc1c9842a87@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226-release-parser-improvements-v1-1-3cc1c9842a87@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB10438:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db75e81-4237-43c0-a1f6-08de75e99b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	xIVkb6FXxxN27jl3OxghNrcNNWlS48KZff1DN6C0xnNik4LRKpfPRV+dRt5PulC7tighDd64FwEwpoKK0mJXa0QYGxC50WsKE5WGCyNUxBLAoAaT39PZAwIe+LOHKYdPq9/WivibZXctBJ1DJE6NNfPuRi2YVTu94vAlBKdX3wlHbIyLFJZrwJk+07jYalRWejwiWxvv3Ug65OPX9+cn3xeEpQOwqPtalpcqQSQSzzQMT/23w5m9xZ779ndENPypNM1SJmnamq6rNDJmtPjyrrVxjOT1t9blZoR83iR7DYraWazQECqqGymAPBod0sLhKINyKFHYwPz5ARdFMvXJEkRCQDtOivjD0rsX3qCFq2tlLRuV+3QUYXFDaLUc0mMNkOw+kBL49FGmJhFe/TqPUjqPF8bTupXdFAjT7xC3dxsMWUIKDohe3bePGA5fwjTWwklRBP5F7v+3AXmtNTNlwGQVu7FUOGv8ErUmNQ0ddQvx02SVfPtvQNRv1lvZjghHQ18XwUPNjN3YZqfBGVr/3trVObxvdV6nym7JHS0KZBDxfY381t2NNMJYcB5PVQGzVDTMx4Y9RXNxbwFyb2iX4FQnYDK5Nhl/xJnc/uTVQ4ogBkdbW0l2LrX0zTGRHNP9XeHIDo5aix2h51bY83JH7zl6335G1FimaX1ig4IHfZEK3xEPazkGqc62FD5PYRxo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3RqT3htbGRGYWIwWThnd3R4K2VDMTlkVWgzdjg4UzUvdnNPdyt0aFFaVytm?=
 =?utf-8?B?dDhzOTNQOXpic0JvMEg1OGZ0bEdjT0I0MnQvaVZNZ3VxRFptdk8yY0RtRjha?=
 =?utf-8?B?SWs0elo0Wlg0VHdIdkQySXk0NTU3ejJCYUNHYUJrc2o1NHlyODZTMGdWeVpG?=
 =?utf-8?B?VFFFZGdrN3BnNGZsN2V6TnZ3YkhzTXFuN1FvMEFBNXE4NDRGVzRBeFFSeVpC?=
 =?utf-8?B?U3Y3SEN5QVFkeWRnUE9sNk5DRmZCYUVMb2VPcjY5MHNIeGt6YnpHZlU3QVB5?=
 =?utf-8?B?M2cvM3QreWw1MXRDSEE2SHBDbU9jZTZLL0hnc3ZTaEpWU3haSkxIS0puTWpa?=
 =?utf-8?B?SnQzZEl4V2dZb2crMCtvY05HeWhPOUFNc1EvYUoyTTh3WkVFTXQ4a05oaVFP?=
 =?utf-8?B?OGxKUWxrUDdQaDhLSDM5bGs2Uk1tSXlNandzK0lLTjdpZ3YrNkZlOExRb3dq?=
 =?utf-8?B?dkwxK0Irc2ZSSkY4dUxsdkFacndQb0wrdkl5TmtOZkZCakc2SFkxU0hHREJz?=
 =?utf-8?B?QVBURnpJU1I1cTkxRjFSMlJRaUt6Q0M3bUNSTXJOTlQ5SFRHb0ZEcU0zK3Mr?=
 =?utf-8?B?blltanlQcUZ2WUJobUs4RHNoQ1RQYXlOWFQ3Q1hBY052cm1jU3NuRXBaL2cw?=
 =?utf-8?B?aXNaaGdKQnpBMEsxOURjcjd3clZwNDYyQ0M3eGw2QzYxc01Id2ZqUXNtMDR6?=
 =?utf-8?B?YnFGRndrUXVKN3ArTDg1RytUL2JycEdOajdoZWlUY2JIWkNibVBpK3ozdnUx?=
 =?utf-8?B?U25EZ2dIck5LRFNINzU4cTFySElHN1NLZW1SUzFTemdLTEZzOTh4VkdUTlV2?=
 =?utf-8?B?VHNJY2ZlTW1NeFdmRmdGYWJIdmhEcWRwa2xKN3hsWmErekJGeGdYSXFraHB2?=
 =?utf-8?B?UnVqV2hUYjl6YThjVVpUUmN6eCtqRzZaSXZJSGxkWUtxcStSTnJtL05uUnNH?=
 =?utf-8?B?bDRJdW44TEVUYkFNQzhHQlhDT1ROeEllRE5xKy9BbEMrK2xnUThMU3Jpa0xx?=
 =?utf-8?B?ZGk2RWQrQWZHbHBlUUR4WGhpd2dGbFBkRVh0YzVPVjJwaFY3ZEZYYU5IMWxo?=
 =?utf-8?B?NFRCRmZzVDNGc2NKYkpqMkNuNzhBNkNYaVdxR2JucWRXWFVSZElkZUdRTzUy?=
 =?utf-8?B?VlVEL29kL1ZGMjFFTG1KMEhFZzhGVm9Fbnk0UVZEOC9aOHdTNC9tZU9Gd2lT?=
 =?utf-8?B?azRXUU1mbytYazVhcnRjUVd2dS92WjBjWGEvVzV6a3VoWW56UXQ5WTVIczBR?=
 =?utf-8?B?eGg2cUhwWjJYV010dXVQeEw3WWhnVHhOcUxIK0tUcXBPNHVsQldLQzJPTm1i?=
 =?utf-8?B?a0Y3M0VPalQzSXpka2tTcTFtU0ZTck1YYUYzcWQ5dFNYZngyTVNGbitJMkgw?=
 =?utf-8?B?T1R2ZEdFSHlVS0dCUlA0Sk9ZMWtLdTA2TTBNQkk3amNSQ3VoQzRMSDhpbW15?=
 =?utf-8?B?UWV5WnhtK0lIdzZTdHdEbGUvQkxvSDVmbU1SNGJlNHh0TnpyZGdsRGJKMGxM?=
 =?utf-8?B?NUFBTlVNM0FvNm9PUElPS3MrWWc2VGN2LzU5L2lZenA3N21IVXJheU9VRlEx?=
 =?utf-8?B?NGlSZDN3cFZ4MlB3UW13UDFXeHJKOW9EZ0NNUzdqVGlVaFNSanpOckNHZjRF?=
 =?utf-8?B?K1dEZHB6VWFyazh5MHNhKzNvY3h2M1dmSW1saEhBT2U5NXZRWWE4MXNsOFNX?=
 =?utf-8?B?aGZua2FJWncvMEdNR1N2UlJzckxxeHovZStLNWlINTJEWDRqaVFUcDNMRkly?=
 =?utf-8?B?cjJwV2VGMGU3cW5xeDVFcC9HcFloRittUGthdTlOVTl6R0lMMUlsai9qcjV0?=
 =?utf-8?B?NXFBWHdrYi95cjlCS0FTTWcydENyVDFGYjBjdHcwUjdhaGVyZVZQU3ltbEk0?=
 =?utf-8?B?NDVZb2MrVGRWNTBQbXFkK1RRaG9zV3BWSkJkYVdVdTYzaTdnbzdZWFlCME1W?=
 =?utf-8?B?WTRkTzRDTFZBeGdMSmx0TmZ3c1Z1R0xtTzkxVDJMeXNibGVwbFcxV2hINTZ0?=
 =?utf-8?B?MHBkUkY5TUU5c2tKOGZIanNTUlJUZjVoMW9kVURmN242TDhudzUxVHhKTk9z?=
 =?utf-8?B?cW9PNkFjMUJCY3lGcU5NNTduTkRoOGhGU1dwVlo2SFppUVh0bkJzc3JuWmo3?=
 =?utf-8?B?NzdXNGdFR1cxbzJwcDVYNTNjb2w1UStzRUppempKWGxHKzBpUmJrYzB6TXpV?=
 =?utf-8?B?SUR0SlRNR3c5eHJWY0JHc3doaVA3UjBBZzFSNUJzdHh0ME5aRVVMOUMxVyta?=
 =?utf-8?B?UWIzNytOMEVCeFJOc3BraUJJUzNDYmo5ZzFZL010MThGTVpkTlY0cE80TDE2?=
 =?utf-8?B?V0xsM3RjL1QrWHJvbjlJcHpGNDFHTksyNFZkL3B5T2FWMVZkTW92UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db75e81-4237-43c0-a1f6-08de75e99b2c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:18:52.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qb556waxgCZuVMseyTBx8y8kmypaMldASpVkU+NqTP6k1WvCP8U1l+CXYCkrPNFmdRjCH9gqE2gMsdqqNQZAUZPXFWIvkCybicJZ+ZsFeBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10438
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 10:19:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3299

Hi Antonin,

On 2/26/26 3:26 PM, Antonin Godard wrote:
> Sort the "releases" array to sort tags based on semantic versioning.
> 
> Turning:
> 
>      "releases": [ "5.0", "5.0.1", "5.0.10", [...] "5.0.8", "5.0.9" ]
> 
> into:
> 
>      "releases": [ "5.0", "5.0.1", "5.0.2", [...] "5.0.14", "5.0.15" ],
> 
> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   scripts/release-parser.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/release-parser.py b/scripts/release-parser.py
> index e07fd71..882c0fd 100755
> --- a/scripts/release-parser.py
> +++ b/scripts/release-parser.py
> @@ -60,7 +60,8 @@ def get_git_tags():
>                   return semver.VersionInfo.parse(tag + ".0")
>   
>           tag_names = [parse(re.sub(r"yocto-", "", e.name)) for e in tags]
> -        tag_strings = [re.sub(r"yocto-", "", e.name) for e in tags]
> +        tag_strings = sorted([re.sub(r"yocto-", "", e.name) for e in tags],
> +                             key=lambda x: [int(y) for y in x.split('.')])
>   

If you reused the tag_names (which contains semver.Version objects due 
to parse() I believe) variable, then you wouldn't need any of this.

See

 >>> s=[semver.Version.parse("3.4.15"), semver.Version.parse("3.4.5"), 
semver.Version.parse("2.6.5")]
 >>> sorted(s)
[Version(major=2, minor=6, patch=5, prerelease=None, build=None), 
Version(major=3, minor=4, patch=5, prerelease=None, build=None), 
Version(major=3, minor=4, patch=15, prerelease=None, build=None)]

Then you can generate a string-only array by using:

 >>> [str(v) for v in tag_strings]

Also, I think you can get rid of the parse function by using 
semver.VersionInfo.parse('1.2.3', optional_minor_and_patch=True)

c.f. 
https://python-semver.readthedocs.io/en/latest/usage/parse-version-string.html. 
This does mean we allow versions with only a "major" part.

Cheers,
Quentin

