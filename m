Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.94])
 by mx.groups.io with SMTP id smtpd.web11.9871.1713351005352524364
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Apr 2024 03:50:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvIuQgOdjCY9vGA5fIF4H0TV/HR/pqMBiwGtg6Rs0aA=;
 b=cIqGY9AHHUiIFaXRidRu2WgOblBtMW+cdFzZPmVQde/WnkmYf5uZd1E8Ss4vTNhi2hN8u4uPEKCDXCasRyop5QzlTYp0dLecfaVpE02w7NBmKtSyAS9rdUzjrcLd0IhZL1UAWqWvJ1qhqW0keU0DKRcYExWNzWRaxK2DDggp2PHceV0LQUhw21Jn+dMdR0PB10UZOql6mcCndEbVAIaHyrfa47S+Q1oMnSR2iMgVOlhh8ITd8XvJjkdXepSsWwuABututgtDm2jXN5y5yY3Bq4XNC1+rYjk7sXM+ypXGQWrRCWGkbs5M4DsOiHKP6xaJP/0P3J25pxKQ/eFUiSKzsA==
Message-ID: <0c3d0d89-dfee-4482-8707-de13f057b8e5@theobroma-systems.com>
Date: Wed, 17 Apr 2024 12:49:59 +0200
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 2/2] fw_env.config: use partition name/label
References: <20240411011638.12198-1-twoerner@gmail.com>
 <20240411011638.12198-2-twoerner@gmail.com>
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240411011638.12198-2-twoerner@gmail.com>
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: yocto-patches@lists.yoctoproject.org, Trevor Woerner <twoerner@gmail.com>
List-ID: <yocto-patches.lists.yoctoproject.org>

Hi Trevor,

On 4/11/24 03:16, Trevor Woerner via lists.yoctoproject.org wrote:
> A filesystem label (/dev/disk/by-label) is a property of, and stored in, the
> filesystem itself. Since the U-Boot environment partition is not formatted (it
> is a raw copy of the generated, binary U-Boot environment) it is not possible
> to assign it a label.
> 
> However, if GPT partitioning is being used, GPT supports the notion of
> assigning labels/names to the partitions which are stored as part of the
> GPT partition table itself (instead of being stored in the filesystem
> in the partition). The naming is a bit confusing (different tools use
> different names) but `wic` calls this "--part-name", `lsblk` calls this
> "PARTLABEL", and `parted` calls this "name".
> 
> In Linux user-space these partition labels are referenced via
> /dev/disk/by-partlabel and provide an excellent way of finding the GPT
> partition containing the U-Boot environment regardless of which backing
> device is actually being used (e.g. mmcblk0, mmcblk1... i.e. emmc,
> sdcard...).
> 
> Tested in both systemd and sysvinit.
> Tested on rock-5b (both emmc and sdcard).
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> v2 changes:
> - new
> ---
>   recipes-bsp/u-boot/u-boot_%.bbappend | 3 +--
>   wic/rockchip.wks                     | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> index 18702428a787..a1dc25449229 100644
> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -59,8 +59,7 @@ do_compile:append:rock2-square () {
>   
>   do_compile:append:rk-u-boot-env() {
>   	UBOOT_ENV_SIZE="$(cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" | cut -d'=' -f2)"
> -	UBOOT_MMC_DEV="$(cat ${B}/.config | grep "^CONFIG_SYS_MMC_ENV_DEV=" | cut -d'=' -f2)"
> -	echo "/dev/mmcblk${UBOOT_MMC_DEV}p5 0x0000 ${UBOOT_ENV_SIZE}" > ${WORKDIR}/fw_env.config
> +	echo "/dev/disk/by-partlabel/uboot_env 0x0000 ${UBOOT_ENV_SIZE}" > ${WORKDIR}/fw_env.config

If you move this patch first in the series, you don't need this diff as 
it would be squashed with the second patch (the one that is currently 
first in the series).

>   }
>   
>   do_deploy:append:rk-u-boot-env() {
> diff --git a/wic/rockchip.wks b/wic/rockchip.wks
> index febb826bccc7..f7e501cbd25e 100644
> --- a/wic/rockchip.wks
> +++ b/wic/rockchip.wks
> @@ -22,7 +22,7 @@ part loader1   --offset 64s    --fixed-size 3552K --fstype=none --source rawcopy
>   part v_storage --offset 7168s  --fixed-size 256K  --fstype=none
>   part reserved  --offset 7680s  --fixed-size 192K  --fstype=none
>   part reserved1 --offset 8064s  --fixed-size 32K   --fstype=none
> -part uboot_env --offset 8128s  --fixed-size 32K   --fstype=none ${RK_UBOOT_ENV}
> +part uboot_env --offset 8128s  --fixed-size 32K   --fstype=none --part-name uboot_env ${RK_UBOOT_ENV}

You could simply have --part-name uboot_env here no? if it was the first 
patch in the series I mean?

 From the commit log, it seems this is required if it is rawcopy but 
otherwise not valid? If true, considering that RK_UBOOT_ENV may be empty 
(and thus not have --source rawcopy), is this actually working for 
setups where MACHINE_FEATURES doesn't have rk-u-boot-env or 
RK_IMAGE_INCLUDES_UBOOT_ENV is not 1?

Cheers,
Quentin
