Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A123FC02193
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 19:08:49 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web10.125122.1738696125870240013
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Feb 2025 11:08:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DDnx/zYz;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d92cd1e811so829376d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Feb 2025 11:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738696125; x=1739300925; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njxY7TKbV81kz6D+gElTETZJT8N4/zYau/1ot7UijE0=;
        b=DDnx/zYzl4RU+7uTQbv3MNsRgFoJfdI+IZktImVVGMjX8yeP6Fde8Xtjx/QT8c3b++
         zBOcuOjpsWANqXJVLU3QtM4g8jmPOPllEJnECt2eK5N0R6WmzSAxmbrGzz+Z9N/Z9TkE
         VfrAiQl+p6Nm0+vsPyhAO95f1FRK3785b19bihC1f7J9xixcWAGRrfnvUh0hUb2DZhJF
         MwcT9d4Y0FlMon+ep83IHuEjYnjlP1cA7uQkBFm8vWGulB1UfBrt/rzZhAYSai9zQzEW
         gED7Qc95fi/pUid2GLRGhScEwW0nAkGtdmkr9xOg9QHuLh38yYtsVDiVARhauMgwKPbl
         7qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738696125; x=1739300925;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njxY7TKbV81kz6D+gElTETZJT8N4/zYau/1ot7UijE0=;
        b=uzOohpDaLuod0k/9/3rCe2yLIiZ9KnGFaLjVLVylLN54letpaO6/aFuCdvXq8tQorc
         maVog3TcL91kjSIfZBxmWb3AWPLhdqUVkTKHHzKBMQnsByE48iRoxeSjGOCSZFwJ/Gjy
         ij8pWrJEajxiMkumE2f3N3Psf+OenysOAP22UF+OqKU/uMigyQ0FZPbyBuEQMpGhRd7p
         Vqt+OeB4JhkBborTFxQXd80qkBuwrNGPY/iKex85XbernlwpViNvOySZbI2RIYPcx5J6
         aFo2BFW1lIL1imgz0XDI1Gl1SOchj0zLERbVWR3cXHS6TpZShKue/iWlnWWb1lbAbnhA
         FUJQ==
X-Gm-Message-State: AOJu0Yyze6SSKUqOU5+etKfj05qlRwkqM6tghaKcfVsEZbp6SgjBnpby
	sKlJmO0OzM73+7cTm587B286mhf/0DEn1xX/HqRrtxPt8z/9u5tiXSnJn0Yte9veA3l/efWlEQ2
	QeDIrXi4AgdSDx8Aq6hRopbwG/pqBowl+
X-Gm-Gg: ASbGnctg2YKTzQDf9G9AzLq4e+umoupqyC/IypK7R/tHcVioidGOYltkpAv/gQ+0lpa
	giLoYUiE/BcW8Q65MVcjhKVEj0YgUxzi70aP56Pq1cmbykBpjseaIrZ4rrWehvX8kbTr3PzXWkj
	aZxWypeuSXp1pFvCVdQPDCj39vEYoVPyw=
X-Google-Smtp-Source: AGHT+IFEtZCuE54fW85u7YFfq7af6ORmdmIWmdekbyaZIeRaMklOmhBf7IxGpbymXandT9n5KqiY+N9v9cbZcqDrG34=
X-Received: by 2002:a05:6214:5b08:b0:6e4:233d:c8cd with SMTP id
 6a1803df08f44-6e42f5ea4fcmr1571616d6.4.1738696124817; Tue, 04 Feb 2025
 11:08:44 -0800 (PST)
MIME-Version: 1.0
References: <DM8PR12MB543001218B1E74EBFFE75B698BF42@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB543001218B1E74EBFFE75B698BF42@DM8PR12MB5430.namprd12.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 4 Feb 2025 20:08:33 +0100
X-Gm-Features: AWEUYZkukkXxQalc7XmgO0K1LJws3wzHqul7jJDETserfahEHxl12NxPeRF_66E
Message-ID: <CANNYZj-bkTMAu6e4f5=JN2wpXvyC4yXED7m0DMo8Rmrx0NttBg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust] librsvg-native
 no longer building
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Feb 2025 19:08:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1031

You probably need to backport:

commit c6557ce953bc858df6b8128748fd4fbc41aa88c1
Author: Alexander Kanavin <alex@linutronix.de>
Date:   Wed Dec 4 07:48:51 2024 +0100

    pkg-config-native: pick additional search paths from
$EXTRA_NATIVE_PKGCONFIG_PATH


If that doesn't help, then set up master, where things work, and see
what the difference is.

Alex

On Tue, 4 Feb 2025 at 19:27, Chris Laplante via lists.yoctoproject.org
<chris.laplante=3Dagilent.com@lists.yoctoproject.org> wrote:
>
> Hi all,
>
>
>
> Unfortunately it seems that librsvg-native doesn=E2=80=99t build anymore =
since the upgrade + move to meson (834e12521bd93e14ba305462c39ba5ebd96710f5=
). The =E2=80=98pkg-config-native=E2=80=99 wrapper makes it impossible to p=
ass through the EXTRA_NATIVE_PKGCONFIG_PATH variable, so the =E2=80=98.pc=
=E2=80=99 is not found.
>
>
>
> |   The system library `librsvg-2.0-uninstalled` required by crate `pixbu=
floader-svg` was not found.
>
> |   The file `librsvg-2.0-uninstalled.pc` needs to be installed and the P=
KG_CONFIG_PATH environment variable must contain its parent directory.
>
> |   PKG_CONFIG_PATH contains the following:
>
> |       - /home/laplante/main_yocto/build/tmp/work/x86_64-linux/librsvg-n=
ative/2.59.2/build/meson-uninstalled
>
> |       - /home/laplante/main_yocto/build/tmp/work/x86_64-linux/librsvg-n=
ative/2.59.2/recipe-sysroot-native/usr/lib/pkgconfig
>
> |       - /home/laplante/main_yocto/build/tmp/work/x86_64-linux/librsvg-n=
ative/2.59.2/recipe-sysroot-native/usr/share/pkgconfig/home/laplante/main_y=
octo/build/tmp/work/x86_64-linux/librsvg-native/2.59.2/build/meson-uninstal=
led
>
>
>
>
>
> [One ultimately irrelevant issue I also noticed is that EXTRA_NATIVE_PKGC=
ONFIG_PATH is being used with the colon as a suffix, but it should be as a =
prefix since it is =E2=80=98post-dotted=E2=80=99 onto PKG_CONFIG_PATH. That=
 doesn=E2=80=99t fix anything though =E2=80=93 =E2=80=98build/meson-install=
ed=E2=80=99 is already injected by meson/cargo_wrapper.py.]
>
>
>
> I=E2=80=99m happy to help implementing and testing a patch to fix this, b=
ut I=E2=80=99m not really sure what the right approach is here.
>
>
>
> Thanks,
>
> Chris
>
>
>
>
>
>
>
>
>
>
>
>
>
> _._,_._,_
> ________________________________
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#1030) | Reply to Group | Reply to Sender | Mute This =
Topic | New Topic
> Your Subscription | Contact Group Owner | Unsubscribe [alex.kanavin@gmail=
.com]
>
> _._,_._,_

