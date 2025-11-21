Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43189CFA46C
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 02:59:53 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3103.1763693992630405492
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 18:59:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eA9pMKpZ;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b29ff9d18cso153370885a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 18:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763693991; x=1764298791; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8bTYq+md2AwOJCpDziOAf3SlDdXJ3BuSyM+esfKZtA=;
        b=eA9pMKpZxZuvAgh0vgS7UbEgCfnVW7A+JtScsAimMeIicj4ykPnkbl4Oj62XOV3w3k
         p2pNxvzhMc2kY3ZmHJCd/sWKg35//uhZN7iSsBEmyQn88Y59Nx50EerLDjeG4/Bz6Ogo
         E9/hwtehAOz2HjQNIhtxIqGXlM5uuRRX8MG2D1MYg46a/ErW3pmTWbdlkUTZI2xGYc86
         nOtPuVJNkBgPoEvWHwIv3NyMMU3BuZ26GTJ9y5zHLm8XMrnHVfn4VB/DHIHtoQgNie2Y
         81W5SkmCjP+OvfkewkO0jIXLcaIVbxBnDJMFPqCBrpIjGdh8Jm/s6Vy3UKCtP1HZJHeb
         tGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763693991; x=1764298791;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8bTYq+md2AwOJCpDziOAf3SlDdXJ3BuSyM+esfKZtA=;
        b=m5vNBvtSUt5c0kIbWpqTBTohwWlYOp0HusonF76IZePr2UYBupOXG07b1GrVlurYVC
         ICPxnO/x23YpTEgYAzm17y1B/OwL3OQN6pqHlyXLpztvLutCFikZZhq9xo8TBvzlSFlF
         W8IddaWKqNeqfuDJqcX9AMP+Y8Ma74NJK03k/AvvzAvgMvjv/Xot/HrXXwAB/1ypLyYU
         SjKAOQOP6An2txVV1AMTN2+PGZ2/xWnogiPhzgfqkmQ0LKhMbz9vTDHs+Pto8qNBJF34
         JuQzttEkzVccHpLPSbhDQ5xO88z9JstI1fObWDQdLis470z8cOsUkGJecYMz6G3O+4u+
         pY1g==
X-Gm-Message-State: AOJu0YzEXMQ7J33sWiTfyP7eNNlyTMolHe19NHEDEUXBDzYP4Jdx3gUG
	XZVos4jFQKhyq0oX7T10VNHXTOB+LHxIkBIiay8BqP3TYsM6HgOINhcKKVnixA==
X-Gm-Gg: ASbGncvZ9Ic16sAGTDIv0Al/Ig398Ju3tXTFgzHu7pV0jreGnPO4QSlnzg01vHzrxFa
	BJOeTbCj2JU2nZhEcC/jZFt1MmMMbz83FmDCtRHnhRFGBlHTayXs7zbkGhX5Oz3QmA6IgmKaIdk
	ryk/sx3p8Tq40GsRcEsgLKoJ0dd5pbeSCCpsUpdf5vudVPjW+0CtpCX1BUAyc6gCuFtzJSBaamE
	2x4fcEsJL759wAXdtlAZN8XrTLGQil8gNGIBIrUYeMNb9T4ckqUGnX1BqefqStOyEYYfBk+/qrJ
	BIarwHJArgahRHfflnfSPEPjvIaCOiQqHR/FaSbHFzprNHhN4d90e44uFYk5VH71bCgzHzxMOXP
	HD23/gcJeDP1Xb2oIzABdwWwezkBwz8pCGCvWYzolfrJzuKLN7mnndKiquT0I9iEL7iMn1skA6n
	p4vZlRF09mVCqw9zrENh1ZCTKJaM1+FG8dDCP1Dg==
X-Google-Smtp-Source: AGHT+IF+OIZkBVPBijFKVQewdaRaIUUlN8TO8D2cWnrxxxqcCUhBp9hw5nstZN5zad6vSwwHcyIYMg==
X-Received: by 2002:a05:620a:7003:b0:8b2:200f:ddc9 with SMTP id af79cd13be357-8b33d1adeefmr60675185a.9.1763693990827;
        Thu, 20 Nov 2025 18:59:50 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295ef333sm279914485a.49.2025.11.20.18.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 18:59:49 -0800 (PST)
Date: Thu, 20 Nov 2025 21:59:47 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Subject: Re: [yocto-patches] [PATCH meta-rockchip v2] orangepi-3b: add
Message-ID: <20251121025947.GA38543@localhost>
References: <20251120-orangepi-3b-v2-1-48df6c49609c@rootcommit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120-orangepi-3b-v2-1-48df6c49609c@rootcommit.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 02:59:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2640

On Thu 2025-11-20 @ 12:11:11 PM, Michael Opdenacker via lists.yoctoproject.org wrote:
> The Orange Pi 3B board is a Raspberry Pi sized single board computer
> based on the Rockchip RK3566:
> 
> http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-3B.html
> 
>     Tech specs:
>     - Rockchip RK3566 (4x Arm Cortex-A55 @ 1.6GHz)
>     - Arm Mali-G52-2EE (OpenGL ES 1.1/2.0/3.0/3.1/3.2, Vulkan 1.1, OpenCL 2.0)
>     - LPDDR4 RAM (2/4/8 GB)
>     - µSD
>     - SPI flash (16/32 MB)
>     - optional eMMC pluggable module (16/32/64/128/256 GB)
>     - Wi-Fi5 + Bluetooth 5.0, BLE
>     - 1x USB 2.0 Type A OTG, 2x USB 2.0 Type A HOST, 1x USB 3.0 Type A Host
>     - 1x HDMI (up to 4K @ 60fps)
>     - 1x MIPI DSI LCD port
>     - 1x MIPI CSI camera port
>     - colour-coded 40-pin GPIO (uart, spi, i2c, pwm, gpio)
>     - Gigabit Ethernet port
>     - optional M.2 M-KEY PCIe port
>     - 89 x 56 mm
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> ---
> Changes in v2:
> - Fixed commit message:
>   "1x MIPI CSI LCD port" -> "1x MIPI DSI LCD port"
> - orangepi-3b.conf:
>   - Replaced "Orange Pi 3B v2.1" by #Orange Pi 3B"
>     in the "#@NAME:" line
>   - Replaced "3th generation SBC" by "Raspberry Pi sized SBC"
>     in the "#@DESCRIPTION:" line.
> - Link to v1: https://lore.kernel.org/r/20251120-orangepi-3b-v1-1-3d31722d6fef@rootcommit.com
> ---
>  README                                      |  1 +
>  conf/machine/orangepi-3b.conf               | 11 +++++++++++
>  recipes-kernel/linux/linux-yocto_%.bbappend |  1 +
>  3 files changed, 13 insertions(+)

Applied to meta-rockchip, master branch.
Thanks!

