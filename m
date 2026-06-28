Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C9AC43458
	for <webhook@archiver.kernel.org>; Sun, 28 Jun 2026 08:08:42 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.69082.1782634119559414189
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Jun 2026 01:08:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FbMe7Yaa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-472a14c9965so294990f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jun 2026 01:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782634117; x=1783238917; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wjrfVLjd0SVVENCm9pW7TTOv0fih4P6UknyrJ/O07Fo=;
        b=FbMe7YaaKNz83e0+B0mFw9G/nzofaWwx86sKMu6p7vZrFy+LUi3Cxe5C4V9xn9ebGM
         EcwFAYd/3PrwqG58hulby+CQ9R2k8raawBZDIz+/2RMI6OxXJhGzjA+74wPz6gHyKcjU
         cjy+R3xlZ8/djVp5lUxPi03Sgo8EY/1/9cWbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782634117; x=1783238917;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjrfVLjd0SVVENCm9pW7TTOv0fih4P6UknyrJ/O07Fo=;
        b=hBwEuDNeOMz2h22ZWx1CqBrJVpFUBPbglFVOR9zPxw1Nuk5or51uH8YNGAfPN2AmdR
         a60vumO35dbFXTVUTygxaDmTNbZnnocDbX1QYtb/4alsvDWQpqLxyj07Kee3OhEK89Jb
         6w7ve3l/pQgXQG6+LuMXmQGZ8MjQZOiBr7KejL+wC+2MjAFA+Oy0aKZROYUYvvRHqZ2B
         83eXdsLykGI+wXYLVIeDtue3GCUgea20ZpWbV/N0KELGdQ8u8PM98QpW/Je1p0OTmcsH
         CKQndGdpXb2YKwVI7vg+EbMCvbA0WJkiBY4jdp80vKEyy40Sc4sGPfEBc0jE9wW5hDIB
         5aTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8J22StemqQ5e/wRYMQPC+vXTaTx5zXimyqr2CPLue6PTos9/omYoykDBGKOU6aLbO+vBVGLDB/CPUgKUCt@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxiZBoR5eFqRkDTzi4V+uiEWd2RBdEgq+ItI3ioaJVFHCbyt4gi
	VtyHmyg3T688x5Tgw5XudiEiiC4h15e2VBrTiDzi5zHnhe0Kk/7KyVPXQI9WYaG4anY=
X-Gm-Gg: AfdE7ckp3MqhFrs6Vv/sNURf84vFMqxcdskjF67LB+bX47STvMmJxDK+sp2JUIb6NlI
	LvfML9U9OD9XYliYub2PvjQuUujc5BJkq8NKCYS2yP7x6J6UegrEONWtOU8Za5w8CAMcXRy1yVu
	HVGM2FAbYyy7SHbyS0W3ncr2b7KDm8ed8c2g7RpmUQCRUdJUXdASJeaxhsVCJVIUdakG7QVK7Vx
	82B4u5kV1DyQODdTn0Uf5FR1GxkbTHOZuIpTs6plmTme2z5MDwPYe6UOQkZUOciQcc0eTUM8ihw
	DUeKcbKUCymBKNYn8yKBf4Pj/eVjqR4yHDIo4GgFBbgj2AWfOeYQKkjxSvfWUy5SUJJSOVXdBtl
	UehPEpEBUNvucAZ4x7k20hCxnl7YKmF9DrOUGqMqYGtXWCD7zfrILORHtXKawoDS/IDUoRd3Y+l
	vi6aE08vPEXAMVYh9SSJ+ouOxr+hokrM0Dwy5tb74koV6krMGROd8+Y+DXKa6Upb9TlzTK0exKC
	auIOw==
X-Received: by 2002:a05:600c:1d08:b0:493:a607:f3b8 with SMTP id 5b1f17b1804b1-493a607f49amr25799735e9.0.1782634117207;
        Sun, 28 Jun 2026 01:08:37 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a165:6d61:c7bd:48ff? ([2001:8b0:aba:5f3c:a165:6d61:c7bd:48ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268ff1be9sm225896365e9.8.2026.06.28.01.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 01:08:36 -0700 (PDT)
Message-ID: <e9ee27ab791e38456ff57b535abe9d56eac60f76.camel@linuxfoundation.org>
Subject: Re: [yocto-autobuilder-helper][scarthgap][PATCH] config.json: Use
 buildtools on RHEL9 derivatives
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Yoann Congal <yoann.congal@smile.fr>, 
	yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
Date: Sun, 28 Jun 2026 09:08:35 +0100
In-Reply-To: <20260624142429.1628429-1-yoann.congal@smile.fr>
References: <20260624142429.1628429-1-yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jun 2026 08:08:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4311

On Wed, 2026-06-24 at 16:24 +0200, Yoann Congal wrote:
> From: Paul Barker <paul@pbarker.dev>
>=20
> tar 1.34 (and possibly earlier versions) is unable to extract tarballs
> containing read-only files with xattrs. This was fixed upstream, but
> it's unlikely at this point that the fix will be backported to RHEL9
> related distros (CentOS Stream 9, AlmaLinux 9, Rocky Linux 9). The issue
> affects these distros specifically because they have selinux enabled by
> default and this uses xattrs.
>=20
> The specific failure we've seen is with the /usr/lib/udev/hwdb.bin file
> installed by the systemd recipe - this file is chmod 0444. This leads to
> the following error, typically during do_image_wic (shortened and split
> to make it readable):
>=20
> =C2=A0=C2=A0=C2=A0 subprocess.CalledProcessError: Command
> =C2=A0=C2=A0=C2=A0 'tar --xattrs --xattrs-include=3D'*' -cf - -S -C .../t=
mp/work/qemux86_64-poky-linux/core-image-minimal/1.0/rootfs -p . |
> =C2=A0=C2=A0=C2=A0 tar --xattrs --xattrs-include=3D'*' -xf - -C .../tmp/w=
ork/qemux86_64-poky-linux/core-image-minimal/1.0/tmp-wic/rootfs2'
> =C2=A0=C2=A0=C2=A0 returned non-zero exit status 2.
>=20
> To work around this, we will need to use the buildtools tarball on
> affected systems.
>=20
> Fixes [YOCTO #16143].

I'm a little worried we missed a side effect of this change.

https://git.openembedded.org/openembedded-core/commit/?id=3Dbb7c445004f0706=
a96192d97bba1c8776595814b

means we do detect and warn users of the issue.

Unfortunately, buildtools has a lot more in than just tar and we're
effectively reducing the value of testing on those older systems by
using a full buildtools to work around an issue in a single one of
them.

I'm wondering if we should create a simpler "tar" buildtools tarball,
to ensure other issues don't creep in on RHEL9 derivatives?

Sadly, we're stuck with RHEL9 for a while yet, we still can't drop
RHEL8 :/

There is precedent for a single tool buildtools before when we had make
issues with ./meta/recipes-core/meta/buildtools-make-tarball.bb
(these days I'd class extend it!).

Cheers,

Richard

