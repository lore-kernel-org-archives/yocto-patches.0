Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EDAC021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 07:56:10 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web10.3394.1740470160839187200
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Feb 2025 23:56:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dlSzZviH;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e6827984b2so61440076d6.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Feb 2025 23:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740470160; x=1741074960; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uXK6oYxyGGEs8+5WNp5tt4zm6Prlf8FirarqfATZjeM=;
        b=dlSzZviHA4KcruVKJ8ZNxRNrGsAJkspc3J7yAKMXECcK9JUz3xgQ2CgldRGDCElLSA
         UvT4udncJvfWR82AqTaGckTtqBgu69xL0c+E2IYieQhrnOATNx3m2NG030ktzolpoqRP
         OETIM9rZqpYyNG7IR3Q2RxG1DYKOD6Ipp2o/fTd2iaLFUDMYMAIldF6CKzZYHDbT5SC4
         z6+AmNbtztZU+e7XVPf3OAz+o8mPcE/HVGxI3b3rYNWqz9l1oju6v6K9vEYVVcI+7z0q
         6YSBfXJsZVWNovyRMwVoNaVRhRnN8lPW/5vIy8pNJC//mHzTWfbz6P24+GXS4b3+2DL1
         cCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740470160; x=1741074960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXK6oYxyGGEs8+5WNp5tt4zm6Prlf8FirarqfATZjeM=;
        b=bXWEyspsYG5rBSS2rSR0HAEzJrpV+V3X9xeaNCD4UHHEYJn7bz22aQBXwejbz9s/RS
         nSV+rgbZ79QrzJm1dK4t2mq6ygi+wvjVgMytSCw9RcXJpbAiUWeQkQm6QSdzjboJdu1S
         xLaD8F0drhXSM0kxsvqnXZELRoVHUZdMIQzcUAzoRDIgwxMCqBbYmf5vT/83QVqRzXOU
         QkIUZEhwCJb0e9qKoitb/3vQSVqcDT3z9Rwz+JM2vWL7jXFmUPh7QMuY8IW+p+pvo3XU
         ZO2P1WwMSidMkD41agicND0ruc1zSgjt+RXa4TH3mMZCFYFrMmm2W30jT1oxuYsjWmKf
         UPUg==
X-Gm-Message-State: AOJu0Yy/vrNyWVB/GNb/DkBztRq2mZ2jCqqcb+R9GljZ6mUGpNWtgn3F
	Xtws+b9biFefmNKwDPeFNQ9YUZuTPEYkS2FC6JJ7Ii6wLHSUaJkRwLy6ZhOcx5o8Xsn4u7slMy9
	uf51kC1A60anA0cXSbqlWOklfCZbj9A==
X-Gm-Gg: ASbGncvIHrHiNuyLRMERj7GilEgRSx1USgTNlZ2J7bXblrnuoN89/c0ZvPoZtdBSfnj
	s27Lfhr6JkAwhrAq2hKNV2ll8vy8OyvH0QelrJp6tVsuO5+Ivz/58kG9ABhuSF9C5lftcw+wJBC
	XiEiQ57DjQPO+Z7Dyk2z6m8bQQ0LEZAFPKqga9s/qkuw==
X-Google-Smtp-Source: AGHT+IFAmNCyn3oGv+9YKjgVAxJZeuFmjnl9YwqI0NPPqOpG+HkK2MAdSxsGPZdralTSCvQKisgo7uycwJ+BJ0F3ZjM=
X-Received: by 2002:a05:6214:d47:b0:6d8:846b:cd8d with SMTP id
 6a1803df08f44-6e87ab9fddemr19333666d6.30.1740470159917; Mon, 24 Feb 2025
 23:55:59 -0800 (PST)
MIME-Version: 1.0
References: <TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <CAMKF1sqJ3MS8gnN8gv1AMLNNZt=UEXtzXyQim-5TA+H9funFUw@mail.gmail.com>
 <TYWPR01MB11861B276559403A8AA76A8EFDCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <49dec7e116d95938712d10e4d76b78ed2df01ca9.camel@linuxfoundation.org>
 <CANNYZj-RPuuU+Ub5d0VBz7gmqg-LEB-yKN9dkJL8Qp-2UY2K1A@mail.gmail.com> <TYWPR01MB118611CBFD42C4CA304D6A552DCC32@TYWPR01MB11861.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB118611CBFD42C4CA304D6A552DCC32@TYWPR01MB11861.jpnprd01.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 25 Feb 2025 08:55:48 +0100
X-Gm-Features: AQ5f1Jrc0YMTk3ccWJvklrUBzM4MseCsDwN7rcJlGW7GdCjR9OHatBjAR44Woos
Message-ID: <CANNYZj8My6Uf78BFFkA09_VKYkHssxbk1z0UMiPF8jAAhYpB7w@mail.gmail.com>
Subject: Re: FW: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status
 in patch
To: yocto-patches@lists.yoctoproject.org, wangmy <wangmy@fujitsu.com>
Cc: Tim Orling <tim.orling@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Feb 2025 07:56:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1127

On Tue, 25 Feb 2025 at 01:21, wangmy via lists.yoctoproject.org
<wangmy=fujitsu.com@lists.yoctoproject.org> wrote:
> There're many patches that have the following error when build them:
> do_patch: QA Issue: Missing Upstream-Status in patch
>
> Do you have any suggestions regarding the Upstream-Status error?
> Should I fix them by adding "Upstrem-Status" to the patch file, or add " ERROR_QA:remove = "patch-status" " to conf/layer.conf to ignore the error.
> Of course, the latter requires a lot of time to figure out the reasons for the existence of these patches and their latest status, and progress may be slow

You are asking the same thing again and again. Please do not do this.

The only answer is: meta-java has no maintainer, and Tim, or anyone
else, is unable to help you. You need to become the maintainer first.

Alex

