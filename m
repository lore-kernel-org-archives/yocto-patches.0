Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21029.1794803127918593906
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 20:25:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=IVQS2Kdl;
 spf=pass (domain: gmail.com, ip: 209.85.217.49, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7cc53938a8fso3723935137.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 20:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794803127; x=1795407927; darn=lists.yoctoproject.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bTIptCSZglDZKXRaZLXVtEXSF7AX+27Hk4IP+NT4o8c=;
        b=IVQS2KdlXOG3X3W57PRWTexT4bvgxF5vNOIVgcEfxXxHBurZeTkRP4k8BMLg95v2KN
         kxtzGXy/TTicFgE2qa7mCYfRLJsNTCkWWuDzo1rkCOjLwnaUDWRW/pr0CrphcQ3Aq/GC
         yCbHNsXKr394HN7hJnQBOXOfWJdPMLisSNoKNkmSFMYpgFstUKK41xCsqKEmaHKqVdCd
         w4GDcDd41lBa42FwsxgEUp/a72yPM2u0LnewRz31yKXqzjA7q3hACwepRQCNv8mLF0+O
         lhsJAYu24+fob66Q+yqzTXc7gOqmO2Cf2fMvBArXWU2BTeIVUnHFz2tFYaY3b0xj13SC
         RZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803127; x=1795407927;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTIptCSZglDZKXRaZLXVtEXSF7AX+27Hk4IP+NT4o8c=;
        b=TN2ndVnKgUEn2j4wVzbwkSYqKDkbJUtOTiNLSUWNlYtgWROqcC6tRCYo542ENRfOPz
         uAJwpslkdQ/euQmvcC/DqOPspr94PPh9IAa/2ZLc5eUc7FRpo0Yih3121t88SVSvaQdD
         5vVCamZBVXA5sBX7rk9qvsxgG1PAKqdHHNbV4RyWXu3S3c/FxMH6jXoXmFQgFwsxqfV3
         Pow72A9C04wdxvxdcztLb1D8PYZgvBsjulM4U+YmJRFwfxRbxq7CQjLNwwmIpe7VNDtk
         7QlpkUDu8cqa2HzB6OJtWtIAaku1g1cOwlxxtwgvOZ/2Gnxl8pauVAOvp1AMDh/fuDK3
         4k5w==
X-Gm-Message-State: APuU4Z/7OvMsAJI0oCOtyvye8/5L5SSo4iemPSplgllBGmK6A8aMIhc8
	WrOPpP8sR6I4QzXGBzZapJxbJVlzjCYLmfO4qjav2pkRg4hLrx6enN0bkQg4e5cT
X-Gm-Gg: AYBFou1X+mfzUlOL7f8VLdskJCWRAW8/2b7xNh9ymrT9/RUWDBYihOAbqOeUyB9zB9U
	ILP+dFI0nh7QAlpbmWxhqRK2vAOMeYXwgBK4/wo2TBKDPJM3LPd6g5KMGbqM3BgsfqhQQ6H2Cuy
	qHFieByT5KeHlkpoHhvfU00S5vqjIqtK7qUsWUZ3X63hNPPYx/ia5FwP+16NLgOH1ZSpUsz6uv3
	zulPsjoXOSUE5siLbiOAMo6HzbR8CS5bVkbZPS1Aus8NaKzCyK7ch9z9xuCnVP/bypsXdfIHkw4
	v2ho0H2nLnk2+AWR4kr+lusl54rzJWD7I20hW5PUbmFVELGOzamTtr4e4OxWUkxGDpgSoYwtTQt
	VLMwJoahU0aY9mL8Y8sILuAFCVk+OmLkNDBhveVH3JPSb4ni/lTeQHvK6QUg/ri6V0vWRaMfZwK
	kl1XMd9a/1cV8OXotaFYQgZbDL4JK7gZJ+Nf4oS9cWQWvJP+zQCq+MTACw/3W+vI4FLKXDX6fx6
	3jWNcv5GibHf0LZYuLP8caHNOLQlfa63f5oiP0X4n0xxo3kgoou0ul26Y9+3WVZwo+fm0smomdU
	c8IvLXXJmKo832SHH+EpnE+Bh5U179PRAj/E6B0f/2HZyf3dBhX+Mgpi7Ld5SOTdBhOjUzKblen
	bhQym8TmYElgSAesaMlrk/5t5nLyFL9Mte3t5TTrmmJ1gkKqC7w==
X-Received: by 2002:a67:e7c1:0:b0:7b2:f3ff:6b34 with SMTP id ada2fe7eead31-7d64d468432mr3356529137.1.1794803126577;
        Sun, 15 Nov 2026 20:25:26 -0800 (PST)
Return-Path: <bruce.ashfield@gmail.com>
Received: from [127.0.1.1] (pool-174-112-34-35.cpe.net.cable.rogers.com. [174.112.34.35])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c47fb86sm5402447137.6.2026.11.15.20.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:25:25 -0800 (PST)
Message-ID: <6afa85b5.10cedc40.24ed7.c6d6@mx.google.com>
Date: Sun, 15 Nov 2026 20:25:25 -0800 (PST)
From: Bruce Ashfield <bruce.ashfield@gmail.com>
To: Rohini Sangam <rsangam@mvista.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-virtualization][scarthgap][PATCH] libvirt: Security fix for
 CVE-2026-18917
In-Reply-To: <20261112071945.270457-1-rsangam@mvista.com>
References: <20261112071945.270457-1-rsangam@mvista.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 04:25:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5405

merged

Bruce

On Thu, Nov 12, 2026 at 12:49, Rohini Sangam wrote:
> Pick patch from [1] also mentioned at Debian tracker in [2]
>
> [1] https://gitlab.com/libvirt/libvirt/-/commit/5a62cbf2907d4590283597b46da=
9c0f41e7b4d4f
> [2] https://security-tracker.debian.org/tracker/CVE-2026-18917
>
> Signed-off-by: Rohini Sangam <rsangam@mvista.com>
> ---
>  .../libvirt/libvirt/CVE-2026-18917.patch      | 70 +++++++++++++++++++
>  recipes-extended/libvirt/libvirt_10.0.0.bb    |  1 +
>  2 files changed, 71 insertions(+)
>  create mode 100644 recipes-extended/libvirt/libvirt/CVE-2026-18917.patch
>
> diff --git a/recipes-extended/libvirt/libvirt/CVE-2026-18917.patch b/recipe=
s-extended/libvirt/libvirt/CVE-2026-18917.patch
> new file mode 100644
> index 00000000..bf9c2e69
> --- /dev/null
> +++ b/recipes-extended/libvirt/libvirt/CVE-2026-18917.patch
> @@ -0,0 +1,70 @@
> +From 5a62cbf2907d4590283597b46da9c0f41e7b4d4f Mon Sep 17 00:00:00 2001
> +From: Peter Krempa <pkrempa@redhat.com>
> +Date: Wed, 12 Aug 2026 16:51:58 +0200
> +Subject: [PATCH] remote: Fix integer overflow in RPC handler for
> + virNodeGetFreePages (CVE-2026-18917)
> +MIME-Version: 1.0
> +Content-Type: text/plain; charset=3DUTF-8
> +Content-Transfer-Encoding: 8bit
> +
> +CVE-2026-18917
> +
> +The RPC handler 'remoteDispatchNodeGetFreePages' multiplies the 'npages'
> +argument with the 'cellcount' argument passed to 'virNodeGetFreePages',
> +both of which are declared as 'unsigned int' to both do an RPC limit
> +check against the 'REMOTE_NODE_MAX_CELLS' constant and then to allocate
> +the memory to hold the result from the actual hypervisor driver.
> +
> +Since both the values are 'unsigned int' the product is also unsigned
> +int so big enough numbers can overflow, both passing the check and also
> +allocating not enough memory for the result. The hypervisor driver
> +assumes that the passed buffer is large enough and overwrites memory.
> +
> +When this happens the the hypervisor daemon crashes.
> +
> +This can be triggered e.g. by passing 1023 and 4198405 as values which
> +multiply to 1019 after wrapping to 32 bit unsigned value.
> +
> +Use the VIR_INT_MULTIPLY_OVERFLOW macro in the check to avoid the issue
> +the same way as we do for other APIs doing multiplication of arguments
> +to determine amount of required memory.
> +
> +Fixes: 34f2d0319d2098c77c8cc27d8350616029125a2b (v1.2.5-164-g34f2d0319d)
> +Closes: https://gitlab.com/libvirt/libvirt/-/work_items/903
> +Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> +Reviewed-by: Daniel P. Berrang? <berrange@redhat.com>
> +
> +CVE: CVE-2026-18917
> +Upstream-Status: Backport from https://gitlab.com/libvirt/libvirt/-/commit=
/5a62cbf2907d4590283597b46da9c0f41e7b4d4f
> +
> +Signed-off-by: Rohini Sangam <rsangam@mvista.com>
> +---
> + src/remote/remote_daemon_dispatch.c | 9 +++++----
> + 1 file changed, 5 insertions(+), 4 deletions(-)
> +
> +diff --git a/src/remote/remote_daemon_dispatch.c b/src/remote/remote_daemo=
n_dispatch.c
> +index 7542caa..8bf5e7c 100644
> +--- a/src/remote/remote_daemon_dispatch.c
> ++++ b/src/remote/remote_daemon_dispatch.c
> +@@ -6620,13 +6620,14 @@ remoteDispatchNodeGetFreePages(virNetServer *serve=
r G_GNUC_UNUSED,
> +     if (!conn)
> +         goto cleanup;
> +
> +-    if (args->pages.pages_len * args->cellCount > REMOTE_NODE_MAX_CELLS) {
> +-        virReportError(VIR_ERR_INTERNAL_ERROR, "%s",
> +-                       _("the result won't fit into REMOTE_NODE_MAX_CELLS=
"));
> ++    if (VIR_INT_MULTIPLY_OVERFLOW(args->pages.pages_len, args->cellCount)=
 ||
> ++        args->pages.pages_len * args->cellCount > REMOTE_NODE_MAX_CELLS) {
> ++        virReportError(VIR_ERR_INTERNAL_ERROR,
> ++                       _("npages * cellcount > REMOTE_NODE_MAX_CELLS (%1$=
u)"),
> ++                       REMOTE_NODE_MAX_CELLS);
> +         goto cleanup;
> +     }
> +
> +-    /* Allocate return buffer. */
> +     ret->counts.counts_val =3D g_new0(uint64_t,
> +                                     args->pages.pages_len * args->cellCou=
nt);
> +
> +--
> +2.44.4
> +
> diff --git a/recipes-extended/libvirt/libvirt_10.0.0.bb b/recipes-extended/=
libvirt/libvirt_10.0.0.bb
> index 4076a0cf..2bb725b1 100644
> --- a/recipes-extended/libvirt/libvirt_10.0.0.bb
> +++ b/recipes-extended/libvirt/libvirt_10.0.0.bb
> @@ -39,6 +39,7 @@ SRC_URI =3D "http://libvirt.org/sources/libvirt-${PV}.tar=
.xz;name=3Dlibvirt \
>             file://CVE-2024-4418.patch \
>             file://CVE-2025-13193.patch \
>             file://CVE-2026-63622.patch \
> +           file://CVE-2026-18917.patch \
>            "
>
>  SRC_URI[libvirt.sha256sum] =3D "8ba2e72ec8bdd2418554a1474c42c35704c30174b7=
611eaf9a16544b71bcf00a"
> --
> 2.34.1
