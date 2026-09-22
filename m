Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15686C98302
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 17:35:04 +0000 (UTC)
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1611.1790098494723357895
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Sep 2026 10:34:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EsayDhzf;
 spf=pass (domain: gmail.com, ip: 74.125.227.12, mailfrom: alex.kanavin@gmail.com)
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78a53fe85easo27971137.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Sep 2026 10:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790098491; cv=none;
        d=google.com; s=arc-20260327;
        b=ZszvSL76qJ9kjzgYr0J5zNliupTMrDnf9NyDVq9470oadh2S91Bl5HcLo3gkV9WInv
         sMCxa01omK4IQQHlNheoA5EbDeI83BIJEfgyoto7Xrzo+ZI+1ngFu0kPxziwQap/1WWs
         9WiQMs8aW/omTEDTHWUKvB5J6S7lVmroDc4i6gJ9VgUtmW64/e9Ah4EfKp9LOnvAa64I
         yamXZa2CJKeE4xDl6sPVy0bFziKNexjikghcosA/m2z14DIzcE+lxaDuH0n8YkID6Cp2
         uT+PFECpIyo2r5exh8c7YkMU9AwChuQgOig8S2LzESAL6nQskExrzh9S+PXhZi9KfmiO
         W7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XpMJkY9dbaMPgnpj8f+bL09n8ASxQfSckglnU4uALxc=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=Uetria+Jp2N3cM48ySeuyjCLR/DOl33885moGia0MzYNiC7knoWPHwPsY4JJcgI9PM
         eQpIgr3gvXFXX7lv7iO7WOYixZb6iakygLn19zybCy5l/nyLBW3X4x6V2/9LOoCUyy51
         v+zkqsUGI6O+AjJKHzkkdZjimEHytWcscFwM9+mbCBXb6Uw93GMyAQ4z+M5hMw9Kmw1Z
         gbO6PLBtdAg574btgszkkaITZvwkSMF0h7KR71f28VdOnMQsZLzLmay096KR6WdOAa+n
         Jlts4MUVYzWI3NN96FPeGxjdtFyWl5CcGKnh6JjSMC6Fe3w1+OKgqZrMC0PgnCDVspav
         BqKg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790098491; x=1790703291; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XpMJkY9dbaMPgnpj8f+bL09n8ASxQfSckglnU4uALxc=;
        b=EsayDhzfDkrrJWwRBX51cpTyWvLe3MDIJSN6Wo5LOe0xsyop3G1WZe+GpmEu2EWvTy
         sh1xCQVTz48PvAHwqjO0Dukt3+cvnqLWbM7ZMI3TDQKa5p+ZT0f+6pRXdHKziDTErd26
         fiXWKaViNxpPldd1fj3JBcNG/yFD+W1e2yOIUNBRBJK/Yz+buEgr964OSAO3+fqF2zwD
         UVdPSnvlUgRoR6wwox7CImqsaFniwCzXA5gQz7qfT4vuiURwjFV4lf6fy9BJZf2ZHuME
         JxfdeQX5s41poXspXBphPqVr9MoA6lQAO7SesZN5qKKOhJww+hyXJILZQRsV/m9Wwws+
         0Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790098491; x=1790703291;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XpMJkY9dbaMPgnpj8f+bL09n8ASxQfSckglnU4uALxc=;
        b=03d4A+WZNQB19i7lwZ2xmEuky7fu+bmj32PiKZk3O7fKwxjtdmFpRywqNJPHNFiGiM
         GoD0zKLske00X6ONxgRmBhC/ODTyJOUY2ODll4TjcIwLUFQBuzR9WEW9WyNubbndKpUx
         Wi8ljuZqJ2kbb9aD+zpSEBGBlgatfHVTVr+z5H+p6sX0l73nxWj6nsFY5FPi0Ll79wkz
         KoCj7nRqxNoyzBdwGJwQDf04qcqhxX/TNwbM9aQ5GT/mwee5eqKXFpvqgkyyXB906+o8
         fs1tcbn8Hp3x6ZiOeM4YY6TaXz+g9p4y7uc61Mp2Ci+xnJb6q2EPEcRU3c0dD0SeziBp
         chOA==
X-Gm-Message-State: AFuF++lpMTms3dkmeDVA2eZ2/hqnT+f/lQJwTWAteGShYA3zZCcy++DG
	HsmBjk3CNUjtdu255VpwiqSmmJF7Cw5sng0m335kRlI81xDOS8ENMe+hR+KPRm+VEio2FSdmBSy
	cbYHrcJxJGHzXGaGXgRpSazulX2xDaYo=
X-Gm-Gg: AYBFou3e0QSrGViB3aZuV22GM8b1cmTYrRliL75VYGRDFgV4lz/Ayq9+OWXO1I3pkF5
	ZHlJkz4bvl5Q7GkEif/aFVw9aerVxUA150YjO3X+wy562kphdWlmvSHuQGlLDuourU1TM7YHqjm
	Snoj5tkuMz+Ud43ngZB8Mu9c9G/F/N3wDCdCkTXLo2+iQt1rZXF/izE5rVqZLLhCiMktajkB+Cl
	+d+JvYii/UjKfBXVpr5tO2MExOO1sSwNEA3IEUmZaQlP+budo7qJRQ2XkTj0Fdi/3JCza3gyghb
	HAtohnhW/7bA7kWPO6+UCO5qfSzRsBtoL3y513n7uAqns9kAYsTWtgKIQwd0glZDb4PVwDVtBe+
	YEKmHuaR1/DT8Sw==
X-Received: by 2002:a05:6102:5e8c:b0:7aa:7769:34e with SMTP id
 ada2fe7eead31-7ac1aad34c7mr40200137.4.1790098490726; Tue, 22 Sep 2026
 10:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260918120342.772566-1-daniel.turull@ericsson.com> <20260918120342.772566-2-daniel.turull@ericsson.com>
In-Reply-To: <20260918120342.772566-2-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 22 Sep 2026 19:34:37 +0200
X-Gm-Features: AcwNN1XclVNvB_Bivf0tki6RDs1fjc5xq7XS7XSTXzqj2__mZE9O059nEFvvb4c
Message-ID: <CANNYZj_dBU3QGcjOjfieN+BU2h-r+Tu-6eHeanGbO7MWshTjbA@mail.gmail.com>
Subject: Re: [auh][PATCH 2/4] steps: skip duplicate changelog for
 shared-source variants
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000a71f33065c15c899"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Sep 2026 17:35:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4931

--000000000000a71f33065c15c899
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Sept 2026 at 14:03, <daniel.turull@ericsson.com> wrote:

>  def devtool_upgrade(devtool, bb, git, opts, group):
> -    for p in group['pkgs']:
> -        _devtool_upgrade(devtool, bb, git, opts, p, group['workdir'])
> +    for i, p in enumerate(group['pkgs']):
> +        _devtool_upgrade(devtool, bb, git, opts, p, group['workdir'], i
> == 0)
>      _append_changelog_to_commit_msg(group, opts)
>

I think this is not quite correct. Recipes in a group may all produce
different changelogs, and in that case they should be all included. The
idea is to remove proven duplicates, not just add the first changelog in a
group.

Alex

--000000000000a71f33065c15c899
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, 18 Sept 2026 at 14:03, &lt;<a hre=
f=3D"mailto:daniel.turull@ericsson.com">daniel.turull@ericsson.com</a>&gt; =
wrote:</div><div class=3D"gmail_quote gmail_quote_container"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">=C2=A0def devtool_upgrade(devtool, bb, =
git, opts, group):<br>
-=C2=A0 =C2=A0 for p in group[&#39;pkgs&#39;]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 _devtool_upgrade(devtool, bb, git, opts, p, gr=
oup[&#39;workdir&#39;])<br>
+=C2=A0 =C2=A0 for i, p in enumerate(group[&#39;pkgs&#39;]):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _devtool_upgrade(devtool, bb, git, opts, p, gr=
oup[&#39;workdir&#39;], i =3D=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0_append_changelog_to_commit_msg(group, opts)<br></block=
quote><div><br></div><div>I think this is not quite correct. Recipes in a g=
roup may all produce different changelogs, and in that case they should be =
all included. The idea is to remove proven duplicates, not just add the fir=
st changelog in a group.</div><div><br></div><div>Alex</div></div></div>

--000000000000a71f33065c15c899--

