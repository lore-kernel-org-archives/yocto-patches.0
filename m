Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6E6CD8C88
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 03:15:48 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9809.1780715741278276377
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 20:15:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=l5UNK//N;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa5edf347eso1665605e87.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 20:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780715739; cv=none;
        d=google.com; s=arc-20240605;
        b=HfyzQB/9FMhxIWkgIfjFipCaz7QnKzvkvJV26UDSjDRd4bjlqv8AkPFtF1Oz65dmau
         RFWrMigP8qoowsEzLLBO/3lzLBb5IUjwduCEIbaZUHbGWOZ7ZxtyZ9X0p6fGZcVH3zrj
         eWg21mPX7T0/b5ZPXURrcWhCl92YshfKBF7e7HomZ30wq0EPTr3yjUc44pDDk6+9Y3Qg
         7MuI+U7xLoQNibRPK7YoQ4Nj6JYJAG25o80l6Cin1f7kQDK6xwlmuCN7iGZnGRYBzamP
         pwvrxaHRhWA8kBgkJa1LGD63AILPA8YwYRxRMjI1Qfg+cUE3NaXDYqV0cMeKWDoN90NW
         rJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=J0nfp2AokAuiDv7DxtqIsefBpJJ20fli1RffY9Wbq+4=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=Ysg597M009trE8tK4xVLzuPSO9X8EJzZ8+pSJRAxkewh9n+TNADdGKPKD1SKIavfur
         7Op36GqpXXwu1rV3KrfZbUhqXk819NMeT9QyLAR/vdI9qPjFNjY4XcTdIkgfuCaTwOoT
         9WLFDAROLl2c+TszK1OnI4XbQMPJvsRM9/XCY2t4FtYcIQV+jgTqhjKn4KeF8sXZHnsg
         yt1YZ1jstB2cifWtv9VDAMaN8q4cBZ0MKE5yOAPGWdKHUa42tc6Ss8DD/Fz44KH6u6KC
         uz+eGCiAXujnXZ3T1k1IrYZj270YQFAC6tFUq+43+cRe8xgbsSugEQdO5Ipa3YdQc6ff
         mPAQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780715739; x=1781320539; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0nfp2AokAuiDv7DxtqIsefBpJJ20fli1RffY9Wbq+4=;
        b=l5UNK//NZJSmMwMo518/ocnNr86tyv0L2iVx5tnqBoqP47nFpWm4A1Lb1wn2Iz1dyW
         mkzFfeIs4kAE5zSwooj9KOY+XeRD+BLd3B/NIGe7dIMFPMZCfqD4xYm161dWNq1iTNPU
         ATvmn9xWhqkxC/sLfgZnkLdUn3m1XcwVyvzqgBVr35esCOHFV8+mSjbe70hDfnK6AI/c
         6tzPaaS5v1GgLCvrjWAvBYzBamsGbwa6r7ws8hVouxZ/6MAxzJLr4eBBWJ3CeT2H2o3e
         ZFwooQDRdY32IkldNaH1Q04B1x/DDBj5qq92T2W9N5bT8gFbH6+8hz4VJ8guNaPxdf+q
         o+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780715739; x=1781320539;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0nfp2AokAuiDv7DxtqIsefBpJJ20fli1RffY9Wbq+4=;
        b=qw7M2oE0RiJHoUvbAZ5jugCTscnSeutUGkT9Fr6cmXkIN8ZM6L92mIo+ezAzh1+iag
         7OBKdwqbPwXQk3ydZiB8qlFTU04VpsS4/Q1fEg0ortfTNarxbSo+KCRn/nXmfy9045I9
         aJGQb3hAit9x8ITchsSnmZwaLnmg2Qldfi3+p7wtHNlVIo4QHaW0UbIaptYSsN2rgjeQ
         rctsReg5RXB2Chh47ZPy0ee0lPhD4KMwjErNC8b0oUqTfzwiCkSqSDdQrFadqf2/gi/X
         G2iMI1pGdlrHsWasd7F2Um+B+hgKoEAWTAV7giPcC1FbbIbK6Ek6dN1rdtcuawz8uUyI
         U+SQ==
X-Gm-Message-State: AOJu0YzCb0JXqlOmtw6YzEsjSQJZclvnkxqJiP6uUKrFDG0HJi2jwq+b
	hzSvGxfDQd9GRBw+vbXGP3kSuqdrpo8bvW9skfzv03H5kqKwa9Ofc9m60iFpQVC+Nni+IAobBbJ
	LQGd8mXhSaaCIJY7UX0GJy3rjVZztauamouuH
X-Gm-Gg: Acq92OE42Jt3kijqSgij3DaCn/22qLKL3+Q/TSN5W1IS/nshwmZpYhDrxLdKKmw4csG
	g1rivSL7Bonafd5fwQkE5MARkFAag/s9bxjZ3rNGxvt8CFlf07ob7WYwBPHHHQ+Opw+HhX11U/u
	9qOgHD6DKZBV0ByTY6nKPrmih9JOUErVCo4oek2tOTDAuf2TcXLdZgr3vKjaQ5LpDLABnxs6BjV
	0NAsWMquw/6+fjEA9vokhduU9QYZiUpVq4XPAqyTY79L2i1bvzVGIt0BIS5bDMsAOCJVFcrjWVx
	VXM+UFCTUBsAqrfptQ==
X-Received: by 2002:ac2:4e10:0:b0:5aa:6c89:72d8 with SMTP id
 2adb3069b0e04-5aa87b7ee90mr1785786e87.19.1780715739162; Fri, 05 Jun 2026
 20:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780354513.git.tim.orling@konsulko.com> <ee99d892018112109ab1b0e6f3ec8899918bdc52.1780354513.git.tim.orling@konsulko.com>
 <02f0c35f16a8a51bbe0e89145353008f67180a84.camel@pbarker.dev>
In-Reply-To: <02f0c35f16a8a51bbe0e89145353008f67180a84.camel@pbarker.dev>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 5 Jun 2026 20:15:25 -0700
X-Gm-Features: AVVi8CfFoqFf6NFt_-4_jHCBa2EHoS5F0JTX_vyD7X9wxE-XwbfQXgr9JvLSV6o
Message-ID: <CANx9H-AGFF3VP_SiUvqWGCHCWB1y2M0ofPb=iA6SjsugJzZRig@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v2 01/10]
 scripts/utils: fix stale extraction dir when tarball is updated
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000142c9006538d31f3"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 03:15:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4165

--000000000000142c9006538d31f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 3:22=E2=80=AFAM Paul Barker via lists.yoctoproject.o=
rg <paul=3D
pbarker.dev@lists.yoctoproject.org> wrote:

> On Mon, 2026-06-01 at 16:18 -0700, Tim Orling via lists.yoctoproject.org
> wrote:
> > From: Tim Orling <tim.orling@konsulko.com>
> >
> > Previously the entire download/cache-validation block in
> > setup_tools_tarball() was guarded by `if not os.path.exists(btdir)`.
> > Once the extraction directory existed from a prior build, every
> > subsequent call was a no-op: the cached tarball was never re-validated,
> > so a freshly-published SDK (e.g. vcontainer-tarball-latest) was silentl=
y
> > ignored and the stale btdir kept being used.
> >
> > Fix by moving the lock/download block outside the btdir existence guard
> > so cache validation always runs. Track tarball_updated to know when the
> > cached download was actually replaced, then remove the stale btdir when
> > True so the fresh tarball is re-extracted.
> >
> > Also add an mtime-based staleness check for local-path (cp) sources so
> > that a newer source file automatically invalidates the cached copy.
> >
> > AI-Generated: Claude Cowork Sonnet 4.6
> > Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> > ---
> >  scripts/utils.py | 64 +++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 41 insertions(+), 23 deletions(-)
> >
> > diff --git a/scripts/utils.py b/scripts/utils.py
> > index 88842f0..87acad6 100644
> > --- a/scripts/utils.py
> > +++ b/scripts/utils.py
> > @@ -481,31 +481,49 @@ def setup_tools_tarball(ourconfig, btdir,
> bttarball, name=3D"buildtools"):
> >          if ";" in bttarball:
> >              bttarball, sha256 =3D bttarball.split(";")
> >          btdir =3D os.path.abspath(btdir)
> > +        btdlpath =3D getconfig("BASE_SHAREDDIR", ourconfig) +
> "/cluster-downloads-cache/" + os.path.basename(bttarball)
> > +        btlock =3D btdlpath + ".lock"
> > +        if not os.path.exists(os.path.dirname(btdlpath)):
> > +            os.makedirs(os.path.dirname(btdlpath), exist_ok=3DTrue)
> > +        # Always run the cache-validation / download step so that a
> freshly
> > +        # published tarball is detected even when btdir already exists
> from a
> > +        # previous build.  tarball_updated is set to True whenever the
> cached
> > +        # download is replaced, which triggers removal of the stale
> btdir.
> > +        tarball_updated =3D False
> > +        while True:
> > +            try:
> > +                with open(btlock, 'a+') as lf:
> > +                    fileno =3D lf.fileno()
> > +                    fcntl.flock(fileno, fcntl.LOCK_EX)
> > +                    if sha256 and os.path.exists(btdlpath):
> > +                        dl_sha256 =3D sha256_file(btdlpath)
> > +                        if dl_sha256 !=3D sha256:
> > +                            os.unlink(btdlpath)
> > +                    elif bttarball.startswith("/") and
> os.path.exists(btdlpath):
> > +                        # For local-path sources (e.g.
> vcontainer-tarball-latest)
> > +                        # invalidate the cached copy when the source i=
s
> newer so
> > +                        # that a freshly-published tarball is always
> picked up.
> > +                        if os.path.getmtime(bttarball) >
> os.path.getmtime(btdlpath):
> > +                            os.unlink(btdlpath)
> > +                        os.unlink(btdlpath)
> > +                    if not os.path.exists(btdlpath):
> > +                        if bttarball.startswith("/"):
> > +                            subprocess.check_call(["cp", bttarball,
> btdlpath])
> > +                        else:
> > +                            subprocess.check_call(["wget", "-O",
> btdlpath, bttarball])
> > +                        os.chmod(btdlpath, 0o775)
> > +                        tarball_updated =3D True
> > +                break
> > +            except OSError:
> > +                # We raced with someone else, try again
> > +                pass
>
> Hi Tim,
>
> This loop allows us to handle random OSError conditions caused by a
> race, but it turns a deterministic OSError into an infinite loop. The
> logic already exists, you're just moving it around, but now I have seen
> it I cannot unsee it!
>
> Should we add a timeout while we are here?
>

This patch was already merged, but the timeout concern was submitted
separately:
https://lore.kernel.org/yocto-patches/20260606011918.61582-1-tim.orling@kon=
sulko.com/


>
> > +        # If the underlying tarball changed, remove any stale extracti=
on
> > +        # directory so it is re-extracted below.
> > +        if tarball_updated and os.path.exists(btdir):
> > +            print("Removing stale %s extraction at %s" % (name, btdir)=
)
> > +            subprocess.check_call(["rm", "-rf", btdir])
> >          if not os.path.exists(btdir):
> > -            btdlpath =3D getconfig("BASE_SHAREDDIR", ourconfig) +
> "/cluster-downloads-cache/" + os.path.basename(bttarball)
> >              print("Extracting %s %s" % (name, bttarball))
> > -            btlock =3D btdlpath + ".lock"
> > -            if not os.path.exists(os.path.dirname(btdlpath)):
> > -                os.makedirs(os.path.dirname(btdlpath), exist_ok=3DTrue=
)
> > -            while True:
> > -                try:
> > -                    with open(btlock, 'a+') as lf:
> > -                        fileno =3D lf.fileno()
> > -                        fcntl.flock(fileno, fcntl.LOCK_EX)
> > -                        if sha256 and os.path.exists(btdlpath):
> > -                            dl_sha256 =3D sha256_file(btdlpath)
> > -                            if dl_sha256 !=3D sha256:
> > -                                os.unlink(btdlpath)
> > -                        if not os.path.exists(btdlpath):
> > -                            if bttarball.startswith("/"):
> > -                                subprocess.check_call(["cp", bttarball=
,
> btdlpath])
> > -                            else:
> > -                                subprocess.check_call(["wget", "-O",
> btdlpath, bttarball])
> > -                            os.chmod(btdlpath, 0o775)
> > -                    break
> > -                except OSError:
> > -                    # We raced with someone else, try again
> > -                    pass
> >              subprocess.check_call(["bash", btdlpath, "-d", btdir, "-y"=
])
> >          enable_tools_tarball(btdir, name)
>
> Best regards,
>
> --
> Paul Barker
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4110):
> https://lists.yoctoproject.org/g/yocto-patches/message/4110
> Mute This Topic: https://lists.yoctoproject.org/mt/119603240/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000142c9006538d31f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 2, =
2026 at 3:22=E2=80=AFAM Paul Barker via <a href=3D"http://lists.yoctoprojec=
t.org">lists.yoctoproject.org</a> &lt;paul=3D<a href=3D"mailto:pbarker.dev@=
lists.yoctoproject.org">pbarker.dev@lists.yoctoproject.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 2026-06-0=
1 at 16:18 -0700, Tim Orling via <a href=3D"http://lists.yoctoproject.org" =
rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.org</a><br>
wrote:<br>
&gt; From: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.com" target=
=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; <br>
&gt; Previously the entire download/cache-validation block in<br>
&gt; setup_tools_tarball() was guarded by `if not os.path.exists(btdir)`.<b=
r>
&gt; Once the extraction directory existed from a prior build, every<br>
&gt; subsequent call was a no-op: the cached tarball was never re-validated=
,<br>
&gt; so a freshly-published SDK (e.g. vcontainer-tarball-latest) was silent=
ly<br>
&gt; ignored and the stale btdir kept being used.<br>
&gt; <br>
&gt; Fix by moving the lock/download block outside the btdir existence guar=
d<br>
&gt; so cache validation always runs. Track tarball_updated to know when th=
e<br>
&gt; cached download was actually replaced, then remove the stale btdir whe=
n<br>
&gt; True so the fresh tarball is re-extracted.<br>
&gt; <br>
&gt; Also add an mtime-based staleness check for local-path (cp) sources so=
<br>
&gt; that a newer source file automatically invalidates the cached copy.<br=
>
&gt; <br>
&gt; AI-Generated: Claude Cowork Sonnet 4.6<br>
&gt; Signed-off-by: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.co=
m" target=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/utils.py | 64 +++++++++++++++++++++++++++++++-----------=
------<br>
&gt;=C2=A0 1 file changed, 41 insertions(+), 23 deletions(-)<br>
&gt; <br>
&gt; diff --git a/scripts/utils.py b/scripts/utils.py<br>
&gt; index 88842f0..87acad6 100644<br>
&gt; --- a/scripts/utils.py<br>
&gt; +++ b/scripts/utils.py<br>
&gt; @@ -481,31 +481,49 @@ def setup_tools_tarball(ourconfig, btdir, bttarb=
all, name=3D&quot;buildtools&quot;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;;&quot; in bttarball:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bttarball, sha256 =3D =
bttarball.split(&quot;;&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btdir =3D os.path.abspath(btdir)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 btdlpath =3D getconfig(&quot;BASE_SHAREDD=
IR&quot;, ourconfig) + &quot;/cluster-downloads-cache/&quot; + os.path.base=
name(bttarball)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 btlock =3D btdlpath + &quot;.lock&quot;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(os.path.dirname(btd=
lpath)):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.makedirs(os.path.dirname=
(btdlpath), exist_ok=3DTrue)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Always run the cache-validation / downl=
oad step so that a freshly<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # published tarball is detected even when=
 btdir already exists from a<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # previous build.=C2=A0 tarball_updated i=
s set to True whenever the cached<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # download is replaced, which triggers re=
moval of the stale btdir.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tarball_updated =3D False<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 while True:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(btl=
ock, &#39;a+&#39;) as lf:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 fileno =3D lf.fileno()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 fcntl.flock(fileno, fcntl.LOCK_EX)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if sha256 and os.path.exists(btdlpath):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 dl_sha256 =3D sha256_file(btdlpath)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if dl_sha256 !=3D sha256:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(btdlpath)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 elif bttarball.startswith(&quot;/&quot;) and os.path.exists(btdlpath):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 # For local-path sources (e.g. vcontainer-tarball-latest)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 # invalidate the cached copy when the source is newer so<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 # that a freshly-published tarball is always picked up.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if os.path.getmtime(bttarball) &gt; os.path.getmtime(btdlpat=
h):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(btdlpath)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 os.unlink(btdlpath)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if not os.path.exists(btdlpath):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if bttarball.startswith(&quot;/&quot;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subprocess.check_call([&quot;cp&quot;, bttarba=
ll, btdlpath])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subprocess.check_call([&quot;wget&quot;, &quot=
;-O&quot;, btdlpath, bttarball])<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 os.chmod(btdlpath, 0o775)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 tarball_updated =3D True<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except OSError:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # We raced wi=
th someone else, try again<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
<br>
Hi Tim,<br>
<br>
This loop allows us to handle random OSError conditions caused by a<br>
race, but it turns a deterministic OSError into an infinite loop. The<br>
logic already exists, you&#39;re just moving it around, but now I have seen=
<br>
it I cannot unsee it!<br>
<br>
Should we add a timeout while we are here?<br></blockquote><div><br></div><=
div>This patch was already merged, but the timeout concern was submitted se=
parately:<br><a href=3D"https://lore.kernel.org/yocto-patches/2026060601191=
8.61582-1-tim.orling@konsulko.com/">https://lore.kernel.org/yocto-patches/2=
0260606011918.61582-1-tim.orling@konsulko.com/</a></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # If the underlying tarball changed, remo=
ve any stale extraction<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # directory so it is re-extracted below.<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if tarball_updated and os.path.exists(btd=
ir):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Removing stale =
%s extraction at %s&quot; % (name, btdir))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subprocess.check_call([&quo=
t;rm&quot;, &quot;-rf&quot;, btdir])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(btdir):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btdlpath =3D getconfig(&quo=
t;BASE_SHAREDDIR&quot;, ourconfig) + &quot;/cluster-downloads-cache/&quot; =
+ os.path.basename(bttarball)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Extracting=
 %s %s&quot; % (name, bttarball))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btlock =3D btdlpath + &quot=
;.lock&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(os.pa=
th.dirname(btdlpath)):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.makedirs(o=
s.path.dirname(btdlpath), exist_ok=3DTrue)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while True:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 with open(btlock, &#39;a+&#39;) as lf:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 fileno =3D lf.fileno()<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 fcntl.flock(fileno, fcntl.LOCK_EX)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if sha256 and os.path.exists(btdlpath):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dl_sha256 =3D sha256_file(btdlpath)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if dl_sha256 !=3D sha256:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(btdlpath)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if not os.path.exists(btdlpath):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if bttarball.startswith(&quot;/&quot;):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subprocess.check_call([&quot;cp&=
quot;, bttarball, btdlpath])<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subprocess.check_call([&quot;wge=
t&quot;, &quot;-O&quot;, btdlpath, bttarball])<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chmod(btdlpath, 0o775)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 break<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except OSErro=
r:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 # We raced with someone else, try again<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pass<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 subprocess.check_call(=
[&quot;bash&quot;, btdlpath, &quot;-d&quot;, btdir, &quot;-y&quot;])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_tools_tarball(btdir, name)<br=
>
<br>
Best regards,<br>
<br>
-- <br>
Paul Barker<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#4110): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/4110" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/4110</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/119603240/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/119603240/924729</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13169857/924729/1023951714/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/10239517=
14/xyzzy</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticot=
imo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div></div>

--000000000000142c9006538d31f3--

