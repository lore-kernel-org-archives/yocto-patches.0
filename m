Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43EBC61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 14:53:06 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37948.1787842382914391478
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Aug 2026 07:53:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=o1oEdw9B;
 spf=pass (domain: gmail.com, ip: 209.85.221.175, mailfrom: rybczynska@gmail.com)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bf83925ddaso913083e0c.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Aug 2026 07:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787842382; cv=none;
        d=google.com; s=arc-20260327;
        b=Eo3x4SkysneY+gY19v6lfDy7WRKRjU737Txhfubuc4YY41vMnWu/wnqtC2sZGvW0if
         RwhqB1ccp/pny9ByrkVnrhqrhFMdMN0QY3WVcC96smsKWv6dLSmeGcySdzj+p6tfM1/E
         dTw2Tn9nQynnVqKxdfWo1QQfWjMcsF+hAZAqpqL9k3F9fax2PL6sEP9kOlDdz5pn84AL
         O0gclK+lioJHHtjwJEgU8k6Au8uqP6AsKdJ7cQitfad4UTH1bBgiPASmc5FL800N5HMq
         Gf5CFRLV6Ovc0ji3LYkaKJbClxX/FcVJm61ljvx1mT+tjwcS0KLKsSfsCAbXtGBms63K
         TRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=tjuSI25Ux2tGHN+EV4CK8DeXeSa7Pt5RJ/VpC1jYpRY=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=UDSY1Ax8TA4lo7KB1bSpjl4eWdrvTEojLJoksE0Lpn1OmiR26Dth498xCdwTNPPdaJ
         yubdoV4xLyvO5h1Gc4IMI8aJWwAEATjkbbRLT+iDYARr3MQpdLnyKGj4+uMm3LDwKnxR
         3D2aorxyvJJvFBsYat5yWWhQ0wxIe0daMyH2OjU2BYmflB+tvII1R8vQT89wtVJOGHtH
         u75ogQBC2ixAw8JSKXMWgUTEKBLU7F3CXOuFd7X0b13JhsYJLlcn4NTbLENl8xjy+CS+
         emIbdzYimnw94Hc0M4Z2qrmjJ+A+S6Gy52Nc2jobBSYWKIyZeJGsF83sjSQ1sw99p8ab
         gxaw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787842382; x=1788447182; darn=lists.yoctoproject.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tjuSI25Ux2tGHN+EV4CK8DeXeSa7Pt5RJ/VpC1jYpRY=;
        b=o1oEdw9BjT9qViYCZEnwAYdy/TugLURzh/QjQzGyneIirudIHBe2gxtUChzTCSpe8d
         ITjvAF8AR28NSiBze4qu3lmmVINSYApcyDgHkP3N3G8xnuTsbt/BfA+f3xPDitBap4fR
         eUPcYYQRYvNq450/rj+3R0y2vOtuB0IgnkvZV1Rq3xZVgMOruZhMeNOHm5iispiefxfY
         iQfWQ+KyfvD5y3PqryP7B1R3aVP0EVP9IoTaUoBJtaZom7Jw+7u1hPtAqst7ORYmQDW9
         su5WYwY2PhcfxnjuAtAMTd61BxiWdrTkq3ambKmfWr5nLvPeAIVEtJNSi/GXN8ZGdLzi
         VYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787842382; x=1788447182;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tjuSI25Ux2tGHN+EV4CK8DeXeSa7Pt5RJ/VpC1jYpRY=;
        b=n8egz+PxWfe0hnhKEoGew/wuM05+kvw0Cz+ONQcjqXkSmE5OrEfJKPc0yt9ZvrmfuU
         LgRUl4BqyuvOD5DB1P7SjGvmhiVKRTsTOZmxmIwCkFKOYgwmB8RdTrFUzwtH4THJMLG7
         ni+ZhQou6U7tC4psL8JJT6rVXdBrnPRh7DsEfb6ikMTtqIKR3qvIiAu8Voeaay79QBJ6
         WL3wLPDPjPlRpTDqfMwfT2WymHpHUPt/FhguwYpfqWtBOJHwFExGsJ9IbkyVj0dPEBJb
         wmWp2jGqRNdi9Dk1QMiDqzaZoilS9uyApQNOKr8OjcTvOKBk2JavZ5rs3O5g1XCnaC2q
         VO7w==
X-Gm-Message-State: AFuF++ki17GcoFmYJUDQMXdew7dAnJvLmzED9gisTJV7I7KvF7WyfPML
	ZCdb+WFcRWsyIO4pW/ReqoqGilGNnIZBo/F71vyvyPl72W0+zgnKVC2kL1lTR3dFZfFsPbhRBWz
	WceoTDqjfhqgwD0Y4QJXIEq5rPCLVNQ5JIw==
X-Gm-Gg: AR+sD102gjG7IH5KVq0aJxdWY8GdVM+6RhIH/+yfAiPQZKXfvI5zIMYFAuy0vTeIVPY
	DYSboOgCaWyyVBBZUQVdj8KcPmDJtXTf1f0Qn0dAR3WAYTWFiRMCerD67xgzsb6sfnNYO8S8our
	gBQer5fVoGd3xzetjqtGmsTPswAI1MkhH+s0euq9PBp8EYaai4FY52AQwi+fF+TqCPWOgEbH1pW
	94DhKenixmvaB6VVF8WvBZzS49XReqrw7UD84F0MZhjQZOlkiwa5D5mR2vwZdqUFacAfomADHFQ
	Ptylqf6JWdZAlP5sdGOJp5m7YZMYAgw2Sd0ATbbFATe+tjQUg0QPByyUC7KPq2HslIqB4MUil9+
	J/fWYmqLMJHKSst8GQ5WMx+SJ2mm+0QN7
X-Received: by 2002:a05:6122:181f:b0:5bd:c27a:dafd with SMTP id
 71dfb90a1353d-5c65c0416c4mr5406345e0c.3.1787842381787; Thu, 27 Aug 2026
 07:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787777775.git.scott.murray@konsulko.com>
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Thu, 27 Aug 2026 16:52:48 +0200
X-Gm-Features: AcwNN1VWqAT7NFKLVOLkUHbuuRaV_vrITYEk2hpdUMOxoG9v0Dr5JaKROI5wtT8
Message-ID: <CAApg2=R1K19rEMTXqBwzHyJvT30n5TmzqRZ7e5nc9dqopG41Bw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 00/15] Assorted updates 08/26
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000014b763065a087e41"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Aug 2026 14:53:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4712

--00000000000014b763065a087e41
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Aug 2026, 22:58 Scott Murray via lists.yoctoproject.org,
<scott.murray=konsulko.com@lists.yoctoproject.org> wrote:

> My apologies for being slow in getting this out, this patch series rolls
> up the contributed patches from the past few months along with some
> other fixes from myself.  These changes are queued on the master-next
> branch if you would like to check them out to test yourself.  I intend
> to merge these to master branch Friday evening (EDT, August 28) unless
> there are objections.  I should have the relevant backports to wrynose
> and scarthgap out for early next week.
>
> Scott
>

Looks good to me.

Kind regards
Marta

>
>

--00000000000014b763065a087e41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 26 Aug 2026, 22:58 Scott=
 Murray via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.or=
g</a>, &lt;scott.murray=3D<a href=3D"mailto:konsulko.com@lists.yoctoproject=
.org">konsulko.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">My apologies for being slow in getting this out, this=
 patch series rolls<br>
up the contributed patches from the past few months along with some<br>
other fixes from myself.=C2=A0 These changes are queued on the master-next<=
br>
branch if you would like to check them out to test yourself.=C2=A0 I intend=
<br>
to merge these to master branch Friday evening (EDT, August 28) unless<br>
there are objections.=C2=A0 I should have the relevant backports to wrynose=
<br>
and scarthgap out for early next week.<br>
<br>
Scott<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Looks good to me.</div><div dir=3D"auto"><br></div><div dir=3D"auto">K=
ind regards=C2=A0</div><div dir=3D"auto">Marta</div><div dir=3D"auto"><div =
class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
</blockquote></div></div></div>

--00000000000014b763065a087e41--

