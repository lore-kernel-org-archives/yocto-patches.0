Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4A7C25B10
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 11:04:19 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.57517.1715598249991955809
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 04:04:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fAb4JZR3;
 spf=pass (domain: gmail.com, ip: 209.85.167.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f3761c96aso4927335e87.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 04:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715598248; x=1716203048; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6M6+YhW/H7AF4nu4LQ7VolqB+HYCt71s4ptaNaC1m4o=;
        b=fAb4JZR3qFIPWNPv83X4JNggiGcPF3LH4V9+VG3yBmgjoDOYdxL1woyccRjlIW05Nv
         48LRxg6G174I1xR2hCAGIesgQCuDRU7SzAs4BilNHNxxLwME/DY0pVN/j3l9E7vi48BF
         zrKtH1tc5XdisgVbrU+cNQWY3TttWkJzpTBKoao9I8oIqX+AfC9LoSVx4WsC/wlXCNoq
         sZ2Fji3OwJyajBd2VNo3yAAKOvNCFpGZMluCWWS399NAvvSHe2GrX0R+7ItIw2lNKCGV
         kah9YyHqsrNJAu2XNc+mWyG8tMPyRHwQMUhmvYv1ssKz1tuzuc9aZ4wEL5D3Xay4Xdy3
         7Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715598248; x=1716203048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6M6+YhW/H7AF4nu4LQ7VolqB+HYCt71s4ptaNaC1m4o=;
        b=Ch374I+5U/7vR2RwQ1FcwVmuWIOkDVfwRAswA+IsZJuwFLfRu3L0KXiW25A2ideoAv
         M691CmBMiVczXitvtdbm8lfTaKXm74NAEyj+4hsVR5vabuGI0u8gpJk0yfiMebFn1Sy6
         hLaXstij2bQ9ULyltwqq/1CJwi0mNWpHOwzsNqPpFL94lStadF6/ZY6wKp2yUKHkX44x
         +/yMUN9Jqwx91pNSEqAiyO9iUmxmXihq+YzQOXAr7cfVLVIPvRnvQIjFmay51XyAzJDf
         Zw/pDyatsCqsfkiwZdJ0LW2mNw/lKEQ4Y/5NGw8/qUMExxVnPmkq+rHKBI6+fG04kkEP
         8G4A==
X-Gm-Message-State: AOJu0YwvTe35e5rq5uYBU6SL4pMNp6oXxI5Yagy0xY94ekeViSfOHx0j
	YzoIeuukllgdlTgzjnI0F7UEx6am5YRYfIyF13rt4k/o07qA361S1hvCzFX050xevUClJus1Fr0
	23UYrdDsf9O5kUgI6RQQraPXYadShVtQc
X-Google-Smtp-Source: AGHT+IEC3AFox5ocnX91FeP2xP8SU8YnNzBX75JlwjyVb+KLoVe80Rs1ICxAnNb6/jS/2MihaMndAdrZ/SuH2WukGh4=
X-Received: by 2002:ac2:5a50:0:b0:523:35a5:5f19 with SMTP id
 2adb3069b0e04-52335a55f81mr2015399e87.34.1715598247765; Mon, 13 May 2024
 04:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
 <20240508153131.94270-3-ninette@thehoodiefirm.com> <3ebe931181412a352eb719d19cee95b0f2eebe23.camel@linuxfoundation.org>
 <CAG1aeW0ySPCCTd040nwjB0VEptrPdECrfLTCrG2OULEo7fChUA@mail.gmail.com>
In-Reply-To: <CAG1aeW0ySPCCTd040nwjB0VEptrPdECrfLTCrG2OULEo7fChUA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 13 May 2024 13:03:56 +0200
Message-ID: <CANNYZj-ZRf-Ea6R5VN9XYdJivjN4rjW5ZOaCFWxOL8-vJXjoFg@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH 02/12] patch-status: add README.md file
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, engineering@neighbourhood.ie, 
	Alex Feyerke <hello@alexfeyerke.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 11:04:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/118

They came through empty for me too. And you can see that on the
mailing list archive:

https://lists.yoctoproject.org/g/yocto-patches/message/93

Try sending them to an external private email first.

Alex

On Mon, 13 May 2024 at 12:58, Ninette Adhikari via
lists.yoctoproject.org
<ninette=3Dthehoodiefirm.com@lists.yoctoproject.org> wrote:
>
> Hi Richard,
>
> This is really strange that the patches are coming through as empty for y=
ou. Sorry about that! Just to be sure that we understood correctly do you m=
ean your email client actually doesn=E2=80=99t display the patches? because=
 we can see them in the email you replied to.
> I followed this documentation to send the patches and it worked fine for =
previous patches. We have also pushed the patches to the yocto metrics cont=
ributors branch in case you can't view the email patches.
>
> Please let me know if there is any other way to share the patches or if I=
 should rensend the patches. Thanks so much!
>
> Best,
> Ninette
>
> On Thu, May 9, 2024 at 12:53=E2=80=AFPM Richard Purdie <richard.purdie@li=
nuxfoundation.org> wrote:
>>
>> On Wed, 2024-05-08 at 17:31 +0200, Ninette Adhikari via lists.yoctoproje=
ct.org wrote:
>> >
>> >
>> >
>>
>>
>> This patch and patches 4, 7 and 8 all appeared to come through as empty
>> unfortunately (messages with nothing in them other than the list
>> footer).
>>
>> Any idea what happened to them?
>>
>> Cheers,
>>
>> Richard
>>
>>
>>
>
> _._,_._,_
> ________________________________
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#117) | Reply To Group | Reply To Sender | Mute This T=
opic | New Topic
> Your Subscription | Contact Group Owner | Unsubscribe [alex.kanavin@gmail=
.com]
>
> _._,_._,_

