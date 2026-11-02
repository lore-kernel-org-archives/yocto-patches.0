Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14545.1793632037405996432
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Nov 2026 07:07:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S0NwwHFv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e20edd106so2405337f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793632035; x=1794236835; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Jr5P9NXLnJb+OyBQspm8LEJVvFBmBgDkYVkrR8ohHpU=;
        b=S0NwwHFvwvw5hWyysm7L3Hz3X/TYVvh/5G3T3UPpm2se7ExleeMZ718qfs6DHZ0alo
         0Edqd2JCpnvMLqjMxuQxGVdpVR0xA0BSoXvm6U0isyK+I+OJqQ2fmUOXKRvzXShKToq0
         r84zD00SWwZbhfMbvkMiqMsrZrDGgRehKd/FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632035; x=1794236835;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jr5P9NXLnJb+OyBQspm8LEJVvFBmBgDkYVkrR8ohHpU=;
        b=gDaYjfhsiio8VOQ5M7pJv7NQcTG4Rq5qP3yW0Eo++SStafga/mLjasm4mK2P3+9Aae
         nUk6mlNteoiO1ssdzvJY6gjgW8j1oTgt02swCEadSaPc/0eGrJB7qQvA4TcpguSBuz05
         PoUTBPZ22c+Nkp6p5rFhAQJD32VEmAv4UG0/G13yjXsQVMiisOf7+JaxFLC6JVTJ8WH1
         ikke4oB4WDoMFKHgMDHgNZ5EC0eLrk51Yju+tUUnA/0zwZQ4NMLs0cNY98fOJSB3I0Bg
         /sokORAXrTBTdwyhX1aiuFy1gpO8eXGleZWYSdj1RJi86OrezmPQ7eA6dHb42uecTM56
         aD6g==
X-Forwarded-Encrypted: i=1; AKwUvBwobcH6cU6c4Zr5XdHx3yYkCtZ7D9Rb0rN83WcfujEBp2hBHhCZ4R+d4ciGog57z5QxSBvoDjj1Tm1/YPry@lists.yoctoproject.org
X-Gm-Message-State: APuU4Z/P8fCoFsGikQfQlHdAL3z//v3j2JFxHzs8Fiw8Bi/74WO0fbWu
	F+YMbi2VOPOX5ebGZC51sWOP8AhIEAFJiPC7omkJPdDqhPujxz9ffPa96kO23fI03/Q=
X-Gm-Gg: AYBFou1A7nVsKlsfLHrrz5SiFKBsJYwhIvtWj7tdtGJYsF11LKg7ZoarlAsO/h9wjoE
	mJdtohMolZdUkRSCPR8zCm1f7LMsQ/xH5JNDNyR6HRHNHB1gQIUNnd+hHOBNgKyCz/TCIKeYvsb
	1NYoZDFlDP2NN1BE66tzd2+vzS3HCvbnW6GX4dDCQkQ9r76peiSsv81A1X+zy/MWjc/jaXW1yCS
	fUT+rp0IvAB3G4bfnN/wQpAUBICD1mGLd392HVj1QIr+W2/FkoLLPps9s1/cQ/MPQ5X33Verd/8
	0J0Sk21EJYSjIVh6rSrZS4Y9zp+lJfcxG2Hx4+FAwangnBBr6zMY0RmEyn6SkvdiQUvgEocnNA0
	N5ugVil7zZH1IdrV1Ye7Y3KqenfT20aRwcGzy6I14zoxrQyV1tkubVTe6Ay6mhZIU9qx04SHxEJ
	3x1xy+j1S2G8PT68FFkAvNbkkCi8Jxw1rW0amUmOtYGdKEOVDs6kTI7rDgfoIhBtyUsnA4oAvWx
	ui9VFsl6uG+OlgR3+atupCxMXPs1KkWNddDrBQkDfbIZ8Njkpd8QlLv0G9tj3k2pzvU/sCCn8pv
	LA8f7vUZ7I2+HSjNG8RIdgnxYRhNOKVNwjG69vYBcT8l/uZlI91+I8mxH586gMxCyhze4q6X2pd
	Ya6C5bADVpnJiosjiWw==
X-Received: by 2002:a05:6000:4021:b0:48e:4300:c70e with SMTP id ffacd0b85a97d-48e6e304059mr22291920f8f.46.1793632035406;
        Mon, 02 Nov 2026 07:07:15 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:a866:4584:45b1:5742? ([2001:8b0:aba:5f3c:a866:4584:45b1:5742])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78c10sm20035458f8f.25.2026.11.02.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:07:14 -0800 (PST)
Message-ID: <7d23bb889cf23f8a0b3d2593dea64cb9be3de5c6.camel@linuxfoundation.org>
Subject: Re: [pseudo][PATCH] pseudo_client: resolve /proc/<pid>/fd/<n> to
 the descriptor
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: chenqi_hycx@cetc.com.cn, yocto-patches@lists.yoctoproject.org, 
	mark.hatle@kernel.crashing.org
Cc: chen_q07@163.com
Date: Mon, 02 Nov 2026 15:07:13 +0000
In-Reply-To: <20261102022203.1613668-1-chenqi_hycx@cetc.com.cn>
References: <20261102022203.1613668-1-chenqi_hycx@cetc.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 15:07:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5207

On Mon, 2026-11-02 at 10:22 +0800, chenqi_hycx@cetc.com.cn wrote:
> From: Chen Qi <chenqi_hycx@cetc.com.cn>
>=20
> Paths such as /proc/self/fd/<n> and /dev/fd/<n> denote the open file: the
> kernel resolves them to the descriptor, so an O_PATH|O_NOFOLLOW descripto=
r
> on a symlink addresses the symlink itself.
>=20
> Path canonicalization expands them with readlink(2) and follows the
> result, which changes that meaning.=C2=A0 For a descriptor on a symlink a=
n
> xattr set through it lands on the link target instead of the link, and fo=
r
> a dangling symlink the call fails with ENOENT.=C2=A0 Once expanded, the p=
ath no
> longer looks like something pseudo tracks either, so the operation is
> passed straight through to the real syscall.
>=20
> libselinux 3.11 labels the rootfs through such descriptors, so setfiles
> could not label any symlink and do_image fell back to a first boot
> relabel:
>=20
> =C2=A0 setfiles: Could not set context for .../etc/mtab:=C2=A0 No such fi=
le or directory
> =C2=A0 setfiles: Could not set context for .../etc/systemd/system/default=
.target:=C2=A0 Operation not permitted
>=20
> Rewrite the reference to the path pseudo recorded for the descriptor,
> which keeps the operation under pseudo's control.=C2=A0 The descriptor it=
self
> identifies the inode, so the final component is followed only when
> following it is what reproduces that inode, i.e. for a descriptor obtaine=
d
> through a symlink.=C2=A0 When the caller passes AT_SYMLINK_NOFOLLOW the
> reference itself is what is being asked about (readlink, lstat, l*xattr),
> so it is left alone for the kernel to resolve.
>=20
> Adds test/test-proc-fd.sh covering both descriptor flavours.
>=20
> Assisted-by: Codewhale:deepseek-v4-flash
> Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
> ---
> =C2=A0pseudo_client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 118 +++++++++++++++=
++++++++++++++
> =C2=A0pseudo_client.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0pseudo_util.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +
> =C2=A0pseudo_wrappers.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0test/test-proc-fd.c=C2=A0 | 174 +++++++++++++++++++++++++++++++++++=
++++++++
> =C2=A0test/test-proc-fd.sh |=C2=A0 17 +++++
> =C2=A06 files changed, 315 insertions(+)
> =C2=A0create mode 100644 test/test-proc-fd.c
> =C2=A0create mode 100755 test/test-proc-fd.sh
>=20
> diff --git a/pseudo_client.c b/pseudo_client.c
> index 302ef21..1ebf665 100644
> --- a/pseudo_client.c
> +++ b/pseudo_client.c
> @@ -864,6 +864,14 @@ fd_path(int fd) {
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/* Return the path pseudo has recorded for fd, or NULL if it is not one
> + * pseudo knows about.=C2=A0 Declared in pseudo_client.h.
> + */
> +char *
> +pseudo_client_fdpath(int fd) {
> +	return fd_path(fd);
> +}
> +

Why not just call fd_path()? Do we need a new function to wrap that?

Cheers,

Richard
