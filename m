Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
 by mx.groups.io with SMTP id smtpd.web10.31135.1712417658757972732
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 06 Apr 2024 08:34:18 -0700
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1e0edd0340fso28317645ad.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 06 Apr 2024 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1712417657; x=1713022457; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slxfOVk4dgypDVCfxBuBFz8pJF1UaR6xr2xgMMMfRnU=;
        b=BJNY7QT6CEGk0SVD2jleiOKH8oR4hY4a49zNyeMQyHxcFbXjdj/soJvCx44/Q7TKTk
         tvd3nDn6Y5QcrjVOpLR1i5hc3miTrQTIxwVzyKPjRfX241tyLjWQDaawEMh95yXqQjO4
         4Ox42bg9WaTbfeJJ04XDkIaQv8KwNALe8sUXs=
Return-Path: <tim.orling@konsulko.com>
Received: from localhost ([2601:1c0:ca00:bd60:b218:59be:238f:ebbb])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902f1d200b001deeac592absm3556041plc.180.2024.04.06.08.34.16
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 08:34:16 -0700 (PDT)
From: "Tim Orling" <tim.orling@konsulko.com>
Subject: [meta-lts-mixins][scarthgap/u-boot][PATCH 2/2] u-boot: update to final v2024.04 release
Date: Sat,  6 Apr 2024 08:34:03 -0700
Message-ID: <66ceeebd047d7fdfc8668b300319a76da8ae257d.1712417041.git.tim.orling@konsulko.com>
In-Reply-To: <cover.1712417041.git.tim.orling@konsulko.com>
References: <cover.1712417041.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Release announcement:
https://lists.denx.de/pipermail/u-boot/2024-April/549827.html

"The merge window is formally open again, and I'll be merging in next
shortly. v2024.07 is scheduled for Monday, July 1st, 2024 and the merge
window will close and -rc1 will be released on the 22nd of April, and
then the next window will open with -rc2, two weeks later.
"

Changes since -rc5:
https://github.com/u-boot/u-boot/compare/v2024.04-rc5...v2024.04

Complete changelog of merges from v2024.01...v2024.04:

425dc46a2c Merge tag 'u-boot-imx-master-20240330' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
9468bf3a69 Merge tag 'doc-2024-04-rc6' of https://source.denx.de/u-boot/custodians/u-boot-efi
a5ec56aea1 Merge https://source.denx.de/u-boot/custodians/u-boot-riscv
34f0452e0e Merge tag 'u-boot-amlogic-fixes-20240325' of https://source.denx.de/u-boot/custodians/u-boot-amlogic
5397daaed8 Merge tag 'efi-2024-04-rc5-2' of https://source.denx.de/u-boot/custodians/u-boot-efi
6ec096a711 Merge tag 'u-boot-imx-master-20240317' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
86fd291a79 Merge tag 'efi-2024-04-rc5' of https://source.denx.de/u-boot/custodians/u-boot-efi
a81242099c Merge tag 'mips-fixes-for-v2024.04' of https://source.denx.de/u-boot/custodians/u-boot-mips
7422f661e2 Merge https://source.denx.de/u-boot/custodians/u-boot-riscv
da07a629e1 Merge tag 'u-boot-imx-master-20240311' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
0981f8900f Merge https://source.denx.de/u-boot/custodians/u-boot-usb
485bfe1adb Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-marvell
46e3871aa6 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sunxi
773cb2bca7 Merge tag 'u-boot-imx-master-20240304' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
eac52e4be4 Merge patch series "ARM: renesas: Rename R-Mobile to Renesas"
574aac1c8c Merge branch 'master-riic' of https://source.denx.de/u-boot/custodians/u-boot-sh
44a15c3f4e Merge patch series "toradex: fix reset and hardware detection regressions"
abd4fb5ac1 Merge patch series "Dockerfile: Build coreboot from source"
1a66a7768a Merge tag 'u-boot-imx-master-20240224' of https://source.denx.de/u-boot/custodians/u-boot-imx
bb9d6c7f4f Merge tag 'u-boot-amlogic-fixes-20240223' of https://source.denx.de/u-boot/custodians/u-boot-amlogic
5e4a0c7f4a Merge branch 'qcom-fixes-2024.04' of https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon
7bb761c42d Merge patch series "board/ti: k3 boards: Stop using findfdt"
1817afe30f Merge https://gitlab.denx.de/u-boot/custodians/u-boot-usb
bebf916f9e Merge https://gitlab.denx.de/u-boot/custodians/u-boot-samsung
3e6f2a94bf Merge tag 'u-boot-imx-master-20240219' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
e4013bcb10 Merge branch 'master-porter' of https://source.denx.de/u-boot/custodians/u-boot-sh
9e00b6993f Merge tag 'u-boot-dfu-20240215' of https://source.denx.de/u-boot/custodians/u-boot-dfu
77ff61a5bb Merge tag 'xilinx-for-v2024.04-rc3' of https://source.denx.de/u-boot/custodians/u-boot-microblaze
0b66c54a97 Merge branch '2024-02-13-assorted-updates'
73b5b47dd5 Merge tag 'doc-2024-04-rc2' of https://source.denx.de/u-boot/custodians/u-boot-efi
91c37c4a20 Merge tag 'u-boot-imx-master-20240212' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
e8f2404e09 Merge branch 'master-779h0-r2' of https://source.denx.de/u-boot/custodians/u-boot-sh
d7aaaf4223 Merge tag 'u-boot-dfu-20240209' of https://source.denx.de/u-boot/custodians/u-boot-dfu
2b51069b7c Merge tag 'u-boot-imx-master-20240208' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
a7fb2f57ad Merge tag 'fsl-qoriq-2024-2-8' of https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq
0101a2ffe1 Merge branch '2024-02-06-assorted-fixes'
7ebc77fede Merge tag 'u-boot-rockchip-20240207' of https://source.denx.de/u-boot/custodians/u-boot-rockchip
daa3100250 Merge patch series "board: siemens: clean up subfolders"
090d8463b0 Merge tag 'rpi-next-2024.04' of https://source.denx.de/u-boot/custodians/u-boot-raspberrypi
819abd0a1e Merge tag 'smbios-2024-04-rc2' of https://source.denx.de/u-boot/custodians/u-boot-efi
050a9b981d Merge tag 'u-boot-amlogic-fixes-20240201' of https://source.denx.de/u-boot/custodians/u-boot-amlogic
f0df21b40c Merge https://source.denx.de/u-boot/custodians/u-boot-watchdog
b6d8969bcb Merge tag 'u-boot-at91-2024.04-a' of https://source.denx.de/u-boot/custodians/u-boot-at91
625e68ef65 Merge https://source.denx.de/u-boot/custodians/u-boot-riscv
28760ce864 Merge tag 'clk-2024.04-rc2' of https://source.denx.de/u-boot/custodians/u-boot-clk
d5c0c990c3 Merge tag 'efi-2024-04-rc1-4' of https://source.denx.de/u-boot/custodians/u-boot-efi
073f4f10b9 Merge patch series "Move framebuffer reservation for SPL to RAM end"
8986be59e7 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-spi
41a737bb85 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sunxi
ce54325c42 Merge branch '2024-01-29-pytest-enhancements'
526a865fe4 Merge branch 'master-cleanup' of https://source.denx.de/u-boot/custodians/u-boot-sh
fb5fe1bf84 Merge tag 'smbios-2024-04-rc1-2' of https://source.denx.de/u-boot/custodians/u-boot-efi
e7f9e5eb58 Merge branch '2024-01-24-assorted-fixes-and-updates'
15e7927b5a Merge patch series "omap3: Make SPL_OMAP3_ID_NAND depend on NAND_OMAP_GPMC"
c09ec8e1cb Merge https://gitlab.denx.de/u-boot/custodians/u-boot-marvell
d64e05fc5b Merge tag 'u-boot-imx-master-20240122' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
79a9697894 Merge commit '3c9bb8fbdc77f6bd56e97597d875d8965db3b96c' of https://github.com/tienfong/uboot_mainline
22aeab2d96 Merge tag 'efi-2024-04-rc1-3' of https://source.denx.de/u-boot/custodians/u-boot-efi
3c04fcf313 Merge patch series "k3-j721e: beagleboneai: Fix USB"
83a8424722 Merge tag 'u-boot-stm32-20240119' of https://source.denx.de/u-boot/custodians/u-boot-stm
f4d5486506 Merge branch '2024-01-18-assorted-fixes'
cb49375239 Merge tag 'u-boot-rockchip-20240119' of https://source.denx.de/u-boot/custodians/u-boot-rockchip
002764d739 Merge tag 'xilinx-for-v2024.04-rc1-v2' of https://source.denx.de/u-boot/custodians/u-boot-microblaze
bdaa0b27b3 Merge tag 'efi-2024-04-rc1-2' of https://source.denx.de/u-boot/custodians/u-boot-efi
106332d6cc Merge branch '2024-01-16-assorted-updates-and-improvements'
043ca8c8a9 Merge tag 'qcom-2024.04-rc1' of https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon
6ca9349b67 Merge tag 'u-boot-imx-20240115' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
b9631fe781 Merge tag 'u-boot-nand-20240115' of https://source.denx.de/u-boot/custodians/u-boot-nand-flash
697758e7c8 Merge branch 'master-sync-dts-663' of https://source.denx.de/u-boot/custodians/u-boot-sh
817fdce324 Merge tag 'efi-2024-04-rc1' of https://source.denx.de/u-boot/custodians/u-boot-efi
547d3dd28a Merge branch '2024-01-12-assorted-fixes'
2ee7a8ec6f Merge patch series "net fixes prior lwip"
d3dba8a28b Merge tag 'u-boot-dfu-20240111' of https://source.denx.de/u-boot/custodians/u-boot-dfu
254a81c6b6 Merge https://source.denx.de/u-boot/custodians/u-boot-marvell
344667db64 Merge tag 'smbios-2024-04-rc1' of https://source.denx.de/u-boot/custodians/u-boot-efi
0727b10f6b Merge branch 'master' of https://gitlab.denx.de/u-boot/custodians/u-boot-samsung
c7937a4199 Merge tag 'rng-2024-04-rc1' of https://gitlab.denx.de/u-boot/custodians/u-boot-efi
c5e461fbf7 Merge tag 'u-boot-imx-master-20240108' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
93d91e9485 Merge branch 'next'
f28a77589e Merge tag 'dm-next-7jan23' of https://source.denx.de/u-boot/custodians/u-boot-dm into next
c2c598e87c Merge branch 'staging' of https://source.denx.de/u-boot/custodians/u-boot-tegra into next
18fa946ab9 Merge branch '2024-01-05-fw_env-fixes' into next
0d53be75c7 Merge patch series "ATF and OP-TEE Firewalling for K3 devices."
93a0138acb Merge tag 'v2024.01-rc6' into next
dffa6d0210 Merge tag 'dm-next-1124' of https://source.denx.de/u-boot/custodians/u-boot-dm into next
2b28c3b871 Merge patch series "Modernize U-Boot shell"
64e47952f5 Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-riscv into next
7c4647b8fb Merge patch series "Complete decoupling of bootm logic from commands"
ced928b199 Merge branch '2023-12-21-assorted-updates-and-fixes' into next
ae797e022e Merge branch '2023-12-21-header-inclusion-cleanup' into next
36d3db6c2c Merge branch '2023-12-20-assorted-general-updates' into next
a0d0e132b3 Merge tag 'u-boot-imx-next-20231220' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next
f7655af980 Merge tag 'u-boot-amlogic-next-20231220' of https://source.denx.de/u-boot/custodians/u-boot-amlogic into next
1f115bdeb8 Merge branch 'staging' of https://source.denx.de/u-boot/custodians/u-boot-tegra into next
936d0f9dd7 Merge patch series "Fix J7200 kernel boot when using upstream u-boot"
9cfef5fcfb Merge patch series "Add support for MediaTek MT8365 EVK Board"
298419ba4d Merge branch '2023-12-19-assorted-platform-updates' into next
a6f86132e3 Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-riscv into next
cd908ba186 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-spi into next
1373ffde52 Merge tag 'v2024.01-rc5' into next
fdefb4e194 Merge tag 'efi-next-20231217' of https://source.denx.de/u-boot/custodians/u-boot-efi into next
8bb3cd7fe7 Merge tag 'clk-2024.01-next' of https://source.denx.de/u-boot/custodians/u-boot-clk into next
57e584d941 Merge branch '2023-12-15-assorted-TI-platform-updates' into next
c936ef7870 Merge tag 'u-boot-stm32-20231215' of https://source.denx.de/u-boot/custodians/u-boot-stm into next
d7a2c7ff75 Merge patch series "bootm: Handle compressed arm64 images with bootm"
fa3f19aa56 Merge tag 'xilinx-for-v2024.04-rc1' of https://source.denx.de/u-boot/custodians/u-boot-microblaze into next
11e1cc7aae Merge tag 'u-boot-imx-next-20231214' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next
86f623dcf8 Merge tag 'dm-next-13dec23' of https://gitlab.denx.de/u-boot/custodians/u-boot-dm into next
9565771076 Merge patch series "bootm: Refactoring to reduce reliance on CMDLINE (part A)"
bfe3c7b93b Merge patch series "some LED patches"
e54987d6af Merge patch series "cmd: bdinfo: Optionally use getopt and implement bdinfo -a"
d379150621 Merge tag 'v2024.01-rc4' into next
4a363dd516 Merge branch 'staging' of https://source.denx.de/u-boot/custodians/u-boot-tegra into next
6357cf0cc4 Merge branch '2023-11-29-assorted-platform-updates' into next
339d96822e Merge patch series "cmd: add scmi command"
e2a9edc0ce Merge patch series "fs: fat: calculate FAT type based on cluster count"
38cc6cdeb1 Merge patch series "Import "string" I/O functions from Linux"
66c21738fd Merge patch series "sysinfo: Expand sysinfo with some more banner information"
d6e052c615 Merge patch series "ufs: Add a PCI UFS controller support"
129d6a0d87 Merge tag 'u-boot-dfu-next-20231124' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next
1682d97db9 Merge branch '2023-11-25-assorted-platform-updates' into next
054222eb68 Merge branch '2023-11-22-TI-K3-cleanups' into next
0744fef6a3 Merge tag 'tpm-next-22112023' of https://source.denx.de/u-boot/custodians/u-boot-tpm into next
dca7a8958f Merge tag 'v2024.01-rc3' into next
9e4b42267e Merge tag 'efi-next-18112023' of https://source.denx.de/u-boot/custodians/u-boot-tpm into next
ae7ec8b0be Merge branch '2023-11-16-assorted-updates' into next
6c1608b1ff Merge patch series "spl: Use common function for loading/parsing images"
5e6a112e11 Merge patch series "nand: Add sandbox tests"
be0724601a Merge tag 'u-boot-stm32-20231113' of https://source.denx.de/u-boot/custodians/u-boot-stm into next
3b6db6901f Merge branch '2023-11-10-improve-semihosting-armv6' into next
1e4d9dd871 Merge branch '2023-11-07-assorted-big-cleanups' into next

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 recipes-bsp/u-boot/u-boot-common.inc                            | 2 +-
 .../{u-boot-tools_2024.04-rc5.bb => u-boot-tools_2024.04.bb}    | 0
 recipes-bsp/u-boot/{u-boot_2024.04-rc5.bb => u-boot_2024.04.bb} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-bsp/u-boot/{u-boot-tools_2024.04-rc5.bb => u-boot-tools_2024.04.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot_2024.04-rc5.bb => u-boot_2024.04.bb} (100%)

diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
index 01067f6..ca53573 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -12,7 +12,7 @@ PE = "1"
 
 # We use the revision in order to avoid having to fetch it from the
 # repo during parse
-SRCREV = "dde373bde392c38649c8c4420e0c98ef8d38d9dc"
+SRCREV = "25049ad560826f7dc1c4740883b0016014a59789"
 
 SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master"
 
diff --git a/recipes-bsp/u-boot/u-boot-tools_2024.04-rc5.bb b/recipes-bsp/u-boot/u-boot-tools_2024.04.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-tools_2024.04-rc5.bb
rename to recipes-bsp/u-boot/u-boot-tools_2024.04.bb
diff --git a/recipes-bsp/u-boot/u-boot_2024.04-rc5.bb b/recipes-bsp/u-boot/u-boot_2024.04.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot_2024.04-rc5.bb
rename to recipes-bsp/u-boot/u-boot_2024.04.bb
-- 
2.43.2

