Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA639C369D5
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 20:33:11 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web10.58917.1745872384252153774
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Apr 2025 13:33:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hQlGqtGS;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8efefec89so54092246d6.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745872382; x=1746477182; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M6/BtAwlVf6D1JsIBAfxkmO3st/N/AANw0XKNyq2mY=;
        b=hQlGqtGSfxzC6rn8Ozvj+bKN+70Ik2jcK3G4ctN9AanoXMyYbe+frNJegKPAYTgxfg
         XEU/1uWvsqzcmmLqJa6GH+eUDy/BD4c1szWQYpGvpzWhcHM/G9oAz9Q1Qin43g0vHx/+
         yPUeXPrUW0OdvTMbyCX5404Ktlfw6mr6G1RVIDZiDunUzgjTGPWw6BFZPVPByOcB2AEm
         gDtL2iEOTGTchUcMMmeE/oUGezBq9amaEevMS6cnlRYIwVkN3xiRF835swzMF3+ErmZP
         RilLBIjbA56ZPg7irgzxDoU0ukZczt2+/fQFbSWGe/665g1BgMX5cEzbXOVtMnyJqZLE
         OuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745872382; x=1746477182;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M6/BtAwlVf6D1JsIBAfxkmO3st/N/AANw0XKNyq2mY=;
        b=esR2YhhSN1IvLzeGqC/t7PP6yx1AyNtbiUMct1INCeaw2EhbBF+h3ZAWa1Tas1sM+E
         BM639u6VnUrkM0G95bpi0qy4+i2i0sNWNcsXHxskx2fENynw5jOWBjVymYzvKD6w0bWq
         VGKSGxbK2hG/bhkA3XF4X8atvYjDeWIYc3XOaanTf9PfLa5H3n0lTJwX2fSaSUfx2aQo
         WbzL1bEsXOLPhhL0ISK4tFIjvQ4I0g7d+aVdPCrXr1yrpSgol/hURCeXU9ph/ZI7J0fm
         A3E5iHWwkGNYujQYIJrLl7QHkMOPq6r09OUwcfAm1i3EcbXSzxvP0WwpSsU3L63/nXVr
         uNRg==
X-Gm-Message-State: AOJu0Yxt8VZ6axYgyDpdOjJidHximfgPIE9UVIH8P3NSAjMLQe5SmjOZ
	Nq1PwlEZjQGGQOXKJut7cS6nOwXi5T/pl6yjr9In+aYhz7e3tlIWnUV4zw==
X-Gm-Gg: ASbGncsMa8TtRVSv+/JLpKc7HVe697p5oOE76JVvYf8jZTlgrBZWfLjBhSeiShOyUfe
	U3ANUu8pFGxfVyAbeHDP8cANFv7qUXt+LFx+6+TzaREES/xo9kmo3rn8DcW5E2kVxkRI2Wo+EN1
	LR0PjF/iunNB/ZUN8YawMlR13WbaJnkhf3NkNSUi9rWkEjoP8YFJsWf8FJFnQAMG3f1KQttvK5q
	icfCvfVTZJUWZGoLIhnhvVNlSLeuW9pSK0egcTpFjQZK8OoDDe64QA0e5Te2bY1sLA1ZwR1A81b
	0RI2tJdPJb5FW67diCoNXbAZkfVMxxt6OCU27+2p1rw29GVmCOMpjXuuKdE6Xx4kSef/m7iEr7H
	IsAs=
X-Google-Smtp-Source: AGHT+IGSUwnxrGXFnrXjrSoFKAvf6drrpKxEZA7AdLBuDjKbgrVe5i3/OMFKJGtrmTlyfXlql6pWag==
X-Received: by 2002:a05:6214:1d23:b0:6f4:d53a:768d with SMTP id 6a1803df08f44-6f4f1bc1104mr11160226d6.25.1745872382106;
        Mon, 28 Apr 2025 13:33:02 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0a73c4fsm64835256d6.80.2025.04.28.13.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:33:01 -0700 (PDT)
Date: Mon, 28 Apr 2025 16:32:59 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2 0/9] rkbin: factoring
 do_deploy, customize ddrbin and bump rkbin
Message-ID: <20250428203259.GA40556@localhost>
References: <20250418-ddrbin-custom-v2-0-700828527faf@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418-ddrbin-custom-v2-0-700828527faf@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 20:33:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1410

On Fri 2025-04-18 @ 04:50:12 PM, Quentin Schulz via lists.yoctoproject.org wrote:

With this v2 I'm seeing build failures:
	| binman: [Errno 2] No such file or directory: '/z/build-master/rockchip-nightly/build/tmp/deploy/images/rock-3a/bl31-rk3568.elf'

This happens with MACHINE:
	- orangepi-5-plus
	- radxa-zero-3e
	- radxa-zero-3w
	- rock-3a
	- rock-5a
	- rock-5b
	- soquartz-model-a

