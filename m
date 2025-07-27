Return-Path: <rwmacleod@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A9EC87FCE
	for <webhook@archiver.kernel.org>; Sun, 27 Jul 2025 19:56:02 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.66704.1753646154765795731
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 27 Jul 2025 12:55:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=a79CUp0F;
 spf=pass (domain: gmail.com, ip: 209.85.214.182, mailfrom: rwmacleod@gmail.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23602481460so37361025ad.0;
        Sun, 27 Jul 2025 12:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753646154; x=1754250954; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6KkNF00+3a2Q+emNPo1EJsif6NbhF58IiYw1uPrO1As=;
        b=a79CUp0FeOSoI/2RQ6MCMzq/FUKIq1HcxOMoV7ATsmnPLCrT48PPafGfrOkj9P4sYT
         gJ0R6wplFaIgWPMmQRl26volS1iHfC2/Pqy34hcX+fCnq/moV30O5SPkDgeIEtLCiDs8
         2Gd52G3o3ja4R1yjaqdqNwd1JIbU9PB4n6RcDo7O81OC4eirWSxKoPanVPx8ynTmpkR9
         ZJPANU2UI5kCAl/nRdUu6G9oIUvAyGIBn/khPhm55ZYZotBdpB8GnZJeIexkCL4j8sjf
         aoiD70web7cSIXxxuGJiiBRup7puXH9sxoqqgD8HpxrIU1zUsJbR2u4XrwIKjs3mIM13
         FN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753646154; x=1754250954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KkNF00+3a2Q+emNPo1EJsif6NbhF58IiYw1uPrO1As=;
        b=RTGEwrgMCa8PhHHv6TnAYMkrVtkubAinfRN0TddHU6FHIkhygSiGYen8Q0w2QCvenq
         5SE+JikKZXMcw8IJUFHV7aHPHZpQwNN7Qy3wVyLOhlDKZBEHnLB6jyP1DQLF3SCI4sR0
         SD6egiKc8hHyls5u/Jy3u3JVJO3//NhqjJalD8zwVmCfOx257Jlxvei33mnlkcgV6K9H
         s/pieNBTZ5jQ1B4MO5snifjHYmVm0DnhkZWgUz8E6kg/wUJVRkxBCHlQvvvi0dXa9L0k
         Er9Q7U/gNfSLBmS+ZDxTavQNeVUVEbqydAjvWsu27kgqIdhbIzol4c4AmAVW7d8fXulZ
         BDFg==
X-Gm-Message-State: AOJu0YxtlUMGbag9NQAr7sKURRm9TABQSYI8RUw0XN0tFCDPj7OfsO4I
	1dkRWIqa+Sd8a/1g7rEihzCM+jp+F7ObR2Wbp5shSfH/r0RjOeyc717A+jJuyEody+A2zS8RTMb
	kOdqPSv3EcmY8YSliL9B28cdTwFDVvmLW/g==
X-Gm-Gg: ASbGncvKLmLP+r90DlebAkI3j0AelS/7WMlSs8iO0nC/6S3/YbjV4oh1mCgCEowVyGy
	aggrNEJ4OcWbjp95JEEo2vTxdoF743u/P0b9JS3/kFtTY81lRn6m9qLOGBTth1VnPQtdfIxkHrt
	ykcEJGkSBoycxFMMrYW913PYkRRwJrXK8WrADYIQhNmYb5YkGXb1Uyb9K1tSEZy0qzZDYYqC+wt
	yPym/RaRg==
X-Google-Smtp-Source: AGHT+IHizWdsnNwMrduIMxvfueVXZ5FnzrNie7vFW+bW491u6SoZvoH/kAW+cJIm8yTMfg6jIomEeFGPKrkV98hPTQ8=
X-Received: by 2002:a17:903:3b8b:b0:223:65dc:4580 with SMTP id
 d9443c01a7336-23fb31b11e2mr124756225ad.52.1753646153580; Sun, 27 Jul 2025
 12:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <26140.1750230376932992667@lists.yoctoproject.org>
 <9960.1750237305887246239@lists.yoctoproject.org> <00589c87-6ba2-ae3b-525c-b09d1b08d72c@konsulko.com>
In-Reply-To: <00589c87-6ba2-ae3b-525c-b09d1b08d72c@konsulko.com>
From: Randy MacLeod <rwmacleod@gmail.com>
Date: Sun, 27 Jul 2025 16:55:44 -0300
X-Gm-Features: Ac12FXzLoEFLJPgkrxyQ_kqCcFWeVSx5ISod58GrhsWn727UjhqFla2jR-1zuI4
Message-ID: <CAK6=ix7bdKAMos-VCPxPQ1=fUia8jFYD7RHXzoGYhizM_+mQBA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][Build error]
 Rust 1.80.0
To: yocto-patches@lists.yoctoproject.org
Cc: "lepotoman via lists.yoctoproject.org" <lepotoman=msn.com@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="0000000000000bc728063aee90e9"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 27 Jul 2025 19:56:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1874

--0000000000000bc728063aee90e9
Content-Type: text/plain; charset="UTF-8"

As Scott said, this sounds like an of build environment.

If you are still unable to build, you could describe your build system and
state exactly what steps you take to build.

Also, are you able to build core-image-sato with poky? What branch and
commit id are you using?

Randy


../Randy/..

On Wed, Jun 18, 2025, 12:12 Scott Murray via lists.yoctoproject.org
<scott.murray=konsulko.com@lists.yoctoproject.org> wrote:

> On Wed, 18 Jun 2025, lepotoman via lists.yoctoproject.org wrote:
>
> > I don't know about how you work.
> >
> > Does I have to propose a patch ?
> >
> > I mean, if it deserve a patch, I'm ok to do it.
> >
> > Just, I don't know if the bug is due to a problem inside the
> meta-lts-mixins layer with my configuration (ie : I cross compile on arm),
> on the bug is due to an external layer I don't control (I begin in Yocto
> and everything was already setup by Asus for the TinkerBoard).
> >
> > What's your opinion ?
> >
> > I don't know if a lot of person get this problem in cross compilation...
>
> I have tried reproducing this here and cannot, and so far you are the
> only person who has reported an issue like this.  So for now, I am going
> to chalk this up to a build environment issue on your end.  The file
> ownership symptoms you have described sound somewhat similar to issues
> others have reported for other packages when using less commonly used
> filesystems or overlayfs setups with some container runtimes.  I would
> suggest trying a different build environment to see if that helps.
>
> Scott
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1661):
> https://lists.yoctoproject.org/g/yocto-patches/message/1661
> Mute This Topic: https://lists.yoctoproject.org/mt/113587898/953399
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13197878/953399/974274548/xyzzy
> [rwmacleod@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
>

--0000000000000bc728063aee90e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>As Scott said, this sounds like an of build environm=
ent.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">If you are st=
ill unable to build, you could describe your build system and state exactly=
 what steps you take to build.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Also, are you able to build core-image-sato with poky? What branch a=
nd commit id are you using?=C2=A0</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Randy</div><div dir=3D"auto"><br></div><div><br></div><div data-s=
martmail=3D"gmail_signature">../Randy/..</div></div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed,=
 Jun 18, 2025, 12:12 Scott Murray via <a href=3D"http://lists.yoctoproject.=
org">lists.yoctoproject.org</a> &lt;scott.murray=3D<a href=3D"mailto:konsul=
ko.com@lists.yoctoproject.org">konsulko.com@lists.yoctoproject.org</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">On Wed, 18 Jun 2025, lepotom=
an via <a href=3D"http://lists.yoctoproject.org" rel=3D"noreferrer noreferr=
er" target=3D"_blank">lists.yoctoproject.org</a> wrote:<br>
<br>
&gt; I don&#39;t know about how you work.<br>
&gt;<br>
&gt; Does I have to propose a patch ?<br>
&gt;<br>
&gt; I mean, if it deserve a patch, I&#39;m ok to do it.<br>
&gt;<br>
&gt; Just, I don&#39;t know if the bug is due to a problem inside the meta-=
lts-mixins layer with my configuration (ie : I cross compile on arm), on th=
e bug is due to an external layer I don&#39;t control (I begin in Yocto and=
 everything was already setup by Asus for the TinkerBoard).<br>
&gt;<br>
&gt; What&#39;s your opinion ?<br>
&gt;<br>
&gt; I don&#39;t know if a lot of person get this problem in cross compilat=
ion...<br>
<br>
I have tried reproducing this here and cannot, and so far you are the<br>
only person who has reported an issue like this.=C2=A0 So for now, I am goi=
ng<br>
to chalk this up to a build environment issue on your end.=C2=A0 The file<b=
r>
ownership symptoms you have described sound somewhat similar to issues<br>
others have reported for other packages when using less commonly used<br>
filesystems or overlayfs setups with some container runtimes.=C2=A0 I would=
<br>
suggest trying a different build environment to see if that helps.<br>
<br>
Scott<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#1661): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/1661" rel=3D"noreferrer noreferrer" target=3D"_blank">htt=
ps://lists.yoctoproject.org/g/yocto-patches/message/1661</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/113587898/953=
399" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.yoctopro=
ject.org/mt/113587898/953399</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank" rel=3D"noreferrer">yocto-patches+owner@lists.yoctoproje=
ct.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13197878/953399/974274548/xyzzy" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://lists.yoctoproject.org/g/yocto-patches/leave/13197878/95339=
9/974274548/xyzzy</a> [<a href=3D"mailto:rwmacleod@gmail.com" target=3D"_bl=
ank" rel=3D"noreferrer">rwmacleod@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--0000000000000bc728063aee90e9--

