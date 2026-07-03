Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA32AC43602
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 12:45:11 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.92348.1783082702231687218
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jul 2026 05:45:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=OXkNDYYY;
 spf=pass (domain: gmail.com, ip: 74.125.224.47, mailfrom: frezidok1@gmail.com)
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664b3831a20so718348d50.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 05:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783082701; cv=none;
        d=google.com; s=arc-20260327;
        b=O4eQgz67D2Pe67aORvq7RgFsG2MGDljMzxTzpWhSlARWOp2YrmwZ8/ZTht0xzGQpsT
         byBJkDPHasMTdXNwOdykYDjY/OrJeX6oqyCWgGfeThcPnsRwEEKbnDgnXhftVRhjLQLK
         TiIgV6Z032UnIV8Xy7oiDSAloPTgptdliac1rxo54rx7fxFnXMCOfk0KDnjNxoETDJmA
         HRDrr6WGhHFDs6jIqLI+Ah7tkEzyv/M4XwTEkVcvszPBKpIwLIRCVl3u8KXRSb7nnfdT
         GKqi2nQQ8W2fpQBuwdGsyTFrNz7K5KTbyrWq/B1X/SG+A+kRg0j+VUI0DNQOfrHDZXsD
         MhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b1jdK0HS9n2WuiQKdNy234FyZzqZmnu6DqLKn7I+urI=;
        fh=42AEEMDgPrAU5bQ5JFglmb8GtmOPp1g9ZYfswycdIh8=;
        b=TlgCoTXD4Hdk+o7Hg5PFEjWYFgAVXKO0SSefJ8EkQg+WdgTL5b0MpnFHmsvLvI51ge
         ++xBH0yZr433WTl2S5xWjWKO3dtlFftfjF7G7qGkh8j9o8x+PvGI4wahZomYLavw10Zb
         TZrgVlWdYVMGyEeaweE7tb+b9anlMzVa4v5Na1/hFAHenPWI/JZ5jRwsmFZBLyO0mdnZ
         G8nPr3QMZZeEqJeyVqmaEGYaqu2qA7DE2famYeMTE8QB1Pa6BLQmLeWJ/+S5iDH4Ho24
         mKbF6P209T2nPxWsbqLLRyjw298rbdkqg4yqO0AO03k2YALeew1aHVHijSAA3kzAfQAG
         d2uQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783082701; x=1783687501; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1jdK0HS9n2WuiQKdNy234FyZzqZmnu6DqLKn7I+urI=;
        b=OXkNDYYYI0Tp7oGjWqFmpuKxAlNaFzlgU7226JH5UEsDN8/7ofrJKm4g3wpo43kvsW
         Uxl87gIcpfzlOSGIbzZDnC7eZd5syLhhqov5cO8iGXB8FNkdffcy8HZGgXOm/OmWSg+5
         SiKpXu7KIZRayaaLaVI+YwjzQGbIKJl4OgAPxugAY2pbp9T5P2q7hncCvpbUMVd65ohU
         WHMzyDKfOcoIgEjGfP9WVNgs/VuRRsEEIDM05H4zElwUjPDVR8R/x+xw8DSSob13s5nq
         1YsafS0LWSY/+iusXcnZvsE1kcsCoKcKdzwDRRHWeXgoZDtIeMQI9HHDBExEV0G3FZN0
         lIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783082701; x=1783687501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1jdK0HS9n2WuiQKdNy234FyZzqZmnu6DqLKn7I+urI=;
        b=MnUpztAmR4d7jLPddj9S2wB/dnnhGk4JSwBmNQC//GCKwbtz4yzImZWaos7nbMmG+X
         Fxtj/Vkm7dRJ9CqNE+oBdvQ64XConYAABbfxDHsb9HEW/jm+NZduir9Fn7ytekLq2hqV
         pSloY+PukbdWrfUEkKQd1GNybabgfgYYKdSRG9OEyaUbO4P0c8KrdYzB6RuLJUhKkOT4
         ePwRqzzdlwOtjtQ0q+cakY8ytFaBKaSQVHvoq/10WR0txvPWsCnjimRxxzf86GmYNbpu
         uYq2b8OFVjDJdo2LEje9zHeKEETTG/YDL/Ya8cNjgsrRhBmCRdHyRCTFQ3TfpYV4vv+/
         xRbw==
X-Gm-Message-State: AOJu0Ywwjg33i+oPwHR2anV6GeS5istkFri95DrspqpU2M8vdtwmHPtU
	NW33ZD6z9hsDYUAEaVywgiWb8mMfcZcxXvbLSPK9UQJT0cfyw2en9UMiH4aS9kJG5i9x2A5orua
	hDord1/tLCDKEqQDzvC0WvBJMuDzQn+/II494
X-Gm-Gg: AfdE7cnocSvD2+8ZFhnvDTS3in/tYGH8FJJ7xKrZBC24e/nE/gYOJ+FPzdTSVjR7Zi1
	yrW9sGhLIbEV54BjweX0WdJyfSKqCgv2rq64XWH7m37w52LBAvFLDHDBG0szCsu9kOmdMm+hpPF
	9iZJN+vQfuHM3GlixJJkW8S4WyIzhET+jG3JLn6t5RyccS/98et3DPNcqwycGMI3gZKYOWk2aL7
	/h9fjHB6ZCyJgxti9k4eu7Goylzja15nRU4yDX/RKsAg8skD4yVj/28du9La2RstCYEkLfo
X-Received: by 2002:a05:690e:43db:b0:664:ac17:6014 with SMTP id
 956f58d0204a3-66521a7af3fmr7219118d50.31.1783082701068; Fri, 03 Jul 2026
 05:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
 <1783039578-31531-13-git-send-email-mark.hatle@kernel.crashing.org> <bc1f156be43b3c476a853e93321db726de900b50.camel@pbarker.dev>
In-Reply-To: <bc1f156be43b3c476a853e93321db726de900b50.camel@pbarker.dev>
From: Dmitry Sakhonchik <frezidok1@gmail.com>
Date: Fri, 3 Jul 2026 15:44:49 +0300
X-Gm-Features: AVVi8CdrkJNvTOnNFKqr8Oz9Ig2IR_gyJQq43zqfWt29zvR4CFUQTQhLgeuowDQ
Message-ID: <CAP4GjN45cuePupoA7eo=DeydCE8xQk8pUOECYs-vwCCFjvyLyw@mail.gmail.com>
Subject: Re: [yocto-patches] [pseudo][PATCH 12/23] pseudo_util: Add default
 log severity values
To: Paul Barker <paul@pbarker.dev>
Cc: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Content-Type: multipart/alternative; boundary="000000000000009cee0655b44bf7"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 12:45:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4394

--000000000000009cee0655b44bf7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

They are designed like that on purpose.
As far as I know, pseudo_debug was originally created as
a debugging mechanism for pseudo developers,
so it lets you choose "which part of what pseudo is doing right now I want
to look at as deeply as possible"
and often used when something goes wrong and you want to debug it.
On the contrary, pseudo_severity is the new mechanism that allows people to
sort their original regular user's log (make it less verbose).
For example, "I don't care about regular log messages, write something only
if warning or error".

These changes are implementing bug 12141
<https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D12141> where Seebs
suggested a new separate category.

In my opinion, these two separate mechanisms should not be merged because
they serve different categories
of people and solve different categories of problems.

As for the "errors are always printed", if it's really confusing, I can
remove "error" from default lists
as it doesn't do anything, but I included it because I wanted to explicitly
show that by default we always use these 3 categories.

Thanks for the review!

=D0=BF=D1=82, 3 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 13:43, Paul=
 Barker <paul@pbarker.dev>:

> On Thu, 2026-07-02 at 19:46 -0500, Mark Hatle wrote:
> > From: Dmitry Sakhonchik <frezidok1@gmail.com>
> >
> > Default values are "show everything". If the user wants to see
> > only certain categories, they should explicitely set
> > PSEUDO_SEVERITY env var or use -k option.
> >
> > Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
> > Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
> > ---
> >  pseudo.h      | 2 ++
> >  pseudo_util.c | 7 ++++---
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/pseudo.h b/pseudo.h
> > index 92ae71e..66aa70e 100644
> > --- a/pseudo.h
> > +++ b/pseudo.h
> > @@ -130,6 +130,8 @@ extern char *pseudo_version;
> >  #define PSEUDO_PIDFILE "pseudo.pid"
> >  #define PSEUDO_SOCKET "pseudo.socket"
> >
> > +#define PSEUDO_SEVERITY_DEFAULT "info,warn,error"
>
> This default is confusing. pseudo_error() doesn't check
> pseudo_util_severity_flags, so errors are always printed.
>
> This also isn't "show everything" as pseudo_debug() messages are not
> shown with this default severity level. They are instead controlled by
> pseudo_util_debug_flags, and having two separate sets of flags is
> another level of confusion to me.
>
> If we're overhauling the logging for v2.0, I think it would be much
> better to merge the log/debug handling into one ordered list of severity
> levels and control what is printed by specifying the minimum severity
> level to output.
>
> Best regards,
>
> --
> Paul Barker
>
>

--000000000000009cee0655b44bf7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>They are designed like that on purpo=
se.=C2=A0</div><div>As far as I know, pseudo_debug was originally created a=
s a=C2=A0debugging=C2=A0mechanism for pseudo developers,</div><div>so it le=
ts you choose &quot;<span style=3D"white-space:pre-wrap">which part of what=
 pseudo is doing right now I want to look at as deeply as possible</span>&q=
uot;</div><div>and often used when something goes wrong and you want to deb=
ug it.</div><div>On the contrary, pseudo_severity is the new mechanism that=
 allows people to sort their original regular user&#39;s log (make it less =
verbose).</div><div>For=C2=A0example, &quot;I don&#39;t care about regular =
log messages, write something only if warning or error&quot;.</div><div><br=
></div><div>These changes are implementing=C2=A0<a href=3D"https://bugzilla=
.yoctoproject.org/show_bug.cgi?id=3D12141" target=3D"_blank">bug 12141</a>=
=C2=A0where Seebs suggested a new=C2=A0<font color=3D"#000000">separate cat=
egory.</font></div><div><font color=3D"#000000"><br></font></div><div><font=
 color=3D"#000000">In my opinion, these two separate mechanisms should not =
be merged because they serve different categories</font></div><div><font co=
lor=3D"#000000">of people and solve different categories of problems.</font=
></div><div><font color=3D"#000000"><br></font></div><div>As for the &quot;=
errors are always printed&quot;, if it&#39;s really confusing, I can remove=
 &quot;error&quot; from default lists</div><div>as it doesn&#39;t do anythi=
ng, but I included it because I wanted to explicitly show that by default w=
e always use these 3 categories.</div><div><br></div><div>Thanks for the re=
view!</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=82, 3 =D0=B8=D1=8E=D0=BB. 2026=
=E2=80=AF=D0=B3. =D0=B2 13:43, Paul Barker &lt;<a href=3D"mailto:paul@pbark=
er.dev">paul@pbarker.dev</a>&gt;:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On Thu, 2026-07-02 at 19:46 -0500, Mark Hatle wrote:<br>
&gt; From: Dmitry Sakhonchik &lt;<a href=3D"mailto:frezidok1@gmail.com" tar=
get=3D"_blank">frezidok1@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Default values are &quot;show everything&quot;. If the user wants to s=
ee<br>
&gt; only certain categories, they should explicitely set<br>
&gt; PSEUDO_SEVERITY env var or use -k option.<br>
&gt; <br>
&gt; Signed-off-by: Dmitry Sakhonchik &lt;<a href=3D"mailto:frezidok1@gmail=
.com" target=3D"_blank">frezidok1@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Mark Hatle &lt;<a href=3D"mailto:mark.hatle@kernel.cras=
hing.org" target=3D"_blank">mark.hatle@kernel.crashing.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 pseudo.h=C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
&gt;=C2=A0 pseudo_util.c | 7 ++++---<br>
&gt;=C2=A0 2 files changed, 6 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/pseudo.h b/pseudo.h<br>
&gt; index 92ae71e..66aa70e 100644<br>
&gt; --- a/pseudo.h<br>
&gt; +++ b/pseudo.h<br>
&gt; @@ -130,6 +130,8 @@ extern char *pseudo_version;<br>
&gt;=C2=A0 #define PSEUDO_PIDFILE &quot;pseudo.pid&quot;<br>
&gt;=C2=A0 #define PSEUDO_SOCKET &quot;pseudo.socket&quot;<br>
&gt;=C2=A0 <br>
&gt; +#define PSEUDO_SEVERITY_DEFAULT &quot;info,warn,error&quot;<br>
<br>
This default is confusing. pseudo_error() doesn&#39;t check<br>
pseudo_util_severity_flags, so errors are always printed.<br>
<br>
This also isn&#39;t &quot;show everything&quot; as pseudo_debug() messages =
are not<br>
shown with this default severity level. They are instead controlled by<br>
pseudo_util_debug_flags, and having two separate sets of flags is<br>
another level of confusion to me.<br>
<br>
If we&#39;re overhauling the logging for v2.0, I think it would be much<br>
better to merge the log/debug handling into one ordered list of severity<br=
>
levels and control what is printed by specifying the minimum severity<br>
level to output.<br>
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
</blockquote></div></div>

--000000000000009cee0655b44bf7--

