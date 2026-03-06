Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA6FF0182E
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 11:50:57 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.67634.1772797849599481263
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 03:50:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Bum6KuSr;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E858F1A2D2D
	for <yocto-patches@lists.yoctoproject.org>; Fri,  6 Mar 2026 11:50:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0D685FF92;
	Fri,  6 Mar 2026 11:50:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2290D10369967;
	Fri,  6 Mar 2026 12:50:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772797847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PIdPTqlK6OY20Ah9/6Zu8quCQ5Z7o16hwzS03hvcOv0=;
	b=Bum6KuSrQi8X6V/lxk5ivAAXMu3U8wQWawRb8jwwTMX/+R8zFw+WEMW2dDHlTmt/gBSkAq
	4NEk5Okp2HNMiFSYU10+jYgRMRWBtndeoW4RFY7xQDQBU74+/YQ4nI+FUH1Mm9OPfN/ICh
	pKjgj06pisOaVKe882zeMvJUlUZL814FLWZ7nj3Rn5D+MrpBPKN7XY5ywBk9p9ww+4cw/k
	Y0hE0GhRW6h3tEA4OeJMVDHMdDH0/JAtO202u8CzscJDtAuN8mPWfxDMLueX0m0rIFUDde
	DeSsbWDHpq9sb9QbhwUkLQ6Sr7H35iRaDpr+y1LDd1JtsuKzonenZAhcFNjR3Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 12:50:45 +0100
Message-Id: <DGVODZBDO0B8.5Z833N1Q8UU3@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Antonin Godard" <antonin.godard@bootlin.com>,
 <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder-helper] config: Fix
 wic builder after wic removal
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Trevor Woerner"
 <twoerner@gmail.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20260305-contrib-mathieu-wic-builder-v1-1-5886c06cd38a@bootlin.com> <DGUVJVAWRRZ0.2ZCMJ65GN3RKK@bootlin.com>
In-Reply-To: <DGUVJVAWRRZ0.2ZCMJ65GN3RKK@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 11:50:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3345

On Thu Mar 5, 2026 at 2:14 PM CET, Antonin Godard wrote:
> Hi,
>
> On Thu Mar 5, 2026 at 12:54 PM CET, Mathieu Dubois-Briand via lists.yocto=
project.org wrote:
>> Wic tool is now stored in an external git, so we can no longer rely on
>> it being provided by openembedded-core scripts directory. Use the
>> version provided by the wic recipe instead.
>>
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> ---
>>  config.json | 44 ++++++++++++++++++++++++++++----------------
>>  1 file changed, 28 insertions(+), 16 deletions(-)
>>
>> diff --git a/config.json b/config.json
>> index c7c92c3a2b0e..ad80c69c6600 100644
>> --- a/config.json
>> +++ b/config.json
>> @@ -1014,41 +1014,53 @@
>>              "step1" : {
>>                  "MACHINE" : "qemux86",
>>                  "shortname" : "qemux86 wic",
>> -                "BBTARGETS" : "wic-tools core-image-sato",
>> +                "BBTARGETS" : "core-image-sato:do_rootfs_wicenv core-im=
age-sato wic-native:do_addto_recipe_sysroot wic-tools",
>> +                "extravars" : [
>> +                     "DEPENDS:pn-core-image-sato +=3D 'parted-native cr=
oss-localedef-native'"
>
> Is it safe to mix an override (pn-core-image-sato) and +=3D? I'm used to =
using
> :append:pn-core-image-sato in these situations.
>
> Antonin

You're right, I should probably use append here. I will send a v2.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


