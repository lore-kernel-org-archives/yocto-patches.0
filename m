Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9709.1792459599982632316
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 18:26:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fB1kniot;
 spf=pass (domain: gmail.com, ip: 209.85.128.180, mailfrom: raj.khem@gmail.com)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b06c0794cfso23538377b3.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 18:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792459599; cv=none;
        d=google.com; s=arc-20260327;
        b=d8tAqpEgzhfJHXY7J+eiZnW/j5Z/aTE9Ka0EX/dg5FkByPgBmjRk7j7RTckO0EbPB3
         soOlnLfq+yy0DmJvriMKDJ7pRUCrCT50bBWepI0xyaxRNvNzngUJnxTkYl42xyIgQl15
         vD6YXtDIwk6RHGlsAyYMHnueKRZ2koWfEzxtT0F+QQ7RbMISrhwtSNXvLtI0jhmjsRc4
         hqO8p5O4nnt54wsGDrhJVenznjm7DzDzN9Bhc+tSgtXWZrON1KECdNCoaz2SmHdpnaCC
         HMLA8VjU+rlck7hAr+U/8dWGUagnFJqD4aPqlftoqy2NBtx4RCEiQ6IryQUSuYcuYOdH
         pTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RQMsB8LN+mBh9EMtXgoScYc07am4nxZW7+FvJecMOYM=;
        fh=5n1l9ClUU2n8NCvynOdAYuW3ZfEeOx0UqsUvFizfswc=;
        b=cG43CPfySdHQuiPbtjCw75PDn9Am1k6R6DNRPK9S9zUhB5WK5TN89bqYxf8rgzmauB
         LcTdacfySdjLeOHcvBmTNp1P6y42TyC/9aTFXzSOMYh2Yrha363Cyr6fji/brjKoPbWl
         AIeSGm/kPB4Uj2cq4cZD5EboPPK1RpdH6XTmOQd0xqKSsWaYOxcSrjzlCufGcjGYAhC0
         VzNIKXy/O5YYc43Tj76bfmkOiAmAI1iOk0Tpwkp1MUKLMcjmJXVe35dTyc3LxcBmor8r
         r70r/ifxxOZbXFx4trTxdSZkxWwfNKVi1JSYqyBNVZkKr7H/OPVhp39fzkyZfySOLaj9
         THoA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792459599; x=1793064399; darn=lists.yoctoproject.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQMsB8LN+mBh9EMtXgoScYc07am4nxZW7+FvJecMOYM=;
        b=fB1kniotn3yWzcLZXkf18jYnMwVOwPY6LR+JBTKUnym4YYTxQnA7bd+dhv5gUMqy/s
         Ricg3JV3r5LYefr61atqSA9oa0o7taKFd1iS83xoSA/yIll0qkh/t2WesqIZk+xw1ih7
         UPiiLereEY+MLv60C6rZhffB0tQYAHnmqsAxgS7DZ94wTcbn4x9MuP4/HSMRbHhqe2NZ
         RSku4xvN3Hsj+RO1UvjatSHU70yZ/UXwxjgfwB7LyeWG2coW1NcWY4S6V+pVCjQ0+O6O
         H84CMWABYKOGg2vC8BxxzXTCMT21Fmdc39wBEqroTsQsYQdY46DoDurD9egg7jfjZfqV
         aVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792459599; x=1793064399;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RQMsB8LN+mBh9EMtXgoScYc07am4nxZW7+FvJecMOYM=;
        b=p5L4eh/jZIzf2f07NqVVC4oOWn6qm2LKmbaAA/F0RPorUQsT3UTY2zDnPp2i706+Ce
         5I0VoPQS38VMoFfcnWPSvYtQRRscdbWUjm9DIMtcVEGcyrdh3uJ/G4NUChvvTN2uleTR
         Dtq3baOVIzYuPIltLjFh0mr8ktOwEhKT4zZUIr/vqAjGyznUtsJlKOTHXSrKGZ0l28pO
         e/TznSfivMjvZBp4qLJQZnxXyp+INY3imeSIot8jpDaYV7sfCyu0Gh/cL5I07g0I0SpN
         GUzCFMuE6QQzFYX/qLdukCW7Pu2Y7cLeAanY3fz1Kk+ySiF2zDV7aMilFRuHeNpZnqP7
         k4AQ==
X-Gm-Message-State: AFq9FYI9ioijw/0J26zBQ8xLoql9zrd0KSbjvHZwxMR1turEcfQ3xCkJ
	Nb7eJnwwYrZcdvticKovGqo2ZEk6+ykLMN/6avp75pWVbC7RJOZIeeiberq7SO9ahKtBNcDwjwC
	pI9r18s+T0nhKKKG5fHCggGi2u3C5xDKtOQ==
X-Gm-Gg: AYBFou2b0zQTCr91IzpKmhiAxxMAX8FYUsWhEhI25DYfqllIkZLZApeKR9ivRfL6ymB
	2IKoOA4/p1CoyHsGYM7FdSci1fL2cWdsdZatf8Ekllao2OvPvga+s8ba6t/u6unbBQRqfLAb7hB
	plykCwrlSc4CtfAaJyhM6KOL/oB9PnlritMuxC+8NCOeqhNKAG9wHVI65Lbxdyy0qwsfQT5XfSf
	6Ak/WGvyh8Cwp0L3/LIYQSF9lNVuy3PBeJ4iR3qZyHyOjyxyb/iV9hhoDhmyxsebqHxoe51CvJl
	iv1cQxiuVYIVASHaSkbJtp4zggB34+mucybp7prZi/vYFbVSRoWzInaUQVKdfXNbpPQVs/U9v4y
	1lXdc83gU1LUSECUQ7FCaFcSVZjSekMwnJ8/nwUW73o8e/k44zknCDdSsUQvpQ5zq3ECLjzYBH3
	gb8v5rpoMhm4PHf1lK+namVOCvAc2zYmZ6wivUJuHY/5b65tMo8G0LEOMENJL2i00bkuKZjtnNj
	InBFw6/IwmoGMmCo3cXZIuz/PZAvEUKsSLYmAbaMA1gZ/R000+IYdqAPS6WEajcg8iz6W2juHZp
	w2Q54A8K3TsvnqfnUJqMvKC3xYtRVis1N219bvw=
X-Received: by 2002:a05:690c:788:b0:8a8:8456:a970 with SMTP id
 00721157ae682-8b0f21e9dbemr34658927b3.68.1792459598996; Mon, 19 Oct 2026
 18:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260929081349.3858049-1-martin.jansa@gmail.com> <CA+chaQejuGizpQ7q0UPaLvPsc8PZhEYAanhwUPbS9=LJBmfDkQ@mail.gmail.com>
In-Reply-To: <CA+chaQejuGizpQ7q0UPaLvPsc8PZhEYAanhwUPbS9=LJBmfDkQ@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 19 Oct 2026 18:26:13 -0700
X-Gm-Features: AclHuK_mDlJZfkvaHZgmuctaGXmmIZ67Oj2HgLpDZBt2EDH5OK8aH_nqJ7soRjc
Message-ID: <CAMKF1sp31EN0ZeKGfRzAmto4N4=hv42xSs_XcMqzV=_vczh2Mw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][PATCH] layer.conf: Update to
 blacksail release
To: yocto-patches@lists.yoctoproject.org
Cc: hongxujia83@gmail.com, jiahongxujia@163.com, jiahongxu_hycx@cetc.com.cn, 
	hongxu.jia@windriver.com
Content-Type: multipart/alternative; boundary="000000000000ac27f7065e3b85af"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 01:26:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5105

--000000000000ac27f7065e3b85af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Martin, a small nit, subject says meta-security, changing it to
meta-tensorflow might help catching maintainer's attention

On Mon, Oct 19, 2026 at 7:24=E2=80=AFAM Martin Jansa via lists.yoctoproject=
.org
<martin.jansa=3Dgmail.com@lists.yoctoproject.org> wrote:

> ping
>
> On Tue, Sep 29, 2026 at 10:13=E2=80=AFAM <martin.jansa@gmail.com> wrote:
> >
> > From: Martin Jansa <martin.jansa@gmail.com>
> >
> > Changed in:
> >
> https://git.openembedded.org/openembedded-core/commit/?h=3Dblacksail&id=
=3D37623ffbdd34a5c6b3e12ee33195f8e82343f198
> >
> > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > ---
> >  conf/layer.conf | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/conf/layer.conf b/conf/layer.conf
> > index c3bd464..bad8eb1 100644
> > --- a/conf/layer.conf
> > +++ b/conf/layer.conf
> > @@ -11,7 +11,7 @@ BBFILE_PRIORITY_meta-tensorflow =3D "10"
> >
> >  LAYERVERSION_meta-tensorflow =3D "1"
> >
> > -LAYERSERIES_COMPAT_meta-tensorflow =3D "wrynose"
> > +LAYERSERIES_COMPAT_meta-tensorflow =3D "blacksail"
> >
> >  LAYERDEPENDS_meta-tensorflow =3D " \
> >      core \
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5097):
> https://lists.yoctoproject.org/g/yocto-patches/message/5097
> Mute This Topic: https://lists.yoctoproject.org/mt/121486933/1997914
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/645=
821814/xyzzy
> [raj.khem@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000ac27f7065e3b85af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Martin, a small nit, subject says meta-security, changing =
it to meta-tensorflow might help catching maintainer&#39;s attention=C2=A0<=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Oct 19, 2026 at 7:24=E2=80=AFAM Martin Jansa v=
ia <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt=
;martin.jansa=3D<a href=3D"mailto:gmail.com@lists.yoctoproject.org">gmail.c=
om@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">ping<br>
<br>
On Tue, Sep 29, 2026 at 10:13=E2=80=AFAM &lt;<a href=3D"mailto:martin.jansa=
@gmail.com" target=3D"_blank">martin.jansa@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.com" targe=
t=3D"_blank">martin.jansa@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Changed in:<br>
&gt; <a href=3D"https://git.openembedded.org/openembedded-core/commit/?h=3D=
blacksail&amp;id=3D37623ffbdd34a5c6b3e12ee33195f8e82343f198" rel=3D"norefer=
rer" target=3D"_blank">https://git.openembedded.org/openembedded-core/commi=
t/?h=3Dblacksail&amp;id=3D37623ffbdd34a5c6b3e12ee33195f8e82343f198</a><br>
&gt;<br>
&gt; Signed-off-by: Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.c=
om" target=3D"_blank">martin.jansa@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 conf/layer.conf | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/conf/layer.conf b/conf/layer.conf<br>
&gt; index c3bd464..bad8eb1 100644<br>
&gt; --- a/conf/layer.conf<br>
&gt; +++ b/conf/layer.conf<br>
&gt; @@ -11,7 +11,7 @@ BBFILE_PRIORITY_meta-tensorflow =3D &quot;10&quot;<b=
r>
&gt;<br>
&gt;=C2=A0 LAYERVERSION_meta-tensorflow =3D &quot;1&quot;<br>
&gt;<br>
&gt; -LAYERSERIES_COMPAT_meta-tensorflow =3D &quot;wrynose&quot;<br>
&gt; +LAYERSERIES_COMPAT_meta-tensorflow =3D &quot;blacksail&quot;<br>
&gt;<br>
&gt;=C2=A0 LAYERDEPENDS_meta-tensorflow =3D &quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 core \<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#5097): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/5097" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/5097</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/121486933/199=
7914" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/121486933/1997914</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13340786/1997914/645821814/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/6458218=
14/xyzzy</a> [<a href=3D"mailto:raj.khem@gmail.com" target=3D"_blank">raj.k=
hem@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--000000000000ac27f7065e3b85af--
