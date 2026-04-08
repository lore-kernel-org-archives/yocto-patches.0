Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C32AFD5F91
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 07:25:42 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.101083.1775633137541080139
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 Apr 2026 00:25:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=sRDu6jLn;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 45C314E42974
	for <yocto-patches@lists.yoctoproject.org>; Wed,  8 Apr 2026 07:25:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 182B6603CB;
	Wed,  8 Apr 2026 07:25:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E69B104503D0;
	Wed,  8 Apr 2026 09:25:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775633134; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=q1hdjU9xywO67xNWy+yzg3e1drJbM6VDYLLoNUG6KWg=;
	b=sRDu6jLnzUsxvhg3b0nV2FaSd0kujD7auH5g+XE0oSqwKdBr3i0kPY99foZ07yryi6MkxA
	7C/8hjmPBnJZFNI58Hf08wo+Xqmeh/n/DL+mMRTiFbJlgkc6N1Uz6AFo+sw2iWJ/WbvpzX
	6WH2dLtrVETp6LzouEwJuNG2vM9xv52Mq781PHrg4Ih5EJkx4p8oAqERqIdcGCUD+fZ+fV
	iW60sl50hBXBWewq4d2lGDzb26cQoQiX36/WNot2YofKOncQxQEwG3wEvgjdiJG/1JuCuu
	WOwh4/l109tx1+wXAkSbeEjm24QgXnZaKIgu+V3zvMCEJA4az8RZUteHUuxuDg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 09:25:32 +0200
Message-Id: <DHNLEVZSJENP.8TRZXPDC4RO3@bootlin.com>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Yoann Congal"
 <yoann.congal@smile.fr>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 scripts/yocto-supported-distros: fix an incorrect regular expression for
 stream
References: <20260326-ysd-fix-centos-regexp-v1-1-e41c6cbe1a18@bootlin.com>
 <054abea2ac9beedac71d4142a14f0bdf8fccec21.camel@pbarker.dev>
In-Reply-To: <054abea2ac9beedac71d4142a14f0bdf8fccec21.camel@pbarker.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 Apr 2026 07:25:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3660

Hi,

On Mon Apr 6, 2026 at 10:49 AM CEST, Paul Barker wrote:
> On Thu, 2026-03-26 at 17:22 +0100, Antonin Godard via
> lists.yoctoproject.org wrote:
>> The lsb string for CentOS Stream is actually centosstream-*, not
>> centos-*. It was thus not detecting centosstream entries in
>> SANITY_TESTED_DISTROS.
>>=20
>> This was preventing the script from outputting the docs-formatted CentOS
>> strings.
>>=20
>> Reported-by: Yoann Congal <yoann.congal@smile.fr>
>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>> ---
>>  scripts/yocto-supported-distros | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-d=
istros
>> index 11b05b7..f1dac04 100755
>> --- a/scripts/yocto-supported-distros
>> +++ b/scripts/yocto-supported-distros
>> @@ -83,7 +83,7 @@ INPUT_REGEXES =3D {
>>      },
>>      "centosstream": {
>>          "ab": re.compile(r"^stream(\d+)"),
>> -        "lsb": re.compile(r"^stream-(\d+)"),
>> +        "lsb": re.compile(r"^centosstream-(\d+)"),
>
> Hi Antonin,
>
> Where do you see centosstream-* reported?
>
> On the stream9-vk-1 autobuilder worker and on a local centos stream 9
> instance I see "centos-9":
>
>     $ ( source /etc/os-release && echo $ID-$VERSION_ID )
>     centos-9
>
> We currently have "centosstream-9" listed as a supported distro, but if
> I build on stream9-vk-1 I see:
>
>     WARNING: Host distribution "centos-9" has not been validated with
>     this version of the build system; you may possibly experience
>     unexpected failures. It is recommended that you use a tested
>     distribution.
>
> So, I sent a patch for meta-yocto [1]. We should try to resolve which
> one is correct.
>
> [1]: https://lore.kernel.org/poky/20260403-centos-9-v1-1-e5324bd74ea3@pba=
rker.dev/T/

I'm a bit confused, why was this not a problem on whinlatter and scarthgap =
then?
Both of them have either centosstream-8 or centosstream-9 as their lsb stri=
ng in
poky.conf.

https://git.yoctoproject.org/meta-yocto/tree/meta-poky/conf/distro/poky.con=
f?h=3Dwhinlatter
https://git.yoctoproject.org/meta-yocto/tree/meta-poky/conf/distro/poky.con=
f?h=3Dscarthgap

Even CentOS Stream 8 images report centos-8 (with a local docker image):

$ docker run --rm -it quay.io/centos/centos:stream8 bash
[root@c33732bb804a /]# cat /etc/os-release
NAME=3D"CentOS Stream"
VERSION=3D"8"
ID=3D"centos"
ID_LIKE=3D"rhel fedora"
VERSION_ID=3D"8"

Should we backport your change to both of these branches?

Antonin

