Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218FBFED3F9
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 18:52:05 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29533.1777056720506825534
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 11:52:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QNLLowuN;
 spf=pass (domain: gmail.com, ip: 209.85.222.174, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d7e7f48499so928404385a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777056719; cv=none;
        d=google.com; s=arc-20240605;
        b=kVP+mggFcX6EU5cwoh4HywGagtVbulMvBc6uArsUF/xB+BCt3K6LMd5ibq7Ixsq3TG
         ShB2G0VprzbyERzN4jhwNue9kvT6OwpoLqH3u2ncddYiQ2xD0moNqeHGFT+HATKtIPd6
         vOKuQIKPxwUSkUjlRCxMa8mdJNDEYrEM+g4M9PGK3Q+XYTcU6oynRAg3N6E1pcJ61TN9
         JSYNfBpJdYE5KxHk9T9PJPEOjOoFNUeWYlLTL+oKj0jnb5zg7XGIUDDHz8tCZNFVRHtZ
         7S7cTjRyuIudJgIjxkB6OEQuiI2w7IyURJslpE3whXZEjXX5JofuNQuvKvmL9OHUu2Ui
         gtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rkQKBHeVu0fAJ+5wh2EOXeH2Ip4+5ZQ9D9eCmd4f318=;
        fh=ZKASkXXDbWkLXZ2ZMTZBRo+mbZPSuSOHP+oAS3wPBOA=;
        b=Vj6Wpp+g3vBJjwtAuMhn7ZBJXuueOl3TW/RfQ7WbmbDNaal6SSe5v2HTGdHPYQTQhx
         59M6Ynd0C57Yn1+qBMuuIkCOClsxb88uLn15Fnu91IAy6oFzbP84S09iAh4rnPPm6rP/
         QiC9O4BqTQPMrZ+rc0Ghibt+aim7TnmApJv3ILYtSkNtXz0nlw0dboBpHuARMzBHW+1V
         hpm0P2PHuWSOy4+rFCdNaJ8Z5f/lrJDozj3Dv9vlGtd3HVWNokvDvNf65h7BNdxo5+YF
         o8lHMBzzEJ6ecv5QQzrJcitlcEzQuzKJoRoJi/Yz2vu739XN/3K//tY7ggMA1vbDbAbv
         5sFQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777056719; x=1777661519; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rkQKBHeVu0fAJ+5wh2EOXeH2Ip4+5ZQ9D9eCmd4f318=;
        b=QNLLowuNIiKWHJsm6/V7RTpfDjad8s7zc3xIE7hotXx04T/JbASIZsrjtg0LoydGYO
         aHYzAGhETt0CB5heHrScFt4CPNVgturvkLQlrKaEqyiI3tKubXxFgipAuVgDlF/wQyJZ
         Fe4hCmknVjaYlhU6vVlcROxNFxBSfyBXZ5wn2rm8buMEqhP03P2hZvUUXg0KxuZKvsAr
         vEDDukBAteMhVpigvsQy2nBVcN9738RDj37EfJxDohstf4NPKvK/FwEoNVvwPZad1Kcp
         JFrsNezdcFCkaCwB2Mqvg++dazDbfsfE46L7xFwj0CcN3aELPu+WYXTC+rMAxfdEXLQf
         0IoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777056719; x=1777661519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkQKBHeVu0fAJ+5wh2EOXeH2Ip4+5ZQ9D9eCmd4f318=;
        b=tZwN58zE1RouSKqa8d1lL1eY4ozGCKJcqxyNt+6SmqZiksJH+c+1XwtBLLHR8uwn+6
         4m2kJswW4oi6aPjV5rMphQCekUjaNF1lsuMo8VRJy9p/UgJF6E4OhHS6Wczcs/npB/iC
         emYBLrpbTVAzOLmmzpJk0tGqIzjVzQ5mFq0uXIpiaW9aPNE1Tb9pc+X/1lNUWZJtoX3b
         8lMqJkFXqBKvoEf/KVTPxjCISwE5nNJAplAsJgEZ74x5X1EJMW8SlHa2AKmMFPEV2B5V
         xbywhNQ5My2lgtBoM2zznqEjbrmS/btgcJ9wVOf3/xF7jwTpDsUJjEKCt0WtdwjowfJO
         83AA==
X-Gm-Message-State: AOJu0YzDfYtV2azpFgdUIySwgqmRXskIzvZal6IaTYnXVKzbL82FDnEX
	Wfof1tb6Q2+3f+mBx9avyImSS932uE3U+TaHggWcZ8tCqVCbY4H/EuW9/PmpWaxFsMKw5NOz21F
	vLcXKFGHWuS2Rl9B3jld728KMZZgTMbM4cJOP
X-Gm-Gg: AeBDiesZlCNJLFIfEr0jbrU9lSJaJKSOLB24Ku+fA3GxXMTSJn18gVzGOjY2zMUaoJ8
	uMh4Ypad4HMu3nrA/aqe3dABBe3gAzitSFupARikzDXqjmeV8WLmNOWMxaUw+EumES8YHKO2kad
	dWwc8sq8dc5JYE302zrbEAgbJHbkHsqiVru549GAxQYAGxPq8zhmkkW4JERvHCHQYsVG1aG8TtC
	BXdWiS5q/5WCJArNdiNY7yP0UpdKw3tzDs7ps9QWlVAAHULwi5JXtr9np2vhr+gJM21UywRoKRs
	SoH32++VOYQ21VZwxUHaeAMBJib+KO8tDXlDTdWWK0FfmT+4CQty
X-Received: by 2002:a05:620a:29c3:b0:8cf:cfdf:733e with SMTP id
 af79cd13be357-8e7918a1473mr4453692585a.32.1777056719352; Fri, 24 Apr 2026
 11:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260414053202.3869771-1-Qi.Chen@windriver.com>
 <20260414053202.3869771-2-Qi.Chen@windriver.com> <CANNYZj9PmjiMDbz6jknMrYubDx=xk5cW2KeGJXVyHCNbFhkpAw@mail.gmail.com>
 <de8caefe20ca7301a8f104e8d9751ffd8ca50e38.camel@linuxfoundation.org>
In-Reply-To: <de8caefe20ca7301a8f104e8d9751ffd8ca50e38.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 24 Apr 2026 20:51:47 +0200
X-Gm-Features: AQROBzDxsEW__3e4q8fQr_Ac0OvcsSBtwrAC7glTNDuT0jBNyaNgRjLjJAC2488
Message-ID: <CANNYZj-r9mM0sOHT+cMF2WK6x-odOT-CTRcwbg4b5xVSf2yVuQ@mail.gmail.com>
Subject: Re: [yocto-patches] [auh][PATCH 2/3] modules/steps.py: refactor
 compile() to use parallel per-machine builds
To: yocto-patches@lists.yoctoproject.org
Cc: Qi.Chen@windriver.com, randy.macleod@windriver.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 18:52:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3807

On Fri, 24 Apr 2026 at 19:04, Richard Purdie via
lists.yoctoproject.org
<richard.purdie=linuxfoundation.org@lists.yoctoproject.org> wrote:
> Whilst we do need to be mindful of this, I suspect there is some room
> to parallelise a bit. How much parallelism is this expected to have?
> Some existing jobs like oe-selftest do run a lot in parallel already so
> this could be not that much different to that...

Patch 3/3 sets the parallelism to four:

-        self.opts['machines'] = settings.get('machines', 'qemux86-64
qemuarm_musl').split()
+        self.opts['machines'] = settings.get('machines', 'qemux86-64
qemux86 qemuarm64_musl qemuarm_musl').split()

Alex

