Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA53F3095B
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 13:15:03 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43816.1772716499717994186
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Mar 2026 05:15:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=yKJyYknO;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AED671A2CDE
	for <yocto-patches@lists.yoctoproject.org>; Thu,  5 Mar 2026 13:14:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8459B5FDEB;
	Thu,  5 Mar 2026 13:14:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EEBE10369870;
	Thu,  5 Mar 2026 14:14:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772716496; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hvzqH0lV5I70sEpAdT4tRmhfen1AFOk6HnQxbi3XI4Y=;
	b=yKJyYknOiHcPs0hPxIRY95tAhy2cBqz7a5QLG7tHOAavpP5nJEWfjeTfWml8bogLTx/2i9
	5308Pap0twQzUoI4UhnR+SsIv1Jez6JJn2OQ3xs0s8FZQOWfvoweNFxYH5Byw/cacH0E6U
	oxOpYcmL8GZFBU5F1BX3iBMrbcmd8v9oUb6C0gE/tk45MQTMbcDpptFkF96fyWqD400oau
	ymcqyWuhVIQ8KBQXguODXVQNNCXW8X67ZWgiWN4fnJ4um48t1NTnYMbKEGjZ4RwFw23WMD
	upSZwa+eFLEoIs82yD3xFjjr5990sOwiQsgxp6wCO7D/Jr1AuH+hAaygPTvzdA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 14:14:55 +0100
Message-Id: <DGUVJVAWRRZ0.2ZCMJ65GN3RKK@bootlin.com>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Trevor Woerner"
 <twoerner@gmail.com>, "Mathieu Dubois-Briand"
 <mathieu.dubois-briand@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder-helper] config: Fix
 wic builder after wic removal
References: <20260305-contrib-mathieu-wic-builder-v1-1-5886c06cd38a@bootlin.com>
In-Reply-To: <20260305-contrib-mathieu-wic-builder-v1-1-5886c06cd38a@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Mar 2026 13:15:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3336

Hi,

On Thu Mar 5, 2026 at 12:54 PM CET, Mathieu Dubois-Briand via lists.yoctopr=
oject.org wrote:
> Wic tool is now stored in an external git, so we can no longer rely on
> it being provided by openembedded-core scripts directory. Use the
> version provided by the wic recipe instead.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  config.json | 44 ++++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/config.json b/config.json
> index c7c92c3a2b0e..ad80c69c6600 100644
> --- a/config.json
> +++ b/config.json
> @@ -1014,41 +1014,53 @@
>              "step1" : {
>                  "MACHINE" : "qemux86",
>                  "shortname" : "qemux86 wic",
> -                "BBTARGETS" : "wic-tools core-image-sato",
> +                "BBTARGETS" : "core-image-sato:do_rootfs_wicenv core-ima=
ge-sato wic-native:do_addto_recipe_sysroot wic-tools",
> +                "extravars" : [
> +                     "DEPENDS:pn-core-image-sato +=3D 'parted-native cro=
ss-localedef-native'"

Is it safe to mix an override (pn-core-image-sato) and +=3D? I'm used to us=
ing
:append:pn-core-image-sato in these situations.

Antonin

