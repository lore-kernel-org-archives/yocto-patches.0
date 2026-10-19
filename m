Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAE7CCF2E5
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 14:24:11 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35770.1792419846281783836
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 07:24:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=LJak6u9P;
 spf=pass (domain: gmail.com, ip: 209.85.208.179, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a49a022221so14720381fa.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 07:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792419844; cv=none;
        d=google.com; s=arc-20260327;
        b=D5uEnM5EVj7LQbMbWBUSs8gc8YUC6+R7HTEXALqR9v7b+N2vMUb3Rxg0eaF7gUA2Cf
         ymqhuu3SXtf8J98m5riRxthlNNrN5D8z/yy4CR0qF9mni+vbO+3Jd+3JhozdSoNGiiHH
         y17vBS2zkrRz6eg2jsCB/Fr4yPTu9SXi1+b5jpmOg9NV7ojYNg/K2fcJxwsJK+9Gh4Ox
         eaq0kHyxhc/l9NqL17SvtPKmip45DNSQlZ2rse2SkdXdW7jrc61b0V90wKKK42ureXjG
         gv1HjlKdOtCMk9VCweTSv8hdihlMRKAU2dCQ+QRqSyzPHAlDZQM+tuzPEUDFvUQJNJo2
         533g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XKG+Zjpx/ageplCTbh3Yry/ecF6Q/IDDuGFq4VmublI=;
        fh=qTYHb5yXIIHHB/PGMSMmgdQUDUIWtd0aKSuRx6SOSg0=;
        b=RGTimUZW6NtyxL5yTA0Zya8/76TaQq2A/NXzCUpZEi1V4n0opYS5iWAkg6o2GKB0A/
         1Koz4aBKsGkSatad4U2pZcNzPXYNYFmiD+Q6xt5+hJCtT9SQgwDhmQBCm0yfQhU1g6Co
         PMsVcYAENm2UWnh1ERgPohvb6x6SUIWKx/BHMW5PRl4IiXVmgU24+DDCZeGn72DvE1zO
         eym8dq3cPvvqu45qbDlvUaaOovTSltYhZTtTVdmpb5D4M8KL3PV0v/W3xd7jr99JrLGL
         8Z0URSoovECmb9N1hAEX11zVP5LnF9QcRzHXuei18fpKpYEimJMGvuMtMy4uKiqs7SNS
         QOsA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792419844; x=1793024644; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XKG+Zjpx/ageplCTbh3Yry/ecF6Q/IDDuGFq4VmublI=;
        b=LJak6u9PX+V9SbsyJ3e2edNJJxV7ZgcR1zHfWyUko1Xh997M9DDk60BrA/56GRlEel
         U1f0PT1MPTersd/ePbKAztWAac5e0n7Y2GpXFgYybV5nDNjWEFRbrkHHw9mUa8YKcO8X
         zQPxkDRvcaXjYuS7VFMgM46x1ZN98AnSZtND51CDqDTghdd+3ZiH70NE2038o5/7Zv92
         345GcVHLkHbz3MVXJz9SRnhtOrGwiF2k/7Zrw+ajOL/GGPrdZ+7XWY+P11pAwuwq75Ez
         YNXEGRLPsAurs9/gr+A/+mO/TSZZ3LmsaAi91RWIj4u0bnqU9ZNo5I0ikoFx3eM34JUC
         7Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419844; x=1793024644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKG+Zjpx/ageplCTbh3Yry/ecF6Q/IDDuGFq4VmublI=;
        b=F/McKMEB5X00mDnwTuCVOUSH0mr4JJKokMxl5AAZllOBmkeJOECTu+zZLaUVJOCUya
         sPQHsNq7wu2sZfMAlQqvsq28Knxv6hglM96kE5bDOEabyGmcKC3GpIpSG9OVhxlOJcpc
         S//OJUkK7SLeeyB8/wvFtvOmbZ96Ba2tgzkrdiOBRtCD+ld+aFgmd0hP6Jk9eDVXBaQr
         nvDVUaDlHfNzqqoWz4yX1Vt+jVtAFI3/SxpE13vG8M9dLHXqMicqmNc7DC3EfeVzkxzJ
         jfVNX2UGOmvjsMgKYNVjPBSyRegVYIHcfb1OnxxmQFh0sg4XoWBUySp5cQqS/tqPK+DO
         LfeQ==
X-Gm-Message-State: AFq9FYI9A1Ge7EFy2EFVEFCikhz5pB7XAf2fbcHNStT97YKK5XGI6BpS
	kHcoZcI/mU3TRGvjFriF8Dofuqnobo4M+0qO4naLczWqNACc2zLziedcxWCX4NkTDg63NxCLHMg
	O2ZNiEVsN6IHG5r3531aD64DHkIjM4lXegg==
X-Gm-Gg: AYBFou3JYkceTjEKTQZtnkxlGg/8fQQonRp7FYT7cmf4IVZkJU1ii9HZgdx/dUaUT/l
	KK8YwRvQtke+b2NOfIbko+XK742WIM3ZyuTTkxDslOLQdomaLQGrjdBDJWirOMxFiy3a+e/aXwI
	T1yzCuH3xC/Auv6/f6U7L+sd6SwQUvpOwtguZnIMsajoy+QR/fQ4EYcNNyY10CKkPx2fzjArZgg
	RtGF1GH8nwR1nROC8do+vNbnfeRMbzaqPRNQ2K7maS8qt2Mgf4gbENlyprAMGCzS9RYI+aG01Ru
	VtpJFvkRar8KoiAGZ+KbeQFs0vHRHd0A6uSgERDOMUJ9HHlrytkfvknzmu5L3WFmvyRpZ6U3SxG
	9cXeJLI4KG+i5v9jzVQfn65KSTWYNmAauxM/x
X-Received: by 2002:a05:651c:1543:b0:3a7:6d4a:1c9f with SMTP id
 38308e7fff4ca-3ab292ab231mr19307701fa.15.1792419843840; Mon, 19 Oct 2026
 07:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260929081349.3858049-1-martin.jansa@gmail.com>
In-Reply-To: <20260929081349.3858049-1-martin.jansa@gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 19 Oct 2026 16:23:44 +0200
X-Gm-Features: AclHuK-MtlMhjhsSUXVxe4kc6t_874q-rkuWzIZggvl0HqRf5-uzUgNWLc5uaZ0
Message-ID: <CA+chaQejuGizpQ7q0UPaLvPsc8PZhEYAanhwUPbS9=LJBmfDkQ@mail.gmail.com>
Subject: Re: [meta-tensorflow][PATCH] layer.conf: Update to blacksail release
To: yocto-patches@lists.yoctoproject.org, hongxujia83@gmail.com, 
	jiahongxujia@163.com, jiahongxu_hycx@cetc.com.cn
Cc: hongxu.jia@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 14:24:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5097

ping

On Tue, Sep 29, 2026 at 10:13=E2=80=AFAM <martin.jansa@gmail.com> wrote:
>
> From: Martin Jansa <martin.jansa@gmail.com>
>
> Changed in:
> https://git.openembedded.org/openembedded-core/commit/?h=3Dblacksail&id=
=3D37623ffbdd34a5c6b3e12ee33195f8e82343f198
>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>  conf/layer.conf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/conf/layer.conf b/conf/layer.conf
> index c3bd464..bad8eb1 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -11,7 +11,7 @@ BBFILE_PRIORITY_meta-tensorflow =3D "10"
>
>  LAYERVERSION_meta-tensorflow =3D "1"
>
> -LAYERSERIES_COMPAT_meta-tensorflow =3D "wrynose"
> +LAYERSERIES_COMPAT_meta-tensorflow =3D "blacksail"
>
>  LAYERDEPENDS_meta-tensorflow =3D " \
>      core \

