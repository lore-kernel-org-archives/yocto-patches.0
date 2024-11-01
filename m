Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C72E6F072
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 17:26:24 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.758.1730481982358739337
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 01 Nov 2024 10:26:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=j8Tor8AR;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so16665471fa.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 01 Nov 2024 10:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730481980; x=1731086780; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xikpefLgpSMUSQ1PxCIXu+cc/+zyQwBzkrFZbUMum3c=;
        b=j8Tor8AR6x7sPGL1RALdVrlXKJpLdMh7RXSJ5VrEa1OUDip9Hlw3Bpqtkeb4w65NYM
         Qg8gzDoUr5IlGCLpp3jeXWAsIcG3RlO6wtV2M6GlMJY83Fctmr3ZryWNUxOc/ZbxBWGE
         v0XXR60clJS7VKECfbqkLkm4c2bnuLiz+3xE53PNx+BVuY4BUvoIstnkvtXMrk/8IqhL
         xrN+RtVImnm82dl/woh6VUc9JbRDCrZhkRJfnlqezW8mROAaP7tYW6pXYFTIJQGeHPY4
         DqsxjY6d/JRZXL+IquVvD1lKA9ge9mComNugVKxxjuGlPe2Xos6W1UZcnbLpmenJdI6W
         lV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730481980; x=1731086780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xikpefLgpSMUSQ1PxCIXu+cc/+zyQwBzkrFZbUMum3c=;
        b=QuuRbfUhxPNHuyPF/j2r2IJVg1+KjPsiVH7qLwK47EFOVZ5TVHXVcUPNjgsGxa804C
         msQCqH2EDsygUaQT7T6staq1uTZWbFwwrOWSqdy0//nxIO0eCP8fsfp35RQN9hD+cg94
         iY/T+b3wN6dqUqgc+QXHyZZjM3n0PUjCZELNSEIoUhHCQ5WBnfEcRmPUNojWuOzZ8/Xl
         8x0W73uOJvMhEMgeArC3n9cqNMaHVSv76Xu+DdZFe1Q3ios3xnN7eSh+68SrdFQXAtcL
         6Wo1H3EmcpwQRIpbViaCAmc7CVfeeUEZe5S835fiZftfLwmKOrAt/WjjrqxnCxT1SDgl
         X6lw==
X-Gm-Message-State: AOJu0YzIh0g0Dfkv6HFpyBp9ZPxXyRlonmyPJjuFWVGqyswtTRt4oRcb
	9EQH4llrioMLO+uTjxrIo60W/JjkQqbjUYz5f5iv/oAW0LTYrXq/BFZstbn+8xNhb1eyJEcZLnP
	98+wyJxLkGth0b5wGENSA4mUrjdNx9Q==
X-Google-Smtp-Source: AGHT+IHzpLh8yvGr3NGk9iuHNE/ASlyQbpAlD07UzaiWI/v2DjS7KoALAq1KA8Ga4OLYLdodB6WJ4e1FufS+N+6S8FU=
X-Received: by 2002:a2e:be0f:0:b0:2fb:3d86:d915 with SMTP id
 38308e7fff4ca-2fdec4bb930mr42420961fa.11.1730481979995; Fri, 01 Nov 2024
 10:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <e3efc225-d2a0-4561-8554-6b3e3dd20ba9@collabora.com>
In-Reply-To: <e3efc225-d2a0-4561-8554-6b3e3dd20ba9@collabora.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 1 Nov 2024 18:26:08 +0100
Message-ID: <CANNYZj_KwkEmFcpiksXEP7t5fj59jjrXf5Bswf699+XsNufJ7A@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/clang][RFC]
 kirkstone/clang branch proposal
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, peter.marko@siemens.com, raj.khem@gmail.com, 
	max@igalia.com
Content-Type: multipart/alternative; boundary="000000000000b53e600625dd3b43"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 01 Nov 2024 17:26:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/784

--000000000000b53e600625dd3b43
Content-Type: text/plain; charset="UTF-8"

Yes, absolutely!

Alex

On Fri 1. Nov 2024 at 17.27, Ariel D'Alessandro via lists.yoctoproject.org
<ariel.dalessandro=collabora.com@lists.yoctoproject.org> wrote:

> Hi all meta-lts-mixins people,
>
> We're currently working on getting `meta-browser` chromium support bump
> to version `129.` on kirkstone [0], which requires `clang 16`.
>
> Scarthgap `meta-clang` layer provides clang `18.1.6`, but kirkstone LTS
> branches do not accept major version updates [1].
>
> Could this be submitted instead to
> https://git.yoctoproject.org/meta-lts-mixins/ as a new branch
> `kirkstone/clang`?
>
> Thanks in advance!
> Ariel
>
> [0] https://github.com/OSSystems/meta-browser/pull/843
> [1] https://github.com/kraj/meta-clang/pull/1024#issuecomment-2451851507
>
> --
> Ariel D'Alessandro
> Software Engineer
>
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#783):
> https://lists.yoctoproject.org/g/yocto-patches/message/783
> Mute This Topic: https://lists.yoctoproject.org/mt/109337193/1686489
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13197349/1686489/315264618/xyzzy
> [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
>

--000000000000b53e600625dd3b43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes, absolutely!</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Alex</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Fri 1. Nov 2024 at 17.27, Ariel D&#39;Alessandro via=
 <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;a=
riel.dalessandro=3D<a href=3D"mailto:collabora.com@lists.yoctoproject.org">=
collabora.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204=
)">Hi all meta-lts-mixins people,<br>
<br>
We&#39;re currently working on getting `meta-browser` chromium support bump=
 <br>
to version `129.` on kirkstone [0], which requires `clang 16`.<br>
<br>
Scarthgap `meta-clang` layer provides clang `18.1.6`, but kirkstone LTS <br=
>
branches do not accept major version updates [1].<br>
<br>
Could this be submitted instead to <br>
<a href=3D"https://git.yoctoproject.org/meta-lts-mixins/" rel=3D"noreferrer=
" target=3D"_blank">https://git.yoctoproject.org/meta-lts-mixins/</a> as a =
new branch <br>
`kirkstone/clang`?<br>
<br>
Thanks in advance!<br>
Ariel<br>
<br>
[0] <a href=3D"https://github.com/OSSystems/meta-browser/pull/843" rel=3D"n=
oreferrer" target=3D"_blank">https://github.com/OSSystems/meta-browser/pull=
/843</a><br>
[1] <a href=3D"https://github.com/kraj/meta-clang/pull/1024#issuecomment-24=
51851507" rel=3D"noreferrer" target=3D"_blank">https://github.com/kraj/meta=
-clang/pull/1024#issuecomment-2451851507</a><br>
<br>
-- <br>
Ariel D&#39;Alessandro<br>
Software Engineer<br>
<br>
Collabora Ltd.<br>
Platinum Building, St John&#39;s Innovation Park, Cambridge CB4 0DS, UK <br=
>
Registered in England &amp; Wales, no. 5513718<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#783): <a href=3D"https://lists.yoctoproject.org/g/yocto=
-patches/message/783" rel=3D"noreferrer" target=3D"_blank">https://lists.yo=
ctoproject.org/g/yocto-patches/message/783</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/109337193/168=
6489" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/109337193/1686489</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13197349/1686489/315264618/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13197349/1686489/3152646=
18/xyzzy</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank">a=
lex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div></div>

--000000000000b53e600625dd3b43--

