Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4729CCFA18
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 07:17:45 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1362.1762586256720442103
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Nov 2025 23:17:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TTe2ph63;
 spf=pass (domain: gmail.com, ip: 209.85.215.182, mailfrom: rybczynska@gmail.com)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b67684e2904so923203a12.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Nov 2025 23:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762586255; x=1763191055; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pFDiT95myCe8+G5RjIaR21MDQ5PgkFnn6WsYOVBBhnQ=;
        b=TTe2ph63ZUZWVdcTRnQZ/CERkJ5juaVwOm1CdXUN/Im0vYIhdLe3/An9PetcNvWdt1
         pKrloD5kRk0FF9c0ndllpKHdbLDD+UFrNUv8BevIkpq2b8iJhxvKkzUPpw8O40GAJ7cC
         Z/ADYlOe5hy2lzJJU3kbBp01drv4BoEXcLMhwp/crOUBLlU/hx1MA0lH99wEMQVTcSm9
         IYgJaqhKVolDoU1uT3u2iZSSkKU8pEj/e48qFm/fb+xWxdtYgh5/VcLxWXhwCO/51snG
         LPlCRosJcEa8mmnW8qYXc++dmSajfYQcNGy8bDWr2GHLws6wcV5OrTgt1rsJLzrpGxqF
         x62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762586255; x=1763191055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFDiT95myCe8+G5RjIaR21MDQ5PgkFnn6WsYOVBBhnQ=;
        b=DYAEsiKqK8RA40WgzLTyLiM6OZs66SHpdEJ9PU6b+fD9pqic1VLpTxMYbhktUzw1Qn
         V6ROOlAdMnZwCMPpgNPfyJx3uGtmX56C/qp8A2VsyeYW/6cJaiPu90r1I4l4l/G518oF
         Xnn5j+PqGGx4Wm/kHsFXFRBbyfv4nnFZx78labVUjDFQ94aBomm3YflCSQ6g6c+dFfaC
         v77W+zd4DmQLNDwEf5SY/Y7+o//E6S5bnoqUZTUtEBrOkb/gBAtP/GGcDgCVnkGvl6Yi
         zWj5INwjIuB97oNBi7TRrt61H0CqgYmH3+wQhGJVeu9w6XP5r0hecxFDDdysSoqIj3Bx
         A71Q==
X-Gm-Message-State: AOJu0YyKQIMLmOm98mGGmyCk3yCUkdkFnMjNnTVIiY48XZzzEnL2qw/i
	cpMfiFKPS9gDv2hzZws9uMERohbPiF4ctyOvWA6aVU+/CTOzuGbl5vLlw77myoABACXDxMSrkuQ
	pl6WYWRjshBhQswVKn5o2Ztpdt+DPpaaTzw==
X-Gm-Gg: ASbGncsqzo+YW6hejD2w/uNSNL3hbYbdNMMZDqM4cuNeDPc+jjheRIBuzssNP5+eU/I
	Iaky/j+pR6KhSHVolbqIoZsbZn8QxiuWGwKUHVnyf8m4ypht0DH4CQSt7wn/APO+G4OXgO4fBky
	7Mh1SV+SmfJTGJ20a/xSB1JDDDgIUnaFNbZ9LaLnbaIIzeVCSFoMp7pRLx/dXb8C/PAtlXcWKcT
	iIgbmWfzWVWlCilmAUHQSUojcI/QXVh/9V0E/m1lrLZcmuAWmklw+PkcViLkPDBgxbT8rGe7IPf
	jS4MTAtlLLeGnXXTnMdNAhhOaQ==
X-Google-Smtp-Source: AGHT+IGK4Z4Kv2FqkizLHigzRnceBO7U3En3YHtYtCmhE7XDaEXb6vBHEzGU7LHIfrhBlm9LfbjccASttSsc+pc3Zdk=
X-Received: by 2002:a17:902:f601:b0:274:5030:2906 with SMTP id
 d9443c01a7336-297e56d0d6dmr25052125ad.46.1762586255117; Fri, 07 Nov 2025
 23:17:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1751647559.git.scott.murray@konsulko.com> <ce65d0a7-4873-434d-98eb-dd5bf922b565@gmail.com>
In-Reply-To: <ce65d0a7-4873-434d-98eb-dd5bf922b565@gmail.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Sat, 8 Nov 2025 08:17:21 +0100
X-Gm-Features: AWmQ_bkksAMOwhlkCw96yUSWuS1ymMIV-a0kGwPeA51TPxo1RAryNV91GTjQICA
Message-ID: <CAApg2=RARDxjHn5XmD_uWfY=Y-2zhyS+GuMLqh_mRDQTCsj3jg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 00/12] Initial fixes for
 master branch
To: yocto-patches@lists.yoctoproject.org
Cc: Scott Murray <scott.murray@konsulko.com>, marta.rybczynska@ygreky.com
Content-Type: multipart/alternative; boundary="0000000000009f504206431017e9"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 07:17:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2431

--0000000000009f504206431017e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Gyorgy,
Positively yes, it is on my list just after the poky split. On the news
side, we have the CI working now.

Kind regards,
Marta

On Fri, Nov 7, 2025 at 5:35=E2=80=AFPM Gyorgy Sarvari via lists.yoctoprojec=
t.org
<skandigraun=3Dgmail.com@lists.yoctoproject.org> wrote:

> On 7/4/25 19:11, Scott Murray via lists.yoctoproject.org wrote:
> > There is still
> > quite a bit of work to recreate a working CI setup, as well as ensuring
> > walnascar and scarthgap branches are in a testable state.
>
> Is the Scarthgap branch still planned to be resurrected?
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2430):
> https://lists.yoctoproject.org/g/yocto-patches/message/2430
> Mute This Topic: https://lists.yoctoproject.org/mt/113986841/5827677
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13234581/5827677/971=
106717/xyzzy
> [rybczynska@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--0000000000009f504206431017e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Gyorgy,</div><div>Positively yes, it is on my l=
ist just after the poky split. On the news side, we have the CI working now=
.</div><div><br></div><div>Kind regards,</div><div>Marta<br></div></div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Fri, Nov 7, 2025 at 5:35=E2=80=AFPM Gyorgy Sarvari via <a h=
ref=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;skandi=
graun=3D<a href=3D"mailto:gmail.com@lists.yoctoproject.org">gmail.com@lists=
.yoctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On 7/4/25 19:11, Scott Murray via <a href=3D"http://lists.=
yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.o=
rg</a> wrote:<br>
&gt; There is still<br>
&gt; quite a bit of work to recreate a working CI setup, as well as ensurin=
g<br>
&gt; walnascar and scarthgap branches are in a testable state.=C2=A0 <br>
<br>
Is the Scarthgap branch still planned to be resurrected?<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#2430): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/2430" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/2430</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/113986841/582=
7677" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/113986841/5827677</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13234581/5827677/971106717/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13234581/5827677/9711067=
17/xyzzy</a> [<a href=3D"mailto:rybczynska@gmail.com" target=3D"_blank">ryb=
czynska@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--0000000000009f504206431017e9--

