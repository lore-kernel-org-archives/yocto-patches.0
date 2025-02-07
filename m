Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF9AC02194
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 16:52:04 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web10.74381.1738947115413413267
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Feb 2025 08:51:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V7SveOL+;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467b086e0easo12247901cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Feb 2025 08:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738947114; x=1739551914; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jrqf9YaFIZl4i4nPBFRKfitFMRG7FcSp98kUISdARE=;
        b=V7SveOL+B2+fMkfZsA4uIN/dazawEuTefEiIvnEu2T//6lDwACjyGF3VgnDjc2KG4a
         oK+EuUDaEweh2MukrjOQP5teXQN9A/RMrcDyZ4Dp71mysm4kepnrS1eqXYbyz7KxU9Hy
         peuzo63KsVPQwhByVsU+JfHu4UsrlicA9u0T6bX9WD/Q7mYools8AfCypjkaqeymQFDD
         gFSxEkRN2Dp2HxTXqC/Vpy8qwmzQYR6W/aC4LKrrCX5V/hu/Axpqtu/TP/HzyVve9KL0
         MqelGKpfiXWNyQYLM8+l60Ge/UHTxTaxSh9MCW6u+D7LqyR6YamYvDeQaYiASOTpVB3E
         KhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738947114; x=1739551914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jrqf9YaFIZl4i4nPBFRKfitFMRG7FcSp98kUISdARE=;
        b=e8WLLo1jNQRoDKAfcjs3MVXWeU8OvaTYp/s0X/SYvnUDpSRp1erWVM9m8T1+HszM49
         te3l3Z/mgGuU4Sd3QacLna+twdeVz/C7cH84fv7QCHhQ2CGE34UIMRwrCCsKWeExaMMS
         ruWL6XX+jWwe2NaU2xUa31rwnWmHQvU/A/8GveiSYMWZJcOvMYMXzmp7KVSliDQct5aF
         EArbj7hsZSLdu+S/lqmug+RuONBhFx3moABJQk3eUnkHYxwHoR3ZKaPpTq0YtAvt3LmM
         QuXN/7WLp+jAMMfFEXdiT2Audt1H19Q8e/MeFsnCna7SzIgy/s2Ly7qBRNK4NAzfJVr3
         MdJw==
X-Gm-Message-State: AOJu0Yy9A5MY2UKUNLdv0mspwycW6gPCDmwQcdE5Xv/gogQXhaeOJeft
	QBWFjkgSUvkIUll8WXRp510wK6FjAJFJQudtOSF9k6hiIB5b1twa5KYKVJ3b
X-Gm-Gg: ASbGncul6w/7t0A9qQ9XzAjMPP5L1wC03EXc70Mrunaf7x9X1IcmmRV4tB2oNuY8R1u
	0SAI+JuGNGoU5I3KEjupc/6bthiuFzsjJL9E5EOAFaYru+K+lUKkhGBv9HBdeN4BhrshfWm7oLz
	5AqEtk152U4fabFd/K8SfcEIQsemc0NaEmDjq9MfTZRj8pNdYNs4R17RCjw824PQdJAuhWlwi+P
	Aryd5J0kgmiOSFpNdjvCUv5HaEI7HIlgM+vB3VjkKk5X9yILrsXQcXg49yh47tiK+VQqn+BXCgP
	X74elWbYXPhnd6eWEdbJmGex9gbre+rCHjKusB/0sVJdF0LiVFDTFrftxas=
X-Google-Smtp-Source: AGHT+IH7zUunw0N/i41shVT0H12zNcbE1PZffEJb++vJCedhFFDHNBjFdF4+WfItxAb2OJ+kcBjumQ==
X-Received: by 2002:ac8:5d03:0:b0:467:69f5:c2d9 with SMTP id d75a77b69052e-47167b7d00amr62839591cf.47.1738947113558;
        Fri, 07 Feb 2025 08:51:53 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153beaabfsm18476451cf.66.2025.02.07.08.51.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 08:51:52 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] rk3308: add WIP thermal support
Date: Fri,  7 Feb 2025 11:51:47 -0500
Message-ID: <20250207165147.16173-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Feb 2025 16:52:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1049

Jonas Karlman provided a WIP patch to add SoC thermal support for rk3308.
Hopefully this, or some variant thereof, makes it upstream.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../linux/linux-yocto/rk3308-therm.patch      | 212 ++++++++++++++++++
 recipes-kernel/linux/linux-yocto_%.bbappend   |   1 +
 2 files changed, 213 insertions(+)
 create mode 100644 recipes-kernel/linux/linux-yocto/rk3308-therm.patch

diff --git a/recipes-kernel/linux/linux-yocto/rk3308-therm.patch b/recipes-kernel/linux/linux-yocto/rk3308-therm.patch
new file mode 100644
index 000000000000..5b93f3dce223
--- /dev/null
+++ b/recipes-kernel/linux/linux-yocto/rk3308-therm.patch
@@ -0,0 +1,212 @@
+From d834afa5a039394ca3a15fa5db9434e82522d068 Mon Sep 17 00:00:00 2001
+From: Jonas Karlman <jonas@kwiboo.se>
+Date: Fri, 7 Feb 2025 10:35:01 +0000
+Subject: [PATCH] WIP: rockchip_thermal: rk3308
+
+Upstream-Status: Pending
+Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
+---
+ arch/arm64/boot/dts/rockchip/rk3308-evb.dts   |  6 ++
+ .../arm64/boot/dts/rockchip/rk3308-roc-cc.dts |  6 ++
+ .../boot/dts/rockchip/rk3308-rock-pi-s.dts    |  6 ++
+ .../boot/dts/rockchip/rk3308-rock-s0.dts      |  6 ++
+ arch/arm64/boot/dts/rockchip/rk3308.dtsi      | 71 +++++++++++++++++++
+ drivers/thermal/rockchip_thermal.c            | 28 ++++++++
+ 6 files changed, 123 insertions(+)
+
+diff --git a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
+index 3f1aafe2dc139..619f4dd45b423 100644
+--- a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
++++ b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
+@@ -195,6 +195,12 @@
+ 	vref-supply = <&vcc_1v8>;
+ };
+ 
++&tsadc {
++	rockchip,hw-tshut-mode = <0>;
++	rockchip,hw-tshut-polarity = <1>;
++	status = "okay";
++};
++
+ &pinctrl {
+ 	pinctrl-names = "default";
+ 	pinctrl-0 = <&rtc_32k>;
+diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+index 629121de5a13d..1c6dcda2811e0 100644
+--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
++++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+@@ -185,6 +185,12 @@
+ 	status = "okay";
+ };
+ 
++&tsadc {
++	rockchip,hw-tshut-mode = <0>;
++	rockchip,hw-tshut-polarity = <1>;
++	status = "okay";
++};
++
+ &uart2 {
+ 	status = "okay";
+ };
+diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+index 7a32972bc2496..9af2cdd864526 100644
+--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
++++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+@@ -337,6 +337,12 @@
+ 	status = "okay";
+ };
+ 
++&tsadc {
++	rockchip,hw-tshut-mode = <0>;
++	rockchip,hw-tshut-polarity = <1>;
++	status = "okay";
++};
++
+ &u2phy {
+ 	status = "okay";
+ 
+diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
+index 8311af4c8689f..ee2574c5945bb 100644
+--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
++++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts
+@@ -260,6 +260,12 @@
+ 	status = "okay";
+ };
+ 
++&tsadc {
++	rockchip,hw-tshut-mode = <0>;
++	rockchip,hw-tshut-polarity = <1>;
++	status = "okay";
++};
++
+ &u2phy {
+ 	status = "okay";
+ };
+diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+index 31c25de2d689c..c83ce6d84af20 100644
+--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
++++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+@@ -561,6 +561,77 @@
+ 		status = "disabled";
+ 	};
+ 
++	thermal-zones {
++		soc_thermal: soc-thermal {
++			polling-delay-passive = <20>;
++			polling-delay = <1000>;
++			sustainable-power = <300>;
++			thermal-sensors = <&tsadc 0>;
++
++			trips {
++				threshold: trip-point-0 {
++					temperature = <70000>;
++					hysteresis = <2000>;
++					type = "passive";
++				};
++
++				target: trip-point-1 {
++					temperature = <85000>;
++					hysteresis = <2000>;
++					type = "passive";
++				};
++
++				soc_crit: soc-crit {
++					temperature = <115000>;
++					hysteresis = <2000>;
++					type = "critical";
++				};
++			};
++
++			cooling-maps {
++				map0 {
++					trip = <&target>;
++					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
++					contribution = <4096>;
++				};
++			};
++		};
++
++		logic_thermal: logic-thermal {
++			polling-delay-passive = <100>;
++			polling-delay = <1000>;
++			thermal-sensors = <&tsadc 1>;
++
++			trips {
++				logic_crit: logic-crit {
++					temperature = <115000>;
++					hysteresis = <2000>;
++					type = "critical";
++				};
++			};
++		};
++	};
++
++	tsadc: tsadc@ff1f0000 {
++		compatible = "rockchip,rk3308-tsadc", "rockchip,px30-tsadc";
++		reg = <0x0 0xff1f0000 0x0 0x100>;
++		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
++		assigned-clock-rates = <50000>;
++		assigned-clocks = <&cru SCLK_TSADC>;
++		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
++		clock-names = "tsadc", "apb_pclk";
++		pinctrl-names = "init", "default", "sleep";
++		pinctrl-0 = <&tsadc_otp_pin>;
++		pinctrl-1 = <&tsadc_otp_out>;
++		pinctrl-2 = <&tsadc_otp_pin>;
++		resets = <&cru SRST_TSADC>;
++		reset-names = "tsadc-apb";
++		#thermal-sensor-cells = <1>;
++		rockchip,grf = <&grf>;
++		rockchip,hw-tshut-temp = <120000>;
++		status = "disabled";
++	};
++
+ 	otp: efuse@ff210000 {
+ 		compatible = "rockchip,rk3308-otp";
+ 		reg = <0x0 0xff210000 0x0 0x4000>;
+diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
+index f551df48eef93..9eb6b1a58aeb6 100644
+--- a/drivers/thermal/rockchip_thermal.c
++++ b/drivers/thermal/rockchip_thermal.c
+@@ -1159,6 +1159,30 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
+ 	},
+ };
+ 
++static const struct rockchip_tsadc_chip rk3308_tsadc_data = {
++	/* cpu, logic */
++	.chn_offset = 0,
++	.chn_num = 2, /* 2 channels for tsadc */
++
++	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
++	.tshut_temp = 95000,
++
++	.initialize = rk_tsadcv2_initialize,
++	.irq_ack = rk_tsadcv3_irq_ack,
++	.control = rk_tsadcv3_control,
++	.get_temp = rk_tsadcv2_get_temp,
++	.set_alarm_temp = rk_tsadcv2_alarm_temp,
++	.set_tshut_temp = rk_tsadcv2_tshut_temp,
++	.set_tshut_mode = rk_tsadcv2_tshut_mode,
++
++	.table = {
++		.id = rk3328_code_table,
++		.length = ARRAY_SIZE(rk3328_code_table),
++		.data_mask = TSADCV2_DATA_MASK,
++		.mode = ADC_INCREMENT,
++	},
++};
++
+ static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
+ 	/* cpu */
+ 	.chn_offset = 0,
+@@ -1321,6 +1345,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
+ 		.compatible = "rockchip,rk3288-tsadc",
+ 		.data = (void *)&rk3288_tsadc_data,
+ 	},
++	{
++		.compatible = "rockchip,rk3308-tsadc",
++		.data = (void *)&rk3308_tsadc_data,
++	},
+ 	{
+ 		.compatible = "rockchip,rk3328-tsadc",
+ 		.data = (void *)&rk3328_tsadc_data,
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index 56ec9d7ea81b..cc0bfb12028c 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -26,3 +26,4 @@ COMPATIBLE_MACHINE:soquartz = "soquartz"
 
 SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
 SRC_URI:append:nanopi-r4s = " file://nanopi-r4s.scc"
+SRC_URI:append:rk3308 = " file://rk3308-therm.patch"
-- 
2.44.0.501.g19981daefd7c


