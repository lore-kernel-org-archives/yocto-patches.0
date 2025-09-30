Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2049CAC5B9
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 02:59:36 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web10.16460.1759201170994287154
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 19:59:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=heNieXk3;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: raj.khem@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d6014810fso57039847b3.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 19:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759201170; x=1759805970; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2VpH1TS3MHHnq1AbczxAYJB94rHJzynNxFEaWN2+Zk=;
        b=heNieXk3BsYTj33CVXbQ6q3qkbCoEAW4gB2XTiDxlBiZPXek8mKcJBy6q7zAYZrLfd
         jzPtGSoTzWDxsGwRdxIQ3EV6dNPE5cUuzt5I6k/4SZ8x6C11Ea0vFOXszuVluKacZzX3
         rBr52aje0cqQrUOzWmwlbFf31afL0BMkOGy4F6qraWpBSf/0VOJSevtE9j8FfdUA9L4H
         ybJI0bc+4JmXWUEu4LwECyzk/AfV2wF/UB1tunwgpmTP0+3PIZQYWqrb0JZRqda04Uf0
         Y41NOvld4WXCTCRh3LgEev1HoXRJhEuOIUH5xFx8n7yIjkQ/3MM/+IGXb/lK8Qncu0uu
         /7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759201170; x=1759805970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2VpH1TS3MHHnq1AbczxAYJB94rHJzynNxFEaWN2+Zk=;
        b=Jz9DHsgdPUGhM0pW12I4pxYiGA0CPgOa8QDlxXzY28fQ4tAR/JTHZDc2NwbBIwfVfB
         f2LLvpsExsABYltVOgU0dTXexQU18P09bNbyyuH2DWLouMK4zxJM575peYQfa1AV4l5U
         ywgkqhwFZMHnvE5JLlaL1ht1q8YbgmyQCP4z6jgzMwUhWwdSI9UmTgRcJ3V/rttjI2bY
         P/e8qciK+qOQeDXfqTU8oMY0ER42EuNQGJWZn01QMsfegLWwFL9grkokUjQdibA/I4ER
         2HX6ZNmhg+1gYgcsh27FZeaZ+ETseq1Un8v89Wpg10aeJnfx+t6XPZSzeYvQkqSKiSOc
         /EHQ==
X-Gm-Message-State: AOJu0YyVUgeoWBq6CVFBoYcptt/6c1iszSecJjUSV4Ewf9sAXjstj9BO
	YpCbE3SkJTa1080u03Yrb+xVlW8mYUfVWe1tk+52Uj5b3mn598rNhLvum+M8O5j7AeuNWy5GpOu
	lqGqVXJuM1zl/C0iKc3kRYP3luRdVjiY=
X-Gm-Gg: ASbGncvWYvZQsMvDdcXnxAjRo2RsdR0srwuk7W6Xwj/vsG+3QX/TQDly4Qek7o3F/an
	kWea5Mff7w5laRYxl3WgE/htjhuKTqrYhNuRclMGl9SzZOrS0C60fueSuCaBrbPXGBwibv8Y0ai
	JrMuDkuXI8g5Pnva4626UDeMY/Gp2C6g+SoUXmTRY4LbXxVCyD8c8CmmSpavR6IQc3Ub0zDi4je
	RPHDSJF8Mjw7vfLX0OEDS5JwvYByz7Wy9qLCzObBnf86RNtB2VXGWAVScNvj+cTiamDY6FinOr3
	igzdK55jTty9pNySETBgpqUepeC+jdJCLWOcmtAbG5wxaLo=
X-Google-Smtp-Source: AGHT+IFTCzUuMOROY/T1QPpjqRQNHErfyEAsGLdUnTQDBVWtxt1dSOifCxIiv5+z3DkS/cJmA89u15mEzg0/9cg2dZk=
X-Received: by 2002:a05:690e:259c:b0:635:4ecd:75a2 with SMTP id
 956f58d0204a3-6361a8ab4dcmr16656312d50.48.1759201170056; Mon, 29 Sep 2025
 19:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250929045007.12623-1-vanusuri@mvista.com> <20250929045007.12623-3-vanusuri@mvista.com>
 <CAMKF1spJZ6Y1XxG-86ROPPwbGp2gzyb0xX6R1H0hG0y0DRq4tg@mail.gmail.com> <CANQUz1_H7qfd10auFPr4dBXvyCdGtsn9dgM+0fsWav3n=8VTeA@mail.gmail.com>
In-Reply-To: <CANQUz1_H7qfd10auFPr4dBXvyCdGtsn9dgM+0fsWav3n=8VTeA@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 29 Sep 2025 19:59:03 -0700
X-Gm-Features: AS18NWDGAQNYYTw-PWjJ04MWxkjzrX1EeP79StW_3Om61qBVOeGmh40TQbpyYq8
Message-ID: <CAMKF1srK7AZFg36EJ8W8Ti-VcxznC3f_p4RzBHxLq0Z9uEtT-w@mail.gmail.com>
Subject: Re: [yocto-patches][meta-cgl][PATCH 3/3] ucarp: Fix the permissions
To: Vijay Anusuri <vanusuri@mvista.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 02:59:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2255

On Mon, Sep 29, 2025 at 6:16=E2=80=AFPM Vijay Anusuri <vanusuri@mvista.com>=
 wrote:
>
> Hi Khem,
>
> The Makefile.in.in file inside the po/ directory had read-only permission=
s (0444), even for the file owner. During the build, the process attempted =
to copy and overwrite this file but failed due to lack of write permissions=
.
>
> I updated the permissions to grant write access so that the build process=
 could proceed successfully.
>
> Below is the error snippet
>
>
> | NOTE: List of Makefile.in.ins to update: /home/xxx/project/yocto_master=
/poky/build/tmp/work/x86-64-v3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5.2/p=
o/Makefile.in.in
> | NOTE: Executing: cp /home/xxx/project/yocto_master/poky/build/tmp/work/=
x86-64-v3-poky-linux/ucarp/1.5.2/recipe-sysroot-native/usr/share/gettext/po=
/Makefile.in.in /home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v=
3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5.2/po/
> | cp: cannot create regular file '/home/xxx/project/yocto_master/poky/bui=
ld/tmp/work/x86-64-v3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5.2/po/Makefil=
e.in.in': Permission denied
>

Good. It will be nice to add this context in the commit message.

>
> Thanks & Regards,
> Vijay
>
> On Tue, Sep 30, 2025 at 12:26=E2=80=AFAM Khem Raj <raj.khem@gmail.com> wr=
ote:
>>
>> On Sun, Sep 28, 2025 at 9:50=E2=80=AFPM Vijay Anusuri via
>> lists.yoctoproject.org <vanusuri=3Dmvista.com@lists.yoctoproject.org>
>> wrote:
>> >
>> > From: Vijay Anusuri <vanusuri@mvista.com>
>> >
>> > Gave write permission to po
>> > List of Makefile.in.ins to update po/Makefile.in.in
>> >
>> > Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
>> > ---
>> >  meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb b/meta-c=
gl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
>> > index d221814..8a2737b 100644
>> > --- a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
>> > +++ b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
>> > @@ -42,6 +42,10 @@ EXTRA_OECONF +=3D "--sysconfdir=3D${sysconfdir}/${B=
PN}"
>> >  # fix the perms for config.rpath
>> >  do_configure:prepend() {
>> >      chmod 755 ${S}/config.rpath
>> > +    # Make sure po directory is writable by current user
>>
>> Why should it be writable ?
>>
>> > +    if [ -d "${S}/po" ]; then
>> > +        chmod -R u+rw ${S}/po
>> > +    fi
>> >  }
>> >
>> >  do_install:append() {
>> > --
>> > 2.25.1
>> >
>> >
>> >
>> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> > Links: You receive all messages sent to this group.
>> > View/Reply Online (#2248): https://lists.yoctoproject.org/g/yocto-patc=
hes/message/2248
>> > Mute This Topic: https://lists.yoctoproject.org/mt/115490482/1997914
>> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
>> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1334=
0786/1997914/645821814/xyzzy [raj.khem@gmail.com]
>> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> >
>> >

