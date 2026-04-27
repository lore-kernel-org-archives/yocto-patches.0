Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E587FF8861
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 09:37:49 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40044.1777282668768145857
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 02:37:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WtD2Fkdn;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8eae9229110so1344495785a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777282668; cv=none;
        d=google.com; s=arc-20240605;
        b=Jp9CBKjX2p6QDt7dIvYWHAJ2kMLeTrS7lSt/SmqVhvsG8Fw+jzPiuUqWeCwTVUj3+J
         i8DqdpU92/sIwD5qeRo4EYBmT5Hv4hHuYWCDqYUgPBOSoQtdt1cEteuQFK+I5Xy3O8Dm
         qz3BWsTalxYLSV66IQ9l9SQKIslA0XKuirqASTVzs7WpfdnDKKWd6hjsmiYSAOfv8z71
         UsFTMmgr79JATWPsAgC0kc71gs4M2b/2d3uiq9H+9n3O/umT2yKeoao2aT38uYQmraD9
         2JXhL5jJ8Y5SUAOmCuv80bpvQsjsWa4BqpkyZ0wCUB0WHOs86hE8wDayMhr27Z6D23jd
         Qcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eyvw5EUblJI3kU13HbWZ0f53+tSF64C0RxzhG1eNqz8=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=AYk1ImnE0V9TqqkYTZ3C8aTco/0dPd7AqKsm0PPU6Qv5wiEw88ciyyrfucfkrAQTaL
         6iQM7YPeQQ/lfMVJrZTLCxkyrrEBJtk3AsIXbqGuhJ8T+7zoYG4UZ1giuQvB195bXRzg
         hNd2fWA/j0sWBOE+ECFZkdATKqJgsOhd2tALqdJYi3UNsHGtOhD3SRG7pEr3S8oBnW1z
         Jp5by/Sv2V9ooskQbYBVeYwaVEMWSYP9v0nunDryL/ixt1AOaWg5V95vWqqJD/9NJY3h
         tA4/cigc0Dl3QoeG7EpSEaDgEkALrupYLKDcpFUC63rEqrqVJgM8LlOPbYuOmxTzYVE6
         +bhg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777282668; x=1777887468; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyvw5EUblJI3kU13HbWZ0f53+tSF64C0RxzhG1eNqz8=;
        b=WtD2FkdnWU183v0F+pza4X0WyYNrTZ+jgTlshn8VKnluoHiRiLzasoBMftQ9aBcQtN
         1gsu50gBraZ3oko2BEh8y//PQXjtRdHI2mSs9Oi8eMvnUNnCIqedYFwrBmjOSLGo2ciY
         7UStH7C3VXev4d0Zbo7U5ai0SdJdqm1ALx6qQepmC1Y2ZM9AuhLvKgKw5dcTyDooG/NL
         CY7TzvF6hdYyN09pV9pDs7Ej5dyBoQEEfEiDG6Ef06qln+sD+n4dyA9eUYhf0FMk//mr
         tts8Dh5igIoRsRNW8eJ0ioJAi2Fcqb/ATOCZisiSQtS0wISuqWNIac8k1JawhVB/L6lV
         kPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282668; x=1777887468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eyvw5EUblJI3kU13HbWZ0f53+tSF64C0RxzhG1eNqz8=;
        b=FDN2KwNOyEGo30GhRdBmlvi2hrtvqtpgEmWYHDbIPHZKzc2KdgLJfR5bMsLSNppbV7
         9JBL+BJadbww0i+FBHCqsxnRmKT/NS3jggoRu8xIZj6L3ukrP3/nx5JXTlpALpSAwS9F
         /aIrHWUcn+qxMqM1aZXk/6eJVYmalh+8fkLK0e//hzquC4/IhCOJFn5hdXFsqorMZ1WX
         sZcGpM4tmKaL3HRIyE6EvQ8SNoTox7tfncgG8Z1YfNZ5zJNRA2sdiBj8Qq8CdtBfmcDk
         9ZWItJq8q71au4u8LQe3GMWCv+3T8VEIlunjG7MavSRt3JUB8cPMCeRoajLcZsbEvWSR
         sRpw==
X-Gm-Message-State: AOJu0YzIH9v1tDLCoosfaKjGwn90INUdi2M0S3Y+OoLDGLzBVE2RPPgd
	qXfDog4e5AxLn/mXx5FsgJcUIX5IFikrEgKqacZdATR/0wadOApLRjkHgO1DYLiTGq95vmYa/zn
	5kYgdtYznFsroAGh7AaSajgaEZeAAOsw=
X-Gm-Gg: AeBDieu+OiTaupw3fxJU4/yiM5t2C67ZzBew6xNLGdKkFAoGa2FX/cH/MxhdXIZhdsi
	I7zkMejG5kQf6SvWh4yTW+ylWYh+NEDaEDkRkKSJwFgTWL7kZnhIflqnOwy7pO7lQekWN3blTQb
	SeTHmPTSTHIk76QaDLmgL7GN4Oojy10ZaD+xjSwOin53ge7tqTsKgASsg+A6zP8Tys6fjoJgUIj
	cNDJzP8r9hp1pHo/7aSF0TfDN187mIfNzGIwIdLiHP/EMEhNaafSoGgOc2oMQC/OLOGU66jJyDw
	3W+oBmXRG5OMpEH+ulOc5aRD62omEc9v5k83iSWdPLLFPNmnPJOw6i0JmgM5ed8=
X-Received: by 2002:a05:6214:29e9:b0:89c:6bbd:76d8 with SMTP id
 6a1803df08f44-8b0280b2f12mr646351596d6.19.1777282667554; Mon, 27 Apr 2026
 02:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com> <20260424114603.2444938-3-daniel.turull@ericsson.com>
In-Reply-To: <20260424114603.2444938-3-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Apr 2026 11:37:36 +0200
X-Gm-Features: AVHnY4KBtHUDzJcGBINo0R1rx4MsKXeH8bz8sLt-RHjrmaXkgvLmoI3_tMeMca0
Message-ID: <CANNYZj-CXDd1uA7d2e7tvfPzNo4-D6u4dRzAwFEShn_mX_mrFw@mail.gmail.com>
Subject: Re: [AUH][PATCH v2 2/9] upgrade-helper.py: Handle fetch errors
 gracefully during version scan
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 09:37:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3831

On Fri, 24 Apr 2026 at 13:46, <daniel.turull@ericsson.com> wrote:
> Materialise the iterator from get_recipe_upgrade_status into a list,
> catching any exception that terminates the iterator early. A single
> unreachable upstream (e.g. git.savannah.gnu.org down) no longer
> aborts the entire scan =E2=80=94 the recipes collected so far are still
> processed.

I'd like to see the particular error that results in this happening
and fix it at the source. The get_recipe_upgrade_status() function is
not supposed to abort like this, and for any upstream network issues
it should be returning UNKNOWN_BROKEN status for that particular
recipe.

Alex

