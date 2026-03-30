Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5629F1061B2A
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 23:29:58 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8778.1774913396642217886
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 30 Mar 2026 16:29:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Bf5FOYz9;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a2a75393e2so3654793e87.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 16:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774913394; cv=none;
        d=google.com; s=arc-20240605;
        b=azxYnRH9zDl8eNXOLulJtWGxjJKAVf7fj3z5mEghkb2zN4bDkYQhXN3dh1HU0c0oY3
         mUixO94LZTXWqhPrzdoyBKvQ+jmZHJTOJJH+lWV9FAheCHN2c2KlBYKD+NTlCrU6NCvf
         BJcw2bKSz+yw2iz2/VH97D8gCSDDeWhvhvFpVEZJ9MbnLaP0Cvg89vlEUU6UOpj6mESV
         zFM1YsZ9ZDtrDKQNwkrt/0zigVShFHO0iokj69B+ttx1jA4ocIpvaZDfxOnjywJjoBdA
         7rmiL9cs0sz8et/MR5AaDNgm3xjdbIlj1rWgjwpwa+YNtzf692vVHTpwbOaerATYK7tl
         2SlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/2iTKWGYiDu6S5uHtzYpaZKf1U4Fte1xpEzmig8uWbE=;
        fh=jrEbHcM9NVatGxI25/yVqhLCFNkcjzfu6ylXCc39wAY=;
        b=k/aVdf6VmQ3wKDevwz4vymEvUzjwIhmwqpKjOaLDRs8e2icS40tYhSQ1hOo1FZihyL
         zcO7KyLt/EnUrliRX7/nh/onrmlTjM8DW1MtmSVegKSa4YAIfOF1bCubdDztY6GGnU7x
         Z/6HbYIp1f5dqy4lQ6w9SkjTClNkHBQvK1/iH0MfUnumU+71OXn/NUPrIWHOt30uOPpx
         iCg5cd8RuZhh5GAPRaRO5rrrB9hKzjyRwNJE1olkJ1sOK6DF7u10yRcF0Jj4qn2qZjfU
         DaFgcgU3bkHOu1sEn/75GAJtlLacjdb01boYhPZldwlM8/XktF6vRCpE0iorhfmQd/bA
         fCXA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774913394; x=1775518194; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/2iTKWGYiDu6S5uHtzYpaZKf1U4Fte1xpEzmig8uWbE=;
        b=Bf5FOYz9dzPh7X3wsi4xtZ9B42ybKIslc575J9mV8aRO4hF8PuyZKy1HNMaMXjFyZ0
         AyBuBFgBUkMcw7sK1i/hOOYBOMT2vt1i5538wne9uS1Gn0sCYoD31ASFbHfzkkpFVocJ
         e45cXnFbnVi4tTm+YELqq8AxXMf59TBxI1AqTMSM2Ta2g53ep/cLCuXAiulFnUj8cWWL
         pHTJ8uIV3XubpPxLNNEhyLF8dheNNcfw87jX2f00gY2pcAjhwTB5QlTJQ6xlgc8GDbgn
         t6ow8b2o9VTGKXX2OJt6t8246edFOJdJnnQGCeS72fdqKgacES8Qmt3E2KEfywkOMrDD
         Awcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774913394; x=1775518194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2iTKWGYiDu6S5uHtzYpaZKf1U4Fte1xpEzmig8uWbE=;
        b=ARQIqPtOFUYeNBA0wu7hPgAhAVsOvMN2gysbGgynGaVZD5/9gPTpaJH+kmEouMcvE8
         wV8pVyaIBoprkWdCe+3leAkWrbb8Zc8sjmuJU209xhI5QQUk1h2S81gi20nsLdBb8MYc
         uBqMRMyU90QK3GvxCW4L2GHAKbbS9jV7bIr0Ee2FMOdl2KvW/2OcSoAjLAxwLwh1Aihk
         eQW7fgidbs5M4ohw3fBghv0vaJDUm80htysmmhLDWf+HXWrRf3LftR6W77NJWdU9R2dm
         DZJrqS46cI8De00llpGrdTSQd6u8yABFSGj5EM6cfxSlYDrT9Vr/r5cb2e0GVFgUPVrM
         fc0g==
X-Gm-Message-State: AOJu0YyvN1nEkBkMDCOdnCTfbNnugmBfWEbbe2Clfkgh6LzRDqjTulYD
	EFtQiE4JPY5nuKtz00NcG+H2DUT43lxXLf3mNX+9rMxdg6Vd5z/zpWXvWvobjvxGMFic0YEvVhN
	vj1ZsMJzzLr/pIgaXlcBkz9SHQvytC3/+qw==
X-Gm-Gg: ATEYQzx5FgRrmr+V//xP9SFWexxZR8mwTpr4ulbbwgdkEO22+Nyc35lXtuBGcSRemsO
	Ub+zse3tA5jtd5ZDdqzYEaPpTiG0yByPtC6rr9G/PRzwc9dQqUSu34U20aGQ22y7qtLexF1n1c8
	SQaamji0jep0UdzXEV7pNUrEQAbpXI2gpkRTGduKJEuiyuMbdSeMiWAZ19SzhbQsJgvwdYzy+H2
	UA8TupzijSt0ghCCh4XVVxwNMNMsErQPCzZfvQRSwyTIu7r38jAZw5hQtC1cYegSfuOfjC/u1BJ
	iwEad3k=
X-Received: by 2002:a05:6512:3d94:b0:5a2:a546:19a2 with SMTP id
 2adb3069b0e04-5a2ab7f212cmr5235874e87.13.1774913393955; Mon, 30 Mar 2026
 16:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260329171109.34764-1-piotr@qbee.io> <20260329171109.34764-3-piotr@qbee.io>
 <18A1837E203356E1.315286@lists.yoctoproject.org>
In-Reply-To: <18A1837E203356E1.315286@lists.yoctoproject.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Mon, 30 Mar 2026 16:29:40 -0700
X-Gm-Features: AQROBzBQULxyFTTOLWA1v2jsMVbyqplRrmTfBFmRnlx5EyFexHQA-Em6nI1rEQo
Message-ID: <CANx9H-CwJVKryPJxUL5gfKvb+6Am7sKeH-udeph-NkaOQvCySA@mail.gmail.com>
Subject: Re: [yocto-patches] [layerindex-web][PATCH 3/3] Update Django from
 4.2 LTS to 5.2 LTS
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?Q?Piotr_Buli=C5=84ski?= <piotr@qbee.io>
Content-Type: multipart/alternative; boundary="0000000000005a967e064e463a60"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 23:29:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3587

--0000000000005a967e064e463a60
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As of today, your patches are live on layers.openembedded.org

On Sun, Mar 29, 2026 at 9:18=E2=80=AFPM Tim Orling via lists.yoctoproject.o=
rg
<ticotimo=3Dgmail.com@lists.yoctoproject.org> wrote:

> Merged to master. Thank you.
>
> On Sun, Mar 29, 2026 at 10:11=E2=80=AFAM Piotr Buli=C5=84ski via lists.yo=
ctoproject.org
> <piotr=3Dqbee.io@lists.yoctoproject.org> wrote:
>
>> This change also updates other dependencies, to ensure compatibility wit=
h
>> the new version of Django.
>>
>> Signed-off-by: Piotr Buli=C5=84ski <piotr@qbee.io>
>> ---
>>  requirements.txt | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/requirements.txt b/requirements.txt
>> index 767d4bc..0aea1f6 100644
>> --- a/requirements.txt
>> +++ b/requirements.txt
>> @@ -10,17 +10,17 @@ click-plugins=3D=3D1.1.1
>>  click-repl=3D=3D0.3.0
>>  confusable-homoglyphs=3D=3D3.3.1
>>  diff-match-patch=3D=3D20230430
>> -Django>=3D4.2.28,<4.3
>> +Django>=3D5.2,<5.3
>>  django-appconf=3D=3D1.0.6
>> -django-axes=3D=3D6.5.1
>> +django-axes=3D=3D7.1.0
>>  django-cors-headers=3D=3D4.4.0
>>  django-ipware=3D=3D7.0.1
>>  django-ranged-response=3D=3D0.2.0
>> -django-registration=3D=3D3.4
>> +django-registration=3D=3D5.2.1
>>  django-reversion=3D=3D5.1.0
>>  django-reversion-compare=3D=3D0.17.0
>>  django-simple-captcha=3D=3D0.6.3
>> -djangorestframework=3D=3D3.15.2
>> +djangorestframework=3D=3D3.16.1
>>  gitdb=3D=3D4.0.11
>>  GitPython=3D=3D3.1.43
>>  kombu=3D=3D5.4.0
>>
>>
>>
>>
>>
>> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#3580)
> <https://lists.yoctoproject.org/g/yocto-patches/message/3580> | Reply to
> Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-pa=
tches%5D%20%5Blayerindex-web%5D%5BPATCH%203%2F3%5D%20Update%20Django%20from=
%204.2%20LTS%20to%205.2%20LTS>
> | Reply to Sender
> <ticotimo@gmail.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-patches%5=
D%20%5Blayerindex-web%5D%5BPATCH%203%2F3%5D%20Update%20Django%20from%204.2%=
20LTS%20to%205.2%20LTS>
> | Mute This Topic <https://lists.yoctoproject.org/mt/118566582/924729> | =
New
> Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/924729> | Contact
> Group Owner <yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/102=
3951714/xyzzy>
> [ticotimo@gmail.com]
> _._,_._,_
>
>

--0000000000005a967e064e463a60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">As of today, your patches are live on <a href=3D"http://la=
yers.openembedded.org">layers.openembedded.org</a></div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On =
Sun, Mar 29, 2026 at 9:18=E2=80=AFPM Tim Orling via <a href=3D"http://lists=
.yoctoproject.org">lists.yoctoproject.org</a> &lt;ticotimo=3D<a href=3D"mai=
lto:gmail.com@lists.yoctoproject.org">gmail.com@lists.yoctoproject.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr">Merged to master. Thank you.</div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 29, 2026 at 10:11=E2=80=
=AFAM Piotr Buli=C5=84ski via <a href=3D"http://lists.yoctoproject.org" tar=
get=3D"_blank">lists.yoctoproject.org</a> &lt;piotr=3D<a href=3D"mailto:qbe=
e.io@lists.yoctoproject.org" target=3D"_blank">qbee.io@lists.yoctoproject.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">This change also updates other dependencies, to ensure compatibility with=
 the new version of Django.<br>
<br>
Signed-off-by: Piotr Buli=C5=84ski &lt;<a href=3D"mailto:piotr@qbee.io" tar=
get=3D"_blank">piotr@qbee.io</a>&gt;<br>
---<br>
=C2=A0requirements.txt | 8 ++++----<br>
=C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/requirements.txt b/requirements.txt<br>
index 767d4bc..0aea1f6 100644<br>
--- a/requirements.txt<br>
+++ b/requirements.txt<br>
@@ -10,17 +10,17 @@ click-plugins=3D=3D1.1.1<br>
=C2=A0click-repl=3D=3D0.3.0<br>
=C2=A0confusable-homoglyphs=3D=3D3.3.1<br>
=C2=A0diff-match-patch=3D=3D20230430<br>
-Django&gt;=3D4.2.28,&lt;4.3<br>
+Django&gt;=3D5.2,&lt;5.3<br>
=C2=A0django-appconf=3D=3D1.0.6<br>
-django-axes=3D=3D6.5.1<br>
+django-axes=3D=3D7.1.0<br>
=C2=A0django-cors-headers=3D=3D4.4.0<br>
=C2=A0django-ipware=3D=3D7.0.1<br>
=C2=A0django-ranged-response=3D=3D0.2.0<br>
-django-registration=3D=3D3.4<br>
+django-registration=3D=3D5.2.1<br>
=C2=A0django-reversion=3D=3D5.1.0<br>
=C2=A0django-reversion-compare=3D=3D0.17.0<br>
=C2=A0django-simple-captcha=3D=3D0.6.3<br>
-djangorestframework=3D=3D3.15.2<br>
+djangorestframework=3D=3D3.16.1<br>
=C2=A0gitdb=3D=3D4.0.11<br>
=C2=A0GitPython=3D=3D3.1.43<br>
=C2=A0kombu=3D=3D5.4.0<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></div>


<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/3580" tar=
get=3D"_blank">View/Reply Online (#3580)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re=
%3A%20%5Byocto-patches%5D%20%5Blayerindex-web%5D%5BPATCH%203%2F3%5D%20Updat=
e%20Django%20from%204.2%20LTS%20to%205.2%20LTS" target=3D"_blank">Reply to =
Group</a>
 =20
    | <a href=3D"mailto:ticotimo@gmail.com?subject=3DPrivate:%20Re:%20Re%3A=
%20%5Byocto-patches%5D%20%5Blayerindex-web%5D%5BPATCH%203%2F3%5D%20Update%2=
0Django%20from%204.2%20LTS%20to%205.2%20LTS" target=3D"_blank">Reply to Sen=
der</a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/118566582/924729" target=3D"=
_blank">Mute This Topic</a>


| <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post" target=3D=
"_blank">New Topic</a>

<br>




<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/924729" t=
arget=3D"_blank">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" target=3D"_bl=
ank">Contact Group Owner</a> |

<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/92=
4729/1023951714/xyzzy" target=3D"_blank">Unsubscribe</a>

 [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticotimo@gmail.co=
m</a>]<br>
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<p></p><p></p></blockquote></div>

--0000000000005a967e064e463a60--

