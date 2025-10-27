Return-Path: <contact@schnwalter.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E7CCF9E5
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 22:32:05 +0000 (UTC)
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mx.groups.io with SMTP id smtpd.web10.4448.1761604317598987496
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Oct 2025 15:31:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@schnwalter.eu header.s=fm1 header.b=sksfoLXC;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=KA1AIyrr;
 spf=pass (domain: schnwalter.eu, ip: 103.168.172.158, mailfrom: contact@schnwalter.eu)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5C7114003E6;
	Mon, 27 Oct 2025 18:31:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 18:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schnwalter.eu;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1761604316; x=1761690716; bh=H2knT+yW99
	ClOLMe/9d+vRbKK/CHXN18ChGmxHpJQqc=; b=sksfoLXCTa8V9FG27pn0/Qgpks
	RhLKnpGTkTuNFKRkltvFIRbiruOWRk+4E/BPBSSRZrkRrZV/06fHWy/5FHETK05w
	JNlVcvWCjJcVaemcNMHgNQ6GlcgOAo/c1epxKQvKSUOSpTz7nN0WOUJPU7zjx9y2
	1Ao0v000Sxtdbq16HxkZk4cpizBDElo0hEvmda5e4TtArHkHBJfh+WoNibTsBi+h
	5f/cEvnkcVNc9AA4IZOdD3YsJqyfY8+HqjfP+NqURwPLdat5bxqu+SDRa+ZrJ+e0
	1LArgMAkEbndqbr9Is8CzUudYtPXPfTt/orknG+dFqYDvop9nhbfvOYV+0rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761604316; x=1761690716; bh=H2knT+yW99ClOLMe/9d+vRbKK/CHXN18ChG
	mxHpJQqc=; b=KA1AIyrrha9I3xzPDvakvov8VnXMh0esTybH1/xuE58K9JuWCpN
	Ag3VDX76PfxWqHfYdgbms5Vx8kX1Cq+REG3rnhap6NIV8xD5JqgSzvQZWGqO84oy
	C6RCbFmz5oHxZ2Zm3O/WXWwL2ld9sZfA/3n5IB9eSlV5CrXmqlEz3SAF2W1vvWTL
	251uUZYolWWyhb9+9pROyK0xvuE95a8YOgk3Rs2pcfa0D/Y6+3QSOMcZ7ZW/6i4h
	Iqj4yAF7IB+iRL4sXjgZqoiRvSPcTT8WezeoUpAp50xTfZxo5tVR29y9kz5MYOOf
	C6KjIsDm9BgfRjntMfpOdxGu7DaKzrYXkMQ==
X-ME-Sender: <xms:3PL_aKfpsqUI5XepaRwMdoP3bpAybigFlII9hIrVD4CBlCBy9URb7w>
    <xme:3PL_aKMloVujyjRTUf5ixurv_iBCAmXOkIS-qKbndZ4Zym5Q_shYNrATqMaBmLURV
    xUFr0bGbF9Ao_hqek3u_BOI5hANYJUOaG0i8O-7LY9Wuh68KOiU2w>
X-ME-Received: <xmr:3PL_aJJu-gvGmE0iAAOyictm0__6aZAA5re3ZLDndgLTIijUPALdMtuf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeludekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeghrghlthgvrhcuhggvrhhnvghrucfuvefjpffgkfffgfftuceotgho
    nhhtrggtthesshgthhhnfigrlhhtvghrrdgvuheqnecuggftrfgrthhtvghrnheptdehue
    fgffejudffkeffkeegteettedvffeuffeuudfhjeduudeitdetkeefuedunecuffhomhgr
    ihhnpehrrggugigrrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheptghonhhtrggtthesshgthhhnfigrlhhtvghrrdgvuhdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihotghtohdqph
    grthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthht
    oheptghonhhtrggtthesshgthhhnfigrlhhtvghrrdgvuh
X-ME-Proxy: <xmx:3PL_aDGJasuWCidKgwaybMAD9xNpil9HvVCTnGXAPIn5KoNAS2vZsQ>
    <xmx:3PL_aJTtkDSC4LVAQKEVZXV1wiXkkm9R2wSHqoAp7OUv9xOXIfBCdQ>
    <xmx:3PL_aHELMJHnh2gAAUbxyxmnLYkpKsu8s7beXybeveytRlTTc3hIPA>
    <xmx:3PL_aN8XfWHk131HDMsik7Cm98FK6dAUcIec22hdMQ_IbxsY9b_ReQ>
    <xmx:3PL_aBiYfxQbCCkG4wcuBMBHaq_ZFCq8dLosf-6e1TT93cI5ssKqlezX>
Feedback-ID: i455149b6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 18:31:55 -0400 (EDT)
From: Walter Werner SCHNEIDER <contact@schnwalter.eu>
To: yocto-patches@lists.yoctoproject.org
Cc: Walter Werner SCHNEIDER <contact@schnwalter.eu>
Subject: [meta-rockchip] [PATCH] rock-pi-4b-plus: add
Date: Tue, 28 Oct 2025 00:31:39 +0200
Message-ID: <20251027223141.520340-1-contact@schnwalter.eu>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Oct 2025 22:32:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2394

Signed-off-by: Walter Werner SCHNEIDER <contact@schnwalter.eu>
---
 conf/machine/rock-pi-4b-plus.conf | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 conf/machine/rock-pi-4b-plus.conf

diff --git a/conf/machine/rock-pi-4b-plus.conf b/conf/machine/rock-pi-4b-plus.conf
new file mode 100644
index 0000000..2f9321f
--- /dev/null
+++ b/conf/machine/rock-pi-4b-plus.conf
@@ -0,0 +1,9 @@
+#@TYPE: Machine
+#@NAME: ww RK3399
+#@DESCRIPTION: An RK3399 SBC with Wi-Fi 5 & BT 5 and PoE Support.
+#https://docs.radxa.com/en/rock4/rock4ab-se
+
+require conf/machine/include/rock-pi-4.inc
+
+KERNEL_DEVICETREE = "rockchip/rk3399-rock-pi-4b-plus.dtb"
+UBOOT_MACHINE = "rock-pi-4-rk3399_defconfig"

