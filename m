Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4180.1794865025175666404
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 13:37:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google2 header.b=gk/4ZI+a;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49412eb1474so2020257f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 13:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google2; t=1794865023; x=1795469823; darn=lists.yoctoproject.org;
        h=in-reply-to:references:subject:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q8FR0ZpVjTKQj1GwDEigrzZsfPF4TKE/k85eSgO+1iI=;
        b=gk/4ZI+alm69prlapT8JnsdZYj3CXekJVfe1yEk7H2I7SOzROrDnFZ79MmSpIATZDN
         llrhxSU57XIyLOyFxv/LoohRMbidcWc/a30ORWy1uTztdhmP3D9cY4Z5zVh83BgJYOep
         v/rXQ5G2ugDxGmv0wfdcTM2PEFn0IsLH/XGJ33XPkDCzEtGTNtrXt2+dvDVCQUJgGBdj
         i2FPzjntEA8WXMvpGXOuq1nX5jGOmJ3ZL5sekYkkGMqW4c0dnEWXiZqPvkGRab0OFpbV
         44D0U8Pl+zeVvzgGpHJJz0UGeBT8GkO9oN6IVrXVXTuNl47U1agtfhrilBlfoER0/Pte
         5TAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794865023; x=1795469823;
        h=in-reply-to:references:subject:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q8FR0ZpVjTKQj1GwDEigrzZsfPF4TKE/k85eSgO+1iI=;
        b=Kiy68p6aONW+ORI38GgHcVO79Lv7fN9ZACiwSk4f++FePuySISYc/DpOXWHCw0oIHx
         z3yeR2hrbwiSDIzfDA8ZRej5TtJF3v5baWh7LDcW/UHFU5hNXPjDV31sq/42ikT0jZKl
         7UKob4LVXZJCxdib6QXpxy+mdXvifGhpKfJCnbIHWwPEVZrpWfn4uQL4o5mE0jLh4nbm
         akbJ2ngyBrXY53mJ9hEA8j0VMKCg8N7Q/J9vlKaahVUu4QemFQh3u1KjSTZtAlLx5xr4
         a7H+WAnt0Q3IDYvu//jdNIAZvLQ9Ei9AGRxKpdFGF2LySMWABC/EuAWMWE0Dj5Cpbh2y
         m9/A==
X-Forwarded-Encrypted: i=1; AL+hErF9pFOf6uZmLTvB9J28cPs7qCdyVhFJhmxEQqPYT0xOZUN+9Pz7V0QvJ+mtTw00hVaX5ntMia9ILYBPAdWE@lists.yoctoproject.org
X-Gm-Message-State: APuU4Z/u/5GIXfxBkFpW1+sTFYfYX8wqd3WiFzvvxfZ/uG7tlK/pWFq0
	4MluSyZh0mEzu3k86mQycVrgOjCVb1/PgRcPAkef7K94gPqhaQmSEMuZcXNx+oBV6+J3bc/esEk
	UODvVKjU=
X-Gm-Gg: AZFdTZeew9ydZhPIdQZIBbYr4VexDLxijAWXtAnrd5TAbXqoeKlgREDmaJJ+z3Eaf2R
	4cSGw4k0xWQ17C+VRwZv82FL8qL+dBWwWHQ74yURGnv/NcJz9bqAXkArhGvGTYQquLkufaA/GSW
	VHJ0NcZEOPa3sSAWVxinQGJG0+qqHxjGGA/zB+KF39MEGhIhmr3TIdTdvFlzrpqPVQRfnuk/dle
	cudFRj7J+Mhv/ZOoVZMWBrnklXfTGojB60liigZsX3WAMXTIWZy+4F2vYyMoBjCcsh9TIdQ52bH
	P7QJbtRb2NimmBp6sj8jfxfH6k69vfhoE5LLfr05p5qIgSUYw45ANr1SXha5iaPFia2LUHjL2kg
	nShyWIxuDw5JOUL79E+8/O6qt1/IqjiUUz1xt9f4TYVcoQdlFTldRgetV26GG6JbeQVqKi9OHMW
	7Rv98Ol7U92BstFIZ2ywp8KgwTD7K0Tsjyhd0hejFFEdljcE5298QOQwu18AejHm2EaXOMfrFWt
	GSJb4fbXSON94/LXMyn5wlZKOKAneBhDn88tmHPQzpp5RjJa5IPhXhWXSvSUPlMCdqZCzwt/lG8
	SAkR1tH6u3aPA10CDUyajDZ13pOqYL9UVabw2P894Kr9x/v0K7rlXHzgFBAi6GxICXFlosGTLTJ
	zGa+CYhg0RxaUPocfZA==
X-Received: by 2002:a5d:5d87:0:b0:48e:5db7:fd6c with SMTP id ffacd0b85a97d-49c6e68da25mr29242165f8f.4.1794865022921;
        Mon, 16 Nov 2026 13:37:02 -0800 (PST)
Return-Path: <yoann.congal@smile.fr>
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c6451sm25841361f8f.45.2026.11.16.13.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 13:37:01 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 22:37:01 +0100
Message-Id: <DMWYJRR9IJX5.23V6N7V9PJCA7@smile.fr>
From: "Yoann Congal" <yoann.congal@smile.fr>
To: "Mark Hatle" <mark.hatle@kernel.crashing.org>,
 <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [pseudo][pseudo-1.9]PATCH 00/10] Backports from
 master to 1.9 branch
X-Mailer: aerc 0.20.0
References: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org> <DMT7HDZT3P6O.1DHC10SI0D1UB@smile.fr> <DMUA3YZ5XCVE.34QEVSM08HIU2@smile.fr> <ee9c9aba-d3e0-4819-ba5e-bc1c87ac8655@kernel.crashing.org>
In-Reply-To: <ee9c9aba-d3e0-4819-ba5e-bc1c87ac8655@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 21:37:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5425

On Mon Nov 16, 2026 at 6:40 PM CET, Mark Hatle wrote:
> I've pushed this version and declared a 1.9.13 tag.
>
> Commit is: 26afebdaafa416eefa51553fc28d827719c5aed5
>
> --Mark

Thanks for the ping. I'll note to upgrade this properly.


>
> On 11/13/26 12:02 PM, Yoann Congal via yocto-patches wrote:
>> On Thu Nov 12, 2026 at 12:46 PM CET, Yoann Congal wrote:
>>> On Wed Nov 11, 2026 at 5:15 PM CET, Mark Hatle via yocto-patches wrote:
>>>> The following are backporting a small number of fixes:
>>>>   Add open_tree test case
>>>>   Fix makewrapper compilation warning
>>>>   Don't require linux/mount.h (part of the open_tree work)
>>>>   State a minimum gcc 5 requirement
>>>>   Add in the parallel rename/link locking
>>>>
>>>> It is also adding to new files:
>>>>   Add a README.security and AGENTS.md file
>>>>
>>>> Note, there is are a couple of additional pending changes likely
>>>> specifically for Yocto Bug 16493.  This is still in testing and
>>>> will be sent to the list once ready.
>>>>
>>>> Mark Hatle (10):
>>>>    test: Skip open_tree tests when the function or syscall is unavaila=
ble
>>>>    makewrappers: Don't generate unused _int paths with noignore_path
>>>>    ports/linux: Don't require <linux/mount.h>
>>>>    configure: Require GCC 5 or later
>>>>    pseudo_client: serialize path changes across clients
>>>>    ports: hold the path lock in create and metadata wrappers
>>>>    ports: check created files under the path lock before recording the=
m
>>>>    test-parallel-ops: Add a parallel create/rename/link/chmod test
>>>>    README.security: Add information specific to file/process security
>>>>    AGENTS.md: Add to assist future developers
>>>
>>> Hello,
>>>
>>> FWIW, I plan to integrate these onto my stables branches to test them.
>>>
>>> Thanks!
>>=20
>> This series passed a-full on scarthgap (on first try!):
>> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/5116
>>=20
>> Integration was done with this patch:
>> https://git.yoctoproject.org/poky-contrib/commit/?h=3Dstable/scarthgap-n=
ut&id=3D7a6ca5322b313aabf826b0105eaf37a0add2f3b0
>>=20
>> I plan to do the same for blacksail and wrynose. It might take 1-2 weeks
>> to get sufficient testing on all those branches.

For what it's worth, this series passed a-full on wrynose:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/5130

Regards,

>>=20
>> Regards,


--=20
Yoann Congal
Smile ECS

