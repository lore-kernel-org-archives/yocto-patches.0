Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F09EF584F
	for <webhook@archiver.kernel.org>; Sat, 14 Feb 2026 18:43:45 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11657.1771094623952299219
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Feb 2026 10:43:44 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=HrzxG8aJ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.53.53, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjbtPs8qH+o6jwhoIfr9caUoPt80ticBhGKthUis3Emt+V1xFm9IX/tyFpMURT52EAnHXU/dXl/UZO3WrsslrU6vTwEiNQtih7kz/Hej2Se6RTr1/iJKd5x5HIBjz9FqsRZwMl0nW6mIM2pqVP8sgf8g+r6Tj9jp+FwCDzFf6xe64tDXOCoOUYtR3TAQtIfDkSwqrUXh9oDo77b9Ex0a6R6Aen+IaPVq0Kzl2F8vF7N8HTvfeossTvtoA+KXFD3okN7yPu8QdLf85nSpuZnbYcZCMOk8Myi6uUn2qGYxmnmahwV5z2CFK2/nZbPVdxRLpM5WEt0pj51leTVUpUnPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QhdKnX55wIOtqwPCPFCrSCpjDb248Jwyuszg/wPD8Y=;
 b=mXntIV+N8tpjgg15p5uUGKwhltAWMDhdA89YFgag4b6k1Z5IB0eQku/gMvw0DoEQtkm4nDCDAC6XzLg5++TtHlXWkS1ZgZoHaiiAwPBqIbr539/0GmFKrHPHps+FWsqDjNyDWkboFwGlG5tyZhoD372VYkfJxkBg0EQ+6QCk0GxhUfm+eVHlCQjQC0v8sufoJiFM70v0LpdDF7391ys6pW6k9gHwbM0ymzyEIwijTn8iKGQiSHWp27BoWXidvGhCQKp65uHHlvImMhLhC5YiPyNHQpEgr5p05+UOImN+FtgGVttb7c5QqUSQZEPajB8Ihb7pkLqljMxK5zWfCbnonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QhdKnX55wIOtqwPCPFCrSCpjDb248Jwyuszg/wPD8Y=;
 b=HrzxG8aJgdvnUwP0rOrZQjMA4a7DiLLmPkdcB4unu+YSU6hKbRiwnyjqdxxKDLXgPeP4ZT42pI7aA2P0/2lfegWiFLeWeOm+9nv3BSuRvpP00CVE7Q4ciDn1TMDHr6AdFoblHj0J0jLXOVW4IdqLfXEKvgFLiWo2KxyURzFdZ3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Sat, 14 Feb
 2026 18:43:41 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::9fec:220a:a205:ec68]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::9fec:220a:a205:ec68%3]) with mapi id 15.20.9611.012; Sat, 14 Feb 2026
 18:43:41 +0000
Message-ID: <0c7c97d1-bb06-4cda-9917-436ad7209320@amd.com>
Date: Sat, 14 Feb 2026 11:43:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-zephyr][master][PATCH] zephyr-qemuboot: use stable ELF
 symlink to avoid broken runqemu rootfs
To: charles.embedded@gmail.com, yocto-patches@lists.yoctoproject.org
CC: chee.yang.lee@intel.com, Charles Dias <charlesdias.cd@outlook.com>
References: <20260208164458.101865-1-charles.embedded@gmail.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20260208164458.101865-1-charles.embedded@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:610:52::14) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c606840-02cc-4adc-d2bc-08de6bf8f927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fERGpoRCXeEa3FlnOHFF1s5LRqAdamCX7yYBiQiHBQ84tn9ChTHcZlSjS0RC?=
 =?us-ascii?Q?0tAHz4IrCL7lV37BUzI3s/t7j7HtF5h8olY4vDhyaZe16tiyKBWIyPdAfW5A?=
 =?us-ascii?Q?JDV/95oFoyXMKPOLjQIQ+cDyn33Z7bzvksc7+/3aMBqLWrMJcyPmZZUMuryY?=
 =?us-ascii?Q?WDtZy0+vIEgYrghRUFEmZ9lvpCe9/grC7dvnOHU4zxryifQ9uP5367o/3sok?=
 =?us-ascii?Q?fGoCMBa7xaEKGIr/ty4+XVaUrVSMo/cAFPm815EnC3FE4fLrmjGWniprtvd3?=
 =?us-ascii?Q?PoWf/H98V/dvzgLhwzPnGU7ysoPADGEE16XLbLxA2Uo9GuHnUmOVnmRc/DP2?=
 =?us-ascii?Q?YRQW/0XpsVHi07kv/I6bjn71HUIL+nmvOT00Mjtnq4L9CKhlYhg63zZ9jXKv?=
 =?us-ascii?Q?DbBH+WxRM3jqM3e0dVwMY0nrXnqpzQ+K/ue1vX7AHxsZPXpXW6x5yJ38lkDi?=
 =?us-ascii?Q?0nCabMTFIVTtyV7w2EHnCiDyRb3qgpczov1gR7qZdkuxKTjC2jqSVaybyHPd?=
 =?us-ascii?Q?8DyhUiHBSd8BIepe3/E8zfCcsTroIFiDJFr7dUzKRDU4MwkBvuW1PPcDf34S?=
 =?us-ascii?Q?oy459K5lyVqOcrwo1ZM8p8/6pWVTF8lSP6ydYdm+GFi1ks3W0NjUxS62CN7s?=
 =?us-ascii?Q?k0Tx2MoLdscJL5TaDuHSi/HzTlR55sDtFZjcWdrOz3VynwFfly/f5EDddbuw?=
 =?us-ascii?Q?B22dNm+oPagRC0YWbl7qfcgU8w5+sWlxhkVnJO0OSSCgrKKG3YUVx/XeNN/v?=
 =?us-ascii?Q?2SsxogKRxNkfcSk7VdqOJJpf/LEZkpXfop0oCi7G5483Eyr65k6BZ6+dlu3s?=
 =?us-ascii?Q?KAIi+Bl9dEZlXMFJEi8KXPHT+xmU0fe26n2IvzIwGXCsbNHTjl79yG5JEgRw?=
 =?us-ascii?Q?Uvm6Fzo03j8OCYF9sKx8wJaBjaUjTt/ZK9ZIiaOU3KfQN/IOAHW6vAWQ2Zyj?=
 =?us-ascii?Q?enj/PoIHNFD0eAHkjpWu/Ult8EoZUfp2EnA007D2BvBbht/er83TXGgPon1W?=
 =?us-ascii?Q?xvi4OFtuBnbERw9UTZC6OiYz0pdyauMNQJa0+otMJ2c6Ao23OY439vDYsYSi?=
 =?us-ascii?Q?0GLqMAAiD9wF1HaMpBpD20K4rwISSRVI6KDUnVmhzaUEJRPeCvsyvuuWuqWI?=
 =?us-ascii?Q?DGn+KETLolWS3PAe4K1K8+Nxjt6ffnZvaWpig8AfIL+o7tsLTf66YpK06xsJ?=
 =?us-ascii?Q?XcH0WLpO75DpkmI5rfMWFoKDK9vnMHvExyFf1sHJ7wJAPuc7aDreV8hw69L3?=
 =?us-ascii?Q?mO+RNDuEUO2M8DxAlaCOR8bWH3m77TPEnwucXq6QWLJklowDPXR4cw7fDaTD?=
 =?us-ascii?Q?MlfAFgG1Ol1ApwhrT9b4rPGNCAYKcoyOnyFCROCH0Q5+wTMab9WluR5LbLo+?=
 =?us-ascii?Q?Qc5861R/ZFv61TIyMOWXoKLlEIUQrpfiGu3rUQHycw3Jnp2N5Fz9X11oQw9s?=
 =?us-ascii?Q?ysUpmqxB7wkdAec58cb5C2Y0M/l9hlEIWcjIxCkCcru/aAxw6BdMPpcg96yY?=
 =?us-ascii?Q?ujZXJ7H3fp81WOKI4bvxFEstCFokg3FXYyOQhRmLelSlSYYyBTmJgL+isoQl?=
 =?us-ascii?Q?NETIrG8SR5agsOO690A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?v1KNhGU28727+AK4HJ7jkrRl71U2eANZafa2V0eK0RazWXafsLeleMhvQKwK?=
 =?us-ascii?Q?0H90rcM7oH62QayqsIy15VH924Yh93sKOM+P5AokBFfXEpw4renDllTM2xrc?=
 =?us-ascii?Q?AN/kNlqY1jJcD/U/e2QP3lK1Q2q5gDZ5NKoBb9qqt4VIeyehGd/GEWuTEdB6?=
 =?us-ascii?Q?NI9IMXLnNcSuFRVvYfvJKotFYCY7axRzdqewYRPaG55SG959sNUeeflrlt33?=
 =?us-ascii?Q?lJ5eYSbRiY6l1JRWqBmMSght/Rv4+45ciREmiHmQhSEPEQHTA7wiIvx1qoUS?=
 =?us-ascii?Q?w2pFFer6e9q1jdAfTkzJZlDi28azsuc1/VkWKm9h2R1b5acX/jeBHr8+lpaN?=
 =?us-ascii?Q?OGIiRRE/KaKhBsOJmwCWiJBmIcT6yYngz0RaH4HRIaXp1FOxeXW8qi3hawux?=
 =?us-ascii?Q?boH10VIupWVHBGzc6wEyg5kC/TfO5Mo9OoQYQS7bMDLUPqE91Q+cKSmR0hbO?=
 =?us-ascii?Q?mx6BydsKUHeK+zOKh+tjWgdpkyNez8Z3bydfKVF6SsUxG0W/5op6FA0Lp5bT?=
 =?us-ascii?Q?HmuXbNt8z2mc4jg5wG0vFEbcAjTasnu9utKjix/j9O8wEGEFRXC8VL3hvQ0V?=
 =?us-ascii?Q?x+ACUoxaTRMGI9hXXp2WBJ4PdPuQGci0xmSlpUfi2pdolRlOJySee6rToo1J?=
 =?us-ascii?Q?n6zvAgJeupNsH05EcgUlfjRkj++13kxUEYKtPdK8vhXSGHdWu/cPRmpdGQOf?=
 =?us-ascii?Q?HTHkhbI9D89ykvHFm1O2yNUhEofKKVrvknmCeEtPHH/6jkJGQl3+oVH/KbDq?=
 =?us-ascii?Q?svGK10MWc4E5x2C/ZIqU+Y2OKJRBOeJt7BgEbFaNvGB2+cErFA2YlyXzbPrC?=
 =?us-ascii?Q?tgMLm175SPehF3DuzQl8Bq+Fw/jgNpI2CJ5kUgn0i2y0EziapKsRYVEBLf1H?=
 =?us-ascii?Q?CaP+WvR4jgTZBSp+5jcribGNeFeh0rx6syKM7iBr1MwISLg9yfr0Hfyjvc1t?=
 =?us-ascii?Q?TQTu18YFyECE/6aNDDKuTf3dNy0s/VfYgMcIAbVB7I3Ajcpffo4g+XEj8Un6?=
 =?us-ascii?Q?5OqcK4xRTAKEON4M0Dz4bez0CwXt9WnnriBlUyPjaxrMh/Otog2gNKIC1uAH?=
 =?us-ascii?Q?E0I5OkhaQMon498H7A0no1sEyO8p+AAqiinyPdCxpJwEFHw6oSOsaYwWS6kk?=
 =?us-ascii?Q?dx7YQYA6AYmZS0er/VsbyFWhf7dETSWqrm5D7ojOArl0q1K4FthQq+Y6Od23?=
 =?us-ascii?Q?Di9Q7k+XKGnBdAbLhtkFnTaMQXqvDZVVnlp8JdgBHovZIqSWcgbVZs1n1ehC?=
 =?us-ascii?Q?hQvlFknPrz2F2IoWW6ovkv3Q7+T0QhaLFN+sIsaq2wkqnIQqoAd0RiJaatjV?=
 =?us-ascii?Q?JgXdma8/ZHOmmoT4Uj62tB0n0OUwg/WoT66wenYCKuy37/dG798EhpX2EZ5u?=
 =?us-ascii?Q?KSJbAcBQ6MIlDBp44qCiY36qA8iSAfWQBgOSPlz724fzbGSUo0H67+m92XPW?=
 =?us-ascii?Q?Y4XMTdfovVcprjwU4tXw/7Zh27HY8pfx5d+K9GpNobT+vCCc/QKNSQ9Eo/rC?=
 =?us-ascii?Q?eOzMJsYCB/pSvUkke3CvE9xPlaPLuTY6Ruteisr+9SPd1oNRAt0GhRG28pyW?=
 =?us-ascii?Q?IL/q/OE/Cx4yk2tfckEmBQp/ZeK/huaAsAEhEsJ7GBG1jWsIWpKDWK++wZPM?=
 =?us-ascii?Q?1Ge8icXqoeIw7lmSsadbIywaGoQairW89DGJtb7bDbeHLFH8dSlgiqboFrF/?=
 =?us-ascii?Q?25HVKPDBmDMaDr+coOOpLQ5ol4+RwSVjMX7F0YrGyjFIyYLxnes/BWAE7mI5?=
 =?us-ascii?Q?x0Fq0zN5dA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c606840-02cc-4adc-d2bc-08de6bf8f927
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 18:43:41.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08XXGJrbuLY1WTZHDQmXzhFr5B2bmphQdNQl8vaZd8W98LVrq02lhm3HN36jmr5m/whRZwkd/pVm2iIjRdNMrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 14 Feb 2026 18:43:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3241


On 2/8/2026 9:44 AM, charles.embedded@gmail.com wrote:
> From: Charles Dias <charlesdias.cd@outlook.com>
>
> do_bootconf_write() may update qemuboot.conf and the QEMU ELF symlink to =
a
> new timestamped name while the ELF itself is reused from sstate and not
> deployed, leaving a broken symlink and causing runqemu to fail with
> "Can't find rootfs: ... .elf".
[Sandeep]: Can you provide me the reproducibility steps for this issue.=20
I didn't see this issue when I run the test a month ago.

 =C2=A0$ MACHINE=3Dqemu-cortex-a9 runqemu nographic
runqemu - INFO - Running MACHINE=3Dqemu-cortex-a9 bitbake -e=C2=A0 ...
runqemu - INFO - Continuing with the following parameters:
KERNEL:=20
[/scratch/sandeep/yocto/yp-master/build-zep/tmp/deploy/images/qemu-cortex-a=
9/zephyr-helloworld-qemu-cortex-a9-20260116230612.elf]
MACHINE: [qemu-cortex-a9]
FSTYPE: [elf]
ROOTFS:=20
[/scratch/sandeep/yocto/yp-master/build-zep/tmp/deploy/images/qemu-cortex-a=
9/zephyr-helloworld-image-qemu-cortex-a9.elf]
Disabled. Changes on rootfs will be kept after QEMU shutdown.
CONFFILE:=20
[/scratch/sandeep/yocto/yp-master/build-zep/tmp/deploy/images/qemu-cortex-a=
9/zephyr-helloworld-image-qemu-cortex-a9-20260116230612.qemuboot.conf]

runqemu - INFO - Running=20
/scratch/sandeep/yocto/yp-master/build-zep/tmp/work/x86_64-linux/qemu-helpe=
r-native/1.0/recipe-sysroot-native/usr/bin/qemu-system-arm=20
-nic none=C2=A0 =C2=A0-icount shift=3D3,align=3Doff,sleep=3Doff -rtc clock=
=3Dvm -machine=20
xilinx-zynq-a9 -cpu cortex-a9=C2=A0 -m 256 -serial mon:stdio -serial null=20
-nographic -nographic -vga none -kernel=20
/scratch/sandeep/yocto/yp-master/build-zep/tmp/deploy/images/qemu-cortex-a9=
/zephyr-helloworld-qemu-cortex-a9-20260116230612.elf=20
-append '=C2=A0 mem=3D256M swiotlb=3D0 '

runqemu - INFO - Host uptime: 2514957.76

*** Booting Zephyr OS build v4.2.0 ***
Hello World! qemu_cortex_a9/xc7z007s
QEMU: Terminated
runqemu - INFO - Cleaning up
runqemu - INFO - Host uptime: 2514968.61

$

>
> Fix by making zephyr-qemuboot use the stable link name
> (${ZEPHYR_IMAGE_LINK_NAME}.elf / ${PN}-${MACHINE}.elf), which is
> guaranteed to exist as a symlink created by zephyr-image.inc and always
> points at the most recently deployed ELF.
>
> Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
> ---
>   meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass b/me=
ta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
> index ab0a281..4d8920f 100644
> --- a/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
> +++ b/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
> @@ -1,8 +1,8 @@
>   inherit qemuboot
>  =20
> -ZEPHYR_IMAGE_BASE_NAME ?=3D "${PN}-${MACHINE}${IMAGE_VERSION_SUFFIX}"
> +ZEPHYR_IMAGE_LINK_NAME ?=3D "${PN}-${MACHINE}"
>  =20
> -KERNEL_IMAGETYPE =3D "${ZEPHYR_IMAGE_BASE_NAME}.elf"
> +KERNEL_IMAGETYPE =3D "${ZEPHYR_IMAGE_LINK_NAME}.elf"
>   QB_DEFAULT_FSTYPE =3D "elf"
>   QB_NETWORK_DEVICE =3D "none"
>   QB_NET =3D "none"
> @@ -29,7 +29,7 @@ python bootconf_clean() {
>   python do_bootconf_write() {
>       bb.build.exec_func("do_write_qemuboot_conf", d)
>  =20
> -    qemuimage =3D "%s/%s.elf" % (d.getVar('DEPLOY_DIR_IMAGE', True), d.g=
etVar('ZEPHYR_IMAGE_BASE_NAME', True))
> +    qemuimage =3D "%s/%s.elf" % (d.getVar('DEPLOY_DIR_IMAGE', True), d.g=
etVar('ZEPHYR_IMAGE_LINK_NAME', True))
>       qemuimage_link =3D d.getVar('QEMU_IMAGE_LINK', True)
>       if os.path.lexists(qemuimage_link):
>           os.remove(qemuimage_link)

