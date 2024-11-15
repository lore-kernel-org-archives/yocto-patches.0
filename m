Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280CED6A25C
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 14:21:23 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web11.21754.1731680481091550533
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 15 Nov 2024 06:21:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=bwDoAY4Q;
 spf=pass (domain: cherry.de, ip: 40.107.21.52, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3+m/ZcALqFidNIDtc/WJj2EJ++Vgw5bJZ+ygkBSxnixdlbxaspHkXCSuOtlOWRAH4HKNUzw1UJGaZtAcFPQmUvKIwRxxKXMkGPfK9dzxGqF8SIu/6r1XIkY1GYyfFuN8AWUf+F+CE3Je4rA3somSAeENuw6j43F1zWcKsZg/nptdA5Zb8fTUP2gOVJHuyduStWhpl32aGKvCMrE2Mnmn7CrLuczw/bqjgLnkLZCMulZz5Rg40NWv8q1mJW9oM+ZTaCBDqb4JquNADnpMuiAkbSh000cvxn4VFN6+0mOKy3uV7iX6J2T9K49qgAWKhWplac6ELD1+3Rg8/mJGe4iOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIFzbAzk3DYViSvv+kgj9jFkpe54rG86JMIownFcKSI=;
 b=ajS7ZF0C8o78waMaby2XSvDXT8XJrxlsWiyyol+pocmWRRke3ZLjroKSSy+fcaKzh4MAduisQKs5JR5HxoQWpzbpAHZRZtvi+0UkUihleEZTDpz56dU05QUZhndMQHN/ebTx2JxutvIFC62l/iJzMz2V8RAES8BEOLl5YXboEMuOmktjhwyEG5sxXJl/dCwXYZMcxh1cmWOHwXsA+TynrBLq7r3/VLFOVu9KKiIzs5N9pCrpjDrqWOduq0ZmmaoAFiZ2gycPY6zC0MgD+saVu/wMqIOL4A8szIhz3U8ZwEvGbdrw4bzrSNqltlSTWLp9RVrzvgrnjPxwjKAwKkMPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIFzbAzk3DYViSvv+kgj9jFkpe54rG86JMIownFcKSI=;
 b=bwDoAY4Qqfvp8c5iu48BC8wC5x2NC80adxrZs0SLcsXxzjfrB5SulmDGaSCbYmFVrmYiBxctf9uH41ZfZwstbltge4F6qHOhwezj45RETS8WNcUaENww+2A7v64SiinAAvJluv/i3nBuFnWGhC2WA2YkGTDMHcptPbBH0cocmsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB7050.eurprd04.prod.outlook.com (2603:10a6:10:129::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Fri, 15 Nov
 2024 14:21:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:21:16 +0000
Message-ID: <a6d0d2b5-9d8a-47ae-89ed-f332765c37ae@cherry.de>
Date: Fri, 15 Nov 2024 15:21:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 prepare-shared-repos: Allow to tag poky git
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
References: <20241115140249.176032-1-mathieu.dubois-briand@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241115140249.176032-1-mathieu.dubois-briand@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: 25232574-2d8f-4b8b-d272-08dd0580c44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Zk4yT1RhQyt2SkNVOS9PalRBam5iSDlLNkRnbkNqMGpvN1ZIWDNzUm5tdTR2?=
 =?utf-8?B?RmZESVlXdXhsdFNwQjFXWEZaUFRPalNzRWxUWVZtUmcwcUVHS0EzQUY0MTlp?=
 =?utf-8?B?ZTBwSUR2VGhPUlU0K2lkMlVQSFJSTE5qQmYxcnJXTG9Xcnd1NjNmb3pVd0Z1?=
 =?utf-8?B?bkJ5SjRJL3NyOVlvc0lzaVNKcCtOMkdXSk1KU1hsVkpVaTRuUlIvVTZNOTI3?=
 =?utf-8?B?REZmL1VqS0Z2OFJFdEc4YWdqbm1YSkxKL2toY0ZnWlpLbHpueW1iVkN1RFhJ?=
 =?utf-8?B?RDU5TXVqMWVDeGx3ZGlOdHA4RVo3d3FpVytTSTFwWnpEQkE5cEJZSG9GR016?=
 =?utf-8?B?ZWNTY3F3T1R2WVlNVGV0Q1BhTHRJdUtyUmdVMTRqbVhEdUJtd2xDL1gzTnJ4?=
 =?utf-8?B?WFcvVmRCZ3N3cUZQMGNGMlcreGtXYzkwTXEyUW1UMitnNEw0ckZpMElERlRX?=
 =?utf-8?B?N1JKRHBpRE12bDVIYzVCTWZaaGo1RGZsWjVvc0gxQ3dEMFNRbzZwSDhnc3cy?=
 =?utf-8?B?ZVBTMkhYbXVyUnpSencxZDI1NnBZTVNubkM2R0cxZnQvMmlBRUtGc3Q5UUtq?=
 =?utf-8?B?QXI5cFVxWEM5bG03bytDVlgvZHJWb0VVZzhVWXBHLzlHY0c1Smk1T0RjYy96?=
 =?utf-8?B?TDFKd1B2cEFqaGdvMFRNTUZUY1BSVlU5dDUxQ0wvVytxU2Zzb2lrcUthMEVl?=
 =?utf-8?B?Y1hiRWtIQy9wbXFINWlJRUFybENzSVdBaGpUWFFDcVpaMWkzZkp5SmFxSTNU?=
 =?utf-8?B?VlVBMEg4T3IzWjhFT05nL2Rsb2JyU2lTRHV2VGVqbEVzT25lenVvbTdUb2RN?=
 =?utf-8?B?YXRIbkRiSlFmdGNKayt4K0s2b0hqK2tDdFVTS3kvTThyM21wMjZ4dWFZYVUw?=
 =?utf-8?B?eDFxaXlSQ05VaDg5MFZyMXl1ZUpnWXZpZzdRUXErcXpObGx1dFVBWDVUVEZp?=
 =?utf-8?B?S21CUDJ3aDVvZkJ5SWN1S3lzQUdRTEdTdlMyUHFVMkc4dC9LUjVwcWdZc1Vu?=
 =?utf-8?B?ZDNkZTRJWWIyVUl6NitFMWZUM3I1ZXN6Mk5wNDcwWGJ5bDlvK282MHZKc20w?=
 =?utf-8?B?QXNZVXlwcW44UFNEUzkwanBVZ3dYOUVrMTdBNFhKaEptQnlVc3lyYit4YUp0?=
 =?utf-8?B?TVdnT1dVRk5VV1FsZmZtRG1yVGsrbHoxT3Q5amdFaElhVTJ3YzJMWXFuMVFm?=
 =?utf-8?B?SWV4K0ozd2dNMWRBUjR5ejFVN1N6bjY5alQ1U0dtYThQRTJ2WG5hQlFCUWJQ?=
 =?utf-8?B?bjlzcVJFNHkzNzh6RFNYOGNSOXlHbkRNTytWNXNUdS9wdVplNTFUcEc1UGU0?=
 =?utf-8?B?MExQWlVSZ0c0WWtwL1V0QmJJRThNS0dzdytjSzFSa3FUUUpVMEMwS2ZuN0NB?=
 =?utf-8?B?TUFqcGxXc3pRL2VKd1hFbjdFU0QybTNjRFZrdmFwMXFZaURLMHVlUTdpRGVp?=
 =?utf-8?B?dFhZZXg5R1JBeFlxV24vQzQraExPamxPM1BaZG5la2JtaFdRU3BOSGszM3dw?=
 =?utf-8?B?U2xObUZ4eE1rdHE3OXdQZzlmdUtheUppTVpHN3BHL2d0OEt5bCtGMjNjOUl5?=
 =?utf-8?B?Q1VuQlNHaVNDSGU4YzFjSm5zazdXbktmaEYrZTJEOVNnUnBZMXM2UjhzNytp?=
 =?utf-8?B?Y2d4VlgveG9oRTY5dllJby9JdWZFRUE1WUhxTVMrNjc3V2wxK25uc0RSUklm?=
 =?utf-8?B?L2VrdklwTlVVSnZXdVIzemdqVUV0ejAxZG41Z0RYb3ZpSW1UU1hmVEVXTmlZ?=
 =?utf-8?Q?sMU6W5Q99bM3G6Zipl6M2JlzgsMgD88v/zHyhb1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWRqUUs2Qy9WbzkyN2FvQkFUTHp4UXl4QTdFbmloQm11aUpNZERmNEl5Y1dB?=
 =?utf-8?B?WFo0U1MzakhhRkhua0NCT3k3S2x1ZzQwRUZFaXFXb3RCNjdaRGNDNzM1c251?=
 =?utf-8?B?TGNUZGlvMU90Uk56OGxNTUx3UUQ1dDh0VENGNEpLQzhLNmx6bWxianBDT3RN?=
 =?utf-8?B?Sm1RbGZNMmNOZlVCYzhSTzdEamRiNkdicGJLeXQvOXY0cVlYanE4ejE2WHRR?=
 =?utf-8?B?ZTBhR1FJK25aYy9qUWJTajNKazR0aytpS3NsbUYySUZxcEVndnRxRTk2WjNm?=
 =?utf-8?B?b0F0R0gwMU1KbzhUTkdWd0pYMmE0YzNSYWVjN25pVlRDWUNYODhLRVhBTlFV?=
 =?utf-8?B?L3Mrbm03QmhvV1BNVEoxVlF2TDFrVDY0MUFEd1U4Lzd1S2RkQ0YvbFpVWkpE?=
 =?utf-8?B?c2RPU21WZE56NG8zOG5Jd21FbGQ2aDgzc1FBNWRYSlgvMVNub2dZYUFZQ3U3?=
 =?utf-8?B?cnRJcWQ5RmJZUmc4LzJLYTc2d1Y5TXJEVmNNdWwzMFFHR2QxTXNaY1hvVHRX?=
 =?utf-8?B?QXZMVDd5L2I4aUV1R200MmFwNTE5UTk2V0wwR2NFT0tkK3JKSlNBR1hoY1pT?=
 =?utf-8?B?dTBkZ2s3ak1MRFBDN1ZRS2duUy9MdmY0a3g3cVNiR2lia2pBM0lsNFcvcTBE?=
 =?utf-8?B?bFBKZkNtMnpOeG5tZng1VldkMHIxWFhKU0doRFN6djNDZ2ZRL1pTcElxNUlO?=
 =?utf-8?B?eVFySHN5VkE0Vy96cjR6TDhxY3FHMGJLc3h6cTM1dVpldFluK3JZWi9xcjNL?=
 =?utf-8?B?UzY1cHQwQ01iRzAzc1QyL3Jla0JmSnFQdThFWlNsVVJZS0ZBSjNBb2FaUEM3?=
 =?utf-8?B?UmhnOXBOczVpUjRhZndpRDZmblN4RnZEUjZ0Z0pubkFOUHNxbVdtTktwTUFk?=
 =?utf-8?B?S3VMTDgremp1NHJtMmZrTVZMQXNBSG1Dd2Z0aVZidVFHM0ZjbHZ4UEdFYTN5?=
 =?utf-8?B?UnpTandqa0FTVWVhT3M3aHY1NjJoaTVweEZiVEV3cVlCWllidExTTm9LaDBD?=
 =?utf-8?B?bDJlN3p5QjdHSTZsNnFCTVFoTi9xMkN5K1NlRFFpcXpmcGZsWEVyQnFjWHVt?=
 =?utf-8?B?ZjkrODdQMWFRNm9GeEwzQWlGWng0K1dNdFhQWUY0ei9TT2JuT3Y4NXdIYjNB?=
 =?utf-8?B?NG4xZURKckJIdnlEV1ZEM2pwdGxtRXJUM055cFJ5SFJYbG9DY2VyaU1kZytW?=
 =?utf-8?B?dGNGeXkvTERCVzNCN1BGYnpkY0kzWjJIQjZqdFNDcFFzSjZxeVc1bHBYVmRC?=
 =?utf-8?B?RzVWRGphL21pZ2xGTlpBQXZQTTFoMzV4MjVZWWdCQWgza3M3WGJJTFgvVTI5?=
 =?utf-8?B?KytiUmg1MHk1ZFdFcEQ2YnYrcGt3YjljbXp5ZFpNMnZHcEFCNEdiVHBFNnlz?=
 =?utf-8?B?QWZFT2l4a1lKV0tmSUd5ejhnL09taDN2NkNlVzNUSUlJOERycThQcVY4eVRM?=
 =?utf-8?B?QUZtVnk3TlBJa3hLKzlKeDIraU4wdXRBejhGZ1hCdDJmSzJpaWRtY2NjbDN0?=
 =?utf-8?B?OUpYMmJ2U3lXUkpSd21yVmcyR3B5a05KaW4xUGNicDFpZldYWkhaRG0zdXpx?=
 =?utf-8?B?THExdDRpV0VJTVVJZ1U5c1hXTEtvMGdLaGtqRklDSUsyRHYwVjQyK1dYOTFy?=
 =?utf-8?B?WVRuekVqZTNtSGZ4MSt2aTNaZGQ5LzVTZVgrN1dHajVZOGVJL0pDaE9KeFE1?=
 =?utf-8?B?emowcUdyZWlPZTlEcUo1N3VTNEZoY0tvU3l2ZURRMFVkeHJGZ1FOc0s4bFJr?=
 =?utf-8?B?OEtuSDB2em4vc3IrYkRuZndWQzRUcmRrNGh2czU5a05vUW9QYjh3eXBteUtL?=
 =?utf-8?B?eXdXazRSWlZ6azhsZklaQmp1S2ZDVnRyRGY3RUVidmY5UFBBMFluZE5iRGZQ?=
 =?utf-8?B?cmsxM0N0TUJwcjFhQmZ0NzZIWW9NeTFvakFWRGJNWEM1OHlTSWZHMjJqVjg5?=
 =?utf-8?B?SmNCMjFXV3o4MmZtRU1oUlpjQUpjMHdIeEZkanJuN3N5U25pWXZTNUFidFIy?=
 =?utf-8?B?Q3A3QVhrSmRQSEcvRjQwYjQxZkYrUzN5VWFnOFFaMUVMWnBFNjlCMS9mZTNX?=
 =?utf-8?B?aHYyUmJuNGJtVUZRTTJVQjRjaTJxUUNOampEWDM5MlJEN2J4VC8wTUdVMHh4?=
 =?utf-8?B?THhuVkVuK0RlVG52MzVtelR2UGtSUnA0QVNFZGJTem5nVFRKTkZmSmV0SmYv?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 25232574-2d8f-4b8b-d272-08dd0580c44a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:21:16.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozZZJE2yCp7nlRlRgeHLSmcWIRLBO8OR9YnrBGgMp3ExbKjfrVaFouZaipbUfC9/LePXIuMxwucMrHSK72QynKZI70E4R5zs//q3TcxafYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7050
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Nov 2024 14:21:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/807

Hi Mathieu,

On 11/15/24 3:02 PM, Mathieu Dubois-Briand via lists.yoctoproject.org wrote:
> From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> 
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>   scripts/prepare-shared-repos |  6 ++++++
>   scripts/utils.py             | 10 ++++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/scripts/prepare-shared-repos b/scripts/prepare-shared-repos
> index 1b756520b701..3d10af4e6d63 100755
> --- a/scripts/prepare-shared-repos
> +++ b/scripts/prepare-shared-repos
> @@ -16,6 +16,7 @@ import tempfile
>   
>   import utils
>   
> +poky_tag_remote = "git@push.yoctoproject.org:poky-ci-archive"
>   
>   parser = utils.ArgParser(description='Iterates over a set of repositories in a json file and sets up a shared directory containing them.')
>   
> @@ -26,6 +27,9 @@ parser.add_argument('sharedsrcdir',
>   parser.add_argument('-p', '--publish-dir',
>                       action='store',
>                       help="Where to publish artefacts to (optional)")
> +parser.add_argument('-t', '--tag',
> +                    action='store',
> +                    help="Git tag to create (optional)")
>   
>   args = parser.parse_args()
>   
> @@ -49,6 +53,8 @@ with tempfile.TemporaryDirectory(prefix="shared-repo-temp-", dir="/home/pokybuil
>               utils.fetchgitrepo(tempdir, repo, repos[repo], stashdir, depth=1)
>           if args.publish_dir:
>               utils.publishrepo(tempdir, repo, args.publish_dir)
> +        if repo == "poky" and args.tag:
> +            utils.taggitrepo(tempdir, repo, repos[repo], poky_tag_remote, args.tag)
>   
>       utils.printheader("Creating shared src tarball")
>       subprocess.check_call("tar -I zstd -cf " + args.sharedsrcdir.rstrip("/") + ".tar.zst ./*", shell=True, cwd=tempdir)
> diff --git a/scripts/utils.py b/scripts/utils.py
> index 8e6463d8c62c..122a56d3c3e4 100644
> --- a/scripts/utils.py
> +++ b/scripts/utils.py
> @@ -280,6 +280,16 @@ def fetchgitrepo(clonedir, repo, params, stashdir, depth=None):
>       subprocess.check_call(["git", "reset", "origin/" + branch, "--hard"], cwd=sharedrepo)
>       subprocess.check_call(["git", "reset", revision, "--hard"], cwd=sharedrepo)
>   
> +def taggitrepo(clonedir, repo, params, tagremote, tagname):
> +    sharedrepo = "%s/%s" % (clonedir, repo)
> +    revision = params["revision"]
> +    print("Creating tag...")
> +    subprocess.check_call(["git", "tag", tagname, revision], cwd=sharedrepo)
> +    print("Pushing tag...")
> +    subprocess.check_call(["git", "remote", "add", "tag", tagremote], cwd=sharedrepo)
> +    subprocess.check_call(["git", "push", "tag", tagname], cwd=sharedrepo)
> +    subprocess.check_call(["git", "remote", "rm", "tag"], cwd=sharedrepo)
> +

Apparently git-push supports pushing without a remote, c.f. the manpage:

        git push [--all | --branches | --mirror | --tags] 
[--follow-tags] [--atomic] [-n | --dry-run] 
[--receive-pack=<git-receive-pack>]
                   [--repo=<repository>] [-f | --force] [-d | --delete] 
[--prune] [-q | --quiet] [-v | --verbose]
                   [-u | --set-upstream] [-o <string> | 
--push-option=<string>]
                   [--[no-]signed|--signed=(true|false|if-asked)]
                   [--force-with-lease[=<refname>[:<expect>]] 
[--force-if-includes]]
                   [--no-verify] [<repository> [<refspec>...]]

[...]

        <repository>
            The "remote" repository that is the destination of a push 
operation. This parameter can be either a URL (see the section GIT URLS
below) or the name of a remote (see the section REMOTES below).

This would avoid leftovers from stopped/interrupted/broken runs to mess 
with the git remote addition which could fail if the remote already exists.

Either don't use an explicit local remote, or remove it beforehand. 
Except that removing a non-existing remote will fail check_call, so you 
probably want to simply run the command and ignore the return code.

Cheers,
Quentin

