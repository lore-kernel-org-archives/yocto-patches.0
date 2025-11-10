Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F6CCF9E3
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 11:59:13 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46458.1762775950110623735
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 03:59:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fW/NSfp1;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so4625935a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 03:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762775948; x=1763380748; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMyqtEUMuRZvxt33ZVv//BeKHh1yZmHQmuw0YQrwvGQ=;
        b=fW/NSfp1YCIMeYkgrdQ+CL1WiFjl0Thzh8l59sw8AEJQTzrnScX6zWPOuTI3mLsBvY
         P1icGA3V2fvoO9cehk9vheWXzorRZkc0QQnV4gz6qO6ZsV0E/iXjFZrPLa/w69fvtint
         WE8Lc68ZLn3toyRWQmVtHK+b+k4bOHue6VB7u5f2u+06vQmfwpT7E+pGhwY1dURDiOlK
         F4NujRIXjE2Co4Hwlh9Hb45fq1XEbCeqE4bofEbGd/WMn900PMq4CCHQhyEAbkBHExT/
         NY+3n9Pxus0DBheCQZFOseMRml1ZPK09eUsIs4njC/uDTPmawNXJzj62WcVASkWiNPl1
         A/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775948; x=1763380748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMyqtEUMuRZvxt33ZVv//BeKHh1yZmHQmuw0YQrwvGQ=;
        b=fqoAdhBM/woqdgnGKszkFULNAxZAKqflTtJK5Bo0ueNX03aRvAxtbq0JIsULIUhmoN
         FBjOHCuCsPBlrED0uOcshCASAPKucyI+HXeY7koa9rglWneuzJscGlExcH0a+bxufLBg
         fHYMEnTFQq9hODD1fPFdDxOD2LsSrg4UqczroPGFsU6mnXIxnzuDN5FUXuLcj9SshVJ7
         EsnXNqwBZaUHFvcAbVpe+bjrscrVsMsJfK0Ygj8j4eGmHbpea3/NpT27pFOHKzeJigC7
         JSr4W9FCsyb6IhKqJpkxLzZJxuD1WwZ66p6W2up5Z8rpMm0ksy71aFvCeC1kX0sLcGGK
         INOg==
X-Gm-Message-State: AOJu0YyaG6iv5MDP0MemDfe00CSsYUUBzRboaOPXRFxQOREIArtwJYRq
	3pB9DzbynBWFzLhj6/BNt2YhIeM6i7nLVDqNCfYHJ4d8+UYIiBkeiZXFLkimlslWZRdxTedqOYl
	T3VGLDx12QaYcD/nYvXuVozinE7+dpIno4l4x0to=
X-Gm-Gg: ASbGnctczOK5upo3b3wH/0T3iq52N9NOvw4Xdsx6Auj0tOkCB93PXNfP7yHD+0K4X93
	PAmtozoU9P9FgnXqYNZdeUAqrkflA7/QmY93lEqErW81i+sfvp5vyP2zcfNevnjywzD1TWvzc5a
	2Ndwv9UQcDEO7dKWsptsGaXCUwx7ftY9qsSFa2ui0kjWpqRz03txDQJ+DoG7wbxJPpFbniVesRP
	PBnhd7BptzPWJ3k3W5hIuw2BIloztgYftawYE7fQUqG7bPKA19TEEvYxLuiDnZphzxIWb0p
X-Google-Smtp-Source: AGHT+IHNNlcSSkLbskH+O2RDvagxM94hdeCn5e+tIq3r3StYOVSfZF+H2aw1rKs21J3etVyDFCYNit2uBlOacBsuZls=
X-Received: by 2002:a17:907:7f2a:b0:b6d:801a:648 with SMTP id
 a640c23a62f3a-b72e055df35mr724592166b.48.1762775947771; Mon, 10 Nov 2025
 03:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20251110085356.11336-1-peter.marko@siemens.com>
In-Reply-To: <20251110085356.11336-1-peter.marko@siemens.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Mon, 10 Nov 2025 11:58:56 +0000
X-Gm-Features: AWmQ_bkMrULXoh-zG_UXHTArGzK_IfrtAMOegF8WqJvGdSUKDX2yJmmlbIWgHjk
Message-ID: <CANPvuR=SZ58xNsdw91C7XjnOQU6Jn5PcAz0v75vygUTCLAqQPw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] README:
 add myself as maintainer
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>, Jose Quaresma <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="0000000000002f871206433c42b4"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 11:59:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2474

--0000000000002f871206433c42b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Applied along with the other pending patches you sent.

Thank you for all your help.

Jose

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (segunda, 10/11/2025 =C3=A0(s)
08:54):

> From: Peter Marko <peter.marko@siemens.com>
>
> I'm already very active contributor backporting all go recipe updates
> and it makes sense to have at least two maintainers to be able to handle
> contributions in timely manner.
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Cc: Jose Quaresma <jose.quaresma@foundries.io>
> ---
>  README | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/README b/README
> index d0b6bc4..6752254 100644
> --- a/README
> +++ b/README
> @@ -12,3 +12,4 @@ The patches can be backport from openembedded-core with=
:
>
>  Maintainers:
>  Jose Quaresma <jose.quaresma@foundries.io>
> +Peter Marko <peter.marko@siemens.com>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2469):
> https://lists.yoctoproject.org/g/yocto-patches/message/2469
> Mute This Topic: https://lists.yoctoproject.org/mt/116216252/5052612
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/150=
4338242/xyzzy
> [quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000002f871206433c42b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter,<br><br></div><div>Applied along with the ot=
her pending patches you sent.<br><br></div>Thank you for all your help.<fon=
t color=3D"#888888"><br><br>Jose</font></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Peter Marko vi=
a <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;=
peter.marko=3D<a href=3D"mailto:siemens.com@lists.yoctoproject.org">siemens=
.com@lists.yoctoproject.org</a>&gt; escreveu (segunda, 10/11/2025 =C3=A0(s)=
 08:54):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: P=
eter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" target=3D"_blank"=
>peter.marko@siemens.com</a>&gt;<br>
<br>
I&#39;m already very active contributor backporting all go recipe updates<b=
r>
and it makes sense to have at least two maintainers to be able to handle<br=
>
contributions in timely manner.<br>
<br>
Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" t=
arget=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
Cc: Jose Quaresma &lt;<a href=3D"mailto:jose.quaresma@foundries.io" target=
=3D"_blank">jose.quaresma@foundries.io</a>&gt;<br>
---<br>
=C2=A0README | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/README b/README<br>
index d0b6bc4..6752254 100644<br>
--- a/README<br>
+++ b/README<br>
@@ -12,3 +12,4 @@ The patches can be backport from openembedded-core with:<=
br>
<br>
=C2=A0Maintainers:<br>
=C2=A0Jose Quaresma &lt;<a href=3D"mailto:jose.quaresma@foundries.io" targe=
t=3D"_blank">jose.quaresma@foundries.io</a>&gt;<br>
+Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" target=3D"_blan=
k">peter.marko@siemens.com</a>&gt;<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#2469): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/2469" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/2469</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/116216252/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/116216252/5052612</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13170708/5052612/1504338242/xyzzy" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/150433=
8242/xyzzy</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_blank=
">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></=
div></div>

--0000000000002f871206433c42b4--

