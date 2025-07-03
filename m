Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2454AC77B7C
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 15:34:07 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web11.25701.1751556841896146447
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Jul 2025 08:34:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=KA4dJ5fP;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.171, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-710fe491842so77731747b3.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 03 Jul 2025 08:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1751556841; x=1752161641; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZ3YNruSsb1dUf7uGeymVx0UgYaK/QCF32CV/fgm1mI=;
        b=KA4dJ5fPN+QlzUOnwMdnoTJAzOkORQ8cebN3VXvPEwsfKXcI2Hi/Jfya9p1vGKeEl5
         zEeF0IfVaIWS9kuoh9QeFrfbicz/jhL44MXZmywwI/3Vs16o+XGwBS4HU+n8pJreAT9M
         Qo2VXjXRyKefPv9+NLwaQI095bhQcseD//lY2zVVmJukb1dNSOioqBOpsX7WSWLS5Rve
         2DT9DRBYA7I3hTjnuYpqG8HNDV1gI3fd/iiX1MtBI7ksn192Rl9U3lsya4khJYMrULw2
         LkHdO4Mtz259tYi9XjZOC+pUNxl/nLmXW2SYVMNTTdo9IV3dQ9yVRfjzP+Neq+TRr++r
         1kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751556841; x=1752161641;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZ3YNruSsb1dUf7uGeymVx0UgYaK/QCF32CV/fgm1mI=;
        b=oH0e6UBTTAI/LMH/ZdLBOWtEa0wgWrJDa0Ixve+dKFS5+b4FXd/LbmpxgMR9j0DSrM
         hTVAwB52W+nFxCTf61tjRGKOzH3qtNyLIkboABAMh2QiMYFlNNCql1+cSwnw5NqkwNfV
         cBXwZt66G86vSvcr9AGzphh7rxk2Y3RpfCWRlEcsKilOFj5kH/7Rsueir+zn7lfs2SyP
         /pb1PoqbKYS0jzvshKyRfOI85x+IGKmMz/Ih/9CHyke6g6sV149tmlhACbUdQpF5Xl1J
         8Ys2cXAkqo0KqZ6dQ5C6m3ImIHlLRn8/u6Fpun16CGzrqWuWWAOJNF/mQ6zTRQoDCHM5
         QKYg==
X-Gm-Message-State: AOJu0Yx60O5Hhy3gq5/DFHFq/9jiEhu7pRAhpjUNdx52Jg7JmpzDXzaU
	oK9XFqh379rd6lywaukme0imMaXW1VsBTtpO9TZcQnJNcztCeKUP33G5JQusbRwXF45gHbdu/JS
	yr+IfqggnvNtZKC8iGtFA0MBhLPEkBjyV6TarzZf1CqyluoUG44EnJP3Lh31G
X-Gm-Gg: ASbGnctXPtIZXJFZjBEH7eklTYEtXm9Ss1SP5EJctXupduOI3HMLN/LWmozT59tsISQ
	QcOHEd1wnMQpUm7ZtBmZC/nLsDfJHKHU/4nlnAcsnk5fWUNiUYQFYU82BDXi8lnzY9xPTtWeSc9
	ad3urpU3aBeB10zR7QmQM5y7BCZtl0ZaWL+AXkG7C+MQUskewlWv3sNbc=
X-Google-Smtp-Source: AGHT+IFBgyQQJx7qZMAukbvAacn6iA2ufXs1Mv4v+Rl5255rgQyBnhnWjq1V9fPwjonenWE3fU6mmfYVG3k4SROZvA0=
X-Received: by 2002:a05:690c:7244:b0:714:31:c9c6 with SMTP id
 00721157ae682-7165a3df146mr51396847b3.30.1751556840665; Thu, 03 Jul 2025
 08:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <zPYp.1751544122388050827.FCRW@lists.yoctoproject.org>
In-Reply-To: <zPYp.1751544122388050827.FCRW@lists.yoctoproject.org>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Thu, 3 Jul 2025 09:33:49 -0600
X-Gm-Features: Ac12FXwW8E3KRALjVicHbwFoSAowzf7w2G-emCV3qB9iHJaym4mnJcCGByWFugQ
Message-ID: <CAOU5ZMsa5usmFrNo+eyP7RhaH6s3WFtmC=GtJRVipBv1jtvmWg@mail.gmail.com>
Subject: Re: [yocto-patches] [ptest-runner][RFC] Implement ptest-runner to
 match previous documentation and current state of run-ptest scripts
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000004ac4980639081b3c"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Jul 2025 15:34:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1746

--0000000000004ac4980639081b3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 6:02=E2=80=AFAM Erik Schumacher via lists.yoctoproje=
ct.org
<erik.schumacher=3Diris-sensing.com@lists.yoctoproject.org> wrote:

> Hi,
>

Hi Erik,

Thanks for looking into this,


> regarding the discussion on the docs mailing list about the behavior of
> the ptest-runner [1], it got me thinking that maybe the tool that runs al=
l
> ptests should be adopted. There are a lot of run-ptest scripts that adher=
ed
> to the documentation and were carefully written to print "PASS:", "FAIL:"
> or "SKIP:" to report the test results. The change in the documentation th=
at
> was just applied, does not fix the underlying problem that the ptest-runn=
er
> is currently not very useful. It will probably take a long time until all
> run-ptest scripts follow the new guidelines of what the scripts should
> print and how they should exit. Until then, the ptest-runner itself could
> be replaced by a simple shell script that just runs all run-ptest scripts=
,
> as the output of ptest-runner (exit code and xml) might hide test failure=
s
> and can not be trusted.
>
> In my opinion, a ptest-runner should work with what is already there. It
> should parse the output, looking for lines starting with "PASS:", "FAIL:"
> or "SKIP:", keep track of the test cases inside a run-ptest script and
> should output valid junit.xml files.
>

I agree, so I propose adding a couple of options (naming on discussion)
plus a enabled analysis file with a list of ptests:

analyze: Enables output analysis of PASS, FAIL, SKIP on enabled ptests in
the file.
analyze-strict: Enables output analysis on all ptests no take into account
the enabled ptest file.

With the strict version we will be able to run ptests and find issues then
fix and grow the enabled analysis file to complete coverage.


>
> Therefore, I implemented a proof-of-concept drop-in replacement in
> Python3, using only built-in libraries. It's about 200 lines of code and
> does all the above: Finding and selecting run-ptest scripts to run, parsi=
ng
> and collecting stdout, analyzing the results and creating a junit.xml fil=
e.
> Some work is still needed to fix minor issues, but with this message I
> wanted to ask if you are interested in this re-implementation of the
> ptest-runner? And if so, how to proceed?
>

A little bit of story, Initially the ptest-runner was on shell then python
finally decided to write in C because we aim to be able run on a tiny
system, which doesn't have a python3 interpreter installed.

Cheers!,
Anibal


>
> [1] https://lists.yoctoproject.org/g/docs/topic/113728319
>
> Best regards
> Erik Schumacher
> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#1743)
> <https://lists.yoctoproject.org/g/yocto-patches/message/1743> | Reply to
> Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20%5Byocto-patches%5D=
%20%5Bptest-runner%5D%5BRFC%5D%20Implement%20ptest-runner%20to%20match%20pr=
evious%20documentation%20and%20current%20state%20of%20run-ptest%20scripts>
> | Reply to Sender
> <erik.schumacher@iris-sensing.com?subject=3DPrivate:%20Re:%20%5Byocto-pat=
ches%5D%20%5Bptest-runner%5D%5BRFC%5D%20Implement%20ptest-runner%20to%20mat=
ch%20previous%20documentation%20and%20current%20state%20of%20run-ptest%20sc=
ripts>
> | Mute This Topic <https://lists.yoctoproject.org/mt/113964431/8181911> |=
 New
> Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/8181911> | Contac=
t
> Group Owner <yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13235916/8181911/17=
931940/xyzzy>
> [anibal@limonsoftware.com]
> _._,_._,_
>
>

--0000000000004ac4980639081b3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 3, =
2025 at 6:02=E2=80=AFAM Erik Schumacher via <a href=3D"http://lists.yoctopr=
oject.org">lists.yoctoproject.org</a> &lt;erik.schumacher=3D<a href=3D"mail=
to:iris-sensing.com@lists.yoctoproject.org">iris-sensing.com@lists.yoctopro=
ject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div>Hi,</div></blockquote><div><br></div><div>Hi Erik,</div><div><=
br></div><div>Thanks for looking into this,</div><div><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<div>=C2=A0</div>
<div>regarding the discussion on the docs mailing list about the behavior o=
f the ptest-runner [1], it got me thinking that maybe the tool that runs al=
l ptests should be adopted. There are a lot of run-ptest scripts that adher=
ed to the documentation and were carefully written to print &quot;PASS:&quo=
t;, &quot;FAIL:&quot; or &quot;SKIP:&quot; to report the test results. The =
change in the documentation that was just applied, does not fix the underly=
ing problem that the ptest-runner is currently not very useful. It will pro=
bably take a long time until all run-ptest scripts follow the new guideline=
s of what the scripts should print and how they should exit. Until then, th=
e ptest-runner itself could be replaced by a simple shell script that just =
runs all run-ptest scripts, as the output of ptest-runner (exit code and xm=
l) might hide test failures and can not be trusted.</div>
<div>=C2=A0</div>
<div>In my opinion, a ptest-runner should work with what is already there. =
It should parse the output, looking for lines starting with &quot;PASS:&quo=
t;, &quot;FAIL:&quot; or &quot;SKIP:&quot;, keep track of the test cases in=
side a run-ptest script and should output valid junit.xml files.</div></blo=
ckquote><div><br></div><div>I agree, so I propose adding a couple of option=
s (naming on discussion) plus a enabled analysis file with a list of=C2=A0p=
tests:</div><div><br></div><div>analyze: Enables output analysis of PASS, F=
AIL, SKIP on enabled ptests in the file.</div><div>analyze-strict: Enables =
output analysis on all ptests no take into account the enabled ptest file.<=
/div><div><br></div><div>With the strict version we will be able to run pte=
sts and find issues then fix and grow the=C2=A0enabled analysis file to com=
plete coverage.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<div>=C2=A0</div>
<div>Therefore, I implemented a proof-of-concept drop-in replacement in Pyt=
hon3, using only built-in libraries. It&#39;s about 200 lines of code and d=
oes all the above: Finding and selecting run-ptest scripts to run, parsing =
and collecting stdout, analyzing the results and creating a junit.xml file.=
 Some work is still needed to fix minor issues, but with this message I wan=
ted to ask if you are interested in this re-implementation of the ptest-run=
ner? And if so, how to proceed?</div></blockquote><div><br></div><div>A lit=
tle bit of story, Initially the ptest-runner was on shell then python final=
ly decided to write in C because we aim to be able run on a tiny system, wh=
ich doesn&#39;t have a python3 interpreter installed.</div><div><br></div><=
div>Cheers!,</div><div>Anibal</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<div>=C2=A0</div>
<div>[1] <a href=3D"https://lists.yoctoproject.org/g/docs/topic/113728319" =
rel=3D"noopener" target=3D"_blank">https://lists.yoctoproject.org/g/docs/to=
pic/113728319</a></div>
<div>=C2=A0</div>
<div>Best regards</div>
<div>Erik Schumacher</div>


<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/1743" tar=
get=3D"_blank">View/Reply Online (#1743)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20%5=
Byocto-patches%5D%20%5Bptest-runner%5D%5BRFC%5D%20Implement%20ptest-runner%=
20to%20match%20previous%20documentation%20and%20current%20state%20of%20run-=
ptest%20scripts" target=3D"_blank">Reply to Group</a>
 =20
    | <a href=3D"mailto:erik.schumacher@iris-sensing.com?subject=3DPrivate:=
%20Re:%20%5Byocto-patches%5D%20%5Bptest-runner%5D%5BRFC%5D%20Implement%20pt=
est-runner%20to%20match%20previous%20documentation%20and%20current%20state%=
20of%20run-ptest%20scripts" target=3D"_blank">Reply to Sender</a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/113964431/8181911" target=3D=
"_blank">Mute This Topic</a>


| <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post" target=3D=
"_blank">New Topic</a>

<br>




<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/8181911" =
target=3D"_blank">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" target=3D"_bl=
ank">Contact Group Owner</a> |

<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13235916/81=
81911/17931940/xyzzy" target=3D"_blank">Unsubscribe</a>

 [<a href=3D"mailto:anibal@limonsoftware.com" target=3D"_blank">anibal@limo=
nsoftware.com</a>]<br>
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<p></p><p></p></blockquote></div></div>

--0000000000004ac4980639081b3c--

