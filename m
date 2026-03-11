Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E741049517
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 09:33:25 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16833.1773221603088719731
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 02:33:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BgVwgJbC;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899f5d337f7so10134086d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 02:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773221602; cv=none;
        d=google.com; s=arc-20240605;
        b=Z3Ev8BnxzY2o82gXDPRuJBSDK510Ub3PJhYIl/23BTYYpXBzG5BggpCBXnz50OkwOQ
         Jq3OEUGulx0Yl0Bq5v9Rtg+vWmm2o5r+8WhM6mydWJoQJyQ1xID3UKrlSVC/t9zm9a3R
         YJNxlHkiilhW/1WFfoD9MfkNqptycGr3WGBM8f+jlsrVor06pGiyXa4IRnTgKl0HKWuI
         YyT4jmC6yIdx8rj296Bri9vFEHDq0MKQi5YEECSaS0pSMiw98djF2uY/t+QJnwcS+/so
         0bd+YfaIJwSguLb3jePhbVuHXgXp1wHfkHVvLJD1rhrZlYgTyOp0uYJ/VaYFWWcL9cOr
         xz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IwPmA9oyiVIhGGb3HiIUyzsl26au9kMoj4LkDqcct1M=;
        fh=nvQ/DZf2jnSmw5O4MEIwQOdwMawupBgAGuif6WaIhH0=;
        b=gu8aDo3y/mjUKLQAF22svN2k1YJhNhWigf2ITWbFcSFBSySbBqzxbJie2vOKPEaVET
         8inq40Q0vzjKFsFR8HR5FYCN40xc4LVzlaxhSfhYsVjhopbFh13c3YYwkPJIm6Oe1nKZ
         XeoxD4BPo+P72XtGLu9ya6u16ZS6F0BeK2nkxiXrBeop4k+332ZQ5THIiTcnkNZxDABU
         WP2BxWPQzJiLvaZuS2qMFsU3OrcA0/Jf/5ewp/4woubi8wkDztE1dvoCDl2JJfYSOZhi
         9FVPXF9BH6gOAOoyF7rm6es+eaiFT/KGFd613MrlLkgg6A0p6DoO/OuFjozH6r0E1xsu
         hgtQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773221602; x=1773826402; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IwPmA9oyiVIhGGb3HiIUyzsl26au9kMoj4LkDqcct1M=;
        b=BgVwgJbCQm8dd5qAnbAHqmBbYKfajVky6H57X0WwxZEZx/Dab0pJNmjm0Fe7D/mokG
         X5qF+g3e/TwrDmTglAOrB5Wlaux3avhBDO4mJyV4GQKyAAyrNyfNR0n+QONa/48zCXYj
         CNQYHQ0r40XpnXlObvexWyn0Kn/eOFdmJaELdMxilVX3pq9X5NAjyKRuIEQTd5zis+tW
         9Zl9GF9U2KVEYZUY91ZXwtAEhTE6nbE+IWjFaq3Z4EfkI7bfsQuvug7ZNQUbEMEAVC+x
         +KlYTTJwaMO3QUQKgvGM4U22iJZ14/jk1winCqgfu2JuLXeD3ze332jEDPHKnQO46Azh
         //GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773221602; x=1773826402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwPmA9oyiVIhGGb3HiIUyzsl26au9kMoj4LkDqcct1M=;
        b=TpIMX5LpkG3RzsyDW648Z3l7nfsIdbcLLqvkSH6mbPrFrZSNRED3Io5YgfPuX7JrxE
         LZTndW01NCcPt62phbDm7WPWY0XgX5IA9hb0ZvNS1jXyMk0KWV4r2aSA2EyhbhXXGv+1
         iXCmbYbIoUJs1nAlwD6pcPZXb6GS+RuzWz1K/GMGZkGGrKW1Tzu5GmRbN81y/oVmNw4r
         msgFUvcnY/216IZ1Ek9bh64Yn8AfdnbNNTfzztBDc5wmbw/S5oEqb8uV7B9VRnQYv6FW
         /lQ2YjuuSUy576gdVmtW7+kLdkzvqUtHx602aXiI6ftcVTGH8X7DQOzZmYFG1Z6LVYaB
         TZ4w==
X-Gm-Message-State: AOJu0Yx8OMkuw/t+rEPKIuMIoXy4Mr9bYDx4qYUCXTNTFjaSD9+rrbE8
	mbMawS//BFBHzOWsvo/xbFJG/nGV7Iyh+khsp4OqTlWIE8u0b76cIpwZrGWb+5XYDgRsVvBAj14
	5mi61AjD6QpXRn7ekJTakV7wevd6rhNkiMg==
X-Gm-Gg: ATEYQzze6Qze/7queOeRZ2rz/LOHqaGuUm/gA4U7tOy3W3A+HX2P/AAIt85Ba+QArPo
	c+B3l92kyi/lP/M00Z57DA+jOeFrotnundz/tlJ2527jGe5/zMbTAZOY9Dguitl0F/1WZ0K95Ul
	z+kRWfy3mFr1VfQWmH0PGWVipEKvyTWu3t7YfCVFxeUhLHxQSloowKpffxvrxTd1h7w6XMmrghh
	u3/HXYqN96+HyhXyccOU51wwxl9H0KV8cWoHmYnhU/+7hvLdzMDTewf2mSsGTr/myLuIBNuq0z0
	I7qeyTjg85GYESEXrW0DNX4mwFilM2cGgCc9y3EIJQ==
X-Received: by 2002:a05:6214:4111:b0:89a:77b:8384 with SMTP id
 6a1803df08f44-89a57be9a90mr87503996d6.7.1773221602032; Wed, 11 Mar 2026
 02:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <189B9F01010B1521.2412760@lists.yoctoproject.org>
 <b8f3d35149f5b2a8e144da24fa6d1b4e777c6419.camel@linuxfoundation.org> <189BBF57BD2F5917.2412760@lists.yoctoproject.org>
In-Reply-To: <189BBF57BD2F5917.2412760@lists.yoctoproject.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 11 Mar 2026 10:33:11 +0100
X-Gm-Features: AaiRm53QsNC_JFV0yUXLye3V8GyEjJCCAyVyPhuO2SsAbr5jfOBpuwiJwAEOt7U
Message-ID: <CANNYZj-Ex5LUpa=5TO6QSHDaSDZTRjRMLUmJsAJzgk3OJhRNUA@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper] [PATCH 1/2]
 config.json: Drop vnc usage
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 09:33:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3428

On Wed, 11 Mar 2026 at 10:27, Alexander Kanavin via
lists.yoctoproject.org <alex.kanavin=gmail.com@lists.yoctoproject.org>
wrote:
> I agree, except one thing.
>
> I would take this opportunity to drop x11 usage on the host/naitve
> side altogether, and migrate the test to use some kind of host-side
> wayland compositor rather, that can be found via WAYLAND_DISPLAY
> variable. I can experiment/propose needed patches to the selftest and
> oe-core metadata, but I don't yet have a clear proposal for the
> wayland setup on hosts.

One option is that the test would start weston-native in headless
mode, and direct qemu to use that (via WAYLAND_DISPLAY). No special
setup needed on the autobuilder.

Alex

