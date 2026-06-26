Return-Path: <colinmca242@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A70C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 20:59:29 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44279.1782507565982327695
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Jun 2026 13:59:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=krEjtyyM;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: colinmca242@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6980ae819f4so2695636a12.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Jun 2026 13:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782507564; cv=none;
        d=google.com; s=arc-20260327;
        b=KVGA2gslCtwBNz0YGGK386dkGjo96PgwOiyx4dQp2CtgOWmPyc1EV77bLffsqcgvRR
         wbyGfs3fgFcn+j6vwrtk1/seCtHNrkVTb6YdUIx/PSD2li48mr259tLkVuGq+FB2onpS
         4lLvbF+GpPttOCPSZTfZZdwuE6+qJ/e/oC2hrtFNtPX5X1lHbGQ1MnvsYbCx6ujuoguc
         ac7ARco5BcYxn/Q8H6zeESpO/F9fEGQIOM9ofyzcuaSuCr+Zp1ji1DwvACSNxEix1wi4
         /43IHWFWWBIEdIAYhtKD141nsBHtRC/h4IZeKk6P4E/rngEACAvnbpl2GMZ90araOL0p
         za5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=eRDRIiz3XImXDUjVYOiE9hOsEzWLdCtLXqeSkv/nysU=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=sxrn2gExaPq3ax6fhQtOrGdXE+TIHV6orik/5rCvmMKWW4vgURA/MUUItxeAi8Q24u
         XxwG6b+oRRZh4m91u0jawurjZzz4ueZfZuBfhA4/HW0+KOZoU8YTzGj2XS7Vl3ODiOaZ
         c2qZrnp5Q6wd/sKXhLsMVWwy/nqfsqS2mCYTBFRJ5U2UIwJwOPWKosIOhYiVgt+FGKvu
         G2V8hfFvaePD9z6c36REoDZwUUORVDhHEBeUWQJQ8QZuuIjGjNRA3r8Mh3tpPpe1fGK2
         CMsPapSzDcAUfKn38vpL7KxiA/rqs7BDAuM0d3Vm8fPs27A6x3DQbMQ0gw+Wbbma1x4G
         /ZAw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782507564; x=1783112364; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRDRIiz3XImXDUjVYOiE9hOsEzWLdCtLXqeSkv/nysU=;
        b=krEjtyyMGJp1eKh+Xfz/XfjBYm7AgoE6AxbHmG/+E5q2v+F1XiuoY+mS/84wwsUr99
         xE4W+7OW0fZfkDx5c1NoDy63TXjnw0YmeRkE4IyuoLkYyU7imvQweNRPTfnc/ptoTtI5
         Q8NR+K9m+q1yV6JqP+GYjxkhkNP96blxsQL3OcIQNkA/h+FEBwpj+omzT2Pq2Cm0AwQ7
         0uSaqteQ0IC89Dtxze0BqQxXbRQi/wS2a8qhCkSpmsORADihzjraDAkFUv0qK6BtSuLw
         MD2uRERtRF1wyASbFfa7GgIGRHeE1LQXuRqxEBpHe8T5jygyxwekeJJHQn/xadRtHdQU
         U23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782507564; x=1783112364;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRDRIiz3XImXDUjVYOiE9hOsEzWLdCtLXqeSkv/nysU=;
        b=CRvsugATUO7BpGR0qdea3ZJHfWJIds2LaUMaWPwDwGcV/GgRhxwEZFHLpw/gACZK25
         WQSZ/ZnMexnQ2nLxDF/DxXme7YhLnO4Yjj/ehOs7DcLF+6FCn4jqSUv6/OO7qTDy2LDL
         /iQ2fSMwAOLmeSOTJOqI+eEr9lpYQ7yxaTNnVjtoHkCmGi+Mm0HxCdwZXlwmU0vYPFwf
         0pujyKl6xnrisjdUngkzfblooD0aISaIhE1UrXqouHvPjBGwrFj3Jx/QGo8BR7s2IOys
         mCaT0vVkHnI3liA6trCJj5m1CNmZ0sYxBY5KBC/SAOpFd0SlyGeq3OZkmIQl3hhLGbmA
         5i7A==
X-Gm-Message-State: AOJu0YwfgSd5kKBrXCYHMAiJJjTZ5zMNVLILpPxymjkEf59t7/rq9kc0
	futXL3FL+MQBB/cyzKNuFJ2p2ssCxSYkvTVUJiQTCoBq2OVbc3g6nHi4w6oCRLtf/MYRKPoCvlJ
	L4Hp8cL8gpZbt91Kv5gLgifj24QApiZMWJy0bIFY=
X-Gm-Gg: AfdE7cnfTf230chvG9+HfNFfZ/toO5Ni3tntG1E2trAiouBnO0/4EzoNuy0OTb2Ubx5
	14tjmebdIiJbqpNffE23FO/3OI5ExRhXUdnnLuPM69/IOInX50n5c3Gvfzkr/oFC2dXrytkBHJ6
	uTyEtXy8DMNE1K3AaNvVDlg8HZKeiONNVFtuPq6uvsi6UCxSw/exwmbt/v010rM+KlOoioyeJdB
	+gD/rY1Jri6yQTZ9TxsyWXZ94o5i5Gl1K920937VGQAb/TQ6dpc51PwL/y3zk3KwVI6pHF7leKI
	KU+ZMDdtAPUSZ67bWUAjQHc9hddSrA==
X-Received: by 2002:aa7:c893:0:b0:698:3b7b:e486 with SMTP id
 4fb4d7f45d1cf-6983b7becd6mr559082a12.18.1782507563661; Fri, 26 Jun 2026
 13:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260624144311.674-1-adityags2004@gmail.com> <330317.1782455986127525796@lists.yoctoproject.org>
In-Reply-To: <330317.1782455986127525796@lists.yoctoproject.org>
From: Colin <colinmca242@gmail.com>
Date: Fri, 26 Jun 2026 15:59:12 -0500
X-Gm-Features: AVVi8Ccku7GINwFaetKCdp1qy2Eg19V367HPJFxuuD1k_IdyCx5FQ9qw7EQ8eq8
Message-ID: <CAAyLwgROtTbdvQnc-PH5GKnBacPUPLrahu7O0Ezdf0b9=e+hKg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-collab][kirkstone][PATCH v2] openssl:
 upgrade 3.0.20 -> 3.0.21
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000243fb006552e62e7"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Jun 2026 20:59:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4309

--000000000000243fb006552e62e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aditya,

Thanks for the v2 patch, it has been applied.
https://github.com/garmin/meta-lts-collab/commit/5ce3646fa069497f2e9868f7df=
3df71e35f16df6

Best,
Colin


On Fri, Jun 26, 2026 at 1:39=E2=80=AFAM Aditya GS via lists.yoctoproject.or=
g <
aditya.gs=3Dbmwtechworks.in@lists.yoctoproject.org> wrote:

> Hi,
> Just following up on this patch: [meta-lts-collab][Kirkstone] openssl:
> upgrade 3.0.20 -> 3.0.21 Are there any updates or feedback on this? Pleas=
e
> let me know if any changes or improvements are needed. I will be happy to
> send a v3 if required. Thanks for your time and review.
> Regards,
> Aditya GS
> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#4306)
> <https://lists.yoctoproject.org/g/yocto-patches/message/4306> | Reply to
> Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-pa=
tches%5D%20%5Bmeta-lts-collab%5D%5Bkirkstone%5D%5BPATCH%20v2%5D%20openssl%3=
A%20upgrade%203.0.20%20-%3E%203.0.21>
> | Reply to Sender
> <aditya.gs@bmwtechworks.in?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-pa=
tches%5D%20%5Bmeta-lts-collab%5D%5Bkirkstone%5D%5BPATCH%20v2%5D%20openssl%3=
A%20upgrade%203.0.20%20-%3E%203.0.21>
> | Mute This Topic <https://lists.yoctoproject.org/mt/119958020/7885119> |=
 New
> Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/7885119> | Contac=
t
> Group Owner <yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe
> <https://lists.yoctoproject.org/g/yocto-patches/leave/15216872/7885119/15=
30421413/xyzzy>
> [colinmca242@gmail.com]
> _._,_._,_
>
>

--000000000000243fb006552e62e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi Aditya,</div><div><br></div><div>Thanks for t=
he v2 patch, it has been applied.</div><div><a href=3D"https://github.com/g=
armin/meta-lts-collab/commit/5ce3646fa069497f2e9868f7df3df71e35f16df6">http=
s://github.com/garmin/meta-lts-collab/commit/5ce3646fa069497f2e9868f7df3df7=
1e35f16df6</a><br></div><div><br></div><div>Best,</div><div>Colin</div></di=
v><br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Jun 26, 2026 at 1:39=E2=80=AFAM Adity=
a GS via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</=
a> &lt;<a href=3D"http://aditya.gs">aditya.gs</a>=3D<a href=3D"mailto:bmwte=
chworks.in@lists.yoctoproject.org">bmwtechworks.in@lists.yoctoproject.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv><span style=3D"font-size:inherit">Hi,</span><br><span style=3D"font-size=
:inherit">Just following up on this patch: [meta-lts-collab][Kirkstone] ope=
nssl: upgrade 3.0.20 -&gt; 3.0.21 Are there any updates or feedback on this=
? Please let me know if any changes or improvements are needed. I will be h=
appy to send a v3 if required. Thanks for your time and review.</span><br><=
span style=3D"font-size:inherit">Regards,</span><br><span style=3D"font-siz=
e:inherit">Aditya GS</span></div>


<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/4306" tar=
get=3D"_blank">View/Reply Online (#4306)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re=
%3A%20%5Byocto-patches%5D%20%5Bmeta-lts-collab%5D%5Bkirkstone%5D%5BPATCH%20=
v2%5D%20openssl%3A%20upgrade%203.0.20%20-%3E%203.0.21" target=3D"_blank">Re=
ply to Group</a>
 =20
    | <a href=3D"mailto:aditya.gs@bmwtechworks.in?subject=3DPrivate:%20Re:%=
20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-lts-collab%5D%5Bkirkstone%5D%5BPATC=
H%20v2%5D%20openssl%3A%20upgrade%203.0.20%20-%3E%203.0.21" target=3D"_blank=
">Reply to Sender</a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/119958020/7885119" target=3D=
"_blank">Mute This Topic</a>


| <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post" target=3D=
"_blank">New Topic</a>

<br>




<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/7885119" =
target=3D"_blank">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" target=3D"_bl=
ank">Contact Group Owner</a> |

<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/15216872/78=
85119/1530421413/xyzzy" target=3D"_blank">Unsubscribe</a>

 [<a href=3D"mailto:colinmca242@gmail.com" target=3D"_blank">colinmca242@gm=
ail.com</a>]<br>
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<p></p><p></p></blockquote></div>

--000000000000243fb006552e62e7--

