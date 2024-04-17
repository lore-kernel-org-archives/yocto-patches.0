Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web10.15141.1713365661420383778
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Apr 2024 07:54:21 -0700
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4347e55066cso23630141cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Apr 2024 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713365660; x=1713970460; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIl6jeB+fms+9V+goRzeA/xpMHVFjJVoI1WaBae2iA4=;
        b=lnBm0ETMb89w0jUaAP1SYuw6TJpX0kum2CawzwqXzPQOEGNZrNzx9wn1FEkPN70XB5
         CTZILo5RgIOs1JIsYeb9q2BlutK4VYOollhIRqWgQ5ANNJqtQkqfAo/Re00G81/qoOTC
         Vqidxmywp7hWiG5X89E/q4YRkA9NYd8DtEwN5Hhu++QAQdQnd8Ov4JYYpXRpb8S8zpbw
         EEZMnxnqi8Z9S8uUnlOqe1hcY62FFOnu9+QufUGgfNUyJN7kfGOTct3vOZrmoEVtuuFO
         bn/OOIrFTJrvUu0Iw7nZfsUR3LxbiVDlg3JZO02LliGbuhqD2rbUbHP4nJyL7lYIGluK
         Bl+w==
Return-Path: <twoerner@gmail.com>
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id g6-20020ac81246000000b0043700c0da4asm3674072qtj.4.2024.04.17.07.54.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:54:18 -0700 (PDT)
Date: Wed, 17 Apr 2024 10:54:17 -0400
From: "Trevor Woerner" <twoerner@gmail.com>
Subject: Re: [meta-rockchip][PATCH] u-boot: remove now-upstreamed rock-pi-e patches
Message-ID: <20240417145416.GA17090@localhost>
References: <20240417041013.13341-1-twoerner@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20240417041013.13341-1-twoerner@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

On Wed 2024-04-17 @ 12:10:13 AM, Trevor Woerner wrote:
> These patches were back-ported from upstream to fix an issue with automatically
> handling different ethernet PHY chips on different spins of the rock-pi-e
> board. Now that the version of U-Boot has been updated in oe-core master,
> these pack-ports are no longer required to be applied explicitly.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  ...are_Reset_eth_phy_before_phy_connect.patch | 83 -------------------
>  ...-e_Enable_DM_ETH_PHY_and_PHY_REALTEK.patch | 65 ---------------
>  recipes-bsp/u-boot/u-boot_%.bbappend          |  6 --
>  3 files changed, 154 deletions(-)
>  delete mode 100644 recipes-bsp/u-boot/files/PATCH_1-2_net_designware_Reset_eth_phy_before_phy_connect.patch
>  delete mode 100644 recipes-bsp/u-boot/files/PATCH_2-2_rockchip_rk3328-rock-pi-e_Enable_DM_ETH_PHY_and_PHY_REALTEK.patch

Applied to meta-rockchip, master branch.
