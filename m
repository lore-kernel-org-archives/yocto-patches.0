Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876C8C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 07:36:11 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32587.1782718563566074118
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jun 2026 00:36:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=i/wl+ECB;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=Km9pqykp;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BC6941D000BF;
	Mon, 29 Jun 2026 03:36:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 03:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782718562;
	 x=1782804962; bh=MfQoUmkvcYdoaHLdvtPHXQAztjNWtaGByl6H+h9oeBs=; b=
	i/wl+ECBXsXuYBzbQ02aYahbSIhAMck4ewyMQImu9XzzGBPHPeyH35uS0F2PDreJ
	GVgLaLORHBvCPb/6lKe7aQJJdedeRRNhtGPcfhxCmQgnNppiUfyoTlQQeOuRsJi5
	DGMneXNK08n3p+a45VFjiAVszSlaDDf7gtqWb3lglo5mMNPj5Z1Xol8z/fzh4nCB
	8jOelJQoYbSD7VO/xwRzL4FZhDbYXb0+VTM37jFYY/gnf064GIspjlwZTzPN+VDV
	gcHd3sBYSO/8NYFOD7ampFM79K5n24pHP/jVAkweDxpw1MzYdMuZmnsPgSXcBghe
	7ZNq//I7jlAolMLmHjsznQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718562; x=
	1782804962; bh=MfQoUmkvcYdoaHLdvtPHXQAztjNWtaGByl6H+h9oeBs=; b=K
	m9pqykpV40PF75AcUnOymloa3EWXNUzk/0NrTZRJGHmP5KrMLph2EQyauL2i3PNI
	ooKVmt6pG0bUbc1M4c1TzXE8xfpxU8oCEWxlcnnJFQe0tsnkpncpGKmLUliCIt6u
	3IaP1WibN1R/R4AbNq5/se8WLYLTSkExUGJUFejBxlGrJpomPgJyf6FCz5rxh/9I
	6h1vsf3u4LzG7C3FKrxEjQ6o+D8kgmv9uojotC/rHUDbea7GbTq8dAQ9guWaqHv8
	+46ZqXXXcd2xILBDyve6iWruUi5I3EAg9I5bkhrPEbA7TCUJ2/F/wz2fB9vqhhfM
	FGwptOLxI3eIRo0fOWz8g==
X-ME-Sender: <xms:YiBCahFcrVlmTFwD4m8GwOdveCaYQcHsNryQO_emRJ3dNvUNFv4wXQ>
    <xme:YiBCasUYx2VxjusFVzWNibkTm6qP5F-CNBDnf4XBVV4jGoJduQ7i_yTOy4MWRl-4I
    mLFRkd00hmZUIbM9j1ge0S6h63qV9whfZcsoWiUqe1ncpbj5eXstTo>
X-ME-Received: <xmr:YiBCagyA6xUKAasCXCJhiXDWqGf6qLgB64MiiSI3JGOOlJJqu1PwspmAIvqKsDbe7-VMiefbXffTeFX_qLKlk3w4CMZgvzU>
X-ME-Proxy-Cause: dmFkZTFCU18uH5r1WwAWMEiwnynHfW0nLEnmeNPDUITFlmzg5Rs0tnuxYxJ/JLZYdzK3cO
    WbRoMwtzy64+D7EQJVjnpfFceaYq+Vqbw3pLIxzKOjV2hvrwflpJVcA61wBBPly6AyRmcw
    i44d/jWD7/YcOZrP7G/F4hVk0w9ewm3vFaRQDoSRJSctTG7bAKbBCjGDqiTTkqd2HNsuKz
    7zNkflhAu5skb2HJznkXGEVN09HROlaPUKm1ser1+5mTj0YMkvStoLcL0RCQ3u/WCyqGuA
    qTMC4IsZrY2LHdfvSIVwxnZlK/Z2E/UMoDhK13YkoLnHa551kenABqfNQD0xB+0ASuzknF
    a9EngDsyghEZ0542afbiITT0HAAmmd2LMSBSNV4cQRtV/K6WytqFYKtcAiz7dnJesBix6J
    2jpxhQAS/TS7/hOtI7aFxOGxeF8osUEHWRsUub8OgxCqF0ILvZlqLyDjLWGJv5HMdalGX1
    qQxS05qUhH/i+bQaka/5lj6KDkIfxG7cuq3FaucjnolkvBs0EZvdmrXhU1Gq3h5SFBKkWV
    bxjWwmNfUtzfViUGrQD9AjUXPpSfZbV0/QD7p8lMNAFdHYohHJ9HPX/3VXuxQXMSO4nPNF
    T3bcFEaqpJirEAvzXsCjbce0J0qITT4VqAnnJ0o0pxcwzWifrDQSb+OOParw
X-ME-Proxy: <xmx:YiBCaiOWOoU5LrkbsnynzE97UAHtB-E4IIZdOf1fu3bXB4-jvWo5Kg>
    <xmx:YiBCap7c3wi_YrA0762Qw_lSiCRTmNGEOh1pge0Xn88eQwpvMbQSXg>
    <xmx:YiBCarPOxuop8cIuPdz8R_DUXJSJ0l9i2buZmKRrJ3Pcks0iGHYRgA>
    <xmx:YiBCavmG8zboSXDydKnKo3UcCvhj3iC7UPyPM4--XyZEDgxjX4t5mA>
    <xmx:YiBCaurLZgEMsewhAQvUZM501wUQfZIJWa8cwo8F4HSKDVDPsapVuFs5>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:36:01 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Mon, 29 Jun 2026 08:35:46 +0100
Subject: [PATCH yocto-autobuilder2 2/2] schedulers: Update wrnose branches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-branches-v1-2-1ab28b1ee5e8@pbarker.dev>
References: <20260629-branches-v1-0-1ab28b1ee5e8@pbarker.dev>
In-Reply-To: <20260629-branches-v1-0-1ab28b1ee5e8@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=LYktx7imuGXKkhK5UDRfzKR7LtZ3gYePjnm+88pGeK8=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWQ5KcRvdfpzOXTGp10y/ad+LbjJ/MJFZ/kLzx0JJyZUl
 drHcnHkdJSyMIhxMciKKbJs7vl6/2mvI29GyC0FmDmsTCBDGLg4BWAix78yMpxVb7AxYc3sEFdw
 nsD49nNTxffNp3Y6asnq5KimqQiLizD8s44+nHQxVat4wa0H5zv33zoy5ZFCY6/NvyRh1bZ28aZ
 iZgA=
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 07:36:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4316

- Add wrynose branches for meta-mingw & meta-security

- Fix meta-riscv name

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 schedulers.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index 9117a059e066..d770d6fb0952 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -80,9 +80,11 @@ branchdefaults = {
         'branch_meta-aws': 'wrynose',
         'branch_meta-clang': 'wrynose',
         'branch_meta-exein': 'wrynose',
+        'branch_meta-mingw': 'wrynose',
         'branch_meta-openembedded': 'wrynose',
         'branch_meta-qcom': 'wrynose',
-        'branch_meta-risc': 'wrynose',
+        'branch_meta-riscv': 'wrynose',
+        'branch_meta-security': 'wrynose',
         'branch_meta-ti': 'wrynose',
         'branch_meta-virtualization': 'wrynose',
         'branch_meta-yocto': 'wrynose',

-- 
2.43.0


