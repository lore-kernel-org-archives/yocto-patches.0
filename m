Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C09C43327
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 07:36:11 +0000 (UTC)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87101.1782718562091891016
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jun 2026 00:36:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=dWEqNre9;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=YntVgWfQ;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 892597A0096;
	Mon, 29 Jun 2026 03:36:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 03:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782718561;
	 x=1782804961; bh=TFg30GIRwkrxoybjdB621+Cr7ivr+O0qnmwME5f8vKY=; b=
	dWEqNre94sQPqvpyzoRTHsv+sit5eJgFm4ziin7klOgcZ/w7Iwg9STejUIHYRoNt
	92cLy8+KRynbNXt9aoWCj48OugEvJFhTLpDTCP8g2CnwPojnknZSjx+vh+HhF0VE
	KPA2+CIbyQzHelEJiQgQAC4bPdLCz1CGOYIvM96N1l2RnP0NJJfcY4F2lf4synFZ
	CHo8a2QCYaju/KUcji6SEzMiDhl7SD5SWUOT+Uj3TWqlP8jeQFxT17vxNLzS+RwS
	pISJNSk/k5vWJlYK6+ZDKZ9hKk78a6Ea0zL0CFh8ek8XGw8DkQKRcM193LbVYi5t
	kzqbpD9I9PeY8S8dApDESA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718561; x=
	1782804961; bh=TFg30GIRwkrxoybjdB621+Cr7ivr+O0qnmwME5f8vKY=; b=Y
	ntVgWfQAj3umfLnWp7AS+MS7Ypjrp6RWh65uDx6e/aQbv3f1Kz2QJ0J6ukq9Kx+N
	8GO2jTSOEWMOKTBwKeta7oi3VRbtwZUtlaN6IflawrttjbkAabJ04kmkRtaYc6KK
	52kQQydZE53zcNNGClG+X6//jT5jzwO6+EwIIOCjtVNs1+l1/4mFuLg3RgNTufpP
	398yqRkDub2j1UazlYoPtfy1bgCv2tU3YYxreVHfPyy55+NSaVtLg28td775647i
	EGyH79bhNpQRv7OdLlQd07OdTjTv3FFpoZ70n5/juwPNoiaxNtiF35DMha+lczzV
	9M3HxTbKqqNYOZjiQ4SBw==
X-ME-Sender: <xms:YSBCanWGgpyimFDJp6rQyiFZ6_OEUi8U7RMYU3QgazysjoO8URZ48g>
    <xme:YSBCaln9zypCEporlnRSCbyBuVm0DAb3DKcNG3w7aPJqbndS5zqK8Y46tCqkxbSxn
    jET3ev0I7D8H98F-3mkvMlwar6Su4-aq9-NbzZ2bscNx4M_UdEAOv0>
X-ME-Received: <xmr:YSBCahDLgQh5ystrEPQ-IPJOAsjm3etoE1vWYuJO34t-Eiz82ldEm-wrycJP_UqWBrvzm6MJc0wsMbmEfKAJ-joYVXCAM_Q>
X-ME-Proxy-Cause: dmFkZTFCU18uH5r1WwAWMEiwnynHfW0nLEnmeNPDUITFlmzg5Rs0tnuxYxJ/JLZYdzK3cO
    WbRoMwtzy64+D7EQJVjnpfFceaYq+Vqbw3pLIxzKOjV2hvrwflpJVcA61wBBPly6AyRmcw
    i44d/jWD7/YcOZrP7G/F4hVk0w9ewm3vFaRQDoSRJSctTG7bAKbBCjGDqiTTkqd2HNsuKz
    7zNkflhAu5skb2HJznkXGEVN09HROlaPUKm1ser1+5mTj0YMkvStoLcL0RCQ3u/WCyqGuA
    qTMC4IsZrY2LHdfvSIVwxnZlK/Z2E/UMoDhK13YkoLnHa551kenABqfNQD0xB+0ASuzkE6
    6ck35qy5OjQ6Yf1xgyn4M1W+o7bHlbWCRMCait/aJ1OGhVu7evToXJiJ4iVDUSgiJ79MLj
    G0BUAH1VSpPbpsnxapyw2fxTi6vhzR4s9eE7DLnPNVU0bKrtRkpUfypZAfqOzRshcAHACq
    /BFOiqRl+FXYi/cxO+p0SDy1sa722NtVAwiUBSohyR6YKpXVXxVPSbueBkT/CZvkYyRxk+
    5gxjPAJ2bpZkro5Dy24PSNkOPrFQdbYjfzK+UpN2RCEb5mKpNK+hO5xUfT71GxDKeFJsqO
    wo5USVAk/rIn12+x8AXZv5A2cDkAVj4ZUssZIQyqDLE77A87zQpHbJKEBXug
X-ME-Proxy: <xmx:YSBCatceTnbTuJizfJGe28l5DMNfH5sWxSRBMCZdeFpkyaz_CL09pA>
    <xmx:YSBCakLJ8lh7R3iS82WD7I1fVHUg2cyXSCrDdaRVsX-QoX8Fx3ZpBA>
    <xmx:YSBCaofooGIvr7r8Ls1iMW1sYXuslRJ6v61Gz8v8bvVZhI_kz9s4Rw>
    <xmx:YSBCaj3-dNkAZJ6AhN7QLMn2hzCh7CGz7_Ri_0ByFcI-JVax4b8_tw>
    <xmx:YSBCao7aQFHPoEyUjATv2r_WZr-sP15TNll11xuavGqybb8FiMz9jtq4>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:36:00 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Mon, 29 Jun 2026 08:35:45 +0100
Subject: [PATCH yocto-autobuilder2 1/2] schedulers: Add missing master
 branches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-branches-v1-1-1ab28b1ee5e8@pbarker.dev>
References: <20260629-branches-v1-0-1ab28b1ee5e8@pbarker.dev>
In-Reply-To: <20260629-branches-v1-0-1ab28b1ee5e8@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=622; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=gklSon6d2zMl/PT/t8+Z5mKFb6fMAJcewB/Q6xODVnQ=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWQ5KcT3KWRqXCmZt3fSv1r9yueHl716xOk4f0n9suIT/
 3fsmWCq3VHKwiDGxSArpsiyuefr/ae9jrwZIbcUYOawMoEMYeDiFICJ7P/GyLCkP+V+/29JAdPv
 LWdKlLxui6xPkJ8/q7+DI3a714rpc9oZGZo7rr9WtapXn35po6dzTFDeZIk/0tziF0+b3nSNEFC
 7yAQA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 07:36:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4315

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 schedulers.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index 5ca57f3961a5..9117a059e066 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -26,6 +26,8 @@ branchdefaults = {
         'branch_meta-intel': 'master',
         'branch_meta-mingw': 'master',
         'branch_meta-exein': 'main',
+        'branch_meta-qcom': 'master',
+        'branch_meta-riscv': 'master',
         'branch_meta-security': 'master',
         'branch_meta-openembedded': 'master',
         'branch_oecore': 'master',

-- 
2.43.0


