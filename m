Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C571ED711D7
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 02:50:15 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8835.1766112614714931650
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 18:50:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fSkUuC+v;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed75832448so17014681cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 18:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766112613; x=1766717413; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eStNsC7gHMQL7aE+DrNMnrO4Otg2svhpAU2JqDduSxc=;
        b=fSkUuC+vFcF49EnTLTgFpHLZzSANs0/kZ7ZL/8dd8n4U22nX4phGIoj7LSphVK6T31
         M/RuDx47Pon5O0mKmYrrKoGo5jxqBizDwldako8IxChu4mEumZzPZgUceBvoZ9KylWBP
         n3ZobiaOgiGRxMk90xtHzii+dgFb3bDKxIN4oU3qNVI4vu1aw5Pvpf2B4jl5ViaoyZ+e
         7+7TSnyB3bujbdMteGIfAj5v1dshvVGwuFF/5Wnsf+k+Qf1nKkah26OwErz5hL/nVT4j
         L9aftRHO9HyNjCktbFpgceii/d/VVMzoDuqPvW3WRGKW+HO3lD8v/lWMZCELcpX8UHrS
         sddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766112613; x=1766717413;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eStNsC7gHMQL7aE+DrNMnrO4Otg2svhpAU2JqDduSxc=;
        b=PAzmnBOFp9Sq+8me9ngGSRi4ZgqGfxiIt7bVzYWlwBSk5LXyCX8P7H7E+aHVPbBfcV
         ShmnCx3zOabwvV4/q5k/uOUZxAfpMvTqHn9hCjU652kUXiVO7LOmZK1LK5HCrhblRpPx
         TGXopm0y7hTNM4rlLjx9+JvW6UStNQdoKnadlbPOufSJEL/UxS+VaJfwQrLn460tYGrK
         sRqcJlCwlCS8Lj67odyne2guahkD/Ema3eN1DeAjA/qsR43S0imNobDMOBWdpGuDdKo4
         q+Hi4ZxSWhLOVDMBprJT4WahYYITSwZgFMotuitCHgDbusLny7Foe3Dh9dq00TFRz8n3
         ieJQ==
X-Gm-Message-State: AOJu0YySb2qxmimVfRSc2v3nTSF9N7KrZ76v/fftUmqIIt6oEj7E3mvL
	LMTECABI9zvLqqftr7MDJG5ddMm9Fe0PqXD4AbesHgl4LXRP8YaggsTmfjV5yw==
X-Gm-Gg: AY/fxX7lAhqd3djNLyA//OWuMvv0EiShCx9dyUrI4ZJuBRlPosLbi2hwyAa2SHNu8D7
	R/gNJutsnYMLB/nVW71syX8P4kMvad+GNi4j41Tm4XG59a/atdR5Z33fuFXqVjlLhLDBJvPgdM8
	Aq//pGPrf07/EtKRQFGe868NFV4bvjg45YJyIRqa0ROBG3vA/cgt2bgu4hqyxTfZZLQq4QpT1rK
	63eSr2buhnzlYFiNJY5Om+YGdMSqhRFEoC/HypvqhMAY3SSwy4jE086mRke0XaP2TIvK+OXlduj
	lmPNFziAtqEKCiAe/qvfjyLoT9B+dwJNQhqZchGDkK4EvRkeSjmhqhxBAYYKLopsDbjhz7wGAcu
	tRgTM/B0l4ryMoLq5O6RBgor5+5aMq9mlh872D88pOjWhMukfLC+apAwb5zkCY7wykkJItchsx9
	5DRf7G9l/GHA3FTycg+/aYma68wEGzgmxPfhOrQg==
X-Google-Smtp-Source: AGHT+IEoH3cYhUeQD2G7Xsysc/TLhP1JPAmSAfzHIcIxzxTGecVznEkAap6P0C2YXnUCfQTliCYwQw==
X-Received: by 2002:a05:622a:a0d:b0:4ee:ccd:7215 with SMTP id d75a77b69052e-4f4abbc303amr24342021cf.0.1766112613180;
        Thu, 18 Dec 2025 18:50:13 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac55fe70sm7494151cf.11.2025.12.18.18.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 18:50:12 -0800 (PST)
Date: Thu, 18 Dec 2025 21:50:10 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: michael.opdenacker@rootcommit.com
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] tinker-board-3: add
Message-ID: <20251219025010.GB5613@localhost>
References: <18823A0A6BE7E236.1506149@lists.yoctoproject.org>
 <38a42c2b-3025-4516-8aac-c9136ee6e55b@rootcommit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38a42c2b-3025-4516-8aac-c9136ee6e55b@rootcommit.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 02:50:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2820

On Thu 2025-12-18 @ 06:10:07 AM, Michael Opdenacker via lists.yoctoproject.org wrote:
> Greetings,
> 
> On 12/18/25 07:03, Michael Opdenacker via lists.yoctoproject.org wrote:
> > From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> > 
> > Add basic support for the Asus Tinker Board 3 [1] and 3S [2] SBCs,
> > with the Rockchip rk3566 SoC.
> > 
> > Support for such boards was introduced in the 6.19-rc1 version
> > of the Linux kernel:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f80b3952318d7ef18573a5010f06118602f992e
> > 
> > Therefore, the https://github.com/betafive/meta-linux-mainline/
> > layer is currently a prerequisite to build images for such machines.
> 
> Is it fine to require an additional dependency to the "meta-linux-mainline"
> layer here, as Linux 6.19-rc1 isn't supported by linux-yocto-dev?
> 
> I could add a machine dependent string to LAYERDEPENDS_rockchip, but I don't
> want to pollute conf/layer.conf.
> 
> And it seems BBFILES_DYNAMIC is for recipes only, not configuration files.
> Thanks in advance
> Michael.

As much as I like Paul's meta-linux-mainline (and use it myself from
time to time) I would prefer of meta-rockchip didn't have a dependency
on it.

