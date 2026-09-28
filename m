Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFFBCA5FA2
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 16:55:15 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.63323.1790614514790633149
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Sep 2026 09:55:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XWqxekwu;
 spf=pass (domain: gmail.com, ip: 209.85.160.170, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5332b955bb7so506361cf.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Sep 2026 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790614514; x=1791219314; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FgcRcDb6pigiFsca5dhMoFyYIH6eWMgHjMtmN4WDxjI=;
        b=XWqxekwuQtp52le52KJ+IDU1vafn+9beYYwGeSe5l+u81jzwqHNoKpHFFWLZK+420i
         Ml6Fb7xfdoh7H3fYLGFYwbdfJk0FsQo2u4+Ta4QfD6RKIqJ5A5bVeojHzroEaj3UxYbh
         A5nt4MihLVgf+n4Plp10ycPGuc36HEcMUhqIm2MwxfZrtVVF/pBXUjnDibVSoOJ4ksJr
         58W4IpU1uOVTKj1gjFZRa5EXo6L2EJ+s2IIp73t8WZ9htF6u2jEu+8oWG/Yu3IzoNv0N
         WEUqw+4E32viR+4OwUn0vu0e/2aMbtU2HsATa9J6ZUQ4IyNKKZDeH2hc+qYLpXjSJ+re
         WVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790614514; x=1791219314;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FgcRcDb6pigiFsca5dhMoFyYIH6eWMgHjMtmN4WDxjI=;
        b=tL6f009lkeF5+sUsHB997bj1bjaU9VdeGbXHrbimsu0Qab+LQAuBNboT7iTP4nl2Ke
         h22xAsvqNikiitZ5JyUl9pNC+pqrgr49GGL+4lYNQ9i4E4w7dSe2Yfcglc1ZhzElPOfj
         qtCff+6XmnkgDmYHuELw1Dh+k6kifJ1BtXZsUtkmN0T+6nApQgHo92AIL2mSqQjov4c1
         s8+7KWDkEj09f5l+Mz96dczNCqSHWYEa05tC3RIZRMSoKnLY1xFXqDHRLhzeoprjZpve
         Jb5v+w61nVn2ru5is8b4J1EP3ITpBGFkODrWv9e4MaLhrHqEaz7twHGweSW9YXuF6gyk
         wsqA==
X-Gm-Message-State: AFuF++m9ysnALcsswEO69KRi53GHqrW39CVrhJ4EHEVzDfzbc4/m+4Cp
	csmi7KApgsYxim2//AxVP/To7W+FKUBBFgNYYV+3lOSO3alHKIYd3FuN
X-Gm-Gg: AYBFou3fQHmNW8d0t4OFAjAIyjUUKA4/pMp9EAmvN2+O5RwrmJtUQTr5gzovRC15DeP
	iaSVdJ+Z22T6qLYngKn8QGvvxcwxaVLPTrY/xMSC7PjhucDEzJZ14pMWRul6P39KyybLAIMuDDA
	4r3pdsYDurknkWs8I5MrxCic8nMd2NoVc2dyAB4aJ0heQfkSn38z7by+UVaO9OD0W8Vv8UNBiFw
	QOqCZsXy+OdRXyZ8KGU6csjkUosGRtfk8FeurS2/tsnZ/U7XozeJK6BkHMwVDsvYrwRO/GLjkC1
	aJ1nmLvSER56n4Hyk5SO0ed6z6atprcQN2417CCSNkydRZS3LfNQAKyCWwbYElvoSm5k4APgS+F
	32CUHGPfMFe8RWtfOe34t6Y9Ro9dP9Iton799LXYkRE8oa+Y30COIc1bQPjVH1xlMRugvxvwxBf
	lqWsqoVE4wqUnq9f2PEbuN0VUHdptzOXSq6l70znAhcRWnJMb9D/eB969+WxRMdGj12Q0XapnNp
	OiTsN3TD1qv7u62gx8ICVRLfsABgByO0e0nPbJr
X-Received: by 2002:ac8:5d4e:0:b0:533:2ea0:e3ad with SMTP id d75a77b69052e-5332ea0ef86mr136936361cf.7.1790614513377;
        Mon, 28 Sep 2026 09:55:13 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430ec25a1sm83729766d6.46.2026.09.28.09.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:55:12 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:55:10 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: sputnik@on-the-web.ch
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v2 0/3] rkbin: convert LICENSE to SPDX
 expressions
Message-ID: <arqb7tB0bSwHOYcS@localhost.localdomain>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
 <20260806214149.714963-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806214149.714963-1-sputnik@on-the-web.ch>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Sep 2026 16:55:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4961

On Thu 2026-08-06 @ 09:42:08 PM, sputnik@on-the-web.ch wrote:
> From: Martin Herren <sputnik@on-the-web.ch>
> 
> Hej,
> 
> This series fixes the legacy/CLOSED LICENSE warnings coming from the
> rkbin recipes by OE-Core commit e9d424738d6f ("classes/conf/lib: Parse
> LICENSE as SPDX Expression"):
> 
>   https://git.openembedded.org/openembedded-core/commit/?id=e9d424738d6f8411d4e745b7d872a00e10bb14ac
> 
> Patches 1 and 2 switch the rkbin family (rockchip-rkbin.inc, used by
> -ddr, -optee-os and -tf-a) and its native variant from "Proprietary" to
> a recipe-specific LicenseRef-Rockchip-rkbin backed by NO_GENERIC_LICENSE,
> so the SPDX manifest references the real Rockchip LICENSE rather than
> the generic one-line stub.
> 
> Patch 3 switches rk3308-rkbin from "CLOSED" to
> "LicenseRef-rk3308-rkbin-CLOSED" + NO_GENERIC_LICENSE[...]=README.
> 
> rk3308-rkbin pins an older rkbin revision whose tree ships no LICENSE
> file, which is why it used CLOSED and only pointed to the README.
> 
> A potential cleaner fix could be to reuse the current repo's LICENSE.
> The rk3308-rkbin S
> RCREV dates back to 2019-10-15 while the initial
> LICENSE was only added 2023-07-26, which beside a typo and a
> trailing newline is identical to the one used for the other rkbins
> (updated 2024-10-17).
> So that's an almost 4 year gap between the used SRCREV and where the
> LICENSE was introduced.
> So this would probably require legal validation from Rockchip's side
> whether it applies retroactively as well.
> This option would require adding a static LICENSE file to the recipe.
> 
> What changed since v1:
> - Added Reviewed-by tag
> - Added AI-Generated tag
> 
> Cheers,
> 
> Martin
> 
> Martin Herren (3):
>   bsp: rkbin: use SPDX LicenseRef for Rockchip proprietary firmware
>   bsp: rkbin-native: use SPDX LicenseRef for Rockchip proprietary
>     firmware
>   bsp: rkbin: rk3308-rkbin: replace deprecated CLOSED license with a
>     LicenseRef
> 
>  recipes-bsp/rkbin/rk3308-rkbin_git.bb          | 3 ++-
>  recipes-bsp/rkbin/rockchip-rkbin-native_git.bb | 3 ++-
>  recipes-bsp/rkbin/rockchip-rkbin.inc         
>   | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)

Applied to meta-rockchip, master branch.
Thanks!

