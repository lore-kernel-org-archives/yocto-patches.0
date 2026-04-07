Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945E2F3D5E1
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 10:59:05 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78648.1775559535458661299
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Apr 2026 03:58:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=UP8j5sUo;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 192A7C5B188
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Apr 2026 10:59:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3B3C0603C7;
	Tue,  7 Apr 2026 10:58:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24DAB104501E1;
	Tue,  7 Apr 2026 12:58:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775559532; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7x8/sawb/C7Em8IODFB4/AjXUsxeGzhSZxSRfV5c2ao=;
	b=UP8j5sUozsw1IRT+D/3IoM3gwRQiUGA766H7qN15tnvHRAhxvZlWnuGQTx1Nd1r4UJhfYc
	d/AX/Ihs+l2pcODWbkEqE3X/LsF6hWMdEuf96v5z5Zaf+QhNVaG1QEfaSUfQIrVcYuON9T
	wFkcSVDyJ3gvr9qa9m6hD5I3FnHPjBkQIyhkYedjCdlKjYSYomOGZ50FU5BaOu3aiFfsC8
	vU4xMnTJLxELyaNQtOs9EiS1a/SA6kZPjPCpCYPX/ZxOSH8B5DAfwzrjno6TELawfFEOwr
	qSklpxmyfOysTloPIBR4TpBVHuMbprwID8rTjpMs39Uol8WukVCGsMoMKHiLZA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Apr 2026 12:58:50 +0200
Message-Id: <DHMVBNW8H8K0.CQXRP80OH374@bootlin.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 scripts/yocto-supported-distros: fix an incorrect regular expression for
 stream
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Yoann Congal"
 <yoann.congal@smile.fr>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
References: <20260326-ysd-fix-centos-regexp-v1-1-e41c6cbe1a18@bootlin.com>
 <054abea2ac9beedac71d4142a14f0bdf8fccec21.camel@pbarker.dev>
In-Reply-To: <054abea2ac9beedac71d4142a14f0bdf8fccec21.camel@pbarker.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 10:59:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3652

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

In meta-yocto :)

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

Your fix to meta-yocto is the correct one. I didn't realize the issue was i=
n
meta-yocto at first, and yocto-supported-distros uses meta-yocto as input.

This means that this commit can be reverted from yocto-autobuilder-helper. =
I'll
send a patch when yours is applied to meta-yocto.

Antonin

