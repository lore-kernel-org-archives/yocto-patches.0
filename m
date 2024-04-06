Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
 by mx.groups.io with SMTP id smtpd.web10.31121.1712417651204757068
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 06 Apr 2024 08:34:11 -0700
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso7737345ad.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 06 Apr 2024 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1712417650; x=1713022450; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=St4OcOBaV/Itw+h6NkNGJxpG7ZTRkQa/nl3b8fa5JhI=;
        b=mx+qDkiTPSRkVN0lawsUsX7D5oTA3CSAGcQPWXqZDYMZDYjvaxLb9GpIGnKWojpn9f
         7XbA1oqF6lRH56Ikiv59si83ejFg77oYL3KS410wcWXLmLHvbwOpVkYUQmK/N9oLgkIt
         33+AucXNiYVRpdu4U1DcDdoVsXnxmIbtFH6Ag=
Return-Path: <tim.orling@konsulko.com>
Received: from localhost ([2601:1c0:ca00:bd60:b218:59be:238f:ebbb])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001e28aa6ab54sm3538867pld.301.2024.04.06.08.34.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 08:34:09 -0700 (PDT)
From: "Tim Orling" <tim.orling@konsulko.com>
Subject: [meta-lts-mixins][scarthgap/u-boot][PATCH 0/2] v2024.04 release
Date: Sat,  6 Apr 2024 08:34:01 -0700
Message-ID: <cover.1712417041.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Since the original RFC [1] (which has been merged as is), u-boot had
an -rc5 release and then the final v2024.04 release.

This series captures the two new updates. Switching to the new yocto-patches
mailing list.

[1] https://lore.kernel.org/yocto/20240320185317.2173087-1-tim.orling@konsulko.com/

The following changes since commit bc4fe6a64de65cb05d46af752715b1eb6f578f57:

  u-boot: bump to v2024.04-rc4 (2024-03-20 11:34:40 -0700)

are available in the Git repository at:

  https://github.com/moto-timo/meta-lts-mixins scarthgap/u-boot
  https://github.com/moto-timo/meta-lts-mixins/tree/scarthgap/u-boot

Tim Orling (2):
  u-boot: bump to v2024.04-rc5
  u-boot: update to final v2024.04 release

 recipes-bsp/u-boot/u-boot-common.inc                            | 2 +-
 .../{u-boot-tools_2024.04-rc4.bb => u-boot-tools_2024.04.bb}    | 0
 recipes-bsp/u-boot/{u-boot_2024.04-rc4.bb => u-boot_2024.04.bb} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-bsp/u-boot/{u-boot-tools_2024.04-rc4.bb => u-boot-tools_2024.04.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot_2024.04-rc4.bb => u-boot_2024.04.bb} (100%)

-- 
2.43.2

