Return-Path: <contact@schnwalter.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDABCCF9E5
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 23:07:35 +0000 (UTC)
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mx.groups.io with SMTP id smtpd.web10.5158.1761606453061645488
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Oct 2025 16:07:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@schnwalter.eu header.s=fm1 header.b=TgS8hL2k;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=GHzDPWh+;
 spf=pass (domain: schnwalter.eu, ip: 103.168.172.158, mailfrom: contact@schnwalter.eu)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 515FC1400240;
	Mon, 27 Oct 2025 19:07:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 27 Oct 2025 19:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schnwalter.eu;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1761606452; x=1761692852; bh=fBT0LAKg1TZi2x/3q73Pz
	twUjvA/ZcEPAYZXACJucTg=; b=TgS8hL2kOU1/VOnbwr8mOYWbbQLoZ3xNhw22v
	eU6uDhl/Qv0fz2iJxF1DvX4ZtsTdkclmCX22Eb9BQpJXCiz5jOv3y/w4kTUv+3uj
	VUzKxDrCA8V4mZjrlR0Uladu9ALHxSeT75cZh1jhZXpyUmOE7yEkTwfcwZVKbcRl
	wcMbzlJ5sPnvSV9wwBmVnVlFX3cugeEPXjvn7UNxXcxS+K+eCEucwuRBXnMXpgKv
	hQ986FavoWvfpiCiqnPJDmnisBkTh1T+rj4I/hGGIbyHXJ3jcehXK94s8ho2YzHs
	YkFD6oCX6R75guUbrIq/t3QOAA2bhj6Xfz4HtIQcW9rgNGXyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761606452; x=1761692852; bh=fBT0LAKg1TZi2x/3q73PztwUjvA/ZcEPAYZ
	XACJucTg=; b=GHzDPWh+hA0JuGq4DfM6rPHMJf3TLiZvZOSSyD7YN/iriaVx+tZ
	3E1gJL+0wepf4DtpjBXANKqCr+C2H2nlDwc9AKgeufHuXhkTwlwqwSZlqdF4a9yB
	NOop+Jpg5g5eYfjwmvuD4wvuSSxbItr1NQxE7rn+8lCrIMOu6udxigrWOXyDojyN
	jVZviYpI1B7JLEkouQDv2+Hnxy2RJR2eq6hIEzutDsMM75n1I1Ir5nW4hD56M7Fi
	06eH0vU0L7aqzMoTDCCm/O6ISu+jJFG0uImicDKBtdL7hUTt+rkFGhD/vRu9LACt
	w4xslREVUzJYrQSg9WqC7HlLgTOYA81XFuA==
X-ME-Sender: <xms:NPv_aHehjzPhrNiezeWg2DvYnOWis_oDeQcLDWKHGQfJGavsmWxYvQ>
    <xme:NPv_aEK-jLGCjcsbSjaYiS_4ftbzmaLvjMLZRI1jRNZlQKbJRIIVkq8Z6tALmvhg2
    cFqbClCOI9ietPWshpKRQRifIHyhx5Vnnp4VQb_QCOlSIsHgCwLj7c>
X-ME-Received: <xmr:NPv_aGK51iiG8JjfIp19c1lB6gpuuZ0Qib5T56x1zVL7GC_VlVZ9Mqj3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
    enucfhrhhomhephggrlhhtvghrucghvghrnhgvrhcuufevjffpgffkfffgtfcuoegtohhn
    thgrtghtsehstghhnhifrghlthgvrhdrvghuqeenucggtffrrghtthgvrhhnpeekfffgje
    dthfekffeuhfefieefueeviefhgeeggeeljedugfduleeuiedtkeejfeenucffohhmrghi
    nheprhgrugigrgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegtohhnthgrtghtsehstghhnhifrghlthgvrhdrvghupdhnsggprhgt
    phhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihohgtthhoqdhprg
    httghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-ME-Proxy: <xmx:NPv_aOF7yJg4RZIU4cZ9ZiVqOMw3OAv9ESgn_OIdks8G_BrhzA_NQA>
    <xmx:NPv_aDnaOR9Bs2yiHOpi6s8910YqadQCu-_SCiWRZ7WTH6kk_Yghgg>
    <xmx:NPv_aDIN6KG56TTHaTkurV8S1VtGt1IA4pUP-zc_z_rDJDvh60CfBg>
    <xmx:NPv_aMaTvwDj88cLOs-dbsfk4KYMBKPwb0G3Hg1Z5Qi8OFMjQ_2GCA>
    <xmx:NPv_aNTU8r4LMm75Q-Kpbf9yH00DeqdzgUwc9AqFYitaGXAeK1S8ywcs>
Feedback-ID: i455149b6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Mon,
 27 Oct 2025 19:07:31 -0400 (EDT)
From: Walter Werner SCHNEIDER <contact@schnwalter.eu>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip] [PATCH v2] rock-pi-4b-plus: add
Date: Tue, 28 Oct 2025 01:06:55 +0200
Message-ID: <20251027230722.524532-1-contact@schnwalter.eu>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Oct 2025 23:07:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2395

Signed-off-by: Walter Werner SCHNEIDER <contact@schnwalter.eu>
---
 conf/machine/rock-pi-4b-plus.conf | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 conf/machine/rock-pi-4b-plus.conf

diff --git a/conf/machine/rock-pi-4b-plus.conf b/conf/machine/rock-pi-4b-plus.conf
new file mode 100644
index 0000000..9a5117b
--- /dev/null
+++ b/conf/machine/rock-pi-4b-plus.conf
@@ -0,0 +1,9 @@
+#@TYPE: Machine
+#@NAME: Radxa Rock 4B+ RK3399
+#@DESCRIPTION: An RK3399 SBC with Wi-Fi 5 & BT 5 and PoE Support.
+#https://docs.radxa.com/en/rock4/rock4ab-se
+
+require conf/machine/include/rock-pi-4.inc
+
+KERNEL_DEVICETREE = "rockchip/rk3399-rock-pi-4b-plus.dtb"
+UBOOT_MACHINE = "rock-pi-4-rk3399_defconfig"

