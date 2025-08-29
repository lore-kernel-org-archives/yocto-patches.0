Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B98CA0FF9
	for <webhook@archiver.kernel.org>; Fri, 29 Aug 2025 10:06:10 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
 by mx.groups.io with SMTP id smtpd.web11.9911.1756461967995394706
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 29 Aug 2025 03:06:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aGqJpxKH;
 spf=pass (domain: gmail.com, ip: 209.85.219.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e970f3c06b5so927070276.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 29 Aug 2025 03:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461967; x=1757066767; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uauk688WoDbjC3UDyCSE5G1cNTWeFnzPqpTeam6WCi4=;
        b=aGqJpxKHi6sSeggpMEsA65YMhgBaUIfSmKAHVk/yYbXDdR16aUdI6CTXFxCCjHs3Fy
         Ef7MTBJlXcz3YE2iz+5Mx+ZFO4TC+BkiA7f4S+8UHxHUnD+RcroiotSbOwb31KGuEDHR
         PzwLEvUfo0YPCfK4Ys+kBpGSXF3FO0jQJ4dwq1xthifb/b/WzzCeBGt7GRbRkrlGv84R
         ZaDhtCZKxWnTEQA4pSDLZvxqLEoTvJZHK+/CYiK6lN2K5XrClvgWtk/qnIXNk6lDYVCU
         GsqfF6ny3Vxxys1djkx3YiCSN6rn7ZNxzsZd5YG66UQD9nlsLj4SSvHKmku4rN1xSauT
         ScCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461967; x=1757066767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uauk688WoDbjC3UDyCSE5G1cNTWeFnzPqpTeam6WCi4=;
        b=tm1EgbcksFiizyHjQgbtd8R1q5tCu0c2dw33BiauyB40GJr8qE/Xy1OFD+3AOKjah0
         toOkIWEWlJZn1pr4Y8ffmkF2WKoELw7T8shHaac8ib9W/6IKjMBeJujHE2xPJbIXNH18
         OJcJ7ky8POw/c8+b2ra0hkogbrBoSyMXsAmKWPz3K+whsU+pjgdnTztx+mG1m+L0Dgeo
         dfmvNbDEKPhre2epadCY8QPo+vtsE6X7OYBqPHtI+4CoQXhPlU7WlJ42K1FHLWWkUu6o
         2pRlBkTSe2FKTkvCfnwcB09f7TxnypeCYbCyrPHZDRa7xfwddhu8iQHqSOHd/H+/Wn+w
         YxAA==
X-Gm-Message-State: AOJu0YzFlM4JCdmwQtQ/7SVy2UaOwsretFtNtp7W3Xp9deCYzJEC/9ae
	rs0gX65EYbe3YUVaNMgz9fAk9xD9S/RkYRIWtqiNoDsJvtOBaxT8ChfqDDOos+F2AOKTW3Xo25H
	YESjTwds1ahQwGKwxw4jiOD1kxrimV7XR3g2a
X-Gm-Gg: ASbGncuGd90D1pLGkHb9UnRBLiSL7tZ/gyGz07ldeAMqLnXV3pdDA+syKo9PzGswDdW
	2JWdffFvJ+5Gx4sx3l5AVLzLc8YXgXWhogSTwHnzGsTdueEOUX3KHxjYKOckEqlvzDiGmpcjjbY
	i+m7Zhi+5yXmbrIEqOJMyd9mUtR3zYKvaF7jDANHriTpq2i6Cw9DhpZSPIEaXiLG6AZQc4h2Nvs
	b1wDH3f5DaKbU9GBN2Th9KnU3xSznj1wDgETSBd1yJSS/Mia5Y1
X-Google-Smtp-Source: AGHT+IH9Y5bcvJ1cpo5aJKfqHqwQWNUfNkp5f3S/GDuLHRQXFlIQwgbW6++g72f2PPVknwnbnM0kjf4FTpT2PPxGTlA=
X-Received: by 2002:a05:690c:f04:b0:71e:7803:cbd1 with SMTP id
 00721157ae682-71fdc2ec379mr286582857b3.15.1756461966832; Fri, 29 Aug 2025
 03:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <CY8PR11MB7921AAF6CFDC45DD76C7B40B813BA@CY8PR11MB7921.namprd11.prod.outlook.com>
 <CANx9H-Dy+hRXngzUdRew-v4xR8dsg-4_r=j=aJZrtKXwe2yPSQ@mail.gmail.com>
In-Reply-To: <CANx9H-Dy+hRXngzUdRew-v4xR8dsg-4_r=j=aJZrtKXwe2yPSQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 29 Aug 2025 12:05:55 +0200
X-Gm-Features: Ac12FXwlUL4EiqJ9S1tDIOtqHZXL4J9EzxP7tX3FyWoAR_WpsaG8xaGwZYz4SaM
Message-ID: <CANNYZj9i7Yh5ZbifZsd_=uTkDk5_C50fbWyM=7BJrEgF+vLL0w@mail.gmail.com>
Subject: Re: [yocto-patches] Insights from Integrating mixins rust into kirkstone-based
To: yocto-patches@lists.yoctoproject.org
Cc: Scott Murray <scott.murray@konsulko.com>, 
	"MacLeod, Randy" <Randy.MacLeod@windriver.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 29 Aug 2025 10:06:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2092

On Fri, 29 Aug 2025 at 11:55, Tim Orling via lists.yoctoproject.org
<ticotimo=gmail.com@lists.yoctoproject.org> wrote:
> You would likely also need a meta-lts-mixins layer for python. No one ever stepped up to do this, but you can see an implementation at
> https://github.com/warthog9/meta-mixin-python

And then it just ends up being more difficult than going ahead and
migrating to scarthgap (or better yet, master) where all these
problems have been already solved by others.

While I appreciate the work going into lts mixins, I still have mixed
feelings about them. We should keep pushing people away from this
'stay with a yocto release for as long as possible' mentality. It
makes it difficult for them to contribute to yocto upstream for one
thing, because the gap to their daily work is so huge. LTS is hugely
successful and useful, and some want to have it for even longer amount
of years, but it isn't helping in getting people to use master.

Alex

