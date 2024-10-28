Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E00D3398E
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 14:33:41 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web11.53197.1730126020089243597
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Oct 2024 07:33:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MsuoQDEe;
 spf=pass (domain: gmail.com, ip: 209.85.210.51, mailfrom: raj.khem@gmail.com)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71811aba576so2775707a34.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Oct 2024 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730126019; x=1730730819; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt66JIt+IEcxPHcMgoI9EleyybyxesGbqLS8KOBILH0=;
        b=MsuoQDEeAfJHCSLfkZmgHsCp8fMtE08BdhNKEYHxecSC03Z5Qj8L1KXBAISRtw5dvW
         PdcMVy20Muuy5Rl3YzVCxOuIF7GqORQm3pcOuGkzO1a7gIfxIfjyMsfOm9A7y1IxEXlR
         E8+CpY63Y5Z+0S5iuJMqRi31bmknHUnPDduFph03l5yL3HwrWx6Hm2BqztcuQMjZWwu8
         ZsK3b8jIMQYzKCE+xXVldotiSGZwbyY78vmfFcEikcOLNQOc2egow3Ou6JbMwyNAQRQq
         zxmxIFdDP+FKVhhdwJlsLGlH2vovACYuc9qbJy3YGL4DtHyRV6E4p8podL8w8qwBqpRr
         Azew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730126019; x=1730730819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt66JIt+IEcxPHcMgoI9EleyybyxesGbqLS8KOBILH0=;
        b=H0+aLpycjQN7FG97sqTLXkyBgWpGnbIOQbR1a3dUi0aIyYwKuwT8aX5MwG5AKFjxzT
         PhKj0LpuQqhGZGG2Y++zWLkHGPTOFXn4BBAbcIQyOZiyyHCECSFwaX9oPUpgbSN7wH3j
         RiNhrGHSVT68HUbz56cN/80y/6NR7Ond3PZCsjA4KtxOCc741g+nWuP3+hf3+DIbbGrE
         GRCeXVLB4hVNizJH7h6HrHT0S5Ts4DeP5dUE9/ZHOG2/9E1mZqDIbuc0gs9K+t4UPXrH
         wSgjxxUKqQaUhrj3r5JBoL5UjAfW4OEDMrqJGoRDAhA+ptS0LzvPXWix8GvoHWAo4IZc
         Xq9w==
X-Gm-Message-State: AOJu0YwjwUTuZhubOziD09N3uYuOZZfASYfyYfpoorXMVAWAr+Fs8Pqb
	xXPOoENzg8DaC1Mi2TAXNgsW/mlK7g58RyJzJXdVYfJvjrE+8R0gALBSM1SOgwnphUFaRUCWWhk
	gHA1FxeggD7xkQi8+pjyJfoVa5Dc=
X-Google-Smtp-Source: AGHT+IEecHgLr/DfbViz71blTI5XlwDOfrWPPbnERMGwa7EmlahdSbtwo/ZrpyQHxy1EFoFLv0LIabtNl8KKNafbHyU=
X-Received: by 2002:a05:6808:1585:b0:3e6:911:a944 with SMTP id
 5614622812f47-3e64f4511cemr12505b6e.22.1730126018948; Mon, 28 Oct 2024
 07:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241028-tf-a-patch-submitted-v1-1-4a4543c3331b@cherry.de>
In-Reply-To: <20241028-tf-a-patch-submitted-v1-1-4a4543c3331b@cherry.de>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 28 Oct 2024 07:33:11 -0700
Message-ID: <CAMKF1sqyZexPdZeQ9s8FzhRHau7i3suEbY1jEO=3gV3iR-zgwg@mail.gmail.com>
Subject: Re: [meta-rockchip PATCH] bsp: trusted-firmware-a: update patches'
 upstream status
To: Quentin Schulz <foss+yocto@0leil.net>
Cc: yocto-patches@lists.yoctoproject.org, 
	Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Oct 2024 14:33:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/768

lgtm

On Mon, Oct 28, 2024 at 7:19=E2=80=AFAM Quentin Schulz <foss+yocto@0leil.ne=
t> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The patches were sent upstream for review, so let's update their
> upstream status to point at the patchset in the appropriate Gerrit.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  ...01-fix-rk3399-dram-Fix-build-with-gcc-11.patch} | 14 ++++++++------
>  ...-plat_macros.S-Use-compatible-.asciz-asm.patch} | 15 +++++++++------
>  ...-pmu-Do-not-mark-already-defined-functio.patch} | 22 ++++++++++++++--=
------
>  .../trusted-firmware-a_%.bbappend                  |  6 +++---
>  4 files changed, 34 insertions(+), 23 deletions(-)
>
> diff --git a/recipes-bsp/trusted-firmware-a/files/0001-dram-Fix-build-wit=
h-gcc-11.patch b/recipes-bsp/trusted-firmware-a/files/0001-fix-rk3399-dram-=
Fix-build-with-gcc-11.patch
> similarity index 71%
> rename from recipes-bsp/trusted-firmware-a/files/0001-dram-Fix-build-with=
-gcc-11.patch
> rename to recipes-bsp/trusted-firmware-a/files/0001-fix-rk3399-dram-Fix-b=
uild-with-gcc-11.patch
> index 120ea0bd363577ed8ed3ce39f93b2561b841e20e..de287c3ef3b3fe2701f3ddb5b=
3accbdcccca280f 100644
> --- a/recipes-bsp/trusted-firmware-a/files/0001-dram-Fix-build-with-gcc-1=
1.patch
> +++ b/recipes-bsp/trusted-firmware-a/files/0001-fix-rk3399-dram-Fix-build=
-with-gcc-11.patch
> @@ -1,7 +1,7 @@
> -From a09a1de53aba422249a8376b0d95024200021317 Mon Sep 17 00:00:00 2001
> +From 300856a62de723e9a04376172e26fb01fa210f6f Mon Sep 17 00:00:00 2001
>  From: Khem Raj <raj.khem@gmail.com>
>  Date: Tue, 11 May 2021 11:55:31 -0700
> -Subject: [PATCH] dram: Fix build with gcc 11
> +Subject: [PATCH 1/3] fix(rk3399): dram: Fix build with gcc 11
>
>  This is a redundant assignment which GCC warns about.
>
> @@ -11,8 +11,13 @@ plat/rockchip/rk3399/drivers/dram/dram_spec_timing.c:7=
81:11: error: explicitly a
>                  twr_tmp =3D twr_tmp;
>                  ~~~~~~~ ^ ~~~~~~~
>
> -Upstream-Status: Pending
>  Signed-off-by: Khem Raj <raj.khem@gmail.com>
> +[add fix(rk3399): prefix to commit title]
> +Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> +Change-Id: Ib12281e0720346ffe68e81a24ea772ddc89d4f83
> +
> +Upstream-Status: Submitted [https://review.trustedfirmware.org/c/TF-A/tr=
usted-firmware-a/+/33082]
> +Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>  ---
>   plat/rockchip/rk3399/drivers/dram/dram_spec_timing.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> @@ -30,6 +35,3 @@ index 3cdb7a296..76bc5ee96 100644
>         else if (twr_tmp <=3D 14)
>                 twr_tmp =3D 14;
>         else
> ---
> -2.31.1
> -
> diff --git a/recipes-bsp/trusted-firmware-a/files/0001-plat_macros.S-Use-=
compatible-.asciz-asm-directive.patch b/recipes-bsp/trusted-firmware-a/file=
s/0002-fix-rockchip-plat_macros.S-Use-compatible-.asciz-asm.patch
> similarity index 64%
> rename from recipes-bsp/trusted-firmware-a/files/0001-plat_macros.S-Use-c=
ompatible-.asciz-asm-directive.patch
> rename to recipes-bsp/trusted-firmware-a/files/0002-fix-rockchip-plat_mac=
ros.S-Use-compatible-.asciz-asm.patch
> index 8807fcaabc0598d9c92b038fa6b443d2d1063945..a6b1522289dc6a12abfa956b3=
070ea1c01a6cecf 100644
> --- a/recipes-bsp/trusted-firmware-a/files/0001-plat_macros.S-Use-compati=
ble-.asciz-asm-directive.patch
> +++ b/recipes-bsp/trusted-firmware-a/files/0002-fix-rockchip-plat_macros.=
S-Use-compatible-.asciz-asm.patch
> @@ -1,13 +1,19 @@
> -From 5f78ce7eb9ab6bf5af682a715a9264d2a5ee7666 Mon Sep 17 00:00:00 2001
> +From 1dcf6b1f6f50396c503c9506629c7a9371f8118b Mon Sep 17 00:00:00 2001
>  From: Khem Raj <raj.khem@gmail.com>
>  Date: Tue, 11 May 2021 12:06:34 -0700
> -Subject: [PATCH] plat_macros.S: Use compatible .asciz asm directive
> +Subject: [PATCH 2/3] fix(rockchip): plat_macros.S: Use compatible .asciz=
 asm
> + directive
>
>  clang asm does not like two strings to .asciz therefore make it single
>  string which works on clang too.
>
> -Upstream-Status: Pending
>  Signed-off-by: Khem Raj <raj.khem@gmail.com>
> +[added fix(rockchip): prefix to commit title]
> +Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> +Change-Id: I5bbc71b3d78c479d0f8099ee0a95ed77287c2bc2
> +
> +Upstream-Status: Submitted [https://review.trustedfirmware.org/c/TF-A/tr=
usted-firmware-a/+/33083]
> +Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>  ---
>   plat/rockchip/common/include/plat_macros.S | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> @@ -26,6 +32,3 @@ index 691beeb44..c07be9ca9 100644
>   newline:
>         .asciz "\n"
>   spacer:
> ---
> -2.31.1
> -
> diff --git a/recipes-bsp/trusted-firmware-a/files/0001-pmu-Do-not-mark-al=
ready-defined-functions-as-weak.patch b/recipes-bsp/trusted-firmware-a/file=
s/0003-fix-rockchip-pmu-Do-not-mark-already-defined-functio.patch
> similarity index 59%
> rename from recipes-bsp/trusted-firmware-a/files/0001-pmu-Do-not-mark-alr=
eady-defined-functions-as-weak.patch
> rename to recipes-bsp/trusted-firmware-a/files/0003-fix-rockchip-pmu-Do-n=
ot-mark-already-defined-functio.patch
> index bd4d2b594e4440024822ea23da49fb8bb2614527..7d9d8a986f790ae09a017f9cc=
8582baf69d5ddb3 100644
> --- a/recipes-bsp/trusted-firmware-a/files/0001-pmu-Do-not-mark-already-d=
efined-functions-as-weak.patch
> +++ b/recipes-bsp/trusted-firmware-a/files/0003-fix-rockchip-pmu-Do-not-m=
ark-already-defined-functio.patch
> @@ -1,24 +1,33 @@
> -From 9d963cd69faf94bdcb80624132fd10392f57875b Mon Sep 17 00:00:00 2001
> +From ba25a5bb2641feeacadbd7ec01ab03169aa0da6e Mon Sep 17 00:00:00 2001
>  From: Khem Raj <raj.khem@gmail.com>
>  Date: Tue, 11 May 2021 12:11:51 -0700
> -Subject: [PATCH] pmu: Do not mark already defined functions as weak
> +Subject: [PATCH 3/3] fix(rockchip): pmu: Do not mark already defined fun=
ctions
> + as weak
>
>  These functions are already defined as static functions in same header
>  Fixes
>
> -| plat/rockchip/common/drivers/pmu/pmu_com.h:35:14: error: weak identifi=
er 'pmu_power_domain_ctr' never declared [-Werror]                         =
                                                             | #pragma weak=
 pmu_power_domain_ctr                                                      =
                                                                           =
                                            |              ^
> +| plat/rockchip/common/drivers/pmu/pmu_com.h:35:14: error: weak identifi=
er 'pmu_power_domain_ctr' never declared [-Werror]
> +| #pragma weak pmu_power_domain_ctr
> +|              ^
>  | plat/rockchip/common/drivers/pmu/pmu_com.h:36:14: error: weak identifi=
er 'check_cpu_wfie' never declared [-Werror]
>  | #pragma weak check_cpu_wfie
>  |              ^
>
> -Upstream-Status: Pending
>  Signed-off-by: Khem Raj <raj.khem@gmail.com>
> +[fixed alignment in commit log]
> +[added fix(rockchip): prefix in commit title]
> +Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> +Change-Id: I96d4acbe743ba4b8996f0be0fa713b341bd4903c
> +
> +Upstream-Status: Submitted [https://review.trustedfirmware.org/c/TF-A/tr=
usted-firmware-a/+/33084]
> +Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>  ---
>   plat/rockchip/common/drivers/pmu/pmu_com.h | 2 --
>   1 file changed, 2 deletions(-)
>
>  diff --git a/plat/rockchip/common/drivers/pmu/pmu_com.h b/plat/rockchip/=
common/drivers/pmu/pmu_com.h
> -index 5359f73b4..3f9ce7df9 100644
> +index 022bb024a..259c8c006 100644
>  --- a/plat/rockchip/common/drivers/pmu/pmu_com.h
>  +++ b/plat/rockchip/common/drivers/pmu/pmu_com.h
>  @@ -32,8 +32,6 @@ enum pmu_pd_state {
> @@ -30,6 +39,3 @@ index 5359f73b4..3f9ce7df9 100644
>
>   static inline uint32_t pmu_power_domain_st(uint32_t pd)
>   {
> ---
> -2.31.1
> -
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend=
 b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
> index c9ad84c248578cd93aeb368f064e58ecf08ca383..8eca63a7a78cc96052455875c=
e75135a7219abaf 100644
> --- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
> @@ -8,9 +8,9 @@ COMPATIBLE_MACHINE:append:px30 =3D "|px30"
>
>  FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
>  SRC_URI +=3D "\
> -    file://0001-dram-Fix-build-with-gcc-11.patch \
> -    file://0001-plat_macros.S-Use-compatible-.asciz-asm-directive.patch =
\
> -    file://0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch =
\
> +    file://0001-fix-rk3399-dram-Fix-build-with-gcc-11.patch \
> +    file://0002-fix-rockchip-plat_macros.S-Use-compatible-.asciz-asm.pat=
ch \
> +    file://0003-fix-rockchip-pmu-Do-not-mark-already-defined-functio.pat=
ch \
>  "
>
>
>
> ---
> base-commit: 24a411a17f389650c4cea38bef1f9279117fab8e
> change-id: 20241028-tf-a-patch-submitted-ea5291721247
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>

