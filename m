Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAECED7B8A
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 08:26:43 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13992.1776155194805219793
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Apr 2026 01:26:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nns8y3Uj;
 spf=pass (domain: gmail.com, ip: 209.85.208.177, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38dd575bca3so52222311fa.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 01:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776155193; cv=none;
        d=google.com; s=arc-20240605;
        b=Amkw1bzoyo4pBegd4laJ0cfbBvV8X48WuNNujSwe9OXY9sURn2xv81O2YYP5/1827L
         UPzfsgDRLXg8pB34d7Quw7mvK2a24UMsrds334zGhYUkBzTBlpFcp7jC8Ej4wwHLkO0O
         +lB9fC9/BxswO7WGDm5BkpGUNoP8v4MJ05qnBj5V8/hkHvBSdit4tb7HczGa+ZpJVkaD
         H3asGouc7olMBEO31tG7BIZxMqwhGME0nO1FmCwAbwfAzmCx0YeUI/527PdUsUWpbePl
         kpLcuEUJ4K9kxdq1if+fyysMIZ+ELYzLNFvUa4x1D1W6QqLLC28FLbDo3c48hdCN20QG
         xKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ScZBiCqMppKjZN2EphBmcJjgnJb6a6dfBwFdDiQeAog=;
        fh=LoaB1U3gh/ajfAkcpZh9MirUlI9pGDlrGSOrYUmQroc=;
        b=LJSU1GMy7gMae5rk5Tp+IhGZxHRY34yD3Z6HJpybIMXTP4HP8NG+JhIqr93AVMkbFD
         K2wkApfmnrHrLGW5jEF6AiJo6tzbYlkDAwGfCRg+I5B/UTw2uYLywqTfu3E9aJl0s49c
         MmbuATL7vAZ4Te9KpTRM4CVKwPgw4nvW8iZXemjBOE7RfQg91Pv6ChkuXbCe9xmr0Yw+
         KdzD8zr18C8SCzafkm9Y+9YLmS/y0EZl0eckbT3jklL8Du4ghamUlf9WNENnRK0TfylP
         5X1GVTYLq8vrVEps+QFovzNdFKyZYGg2FytIVgcbmoASxx8nUX/AdlOkLQs0DuRUz8aS
         TFbw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776155193; x=1776759993; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScZBiCqMppKjZN2EphBmcJjgnJb6a6dfBwFdDiQeAog=;
        b=nns8y3UjhfQoV4UL8Pudaalyw0SWIrCCgwC0WNuBn6DjZwicII8PcRsUFVcFlGW2TM
         ro4pERjUynffmK4S6FeXLV0x8n4bdS3wVBrmysxMrJeXHLacxO+onvsqOCnP/j/LQ289
         f+LIXqgJEQnwftoipb5YoZNyMSEDVoGrfs6GVKj+I3CcYQvwGmS0rP80oNE59Q4SWFsS
         gierHGiSItnX/TrAusxn9lnOinSxLKIhnJ0qZBnRSpmExU5VB4gTJHrRERoOwlzvFKyI
         9PHGJ0IrrQaNYVRwUboTpOQmFAKnEImv8YJQv855MW6O1n9841MO4EXf45uiqVMsQ0mz
         SEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776155193; x=1776759993;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ScZBiCqMppKjZN2EphBmcJjgnJb6a6dfBwFdDiQeAog=;
        b=RiCFEkJrnbDiZvTs2U4sO6CsdtZ5vNLvfNi15GG9kN2TNJhSuYFWafcl/BWDBNCvGl
         ymmIocfVXowZKu1LZH3eaVSvpD33I4+ZuNYVEunsNQCNmbjxz0hf9ORWAYmssich/0rO
         yIv12FKPTUOb1CKsBr9GufGy8LZaTqxQYUdGMdV3gH9QeHJ4N1IexHCn96BrJ7h0+KSg
         /pHdABoThbLYf+T0+GF33ajvnZNzLMFWWQSN5jKLhVjbklgeyaU795zb4Y/ysWj6mSpd
         Y73Xlle5TSlXpdS2aeGZT6dljLDL+TVRje3G4AYf+oUZafh5ZcghDsFICmjKJd8mQxOB
         wjtw==
X-Gm-Message-State: AOJu0YyRupTKqJsImwpctSXt1mJ2FMEhL6AIZiU1EhBA7LsMbf3Fgj9K
	TTGio2t+aredu3aftbk5CwBphEO2nmVtCGPcO/VB/Q16PU4hr86ggJqo5TD4RlPpGz1OOV0XzAf
	wrXdhK+3m1lhJ1UbtzvSSK2nP7SEUeGgNlfAA
X-Gm-Gg: AeBDietOhWJ7TAqPG7LkrhmLQWt1J8cJyLd/Y+fQCq5Fq4QabKSI+5asB0HLpwnfB4l
	adEWDOTBvbfx5nyeK+Tlgr2+/LFnSnSlIQC3HKkVl+pa7uOkuaTwgHQ85kQlerrSE8nX+iyRvFE
	gy8Fy15lX8O2v2e9ok8Q082B4gZ7N55LH/6x4uYgkA53+Y17mYJ2uf2+LWW3pVLZ+IN0cMUTj/d
	FMktxC5m1+z8+2a7nKQaEMRIDJdSfS3oqfcA4r7MkMXQ16TSDQNKhd4TEfIamqy+yLpRkMTCVj3
	jXx5UJDv8CZgmLUZFY8o/itPTE7ZWslHDxAFLL/ItMexq+B6m+6yEln04JOTcwfjVZ6HyiDYnAK
	U
X-Received: by 2002:a05:6512:128a:b0:5a4:156:aea3 with SMTP id
 2adb3069b0e04-5a40156b048mr1395934e87.7.1776155192375; Tue, 14 Apr 2026
 01:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <18A45B2EA8F8EC11.657799@lists.yoctoproject.org>
In-Reply-To: <18A45B2EA8F8EC11.657799@lists.yoctoproject.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 14 Apr 2026 10:26:20 +0200
X-Gm-Features: AQROBzD-qORDm0yf_IPSNpS9LKsuFIkcnftQQrqrHqEoTJkebFEq6uXDGIBB6aM
Message-ID: <CA+chaQeUfObYUY=iKFdz5YmZkCq8bp9Ex44uqn4Xf8VTgo=w5w@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH] wic: move to files/wic
To: yocto-patches@lists.yoctoproject.org, 
	Marta Rybczynska <rybczynska@gmail.com>, Scott Murray <scott.murray@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 08:26:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3700

Gentle ping as the builds cannot be started with recent oe-core (since
last week) when meta-security is included.

oe-core $ bitbake -k ovmf-native
NOTE: Started PRServer with DBfile:
/OE/build/oe-core/cache/prserv.sqlite3, Address: 127.0.0.1:36907, PID:
407062
ERROR:  OE-core's config sanity checker detected a potential misconfigurati=
on.
    Either fix the cause of this error or at your own risk disable the
checker (see sanity.conf).
    Following is the list of potential problems / advisories:

    wic/wks files at /OE/build/oe-core/meta-security/wic need to be
moved to files/wic within the layer to be found/used
wic/wks files at /OE/build/oe-core/meta-security/wic need to be moved
to files/wic within the layer to be found/used

Cheers,

On Wed, Apr 8, 2026 at 12:33=E2=80=AFPM Martin Jansa via
lists.yoctoproject.org <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
wrote:
>
> From: Martin Jansa <martin.jansa@gmail.com>
>
> To avoid sanity check failure
> https://git.openembedded.org/openembedded-core/commit/?id=3D07e410600c411=
03098b670f12abe87f64419a624
>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>  {wic =3D> files/wic}/beaglebone-yocto-verity.wks.in        | 0
>  {wic =3D> files/wic}/systemd-bootdisk-dmverity-hash.wks.in | 0
>  {wic =3D> files/wic}/systemd-bootdisk-dmverity.wks.in      | 0
>  3 files changed, 0 insertions(+), 0 deletions(-)
>  rename {wic =3D> files/wic}/beaglebone-yocto-verity.wks.in (100%)
>  rename {wic =3D> files/wic}/systemd-bootdisk-dmverity-hash.wks.in (100%)
>  rename {wic =3D> files/wic}/systemd-bootdisk-dmverity.wks.in (100%)
>
> diff --git a/wic/beaglebone-yocto-verity.wks.in b/files/wic/beaglebone-yo=
cto-verity.wks.in
> similarity index 100%
> rename from wic/beaglebone-yocto-verity.wks.in
> rename to files/wic/beaglebone-yocto-verity.wks.in
> diff --git a/wic/systemd-bootdisk-dmverity-hash.wks.in b/files/wic/system=
d-bootdisk-dmverity-hash.wks.in
> similarity index 100%
> rename from wic/systemd-bootdisk-dmverity-hash.wks.in
> rename to files/wic/systemd-bootdisk-dmverity-hash.wks.in
> diff --git a/wic/systemd-bootdisk-dmverity.wks.in b/files/wic/systemd-boo=
tdisk-dmverity.wks.in
> similarity index 100%
> rename from wic/systemd-bootdisk-dmverity.wks.in
> rename to files/wic/systemd-bootdisk-dmverity.wks.in
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3662): https://lists.yoctoproject.org/g/yocto-patches=
/message/3662
> Mute This Topic: https://lists.yoctoproject.org/mt/118722653/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

