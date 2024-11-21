Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2EFD6ED19
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 12:34:53 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
 by mx.groups.io with SMTP id smtpd.web11.9637.1732192492058318038
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 21 Nov 2024 04:34:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UfFXQSck;
 spf=pass (domain: gmail.com, ip: 209.85.219.176, mailfrom: alex.kanavin@gmail.com)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e388d8850d3so845983276.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 21 Nov 2024 04:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732192491; x=1732797291; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvIwkDuayz7z3J4ahUterVHEkq/4SNlRMkC+uQjBqJo=;
        b=UfFXQSckyrzrXc+WwLBViTpFh58RHuKiKx0lT6Scoaug/SRIrJDuI2K79orPVLIAf3
         7dCEfrY6Q3GhJhgEQ7cOqZGWL5aeEah24GC5wqPvQSEPAHQjKylJh7kwxGRtXOqMxc26
         9idukCgM8vjMONkOquv43HDNJVn+R7oWSIl/nN5LkzuPlsMY2p2DlIxNPCQgOwp2xsaJ
         yAAxHm5Wn/Z8/fOYwOUGCvjEotllXI88c95NyqUZGm/TNRtGd45MuiE3wouOnwLnXtyq
         6JlsfGX59H3MPyYoTW+cMDgEWsuxbuaw2AzWeHpyGSLJUg1c/LbvsejJfDE+rktnerqm
         jqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732192491; x=1732797291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvIwkDuayz7z3J4ahUterVHEkq/4SNlRMkC+uQjBqJo=;
        b=noGzk09D4FBXYvrbs+NNziGRL2dTatqzqKFsiTk+Cmd1lQNaPJdzgzSpWf9o2EPQBL
         2Gb8LwnrS6ZSnt94VHhF7Jw1L80G4gH51XcXakQ29bPYlWD0riDjnyKOjeQk3WPSA3Cf
         UR4UAA7DjcxvO1ZFTCNccmvcM3Mz+aoZbYghi+66bCW3LxfDcQcT0ucapIxl05BrZRn/
         8bR/DsdlrrCwXcTDDchIa49VkjyJ365MVDogHReb3wesMcQwOx9tshi91UbC7uajb+Iz
         jcaAaE0kNc9PbftnpQiMTsUCQrvRsgcgshTe+ieVCZyxdtF/YJS5O1WoYf2bC1BH7M+a
         T6+w==
X-Gm-Message-State: AOJu0YyH5jScIx6qI0In9ww2HLXOUDDTqQYiBAc2f3eloyJ6ii/oNAY0
	VqfNufclMptis1SDCIO5w5LstbIeFlukScjfmjw5FB/GIlKQ7yU0XmLoHMIwomxHEdJwvNsy2XN
	2ypr5yWdfgaxtXSZyJExRf1rakNiXwQ==
X-Gm-Gg: ASbGnct5ResNhTk4ICAcBRiCP8hODmNBb0nwMeRfTyAW3iiUVaYY+Sj2JLtwT5+YrlN
	eQ5C9lej94h+i/zI1IfmvyD1c+GW6qpo7rMIfRkB3bc3qsbt4PM5snqTRxy1zmiFwZg==
X-Google-Smtp-Source: AGHT+IEhC3uiOy9j8dvR6JQtfwIyT8D5FGuwKn3R3ENubdFzhqUcj9pZEm/aWifebap4ivRALjb/FvjPt8eWPBbkJ2o=
X-Received: by 2002:a05:690c:338c:b0:6ea:8647:d616 with SMTP id
 00721157ae682-6eebd132cd1mr72950597b3.15.1732192491160; Thu, 21 Nov 2024
 04:34:51 -0800 (PST)
MIME-Version: 1.0
References: <C9A737D5-315E-444F-8D89-1B190D13D3AC@noisolation.com>
 <fa7168a8-5e96-9025-8fcf-c13df18e54a8@konsulko.com> <9FBDF944-527C-499A-A6C7-FFFD49B6B458@noisolation.com>
In-Reply-To: <9FBDF944-527C-499A-A6C7-FFFD49B6B458@noisolation.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 21 Nov 2024 13:34:40 +0100
Message-ID: <CANNYZj--Hpb8DcSJHeYsLfLj5ts5mz8VHW1R6eBAOmTzUQnX9w@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins] Create scarthgap/rust branch to
 backport Rust 1.80 to Scarthgap
To: yocto-patches@lists.yoctoproject.org, dorum@noisolation.com
Cc: Scott Murray <scott.murray@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 21 Nov 2024 12:34:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/831

On Thu, 21 Nov 2024 at 13:29, Martin D=C3=B8rum via lists.yoctoproject.org
<dorum=3Dnoisolation.com@lists.yoctoproject.org> wrote:

> All of this is good feedback, but seeing as you're already planning
> to make a scarthgap/rust mixin soon, I think I'll leave this as is.
> Feel free to use as much or as little of my patch as you want
> (though seeing as this all more or less just worked when copying from
> the master branch (with the exception of the ${UNPACKDIR} thing),
> I'm guessing most of this won't be too useful).

FWIW, if you want to contribute, we'd welcome rust version upgrades in
master. It has 1.80 now, whereas 1.82 is the latest.

Alex

