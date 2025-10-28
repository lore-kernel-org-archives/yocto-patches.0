Return-Path: <contact@schnwalter.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233BDCCF9E0
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 13:48:09 +0000 (UTC)
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mx.groups.io with SMTP id smtpd.web11.9401.1761659283389984485
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Oct 2025 06:48:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@schnwalter.eu header.s=fm1 header.b=mkb82cbN;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=n8le7XIR;
 spf=pass (domain: schnwalter.eu, ip: 103.168.172.159, mailfrom: contact@schnwalter.eu)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 529EC14002D7;
	Tue, 28 Oct 2025 09:48:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 09:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schnwalter.eu;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1761659282; x=1761745682; bh=P933wGHCnA
	/lDRdq3zOQuk4m3sPLZNeEFiZ4PT8TIr4=; b=mkb82cbN5/N1RHRQEMJnkvv8Ov
	edPLjfNYtWC8v/r9Z2E7N9MdgCyjugZPGLDiplVIUPJTKdiXdxp2NRHhhnz05CVC
	PWJ4gFqyEu+YEvHWTC+fuSRLh095YIy9dF/fZhLaYOLrcDjIQ6L+QOphsaZ/wW/l
	BSu/QwZKXC7Bw+CcSVWBSaiLLBt0aytsZI9SE2Ra/ZYhk3M7LyUMlcTxFh8pN7He
	WPC2vmggtIipzuVW5OJiJC3eaqKqD9Dx003lHpwlllWb4y6vEvGeNexWPImBiL0v
	1CrbJBnPRQHlC0slQXS4ro36Ha7e8nIDyRWbuESdVIfM/mbHiRwpL8gKiGzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761659282; x=1761745682; bh=P933wGHCnA/lDRdq3zOQuk4m3sPLZNeEFiZ
	4PT8TIr4=; b=n8le7XIRtNfM4XBb6d6S45hip8zsf9KqYEPf6Ebh409U8uC31xX
	t20TYvtIvBRUgx68IgRGWSMIeHmzYMJUm+Omj7tV/Q+ngtpmdkLPdfUafx2NBWZ7
	uKwnE4tq3iAoZV+65XSZgKqUTczlAU3RiWEUUpAalI7dkyNDs+Iu6xXZUWm/w2eo
	9RQCKXAobIr64wFgq9rnPg5iNCG7zQMqNFUWSEZBX/OfPOZxIA0y/8wIt1tj0a54
	w3yiabAn/B4BdlOWZRBj3bO5XwebnIRi+GclqreEcEWs1P/2zyx1jkvQtjdoLrMZ
	OKY1DzzAWY0i8Ykdsll/E/o0ufMCw/bzp5A==
X-ME-Sender: <xms:kckAaf68YjvOY5msPZxB22mBRQjnVW7JR8a38P5gb40SDhe6mFgIGA>
    <xme:kckAaa5LklVYLPJvgGWAdTQySUDVTJcyZwGBl5S0FuLZ5ehC5iN1o3NTVsLj9KNLS
    AsGe6IDUphBc3xnsbacs0k6iwkbqCauNM0mZwgYpMO_c9l8slF2gA>
X-ME-Received: <xmr:kckAaUGD-bsfvCDg8ZLTSx5jYmzgdyl5f1da9ismymHrVOYWBZ0GeotT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhephggrlhhtvghrucgh
    vghrnhgvrhcuufevjffpgffkfffgtfcuoegtohhnthgrtghtsehstghhnhifrghlthgvrh
    drvghuqeenucggtffrrghtthgvrhhnpedtheeugfffjeduffekffekgeetteetvdffueff
    ueduhfejudduiedtteekfeeuudenucffohhmrghinheprhgrugigrgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohhnthgrtght
    sehstghhnhifrghlthgvrhdrvghupdhnsggprhgtphhtthhopedvpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgt
    thhophhrohhjvggtthdrohhrghdprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhlii
    estghhvghrrhihrdguvg
X-ME-Proxy: <xmx:kckAabSR77r0C846secIEz25v3H_YY78sSXLzNt43E45d7F6Ywdj7A>
    <xmx:kckAaVs_nyhnnHgb8A0Q1DTsLXlrx5bbunI-FJ6UCO88dQfncqn0rg>
    <xmx:kckAaSynNU7QRaHakJ83vccaSXcYC1C4UmLYRBfBbTLFvnIxE9YiyQ>
    <xmx:kckAaX5oLqFt3ATltV1mCIKklqePyo_s62pUmyJhQmKQUNqiMLxY0w>
    <xmx:kskAab-75dm_RzB1aEZydBeJ8vovBYEXvtTZ7CWf8IxWJv_snjJGuaxr>
Feedback-ID: i455149b6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 09:48:01 -0400 (EDT)
From: Walter Werner SCHNEIDER <contact@schnwalter.eu>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip] [PATCH v3] rock-pi-4b-plus: add
Date: Tue, 28 Oct 2025 15:45:16 +0200
Message-ID: <20251028134734.974027-1-contact@schnwalter.eu>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Oct 2025 13:48:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2399

The Radxa ROCK (Pi) 4B+ is a SBC with an overclocked RK3399 SoC (the OP1)
and it comes with WiFi5, BT5 and PoE Support.

Product Page:
https://radxa.com/products/rock4/4bp/

Documentation page:
https://docs.radxa.com/en/rock4/rock4ab-se

Specs:
- Rockchip OP1
- Dual-Core Arm Cortex-A72 @ 2.0GHz
- Quad-Core Arm Cortex-A53 @ 1.5GHz
- Arm Mali T860MP4 GPU
- OpenGL ES 1.1/2.0/3.0/3.1/3.2
- Vulkan 1.0
- OpenCL 1.1/1.2
- DirectX 11.1
- LPDDR4 RAM (2/4)
- Onboard eMMC (16/32/64/128 GB)
- 1x M.2 M-Key (4-lane PCIe 2.1) supports NVMe SSD
- 1x Micro SD Card Slot
- 1x HDMI
- 1x 4-lane MIPI DSI
- 1x 2-lane MIPI CSI
- IEEE 802.11 b/g/n/ac and Bluetooth 5.0 with BLE
- 1x Gigabit Ethernet with PoE support via an HAT
- 1x USB3 OTG/HOST port
- 1x USB3 HOST port
- 2x USB2 HOST ports
- 1x 4-ring 3.5mm Headphone Jack
- 40x GPIO, UART, SPI, I2C, PCM/I2S, SPDIF, PWM, ADC, 5V in and 3.3V out
- USB Type-C with PD and Quick Charge
- Dimensions: 85 mm x 56 mm

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Walter Werner SCHNEIDER <contact@schnwalter.eu>
---
V2 -> V3: Updated README
V1 -> V2: Fixed name

 README                            | 1 +
 conf/machine/rock-pi-4b-plus.conf | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 conf/machine/rock-pi-4b-plus.conf

diff --git a/README b/README
index 2cd33a5..f55f750 100644
--- a/README
+++ b/README
@@ -42,6 +42,7 @@ Status of supported boards:
 			rock-5b
 			rock-pi-4a
 			rock-pi-4b
+			rock-pi-4b-plus
 			rock-pi-4c
 			rock-pi-e
 			rock-pi-s
diff --git a/conf/machine/rock-pi-4b-plus.conf b/conf/machine/rock-pi-4b-plus.conf
new file mode 100644
index 0000000..2749c60
--- /dev/null
+++ b/conf/machine/rock-pi-4b-plus.conf
@@ -0,0 +1,9 @@
+#@TYPE: Machine
+#@NAME: Radxa Rock 4B+ OP1
+#@DESCRIPTION: An OP1 SBC with Wi-Fi 5 & BT 5 and PoE Support.
+#https://docs.radxa.com/en/rock4/rock4ab-se
+
+require conf/machine/include/rock-pi-4.inc
+
+KERNEL_DEVICETREE = "rockchip/rk3399-rock-pi-4b-plus.dtb"
+UBOOT_MACHINE = "rock-pi-4-rk3399_defconfig"

