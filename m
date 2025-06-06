Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0520C5AD49
	for <webhook@archiver.kernel.org>; Fri,  6 Jun 2025 07:12:08 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.28241.1749193926094003030
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Jun 2025 00:12:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=uKKwiW9B;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so10129405e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Jun 2025 00:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1749193924; x=1749798724; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xieDuAQPit8Z6xwHGrzy1Xns606JKD57bwwnr4AX1bk=;
        b=uKKwiW9BtEgnpRzeHyNOIMo4kXXTWWrzaYY433srlNy4DzruaI4w+OiCEBL4o8aYnt
         hpFX5i3wq0mSAPlFTxCsHifMfSNRWzfDZtHOT1zpic/VLWKjFvAyvNt4Bey3fqq1njwH
         +cbysH2Efc33u7GaC3OE2DUXkWoQ1hJzpTX5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749193924; x=1749798724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xieDuAQPit8Z6xwHGrzy1Xns606JKD57bwwnr4AX1bk=;
        b=jhwPQM+EpuoCpO0mYm/FWvjKH9NpkmYz01mMqPxwTw7+GmGEQrsComqNekDvtm4ZaU
         /7lPpfgnnjqOT7lYVGi+m8k+Lm/c0DtPkdxtLz3Jt7QZSRQiHsiuBujxdHcwIVwAXg4F
         joF8thGtngrAtSrWOhcXYrHifaOib+KDZA62czbwvZ6X5lqKckIZWk4+G3KkNbJZgfh0
         XPfrHxKI6TGWwK8q2uyOjEVMXJBGytQzNS+hqjs5tJFJtZxZu7ccpbz6cPKW2kF25apE
         loxL24iivjkpI2JMAQvAc9nawIzCsqz5PvUYB7ya3D8IZLAyEOlZ77vOrx8jfqYT6Iqi
         hj4A==
X-Gm-Message-State: AOJu0Yw65NCnE4G37Ju/0asrcCvYtFyHkbZD4g63fxTdGrYUw4WZmdUT
	smC8RwMw2N2tHGNiDtS0f/i60RUTLaYSMzPYjq1PaWLtw1Md0XnlQcp4KKOcD7zzvgA1c9jQQpW
	nAnKJpzu2Xhlzx88+XX67otAdXW9IxC09lKKDasGY+AGtsJQ2z4yuEKqe3g==
X-Gm-Gg: ASbGncv/WOvPnhbsD1MApzBOiFs4rL+nHLs27uURCJjRWHLDpFa3YANZHZ1EgTIUDYR
	PIPwWvZ0PScqBPyGUDlaUzNk2usL42D3vyg1B6GjVZI/+GN6P0e2teSRiPZs8IwMKZCu4BPGwWu
	b/IUEaPz9m6B1mMmRgcfqe+8gkQ5Qc2/t8xi263ovkYhPF5Zy+cntw7qmLs/sg8wRG2d12qDUIj
	P2gaw==
X-Google-Smtp-Source: AGHT+IHKsVoFB5A48bwTsO273jDeVwhOyicc7sxNDezhp8nopyOUbpAmm9G9Gh7OHH3MJkNl1VWmUcBzQ95pNI/M7U4=
X-Received: by 2002:a05:600c:348f:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-452015837camr22786715e9.10.1749193924029; Fri, 06 Jun 2025
 00:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <a0b99adcf8925e0462b9e9f77f1b51e7ede61d22.camel@iris-sensing.com>
In-Reply-To: <a0b99adcf8925e0462b9e9f77f1b51e7ede61d22.camel@iris-sensing.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Fri, 6 Jun 2025 09:11:37 +0200
X-Gm-Features: AX0GCFvBO6IAklYA43RisT3kTPBsM5aJ0ULSqxqxkXrVf8irkFXQYeOg0jGetBU
Message-ID: <CAMSfU+6M0pTE1X8g3N5xPz3Uu+qpRRVTBrzJ=qnGzst+GitBuA@mail.gmail.com>
Subject: Re: [yocto-patches] [ptest-runner][RESEND] Documentation and behavior
 do not match
To: yocto-patches@lists.yoctoproject.org
Cc: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>, 
	"anibal@limonsoftware.com" <anibal@limonsoftware.com>
Content-Type: multipart/alternative; boundary="0000000000007c431d0636e1f22e"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Jun 2025 07:12:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1620

--0000000000007c431d0636e1f22e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 juin 2025 =C3=A0 07:52, Erik Schumacher via lists.yoctoproject.or=
g
<erik.schumacher=3Diris-sensing.com@lists.yoctoproject.org> a =C3=A9crit :

> Hi,
>
> I have created some ptests and executed them with the ptest-runner and
> realized that the documentation and the actual behavior of the ptest-
> runner don't really fit together.
>
> What I did:
>
> I used the wiki pages [1] and [2] as guidelines and also had a look at
> some existing run-ptest scripts like [3] and [4]. It's not entirely
> clear in the phrasing, but the documentation implies that a run-ptest
> script must print either "PASS", "FAIL" or "SKIP" followed by the
> testname. That's what most of the existing run-ptest scripts do.
> Then I created my own run-ptest script that did something like:
> /path/to/mybinary-gtest && echo "PASS: mybinary" || echo "FAIL:
> mybinary"
>
> What I expected:
>
> The script itself worked and ptest-runner was able to run it. So far,
> so good. I started to wonder when my script simulated a faulty test. My
> script printed "FAIL: mybinary", but ptest-runner completed the test
> without failures (last line: "TOTAL: 1 FAIL: 0"). I expected "FAIL: 1"
> here. The same applies to the xml output, which can be consumed by
> Gitlab when the ptest-runner runs inside a CI/CD pipeline.
>
> What I found:
>
> By looking at the code of ptest-runner, it quickly became clear to me
> that a failure is only determined by the exit code of a run-ptest
> script. See [5]. It doesn't matter what the script is printing. As long
> as the exit code is 0, the test has passed. Any other exit code is
> treated as fail.
>
> Why I think this is a problem:
>
> The behavior of ptest-runner somehow contradicts the documentation,
> which describes what the output of the script should look like. The
> documentation says nothing about the exit code being relevant. There is
> no run-ptest script that explicitly returns the right exit code. There
> are some that implicitly pass the exit code of the only / or last
> command, like gzip [6].
> Using the generated xml file in a Gitlab testing pipeline will lead to
> a false sense of security that all tests would have been successful,
> even if they might not be.
>
> By relying on the exit code, ptest-runner also treats a run-ptest
> script as a single unit which can either pass or fail, even though a
> ptest might consists of multiple test cases ([3] or [4]).
>

Agreed, there is a difference between the documentation and the code
around ptests.

We stumbled upon it recently and I opened a bug to not forget :
15832 =E2=80=93 Specify API between exit code of run-ptest and ptest-runner
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15832

BTW, the "PASS,FAIL,...", while not used by ptest-runner itself, are
used at a higher level: by testimage.


> [1] https://wiki.yoctoproject.org/wiki/Ptest
> [2] https://docs.yoctoproject.org/test-manual/ptest.html
> [3]
>
> https://git.openembedded.org/openembedded-core/tree/meta/recipes-extended=
/bc/bc/run-ptest
> [4]
>
> https://git.openembedded.org/openembedded-core/tree/meta/recipes-connecti=
vity/bluez5/bluez5/run-ptest
> [5] https://git.yoctoproject.org/ptest-runner2/tree/utils.c#n522
> [6]
>
> https://git.openembedded.org/openembedded-core/tree/meta/recipes-extended=
/gzip/files/run-ptest
>
> Signed-off-by: Erik Schumacher <erik.schumacher@iris-sensing.com>
>
> Resending this mail as I forgot to subscribe to the mailing list.
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1619):
> https://lists.yoctoproject.org/g/yocto-patches/message/1619
> Mute This Topic: https://lists.yoctoproject.org/mt/113499100/4316185
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13179410/4316185/929=
767106/xyzzy
> [yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--=20
Yoann Congal
Smile ECS

--0000000000007c431d0636e1f22e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0ven. 6 =
juin 2025 =C3=A0=C2=A007:52, Erik Schumacher via <a href=3D"http://lists.yo=
ctoproject.org">lists.yoctoproject.org</a> &lt;erik.schumacher=3D<a href=3D=
"mailto:iris-sensing.com@lists.yoctoproject.org">iris-sensing.com@lists.yoc=
toproject.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Hi,<br>
<br>
I have created some ptests and executed them with the ptest-runner and<br>
realized that the documentation and the actual behavior of the ptest-<br>
runner don&#39;t really fit together.<br>
<br>
What I did:<br>
<br>
I used the wiki pages [1] and [2] as guidelines and also had a look at<br>
some existing run-ptest scripts like [3] and [4]. It&#39;s not entirely<br>
clear in the phrasing, but the documentation implies that a run-ptest<br>
script must print either &quot;PASS&quot;, &quot;FAIL&quot; or &quot;SKIP&q=
uot; followed by the<br>
testname. That&#39;s what most of the existing run-ptest scripts do.<br>
Then I created my own run-ptest script that did something like:<br>
/path/to/mybinary-gtest &amp;&amp; echo &quot;PASS: mybinary&quot; || echo =
&quot;FAIL:<br>
mybinary&quot;<br>
<br>
What I expected:<br>
<br>
The script itself worked and ptest-runner was able to run it. So far,<br>
so good. I started to wonder when my script simulated a faulty test. My<br>
script printed &quot;FAIL: mybinary&quot;, but ptest-runner completed the t=
est<br>
without failures (last line: &quot;TOTAL: 1 FAIL: 0&quot;). I expected &quo=
t;FAIL: 1&quot;<br>
here. The same applies to the xml output, which can be consumed by<br>
Gitlab when the ptest-runner runs inside a CI/CD pipeline.<br>
<br>
What I found:<br>
<br>
By looking at the code of ptest-runner, it quickly became clear to me<br>
that a failure is only determined by the exit code of a run-ptest<br>
script. See [5]. It doesn&#39;t matter what the script is printing. As long=
<br>
as the exit code is 0, the test has passed. Any other exit code is<br>
treated as fail.<br>
<br>
Why I think this is a problem:<br>
<br>
The behavior of ptest-runner somehow contradicts the documentation,<br>
which describes what the output of the script should look like. The<br>
documentation says nothing about the exit code being relevant. There is<br>
no run-ptest script that explicitly returns the right exit code. There<br>
are some that implicitly pass the exit code of the only / or last<br>
command, like gzip [6].<br>
Using the generated xml file in a Gitlab testing pipeline will lead to<br>
a false sense of security that all tests would have been successful,<br>
even if they might not be.<br>
<br>
By relying on the exit code, ptest-runner also treats a run-ptest<br>
script as a single unit which can either pass or fail, even though a<br>
ptest might consists of multiple test cases ([3] or [4]).<br></blockquote><=
div><br></div><div>Agreed, there is a difference between=C2=A0the documenta=
tion and the code around=C2=A0ptests.</div><div><br></div><div>We stumbled =
upon it recently and I opened a bug to not forget :</div><div>15832 =E2=80=
=93 Specify API between exit code of run-ptest and ptest-runner<br><a href=
=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15832">https://bugz=
illa.yoctoproject.org/show_bug.cgi?id=3D15832</a></div><div><br></div><div>=
BTW, the &quot;PASS,FAIL,...&quot;, while not used by ptest-runner itself, =
are used=C2=A0at a higher level: by testimage.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
[1] <a href=3D"https://wiki.yoctoproject.org/wiki/Ptest" rel=3D"noreferrer"=
 target=3D"_blank">https://wiki.yoctoproject.org/wiki/Ptest</a><br>
[2] <a href=3D"https://docs.yoctoproject.org/test-manual/ptest.html" rel=3D=
"noreferrer" target=3D"_blank">https://docs.yoctoproject.org/test-manual/pt=
est.html</a><br>
[3]<br>
<a href=3D"https://git.openembedded.org/openembedded-core/tree/meta/recipes=
-extended/bc/bc/run-ptest" rel=3D"noreferrer" target=3D"_blank">https://git=
.openembedded.org/openembedded-core/tree/meta/recipes-extended/bc/bc/run-pt=
est</a><br>
[4]<br>
<a href=3D"https://git.openembedded.org/openembedded-core/tree/meta/recipes=
-connectivity/bluez5/bluez5/run-ptest" rel=3D"noreferrer" target=3D"_blank"=
>https://git.openembedded.org/openembedded-core/tree/meta/recipes-connectiv=
ity/bluez5/bluez5/run-ptest</a><br>
[5] <a href=3D"https://git.yoctoproject.org/ptest-runner2/tree/utils.c#n522=
" rel=3D"noreferrer" target=3D"_blank">https://git.yoctoproject.org/ptest-r=
unner2/tree/utils.c#n522</a><br>
[6]<br>
<a href=3D"https://git.openembedded.org/openembedded-core/tree/meta/recipes=
-extended/gzip/files/run-ptest" rel=3D"noreferrer" target=3D"_blank">https:=
//git.openembedded.org/openembedded-core/tree/meta/recipes-extended/gzip/fi=
les/run-ptest</a><br>
<br>
Signed-off-by: Erik Schumacher &lt;<a href=3D"mailto:erik.schumacher@iris-s=
ensing.com" target=3D"_blank">erik.schumacher@iris-sensing.com</a>&gt;<br>
<br>
Resending this mail as I forgot to subscribe to the mailing list.<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#1619): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/1619" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/1619</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/113499100/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/113499100/4316185</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13179410/4316185/929767106/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13179410/4316185/9297671=
06/xyzzy</a> [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_blank">yo=
ann.congal@smile.fr</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000007c431d0636e1f22e--

