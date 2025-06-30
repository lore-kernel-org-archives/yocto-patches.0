Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85B3C83030
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 11:55:09 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.38187.1751284504256195378
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 30 Jun 2025 04:55:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EmCPk0dp;
 spf=pass (domain: gmail.com, ip: 209.85.216.48, mailfrom: rybczynska@gmail.com)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso1274879a91.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 30 Jun 2025 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751284503; x=1751889303; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76vXsM/4MGxCYXc7CgZYSpVsBnm4kP5hFTBitZGYZMs=;
        b=EmCPk0dpTfg2OhsIMbpeAjeBfjVws/xBiaX3Lkvfsd2x06jtAjyW6d2rstF2k6BEjQ
         ZsQvZXuw7s0sL7AnkntpWVTU7UU+Q8tAFYoqeUh1kaT4thi5bbzojfpzOdbTTsGW9o6h
         1PSTOQtSU0UbBLqiwLzlYOmTt5bJq6gzZvfDkKDQAistBY2xD1ydx8bNvzvyesq+dQna
         rx/rVRDiIymIWMBHd6fK3xd25tvyc1Z117dz/xq2DVWpdSEz0GsBiz8PiJ04b9orcszr
         G6dxS3nSmY8FIDGwQ+dXvuZ+5Pfw9yoX6Jh5wcOHXoUTxqlc7oKXsft5lSR5g53eG+Ui
         mJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751284503; x=1751889303;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76vXsM/4MGxCYXc7CgZYSpVsBnm4kP5hFTBitZGYZMs=;
        b=Ixgu9rw4RMFi10Rv/pmXZzYI8e80wAfMtVGIjRGgDT69D0reGdRJU86czPHR/bqz7o
         TNvoUCW0ArugTX1AweodH3eJgUpapf3YmKfY4Pn+0HH2UPLTBUqVQ9+zIRaL3Uf+h2CT
         HoCCY3fe70INZlVacSxbih5n6R7dDd+N67rd3cCRtdn5GbMB+9j5gC9xq3OJsNKm9Hhu
         Tj/fcR/9LiDSwNIqhOm1EYUHOJw7LqN2eGPAYU/caK1cXUIb3ODTJrj+8wI0JWDsqdKU
         ikNkBoB2c98+y1BS1ZZLm/qThMs8/AVZBPIgfNHgP53La4itLhK0xV1lyEVLSVRmn0Hv
         Kt4A==
X-Gm-Message-State: AOJu0YyngPnlEHMd4Vtk5d92ksjaIrZyPqJGJ0SyTxNBWAvkCb9BT0DM
	woQ2d5JGBqKkllY9IpOdIDflF+o5RMEobPvYIX9jjeF40R9dVumgvn/0FzIc/2cj5ZjX+pwKpQM
	SQ8ZsW4tyM7nPNCILvEwoLlYj+/obcieUVA==
X-Gm-Gg: ASbGncvqVOPT3l9WGkrf6A2ThMWoggCyw5dwxCvd6pyoaQ3bXlCoKjDndU8t1JWOkzq
	DSI6pKXfobxaXIyBS+tMLSMD6PqQLiNhnTxx0JpamSjVwZLc7dHD0Xxj+35e9Ob2WjtzOh0Abgm
	U5mhwuJOBQHaj3YSzFN97y4qtpXLGzc4ePg81JMZSBcJC+
X-Google-Smtp-Source: AGHT+IHikhlZZ7U9hg82E5MLREepje41k0lUlJ2sX3eSkpYFc8o38nySMGcOz+GwqBjR6XctXco7T2Z0UaGG4o261CA=
X-Received: by 2002:a17:90b:35ce:b0:312:db8:dbdd with SMTP id
 98e67ed59e1d1-318c925a50fmr18189823a91.28.1751284503072; Mon, 30 Jun 2025
 04:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <d362cdc5e05123ac1907f64d94ea604fdaab884f.1751049467.git.scott.murray@konsulko.com>
 <25294.1751202200711749103@lists.yoctoproject.org>
In-Reply-To: <25294.1751202200711749103@lists.yoctoproject.org>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Mon, 30 Jun 2025 13:54:50 +0200
X-Gm-Features: Ac12FXwrE5v8KM1kuGUDZIlOpYJ82PhnFZCbEVVf7rqI0LWZxII7O6mObNWMgLA
Message-ID: <CAApg2=S8PUKMVSCcBdZazNDkxwMLMGjQ2UH4HoebymErpm4mZA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 1/1] Update maintainers
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000b4d3090638c8b267"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 30 Jun 2025 11:55:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1728

--000000000000b4d3090638c8b267
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 3:03=E2=80=AFPM Anton Antonov via lists.yoctoprojec=
t.org
<anton.antonov=3Darm.com@lists.yoctoproject.org> wrote:

> Hi Scott, Marta,
>
>   Thank you for taking maintainer roles for meta-security.
>   Armin also used to be a co-maintainer of meta-parsec. I don't know if
> you want to include yourselves there as well.
>   When you have access to all the repositories could you have a look at
> his PR:
> https://lore.kernel.org/all/20250519084553.2027324-1-Anton.Antonov@arm.co=
m/
>   It's a breaking issue.
>

Hello Anton,
Thank you. I have had a look at the patch and it looks correct, but will
need at least to build-test.

Kind regards,
Marta

--000000000000b4d3090638c8b267
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jun 29,=
 2025 at 3:03=E2=80=AFPM Anton Antonov via <a href=3D"http://lists.yoctopro=
ject.org">lists.yoctoproject.org</a> &lt;anton.antonov=3D<a href=3D"mailto:=
arm.com@lists.yoctoproject.org">arm.com@lists.yoctoproject.org</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>Hi Scott=
, Marta,<br><br>=C2=A0 Thank you for taking maintainer roles for meta-secur=
ity.</div>
<div>=C2=A0 Armin also used to be a co-maintainer of meta-parsec. I don&#39=
;t know if you want to include yourselves there as well.<br>=C2=A0 When you=
 have access to all the repositories could you have a look at his PR: <a hr=
ef=3D"https://lore.kernel.org/all/20250519084553.2027324-1-Anton.Antonov@ar=
m.com/" rel=3D"noopener" target=3D"_blank">https://lore.kernel.org/all/2025=
0519084553.2027324-1-Anton.Antonov@arm.com/</a><br>=C2=A0 It&#39;s a breaki=
ng issue.</div></blockquote><div><br></div><div>Hello Anton,</div><div>Than=
k you. I have had a look at the patch and it looks correct, but will need a=
t least to build-test.</div><div><br></div><div>Kind regards,</div><div>Mar=
ta <br></div></div></div>

--000000000000b4d3090638c8b267--

