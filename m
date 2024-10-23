Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC43CDDE5D
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:24:30 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.5644.1729679066702543471
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Oct 2024 03:24:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kKrMD1xU;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so5950865e87.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 03:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729679065; x=1730283865; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zE/1JH9mu286yarSyEcBv7X1w8j2SGBSN1Vax2g16Ms=;
        b=kKrMD1xU1v3d/Ey+LolHj49psDFN/bQsBSn8Gz1t/MIgU+/0zykIL0z99gIa8ezabK
         pLvUtn18OP8zenUvVRuDCTAp4iDhP3hw0WirCqWAJOD76ZPtGC9MxKhzqOSTmeqaGG4d
         3232fU8nFBfrYnRTX735RUq3q0hIORBMTnzuAThHhhd7xZLJTGMxRW47+Xd0+mhL/b6H
         DZdo1XeGGxH7FtBaqbsR+UjlzXEjyRN2arfldACsY5vosdjiXxbkA/RdKJY0X8eYQM57
         TrHF7L6b+ZDhFf18oOKgsES/Vhh64ddC3+5cxYQvI02xpV2cIgLwr0uUvuPDEVigRLDb
         OqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679065; x=1730283865;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zE/1JH9mu286yarSyEcBv7X1w8j2SGBSN1Vax2g16Ms=;
        b=H1CMXM+cC3mMJk3vJZFwmmuYeEk85dvW+fqUwZG1xbGp33G0Q0qKOKtx+QwxorTkMj
         zZ/nS0N/Q2wXj8avVSKOsJ+YUqXxuqio/N/pCfuqkuCtUJGiF39QqEVH5+QxbJxF1QV9
         TK8Cff9qMGn5skqugEPqUmgL8hGDb9nzCceQeLK27ksv6V5uzpssJagDflCIGhx7/Hcc
         7fduyszqU76Qc8jmD7/aVZ7+cJc+kAW8QGUACoGxcK6wf3et43QaFVqzPUNt3hzqZUAG
         WNwkoqbt8/WwpIviPrFxSa98fBOgHq0fvpb31k50b2KxDzdXBj+KknQzhYpT4SQTGXZi
         rChQ==
X-Gm-Message-State: AOJu0Yyji3xKhxFQ08rOtR9rjy/3Ew+j0t5eZh5H/24UfWt7aN/2csD0
	zV3NDJzOZGLAuKVgCZDTO4QnCrh7eOdaHj7P4AWp7fDrrPiF974ZbIv25uRdHqQZgzShe8C0ILx
	2Jdqsy0D/6CdzuUFg+JTXH+HhRYDfhg==
X-Google-Smtp-Source: AGHT+IFWzMssZQpIDd9pOQYaKYbuRl4pNrPzCfkzikBEcn0bKWe2YcLQqwS/Y1WwdmomPa4/veofx01dYNc5RD2nYqY=
X-Received: by 2002:a05:6512:3da1:b0:539:fd75:2b88 with SMTP id
 2adb3069b0e04-53b1a3735c7mr1064368e87.60.1729679064400; Wed, 23 Oct 2024
 03:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj-YHx0Hw_GGPWMruF2+vp5CWe6yyxPMqPGBSx-S6Mk=Yg@mail.gmail.com>
 <17198.1729678370250194557@lists.yoctoproject.org>
In-Reply-To: <17198.1729678370250194557@lists.yoctoproject.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 23 Oct 2024 12:24:13 +0200
Message-ID: <CANNYZj8CNhBQeKm+=RZggx60cfDnN-17Gx9goCq__+D-Nvj--w@mail.gmail.com>
Subject: Re: [yocto-patches] [matchbox-panel-2 v2] panel: added sysfs support
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 10:24:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/734

On Wed, 23 Oct 2024 at 12:12, Dixit Parmar via lists.yoctoproject.org
<dixitparmar19=3Dgmail.com@lists.yoctoproject.org> wrote:
> Thank you for review. from what I understood from your comment,
> The file[battery-sysfs.c] was created solely by me as an individual contr=
ibutor, out of my work duties with my employer.
> The file header(along with copyright details) is copied straight away fro=
m the same codebase's existing file: https://git.yoctoproject.org/matchbox-=
panel-2/tree/applets/battery/battery-acpi.c. I am not good with the licensi=
ng terms, so I am not exactly sure what the correct one should be. Pls guid=
e me for correct header.

I think
(C) Dixit Parmar
is fine. No need for the year.

Alex

