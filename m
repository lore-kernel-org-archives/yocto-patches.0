Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0A0C021B8
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 10:04:09 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web11.2546.1740564249326645614
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Feb 2025 02:04:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dDRpNoBL;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e44fda56e3so6741806d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Feb 2025 02:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740564248; x=1741169048; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tbwnMgDb6d4MdSxFr7nBH29tBNBlemaLoHDFCRZ+hHQ=;
        b=dDRpNoBLrAuDfBab2w4PhuJOlrhWFOaGHHWyLo4I7FUT7rlzJgdMozw+nx5QiFXWPp
         lcOUgYJbRrkalxsq1ai6lNZrXfgxL7NkfG/o7GHsVhGdscmGFNSQtU3Tr5RSsnhOLfpo
         5k5+P+seMXukzrqkp5+vsS64YjSC+b8V2HjoVJjEqBvwHN6bgmjMxPAgHsQ/ih/95PgX
         QUyUxpcyexLRYvzxtMwGrE1PSM+NZNA6hDkxdHImZqMdT2Xv3OnmHtM/Nzuti+Y1UA0E
         3phFEqHLUcEoltUecvQnqKKMMNu/Tv+5VQ9b70JHO9YfABwMgXFFjSX/bAXqNWJ+EQkP
         LR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740564248; x=1741169048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbwnMgDb6d4MdSxFr7nBH29tBNBlemaLoHDFCRZ+hHQ=;
        b=n+z8RvHATw+qam5LgcsvvZLzg/lcwpFpJaRwloAsxJGepd3knWlTqwVJ99j8Y55V0R
         3TUtFuHjCqY8Y2TTXoOahNoBmwPf+DOLGxL4FcOgIDmXu4aIrwH4KWMtPQDlp7peVEGM
         74/Ril/EelWWnL1NpOQM6dStfvJXpK+G1oQzz6+qTJlg9ogos31AWBueupWYBCWQBwaU
         B5mfLUdnKnS58q4nZhfXQFl+/VOFq6DuuVGii/TaF0Pp/WPMzfSyrluh1yQAPcsXAX5q
         83yic8/7TgvNHk5wdgfCxvI5GTvFnkVkOZA/GJ9s8OJmg5ACnAxUQVVyQOWH/xch3Ou7
         H4Wg==
X-Gm-Message-State: AOJu0YzPfwdWUWb09SBL7WKxnmN5OMyg6CUogK2ohair/R/gPYyY/A1Z
	kY00UzIlo6YFWV66gwFA6aHhVeia7KPh0HSt/dN7e1QFarElq7XmUZE7N5jdEYZe5lVWLpEXKCG
	d5NnHpUxlBFZ0w9ZGdUYsZlvwTLQ=
X-Gm-Gg: ASbGncu/4iokr363biVKCpIiO3owVhqsr5VAETE5nzDWSluwhLDBh/vkd5Y66kLzVlp
	K6Xw4pShSsgpcthx7CsNEm79Jed7MRktp8gY9W2Yn+EtdsTPfMMWhInp5HZ+gDkAf4N1R9bxNgk
	o+4AgOJEEP
X-Google-Smtp-Source: AGHT+IHm0GX0zs5PyoOg20pOBaqkkn3SSWusj6tjadEWCI3v/gVEPyvFv4JU3hiQVjnC651Id6gkHGNkbmrwPoxxh0c=
X-Received: by 2002:a0c:fc4f:0:b0:6e8:903c:6e5b with SMTP id
 6a1803df08f44-6e8903c6f30mr4563396d6.9.1740564248284; Wed, 26 Feb 2025
 02:04:08 -0800 (PST)
MIME-Version: 1.0
References: <TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <CAMKF1sqJ3MS8gnN8gv1AMLNNZt=UEXtzXyQim-5TA+H9funFUw@mail.gmail.com>
 <TYWPR01MB11861B276559403A8AA76A8EFDCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <49dec7e116d95938712d10e4d76b78ed2df01ca9.camel@linuxfoundation.org>
 <CANNYZj-RPuuU+Ub5d0VBz7gmqg-LEB-yKN9dkJL8Qp-2UY2K1A@mail.gmail.com>
 <TYWPR01MB118611CBFD42C4CA304D6A552DCC32@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <CANNYZj8My6Uf78BFFkA09_VKYkHssxbk1z0UMiPF8jAAhYpB7w@mail.gmail.com> <TYWPR01MB1186195D31D8A8A089D2D8C75DCC22@TYWPR01MB11861.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB1186195D31D8A8A089D2D8C75DCC22@TYWPR01MB11861.jpnprd01.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 26 Feb 2025 11:03:57 +0100
X-Gm-Features: AQ5f1JpoYvDPo7NVVd7h39O43avhTYRrrlK7qmRD6OdKyE6-Iu2Q66FwXkzH35o
Message-ID: <CANNYZj-g0eJ2y7e2HvZkLbjwhfA1Rk6Ox+_FK_k3-Ycocp2Wcg@mail.gmail.com>
Subject: Re: FW: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status
 in patch
To: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Feb 2025 10:04:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1133

On Wed, 26 Feb 2025 at 01:34, Mingyu Wang (Fujitsu) <wangmy@fujitsu.com> wrote:
> >The only answer is: meta-java has no maintainer, and Tim, or anyone
> >else, is unable to help you. You need to become the maintainer first.
>
> I wonder if it means that I or somebody else can become the maintainer of meta-java?

What you can do is make a fork of meta-java somewhere public
(typically we suggest github, but that might be difficult for you to
access from PRC). Then you can add your patches and fixes in it, and
send announcements here when there are significant enhancements. If
there's a good track record and commitment to making it work according
to official yocto layer standards, then we can make it official.

Alex

