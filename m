Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D2ED25931
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 09:40:48 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6834.1769506838134498906
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 01:40:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=LamDc08t;
 spf=pass (domain: smile.fr, ip: 209.85.221.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so5294292f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 01:40:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769506836; cv=none;
        d=google.com; s=arc-20240605;
        b=QvsrFAQq9D8NAjJKEM1W5j8Y8OWG4X6euJivD0ufYTCjkGfFc4hk5oWOjxIe33iCr8
         zBfl02W8JV5Zdwm9KPYvWy7uzdRS0IuMfsTOGsmQJQvXOI3Fi9H9WDXEXXqSFkSELAo6
         4J+M7Wqf4QEyyE1Ewh7e9HlnM7B6QpgTphZest3fnB/FPhfGqUAkSwR4f11bo9mrR9dO
         8Yaei3TcQTTBxSLAPfqzhIGed/sJo5jilg309cL0fHmEmyJlChIwUAqDd0mjctBXVgvw
         PeQNUyisUu/QUBXRVU9YlkjrdgfeAdmuYvzfhwH0h+woOsHNUpumFlTUvlwf/6nst31K
         GHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b3534bY668zyP57ty21xKYRxCxsyTui3sQEkc70l0MU=;
        fh=G2FF0qTK6PgfO3whISghi4ipu10huCXGE0j+uqU1bmg=;
        b=YB9lMdNfRArz3EYOiITLlgPMw3ugDz8lg95Zvm6bUsYKaSXyR7jK0wX516We28105/
         9SjPqRWpqDrd4A74eDnkf5WmshL7OPRIY0Ne3OfspxZJ49ojZ6OgYA7AHu5JLEP6vTDv
         S+lM3NW5XzJv70PQ6OE8rMekBoyv1oXVlDjPwdHFo5skhyZF8Bv/JuhkH78jqvOkYGxn
         yDRh4mD47bOTGbuCIPZznsIb4iuJKGT+t7xH5IL+YeU8A1H7Ar58noIAOngs6m3vYOPm
         lMEIzSFsD5l6RycqGV0D5MqNk82ymhOxXlJ/nQyjl2pNdAJz8MRywvYjXJMbdtMR6I+t
         NuuQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769506836; x=1770111636; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3534bY668zyP57ty21xKYRxCxsyTui3sQEkc70l0MU=;
        b=LamDc08tjCSM/FDRjRwvif4VLTkVa6EkAkDhrUpCICF3q+GHw5UfyhPZDfejLtyyhs
         uwU9Jv2rS9dylbAgbOe/nMaeGZQG2WRtPwSKUo+0FiXhFzXaXcmdPAj7RkVZX3veImSl
         5bUtLiHMtcS9AXAIHUAtLp43P8obvWZzIDnkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769506836; x=1770111636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3534bY668zyP57ty21xKYRxCxsyTui3sQEkc70l0MU=;
        b=WVF7nsSM9cYnvcJybXETDu2V+wOmVJpxr7BSbGR45GKkG3EmEiXZZ4e7oYjjf7laco
         SpetwWU6upkEGbDTZnLX4F/SDc//R9veVURCvv+8BIkcXOhEnpWbwxcl31yrGOYHZ+Qy
         evIFPKaRJs34UzUETTcDDeGPLfKIuknFbYymEQ7e/rwFGRN0NK6EVZWEcsZ4jP+AmWWO
         Cc9Pc6O3/a9xhGhgoHvmczjXVS9rqZKHBSAfWCfPBXY32lYEIOu7+9UXui8uZ2kG8tqi
         nh0CfEKsVJTvhGvjcM6yZ772pFCJQIeIrOq15wYwHVZPE1NmMdBp+CREvA+MAzftpm/v
         6W1A==
X-Gm-Message-State: AOJu0YzVMMQ9HA0Y36iAX48wLj3TGN2sQAEo1MVq2BwPFnPgsL0BXmtr
	38qC94G3bOpTZbQOq440qyvCrhuElVbQ0Vf0yL/icrKEVJz2iQQQgbnBnKwQ5XleMCNlEzmD+aQ
	7axyDialBFmpEYRYiyEoJSesFdl3Boh9dwSK8o6eoXA==
X-Gm-Gg: AZuq6aLtWsXdu8lz6zOZ0oJkXV6dwh0ptRK+eXm/5rmwKQntIlunAVBdRsYp9IEnsHP
	gN1WAuS7dhptlaVIHzThY3hQbvtMmp2/jgeoC4IIianas7pW551DK74jBW/ZkOV/o5Wg+zE+WaN
	AQKjewCKrtODwet9ueEqvPFrZrLs+IrdqDwJa175UOnXEcHYqBl/L4GVqeyPJiQbL4J2LXStH1w
	6X0/nI8DVSWixHsLuuVewLIvup+8G0je2591sFEEj4l+oruxXoVEibmsCwjHQnyapzmQpe1OJr0
	6F43FBpp4gPmLiLBCvhIT0Pod9Rs
X-Received: by 2002:a05:6000:18a8:b0:430:f65d:c0df with SMTP id
 ffacd0b85a97d-435dd1cca3amr1689954f8f.56.1769506836461; Tue, 27 Jan 2026
 01:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20260126085252.178615-2-yoann.congal@smile.fr>
 <aXcy6iZSrBkErjvm@nuoska> <CAMSfU+7Tm8W9ZBej-L7S9tJVUo6wJx6tQmiUBWavY9XpHdJ+8Q@mail.gmail.com>
In-Reply-To: <CAMSfU+7Tm8W9ZBej-L7S9tJVUo6wJx6tQmiUBWavY9XpHdJ+8Q@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 27 Jan 2026 10:40:10 +0100
X-Gm-Features: AZwV_Qhju3HSgbM4WNX1Sijl7PSLQjdbf19w8CjR1jncpwbh-f4FvTatuBLYDZw
Message-ID: <CAMSfU+5Kx7GNqRgymCn0WzKGZZfz7E7Pt5tZNLi+U1bn5aTjYA@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] send_qa_email:
 add git-describe output if possible
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000006a4e6006495b6aa3"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 09:40:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3114

--0000000000006a4e6006495b6aa3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 janv. 2026 =C3=A0 15:19, Yoann Congal <yoann.congal@smile.fr> a
=C3=A9crit :

>
>
> Le lun. 26 janv. 2026 =C3=A0 10:25, Mikko Rapeli <mikko.rapeli@linaro.org=
> a
> =C3=A9crit :
>
>> Hi,
>>
>> On Mon, Jan 26, 2026 at 09:52:53AM +0100, Yoann Congal via
>> lists.yoctoproject.org wrote:
>> > From: Yoann Congal <yoann.congal@smile.fr>
>> >
>> > This would allow to quickly identify commits that are not on the right
>> > branch.
>> >
>> > Partial example of output on my whinlatter-nut branch:
>> >   bitbake: 74f8a927ca6a20342072e5579182aea917b6dc30
>> (yocto-5.3-3-g74f8a927c)
>> >   meta-yocto: 6973ca663aaa9c3ab517ee960ab7985a5bf54c07
>> (yocto-5.3-1-g6973ca6)
>> >   openembedded-core: b4e7819b99d9c1a8995eba87e6f466fd8c77e14a
>> (yocto-5.3-73-gb4e7819b99)
>> > (It shows that every commits are correctly after yocto-5.3)
>>
>> The output may or may not work, and may actually confuse users:
>>
>> bitbake$ git describe --match yocto-* origin/master
>> yocto-5.3-52-gcdd79c1768ac
>> core$ git describe --match yocto-* origin/master
>> yocto-5.1-4541-g6c31c2a73185
>> meta-yocto$ git describe --match yocto-* origin/master
>> yocto-5.0.10-40-gc23c19e0b300
>>
>> and I don't seem to be able to find out in a few minutes which branch
>> of bitbake is used with core and meta-yocto whinlatter branches
>> since the branch is not called "whinlatter" but bitbake version.
>> Oh bitbake
>> default-registry/configurations/oe-nodistro-whinlatter.conf.json
>> has it as "2.16" but openembedded-core doesn't seem to know which bitbak=
e
>> version is correct for whinlatter.
>>
>> I hope this works for "whinlatter" and other releases in the future
>> but the tags are a bit messy stil.
>>
>
> Yes, agreed. That works well only for stable branches after the first
> release.
> Maybe we can only take this patch for those branches?
>

This is something I can check locally before greenlighting a build for QA,
just tried it for 4.0.33-rc3.
=3D> We can drop this patch.


>
>> Cheers,
>>
>> -Mikko
>>
>> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>> > ---
>> >  scripts/send_qa_email.py | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
>> > index e3de4b5..8d24af5 100755
>> > --- a/scripts/send_qa_email.py
>> > +++ b/scripts/send_qa_email.py
>> > @@ -265,6 +265,15 @@ def send_qa_email():
>> >          # Need the finalised revisions (not 'HEAD')
>> >          targetrepodir =3D "%s/%s" % (repodir, repo)
>> >          revision =3D subprocess.check_output(["git", "rev-parse",
>> "HEAD"], cwd=3Dtargetrepodir).decode('utf-8').strip()
>> > +
>> > +        # Add git describe output if possible
>> > +        try:
>> > +            description =3D subprocess.check_output(["git", "describe=
",
>> "--match", "yocto-*", "HEAD"],
>> > +                                                  cwd=3Dtargetrepodir=
,
>> stderr=3Dsubprocess.DEVNULL).decode('utf-8').strip()
>> > +            revision +=3D " (%s)" % description
>> > +        except subprocess.CalledProcessError:
>> > +            pass # ignore any error
>> > +
>> >          buildhashes +=3D "%s: %s\n" % (repo, revision)
>> >
>> >      web_root =3D utils.getconfig('WEBPUBLISH_DIR', ourconfig)
>> >
>> >
>> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> > Links: You receive all messages sent to this group.
>> > View/Reply Online (#3077):
>> https://lists.yoctoproject.org/g/yocto-patches/message/3077
>> > Mute This Topic: https://lists.yoctoproject.org/mt/117465359/7159507
>> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
>> > Unsubscribe:
>> https://lists.yoctoproject.org/g/yocto-patches/leave/13178654/7159507/91=
4336139/xyzzy
>> [mikko.rapeli@linaro.org]
>> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> >
>> >
>>
>
>
> --
> Yoann Congal
> Smile ECS
>


--=20
Yoann Congal
Smile ECS

--0000000000006a4e6006495b6aa3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0lun. 26=
 janv. 2026 =C3=A0=C2=A015:19, Yoann Congal &lt;<a href=3D"mailto:yoann.con=
gal@smile.fr">yoann.congal@smile.fr</a>&gt; a =C3=A9crit=C2=A0:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0lun. 26 janv. 2026 =
=C3=A0=C2=A010:25, Mikko Rapeli &lt;<a href=3D"mailto:mikko.rapeli@linaro.o=
rg" target=3D"_blank">mikko.rapeli@linaro.org</a>&gt; a =C3=A9crit=C2=A0:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
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
/div><div>Maybe we can only take this patch for those branches?</div></div>=
</div></div></div></blockquote><div><br></div><div>This is something I can =
check locally before greenlighting a build for QA, just tried it for 4.0.33=
-rc3.</div><div>=3D&gt; We can drop this patch.</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
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
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000006a4e6006495b6aa3--

