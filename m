Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A22FF885A
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 09:25:34 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34920.1777973133609786869
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 May 2026 02:25:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=MhkyesbG;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ef0ba61d46so571385585a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 02:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777973132; cv=none;
        d=google.com; s=arc-20240605;
        b=ViyYwwkllY/ClVCreo+uEzc7FOI1ksJpWM/hMjvFRakwKc1ofQ42Eg7hcZWI5R4+Nc
         +6VKqwvUkxpAFh8O5qfmaYCzJ+HEfug31FXPk1pS6HpqcUK4DTHfFmrPK38hdICoNLTF
         pJwZ2Q68qtuWBKuMpdW6iMbLtVqPKQL5WLY6EBFAF+4yp+F2GAhcZI1adOTJhc6N7Zz7
         +c8g3cOVK53MhYsv5je27bElCe1w86md/WDteQxOav8GSXo4n+1rshBV9JYeSoSYnUXB
         LMbk2IwJWV8DJY2go8JNxznbVFvUxl3RgGi9Y+4CFtjgOvlhoEiZLOhURmipYBGZyAZx
         77IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g89+ZXdrv2HwDVtTUJW6LEoVLUnEgjDOkUkZiBWX9R4=;
        fh=5f3juoVmFZAcDZXxw6MpSCyKznmuK5IWEecktzwNVBw=;
        b=WiJ4yt+jPeYLIbD12LzKnefiRJbWwb0Yeni6FK57i6a8Dg0kenjz883ADdj+AEoW+p
         8XutGT6NYM9ciI8hyGy6SzMyPEmCmSRUVusoXmWZCoAxfEvdDGqaEXZ8ralrxsBVE2kF
         zJ6+DAvBNyrXC1NPBydJEXwkRmVuE9plfsv064YgSR20X/UuNtipNOl0ecF6z7WFZPIt
         Nv08okz74ZKJl7qArP9oUcfnklCvyIH3aCFyoPM4FswpaX6dCt4mUBl0lGUvYb9p3afY
         1yz0tCl3DcqlvYsDO1K23NCgI69vrdpIhWhN0XOiyNdi/E165lG7RRbfVYsnKs+c/zhx
         qV3A==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777973132; x=1778577932; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g89+ZXdrv2HwDVtTUJW6LEoVLUnEgjDOkUkZiBWX9R4=;
        b=MhkyesbGh4OM+YXgp0dtejh4W6+aAwdE0rsIbw5QGVMaWKdECYCELmdYLSchAM0/5d
         UZh0zG/U/GaNyyal+SA4bNXgOV8xAS767HmL+PrWiglkervTi6obvfO44YdCAd9/7NW5
         cvoBFcnHKYQ90tABbgn3fx0OWk+kZ6zSoADh47ISplUEcuyue87QmH5S8ga37dIRcOh0
         6i0nkdbkPDSXqRCQuaZsQuFIMGSanwUMbOKmolXxqVBkNKwkMMS+ST8rE+9tOt3CGi6x
         4RWgkND0l3oP0ldL28EwEnoXYmGLrBZUgPspnK23fe69pmtI8bFdbhp/MQkG3M/JpdzT
         w+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777973132; x=1778577932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g89+ZXdrv2HwDVtTUJW6LEoVLUnEgjDOkUkZiBWX9R4=;
        b=sRHwl+RZ0omeaSekoUj9vKpaX4LOn+rFl2zx1q61PR6PVRkG4FpOjOviqVQBvcq474
         fUnspOLpX1xk5IUL3jnmp0VxbaA0S8k2XlV1+KEmGcQ86q5m4VQ7YqSL7quZec/OP8p0
         u0VSkdJs7Ux+JinoMtwYrlaPQvRkMHBvXwNg+2HhsySjgFrKDx/FuhmXVenvlIZmtQ5r
         wkVtEV3SyURcFNPafPELj+UzV0o1GcEbF6i2dOyAUr+v9ZoBqUReoVEUV4Upts6ToLXL
         0rDm52fZd1aUBCGjrTMATiaGg0UgTJIZmCe9z/mdhnRQStB4Z+lepkd07B3YQhw/n6hw
         ++Fg==
X-Gm-Message-State: AOJu0YwFZ95gIQmN8BrVEj9wnu3s+cJHZpwC5+33pXsPTsBDnsPn7aRF
	TWtxom8/tSj64tqGr3DqNNpie3SKxj7nvQpmMaZDDvIuO4ajuvHKPGPkog2c8sVSBFf0kPwaRKp
	w/KWuaUylpM5yvNg8uvnkK28U4poY86w=
X-Gm-Gg: AeBDietGh3oU2k1SVM7R6/AqzW1PgVoF4yLXLOkF2Qy0W57qlYKTxY5vrlkVf8SLud1
	oviBeMEHZjIoFrk0t/6fbBKk4LoOWAwju3W9/zRGNyGxoRM0FzmHDS/Yrl2/NqHPFdLXH9szdhp
	CK5F5GI8HPzdhxgOY0Gn7IRGNS640NcKF51fOhwhWWGUXC1EM9L7GTNdgWRJNh8MLABccLitADl
	KqEH6O8sWFuqie/tAqnSvl+uiXoczuAFk1oDGxVP4A0KvMzoEm0oTUPV3b41Ykh1MQGNgL+DzKL
	tFXjRT75axfkaltFXxw3OgPV7g9PuhXmElhubu7l7sn0jB83xwCf
X-Received: by 2002:a05:620a:4147:b0:8cd:9707:631e with SMTP id
 af79cd13be357-8fd15add61amr2035087385a.2.1777973132600; Tue, 05 May 2026
 02:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260504063614.3831203-1-daniel.turull@ericsson.com>
 <20260504063614.3831203-5-daniel.turull@ericsson.com> <CANNYZj_UU10pV=pHBi_GOK5m0NsC5EzLB828k9Q08mG3K-wj=A@mail.gmail.com>
 <PA3PR07MB1072178ACD37973C762EAE17E8A3E2@PA3PR07MB10721.eurprd07.prod.outlook.com>
 <CANNYZj_ogpJFafzS=zXzg+iPZL64qURsHAugwwSvSrrB3wy03Q@mail.gmail.com> <PA3PR07MB10721F580DF2B9334EF9975E08A3E2@PA3PR07MB10721.eurprd07.prod.outlook.com>
In-Reply-To: <PA3PR07MB10721F580DF2B9334EF9975E08A3E2@PA3PR07MB10721.eurprd07.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 5 May 2026 11:25:21 +0200
X-Gm-Features: AVHnY4KEEtDfTKto6p2aZIj7ZsHBbVLVYssJLUvkAbMpZoBvohc08HKeYaGOaNE
Message-ID: <CANNYZj-Vth+2qLb48DXw8qLoeQDM4=kOSmypo9BBT0-uu=pKfw@mail.gmail.com>
Subject: Re: [AUH][PATCH v3 4/4] upgrade-helper.py: Add resume option to skip
 already attempted recipes
To: Daniel Turull <daniel.turull@ericsson.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
	"paul@pbarker.dev" <paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>, 
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 09:25:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3914

On Tue, 5 May 2026 at 10:21, Daniel Turull <daniel.turull@ericsson.com> wrote:
> Yes, it was introduced by AI and I missed to catch it.
>
> I did review it manually but clearly I need to be more focused to catch these types of issues.

What I've seen here, and in other patches is that AI makes code that
functions, but has baffling, unexplained logic oddities and
maintainability shortcomings that a human wouldn't make. It also
doesn't write good commit messages.

I don't object to usage of AI per se (that ship has sailed), but you
should treat it as a bumbling, confused summer intern that needs to be
carefully watched and corrected. Whether you actually end up saving
time that way is up to you, just do your utmost to not end up using
more of maintainers time.

Alex

