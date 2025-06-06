Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F8C5AD49
	for <webhook@archiver.kernel.org>; Fri,  6 Jun 2025 15:52:43 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web10.36899.1749225155102584864
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Jun 2025 08:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=JDFnV38O;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.170, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70f94fe1e40so34912337b3.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Jun 2025 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1749225154; x=1749829954; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J6ibGf4iXTq5PdG5BqfcdCTnGUlrzvGJQ2R7ua8c118=;
        b=JDFnV38OKnHNqE8uzrcggbSaOmC3BdmC9f1iyoUEyIllrb9X0v4mnkUueekUIdbA4N
         lr6PH/c2Es++qWePzaAivgEin/bI6/LSA55cbgSvgalAYG+cnsUKx/Qzkc3l8qMPImj+
         09PPsmIXMKSecQ+x0ozF6DvEWfjS/L/3D2w4PyueP5VbtWzrVdop14WtnIoebFDoLM1k
         GmrYTJ8jrW+rpFyFinUDos6sseHMuqODAdosQyK9KUBe44vAhw6lk95KGCYj+7UJDUm1
         ByCwDtzJoK8wHOGBOTnjA9IlB0u4LX5x3HGGRM70RvCxaajRgemtZvoEHuAomaC7mwTx
         Rg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749225154; x=1749829954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6ibGf4iXTq5PdG5BqfcdCTnGUlrzvGJQ2R7ua8c118=;
        b=miUsW8QvcbeHewOOL4tuA4qEuJAT44K1FMBLY41UG8TU7msf9uCTjTgD3VYn7TcVLz
         VoQQUwl+91cBaPTknxwk7ZrqoKYn794nYrDWmJUo/RFMlFV92zlJOwaWVo/zgBZSJRyc
         DGfSU4sd7vqBHWjZbNxCU7GRPQ3+7Vk+n6JTzEjzuIZPPb4NazBpieA85cBuWBHRmy7r
         ttwkwT6Vj8Kym2rro5XUvCfoFJhOq6EaCQPpDtWp/ZUwMoRW1aJ0lxmfhcu+0ZmLBLit
         /0Br4LnRZK4vM4NRX7IgZgQF508XNCWAZTXndcrhVgOvfY93V64HgtCKTKb0Z9bjvnJ6
         +VBw==
X-Gm-Message-State: AOJu0YzeyeMnv8wXRxRz70j0kb8vr2MEpBuB1rYhYy/yjIq5jyMtATbm
	qA+FFSPsKR21WVwh9nV/K2l2kV1KWkdQ+QZ2h0LmZFJTO1B5Y5u5N3TNmPTpZY+RZvEHO9dfgIr
	1WKoWdyhF180K7QwQmr0RGqa5qMnEVRUxFZMt+broyE6PG4JslaLcTgDohA==
X-Gm-Gg: ASbGnct3hpsQQvupRMc/otganzbHQ/rptkRhKqit0SuQKfmJQEgZUUqYWPdknfPv1SO
	VGfoZld8yGtrseKZnDcuEBwyJkzYpWDYOjyYj0UXIoWGRZq8RHaqMYgnJuzdDvyCMFF5B8TE0m3
	aDQtWYKASBK9F1lVZ+AkR8SWC2p09Zo+TcCJTjMouT6eR/
X-Google-Smtp-Source: AGHT+IHx8L8+pp5gNZsSKzK/27sDk8gUbQ/kOb6WHtQfQ3FXGf2DU+tELy0SjnkBhLmCLrWXcrUwkuXLAFyqkadPSkM=
X-Received: by 2002:a05:690c:448c:b0:70e:39e:91c2 with SMTP id
 00721157ae682-710f9e9a58bmr39118297b3.11.1749225153963; Fri, 06 Jun 2025
 08:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <a0b99adcf8925e0462b9e9f77f1b51e7ede61d22.camel@iris-sensing.com>
In-Reply-To: <a0b99adcf8925e0462b9e9f77f1b51e7ede61d22.camel@iris-sensing.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Fri, 6 Jun 2025 09:52:23 -0600
X-Gm-Features: AX0GCFu8crqvf7VXRH-K_YavkfXtiRLgsEOEhS6M4QpxuBq5epwC297ezNd-x5o
Message-ID: <CAOU5ZMuqoy0Vu1OjN2+DOZNLfMY3J4q5uicSXV_dtk9epWgf_A@mail.gmail.com>
Subject: Re: [ptest-runner][RESEND] Documentation and behavior do not match
To: Erik Schumacher <erik.schumacher@iris-sensing.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Content-Type: multipart/alternative; boundary="000000000000ef41010636e9373b"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Jun 2025 15:52:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1622

--000000000000ef41010636e9373b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Erick,

Thanks for look into this,

On Thu, Jun 5, 2025 at 11:52=E2=80=AFPM Erik Schumacher <
erik.schumacher@iris-sensing.com> wrote:

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

Yes is the current implemented logic, at the level of the runner we do not
know the internals of the
tests so we rely only on the exit code (Unix-like) to set a testsuite being
passed or fail.



> Why I think this is a problem:
>
> The behavior of ptest-runner somehow contradicts the documentation,
> which describes what the output of the script should look like. The
> documentation says nothing about the exit code being relevant. There is
> no run-ptest script that explicitly returns the right exit code. There
> are some that implicitly pass the exit code of the only / or last
> command, like gzip [6].
>

That is missing on the docs, thanks for pointing out, I will get updated.


> Using the generated xml file in a Gitlab testing pipeline will lead to
> a false sense of security that all tests would have been successful,
> even if they might not be.
>
> By relying on the exit code, ptest-runner also treats a run-ptest
> script as a single unit which can either pass or fail, even though a
> ptest might consists of multiple test cases ([3] or [4]).
>

It is a complex case because it depends on the intrinsics of the testsuite
we are executing, of course we have an
integration wrapper via run-ptest.

Adding an extra flag to ptest-runner (--strict) to analyze the test output
and decide if fail or not is a possible course of action.
Then we can work on get the ptest suites fixed with "strict" mode and later
enable by default,

We can find issues like an Internal test on glibc fails but is not a
failure for us, so we will need to maintain some whitelisting.

Cheers!,
Anibal


>
>
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

--000000000000ef41010636e9373b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Erick,<div><br></div><div>Thanks=C2=A0=
for look into this,</div></div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 5, 2025 at 11:52=
=E2=80=AFPM Erik Schumacher &lt;<a href=3D"mailto:erik.schumacher@iris-sens=
ing.com">erik.schumacher@iris-sensing.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Hi,<br>
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
treated as fail.<br></blockquote><div><br></div><div>Yes is the current imp=
lemented logic, at the level of the runner we do not know the internals of =
the<br>tests so we rely only on the exit code (Unix-like) to set a testsuit=
e being passed or fail.</div><div><br></div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
Why I think this is a problem:<br>
<br>
The behavior of ptest-runner somehow contradicts the documentation,<br>
which describes what the output of the script should look like. The<br>
documentation says nothing about the exit code being relevant. There is<br>
no run-ptest script that explicitly returns the right exit code. There<br>
are some that implicitly pass the exit code of the only / or last<br>
command, like gzip [6].<br></blockquote><div><br></div><div>That is missing=
 on the docs, thanks for pointing out, I will get updated.</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
Using the generated xml file in a Gitlab testing pipeline will lead to<br>
a false sense of security that all tests would have been successful,<br>
even if they might not be.<br>
<br>
By relying on the exit code, ptest-runner also treats a run-ptest<br>
script as a single unit which can either pass or fail, even though a<br>
ptest might consists of multiple test cases ([3] or [4]).<br></blockquote><=
div><br></div><div>It is a complex case because it depends on the intrinsic=
s of the testsuite we are executing, of course we have an <br>integration w=
rapper via run-ptest.<br><br>Adding an extra flag to ptest-runner (--strict=
) to analyze the test output and decide if fail or not is a possible course=
 of action.<br>Then we can work on get the ptest suites fixed with &quot;st=
rict&quot; mode and later enable by default,<br><br>We can find issues like=
 an Internal test on glibc fails but is not a failure for us, so we will ne=
ed to maintain some whitelisting.</div><div><br></div><div>Cheers!,</div><d=
iv>Anibal</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
<br>
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
</blockquote></div></div>

--000000000000ef41010636e9373b--

