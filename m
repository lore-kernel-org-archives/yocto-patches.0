Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF47ED13C1E
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 14:20:07 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20449.1769437200516219636
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 06:20:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=3SvjZJnN;
 spf=pass (domain: smile.fr, ip: 209.85.221.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fed090e5fso2766080f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 06:20:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769437199; cv=none;
        d=google.com; s=arc-20240605;
        b=JvKcLOHnO/pERjwTzkw/+LFFW8Qk5ad8mfRVKKFjIfKZPywQqaOplsIrCva5iDpnVw
         q5p8Rh53u6JKGYS4u1v/lJRgDK32XfsFAzSYfltCXEllc5RrpcT5gJt04jWS3d0UXerH
         judq9ktPfqCblTJ8Bu9L+ygeD8mNCUk8E3YrwFOW0njFq3yOj3v0TxmsfC34dtOGh+sF
         hRevE2N0kpi6p85msjuvn2PPIBzH/bsBFLfcLqgjCDZeJTWTbhZEA92SR1QSD8q24MpK
         +Be33BieS6otfbL6VIOsSiYIwu8fFVB9w7bC8Yu85B7NzULnOfmJrKF2ew5Ef/rBohQe
         w6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RZ+ciX2+lDYgnQeRXcB+nSqJjsu66Dl0jFpSYs7q+yg=;
        fh=G2FF0qTK6PgfO3whISghi4ipu10huCXGE0j+uqU1bmg=;
        b=F6n0XJ/uQQI0LE+ryJcFadBP1fTRrcCEg79u0DHnrIwROiSFGOg8As2lQyIKKjW7uo
         PKQ4FZgSFcr9lmhD222hdE5HpBN7ycpV/+EY+h0cL3CuUBQs153MUhlaAHNJtj1tZddI
         NPaRVvrX9mFynJU1J/fBGlIahqo3BeCO7Ni17a8ho1jM87QykeQK+UJndhtHiYc6XDVf
         /4eVMHi0o3romNtDLZE2eTZsHaJ5Iqc1H0sr08q59G5ffdJPab7DJbGcjMeYG6M+sGFL
         8/Q9UHJmbb1CCip7uZmSY4UxK5ksGe2vGWEz2mGlXI/yelLXP7MP+5eIHZjUs1HEJAS8
         9awg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769437199; x=1770041999; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ+ciX2+lDYgnQeRXcB+nSqJjsu66Dl0jFpSYs7q+yg=;
        b=3SvjZJnNpuHw1ZEmD1A9gnJO3KK424xX5XnM+3Ir6Re6D+AKMlbGdLCuCD+dCDEIkb
         ur2dE5zEIZU+W5FdqGnvE76XFxuDmvvlSHbZ14B9zFIavJfUjQ11UqPtWo5kr2ImYtnK
         4HRcFcMhsJqI2nWvDINUC3jQpuMHB2O09az6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769437199; x=1770041999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ+ciX2+lDYgnQeRXcB+nSqJjsu66Dl0jFpSYs7q+yg=;
        b=FHHXo5z87P6788XGVEM8QbmK18qjIUm5hzcd7YAkuD/EmEBT5Gw52lpcYYRv9v/vSZ
         7UcM5CD2K0vn9gZsnTpBEHFJ/N/lTFpWOCL9DSStTX04xi8H7OugQ2jhpI/yWUhungVt
         dllpudv/uUEuQV+tz5vUHdyzH0OXQVFfw9TG566lSOc+VF7zca+lEDneE1X+FXR3ambm
         YB6WFX4+zPDCyW2dsZckpHr1jDV2TXew96IwkK6HUVZ2ModJmUj/nUIl02tBbCbV44p7
         G+F2x3Ts9rDycPegEt433NZnE/wOKvykUWQ93Sq6Kg1XlV81IZm/v7RCNjGMV3i7zokg
         FMgg==
X-Gm-Message-State: AOJu0YyzdGIQZOUi2dFX+nPZfghqUHYLt8nKMXX3Cq2nMIeaI9DSr6gN
	5vx1W72J8ulxYJHUnuxoap80PcZZ+PLE4VOUVX5FB287LbS35GvpCnIN9BqYbJmEJbwvuCFzzIu
	ccb0CDIsB6oxKNeiyl6cUZYJY3bX3wVpWi4N2rZi8cA==
X-Gm-Gg: AZuq6aJfWja0df+trDww91au7g8PeUxL5Cmfb/U29qkYDSEl6EYJl7lTYSgjp0gxz7s
	zY/JJGBo8VTkYNM8dPYRWitb9Y6clHuFyU2yCJ8Fp1cQapQT9P6kNO68JdcQ+ER6oTq64OsD6Le
	OpXjvAyujQ/7xFy/B1/Qr3JargmQQkPGciuyL2aTi6CwHRcK7dx1M5X5ZdITLc7Rmn/yXlvDPqn
	3dz7oAF19oVDKkzAPpxfCQAZiljEO+kboAnmGoQWABe8JtOm+wEzcs4H2zqnv9j6SrDuomM4g==
X-Received: by 2002:a05:6000:220e:b0:432:857d:e425 with SMTP id
 ffacd0b85a97d-435ca1adf07mr7098256f8f.30.1769437198525; Mon, 26 Jan 2026
 06:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20260126085252.178615-2-yoann.congal@smile.fr> <aXcy6iZSrBkErjvm@nuoska>
In-Reply-To: <aXcy6iZSrBkErjvm@nuoska>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Mon, 26 Jan 2026 15:19:32 +0100
X-Gm-Features: AZwV_QjltLpbAxaBSbOG6fipSSDTYZ3cHxrVRoB5XHmXb0uCGtVb4E3SAuL6NEo
Message-ID: <CAMSfU+7Tm8W9ZBej-L7S9tJVUo6wJx6tQmiUBWavY9XpHdJ+8Q@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] send_qa_email:
 add git-describe output if possible
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000abbabb06494b3316"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 14:20:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3081

--000000000000abbabb06494b3316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 janv. 2026 =C3=A0 10:25, Mikko Rapeli <mikko.rapeli@linaro.org> =
a
=C3=A9crit :

> Hi,
>
> On Mon, Jan 26, 2026 at 09:52:53AM +0100, Yoann Congal via
> lists.yoctoproject.org wrote:
> > From: Yoann Congal <yoann.congal@smile.fr>
> >
> > This would allow to quickly identify commits that are not on the right
> > branch.
> >
> > Partial example of output on my whinlatter-nut branch:
> >   bitbake: 74f8a927ca6a20342072e5579182aea917b6dc30
> (yocto-5.3-3-g74f8a927c)
> >   meta-yocto: 6973ca663aaa9c3ab517ee960ab7985a5bf54c07
> (yocto-5.3-1-g6973ca6)
> >   openembedded-core: b4e7819b99d9c1a8995eba87e6f466fd8c77e14a
> (yocto-5.3-73-gb4e7819b99)
> > (It shows that every commits are correctly after yocto-5.3)
>
> The output may or may not work, and may actually confuse users:
>
> bitbake$ git describe --match yocto-* origin/master
> yocto-5.3-52-gcdd79c1768ac
> core$ git describe --match yocto-* origin/master
> yocto-5.1-4541-g6c31c2a73185
> meta-yocto$ git describe --match yocto-* origin/master
> yocto-5.0.10-40-gc23c19e0b300
>
> and I don't seem to be able to find out in a few minutes which branch
> of bitbake is used with core and meta-yocto whinlatter branches
> since the branch is not called "whinlatter" but bitbake version.
> Oh bitbake default-registry/configurations/oe-nodistro-whinlatter.conf.js=
on
> has it as "2.16" but openembedded-core doesn't seem to know which bitbake
> version is correct for whinlatter.
>
> I hope this works for "whinlatter" and other releases in the future
> but the tags are a bit messy stil.
>

Yes, agreed. That works well only for stable branches after the first
release.
Maybe we can only take this patch for those branches?


> Cheers,
>
> -Mikko
>
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > ---
> >  scripts/send_qa_email.py | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
> > index e3de4b5..8d24af5 100755
> > --- a/scripts/send_qa_email.py
> > +++ b/scripts/send_qa_email.py
> > @@ -265,6 +265,15 @@ def send_qa_email():
> >          # Need the finalised revisions (not 'HEAD')
> >          targetrepodir =3D "%s/%s" % (repodir, repo)
> >          revision =3D subprocess.check_output(["git", "rev-parse",
> "HEAD"], cwd=3Dtargetrepodir).decode('utf-8').strip()
> > +
> > +        # Add git describe output if possible
> > +        try:
> > +            description =3D subprocess.check_output(["git", "describe"=
,
> "--match", "yocto-*", "HEAD"],
> > +                                                  cwd=3Dtargetrepodir,
> stderr=3Dsubprocess.DEVNULL).decode('utf-8').strip()
> > +            revision +=3D " (%s)" % description
> > +        except subprocess.CalledProcessError:
> > +            pass # ignore any error
> > +
> >          buildhashes +=3D "%s: %s\n" % (repo, revision)
> >
> >      web_root =3D utils.getconfig('WEBPUBLISH_DIR', ourconfig)
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#3077):
> https://lists.yoctoproject.org/g/yocto-patches/message/3077
> > Mute This Topic: https://lists.yoctoproject.org/mt/117465359/7159507
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13178654/7159507/914=
336139/xyzzy
> [mikko.rapeli@linaro.org]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> >
>


--=20
Yoann Congal
Smile ECS

--000000000000abbabb06494b3316
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=
=C2=A0lun. 26 janv. 2026 =C3=A0=C2=A010:25, Mikko Rapeli &lt;<a href=3D"mai=
lto:mikko.rapeli@linaro.org" target=3D"_blank">mikko.rapeli@linaro.org</a>&=
gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Hi,<br>
<br>
On Mon, Jan 26, 2026 at 09:52:53AM +0100, Yoann Congal via <a href=3D"http:=
//lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">lists.yoctop=
roject.org</a> wrote:<br>
&gt; From: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=
=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; <br>
&gt; This would allow to quickly identify commits that are not on the right=
<br>
&gt; branch.<br>
&gt; <br>
&gt; Partial example of output on my whinlatter-nut branch:<br>
&gt;=C2=A0 =C2=A0bitbake: 74f8a927ca6a20342072e5579182aea917b6dc30 (yocto-5=
.3-3-g74f8a927c)<br>
&gt;=C2=A0 =C2=A0meta-yocto: 6973ca663aaa9c3ab517ee960ab7985a5bf54c07 (yoct=
o-5.3-1-g6973ca6)<br>
&gt;=C2=A0 =C2=A0openembedded-core: b4e7819b99d9c1a8995eba87e6f466fd8c77e14=
a (yocto-5.3-73-gb4e7819b99)<br>
&gt; (It shows that every commits are correctly after yocto-5.3)<br>
<br>
The output may or may not work, and may actually confuse users:<br>
<br>
bitbake$ git describe --match yocto-* origin/master<br>
yocto-5.3-52-gcdd79c1768ac<br>
core$ git describe --match yocto-* origin/master<br>
yocto-5.1-4541-g6c31c2a73185<br>
meta-yocto$ git describe --match yocto-* origin/master<br>
yocto-5.0.10-40-gc23c19e0b300<br>
<br>
and I don&#39;t seem to be able to find out in a few minutes which branch<b=
r>
of bitbake is used with core and meta-yocto whinlatter branches<br>
since the branch is not called &quot;whinlatter&quot; but bitbake version.<=
br>
Oh bitbake default-registry/configurations/oe-nodistro-whinlatter.conf.json=
<br>
has it as &quot;2.16&quot; but openembedded-core doesn&#39;t seem to know w=
hich bitbake<br>
version is correct for whinlatter.<br>
<br>
I hope this works for &quot;whinlatter&quot; and other releases in the futu=
re<br>
but the tags are a bit messy stil.<br></blockquote><div><br></div><div>Yes,=
 agreed. That works well only for stable branches after the first release.<=
/div><div>Maybe we can only take this patch for those branches?</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Cheers,<br>
<br>
-Mikko<br>
<br>
&gt; Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.f=
r" target=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/send_qa_email.py | 9 +++++++++<br>
&gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt; <br>
&gt; diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py<br>
&gt; index e3de4b5..8d24af5 100755<br>
&gt; --- a/scripts/send_qa_email.py<br>
&gt; +++ b/scripts/send_qa_email.py<br>
&gt; @@ -265,6 +265,15 @@ def send_qa_email():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Need the finalised revisions (not =
&#39;HEAD&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 targetrepodir =3D &quot;%s/%s&quot; =
% (repodir, repo)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revision =3D subprocess.check_output=
([&quot;git&quot;, &quot;rev-parse&quot;, &quot;HEAD&quot;], cwd=3Dtargetre=
podir).decode(&#39;utf-8&#39;).strip()<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Add git describe output if possible<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 description =3D subprocess.=
check_output([&quot;git&quot;, &quot;describe&quot;, &quot;--match&quot;, &=
quot;yocto-*&quot;, &quot;HEAD&quot;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cwd=3Dtargetrepodir, stderr=3Dsubprocess.DE=
VNULL).decode(&#39;utf-8&#39;).strip()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revision +=3D &quot; (%s)&q=
uot; % description<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 except subprocess.CalledProcessError:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass # ignore any error<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buildhashes +=3D &quot;%s: %s\n&quot=
; % (repo, revision)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 web_root =3D utils.getconfig(&#39;WEBPUBLISH_DIR&#=
39;, ourconfig)<br>
&gt; <br>
&gt; <br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#3077): <a href=3D"https://lists.yoctoproject.org/g=
/yocto-patches/message/3077" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.yoctoproject.org/g/yocto-patches/message/3077</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/11746535=
9/7159507" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.=
org/mt/117465359/7159507</a><br>
&gt; Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoprojec=
t.org" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches=
/leave/13178654/7159507/914336139/xyzzy" rel=3D"noreferrer" target=3D"_blan=
k">https://lists.yoctoproject.org/g/yocto-patches/leave/13178654/7159507/91=
4336139/xyzzy</a> [<a href=3D"mailto:mikko.rapeli@linaro.org" target=3D"_bl=
ank">mikko.rapeli@linaro.org</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; <br>
&gt; <br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>
</div>
</div>

--000000000000abbabb06494b3316--

