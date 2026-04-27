Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77CCFF8861
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 10:22:20 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40690.1777285339734048588
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 03:22:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Qfl/IyVD;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e63771d91so87840911cf.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 03:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777285339; cv=none;
        d=google.com; s=arc-20240605;
        b=CQA963J04bq6RWfkjKNGCtKQjy1IWI/16tsSfzYTFYUYA8KyonZTG/eSOxiRP+5h/6
         LPivD2bXDkXoD2c7egi7A33tfqJmg2yc/7nrRsqok4OdFYtsTmf1QbUokqWctO/iZK0j
         fq7zDyWrT/ICWbh2xD7dMz9x7tpkpnhuD8at/5LeZN7qUNHmpQEtrkfHtE0+EGy3IGeC
         2ZkN34XQUDKPlyMqZ0QQYFsOEdwF6fDg0zecLiyJnzWe7Zd2DGWk95gSAKDA49BzW88M
         qp3QUowk3rVfkG5RKsO3zSXX7umeRacKDX9DrNqJH4jjjECf+PCtB5CyXRVGRgC9hFtf
         wpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MorTDcolzApXe/cSKM3nGfSpm0ixcNX607wgfQVK49c=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=RJ8P+4uw+qqia1qrl5VBJIuPf+FaiYCm6zEchdG1rAQPC4iA1z0NJ2i1RpsXtNvf7w
         dRRwhwtmyPWri76nGnTIqH0XisPkXT2BRUlOaFZpgdf4Hz5yVvXA560qMMy+CXZnbv0a
         bb/wJNM00bJVT+6+NB0U6PELz7OyTtmw4XqSEyICpjLpovhS4bAkIr4RO676N6VMWegN
         jJUIEs1JHZ4t1mKkYQcjWuV03s4/cJNW3tpgyEeR+kg9YabMhJVzUm8rKLp+FvJLBUhD
         gTvXKiydGcPYI2xj/vBLNLm3kw9F2BEfCgMW+lCDhRV/7ksgdpvZjfuwxvXP2ZK2ZAXQ
         JkAg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777285339; x=1777890139; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MorTDcolzApXe/cSKM3nGfSpm0ixcNX607wgfQVK49c=;
        b=Qfl/IyVDlv764glyCsubrqWxoZPqCPhBSDC5IUc/piOp8HtfoU25h7JgqxdYxKQ8n6
         URXPbyJO8fbjw3hvtKwfTBIqxrrxG8R3rlg6kcN1a5qGh6MVm+3zw0+c5p4ZocZzC7nF
         6PcJRP1/qqxLk5Al1Ihfh7TixilLAn0tVTk+r365kEZDD/wbIhUn9/Y74bVUeZU1BONP
         mOMbP0TkOZA11gDjrTxgzejPBE0ZDvnT+YL/vVBWfxoF8vImi3/St6Uae22D0KBEO/SE
         IGDnW7URewTtjTJBD8QaFNXp3DXDrBuZddek226OUanqIPFkIAKYObrl+lzVUVKp6a87
         C7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777285339; x=1777890139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MorTDcolzApXe/cSKM3nGfSpm0ixcNX607wgfQVK49c=;
        b=NyGCvCw6S7tJoJFSg3FkAadnbNi2BtdFQdty5fGXoFObGOvA7XBykgmWcnwL8YdcdE
         6/gI6FDkz7dVO3yvd7xwFAqEbXzr0VgmYndbF/c788zAzrHpNDTeDYPL2U/3kQXUSy5W
         aHUxHQ2xETZChFqXPKEr/ijQkZDzeNrseFLrWcCJ836QH7QfGo1Zu2LEkM6b1/ML8ZrY
         jvhEB0q8cttRfQcCM3g+fkxXp89/9gU3zTvUXgapqDlFnb4RNcELCzLAldvKPrImKAMg
         2fxA4wBUK2pCtcF/JfhxBDWD6oHpnM24Mzwxcgo+r3goq1isXAkPszBiEKF1/mg+sMe0
         D4vQ==
X-Gm-Message-State: AOJu0Yy2edn44aNBW7HRz+NaIYdgvHSL9OtPHTQk/V0qOteUgtY+je5Z
	0FOmR0tT7QfUExAFxadrdSv5FoD8+VJl26WgbSpeHyIeBvUFaX+EEHYSSSFrhzWbSxE/YLII2OM
	PdeKnZipmrMsFcWjc1nB4jK/VtIWAcFw=
X-Gm-Gg: AeBDieuJaLbdMlm0T2NjQlQhKB4fjOC8C8+hYmYSlPHHLY6yBbIokQRK2MQrkV6wukB
	8VM695qmfB7OfAmj94MRFbzoNz1CUij8/RSuvfNLwBNiiVeG38EW53AKe0d04xkAnr3W+/8B72I
	GdrPgYmVhHtKJ8LPoWjsPMvh8O8rq2aUM9TCLVoDhnWadYrA/ptugT2lOWJZJMTa1hKXtjuBPN7
	31uiMuIIDVcp9qM9MXyRXXeRfFhRIzX1Sq7G9fJavo6+K5J1Zu0paXYONBl0JpRMcwsT1k60Srx
	9kNzl1aMBbxRxzt4nxaQLecMmFvqjdlYrd1bCzCweFUDbiZm2tUvxWeMY0KA8kQ=
X-Received: by 2002:a05:622a:4cb:b0:50e:614e:4433 with SMTP id
 d75a77b69052e-50e614e4701mr434327611cf.30.1777285338655; Mon, 27 Apr 2026
 03:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com> <20260424114603.2444938-7-daniel.turull@ericsson.com>
In-Reply-To: <20260424114603.2444938-7-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Apr 2026 12:22:07 +0200
X-Gm-Features: AVHnY4Luk0lBtiO45LSN8Ik2AsHMh3FhDkR0CWAgcGRbcuzsv-vW3nHG_k5UUk4
Message-ID: <CANNYZj9xmzFLVb0ECP7LYbvtf09rafXc0CbAz7o31gNdZE6CkQ@mail.gmail.com>
Subject: Re: [AUH][PATCH v2 6/9] upgrade-helper.py: Add minor option for minor
 version upgrades
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 10:22:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3836

On Fri, 24 Apr 2026 at 13:46, <daniel.turull@ericsson.com> wrote:
>                          help="extract changelog between old and new versions, highlighting CVEs")
>      parser.add_argument("--stable", action="store_true", default=False,
>                          help="only upgrade to the next patch version within the stable branch (e.g. 1.2.3 -> 1.2.4)")
> +    parser.add_argument("--minor", action="store_true", default=False,
> +                        help="allow upgrades within the same major version (e.g. 3.5.2 -> 3.6.0, 3.99.0)")

I'm somewhat confused. When and how one would be using either of these
options? What's the workflow for them?

I still think it's better to place stable maintenance information
directly into recipes.

Alex

